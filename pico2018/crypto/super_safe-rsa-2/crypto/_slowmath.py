#!/usr/bin/env python
#
from __future__ import division
from builtins import range

import struct
import random
from fractions import gcd


try:
    # New in Python v2.7 and v3.1
    int.bit_length(1)
    def bit_length(x):
        return x.bit_length()
except AttributeError:
    def bit_length(x):
        """
        Calculates the bit length of x
        """
        assert x >= 0
        return len(bin(x)) - 2


def gcdext(a, b):
    """gcdext(a, b) -> (int, int, int)

    Returns (g, s, t) and such that
        a*s + b*t = g and g = gcd(a,b).
    """

    (s, old_s) = (0, 1)
    (t, old_t) = (1, 0)
    (r, old_r) = (b, a)

    while r != 0:
        (quotient, mod) = divmod(old_r, r)
        (old_r, r) = (r, mod)
        (old_s, s) = (s, old_s - quotient*s)
        (old_t, t) = (t, old_t - quotient*t)

    g, s, t = old_r, old_s, old_t
    return (g, s, t)


def iroot(x, n):
    """iroot(x, n) -> (int, bool)

    Returns a 2-element tuple (y, exact) such that y**n = x and
    exact is True.

    x must be >= 0 and n must be > 0.
    """
    lo, hi = -1, (x + 1)
    while (lo + 1) < hi:
        y = (lo + hi) // 2
        p = y**n
        if p < x:
            lo = y
        else:
            hi = y
    exact = ((hi**n) == x)
    y = hi if exact else lo
    return (y, exact)


def isqrt(n):
    """isqrt(n) -> int

    Returns the integer square root of n (int). n must be >= 0.
    """
    if n < 0:
        raise ValueError('Negative numbers: n = %d'%(n))
    elif n == 0:
        return 0
    a, b= divmod(bit_length(n), 2)
    x = 2**(a+b)
    y = (x + n//x)//2
    while True:
        y = (x + n//x)//2
        if y >= x:
            return x
        x = y
    return x


def perfect_sqrt(x):
    """perfect_sqrt(x) -> int

    Returns s if s*s = x else -1.
    """
    last_hexdigit = x & 0xf
    square_free_list = [2, 3, 5, 6, 7, 8, 10, 11, 12, 13, 14, 15]
    if (last_hexdigit in square_free_list):
        return - 1
    s = isqrt(x)
    return s if s*s == x else -1


def invert(a, m):
    """invert(a, m) -> int

    Returns x (int) such that a*x = 1 (mod m), or 0 if no such x exists.
    """
    (g, x, _) = gcdext(a, m)
    return (x % m) if g == 1 else 0


def check_fermat_little(a, n):
    """check_fermat_little(a, n) -> bool

    Check if n is a probabilistic prime number based on Fermat's little theorem.

    Fermat's little theorem: If n is a prime number, then for any integer a,
            a**(n-1) = 1 (mod n)
    """
    return (gcd(a, n) == 1 and pow(a, n - 1, n) == 1)


def fermat(n, count=100):
    """fermat(n, count=100) -> bool

    Use loop (in range `count`) to decrease error probability of algorithm.

    Returns:
        True if n is a probabilistic prime, otherwise False, composite.
    """
    if n == 2: return True
    if n < 2 or n % 2 == 0:
        return False

    if count >= n:
        count = n - 1

    for x in range(count):
        a = random.randint(2, n - 2)
        if not check_fermat_little(a, n):
            return False

    return True


def _decompose(p):
    """_decompose(p) -> (int, int)

    Returns (s, q) such that p = (2**s) * q. p must be > 0.
    """
    t = bin(p)
    s = len(t) - t.rindex('1') - 1
    q = p >> s
    return (s, q)


def miller_rabin(n):
    """miller_rabin(n) -> bool

    Use the probabilistic Miller-Rabin test to check if n is *probably* prime.
    n > 3

    Implements:
        1. Given n, pick a random `a` in range 2 -> n - 1.
        2. Find s so that n - 1 = (2**s) * q for some odd q
        3. If a**q = 1 (mod n) then n passes (and exit).
        4. For i=0 -> s-1, see if (a**q)**(2**i) = (n - 1) (mod n).
           If so, n passes (and exit).
        5. Otherwise n is composite.

    References:
        http://www.giaithuatlaptrinh.com/?p=278
    """
    a = random.randint(2, n - 1)
    if not check_fermat_little(a, n):
        return False

    s, q = _decompose(n - 1)

    aq = pow(a, q, n)
    if aq == 1:
        return True

    for i in range(s):
        a2iq = pow(aq, 2, n)
        if a2iq == 1: # a2iq is the smalles: a2iq = 1 (mod n)
            return (aq == (n - 1)) # aq = -1 (mod n)
        aq = a2iq

    return False


def long_to_bytes(n, blocksize=0):
    """long_to_bytes(n:long, blocksize:int) -> string

    Convert a long integer to a byte string.
    If optional blocksize is given and greater than zero, pad the front of the
    byte string with binary zeros so that the length is a multiple of
    blocksize.

    References:
        https://github.com/dlitz/pycrypto/blob/master/lib/Crypto/Util/number.py
    """
    # after much testing, this algorithm was deemed to be the fastest
    a = []
    n = long(n)
    pack = struct.pack
    while n > 0:
        a.insert(0, pack('>I', n & 0xffffffffL))
        n >>= 32
    s = b''.join(a)
    # strip off leading zeros
    for i in range(len(s)):
        if s[i] != b'\000'[0]:
            break
    else:
        # only happens when n == 0
        s = b'\000'
        i = 0
    s = s[i:]
    # add back some pad bytes.  this could be done more efficiently w.r.t. the
    # de-padding being done above, but sigh...
    if blocksize > 0 and len(s) % blocksize:
        s = (blocksize - len(s) % blocksize) * b'\000' + s
    return s


def bytes_to_long(s):
    """bytes_to_long(string) -> long

    Convert a byte string to a long integer.
    This is (essentially) the inverse of long_to_bytes().
    """
    acc = 0L
    unpack = struct.unpack
    length = len(s)
    if length % 4:
        extra = (4 - length % 4)
        s = b'\000' * extra + s
        length = length + extra
    for i in range(0, length, 4):
        acc = (acc << 32) + unpack('>I', s[i:i+4])[0]
    return acc


