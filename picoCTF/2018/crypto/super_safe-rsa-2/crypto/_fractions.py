#!/usr/bin/env python

from _combability_layer import _math


def continued_fraction(n, m=1):
    """
    Returns continued fraction `pquotients' in form (a0, a1, .., a_n)
    of a rational p/q

    Example:
    >>> continued_fraction(45, 16)
    (2, 1, 4, 3)
    >>>

    Algorithm:
    Using GCD algorithm
        n   =   q x m   +   r
        =====================
        45  =   2 x 16  +   13
        16  =   1 x 13  +   3
        13  =   4 x 3   +   1
        3   =   3 x 1   +   0
    """
    q, r = _math.f_divmod(n, m)
    partial_quotients = [q]
    while r != 0:
        n, m = m, r
        q, r = _math.f_divmod(n, m)
        partial_quotients.append(q)
    return tuple(partial_quotients)


def continued_fraction_convergents(pquotients):
    """
    Returns iterator to list of convergents (rational approximations)
    of the continued fraction in form of (n, m), equivalent with n/m

    Note:
    + Even-numbered convergents are smaller than the original number,
    while odd-numbered ones are bigger.

    Example:
    >>> pquotients = continued_fraction(73, 27)
    >>> print(pquotients)
    (2, 1, 2, 2, 1, 2)
    >>> c = continued_fraction_convergents(pquotients)
    >>> print(list(c))
    [(2, 1), (3, 1), (8, 3), (19, 7), (27, 10), (73, 27)]
    >>>

    Reference:
    + https://oeis.org/wiki/Continued_fractions
    """
    if len(pquotients) == 0:
        yield (0, 1)
    else:
        p_2, q_2 = 0, 1
        p_1, q_1 = 1, 0
        for a_i in pquotients:
            p = a_i*p_1 + p_2 # p[i] = a[i]*p[i-1] + p[i-2]
            q = a_i*q_1 + q_2 # q[i] = a[i]*q[i-1] + q[i-2]
            p_2, p_1 = p_1, p
            q_2, q_1 = q_1, q
            c = (p, q) # c_i = p_i / q_i, i>=0
            yield c

