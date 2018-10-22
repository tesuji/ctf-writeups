            ;-- main:
┌ (fcn) sym.main 49
│   sym.main ();
│           ; var int local_30h @ rbp-0x30
│           ; var int local_24h @ rbp-0x24
│           ; var int local_20h @ rbp-0x20
│              ; DATA XREF from 0x004004dd (entry0)
│           0x004005c7      55             push rbp
│           0x004005c8      4889e5         rbp = rsp
│           0x004005cb      4883ec30       rsp -= 0x30                 ; '0'
│           0x004005cf      897ddc         dword [local_24h] = edi
│           0x004005d2      488975d0       qword [local_30h] = rsi
│           0x004005d6      bf8e064000     edi = str.Do_you_gets_it    ; 0x40068e ; "Do you gets it??"
│           0x004005db      e890feffff     sym.imp.puts ()             ; int puts(const char *s)
│           0x004005e0      488d45e0       rax = qword [local_20h]
│           0x004005e4      4889c7         rdi = rax
│           0x004005e7      b800000000     eax = 0
│           0x004005ec      e8affeffff     sym.imp.gets ()             ; char*gets(char *s)
│           0x004005f1      b800000000     eax = 0
│           0x004005f6      c9               
└           0x004005f7      c3             return 0
┌ (fcn) sym.give_shell 17
│   sym.give_shell ();
│           0x004005b6      55             push rbp
│           0x004005b7      4889e5         rbp = rsp
│           0x004005ba      bf84064000     edi = str.bin_bash          ; 0x400684 ; "/bin/bash"
│           0x004005bf      e8bcfeffff     sym.imp.system ()           ; int system(const char *string)
│           0x004005c4      90             
│           0x004005c5      5d                 
└           0x004005c6      c3             return
