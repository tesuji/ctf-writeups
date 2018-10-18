#!/usr/bin/env python

from __future__ import absolute_import
from __future__ import division
from builtins import int

from base64 import b64encode, b64decode

# In Debian, install `apt install python-crypto`
from Crypto import Random
from Crypto.Cipher import AES

from ._combability_layer import _math
from . import _fractions

__all__ = ['AESCipher', 'RSAAttack']

class RSAAttack:
    """Mostly stuffs for RSA"""

    @staticmethod
    def extended_gcd(a, b):
        """extended_gcd(a, b) -> (int, int, int)

        Returns (g, x, y) and such that a*x + b*y = g and g = gcd(a,b).
        """
        return _math.gcdext(a, b)

    @staticmethod
    def mod_inverse(a, m):
        """mod_inverse(a, m) -> int

        Returns x such that a*x = 1 (mod m).
        """
        x = _math.invert(a, m)
        if x == 0:
            raise ValueError('No x such that %d*x = 1 (mod %d)'%(a, m))
        return x

    @staticmethod
    def chinese_remainder(n, a):
        """chinese_remainder(n, a) -> int

        Returns x (int) such that
            x = a[i] (mod n[i]) for i := 1 -> k

        Reference: https://rosettacode.org/wiki/Chinese_remainder_theorem
        """

        prod = reduce(_math.mul, n) # reduce is faster than equivalent for loop
        total = 0
        for (n_i, a_i) in zip(n, a):
            p = prod // n_i
            total += a_i * RSAAttack.mod_inverse(p, n_i) * p
        return _math.f_mod(total, prod)

    @staticmethod
    def hastad_broadcast_attack(N, C):
        """hastad_broadcast_attack(N, C) -> int

        Retunrs plain text m in form long type such that e=len(N)=len(C) and
        e is small and we knew `e' pairs module n, ciphertext c

        In short, returns m if
            c[i] = (m**k) (mod n[i]) for i: 1->k
        With chinese remainder theorem:
            c'  = (m**k) (mod n[1]*n[2]*..*n[k]) for i: 1->k
        """
        e = len(N)
        assert(e == len(C))
        remainder = RSAAttack.chinese_remainder(N, C)
        for (n, c) in zip(N, C):
            assert(_math.f_mod(remainder, n) == c)
        m, exact = _math.iroot(remainder, e)
        assert(exact)
        return m

    @staticmethod
    def wiener_attack(e, n):
        """wiener_attack(e, n) -> int

        Given (e, n), returns d using the Wiener continued fraction attack
        -------------------------------
        RSA-keys are Wiener-vulnerable if d < (n^(1/4))/sqrt(6)

        The RSA keys are obtained as follows:
        1. Choose two prime numbers p and q
        2. Compute n=p*q
        3. Compute phi(n)=(p-1)*(q-1)
        4. Choose e such that 1 < e < phi(n); e and phi(n) are coprime
        5. Compute d = e^(-1) (mod phi(n))
        6. e is the public key;
           n is also made public (determines the block size);
           d is the private key

        Encryption is as follows:
        1. Size of data to be encrypted must be less than n
        2. ciphertext=pow(plaintext, e, n)

        Decryption is as follows:
        1. Size of data to be decrypted must be less than n
        2. plaintext=pow(ciphertext, d, n)
        """
        frac = _fractions.continued_fraction(e, n)
        convergents = _fractions.continued_fraction_convergents(frac)

        for (k, d) in convergents:
            #check if d is actually the key
            if (k != 0) and ((e*d - 1)%k == 0):
                phi = (e*d - 1)//k
                s   = n - phi + 1
                # check if the equation x^2 - s*x + n = 0
                # has integer roots
                discr = s*s - 4*n
                if discr >= 0:
                    t = _math.perfect_sqrt(discr)
                    if (t != -1) and ((s+t)%2 == 0):
                        return d
        return -1


class AESCipher:
    """
    Reference:
    + http://pythonhosted.org/pycrypto/
    """

    MODE_ECB = AES.MODE_ECB
    MODE_CBC = AES.MODE_CBC

    def __init__(self, key, mode=AES.MODE_ECB):
        # key (byte string) - The secret key to use in the symmetric cipher.
        #     It must be 16 (AES-128), 24 (AES-192), or 32 (AES-256) bytes long.
        # key must be hash by sha256, md5 before pass to this class
        # Why hash key? To len(key) in AES.key_size

        assert mode in (AES.MODE_ECB, AES.MODE_CBC)
        assert len(key) in AES.key_size
        self.key = key
        self.bs = AES.block_size
        self.mode = mode

    def __repr__(self):
        return "AESCipher(key=%r, mode=%r)" % (self.key, self.mode)

    def encrypt(self, raw):
        """Encrypt using AES in CBC or ECB mode."""

        raw = self.pad(raw)
        iv = (Random.new().read(self.bs) if (self.mode == AES.MODE_CBC)
              else '')
        aes = AES.new(key=self.key, mode=self.mode, IV=iv)
        return b64encode(iv + aes.encrypt(raw))

    def decrypt(self, enc):
        """Decrypt using AES in CBC mode. Expects the IV at the front of the string."""

        enc = b64decode(enc)
        if self.mode == AES.MODE_CBC:
            iv = enc[:self.bs]
            enc = enc[self.bs:]
        else:
            iv = ''
        aes = AES.new(key=self.key, mode=self.mode, IV=iv)
        dec = aes.decrypt(enc)
        return self.unpad(dec)

    def unpad(self, text):
        """PKCS7 unpad"""

        last_byte = ord(text[-1:])
        if last_byte > self.bs:
            return text
        if text[-last_byte:] != chr(last_byte) * last_byte:
            return text
        return text[:-last_byte]

    def pad(self, text):
        """PKCS7 pad"""

        pad_num = self.bs - len(text) % self.bs
        return text + chr(pad_num) * pad_num

