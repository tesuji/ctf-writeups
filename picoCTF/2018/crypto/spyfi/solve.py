#! /usr/bin/env python
from __future__ import division
from __future__ import print_function
from binascii import unhexlify, hexlify
import string
import sys
from pprint import pprint
#
from pwn import context, p32, u32, log, remote, args, log
context.clear(arch='i386', os='linux')


def pad(message):
    if len(message) % 16 != 0:
        message = message + '0'*(16 - len(message)%16 )
    return message


def query(msg, bs=32):
    HOST = '2018shell2.picoctf.com'
    PORT = 31123
    with remote(HOST, PORT) as p:
        log.info('TRYING : %r', msg)

        p.clean()
        p.sendline(msg)

        enc = p.recvall().strip()
        enc_len = len(enc)
        u = tuple( enc[x:x+bs] for x in xrange(0, enc_len, bs) )
        return u


def get_message_template():
    message = r"""Agent,
Greetings. My situation report is as follows:
@
My agent identifying code is: @.
Down with the Soviets,
006
"""
    return message.split(r'@')


def print_block(text, bs):
    text_len = len(text)
    for x in xrange(0, text_len, bs):
        log.info('\tblock %d: %r' % (x // bs, text[x:x+bs]))


def giveme_log(my_report, template, bs=16):
    msg_head, msg_medium, msg_tail = template
    agent_code  = r'picoCTF{XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX}'

    message = ''.join([msg_head, my_report, msg_medium, agent_code, msg_tail])
    message = pad(message)

    log.info('plain : %r' % message)
    print_block(message, bs)


def bruteforce_ecb():
    BLOCK_SIZE = 16
    # CHARSETS = r"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789_{}"
    CHARSETS = tuple(string.printable.strip())

    template = get_message_template()
    msg_head, msg_medium, msg_tail = template

    leak_flag = ''
    # for _ in xrange(2):
    while True:
        if '}' in leak_flag:
            break

        prefix_len  = sum(map(len, [msg_head, msg_medium, leak_flag]))
        padding_len = (-(prefix_len + 1)) % BLOCK_SIZE
        padding = '*' * padding_len

        all_len = prefix_len + 1 + padding_len
        assert((all_len % BLOCK_SIZE) == 0)
        block_id = (all_len // BLOCK_SIZE) - 1
        log.info("Block ID : %r", block_id)

        encrypted_text = query(padding)
        pprint(encrypted_text)
        precise_part = encrypted_text[block_id]

        log.info('precise_part: %r', precise_part)

        giveme_log(padding, template, BLOCK_SIZE)

        padding_len = (-prefix_len + 1) % BLOCK_SIZE + BLOCK_SIZE
        padding = msg_medium[(-padding_len + 3):]
        fake_id = ((len(msg_head) + padding_len + len(leak_flag) + 1) // 16) - 1
        log.info("Fake ID : %r", fake_id)
        for c in CHARSETS:
            payload = padding + leak_flag + c
            #giveme_log(payload, template, BLOCK_SIZE)
            enc = query(payload)
            part = enc[fake_id]
            if part == precise_part:
                pprint(enc)
                leak_flag += c
                log.success("FLAG updated: %r", leak_flag)
                break
        else:
            break

    return leak_flag


def main():
    leak_flag = bruteforce_ecb()
    log.success('FLAG: %r', leak_flag)


if __name__ == "__main__":
    main()
