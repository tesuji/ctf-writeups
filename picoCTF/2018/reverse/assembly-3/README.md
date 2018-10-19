# assembly-3 - Points: 400 - (Solves: 178)

What does asm3(0xf238999b,0xda0f9ac5,0xcc85310c) return?
Submit the flag as a hexadecimal value (starting with '0x').
NOTE: Your submission for this question will NOT be in the normal flag format.
[Source][1] located in the directory at /problems/assembly-3_2_504fe35f4236db611941d162e2abc6b9.

[1]: https://2018shell2.picoctf.com/static/8574a4801ca14ef4666bc4a6e5f694c2/end_asm_rev.S

## Hints

https://en.wikipedia.org/wiki/Base64

---

```sh
% make -C src
% gdb ./test.elf
Reading symbols from ./test.elf...(no debugging symbols found)...done.
(gdb) disas _start
Dump of assembler code for function _start:
   0x08048080 <+0>: push   ebp
   0x08048081 <+1>: mov    ebp,esp
   0x08048083 <+3>: push   0x0
   0x08048085 <+5>: push   0x0
   0x08048087 <+7>: push   0x0
   0x08048089 <+9>: push   0x0
   0x0804808b <+11>:  push   0xcc85310c
   0x08048090 <+16>:  push   0xda0f9ac5
   0x08048095 <+21>:  push   0xf238999b
   0x0804809a <+26>:  call   0x80480ae <asm3>
   0x0804809f <+31>:  mov    esp,ebp
   0x080480a1 <+33>:  pop    ebp
   0x080480a2 <+34>:  mov    ebx,0x0
   0x080480a7 <+39>:  mov    eax,0x1
   0x080480ac <+44>:  int    0x80
End of assembler dump.
(gdb) b *0x0804809a
Breakpoint 1 at 0x804809a
(gdb) r
Starting program: /stor/ctf/pico2018/reversing/assembly-3/src/test.elf

Breakpoint 1, 0x0804809a in _start ()
(gdb) i r eax
eax            0x0  0
(gdb) x/8xw $sp
0xffffd030: 0xf238999b  0xda0f9ac5  0xcc85310c  0x00000000
0xffffd040: 0x00000000  0x00000000  0x00000000  0x00000000
(gdb) ni
0x0804809f in _start ()
(gdb) i r eax
eax            0x56a3 22179
(gdb) quit
```
