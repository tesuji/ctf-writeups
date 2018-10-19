# assembly-0 - Points: 150 - (Solves: 383)

What does asm0(0xb6,0xc6) return? Submit the flag as a hexadecimal
value (starting with '0x').

NOTE: Your submission for this question will NOT be in the normal flag format.
[Source][1] located in the directory at

    /problems/assembly-0_0_5a220faedfaf4fbf26e6771960d4a359.

[1]: https://2018shell2.picoctf.com/static/46ada954d2690f0d3631cd55e82e85df/intro_asm_rev.S

## Hint

- basical assembly [tutorial](https://www.tutorialspoint.com/assembly_programming/assembly_basic_syntax.htm)
- assembly [registers](https://www.tutorialspoint.com/assembly_programming/assembly_registers.htm)

---

**intro_asm_rev.S**

```asm
.intel_syntax noprefix
.bits 32

.global asm0

asm0:
  push  ebp
  mov ebp,esp
  mov eax,DWORD PTR [ebp+0x8]
  mov ebx,DWORD PTR [ebp+0xc]
  mov eax,ebx
  mov esp,ebp
  pop ebp
  ret
```

Pseudo code:

```c
int asm0(int a, int b)
{
  return b;
}
```

FLAG: 0xc6
