# HEEEEEEERE'S Johnny! - Points: 100 - (Solves: 170)

Okay, so we found some important looking files on a linux computer.
Maybe they can be used to get a password to the process.
Connect with

    nc 2018shell2.picoctf.com 38860

Files can be found here: [passwd][1] [shadow][2].

[1]: https://2018shell2.picoctf.com/static/29633d1bd5ba677d6af455cf61b18f57/passwd
[2]: https://2018shell2.picoctf.com/static/29633d1bd5ba677d6af455cf61b18f57/shadow

---

## Preparing on picoctf server

### Install john

```sh
wget https://www.openwall.com/john/j/john-1.8.0.tar.xz
unxz john-1.8.0.tar.xz
tar -xvf john-1.8.0.tar
cd john-1.8.0/src && make linux-x86-64-avx
cd ../run
/unshadow passwd shadow > ~/mypasswd.txt
./john ~/mypasswd.txt
```

### Cracking

```sh
% john --wordlist=rockyou.txt mypw.txt
Loaded 1 password hash (crypt, generic crypt(3) [?/64])
Press 'q' or Ctrl-C to abort, almost any other key for status
thematrix        (root)
1g 0:00:00:41 100% 0.02437g/s 269.1p/s 269.1c/s 269.1C/s jemjem..davida
Use the "--show" option to display all of the cracked passwords reliably
Session completed
% nc 2018shell2.picoctf.com 38860
Username: root
Password: thematrix
picoCTF{J0hn_1$_R1pp3d_4e5aa29e}
```
