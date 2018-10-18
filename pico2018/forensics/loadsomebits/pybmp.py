#!/usr/bin/env python
import binascii
from builtins import range
#
from PIL import Image
from PIL import ImageFile
ImageFile.LOAD_TRUNCATED_IMAGES = True


BYTE_SIZE = 8

class BMPDecryptor():
    """docstring for BMPDecryptor"""
    def __init__(self, bmp_name):
        self.img = Image.open(bmp_name, 'r')
        self.width, self.height = self.img.size


    def __del__(self):
        self.img.close()


    def __enter__(self):
        return self


    def __exit__(self, exc_type, exc_value, traceback):
        self.img.close()


    def decrypt(self, to_bytes=False):
        """"""
        img = self.img
        width, height = self.width, self.height

        out = bytearray()
        for y in range(height):
            for x in range(width):
                pix = img.getpixel((x, y))
                r, g, b = pix
                r = r & 1
                g = g & 1
                b = b & 1
                out.extend((r, g, b))

        rs = bytearray()
        out_len = len(out)
        for i in range(0, out_len, BYTE_SIZE):
            c = 0
            for j in range(BYTE_SIZE):
                c <<= 1
                c |= out[i + j]

            rs.append(c)

        if to_bytes:
            return bytes(rs)
        else:
            return rs


def main():
    with BMPDecryptor('/stor/ctf/pico2018/forensics/loadsomebits/pico2018-special-logo.bmp') as decryptor:
        rs = decryptor.decrypt()
        print(rs)


if __name__ == '__main__':
    main()
