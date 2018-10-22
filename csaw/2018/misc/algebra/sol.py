#!/usr/bin/env python
#
import sympy
from pwn import *


def get_eq_string(r):
    """get_eq_string(r) -> str

    If we read

        2 * X = 116
        What does X equal?: 116 /2

    We need to return the string
        '2 * X = 116'
    """
    try:
        buf = r.recvuntil(b'equal?: ')
    except EOFError as e:
        log.warn("Error: Cannot recv")
        log.info("%s" % r.recvall())
        return None

    print("%s" % buf)
    return buf.splitlines()[-2]


def solve_eq(eqm):
    X = sympy.Symbol('X')
    lv, rv = eqm.split('=')
    eq_str = "%s - (%s)" % (lv, rv)
    eq = sympy.Eq(eval(eq_str))
    return sympy.solve(eq)


def main():
    host, port = 'misc.chal.csaw.io', 9002
    r = remote(host, port)

    while True:
        eqm = get_eq_string(r)
        log.info("Equation: %r" % eqm)

        X_root = solve_eq(eqm)
        log.indented("Root: %r" % X_root)
        if isinstance(X_root, list):
            r.sendline(str(float(X_root[0])))
        else:
            r.sendline('0')


if __name__ == '__main__':
    main()
