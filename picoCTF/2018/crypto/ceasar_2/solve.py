#!/usr/bin/env python

def main():
    ciphertext = open('ciphertext', 'rb').read()
    ciphertext = bytearray(ciphertext)

    plain = bytearray(b'picoCTF{')

    array = [x -y for x, y in zip(plain, ciphertext)]

    assert(len(set(array)) == 1)

    array[0]
    u = [chr(x + array[0]) for x in ciphertext]
    v = ''.join(u)
    print(v)

if __name__ == '__main__':
    main()
