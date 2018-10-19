#!/usr/bin/env python
import json
from hashlib import md5
from base64 import b64decode
from base64 import b64encode
from binascii import hexlify, unhexlify
#
from Crypto import Random
from Crypto.Cipher import AES


BLOCK_SIZE = 16  # Bytes
pad = lambda s: s + (BLOCK_SIZE - len(s) % BLOCK_SIZE) * \
                chr(BLOCK_SIZE - len(s) % BLOCK_SIZE)
unpad = lambda s: s[:-ord(s[len(s) - 1:])]


class AESCipher:
    """
    Usage:
        c = AESCipher('password').encrypt('message')
        m = AESCipher('password').decrypt(c)
    Tested under Python 3 and PyCrypto 2.6.1.
    """
    def __init__(self, key, iv=None):
        self.key = md5(key.encode('utf8')).hexdigest()
        self.iv = iv

    def encrypt(self, raw):
        raw = pad(raw)
        print('raw: %r' % raw)
        if not self.iv:
            self.iv = Random.new().read(AES.block_size)
        cipher = AES.new(self.key, AES.MODE_CBC, self.iv)
        return b64encode(self.iv + cipher.encrypt(raw))

    def decrypt(self, enc):
        enc = b64decode(enc)
        iv = enc[:16]
        cipher = AES.new(self.key, AES.MODE_CBC, iv)
        return unpad(cipher.decrypt(enc[16:])).decode('utf8')


def print_block(text):
    text_len = len(text)
    for x in xrange(0, text_len, BLOCK_SIZE):
        print('\tblock %d: %r' % (x >> 4, text[x:x+BLOCK_SIZE]))


def bitflip_CBC(raw, encrypted, bit_position):
    enc = b64decode(encrypted)
    iv  = enc[:BLOCK_SIZE]
    enc = enc[BLOCK_SIZE:]

    print("iv  : %r" % hexlify(iv))
    print('plain  : %r' % raw)
    print_block(raw)
    print("enc : %r" % hexlify(enc))
    print_block(enc)

    iv_modified     = bytearray(iv)
    iv_modified[bit_position] ^= 0x01
    intercepted_ciphertext = b64encode(bytes(iv_modified) + enc)
    print("intercepted_ciphertext: %r" % intercepted_ciphertext)


def main():
    cookie_data = {'password': '', 'admin': 0, 'username': 'aaaa'}
    cookie_data = json.dumps(cookie_data, sort_keys=True)

    encrypted_on_server = 'hqgCtiZz9zhwrBGSBNFMxBCuJVZxSS950LOucIXncYtEnhw7QxF6XqkC+c/+1GAOlwvO3on/HLkXy6A6BewAbwCy4RwPRyNtxnvwmAOjW50='
    bitflip_CBC(cookie_data, encrypted_on_server, 10)


if __name__ == '__main__':
    main()
