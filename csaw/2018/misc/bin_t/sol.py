#!/usr/bin/env python
#
# nc misc.chal.csaw.io 9001

# Local module import
from pwn import *
# local import
from pyavltree import AVLTree


def main():
    # r = remote(b'misc.chal.csaw.io', 9001)
    # r.recvuntil(b'preorder traversal!\n')
    # avl_server = r.recvuntil(b'\n').split(',')

    avl_server = [99,77,91,70,72,69,29,23,36,52,99,77,53,97,13,0,49,99,89,25,77,85,35,11,94,22,39,47,19,16,75,9,59,14,46,7,26,28,66,20,13,2,65,18,100,78,75,71,0,75,71,23,71,72,64,92,83,81,87,29
,49,73,41,75,35,49,78,77,9,95,90,16,71,69,74,97,53,83,1,78,76,55,85,72,96,87,89,26,95,23,61,31,48,20,30,71,54,100,51,33]
    tree = AVLTree(avl_server)
    tree.sanity_check()
    print(tree.as_list(0))


if __name__ == '__main__':
    main()
