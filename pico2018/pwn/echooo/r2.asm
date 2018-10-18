            ;-- eip:
┌ (fcn) main 350
│   main ();
│           ; var int local_9ch @ ebp-0x9c
│           ; var int flag_ptr @ ebp-0x98
│           ; var int gid @ ebp-0x94
│           ; var unsigned int file @ ebp-0x90
│           ; var int buf @ ebp-0x8c
│           ; var int flag @ ebp-0x4c
│           ; var int local_ch @ ebp-0xc
│           ; DATA XREF from entry0 (0x8048517)
│           0x080485fb      lea ecx, [esp + 4]                         ; 4
│           0x080485ff      and esp, 0xfffffff0
│           0x08048602      push dword [ecx - 4]
│           0x08048605      push ebp
│           0x08048606      mov ebp, esp
│           0x08048608      push ecx
│           0x08048609      sub esp, 0xa4
│           0x0804860f      mov eax, ecx
│           0x08048611      mov eax, dword [eax + 4]                   ; [0x4:4]=-1 ; 4
│           0x08048614      mov dword [local_9ch], eax
│           0x0804861a      mov eax, dword gs:[0x14]                   ; [0x14:4]=-1 ; 20
│           0x08048620      mov dword [local_ch], eax
│           0x08048623      xor eax, eax
│           0x08048625      mov eax, dword [obj.stdout]                ; [0x804a044:4]=0
│           0x0804862a      push 0
│           0x0804862c      push 2                                     ; 2
│           0x0804862e      push 0
│           0x08048630      push eax
│           0x08048631      call sym.imp.setvbuf
│           0x08048636      add esp, 0x10
│           0x08048639      lea eax, [flag]
│           0x0804863c      mov dword [flag_ptr], eax
│           0x08048642      call sym.imp.getegid
│           0x08048647      mov dword [gid], eax
│           0x0804864d      sub esp, 4
│           0x08048650      push dword [gid]
│           0x08048656      push dword [gid]
│           0x0804865c      push dword [gid]
│           0x08048662      call sym.imp.setresgid
│           0x08048667      add esp, 0x10
│           0x0804866a      sub esp, 4
│           0x0804866d      push 0x40                                  ; '@' ; 64
│           0x0804866f      push 0
│           0x08048671      lea eax, [buf]
│           0x08048677      push eax
│           0x08048678      call sym.imp.memset
│           0x0804867d      add esp, 0x10
│           0x08048680      sub esp, 4
│           0x08048683      push 0x40                                  ; '@' ; 64
│           0x08048685      push 0
│           0x08048687      lea eax, [buf]
│           0x0804868d      push eax
│           0x0804868e      call sym.imp.memset
│           0x08048693      add esp, 0x10
│           0x08048696      sub esp, 0xc
│           0x08048699      push str.Time_to_learn_about_Format_Strings ; 0x80487e0 ; "Time to learn about Format Strings!"
│           0x0804869e      call sym.imp.puts
│           0x080486a3      add esp, 0x10
│           0x080486a6      sub esp, 0xc
│           0x080486a9      push str.We_will_evaluate_any_format_string_you_give_us_with_printf__. ; 0x8048804 ; "We will evaluate any format string you give us with printf()."
│           0x080486ae      call sym.imp.puts
│           0x080486b3      add esp, 0x10
│           0x080486b6      sub esp, 0xc
│           0x080486b9      push str.See_if_you_can_get_the_flag       ; 0x8048842 ; "See if you can get the flag!"
│           0x080486be      call sym.imp.puts
│           0x080486c3      add esp, 0x10
│           0x080486c6      sub esp, 8
│           0x080486c9      push 0x804885f
│           0x080486ce      push str.flag.txt                          ; 0x8048861 ; "flag.txt"
│           0x080486d3      call sym.imp.fopen
│           0x080486d8      add esp, 0x10
│           0x080486db      mov dword [file], eax
│           0x080486e1      cmp dword [file], 0
│       ┌─< 0x080486e8      jne 0x8048704
│       │   0x080486ea      sub esp, 0xc
│       │   0x080486ed      push str.Flag_File_is_Missing._Problem_is_Misconfigured__please_contact_an_Admin_if_you_are_running_this_on_the_shell_server. ; 0x804886c ; "Flag File is Missing. Problem is Misconfigured, please contact an Admin if you are running this on the shell server."
│       │   0x080486f2      call sym.imp.puts
│       │   0x080486f7      add esp, 0x10
│       │   0x080486fa      sub esp, 0xc
│       │   0x080486fd      push 0
│       │   0x080486ff      call sym.imp.exit
│       │   ; CODE XREF from main (0x80486e8)
│       └─> 0x08048704      sub esp, 4
│           0x08048707      push dword [file]
│           0x0804870d      push 0x40                                  ; '@' ; 64
│           0x0804870f      lea eax, [flag]
│           0x08048712      push eax
│           0x08048713      call sym.imp.fgets
└           0x08048718      add esp, 0x10
│           ; CODE XREF from main (0x8048757)
│       ┌─> 0x0804871b      sub esp, 0xc
│       ⁝   0x0804871e      push 0x80488e1
│       ⁝   0x08048723      call sym.imp.printf
│       ⁝   0x08048728      add esp, 0x10
│       ⁝   0x0804872b      mov eax, dword [sym.stdin]                 ; obj.stdin ; [0x804a040:4]=0
│       ⁝   0x08048730      sub esp, 4
│       ⁝   0x08048733      push eax
│       ⁝   0x08048734      push 0x40                                  ; '@' ; 64
│       ⁝   0x08048736      lea eax, [buf]
│       ⁝   0x0804873c      push eax
│       ⁝   0x0804873d      call sym.imp.fgets
│       ⁝   0x08048742      add esp, 0x10
│       ⁝   0x08048745      sub esp, 0xc
│       ⁝   0x08048748      lea eax, [buf]
│       ⁝   0x0804874e      push eax
│       ⁝   0x0804874f      call sym.imp.printf
│       ⁝   0x08048754      add esp, 0x10
│       └─< 0x08048757      jmp 0x804871b
