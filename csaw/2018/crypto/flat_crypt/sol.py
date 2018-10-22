#!/usr/bin/env python
import string
from pwn import *

context.log_level = "error"


def enter_text(r, msg):
    r.recvuntil(b"service\n")
    r.sendline(msg)


def main():
    CHARSET = string.ascii_lowercase + "_"
    host, port = "crypto.chal.csaw.io", 8040
    flag = ""

    for j in xrange(30):
        for i in CHARSET:
            r = remote(host, port)
            msg = (i + flag) * 20
            enter_text(r, msg)

            out = r.recvline()
            l = ord(out[-2])

            log.info("len = %r, i = %r" %(l, i))

            if l < 35:                  #<== You have to edit this manually
                print i
                flag = i + flag
                break
            r.close()

        log.info("flag: %s" % flag)


if __name__ == '__main__':
    main()
