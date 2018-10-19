┌ (fcn) sym.calc 140
│   sym.calc ();
│           ; var signed int n @ rbp-0x24
│           ; var int rs @ rbp-0x14
│           ; XREFS: CALL 0x00400733  CALL 0x00400742  CALL 0x00400751  CALL 0x00400761  CALL 0x00400776  CALL 0x0040079b  
│           0x00400706      push rbp
│           0x00400707      mov rbp, rsp
│           0x0040070a      push r12
│           0x0040070c      push rbx
│           0x0040070d      sub rsp, 0x20
│           0x00400711      mov dword [n], edi
│           0x00400714      cmp dword [n], 4                           ; [0x4:4]=-1 ; 4
│       ┌─< 0x00400718      ja 0x40072b
│       │   0x0040071a      mov eax, dword [n]
│       │   0x0040071d      imul eax, dword [n]
│       │   0x00400721      add eax, 0x2345                            ; 'E#'
│       │   0x00400726      mov dword [rs], eax
│      ┌──< 0x00400729      jmp 0x400786
│      ││   ; CODE XREF from sym.calc (0x400718)
│      │└─> 0x0040072b      mov eax, dword [n]
│      │    0x0040072e      sub eax, 1
│      │    0x00400731      mov edi, eax
│      │    0x00400733      call sym.calc
│      │    0x00400738      mov ebx, eax
│      │    0x0040073a      mov eax, dword [n]
│      │    0x0040073d      sub eax, 2
│      │    0x00400740      mov edi, eax
│      │    0x00400742      call sym.calc
│      │    0x00400747      sub ebx, eax
│      │    0x00400749      mov eax, dword [n]
│      │    0x0040074c      sub eax, 3
│      │    0x0040074f      mov edi, eax
│      │    0x00400751      call sym.calc
│      │    0x00400756      mov r12d, eax
│      │    0x00400759      mov eax, dword [n]
│      │    0x0040075c      sub eax, 4
│      │    0x0040075f      mov edi, eax
│      │    0x00400761      call sym.calc
│      │    0x00400766      sub r12d, eax
│      │    0x00400769      mov eax, r12d
│      │    0x0040076c      add ebx, eax
│      │    0x0040076e      mov eax, dword [n]
│      │    0x00400771      sub eax, 5
│      │    0x00400774      mov edi, eax
│      │    0x00400776      call sym.calc
│      │    0x0040077b      imul eax, eax, 0x1234
│      │    0x00400781      add eax, ebx
│      │    0x00400783      mov dword [rs], eax
│      │    ; CODE XREF from sym.calc (0x400729)
│      └──> 0x00400786      mov eax, dword [rs]
│           0x00400789      add rsp, 0x20
│           0x0040078d      pop rbx
│           0x0040078e      pop r12
│           0x00400790      pop rbp
└           0x00400791      ret
┌ (fcn) sym.decrypt_flag 112
│   sym.decrypt_flag ();
│           ; var int key @ rbp-0x14
│           ; var int i @ rbp-0x4
│           ; CALL XREF from sym.print_flag (0x400856)
│           0x00400696      push rbp
│           0x00400697      mov rbp, rsp
│           0x0040069a      mov dword [key], edi
│           0x0040069d      mov dword [i], 0
│       ┌─< 0x004006a4      jmp 0x4006fb
│      ┌──> 0x004006a6      mov eax, dword [i]
│      ⁝│   0x004006a9      cdqe
│      ⁝│   0x004006ab      movzx ecx, byte [rax + obj.flag]           ; [0x601080:1]=154
│      ⁝│   0x004006b2      mov eax, dword [i]
│      ⁝│   0x004006b5      cdq
│      ⁝│   0x004006b6      shr edx, 0x1e
│      ⁝│   0x004006b9      add eax, edx
│      ⁝│   0x004006bb      and eax, 3
│      ⁝│   0x004006be      sub eax, edx
│      ⁝│   0x004006c0      cdqe
│      ⁝│   0x004006c2      lea rdx, [key]
│      ⁝│   0x004006c6      add rax, rdx                               ; '('
│      ⁝│   0x004006c9      movzx eax, byte [rax]
│      ⁝│   0x004006cc      xor ecx, eax
│      ⁝│   0x004006ce      mov edx, ecx
│      ⁝│   0x004006d0      mov eax, dword [i]
│      ⁝│   0x004006d3      cdqe
│      ⁝│   0x004006d5      mov byte [rax + obj.flag], dl              ; [0x601080:1]=154
│      ⁝│   0x004006db      mov eax, dword [i]
│      ⁝│   0x004006de      cdq
│      ⁝│   0x004006df      shr edx, 0x1e
│      ⁝│   0x004006e2      add eax, edx
│      ⁝│   0x004006e4      and eax, 3
│      ⁝│   0x004006e7      sub eax, edx
│      ⁝│   0x004006e9      cmp eax, 3                                 ; 3
│     ┌───< 0x004006ec      jne 0x4006f7
│     │⁝│   0x004006ee      mov eax, dword [key]
│     │⁝│   0x004006f1      add eax, 1
│     │⁝│   0x004006f4      mov dword [key], eax
│     │⁝│   ; CODE XREF from sym.decrypt_flag (0x4006ec)
│     └───> 0x004006f7      add dword [i], 1
│      ⁝│   ; CODE XREF from sym.decrypt_flag (0x4006a4)
│      ⁝└─> 0x004006fb      mov eax, dword [i]
│      ⁝    0x004006fe      cmp eax, 0x28                              ; '(' ; 40
│      └──< 0x00400701      jbe 0x4006a6
│           0x00400703      nop
│           0x00400704      pop rbp
└           0x00400705      ret
