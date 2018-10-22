            ;-- main:
┌ (fcn) sym.main 327
│   sym.main (int argc, char **argv, char **envp);
│           ; var char **m_argv @ rbp-0x840
│           ; var int m_argc @ rbp-0x834
│           ; var void *buf @ rbp-0x830
│           ; var Turtle *turtle @ rbp-0x18
│           ; arg int argc @ rdi
│           ; arg char **argv @ rsi
│           0x00400b84      push rbp                                   ; .//turtles.m:20
│           0x00400b85      mov rbp, rsp
│           0x00400b88      push rbx
│           0x00400b89      sub rsp, 0x838
│           0x00400b90      mov dword [m_argc], edi                    ; argc
│           0x00400b96      mov qword [m_argv], rsi                    ; argv
│           0x00400b9d      mov rax, qword [reloc.stdout]              ; .//turtles.m:22 ; [0x601258:8]=0
│           0x00400ba4      mov rax, qword [rax]
│           0x00400ba7      mov ecx, 0
│           0x00400bac      mov edx, 2
│           0x00400bb1      mov esi, 0
│           0x00400bb6      mov rdi, rax
│           0x00400bb9      call sym.imp.setvbuf                       ; int setvbuf(FILE*stream, char *buf, int mode, size_t size)
│           0x00400bbe      mov rax, qword [reloc.stdin]               ; .//turtles.m:23 ; [0x601260:8]=0
│           0x00400bc5      mov rax, qword [rax]
│           0x00400bc8      mov ecx, 0
│           0x00400bcd      mov edx, 2
│           0x00400bd2      mov esi, 0
│           0x00400bd7      mov rdi, rax
│           0x00400bda      call sym.imp.setvbuf                       ; int setvbuf(FILE*stream, char *buf, int mode, size_t size)
│           0x00400bdf      lea rdi, [0x00400e73]                      ; .//turtles.m:25 ; "Turtle"
│           0x00400be6      call sym.imp.objc_get_class
│           0x00400beb      mov rbx, rax
│           0x00400bee      lea rsi, obj._OBJC_SELECTOR_TABLE          ; 0x601540 ; "6\x13`"
│           0x00400bf5      mov rdi, rbx
│           0x00400bf8      call sym.imp.objc_msg_lookup
│           0x00400bfd      lea rsi, obj._OBJC_SELECTOR_TABLE          ; 0x601540 ; "6\x13`"
│           0x00400c04      mov rdi, rbx
│           0x00400c07      call rax
│           0x00400c09      mov rbx, rax
│           0x00400c0c      lea rsi, [0x00601550]
│           0x00400c13      mov rdi, rbx
│           0x00400c16      call sym.imp.objc_msg_lookup
│           0x00400c1b      lea rsi, [0x00601550]
│           0x00400c22      mov rdi, rbx
│           0x00400c25      call rax
│           0x00400c27      mov qword [turtle], rax
│           0x00400c2b      mov rax, qword [turtle]                    ; .//turtles.m:26
│           0x00400c2f      mov rsi, rax
│           0x00400c32      lea rdi, str.Here_is_a_Turtle:__p          ; 0x400e7a ; "Here is a Turtle: %p\n"
│           0x00400c39      mov eax, 0
│           0x00400c3e      call sym.imp.printf                        ; int printf(const char *format)
│           0x00400c43      lea rax, [buf]                             ; .//turtles.m:28
│           0x00400c4a      mov edx, 0x810                             ; 2064
│           0x00400c4f      mov rsi, rax
│           0x00400c52      mov edi, 0
│           0x00400c57      call sym.imp.read                          ; ssize_t read(int fildes, void *buf, size_t nbyte)
│           0x00400c5c      lea rcx, [buf]                             ; .//turtles.m:29
│           0x00400c63      mov rax, qword [turtle]
│           0x00400c67      mov edx, 0xc8                              ; 200
│           0x00400c6c      mov rsi, rcx
│           0x00400c6f      mov rdi, rax
│           0x00400c72      call sym.imp.memcpy                        ; void *memcpy(void *s1, const void *s2, size_t n)
│           0x00400c77      mov rbx, qword [turtle]                    ; .//turtles.m:31
│           0x00400c7b      lea rsi, [0x00601560]
│           0x00400c82      mov rdi, rbx
│           0x00400c85      call sym.imp.objc_msg_lookup
│           0x00400c8a      lea rdx, obj._OBJC_INSTANCE_1              ; 0x6013a0
│           0x00400c91      lea rsi, [0x00601560]
│           0x00400c98      mov rdi, rbx
│           0x00400c9b      call rax
│           0x00400c9d      mov rbx, qword [turtle]                    ; .//turtles.m:32
│           0x00400ca1      lea rsi, [0x00601570]
│           0x00400ca8      mov rdi, rbx
│           0x00400cab      call sym.imp.objc_msg_lookup
│           0x00400cb0      lea rsi, [0x00601570]
│           0x00400cb7      mov rdi, rbx
│           0x00400cba      call rax
│           0x00400cbc      mov eax, 0
│           0x00400cc1      add rsp, 0x838                             ; .//turtles.m:33
│           0x00400cc8      pop rbx
│           0x00400cc9      pop rbp
└           0x00400cca      ret
