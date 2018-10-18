#!/usr/bin/env python
import ctypes
import struct
#

def p32(x):
    return struct.pack('<I', x)


def u32(x):
    return struct.unpack('<I', x)[0]


def gen_key(enc, plain):
    """
    NOTE:
        >>> [x ^ y for x, y in zip ( plain,enc_flag )]
        [234, 142, 29, 34, 235, 142, 29, 34]
    """
    u = [x ^ y for x, y in zip ( plain, enc )]
    b = bytearray(u[:4])
    key = u32(bytes(b))
    return key


def decrypt_flag():
    enc_flag = bytearray.fromhex('9ae77e4da8da5b5988f7734380e77e7d9efc2d459def704f99e07a7d97fa6a7d93be7f1291b97b1a89')
    plain = bytearray('picoCTF{')

    key = gen_key(enc_flag, plain)

    out = bytearray()
    for x in xrange(0x29):
        b = enc_flag[x] ^ ord(p32(key)[x & 3])
        out.append(b)
        if (x & 3) == 3:
            key += 1

    print(bytes(out))


def main():
    decrypt_flag()


if __name__ == '__main__':
    main()
