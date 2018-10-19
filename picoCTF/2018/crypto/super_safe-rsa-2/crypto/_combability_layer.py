#!/usr/bin/env python

try:
    import gmpy2 as _math

    def perfect_sqrt(x):
        s, r = _math.isqrt_rem(x)
        return s if r == 0 else -1

    _math.perfect_sqrt = perfect_sqrt
except ImportError:
    import operator

    import _slowmath as _math

    """compatibility layer with `gmpy2`"""
    _math.mul = operator.mul
    _math.f_mod = operator.mod
    _math.f_divmod = divmod
