#!/usr/bin/env python
"""
Functions for computing various hashes of files and strings.
"""
import hashlib
from io import open

_algorithms = ('md5', 'sha1', 'sha224', 'sha256', 'sha384', 'sha512')

for _algo in _algorithms:
    def _closure():
        hash = getattr(hashlib, _algo)
        def file(filename, block_size=65536):
            h = hash()
            with open(filename, 'rb') as fd:
                for block in iter(lambda: fd.read(block_size), b''):
                    h.update(block)
            return h
        def sum(s):
            return hash(s)
        filef = lambda x: file(x).digest()
        filef.__doc__ = 'Calculates the %s sum of a file' % _algo
        sumf = lambda x: sum(x).digest()
        sumf.__doc__ = 'Calculates the %s sum of a string' % _algo
        fileh = lambda x: file(x).hexdigest()
        fileh.__doc__ = 'Calculates the %s sum of a file; returns hex-encoded' % _algo
        sumh = lambda x: sum(x).hexdigest()
        sumh.__doc__ = 'Calculates the %s sum of a string; returns hex-encoded' % _algo
        return filef, sumf, fileh, sumh
    (
        globals()[_algo + 'file'],
        globals()[_algo + 'sum'],
        globals()[_algo + 'filehex'],
        globals()[_algo + 'sumhex']
    ) = _closure()
