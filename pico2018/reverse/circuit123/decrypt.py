#!/usr/bin/python2
from __future__ import print_function
from hashlib import sha512
import sys

def verify(key, chalbox):
    length, gates, check = chalbox

    b = [(key >> i) & 1 for i in range(length)]

    for name, args in gates:
        if name == 'true':
            b.append(1)
        else:
            u1 = b[args[0][0]] ^ args[0][1]
            u2 = b[args[1][0]] ^ args[1][1]
            if name == 'or':
                b.append(u1 | u2)
            elif name == 'xor':
                b.append(u1 ^ u2)
    return b[check[0]] ^ check[1]

def dec(x, w):
    z = int(sha512(str(int(x))).hexdigest(), 16)
    return '{:x}'.format(w ^ z).decode('hex')

if __name__ == '__main__':
    prog_name, key, mapfile = sys.argv[0], sys.argv[1], sys.argv[2]

    if len(sys.argv) < 3:
        print('Usage: ' + prog_name + ' <key> <map.txt>')
        print('Example: Try Running ' + prog_name + ' 11443513758266689915 map1.txt')
        exit(1)

    with open(mapfile, 'r') as f:
        cipher, chalbox = eval(f.read())

    length = chalbox[0]
    key = int(key) % (1 << length)
    print('Attempting to decrypt ' + mapfile + '...')
    if verify(key, chalbox):
        print('Congrats the flag for ' + mapfile + ' is:', dec(key, cipher))
    else:
        print('Wrong key for ' + mapfile + '.')
