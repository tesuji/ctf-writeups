#!/usr/bin/env python
from builtins import range
#
from datetime import (
    datetime,
    time as dtime # conflict with pwn.time
)
#
from pwn import *

class ExploitInfo:
    remote      = r'2018shell2.picoctf.com'
    remote_port = 27108
    #
    time_format_str = r'%H:%M:%S'
    # range
    h0  = dtime(0)
    h10 = dtime(10)
    h16 = dtime(16)


def main():
    p = remote(ExploitInfo.remote, ExploitInfo.remote_port)
    p.recvuntil('num_IPs\n')
    d = p.recv(4096)
    e = d.split()
    e_len = len(e)
    for i in range(0, e_len, 4):
        log_ID, attime, num_IPs = e[i+1:i+4]
        num_IPs = int(num_IPs)
        t = datetime.strptime(attime, ExploitInfo.time_format_str).time()
        print(t)


    # p.clean()
    # p.sendline(ExploitInfo.shellcode_x86_32)

    # p.clean()
    # log.success("Get the shell")s
    # p.sendline('cd /problems/shellcode_4_99838609970da2f5f6cf39d6d9ed57cd')
    # p.sendline('ls')
    # p.interactive()


if __name__ == "__main__":
    main()
