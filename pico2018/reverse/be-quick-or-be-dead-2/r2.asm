            ;-- rip:
┌ (fcn) sym.decrypt_flag 112
│   sym.decrypt_flag (int arg1);
│           ; var int key @ rbp-0x14
│           ; var int count @ rbp-0x4
│           ; arg int arg1 @ rdi
│           ; CALL XREF from sym.print_flag (0x40080f)
│           0x00400696      push rbp
│           0x00400697      mov rbp, rsp
│           0x0040069a      mov dword [key], edi                       ; arg1
│           0x0040069d      mov dword [count], 0
│       ┌─< 0x004006a4      jmp 0x4006fb
│      ┌──> 0x004006a6      mov eax, dword [count]
│      ⁝│   0x004006a9      cdqe
│      ⁝│   0x004006ab      movzx ecx, byte [rax + obj.flag]           ; [0x601080:1]=40 ; "(\xf2i\x98\x1a\xcfL\x8c.\xf3o\xa8=\xf2h\x982\xfai\x944\xc4y\x92/\xeeo\x99<\xfeU\x94\x01\xf5U\x95\x04\xc4n\x98\f\xfeU\x91\x02\xe8~\xa8S\xfe;\xcf]\xa39\xc3\x1b"
│      ⁝│   0x004006b2      mov eax, dword [count]
│      ⁝│   0x004006b5      cdq 				;  EDX:EAX = sign-extend of EAX
│      ⁝│   0x004006b6      shr edx, 0x1e 			; 0
│      ⁝│   0x004006b9      add eax, edx 			; eax
│      ⁝│   0x004006bb      and eax, 3 				; eax & 3
│      ⁝│   0x004006be      sub eax, edx 			; eax
│      ⁝│   0x004006c0      cdqe 				; RAX = sign-extend of EAX.
│      ⁝│   0x004006c2      lea rdx, [key] 			; &key
│      ⁝│   0x004006c6      add rax, rdx                        ; eax + &key
│      ⁝│   0x004006c9      movzx eax, byte [rax] 		;
│      ⁝│   0x004006cc      xor ecx, eax
│      ⁝│   0x004006ce      mov edx, ecx
│      ⁝│   0x004006d0      mov eax, dword [count]
│      ⁝│   0x004006d3      cdqe
│      ⁝│   0x004006d5      mov byte [rax + obj.flag], dl              ; [0x601080:1]=40 ; "(\xf2i\x98\x1a\xcfL\x8c.\xf3o\xa8=\xf2h\x982\xfai\x944\xc4y\x92/\xeeo\x99<\xfeU\x94\x01\xf5U\x95\x04\xc4n\x98\f\xfeU\x91\x02\xe8~\xa8S\xfe;\xcf]\xa39\xc3\x1b"
│      ⁝│   0x004006db      mov eax, dword [count]
│      ⁝│   0x004006de      cdq
│      ⁝│   0x004006df      shr edx, 0x1e
│      ⁝│   0x004006e2      add eax, edx
│      ⁝│   0x004006e4      and eax, 3
│      ⁝│   0x004006e7      sub eax, edx
│      ⁝│   0x004006e9      cmp eax, 3                                 ; 3
│     ┌───< 0x004006ec      jne 0x4006f7                               ; likely
│     │⁝│   0x004006ee      mov eax, dword [key]
│     │⁝│   0x004006f1      add eax, 1
│     │⁝│   0x004006f4      mov dword [key], eax
│     │⁝│   ; CODE XREF from sym.decrypt_flag (0x4006ec)
│     └───> 0x004006f7      add dword [count], 1
│      ⁝│   ; CODE XREF from sym.decrypt_flag (0x4006a4)
│      ⁝└─> 0x004006fb      mov eax, dword [count]
│      ⁝    0x004006fe      cmp eax, 0x38                              ; '8' ; 56
│      └──< 0x00400701      jbe 0x4006a6                               ; likely
│           0x00400703      nop
│           0x00400704      pop rbp
└           0x00400705      ret
┌ (fcn) sym.fib 69
│   sym.fib ();
│           ; var unsigned int a @ rbp-0x24
│           ; var unsigned int b @ rbp-0x14
│           ; CALL XREFS from sym.fib (0x400728, 0x400737)
│           ; CALL XREF from sym.calculate_key (0x400754)
│           0x00400706      push rbp
│           0x00400707      mov rbp, rsp
│           0x0040070a      push rbx
│           0x0040070b      sub rsp, 0x28                              ; '('
│           0x0040070f      mov dword [a], edi
│           0x00400712      cmp dword [a], 1                           ; [0x1:4]=-1 ; 1
│       ┌─< 0x00400716      ja 0x400720
│       │   0x00400718      mov eax, dword [a]
│       │   0x0040071b      mov dword [b], eax
│      ┌──< 0x0040071e      jmp 0x400741
│      ││   ; CODE XREF from sym.fib (0x400716)
│      │└─> 0x00400720      mov eax, dword [a]
│      │    0x00400723      sub eax, 1
│      │    0x00400726      mov edi, eax
│      │    0x00400728      call sym.fib
│      │    0x0040072d      mov ebx, eax
│      │    0x0040072f      mov eax, dword [a]
│      │    0x00400732      sub eax, 2
│      │    0x00400735      mov edi, eax
│      │    0x00400737      call sym.fib
│      │    0x0040073c      add eax, ebx
│      │    0x0040073e      mov dword [b], eax
│      │    ; CODE XREF from sym.fib (0x40071e)
│      └──> 0x00400741      mov eax, dword [b]
│           0x00400744      add rsp, 0x28                              ; '('
│           0x00400748      pop rbx
│           0x00400749      pop rbp
└           0x0040074a      ret
