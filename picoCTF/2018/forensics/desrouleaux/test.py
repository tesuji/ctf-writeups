#!/usr/bin/env python
from collections import Counter
import json
import pprint
#
from pwn import *

class RemoteData(object):
    remote = '2018shell2.picoctf.com'
    remote_port = 14079


def most_common_src_IP(src_IPs):
    v = Counter(src_IPs).most_common()[0][0]
    return v


def count_unique_dst_IP(tickets, src_IP):
    dst_ip = set()
    for x in tickets:
        if x['src_ip'] == src_IP:
            dst_ip.add(x['dst_ip'])

    log.info('unique destination IP: %s' % dst_ip)
    return len(dst_ip)


def main():
    tickets = None
    with open('incidents.json', 'r') as fd:
        tickets = json.load(fd)['tickets']

    src_IPs = [x['src_ip'] for x in tickets]

    r = remote(RemoteData.remote, RemoteData.remote_port)
    v = most_common_src_IP(src_IPs)
    r.sendlineafter('most common ones.\n', v)

    #
    r.recvuntil('source IP address ')
    src_IP = r.recvuntil('?', drop=True)
    v = count_unique_dst_IP(tickets, src_IP)
    r.clean()
    r.sendline(str(v))
    #
    r.interactive()


if __name__ == '__main__':
    main()
