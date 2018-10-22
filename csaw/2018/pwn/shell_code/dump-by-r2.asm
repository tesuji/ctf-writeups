┌ (fcn) sym.main 93
│   sym.main ();
│              ; DATA XREF from 0x0000073d (entry0)
│           0x00000966      55             push rbp
│           0x00000967      4889e5         rbp = rsp
│           0x0000096a      488b059f0620.  rax = qword [obj.stdout]    ; loc.stdout ; [0x201010:8]=0
│           0x00000971      b900000000     ecx = 0                     ; size_t size
│           0x00000976      ba02000000     edx = 2                     ; int mode
│           0x0000097b      be00000000     esi = 0                     ; char* buf
│           0x00000980      4889c7         rdi = rax                   ; FILE* stream
│           0x00000983      e868fdffff     sym.imp.setvbuf ()          ; int setvbuf(FILE*stream, char*buf, int mode, size_t size)
│           0x00000988      488b05910620.  rax = qword [obj.stdin]     ; [0x201020:8]=0
│           0x0000098f      b900000000     ecx = 0                     ; size_t size
│           0x00000994      ba02000000     edx = 2                     ; int mode
│           0x00000999      be00000000     esi = 0                     ; char* buf
│           0x0000099e      4889c7         rdi = rax                   ; FILE* stream
│           0x000009a1      e84afdffff     sym.imp.setvbuf ()          ; int setvbuf(FILE*stream, char*buf, int mode, size_t size)
│           0x000009a6      488d3d330100.  rdi = qword str.Linked_lists_are_great____They_let_you_chain_pieces_of_data_together. ; str.Linked_lists_are_great___They_let_you_chain_pieces_of_data_together. ; 0xae0 ; "Linked lists are great! \nThey let you chain pieces of data together.\n" ; const char * s
│           0x000009ad      e80efdffff     sym.imp.puts ()             ; int puts(const char *s)
│           0x000009b2      b800000000     eax = 0
│           0x000009b7      e833ffffff     sym.nononode ()
│           0x000009bc      b800000000     eax = 0
│           0x000009c1      5d
└           0x000009c2      c3             return 0
┌ (fcn) sym.nononode 119
│   sym.nononode ();
│           ; var int local_40h @ rbp-0x40
│           ; var int local_20h @ rbp-0x20
│              ; CALL XREF from 0x000009b7 (sym.main)
│           0x000008ef      55             push rbp
│           0x000008f0      4889e5         rbp = rsp
│           0x000008f3      4883ec40       rsp -= 0x40                 ; '@'
│           0x000008f7      488d45c0       rax = qword [local_40h]
│           0x000008fb      488945e0       qword [local_20h] = rax
│           0x000008ff      488d3d940100.  rdi = qword str.15_bytes__Text_for_node_1: ; 0xa9a ; "(15 bytes) Text for node 1:  " ; const char * s
│           0x00000906      e8b5fdffff     sym.imp.puts ()             ; int puts(const char *s)
│           0x0000090b      488d45e0       rax = qword [local_20h]
│           0x0000090f      4883c008       rax += 8
│           0x00000913      be0f000000     esi = 0xf
│           0x00000918      4889c7         rdi = rax
│           0x0000091b      e83cffffff     sym.readline () 		; void readline(char *s, size_t len)
│           0x00000920      488d3d910100.  rdi = qword str.15_bytes__Text_for_node_2: ; 0xab8 ; "(15 bytes) Text for node 2: " ; const char * s
│           0x00000927      e894fdffff     sym.imp.puts ()             ; int puts(const char *s)
│           0x0000092c      488d45c0       rax = qword [local_40h]
│           0x00000930      4883c008       rax += 8
│           0x00000934      be0f000000     esi = 0xf
│           0x00000939      4889c7         rdi = rax
│           0x0000093c      e81bffffff     sym.readline ()
│           0x00000941      488d3d8d0100.  rdi = qword str.node1:      ; 0xad5 ; "node1: " ; const char * s
│           0x00000948      e873fdffff     sym.imp.puts ()             ; int puts(const char *s)
│           0x0000094d      488d45e0       rax = qword [local_20h]
│           0x00000951      4889c7         rdi = rax
│           0x00000954      e8d1feffff     sym.printNode ()
│           0x00000959      b800000000     eax = 0
│           0x0000095e      e845ffffff     sym.goodbye ()
│           0x00000963      90
│           0x00000964      c9             leave
└           0x00000965      c3             return
┌ (fcn) sym.readline 76
│   sym.readline (); 							 void readline(char *s, int len)
│           ; var size_t local_20h @ rbp-0x20
│           ; var int local_18h @ rbp-0x18
│           ; var int local_10h @ rbp-0x10
│           ; var int local_8h @ rbp-0x8
│              ; CALL XREF from 0x0000091b (sym.nononode)
│              ; CALL XREF from 0x0000093c (sym.nononode)
│           0x0000085c      55             push rbp
│           0x0000085d      4889e5         rbp = rsp
│           0x00000860      4883ec20       rsp -= 0x20
│           0x00000864      48897de8       qword [local_18h] = rdi
│           0x00000868      488975e0       qword [local_20h] = rsi
│           0x0000086c      48c745f80000.  qword [local_8h] = 0
│           0x00000874      488b15a50720.  rdx = qword [obj.stdin]     ; [0x201020:8]=0
│           0x0000087b      488d4df0       rcx = qword [local_10h] 	; size_t *n
│           0x0000087f      488d45f8       rax = qword [local_8h] 	; char **lineptr
│           0x00000883      4889ce         rsi = rcx 			; size_t *n
│           0x00000886      4889c7         rdi = rax 			; char **lineptr
│              ; DATA XREF from 0x00000b12 (str.Linked_lists_are_great____They_let_you_chain_pieces_of_data_together. + 50)
│           0x00000889      e872feffff     sym.imp.getline () 		; ssize_t getline(char **lineptr, size_t *n, FILE *stream);
│           0x0000088e      488b4df8       rcx = qword [local_8h]
│           0x00000892      488b55e0       rdx = qword [local_20h]     ; size_t  n
│           0x00000896      488b45e8       rax = qword [local_18h]
│           0x0000089a      4889ce         rsi = rcx                   ; const char * src
│           0x0000089d      4889c7         rdi = rax                   ; char *dest
│           0x000008a0      e80bfeffff     sym.imp.strncpy ()          ; char *strncpy(char *dest, const char *src, size_t  n)
│           0x000008a5      90
│           0x000008a6      c9             leave
└           0x000008a7      c3             return
┌ (fcn) sym.printNode 50
│   sym.printNode ();
│           ; var int local_8h @ rbp-0x8
│              ; CALL XREF from 0x00000954 (sym.nononode)
│           0x0000082a      55             push rbp
│           0x0000082b      4889e5         rbp = rsp
│           0x0000082e      4883ec10       rsp -= 0x10
│           0x00000832      48897df8       qword [local_8h] = rdi
│           0x00000836      488b45f8       rax = qword [local_8h]
│           0x0000083a      488d5008       rdx = qword [rax + 8]
│           0x0000083e      488b45f8       rax = qword [local_8h]
│           0x00000842      488b00         rax = qword [rax]
│           0x00000845      4889c6         rsi = rax
│           0x00000848      488d3d090200.  rdi = qword str.node.next:__p__node.buffer:__s ; 0xa58 ; "node.next: %p\nnode.buffer: %s\n" ; const char * format
│           0x0000084f      b800000000     eax = 0
│           0x00000854      e877feffff     sym.imp.printf ()           ; int printf(const char *format)
│           0x00000859      90
│           0x0000085a      c9             leave
└           0x0000085b      c3             return
┌ (fcn) sym.goodbye 71
│   sym.goodbye ();
│           ; var int local_3h @ rbp-0x3
│              ; CALL XREF from 0x0000095e (sym.nononode)
│           0x000008a8      55             push rbp
│           0x000008a9      4889e5         rbp = rsp
│           0x000008ac      4883ec10       rsp -= 0x10
│           0x000008b0      488d3dc00100.  rdi = qword str.What_are_your_initials ; 0xa77 ; "What are your initials?" ; const char * s
│           0x000008b7      e804feffff     sym.imp.puts ()             ; int puts(const char *s)
│           0x000008bc      488b155d0720.  rdx = qword [obj.stdin]     ; [0x201020:8]=0 ; FILE *stream
│           0x000008c3      488d45fd       rax = qword [local_3h]
│           0x000008c7      be20000000     esi = 0x20                  ; "@" ; int size
│           0x000008cc      4889c7         rdi = rax                   ; char *s
│           0x000008cf      e80cfeffff     sym.imp.fgets ()            ; char *fgets(char *s, int size, FILE *stream)
│           0x000008d4      488d45fd       rax = qword [local_3h]
│           0x000008d8      4889c6         rsi = rax
│           0x000008db      488d3dad0100.  rdi = qword str.Thanks__s   ; 0xa8f ; "Thanks %s\n" ; const char * format
│           0x000008e2      b800000000     eax = 0
│           0x000008e7      e8e4fdffff     sym.imp.printf ()           ; int printf(const char *format)
│           0x000008ec      90
│           0x000008ed      c9             leave
└           0x000008ee      c3             return
