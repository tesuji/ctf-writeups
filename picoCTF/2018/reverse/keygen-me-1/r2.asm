┌ (fcn) sym.validate_key 172
│   sym.validate_key (int keybuf);
│           ; var int i @ ebp-0x14
│           ; var signed int j @ ebp-0x10
│           ; var int len @ ebp-0xc
│           ; arg int keybuf @ ebp+0x8
│           ; CALL XREF from main (0x8048899)
│           0x08048771      push ebp
│           0x08048772      mov ebp, esp
│           0x08048774      push ebx
│           0x08048775      sub esp, 0x14
│           0x08048778      sub esp, 0xc
│           0x0804877b      push dword [keybuf]
│           0x0804877e      call sym.imp.strlen
│           0x08048783      add esp, 0x10
│           0x08048786      mov dword [len], eax
│           0x08048789      mov dword [i], 0
│           0x08048790      mov dword [j], 0
│       ┌─< 0x08048797      jmp 0x80487c9
│       │   ; CODE XREF from sym.validate_key (0x80487d2)
│      ┌──> 0x08048799      mov edx, dword [j]
│      ⁝│   0x0804879c      mov eax, dword [keybuf]                    ; [0x8:4]=-1 ; 8
│      ⁝│   0x0804879f      add eax, edx
│      ⁝│   0x080487a1      movzx eax, byte [eax]
│      ⁝│   0x080487a4      movsx eax, al
│      ⁝│   0x080487a7      sub esp, 0xc
│      ⁝│   0x080487aa      push eax
│      ⁝│   0x080487ab      call sym.ord
│      ⁝│   0x080487b0      add esp, 0x10
│      ⁝│   0x080487b3      movsx eax, al
│      ⁝│   0x080487b6      lea edx, [eax + 1]                         ; 1
│      ⁝│   0x080487b9      mov eax, dword [j]
│      ⁝│   0x080487bc      add eax, 1
│      ⁝│   0x080487bf      imul eax, edx
│      ⁝│   0x080487c2      add dword [i], eax
│      ⁝│   0x080487c5      add dword [j], 1
│      ⁝│   ; CODE XREF from sym.validate_key (0x8048797)
│      ⁝└─> 0x080487c9      mov eax, dword [len]
│      ⁝    0x080487cc      sub eax, 1
│      ⁝    0x080487cf      cmp eax, dword [j]
│      └──< 0x080487d2      jg 0x8048799                               ; unlikely
│           0x080487d4      mov ecx, dword [i]
│           0x080487d7      mov edx, 0x38e38e39
│           0x080487dc      mov eax, ecx
│           0x080487de      mul edx
│           0x080487e0      mov ebx, edx
│           0x080487e2      shr ebx, 3
│           0x080487e5      mov eax, ebx
│           0x080487e7      shl eax, 3
│           0x080487ea      add eax, ebx
│           0x080487ec      shl eax, 2
│           0x080487ef      sub ecx, eax
│           0x080487f1      mov ebx, ecx
│           0x080487f3      mov eax, dword [len]
│           0x080487f6      lea edx, [eax - 1]
│           0x080487f9      mov eax, dword [keybuf]                    ; [0x8:4]=-1 ; 8
│           0x080487fc      add eax, edx
│           0x080487fe      movzx eax, byte [eax]
│           0x08048801      movsx eax, al
│           0x08048804      sub esp, 0xc
│           0x08048807      push eax
│           0x08048808      call sym.ord
│           0x0804880d      add esp, 0x10
│           0x08048810      movsx eax, al
│           0x08048813      cmp ebx, eax
│           0x08048815      sete al
│           0x08048818      mov ebx, dword [ebp - 4]
│           0x0804881b      leave                                      ; ebp
└           0x0804881c      ret
            ;-- eip:
┌ (fcn) sym.ord 82
│   sym.ord (int ch);
│           ; var signed int c @ ebp-0xc
│           ; arg int ch @ ebp+0x8
│           ; CALL XREFS from sym.validate_key (0x80487ab, 0x8048808)
│           0x080486b8      push ebp
│           0x080486b9      mov ebp, esp
│           0x080486bb      sub esp, 0x18
│           0x080486be      mov eax, dword [ch]                        ; [0x8:4]=-1 ; 8
│           0x080486c1      mov byte [c], al
│           0x080486c4      cmp byte [c], 0x2f                         ; [0x2f:1]=255 ; '/' ; 47
│       ┌─< 0x080486c8      jle 0x80486d9                              ; likely
│       │   0x080486ca      cmp byte [c], 0x39                         ; [0x39:1]=255 ; '9' ; 57
│      ┌──< 0x080486ce      jg 0x80486d9                               ; unlikely
│      ││   0x080486d0      movzx eax, byte [c]
│      ││   0x080486d4      sub eax, 0x30                              ; '0'
│     ┌───< 0x080486d7      jmp 0x8048708
│     │││   ; CODE XREFS from sym.ord (0x80486c8, 0x80486ce)
│     │└└─> 0x080486d9      cmp byte [c], 0x40                         ; [0x40:1]=255 ; '@' ; 64
│     │ ┌─< 0x080486dd      jle 0x80486ee                              ; likely
│     │ │   0x080486df      cmp byte [c], 0x5a                         ; [0x5a:1]=255 ; 'Z' ; 90
│     │┌──< 0x080486e3      jg 0x80486ee                               ; unlikely
│     │││   0x080486e5      movzx eax, byte [c]
│     │││   0x080486e9      sub eax, 0x37                              ; '7'
│    ┌────< 0x080486ec      jmp 0x8048708
│    ││││   ; CODE XREFS from sym.ord (0x80486dd, 0x80486e3)
│    ││└└─> 0x080486ee      sub esp, 0xc
│    ││     0x080486f1      push str.Found_Invalid_Character           ; 0x8048984 ; "Found Invalid Character!"
│    ││     0x080486f6      call sym.imp.puts
│    ││     0x080486fb      add esp, 0x10
│    ││     0x080486fe      sub esp, 0xc
│    ││     0x08048701      push 0
│    ││     0x08048703      call sym.imp.exit
│    ││     ; CODE XREFS from sym.ord (0x80486d7, 0x80486ec)
│    └└───> 0x08048708      leave                                      ; ebp
└           0x08048709      ret
