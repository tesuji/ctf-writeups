#!/usr/bin/env python

from pwn import *

class ExploitInfo:
    remote = '2018shell2.picoctf.com'
    remote_port = 31711


def bits_to_int(s):
    return int(s, 2)


def octal_to_int(s):
    return int(s, 8)


def get_problem_input(r):
    r.recvuntil('Please give me the ')
    rs = r.recvuntil(' as a word', drop=True).strip()
    log.info("Data stripped: %r", rs)
    return rs


def main():
    p = remote(ExploitInfo.remote, ExploitInfo.remote_port)

    # stage 1
    i = get_problem_input(p)
    u = map(bits_to_int, i.split())
    v = map(chr, u)
    p.clean()
    p.sendline(''.join(v))
    # stage 2
    i = get_problem_input(p)
    v = bytearray.fromhex(i)
    p.clean()
    p.sendline(bytes(v))
    # stage 3
    i = get_problem_input(p)
    u = map(octal_to_int, i.split())
    v = ''.join(map(chr, u))
    p.clean()
    p.sendline(v)
    #
    log.success(p.recvall())


if __name__ == "__main__":
    main()
