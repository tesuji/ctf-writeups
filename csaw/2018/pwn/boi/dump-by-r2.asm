            ;-- main:
┌ (fcn) main 159
│   main ();
│           ; var int local_40h @ rbp-0x40
│           ; var int local_34h @ rbp-0x34
│           ; var int local_30h @ rbp-0x30
│           ; var int local_28h @ rbp-0x28
│           ; var int local_20h @ rbp-0x20
│           ; var int local_1ch @ rbp-0x1c
│           ; var int local_18h @ rbp-0x18
│           ; var int local_8h @ rbp-0x8
│              ; DATA XREF from 0x0040054d (entry0)
│           0x00400641      55             push rbp
│           0x00400642      4889e5         rbp = rsp
│           0x00400645      4883ec40       rsp -= 0x40                 ; '@'
│           0x00400649      897dcc         dword [local_34h] = edi
│           0x0040064c      488975c0       qword [local_40h] = rsi
│           0x00400650      64488b042528.  rax = qword fs:[0x28]       ; [0x28:8]=-1 ; '(' ; 40
│           0x00400659      488945f8       qword [local_8h] = rax
│           0x0040065d      31c0           eax = 0
│           0x0040065f      48c745d00000.  qword [local_30h] = 0
│           0x00400667      48c745d80000.  qword [local_28h] = 0
│           0x0040066f      48c745e00000.  qword [local_20h] = 0
│           0x00400677      c745e8000000.  dword [local_18h] = 0
│           0x0040067e      c745e4efbead.  dword [local_1ch] = 0xdeadbeef
│           0x00400685      bf64074000     edi = str.Are_you_a_big_boiiiii ; 0x400764 ; "Are you a big boiiiii??"
│           0x0040068a      e841feffff     sym.imp.puts ()             ; int puts(const char *s)
│           0x0040068f      488d45d0       rax = qword [local_30h]
│           0x00400693      ba18000000     edx = 0x18                  ; 24
│           0x00400698      4889c6         rsi = rax
│           0x0040069b      bf00000000     edi = 0
│           0x004006a0      e85bfeffff     sym.imp.read ()             ; ssize_t read(int fildes, void *buf, size_t nbyte)
│           0x004006a5      8b45e4         eax = dword [local_1ch]
│           0x004006a8      3deebaf3ca     var = eax - 0xcaf3baee
│       ┌─< 0x004006ad      750c           if (var) goto 0x4006bb
│       │   0x004006af      bf7c074000     edi = str.bin_bash          ; 0x40077c ; "/bin/bash"
│       │   0x004006b4      e86dffffff     sym.run_cmd ()
│      ┌──< 0x004006b9      eb0a           goto 0x4006c5
│      ││      ; JMP XREF from 0x004006ad (main)
│      │└─> 0x004006bb      bf86074000     edi = str.bin_date          ; 0x400786 ; "/bin/date"
│      │    0x004006c0      e861ffffff     sym.run_cmd ()
│      │       ; JMP XREF from 0x004006b9 (main)
│      └──> 0x004006c5      b800000000     eax = 0
│           0x004006ca      488b4df8       rcx = qword [local_8h]
│           0x004006ce      6448330c2528.  rcx ^= qword fs:[0x28]
│       ┌─< 0x004006d7      7405           if (!var) goto 0x4006de
│       │   0x004006d9      e802feffff     sym.imp.__stack_chk_fail () ; void __stack_chk_fail(void)
│       │      ; JMP XREF from 0x004006d7 (main)
│       └─> 0x004006de      c9             leave 
└           0x004006df      c3             return
