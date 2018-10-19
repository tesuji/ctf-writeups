            ;-- main:
┌ (fcn) sym.main 158
│   sym.main ();
│           ; var int buf @ ebp-0x10
│           ; var int len @ ebp-0xc
│           ; var int local_4h @ ebp-0x4
│           ; DATA XREF from entry0 (0x8048467)
│           0x080486f6      lea ecx, [esp + 4]                         ; 4
│           0x080486fa      and esp, 0xfffffff0
│           0x080486fd      push dword [ecx - 4]
│           0x08048700      push ebp
│           0x08048701      mov ebp, esp
│           0x08048703      push ecx
│           0x08048704      sub esp, 0x14
│           0x08048707      sub esp, 0xc
│           0x0804870a      push str.We_re_moving_along_swimmingly._Is_this_one_too_fowl_for_you ; 0x8048884 ; "We're moving along swimmingly. Is this one too fowl for you?"
│           0x0804870f      call sym.imp.puts
│           0x08048714      add esp, 0x10
│           0x08048717      sub esp, 0xc
│           0x0804871a      push str.Enter_text_to_encrypt:            ; 0x80488c1 ; "Enter text to encrypt: "
│           0x0804871f      call sym.imp.printf
│           0x08048724      add esp, 0x10
│           0x08048727      call sym.read_input
│           0x0804872c      mov dword [buf], eax
│           0x0804872f      sub esp, 0xc
│           0x08048732      push dword [buf]
│           0x08048735      call sym.encrypt
│           0x0804873a      add esp, 0x10
│           0x0804873d      mov dword [len], eax
│           0x08048740      sub esp, 0xc
│           0x08048743      push str.Here_s_your_ciphertext:           ; 0x80488d9 ; "Here's your ciphertext: "
│           0x08048748      call sym.imp.printf
│           0x0804874d      add esp, 0x10
│           0x08048750      sub esp, 8
│           0x08048753      push dword [len]
│           0x08048756      push dword [buf]
│           0x08048759      call sym.print_hex
│           0x0804875e      add esp, 0x10
│           0x08048761      mov eax, dword obj.encryptedBuffer         ; [0x804a030:4]=0x8048820 str.11_80_20_E0_22_53_72_A1_01_41_55_20_A0_C0_25_E3_35_40_55_30_85_55_70_20_C1 ; " \x88\x04\b"
│           0x08048766      sub esp, 8
│           0x08048769      push eax
│           0x0804876a      push str.Now_quack_it__:__s                ; 0x80488f2 ; "Now quack it! : %s\n"
│           0x0804876f      call sym.imp.printf
│           0x08048774      add esp, 0x10
│           0x08048777      sub esp, 0xc
│           0x0804877a      push str.That_s_all_folks.                 ; 0x8048906 ; "That's all folks."
│           0x0804877f      call sym.imp.puts
│           0x08048784      add esp, 0x10
│           0x08048787      mov eax, 0
│           0x0804878c      mov ecx, dword [local_4h]
│           0x0804878f      leave
│           0x08048790      lea esp, [ecx - 4]
└           0x08048793      ret
┌ (fcn) sym.read_input 117
│   sym.read_input ();
│           ; var char *line @ ebp-0x18
│           ; var size_t len @ ebp-0x14
│           ; var ssize_t nread @ ebp-0x10
│           ; var int carary @ ebp-0xc
│           ; CALL XREF from sym.do_magic (0x80485c6)
│           ; CALL XREF from sym.main (0x8048727)
│           0x0804854b      push ebp
│           0x0804854c      mov ebp, esp
│           0x0804854e      sub esp, 0x18
│           0x08048551      mov eax, dword gs:[0x14]                   ; [0x14:4]=-1 ; 20
│           0x08048557      mov dword [carary], eax
│           0x0804855a      xor eax, eax
│           0x0804855c      mov dword [line], 0
│           0x08048563      mov eax, dword [sym.stdin]                 ; obj.stdin ; [0x804a040:4]=0
│           0x08048568      sub esp, 4
│           0x0804856b      push eax
│           0x0804856c      lea eax, [len]
│           0x0804856f      push eax
│           0x08048570      lea eax, [line]
│           0x08048573      push eax
│           0x08048574      call sym.imp.getline
│           0x08048579      add esp, 0x10
│           0x0804857c      mov dword [nread], eax
│           0x0804857f      cmp dword [nread], 0xffffffffffffffff
│       ┌─< 0x08048583      je 0x8048598
│       │   0x08048585      mov eax, dword [line]
│       │   0x08048588      mov edx, dword [nread]
│       │   0x0804858b      sub edx, 1
│       │   0x0804858e      add eax, edx
│       │   0x08048590      mov byte [eax], 0
│       │   0x08048593      mov eax, dword [line]
│      ┌──< 0x08048596      jmp 0x80485ad
│      ││   ; CODE XREF from sym.read_input (0x8048583)
│      │└─> 0x08048598      sub esp, 0xc
│      │    0x0804859b      push str.No_line_read...                   ; 0x804886b ; "No line read..."
│      │    0x080485a0      call sym.imp.puts
│      │    0x080485a5      add esp, 0x10
│      │    0x080485a8      mov eax, 0x804887b
│      │    ; CODE XREF from sym.read_input (0x8048596)
│      └──> 0x080485ad      mov ecx, dword [carary]
│           0x080485b0      xor ecx, dword gs:[0x14]
│       ┌─< 0x080485b7      je 0x80485be
│       │   0x080485b9      call sym.imp.__stack_chk_fail
│       │   ; CODE XREF from sym.read_input (0x80485b7)
│       └─> 0x080485be      leave
└           0x080485bf      ret
┌ (fcn) sym.encrypt 119
│   sym.encrypt (char *buf);
│           ; var char ch @ ebp-0x11
│           ; var int i @ ebp-0x10
│           ; var size_t len @ ebp-0xc
│           ; arg char *buf @ ebp+0x8
│           ; CALL XREF from sym.main (0x8048735)
│           0x0804867f      push ebp
│           0x08048680      mov ebp, esp
│           0x08048682      sub esp, 0x18
│           0x08048685      sub esp, 0xc
│           0x08048688      push dword [buf]
│           0x0804868b      call sym.imp.strlen
│           0x08048690      add esp, 0x10
│           0x08048693      mov dword [len], eax
│           0x08048696      mov dword [i], 0
│       ┌─< 0x0804869d      jmp 0x80486e9
│       │   ; CODE XREF from sym.encrypt (0x80486ef)
│      ┌──> 0x0804869f      mov edx, dword [i]
│      ⁝│   0x080486a2      mov eax, dword [buf]                       ; [0x8:4]=-1 ; 8
│      ⁝│   0x080486a5      add eax, edx
│      ⁝│   0x080486a7      movzx eax, byte [eax]
│      ⁝│   0x080486aa      mov byte [ch], al
│      ⁝│   0x080486ad      movsx eax, byte [ch]
│      ⁝│   0x080486b1      sub esp, 0xc
│      ⁝│   0x080486b4      push eax
│      ⁝│   0x080486b5      call sym.rol4
│      ⁝│   0x080486ba      add esp, 0x10
│      ⁝│   0x080486bd      mov byte [ch], al
│      ⁝│   0x080486c0      xor byte [ch], 0x16
│      ⁝│   0x080486c4      movsx eax, byte [ch]
│      ⁝│   0x080486c8      sub esp, 0xc
│      ⁝│   0x080486cb      push eax
│      ⁝│   0x080486cc      call sym.ror8
│      ⁝│   0x080486d1      add esp, 0x10
│      ⁝│   0x080486d4      mov byte [ch], al
│      ⁝│   0x080486d7      mov edx, dword [i]
│      ⁝│   0x080486da      mov eax, dword [buf]                       ; [0x8:4]=-1 ; 8
│      ⁝│   0x080486dd      add edx, eax
│      ⁝│   0x080486df      movzx eax, byte [ch]
│      ⁝│   0x080486e3      mov byte [edx], al
│      ⁝│   0x080486e5      add dword [i], 1
│      ⁝│   ; CODE XREF from sym.encrypt (0x804869d)
│      ⁝└─> 0x080486e9      mov eax, dword [i]
│      ⁝    0x080486ec      cmp eax, dword [len]
│      └──< 0x080486ef      jl 0x804869f
│           0x080486f1      mov eax, dword [len]
│           0x080486f4      leave
└           0x080486f5      ret
┌ (fcn) sym.rol4 39
│   sym.rol4 (int ch);
│           ; var int c @ ebp-0x14
│           ; var char rs @ ebp-0x1
│           ; arg int ch @ ebp+0x8
│           ; CALL XREF from sym.encrypt (0x80486b5)
│           0x080485d1      push ebp
│           0x080485d2      mov ebp, esp
│           0x080485d4      sub esp, 0x14
│           0x080485d7      mov eax, dword [ch]                        ; [0x8:4]=-1 ; 8
│           0x080485da      mov byte [c], al
│           0x080485dd      movzx eax, byte [c]
│           0x080485e1      mov byte [rs], al
│           0x080485e4      movzx edx, byte [c]
│           0x080485e8      mov al, dl
│           0x080485ea      rol al, 4
│           0x080485ed      mov dl, al
│           0x080485ef      mov byte [rs], dl
│           0x080485f2      movzx eax, byte [rs]
│           0x080485f6      leave
└           0x080485f7      ret
┌ (fcn) sym.ror8 39
│   sym.ror8 (int ch);
│           ; var int c @ ebp-0x14
│           ; var char rs @ ebp-0x1
│           ; arg int ch @ ebp+0x8
│           ; CALL XREF from sym.encrypt (0x80486cc)
│           0x080485f8      push ebp
│           0x080485f9      mov ebp, esp
│           0x080485fb      sub esp, 0x14
│           0x080485fe      mov eax, dword [ch]                        ; [0x8:4]=-1 ; 8
│           0x08048601      mov byte [c], al
│           0x08048604      movzx eax, byte [c]
│           0x08048608      mov byte [rs], al
│           0x0804860b      movzx edx, byte [c]
│           0x0804860f      mov al, dl
│           0x08048611      ror al, 8
│           0x08048614      mov dl, al
│           0x08048616      mov byte [rs], dl
│           0x08048619      movzx eax, byte [rs]
│           0x0804861d      leave
└           0x0804861e      ret
