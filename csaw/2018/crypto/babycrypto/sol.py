#!/usr/bin/env python3

u = None
with open('1.txt', 'rb') as fd:
    u = fd.read()

for i in range(256):
    print("i = {}".format(i))
    out = [i ^ x for x in u]
    xored_filename = 'save_{}'.format(i)
    with open(xored_filename, 'wb') as fd:
        fd.write(bytes(out) + b'\n')

