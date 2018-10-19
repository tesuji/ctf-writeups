┌ (fcn) sym.vuln 240
│   sym.vuln ();
│           ; var int count @ ebp-0x54
│           ; var int length_buf @ ebp-0x50
│           ; var int buf @ ebp-0x30
│           ; var int canary @ ebp-0x10
│           ; var signed int x @ ebp-0xc
│           ; CALL XREF from sym.main (0x80488f9)
│           0x080487c3      push ebp
│           0x080487c4      mov ebp, esp
│           0x080487c6      sub esp, 0x58                              ; 'X'
│           0x080487c9      mov dword [x], 0
│           0x080487d0      mov eax, dword [obj.global_canary]         ; [0x804a058:4]=0
│           0x080487d5      mov dword [canary], eax
│           0x080487d8      sub esp, 0xc
│           0x080487db      push str.How_Many_Bytes_will_You_Write_Into_the_Buffer ; 0x8048a90 ; "How Many Bytes will You Write Into the Buffer?\n> "
│           0x080487e0      call sym.imp.printf
│           0x080487e5      add esp, 0x10
│       ┌─< 0x080487e8      jmp 0x8048815
│       │   ; CODE XREF from sym.vuln (0x8048819)
│      ┌──> 0x080487ea      mov eax, dword [x]
│      ⁝│   0x080487ed      lea edx, [length_buf]
│      ⁝│   0x080487f0      add eax, edx
│      ⁝│   0x080487f2      sub esp, 4
│      ⁝│   0x080487f5      push 1                                     ; 1
│      ⁝│   0x080487f7      push eax
│      ⁝│   0x080487f8      push 0
│      ⁝│   0x080487fa      call sym.imp.read
│      ⁝│   0x080487ff      add esp, 0x10
│      ⁝│   0x08048802      lea edx, [length_buf]
│      ⁝│   0x08048805      mov eax, dword [x]
│      ⁝│   0x08048808      add eax, edx
│      ⁝│   0x0804880a      movzx eax, byte [eax]
│      ⁝│   0x0804880d      cmp al, 0xa                                ; 10
│     ┌───< 0x0804880f      je 0x804881d
│     │⁝│   0x08048811      add dword [x], 1
│     │⁝│   ; CODE XREF from sym.vuln (0x80487e8)
│     │⁝└─> 0x08048815      cmp dword [x], 0x1f                        ; [0x1f:4]=-1 ; 31
│     │└──< 0x08048819      jle 0x80487ea
│     │ ┌─< 0x0804881b      jmp 0x804881e
│     │ │   ; CODE XREF from sym.vuln (0x804880f)
│     └───> 0x0804881d      nop
│       │   ; CODE XREF from sym.vuln (0x804881b)
│       └─> 0x0804881e      sub esp, 4
│           0x08048821      lea eax, [count]
│           0x08048824      push eax
│           0x08048825      push 0x8048ac2
│           0x0804882a      lea eax, [length_buf]
│           0x0804882d      push eax
│           0x0804882e      call sym.imp.__isoc99_sscanf
│           0x08048833      add esp, 0x10
│           0x08048836      sub esp, 0xc
│           0x08048839      push str.Input                             ; 0x8048ac5 ; "Input> "
│           0x0804883e      call sym.imp.printf
│           0x08048843      add esp, 0x10
│           0x08048846      mov eax, dword [count]
│           0x08048849      sub esp, 4
│           0x0804884c      push eax
│           0x0804884d      lea eax, [buf]
│           0x08048850      push eax
│           0x08048851      push 0
│           0x08048853      call sym.imp.read
│           0x08048858      add esp, 0x10
│           0x0804885b      sub esp, 4
│           0x0804885e      push 4                                     ; 4
│           0x08048860      push obj.global_canary                     ; 0x804a058
│           0x08048865      lea eax, [canary]
│           0x08048868      push eax
│           0x08048869      call sym.imp.memcmp
│           0x0804886e      add esp, 0x10
│           0x08048871      test eax, eax
│       ┌─< 0x08048873      je 0x804888f
│       │   0x08048875      sub esp, 0xc
│       │   0x08048878      push str.Stack_Smashing_Detected_____:_Canary_Value_Corrupt ; 0x8048ad0 ; "*** Stack Smashing Detected *** : Canary Value Corrupt!"
│       │   0x0804887d      call sym.imp.puts
│       │   0x08048882      add esp, 0x10
│       │   0x08048885      sub esp, 0xc
│       │   0x08048888      push 0xffffffffffffffff
│       │   0x0804888a      call sym.imp.exit
│       │   ; CODE XREF from sym.vuln (0x8048873)
│       └─> 0x0804888f      sub esp, 0xc
│           0x08048892      push str.Ok..._Now_Where_s_the_Flag        ; 0x8048b08 ; "Ok... Now Where's the Flag?"
│           0x08048897      call sym.imp.puts
│           0x0804889c      add esp, 0x10
│           0x0804889f      mov eax, dword [sym.stdout]                ; obj.stdout ; [0x804a050:4]=0
│           0x080488a4      sub esp, 0xc
│           0x080488a7      push eax
│           0x080488a8      call sym.imp.fflush
│           0x080488ad      add esp, 0x10
│           0x080488b0      nop
│           0x080488b1      leave
└           0x080488b2      ret
