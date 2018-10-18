┌ (fcn) main 375
│   main ();
│           ; var int bet @ ebp-0x10
│           ; var int choice @ ebp-0xc
│           0x08048d2f      lea ecx, [esp + 4]                         ; 4
│           0x08048d33      and esp, 0xfffffff0
│           0x08048d36      push dword [ecx - 4]
│           0x08048d39      push ebp
│           0x08048d3a      mov ebp, esp
│           0x08048d3c      push ecx
│           0x08048d3d      sub esp, 0x14
│           0x08048d40      mov eax, dword [sym.stdout]                ; obj.stdout ; [0x804b0d0:4]=0
│           0x08048d45      push 0
│           0x08048d47      push 2                                     ; 2
│           0x08048d49      push 0
│           0x08048d4b      push eax
│           0x08048d4c      call sym.imp.setvbuf
│           0x08048d51      add esp, 0x10
│           0x08048d54      call sym.get_rand
│           0x08048d59      mov dword [obj.cash], eax                  ; [0x804b0d8:4]=0
│           0x08048d5e      sub esp, 0xc
│           0x08048d61      push str.Welcome_to_ONLINE_ROULETTE        ; 0x8049201 ; "Welcome to ONLINE ROULETTE!"
│           0x08048d66      call sym.imp.puts
│           0x08048d6b      add esp, 0x10
│           0x08048d6e      mov eax, dword [obj.cash]                  ; [0x804b0d8:4]=0
│           0x08048d73      sub esp, 8
│           0x08048d76      push eax
│           0x08048d77      push str.Here__have___ld_to_start_on_the_house__You_ll_lose_it_all_anyways__: ; 0x8049220 ; "Here, have $%ld to start on the house! You'll lose it all anyways >:)\n"
│           0x08048d7c      call sym.imp.printf
│           0x08048d81      add esp, 0x10
│           0x08048d84      sub esp, 0xc
│           0x08048d87      push 0x80491b3
│           0x08048d8c      call sym.imp.puts
│           0x08048d91      add esp, 0x10
│       ┌─< 0x08048d94      jmp 0x8048e7c
│      ┌──> 0x08048d99      call sym.get_bet
│      ⁝│   0x08048d9e      mov dword [bet], eax
│      ⁝│   0x08048da1      mov eax, dword [obj.cash]                  ; [0x804b0d8:4]=0
│      ⁝│   0x08048da6      sub eax, dword [bet]
│      ⁝│   0x08048da9      mov dword [obj.cash], eax                  ; [0x804b0d8:4]=0
│      ⁝│   0x08048dae      call sym.get_choice
│      ⁝│   0x08048db3      mov dword [choice], eax
│      ⁝│   0x08048db6      sub esp, 0xc
│      ⁝│   0x08048db9      push 0x80491b3
│      ⁝│   0x08048dbe      call sym.imp.puts
│      ⁝│   0x08048dc3      add esp, 0x10
│      ⁝│   0x08048dc6      sub esp, 8
│      ⁝│   0x08048dc9      push dword [bet]
│      ⁝│   0x08048dcc      push dword [choice]
│      ⁝│   0x08048dcf      call sym.play_roulette
│      ⁝│   0x08048dd4      add esp, 0x10
│      ⁝│   0x08048dd7      mov eax, dword [obj.wins]                  ; [0x804b0dc:4]=0
│      ⁝│   0x08048ddc      cmp eax, 0xf                               ; 15
│     ┌───< 0x08048ddf      jle 0x8048e17
│     │⁝│   0x08048de1      mov eax, dword [obj.wins]                  ; [0x804b0dc:4]=0
│     │⁝│   0x08048de6      sub esp, 8
│     │⁝│   0x08048de9      push eax
│     │⁝│   0x08048dea      push str.Wow_you_won__lu_times__Looks_like_its_time_for_you_cash_you_out. ; 0x8049268 ; "Wow you won %lu times? Looks like its time for you cash you out.\n"
│     │⁝│   0x08048def      call sym.imp.printf
│     │⁝│   0x08048df4      add esp, 0x10
│     │⁝│   0x08048df7      mov eax, dword [obj.cash]                  ; [0x804b0d8:4]=0
│     │⁝│   0x08048dfc      sub esp, 8
│     │⁝│   0x08048dff      push eax
│     │⁝│   0x08048e00      push str.Congrats_you_made___lu._See_you_next_time ; 0x80492ac ; "Congrats you made $%lu. See you next time!\n"
│     │⁝│   0x08048e05      call sym.imp.printf
│     │⁝│   0x08048e0a      add esp, 0x10
│     │⁝│   0x08048e0d      sub esp, 0xc
│     │⁝│   0x08048e10      push 0xffffffffffffffff
│     │⁝│   0x08048e12      call sym.imp.exit
│     └───> 0x08048e17      mov eax, dword [obj.cash]                  ; [0x804b0d8:4]=0
│      ⁝│   0x08048e1c      cmp eax, 0x3b9aca00
│     ┌───< 0x08048e21      jle 0x8048e7c
│     │⁝│   0x08048e23      mov eax, dword [obj.cash]                  ; [0x804b0d8:4]=0
│     │⁝│   0x08048e28      sub esp, 8
│     │⁝│   0x08048e2b      push eax
│     │⁝│   0x08048e2c      push str.Current_Balance:___lu             ; 0x80492d8 ; "*** Current Balance: $%lu ***\n"
│     │⁝│   0x08048e31      call sym.imp.printf
│     │⁝│   0x08048e36      add esp, 0x10
│     │⁝│   0x08048e39      mov eax, dword [obj.wins]                  ; [0x804b0dc:4]=0
│     │⁝│   0x08048e3e      cmp eax, 2                                 ; 2
│    ┌────< 0x08048e41      jle 0x8048e62
│    ││⁝│   0x08048e43      sub esp, 0xc
│    ││⁝│   0x08048e46      push str.Wow__I_can_t_believe_you_did_it.._You_deserve_this_flag ; 0x80492f8 ; "Wow, I can't believe you did it.. You deserve this flag!"
│    ││⁝│   0x08048e4b      call sym.imp.puts
│    ││⁝│   0x08048e50      add esp, 0x10
│    ││⁝│   0x08048e53      call sym.print_flag
│    ││⁝│   0x08048e58      sub esp, 0xc
│    ││⁝│   0x08048e5b      push 0
│    ││⁝│   0x08048e5d      call sym.imp.exit
│    └────> 0x08048e62      sub esp, 0xc
│     │⁝│   0x08048e65      push str.Wait_a_second..._You_re_not_even_on_a_hotstreak__Get_out_of_here_cheater ; 0x8049334 ; "Wait a second... You're not even on a hotstreak! Get out of here cheater!"
│     │⁝│   0x08048e6a      call sym.imp.puts
│     │⁝│   0x08048e6f      add esp, 0x10
│     │⁝│   0x08048e72      sub esp, 0xc
│     │⁝│   0x08048e75      push 0xffffffffffffffff
│     │⁝│   0x08048e77      call sym.imp.exit
│     │⁝│   ; CODE XREF from main (0x8048d94)
│     └─└─> 0x08048e7c      mov eax, dword [obj.cash]                  ; [0x804b0d8:4]=0
│      ⁝    0x08048e81      test eax, eax
│      └──< 0x08048e83      jg 0x8048d99
│           0x08048e89      sub esp, 0xc
│           0x08048e8c      push str.Haha__lost_all_the_money_I_gave_you_already__See_ya_later ; 0x8049380 ; "Haha, lost all the money I gave you already? See ya later!"
│           0x08048e91      call sym.imp.puts
│           0x08048e96      add esp, 0x10
│           0x08048e99      mov eax, 0
│           0x08048e9e      mov ecx, dword [ebp - 4]
│           0x08048ea1      leave
│           0x08048ea2      lea esp, [ecx - 4]
└           0x08048ea5      ret
