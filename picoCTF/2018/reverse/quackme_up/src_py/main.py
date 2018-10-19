#!/usr/bin/env python
from pybitrot import ror8, rol8


def decrypt(buf):
    out = bytearray()
    for x in buf:
        a = rol8(x, 8) ^ 0x16
        b = ror8(a, 4)
        out.append(b)
    return out


def main():
    buf = bytearray("\x11\x80\x20\xe0\x22\x53\x72\xa1\x01\x41\x55\x20\xa0\xc0\x25\xe3\x35\x40\x55\x30\x85\x55\x70\x20\xc1")
    rs = decrypt(buf)
    print(bytes(rs))


if __name__ == '__main__':
    main()
