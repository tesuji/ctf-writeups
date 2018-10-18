            ;-- main:
┌ (fcn) sym.main 226
│   sym.main ();
│           ; var void (*)(void) location @ rbp-0x1018
│           ; var char[0x1000] buffer @ rbp-0x1010
│           ; var int canary @ rbp-0x8
│           0x004009e5      push rbp
│           0x004009e6      mov rbp, rsp
│           0x004009e9      sub rsp, 0x1020
│           0x004009f0      mov rax, qword fs:[0x28]                   ; [0x28:8]=-1 ; '(' ; 40
│           0x004009f9      mov qword [canary], rax
│           0x004009fd      xor eax, eax
│           0x004009ff      mov rax, qword [sym.stdout]                ; loc.stdout ; [0x601080:8]=0
│           0x00400a06      mov esi, 0
│           0x00400a0b      mov rdi, rax
│           0x00400a0e      call sym.imp.setbuf
│           0x00400a13      lea rax, [buffer]
│           0x00400a1a      mov edi, eax
│           0x00400a1c      call sym.imp.srand
│           0x00400a21      mov eax, 0
│           0x00400a26      call sym.initialize
│           0x00400a2b      mov eax, 0
│           0x00400a30      call sym.acquire_satellites
│           0x00400a35      mov eax, 0
│           0x00400a3a      call sym.query_position
│           0x00400a3f      mov rsi, rax
│           0x00400a42      mov edi, str.We_need_to_access_flag.txt.__Current_position:__p ; 0x400be8 ; "We need to access flag.txt.\nCurrent position: %p\n"
│           0x00400a47      mov eax, 0
│           0x00400a4c      call sym.imp.printf
│           0x00400a51      mov edi, str.What_s_your_plan              ; 0x400c1a ; "What's your plan?\n> "
│           0x00400a56      mov eax, 0
│           0x00400a5b      call sym.imp.printf
│           0x00400a60      mov rdx, qword [obj.stdin]                 ; [0x601090:8]=0
│           0x00400a67      lea rax, [buffer]
│           0x00400a6e      mov esi, 0x1000
│           0x00400a73      mov rdi, rax
│           0x00400a76      call sym.imp.fgets
│           0x00400a7b      mov edi, str.Where_do_we_start             ; 0x400c2f ; "Where do we start?\n> "
│           0x00400a80      mov eax, 0
│           0x00400a85      call sym.imp.printf
│           0x00400a8a      lea rax, [location]
│           0x00400a91      mov rsi, rax
│           0x00400a94      mov edi, 0x400c45
│           0x00400a99      mov eax, 0
│           0x00400a9e      call sym.imp.__isoc99_scanf
│           0x00400aa3      mov rax, qword [location]
│           0x00400aaa      call rax
│           0x00400aac      mov eax, 0
│           0x00400ab1      mov rcx, qword [canary]
│           0x00400ab5      xor rcx, qword fs:[0x28]
│       ┌─< 0x00400abe      je 0x400ac5
│       │   0x00400ac0      call sym.imp.__stack_chk_fail
│       └─> 0x00400ac5      leave
└           0x00400ac6      ret
┌ (fcn) sym.query_position 111
│   sym.query_position ();
│           ; var char stk @ rbp-0x15
│           ; var int offset @ rbp-0x14
│           ; var void *ret @ rbp-0x10
│           ; var int canary @ rbp-0x8
│           ; CALL XREF from sym.main (0x400a3a)
│           0x00400976      push rbp
│           0x00400977      mov rbp, rsp
│           0x0040097a      sub rsp, 0x20
│           0x0040097e      mov rax, qword fs:[0x28]                   ; [0x28:8]=-1 ; '(' ; 40
│           0x00400987      mov qword [canary], rax
│           0x0040098b      xor eax, eax
│           0x0040098d      call sym.imp.rand
│           0x00400992      mov ecx, eax
│           0x00400994      mov edx, 0x6208cecb
│           0x00400999      mov eax, ecx
│           0x0040099b      imul edx
│           0x0040099d      sar edx, 9
│           0x004009a0      mov eax, ecx
│           0x004009a2      sar eax, 0x1f
│           0x004009a5      sub edx, eax
│           0x004009a7      mov eax, edx
│           0x004009a9      imul eax, eax, 1337
│           0x004009af      sub ecx, eax
│           0x004009b1      mov eax, ecx
│           0x004009b3      sub eax, 668
│           0x004009b8      mov dword [offset], eax
│           0x004009bb      mov eax, dword [offset]
│           0x004009be      cdqe
│           0x004009c0      lea rdx, [stk]
│           0x004009c4      add rax, rdx                               ; '('
│           0x004009c7      mov qword [ret], rax
│           0x004009cb      mov rax, qword [ret]
│           0x004009cf      mov rsi, qword [canary]
│           0x004009d3      xor rsi, qword fs:[0x28]
│       ┌─< 0x004009dc      je 0x4009e3
│       │   0x004009de      call sym.imp.__stack_chk_fail
│       └─> 0x004009e3      leave
└           0x004009e4      ret
