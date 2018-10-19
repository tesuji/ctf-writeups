            ;-- main:
┌ (fcn) sym.main 83
│   sym.main ();
│           ; var int gid @ ebp-0xc
│           0x08048643      lea ecx, [esp + 4]                         ; 4
│           0x08048647      and esp, 0xfffffff0
│           0x0804864a      push dword [ecx - 4]
│           0x0804864d      push ebp
│           0x0804864e      mov ebp, esp
│           0x08048650      push ecx
│           0x08048651      sub esp, 0x14
│           0x08048654      mov eax, dword [sym.stdout]                ; obj.stdout ; [0x804a038:4]=0
│           0x08048659      push 0
│           0x0804865b      push 2                                     ; 2
│           0x0804865d      push 0
│           0x0804865f      push eax
│           0x08048660      call sym.imp.setvbuf
│           0x08048665      add esp, 0x10
│           0x08048668      call sym.imp.getegid
│           0x0804866d      mov dword [gid], eax
│           0x08048670      sub esp, 4
│           0x08048673      push dword [gid]
│           0x08048676      push dword [gid]
│           0x08048679      push dword [gid]
│           0x0804867c      call sym.imp.setresgid
│           0x08048681      add esp, 0x10
│           0x08048684      call sym.vuln
│           0x08048689      mov eax, 0
│           0x0804868e      mov ecx, dword [ebp - 4]
│           0x08048691      leave
│           0x08048692      lea esp, [ecx - 4]
└           0x08048695      ret
┌ (fcn) sym.vuln 152
│   sym.vuln ();
│           ; var int buf @ ebp-0x8c
│           ; var int canary @ ebp-0xc
│           ; CALL XREF from sym.main (0x8048684)
│           0x080485ab      push ebp
│           0x080485ac      mov ebp, esp
│           0x080485ae      push edi
│           0x080485af      sub esp, 0x94
│           0x080485b5      mov eax, dword gs:[0x14]                   ; [0x14:4]=-1 ; 20
│           0x080485bb      mov dword [canary], eax
│           0x080485be      xor eax, eax
│           0x080485c0      lea edx, [buf]
│           0x080485c6      mov eax, 0
│           0x080485cb      mov ecx, 0x20                              ; 32
│           0x080485d0      mov edi, edx
│           0x080485d2      rep stosd dword es:[edi], eax
│           0x080485d4      sub esp, 0xc
│           0x080485d7      push str.echo_input_your_message:          ; 0x8048720 ; "echo input your message:"
│           0x080485dc      call sym.imp.system
│           0x080485e1      add esp, 0x10
│           0x080485e4      sub esp, 4
│           0x080485e7      push 0x7f                                  ; 127
│           0x080485e9      lea eax, [buf]
│           0x080485ef      push eax
│           0x080485f0      push 0
│           0x080485f2      call sym.imp.read
│           0x080485f7      add esp, 0x10
│           0x080485fa      sub esp, 0xc
│           0x080485fd      lea eax, [buf]
│           0x08048603      push eax
│           0x08048604      call sym.imp.printf
│           0x08048609      add esp, 0x10
│           0x0804860c      sub esp, 0xc
│           0x0804860f      push 0x8048739
│           0x08048614      call sym.imp.puts
│           0x08048619      add esp, 0x10
│           0x0804861c      sub esp, 0xc
│           0x0804861f      push str.Thanks_for_sending_the_message    ; 0x804873c ; "Thanks for sending the message!"
│           0x08048624      call sym.imp.puts
│           0x08048629      add esp, 0x10
│           0x0804862c      nop
│           0x0804862d      mov eax, dword [canary]
│           0x08048630      xor eax, dword gs:[0x14]
│       ┌─< 0x08048637      je 0x804863e
│       │   0x08048639      call sym.imp.__stack_chk_fail
│       └─> 0x0804863e      mov edi, dword [ebp - 4]
│           0x08048641      leave
└           0x08048642      ret
