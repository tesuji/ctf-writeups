┌ (fcn) sym.do_magic 211
│   sym.do_magic ();
│           ; var char ch @ ebp-0x1d
│           ; var unsigned int i @ ebp-0x1c
│           ; var int j @ ebp-0x18
│           ; var char *s @ ebp-0x14
│           ; var size_t size @ ebp-0x10
│           ; var void *ptr @ ebp-0xc
│           ; CALL XREF from sym.main (0x804874a)
│           0x08048642      push ebp
│           0x08048643      mov ebp, esp
│           0x08048645      sub esp, 0x28                              ; '('
│           0x08048648      call sym.read_input
│           0x0804864d      mov dword [s], eax
│           0x08048650      sub esp, 0xc
│           0x08048653      push dword [s]                             ; const char *s
│           0x08048656      call sym.imp.strlen                        ; size_t strlen(const char *s)
│           0x0804865b      add esp, 0x10
│           0x0804865e      mov dword [size], eax
│           0x08048661      mov eax, dword [size]
│           0x08048664      add eax, 1
│           0x08048667      sub esp, 0xc
│           0x0804866a      push eax                                   ; size_t size
│           0x0804866b      call sym.imp.malloc                        ; void *malloc(size_t size)
│           0x08048670      add esp, 0x10
│           0x08048673      mov dword [ptr], eax
│           0x08048676      cmp dword [ptr], 0
│       ┌─< 0x0804867a      jne 0x8048696
│       │   0x0804867c      sub esp, 0xc
│       │   0x0804867f      push str.malloc___returned_NULL._Out_of_Memory ; 0x8048884 ; "malloc() returned NULL. Out of Memory\n" ; const char *s
│       │   0x08048684      call sym.imp.puts                          ; int puts(const char *s)
│       │   0x08048689      add esp, 0x10
│       │   0x0804868c      sub esp, 0xc
│       │   0x0804868f      push 0xffffffffffffffff                    ; int status
│       │   0x08048691      call sym.imp.exit                          ; void exit(int status)
│       │   ; CODE XREF from sym.do_magic (0x804867a)
│       └─> 0x08048696      mov eax, dword [size]
│           0x08048699      add eax, 1
│           0x0804869c      sub esp, 4
│           0x0804869f      push eax                                   ; size_t n
│           0x080486a0      push 0                                     ; int c
│           0x080486a2      push dword [ptr]                           ; void *s
│           0x080486a5      call sym.imp.memset                        ; void *memset(void *s, int c, size_t n)
│           0x080486aa      add esp, 0x10
│           0x080486ad      mov dword [i], 0
│           0x080486b4      mov dword [j], 0
│       ┌─< 0x080486bb      jmp 0x804870b
│       │   ; CODE XREF from sym.do_magic (0x8048711)
│      ┌──> 0x080486bd      mov eax, dword [j]
│      ⁝│   0x080486c0      add eax, obj.sekrutBuffer
│      ⁝│   0x080486c5      movzx ecx, byte [eax]
│      ⁝│   0x080486c8      mov edx, dword [j]
│      ⁝│   0x080486cb      mov eax, dword [s]
│      ⁝│   0x080486ce      add eax, edx
│      ⁝│   0x080486d0      movzx eax, byte [eax]
│      ⁝│   0x080486d3      xor eax, ecx
│      ⁝│   0x080486d5      mov byte [ch], al
│      ⁝│   0x080486d8      mov edx, dword obj.greetingMessage         ; [0x804a038:4]=0x80487f0 str.You_have_now_entered_the_Duck_Web__and_you_re_in_for_a_honkin__good_time.__Can_you_figure_out_my_trick
│      ⁝│   0x080486de      mov eax, dword [j]
│      ⁝│   0x080486e1      add eax, edx
│      ⁝│   0x080486e3      movzx eax, byte [eax]
│      ⁝│   0x080486e6      cmp al, byte [ch]
│     ┌───< 0x080486e9      jne 0x80486ef
│     │⁝│   0x080486eb      add dword [i], 1
│     │⁝│   ; CODE XREF from sym.do_magic (0x80486e9)
│     └───> 0x080486ef      cmp dword [i], 0x19                        ; [0x19:4]=-1 ; 25
│     ┌───< 0x080486f3      jne 0x8048707
│     │⁝│   0x080486f5      sub esp, 0xc
│     │⁝│   0x080486f8      push str.You_are_winner                    ; 0x80488ab ; "You are winner!" ; const char *s
│     │⁝│   0x080486fd      call sym.imp.puts                          ; int puts(const char *s)
│     │⁝│   0x08048702      add esp, 0x10
│    ┌────< 0x08048705      jmp 0x8048713
│    ││⁝│   ; CODE XREF from sym.do_magic (0x80486f3)
│    │└───> 0x08048707      add dword [j], 1
│    │ ⁝│   ; CODE XREF from sym.do_magic (0x80486bb)
│    │ ⁝└─> 0x0804870b      mov eax, dword [j]
│    │ ⁝    0x0804870e      cmp eax, dword [size]
│    │ └──< 0x08048711      jl 0x80486bd
│    └────> 0x08048713      leave
└           0x08048714      ret
