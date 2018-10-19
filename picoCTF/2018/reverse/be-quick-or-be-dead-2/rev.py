#!/usr/bin/env python
import ctypes
import struct
#
import gmpy2


def p32(m):
    return struct.pack('<I', m)


def decrypt_flag():
    enc_flag = bytearray.fromhex('28f269981acf4c8c2ef36fa83df2689832fa699434c479922fee6f993cfe559401f5559504c46e980cfe559102e87ea853fe3bcf5da339c31b00')
    key = ctypes.c_uint(gmpy2.fib(0x402)).value

    out = bytearray()
    for x in xrange(0x39):
        b = enc_flag[x] ^ ord(p32(key)[x & 3])
        out.append(b)
        if (x & 3) == 3:
            key += 1

    print(bytes(out))

def main():
    decrypt_flag()


if __name__ == '__main__':
    main()
