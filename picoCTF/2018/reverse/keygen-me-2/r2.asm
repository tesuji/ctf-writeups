┌ (fcn) sym.check_valid_key 103
│   sym.check_valid_key (char *key);
│           ; var char ch @ ebp-0x5
│           ; var int i @ ebp-0x4
│           ; arg char *key @ ebp+0x8
│           ; CALL XREF from main (0x8048e49)
│           0x0804870a      push ebp
│           0x0804870b      mov ebp, esp
│           0x0804870d      sub esp, 0x10
│           0x08048710      cmp dword [key], 0
│       ┌─< 0x08048714      jne 0x804871d                              ; likely
│       │   0x08048716      mov eax, 0
│      ┌──< 0x0804871b      jmp 0x804876f
│      │└─> 0x0804871d      mov eax, dword [key]                       ; [0x8:4]=-1 ; 8
│      │    0x08048720      movzx eax, byte [eax]
│      │    0x08048723      mov byte [ch], al
│      │    0x08048726      mov dword [i], 0
│      │┌─< 0x0804872d      jmp 0x8048759
│     ┌───> 0x0804872f      movsx eax, byte [ch]
│     ⁝││   0x08048733      push eax
│     ⁝││   0x08048734      call sym.check_valid_char
│     ⁝││   0x08048739      add esp, 4
│     ⁝││   0x0804873c      test al, al
│    ┌────< 0x0804873e      jne 0x8048747                              ; likely
│    │⁝││   0x08048740      mov eax, 0
│   ┌─────< 0x08048745      jmp 0x804876f
│   │└────> 0x08048747      add dword [i], 1
│   │ ⁝││   0x0804874b      mov edx, dword [key]                       ; [0x8:4]=-1 ; 8
│   │ ⁝││   0x0804874e      mov eax, dword [i]
│   │ ⁝││   0x08048751      add eax, edx
│   │ ⁝││   0x08048753      movzx eax, byte [eax]
│   │ ⁝││   0x08048756      mov byte [ch], al
│   │ ⁝││   ; CODE XREF from sym.check_valid_key (0x804872d)
│   │ ⁝│└─> 0x08048759      cmp byte [ch], 0
│   │ └───< 0x0804875d      jne 0x804872f                              ; likely
│   │  │    0x0804875f      cmp dword [i], 0x10                        ; [0x10:4]=-1 ; 16
│   │  │┌─< 0x08048763      je 0x804876c                               ; unlikely
│   │  ││   0x08048765      mov eax, 0
│   │ ┌───< 0x0804876a      jmp 0x804876f
│   │ ││└─> 0x0804876c      mov eax, dword [i]
│   │ ││    ; CODE XREFS from sym.check_valid_key (0x804871b, 0x8048745, 0x804876a)
│   └─└└──> 0x0804876f      leave
└           0x08048770      ret
┌ (fcn) sym.check_valid_char 50
│   sym.check_valid_char (int in);
│           ; var char ch @ ebp-0x4
│           ; arg int in @ ebp+0x8
│           ; CALL XREF from sym.check_valid_key (0x8048734)
│           0x08048686      push ebp
│           0x08048687      mov ebp, esp
│           0x08048689      sub esp, 4
│           0x0804868c      mov eax, dword [in]                        ; [0x8:4]=-1 ; 8
│           0x0804868f      mov byte [ch], al
│           0x08048692      cmp byte [ch], 0x2f                        ; [0x2f:1]=255 ; '/' ; 47
│       ┌─< 0x08048696      jle 0x804869e                              ; unlikely
│       │   0x08048698      cmp byte [ch], 0x39                        ; [0x39:1]=255 ; '9' ; 57
│      ┌──< 0x0804869c      jle 0x80486aa                              ; unlikely
│      │└─> 0x0804869e      cmp byte [ch], 0x40                        ; [0x40:1]=255 ; '@' ; 64
│      │┌─< 0x080486a2      jle 0x80486b1                              ; unlikely
│      ││   0x080486a4      cmp byte [ch], 0x5a                        ; [0x5a:1]=255 ; 'Z' ; 90
│     ┌───< 0x080486a8      jg 0x80486b1                               ; likely
│     │└──> 0x080486aa      mov eax, 1
│     │┌──< 0x080486af      jmp 0x80486b6
│     └─└─> 0x080486b1      mov eax, 0
│      │    ; CODE XREF from sym.check_valid_char (0x80486af)
│      └──> 0x080486b6      leave
└           0x080486b7      ret
┌ (fcn) sym.validate_key 325
│   sym.validate_key (char *key);
│           ; var int len @ ebp-0xc
│           ; arg char *key @ ebp+0x8
│           ; CALL XREF from main (0x8048e78)
│           0x08048cb7      push ebp
│           0x08048cb8      mov ebp, esp
│           0x08048cba      sub esp, 0x18
│           0x08048cbd      sub esp, 0xc
│           0x08048cc0      push dword [key]
│           0x08048cc3      call sym.imp.strlen
│           0x08048cc8      add esp, 0x10
│           0x08048ccb      mov dword [len], eax
│           0x08048cce      mov eax, dword [len]
│           0x08048cd1      sub esp, 8
│           0x08048cd4      push eax
│           0x08048cd5      push dword [key]
│           0x08048cd8      call sym.key_constraint_01
│           0x08048cdd      add esp, 0x10
│           0x08048ce0      test al, al
│       ┌─< 0x08048ce2      je 0x8048df5                               ; unlikely
│       │   0x08048ce8      mov eax, dword [len]
│       │   0x08048ceb      sub esp, 8
│       │   0x08048cee      push eax
│       │   0x08048cef      push dword [key]
│       │   0x08048cf2      call sym.key_constraint_02
│       │   0x08048cf7      add esp, 0x10
│       │   0x08048cfa      test al, al
│      ┌──< 0x08048cfc      je 0x8048df5                               ; unlikely
│      ││   0x08048d02      mov eax, dword [len]
│      ││   0x08048d05      sub esp, 8
│      ││   0x08048d08      push eax
│      ││   0x08048d09      push dword [key]
│      ││   0x08048d0c      call sym.key_constraint_03
│      ││   0x08048d11      add esp, 0x10
│      ││   0x08048d14      test al, al
│     ┌───< 0x08048d16      je 0x8048df5                               ; unlikely
│     │││   0x08048d1c      mov eax, dword [len]
│     │││   0x08048d1f      sub esp, 8
│     │││   0x08048d22      push eax
│     │││   0x08048d23      push dword [key]
│     │││   0x08048d26      call sym.key_constraint_04
│     │││   0x08048d2b      add esp, 0x10
│     │││   0x08048d2e      test al, al
│    ┌────< 0x08048d30      je 0x8048df5                               ; unlikely
│    ││││   0x08048d36      mov eax, dword [len]
│    ││││   0x08048d39      sub esp, 8
│    ││││   0x08048d3c      push eax
│    ││││   0x08048d3d      push dword [key]
│    ││││   0x08048d40      call sym.key_constraint_05
│    ││││   0x08048d45      add esp, 0x10
│    ││││   0x08048d48      test al, al
│   ┌─────< 0x08048d4a      je 0x8048df5                               ; unlikely
│   │││││   0x08048d50      mov eax, dword [len]
│   │││││   0x08048d53      sub esp, 8
│   │││││   0x08048d56      push eax
│   │││││   0x08048d57      push dword [key]
│   │││││   0x08048d5a      call sym.key_constraint_06
│   │││││   0x08048d5f      add esp, 0x10
│   │││││   0x08048d62      test al, al
│  ┌──────< 0x08048d64      je 0x8048df5                               ; unlikely
│  ││││││   0x08048d6a      mov eax, dword [len]
│  ││││││   0x08048d6d      sub esp, 8
│  ││││││   0x08048d70      push eax
│  ││││││   0x08048d71      push dword [key]
│  ││││││   0x08048d74      call sym.key_constraint_07
│  ││││││   0x08048d79      add esp, 0x10
│  ││││││   0x08048d7c      test al, al
│ ┌───────< 0x08048d7e      je 0x8048df5                               ; unlikely
│ │││││││   0x08048d80      mov eax, dword [len]
│ │││││││   0x08048d83      sub esp, 8
│ │││││││   0x08048d86      push eax
│ │││││││   0x08048d87      push dword [key]
│ │││││││   0x08048d8a      call sym.key_constraint_08
│ │││││││   0x08048d8f      add esp, 0x10
│ │││││││   0x08048d92      test al, al
│ ────────< 0x08048d94      je 0x8048df5                               ; unlikely
│ │││││││   0x08048d96      mov eax, dword [len]
│ │││││││   0x08048d99      sub esp, 8
│ │││││││   0x08048d9c      push eax
│ │││││││   0x08048d9d      push dword [key]
│ │││││││   0x08048da0      call sym.key_constraint_09
│ │││││││   0x08048da5      add esp, 0x10
│ │││││││   0x08048da8      test al, al
│ ────────< 0x08048daa      je 0x8048df5                               ; unlikely
│ │││││││   0x08048dac      mov eax, dword [len]
│ │││││││   0x08048daf      sub esp, 8
│ │││││││   0x08048db2      push eax
│ │││││││   0x08048db3      push dword [key]
│ │││││││   0x08048db6      call sym.key_constraint_10
│ │││││││   0x08048dbb      add esp, 0x10
│ │││││││   0x08048dbe      test al, al
│ ────────< 0x08048dc0      je 0x8048df5                               ; unlikely
│ │││││││   0x08048dc2      mov eax, dword [len]
│ │││││││   0x08048dc5      sub esp, 8
│ │││││││   0x08048dc8      push eax
│ │││││││   0x08048dc9      push dword [key]
│ │││││││   0x08048dcc      call sym.key_constraint_11
│ │││││││   0x08048dd1      add esp, 0x10
│ │││││││   0x08048dd4      test al, al
│ ────────< 0x08048dd6      je 0x8048df5                               ; unlikely
│ │││││││   0x08048dd8      mov eax, dword [len]
│ │││││││   0x08048ddb      sub esp, 8
│ │││││││   0x08048dde      push eax
│ │││││││   0x08048ddf      push dword [key]
│ │││││││   0x08048de2      call sym.key_constraint_12
│ │││││││   0x08048de7      add esp, 0x10
│ │││││││   0x08048dea      test al, al
│ ────────< 0x08048dec      je 0x8048df5                               ; unlikely
│ │││││││   0x08048dee      mov eax, 1
│ ────────< 0x08048df3      jmp 0x8048dfa
│ └└└└└└└─> 0x08048df5      mov eax, 0
│           ; CODE XREF from sym.validate_key (0x8048df3)
│ ────────> 0x08048dfa      leave
└           0x08048dfb      ret
┌ (fcn) sym.ord 82
│   sym.ord (int arg_8h);
│           ; var char ch @ ebp-0xc
│           ; arg int arg_8h @ ebp+0x8
│           ; XREFS(33)
│           0x080486b8      push ebp
│           0x080486b9      mov ebp, esp
│           0x080486bb      sub esp, 0x18
│           0x080486be      mov eax, dword [arg_8h]                    ; [0x8:4]=-1 ; 8
│           0x080486c1      mov byte [ch], al
│           0x080486c4      cmp byte [ch], 0x2f                        ; [0x2f:1]=255 ; '/' ; 47
│       ┌─< 0x080486c8      jle 0x80486d9                              ; unlikely
│       │   0x080486ca      cmp byte [ch], 0x39                        ; [0x39:1]=255 ; '9' ; 57
│      ┌──< 0x080486ce      jg 0x80486d9                               ; likely
│      ││   0x080486d0      movzx eax, byte [ch]
│      ││   0x080486d4      sub eax, 0x30                              ; '0'
│     ┌───< 0x080486d7      jmp 0x8048708
│     │└└─> 0x080486d9      cmp byte [ch], 0x40                        ; [0x40:1]=255 ; '@' ; 64
│     │ ┌─< 0x080486dd      jle 0x80486ee                              ; unlikely
│     │ │   0x080486df      cmp byte [ch], 0x5a                        ; [0x5a:1]=255 ; 'Z' ; 90
│     │┌──< 0x080486e3      jg 0x80486ee                               ; likely
│     │││   0x080486e5      movzx eax, byte [ch]
│     │││   0x080486e9      sub eax, 0x37                              ; '7'
│    ┌────< 0x080486ec      jmp 0x8048708
│    ││└└─> 0x080486ee      sub esp, 0xc
│    ││     0x080486f1      push str.Found_Invalid_Character           ; 0x8048f64 ; "Found Invalid Character!"
│    ││     0x080486f6      call sym.imp.puts
│    ││     0x080486fb      add esp, 0x10
│    ││     0x080486fe      sub esp, 0xc
│    ││     0x08048701      push 0
│    ││     0x08048703      call sym.imp.exit                          ; CALL: 0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff
│    ││     ; CODE XREFS from sym.ord (0x80486d7, 0x80486ec)
│    └└───> 0x08048708      leave
└           0x08048709      ret
┌ (fcn) sym.key_constraint_01 85
│   sym.key_constraint_01 (char *key, size_t len);
│           ; var int local_4h @ ebp-0x4
│           ; arg char *key @ ebp+0x8
│           ; arg size_t len @ ebp+0xc
│           ; CALL XREFS from sym.validate_key (0x8048cb7, 0x8048cd8)
│           0x08048796      push ebp
│           0x08048797      mov ebp, esp
│           0x08048799      push ebx
│           0x0804879a      sub esp, 4
│           0x0804879d      mov eax, dword [key]                       ; [0x8:4]=-1 ; 8
│           0x080487a0      movzx eax, byte [eax]
│           0x080487a3      movsx eax, al
│           0x080487a6      sub esp, 0xc
│           0x080487a9      push eax
│           0x080487aa      call sym.ord
│           0x080487af      add esp, 0x10
│           0x080487b2      movsx ebx, al
│           0x080487b5      mov eax, dword [key]                       ; [0x8:4]=-1 ; 8
│           0x080487b8      add eax, 1
│           0x080487bb      movzx eax, byte [eax]
│           0x080487be      movsx eax, al
│           0x080487c1      sub esp, 0xc
│           0x080487c4      push eax
│           0x080487c5      call sym.ord
│           0x080487ca      add esp, 0x10
│           0x080487cd      movsx eax, al
│           0x080487d0      add eax, ebx
│           0x080487d2      sub esp, 8
│           0x080487d5      push 0x24                                  ; '$' ; 36
│           0x080487d7      push eax
│           0x080487d8      call sym.mod
│           0x080487dd      add esp, 0x10
│           0x080487e0      cmp eax, 0xe                               ; 14
│           0x080487e3      sete al
│           0x080487e6      mov ebx, dword [local_4h]
│           0x080487e9      leave
└           0x080487ea      ret
┌ (fcn) sym.mod 37
│   sym.mod (int a, int b);
│           ; var int rs @ ebp-0x4
│           ; arg int a @ ebp+0x8
│           ; arg int b @ ebp+0xc
│           ; XREFS: CALL 0x080487d8  CALL 0x08048830  CALL 0x08048887  CALL 0x080488fc  CALL 0x08048971  CALL 0x080489e6  
│           ; XREFS: CALL 0x08048a5b  CALL 0x08048ad0  CALL 0x08048b45  CALL 0x08048bba  CALL 0x08048c2f  CALL 0x08048ca4  
│           0x08048771      push ebp
│           0x08048772      mov ebp, esp
│           0x08048774      sub esp, 0x10
│           0x08048777      mov eax, dword [a]                         ; [0x8:4]=-1 ; 8
│           0x0804877a      cdq
│           0x0804877b      idiv dword [b]
│           0x0804877e      mov dword [rs], edx
│           0x08048781      cmp dword [rs], 0
│       ┌─< 0x08048785      jns 0x8048791                              ; likely
│       │   0x08048787      mov edx, dword [rs]
│       │   0x0804878a      mov eax, dword [b]                         ; [0xc:4]=-1 ; 12
│       │   0x0804878d      add eax, edx
│      ┌──< 0x0804878f      jmp 0x8048794
│      │└─> 0x08048791      mov eax, dword [rs]
│      │    ; CODE XREF from sym.mod (0x804878f)
│      └──> 0x08048794      leave
└           0x08048795      ret
