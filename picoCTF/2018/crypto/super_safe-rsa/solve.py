#!/usr/bin/env python
from __future__ import division, print_function
import binascii
#
import gmpy2


def main():
    c = 5981164849559424864180602499711307250396925537655169926534145029224067076510391
    n = 11120951712543328287096532430519545274740723885880016175943041012662989713960249
    e = 65537
    p, q = 97109741746980388830175125806544782071, 114519424235716623349795034881831978947919

    totient = (p - 1) * (q - 1)
    d = gmpy2.invert(e, totient)
    m = pow(c, d, n)
    plain = '%x' % m
    plain = plain if len(plain) % 2 == 0 else '0' + plain
    plain = binascii.unhexlify(plain)
    print(plain)


if __name__ == '__main__':
    main()

