┌ (fcn) main 962
│   main ();
│           ; var int argv @ rbp-0x240
│           ; var int argc @ rbp-0x234
│           ; var int level @ rbp-0x224
│           ; var int user @ rbp-0x220
│           ; var int arg @ rbp-0x218
│           ; var int buf @ rbp-0x210
│           ; var int canary @ rbp-0x8
│           0x00400aa5      push rbp
│           0x00400aa6      mov rbp, rsp
│           0x00400aa9      sub rsp, 0x240
│           0x00400ab0      mov dword [argc], edi
│           0x00400ab6      mov qword [argv], rsi
│           0x00400abd      mov rax, qword fs:[0x28]                   ; [0x28:8]=-1 ; '(' ; 40
│           0x00400ac6      mov qword [canary], rax
│           0x00400aca      xor eax, eax
│           0x00400acc      mov rax, qword [sym.stdout]                ; obj.stdout ; [0x6020b0:8]=0
│           0x00400ad3      mov esi, 0
│           0x00400ad8      mov rdi, rax
│           0x00400adb      call sym.imp.setbuf
│           0x00400ae0      mov eax, 0
│           0x00400ae5      call sym.menu
│           0x00400aea      mov qword [user], 0
│           ; XREFS: CODE 0x00400b68  CODE 0x00400b90  CODE 0x00400c72  CODE 0x00400d47  CODE 0x00400daa  CODE 0x00400e09  
│           ; XREFS: CODE 0x00400e46  
│ ┌┌┌┌┌┌┌─> 0x00400af5      mov edi, str.Enter_your_command:           ; 0x4010e0 ; "\nEnter your command:"
│ ⁝⁝⁝⁝⁝⁝⁝   0x00400afa      call sym.imp.puts
│ ⁝⁝⁝⁝⁝⁝⁝   0x00400aff      mov edi, 0x3e                              ; '>' ; 62
│ ⁝⁝⁝⁝⁝⁝⁝   0x00400b04      call sym.imp.putchar
│ ⁝⁝⁝⁝⁝⁝⁝   0x00400b09      mov edi, 0x20                              ; 32
│ ⁝⁝⁝⁝⁝⁝⁝   0x00400b0e      call sym.imp.putchar
│ ⁝⁝⁝⁝⁝⁝⁝   0x00400b13      mov rdx, qword [obj.stdin]                 ; [0x6020c0:8]=0
│ ⁝⁝⁝⁝⁝⁝⁝   0x00400b1a      lea rax, [buf]
│ ⁝⁝⁝⁝⁝⁝⁝   0x00400b21      mov esi, 0x200                             ; 512
│ ⁝⁝⁝⁝⁝⁝⁝   0x00400b26      mov rdi, rax
│ ⁝⁝⁝⁝⁝⁝⁝   0x00400b29      call sym.imp.fgets
│ ⁝⁝⁝⁝⁝⁝⁝   0x00400b2e      test rax, rax
│ ────────< 0x00400b31      je 0x400e4b
│ ⁝⁝⁝⁝⁝⁝⁝   0x00400b37      lea rax, [buf]
│ ⁝⁝⁝⁝⁝⁝⁝   0x00400b3e      mov edx, 4
│ ⁝⁝⁝⁝⁝⁝⁝   0x00400b43      mov esi, str.show                          ; 0x4010f5 ; "show"
│ ⁝⁝⁝⁝⁝⁝⁝   0x00400b48      mov rdi, rax
│ ⁝⁝⁝⁝⁝⁝⁝   0x00400b4b      call sym.imp.strncmp
│ ⁝⁝⁝⁝⁝⁝⁝   0x00400b50      test eax, eax
│ ────────< 0x00400b52      jne 0x400b95
│ ⁝⁝⁝⁝⁝⁝⁝   0x00400b54      cmp qword [user], 0
│ ────────< 0x00400b5c      jne 0x400b6a
│ ⁝⁝⁝⁝⁝⁝⁝   0x00400b5e      mov edi, str.Not_logged_in.                ; 0x4010fa ; "Not logged in."
│ ⁝⁝⁝⁝⁝⁝⁝   0x00400b63      call sym.imp.puts
│ └───────< 0x00400b68      jmp 0x400af5
│ ────────> 0x00400b6a      mov rax, qword [user]
│  ⁝⁝⁝⁝⁝⁝   0x00400b71      mov edx, dword [rax + 8]                   ; [0x8:4]=-1 ; 8
│  ⁝⁝⁝⁝⁝⁝   0x00400b74      mov rax, qword [user]
│  ⁝⁝⁝⁝⁝⁝   0x00400b7b      mov rax, qword [rax]
│  ⁝⁝⁝⁝⁝⁝   0x00400b7e      mov rsi, rax
│  ⁝⁝⁝⁝⁝⁝   0x00400b81      mov edi, str.Logged_in_as__s___u           ; 0x401109 ; "Logged in as %s [%u]\n"
│  ⁝⁝⁝⁝⁝⁝   0x00400b86      mov eax, 0
│  ⁝⁝⁝⁝⁝⁝   0x00400b8b      call sym.imp.printf
│  └──────< 0x00400b90      jmp 0x400af5
│ ────────> 0x00400b95      lea rax, [buf]
│   ⁝⁝⁝⁝⁝   0x00400b9c      mov edx, 5
│   ⁝⁝⁝⁝⁝   0x00400ba1      mov esi, str.login                         ; 0x40111f ; "login"
│   ⁝⁝⁝⁝⁝   0x00400ba6      mov rdi, rax
│   ⁝⁝⁝⁝⁝   0x00400ba9      call sym.imp.strncmp
│   ⁝⁝⁝⁝⁝   0x00400bae      test eax, eax
│  ┌──────< 0x00400bb0      jne 0x400c77
│  │⁝⁝⁝⁝⁝   0x00400bb6      cmp qword [user], 0
│ ┌───────< 0x00400bbe      je 0x400bcf
│ ││⁝⁝⁝⁝⁝   0x00400bc0      mov edi, str.Already_logged_in._Reset_first. ; 0x401128 ; "Already logged in. Reset first."
│ ││⁝⁝⁝⁝⁝   0x00400bc5      call sym.imp.puts
│ ────────< 0x00400bca      jmp 0x400e46
│ └───────> 0x00400bcf      lea rax, [buf]
│  │⁝⁝⁝⁝⁝   0x00400bd6      add rax, 6
│  │⁝⁝⁝⁝⁝   0x00400bda      mov esi, str.Invalid_command               ; 0x401148 ; "\n"
│  │⁝⁝⁝⁝⁝   0x00400bdf      mov rdi, rax
│  │⁝⁝⁝⁝⁝   0x00400be2      call sym.imp.strtok
│  │⁝⁝⁝⁝⁝   0x00400be7      mov qword [arg], rax
│  │⁝⁝⁝⁝⁝   0x00400bee      cmp qword [arg], 0
│ ┌───────< 0x00400bf6      jne 0x400c07
│ ││⁝⁝⁝⁝⁝   0x00400bf8      mov edi, 0x40114a
│ ││⁝⁝⁝⁝⁝   0x00400bfd      call sym.imp.puts
│ ────────< 0x00400c02      jmp 0x400e46
│ └───────> 0x00400c07      mov edi, 0x10                              ; 16
│  │⁝⁝⁝⁝⁝   0x00400c0c      call sym.imp.malloc
│  │⁝⁝⁝⁝⁝   0x00400c11      mov qword [user], rax
│  │⁝⁝⁝⁝⁝   0x00400c18      cmp qword [user], 0
│ ┌───────< 0x00400c20      jne 0x400c36
│ ││⁝⁝⁝⁝⁝   0x00400c22      mov edi, str.malloc___returned_NULL._Out_of_Memory ; 0x401160 ; "malloc() returned NULL. Out of Memory\n"
│ ││⁝⁝⁝⁝⁝   0x00400c27      call sym.imp.puts
│ ││⁝⁝⁝⁝⁝   0x00400c2c      mov edi, 0xffffffff                        ; -1
│ ││⁝⁝⁝⁝⁝   0x00400c31      call sym.imp.exit
│ └───────> 0x00400c36      mov rax, qword [arg]
│  │⁝⁝⁝⁝⁝   0x00400c3d      mov rdi, rax
│  │⁝⁝⁝⁝⁝   0x00400c40      mov eax, 0
│  │⁝⁝⁝⁝⁝   0x00400c45      call sym.imp.strdup
│  │⁝⁝⁝⁝⁝   0x00400c4a      cdqe
│  │⁝⁝⁝⁝⁝   0x00400c4c      mov rdx, rax
│  │⁝⁝⁝⁝⁝   0x00400c4f      mov rax, qword [user]
│  │⁝⁝⁝⁝⁝   0x00400c56      mov qword [rax], rdx
│  │⁝⁝⁝⁝⁝   0x00400c59      mov rax, qword [arg]
│  │⁝⁝⁝⁝⁝   0x00400c60      mov rsi, rax
│  │⁝⁝⁝⁝⁝   0x00400c63      mov edi, str.Logged_in_as___s              ; 0x401187 ; "Logged in as \"%s\"\n"
│  │⁝⁝⁝⁝⁝   0x00400c68      mov eax, 0
│  │⁝⁝⁝⁝⁝   0x00400c6d      call sym.imp.printf
│  │└─────< 0x00400c72      jmp 0x400af5
│  └──────> 0x00400c77      lea rax, [buf]
│    ⁝⁝⁝⁝   0x00400c7e      mov edx, 8
│    ⁝⁝⁝⁝   0x00400c83      mov esi, str.set_auth                      ; 0x40119a ; "set-auth"
│    ⁝⁝⁝⁝   0x00400c88      mov rdi, rax
│    ⁝⁝⁝⁝   0x00400c8b      call sym.imp.strncmp
│    ⁝⁝⁝⁝   0x00400c90      test eax, eax
│   ┌─────< 0x00400c92      jne 0x400d4c
│   │⁝⁝⁝⁝   0x00400c98      cmp qword [user], 0
│  ┌──────< 0x00400ca0      jne 0x400cb1
│  ││⁝⁝⁝⁝   0x00400ca2      mov edi, str.Login_first.                  ; 0x4011a3 ; "Login first."
│  ││⁝⁝⁝⁝   0x00400ca7      call sym.imp.puts
│ ┌───────< 0x00400cac      jmp 0x400e46
│ │└──────> 0x00400cb1      lea rax, [buf]
│ │ │⁝⁝⁝⁝   0x00400cb8      add rax, 9
│ │ │⁝⁝⁝⁝   0x00400cbc      mov esi, str.Invalid_command               ; 0x401148 ; "\n"
│ │ │⁝⁝⁝⁝   0x00400cc1      mov rdi, rax
│ │ │⁝⁝⁝⁝   0x00400cc4      call sym.imp.strtok
│ │ │⁝⁝⁝⁝   0x00400cc9      mov qword [arg], rax
│ │ │⁝⁝⁝⁝   0x00400cd0      cmp qword [arg], 0
│ │┌──────< 0x00400cd8      jne 0x400ce9
│ │││⁝⁝⁝⁝   0x00400cda      mov edi, 0x40114a
│ │││⁝⁝⁝⁝   0x00400cdf      call sym.imp.puts
│ ────────< 0x00400ce4      jmp 0x400e46
│ │└──────> 0x00400ce9      mov rax, qword [arg]
│ │ │⁝⁝⁝⁝   0x00400cf0      mov edx, 0xa
│ │ │⁝⁝⁝⁝   0x00400cf5      mov esi, 0
│ │ │⁝⁝⁝⁝   0x00400cfa      mov rdi, rax
│ │ │⁝⁝⁝⁝   0x00400cfd      call sym.imp.strtoul
│ │ │⁝⁝⁝⁝   0x00400d02      mov dword [level], eax
│ │ │⁝⁝⁝⁝   0x00400d08      cmp dword [level], 4                       ; [0x4:4]=-1 ; 4
│ │┌──────< 0x00400d0f      jbe 0x400d20
│ │││⁝⁝⁝⁝   0x00400d11      mov edi, str.Can_only_set_authorization_level_below_5 ; 0x4011b0 ; "Can only set authorization level below 5"
│ │││⁝⁝⁝⁝   0x00400d16      call sym.imp.puts
│ ────────< 0x00400d1b      jmp 0x400e46
│ │└──────> 0x00400d20      mov rax, qword [user]
│ │ │⁝⁝⁝⁝   0x00400d27      mov edx, dword [level]
│ │ │⁝⁝⁝⁝   0x00400d2d      mov dword [rax + 8], edx
│ │ │⁝⁝⁝⁝   0x00400d30      mov eax, dword [level]
│ │ │⁝⁝⁝⁝   0x00400d36      mov esi, eax
│ │ │⁝⁝⁝⁝   0x00400d38      mov edi, str.Set_authorization_level_to___u ; 0x4011e0 ; "Set authorization level to \"%u\"\n"
│ │ │⁝⁝⁝⁝   0x00400d3d      mov eax, 0
│ │ │⁝⁝⁝⁝   0x00400d42      call sym.imp.printf
│ │ │└────< 0x00400d47      jmp 0x400af5
│ │ └─────> 0x00400d4c      lea rax, [buf]
│ │   ⁝⁝⁝   0x00400d53      mov edx, 8
│ │   ⁝⁝⁝   0x00400d58      mov esi, str.get_flag                      ; 0x401201 ; "get-flag"
│ │   ⁝⁝⁝   0x00400d5d      mov rdi, rax
│ │   ⁝⁝⁝   0x00400d60      call sym.imp.strncmp
│ │   ⁝⁝⁝   0x00400d65      test eax, eax
│ │  ┌────< 0x00400d67      jne 0x400daf
│ │  │⁝⁝⁝   0x00400d69      cmp qword [user], 0
│ │ ┌─────< 0x00400d71      jne 0x400d82
│ │ ││⁝⁝⁝   0x00400d73      mov edi, str.Login_first                   ; 0x40120a ; "Login first!"
│ │ ││⁝⁝⁝   0x00400d78      call sym.imp.puts
│ │┌──────< 0x00400d7d      jmp 0x400e46
│ ││└─────> 0x00400d82      mov rax, qword [user]
│ ││ │⁝⁝⁝   0x00400d89      mov eax, dword [rax + 8]                   ; [0x8:4]=-1 ; 8
│ ││ │⁝⁝⁝   0x00400d8c      cmp eax, 5                                 ; 5
│ ││┌─────< 0x00400d8f      je 0x400da0
│ ││││⁝⁝⁝   0x00400d91      mov edi, str.Must_have_authorization_level_5. ; 0x401218 ; "Must have authorization level 5."
│ ││││⁝⁝⁝   0x00400d96      call sym.imp.puts
│ ────────< 0x00400d9b      jmp 0x400e46
│ ││└─────> 0x00400da0      mov eax, 0
│ ││ │⁝⁝⁝   0x00400da5      call sym.give_flag
│ ││ │└───< 0x00400daa      jmp 0x400af5
│ ││ └────> 0x00400daf      lea rax, [buf]
│ ││   ⁝⁝   0x00400db6      mov edx, 5
│ ││   ⁝⁝   0x00400dbb      mov esi, str.reset                         ; 0x401239 ; "reset"
│ ││   ⁝⁝   0x00400dc0      mov rdi, rax
│ ││   ⁝⁝   0x00400dc3      call sym.imp.strncmp
│ ││   ⁝⁝   0x00400dc8      test eax, eax
│ ││  ┌───< 0x00400dca      jne 0x400e0e
│ ││  │⁝⁝   0x00400dcc      cmp qword [user], 0
│ ││ ┌────< 0x00400dd4      jne 0x400de2
│ ││ ││⁝⁝   0x00400dd6      mov edi, str.Not_logged_in                 ; 0x40123f ; "Not logged in!"
│ ││ ││⁝⁝   0x00400ddb      call sym.imp.puts
│ ││┌─────< 0x00400de0      jmp 0x400e46
│ │││└────> 0x00400de2      mov rax, qword [user]
│ │││ │⁝⁝   0x00400de9      mov rax, qword [rax]
│ │││ │⁝⁝   0x00400dec      mov rdi, rax
│ │││ │⁝⁝   0x00400def      call sym.imp.free
│ │││ │⁝⁝   0x00400df4      mov qword [user], 0
│ │││ │⁝⁝   0x00400dff      mov edi, str.Logged_out                    ; 0x40124e ; "Logged out!"
│ │││ │⁝⁝   0x00400e04      call sym.imp.puts
│ │││ │└──< 0x00400e09      jmp 0x400af5
│ │││ └───> 0x00400e0e      lea rax, [buf]
│ │││   ⁝   0x00400e15      mov edx, 4
│ │││   ⁝   0x00400e1a      mov esi, str.quit                          ; 0x40125a ; "quit"
│ │││   ⁝   0x00400e1f      mov rdi, rax
│ │││   ⁝   0x00400e22      call sym.imp.strncmp
│ │││   ⁝   0x00400e27      test eax, eax
│ │││  ┌──< 0x00400e29      jne 0x400e32
│ │││  │⁝   0x00400e2b      mov eax, 0
│ │││ ┌───< 0x00400e30      jmp 0x400e51
│ │││ │└──> 0x00400e32      mov edi, str.Invalid_option                ; 0x40125f ; "Invalid option"
│ │││ │ ⁝   0x00400e37      call sym.imp.puts
│ │││ │ ⁝   0x00400e3c      mov eax, 0
│ │││ │ ⁝   0x00400e41      call sym.menu
│ │││ │ │   ; XREFS: CODE 0x00400bca  CODE 0x00400c02  CODE 0x00400cac  CODE 0x00400ce4  CODE 0x00400d1b  CODE 0x00400d7d  
│ │││ │ │   ; XREFS: CODE 0x00400d9b  CODE 0x00400de0  
│ └└└───└─< 0x00400e46      jmp 0x400af5
│ ────────> 0x00400e4b      nop
│     │     0x00400e4c      mov eax, 0
│     │     ; CODE XREF from main (0x400e30)
│     └───> 0x00400e51      mov rcx, qword [canary]
│           0x00400e55      xor rcx, qword fs:[0x28]
│       ┌─< 0x00400e5e      je 0x400e65
│       │   0x00400e60      call sym.imp.__stack_chk_fail
│       └─> 0x00400e65      leave
└           0x00400e66      ret
