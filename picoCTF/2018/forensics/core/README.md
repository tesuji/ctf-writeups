# core - Points: 350 - (Solves: 126)

This program was about to [print][1] the flag when it died.
Maybe the flag is still in this [core][2] file that it dumped?
Also available at /problems/core_2_6f573d741fe8c5c6518e4a29f04a1e19 on the shell server.

[1]: https://2018shell2.picoctf.com/static/98e0066d40ecdb580ae59a473bcaf721/print_flag
[2]: https://2018shell2.picoctf.com/static/98e0066d40ecdb580ae59a473bcaf721/core

## Hints

- What is a core file?
- You may find this [reference](http://darkdust.net/files/GDB%20Cheat%20Sheet.pdf) helpful.
- Try to figure out where the flag was read into memory using the
  disassembly and [strace](https://linux.die.net/man/1/strace).
- You should study the format options on the cheat sheet and
  use the examine (x) or print (p) commands. disas may also be useful.

---

```sh
% gdb ./print_flag core
> i r eip
eip            0x80487c1  0x80487c1 <print_flag>
> print/x 0x539* 4 + 0x0804a080
$2 = 0x804b564
> x/xw $2
0x804b564 <strs+5348>:  0x080610f0
> x/s 0x080610f0
0x80610f0:  "31b1f6d7550619d1f774bef9c4c0e2e8"
```

picoCTF{31b1f6d7550619d1f774bef9c4c0e2e8}
