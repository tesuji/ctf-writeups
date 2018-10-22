┌ (fcn) fcn.00000000 (64 bits) 1
│   fcn.00000000 ();
└           0000:0000     f4             hlt                           ; stop process until external interrupt received
            0000:0001     e492           in al, 0x92                   ; input from port
            0000:0003     0c02           or al, 2                      ; logical inclusive or
            0000:0005     e692           out 0x92, al                  ; output to port
            0000:0007     31c0           xor ax, ax                    ; 0
            0000:0009     8ed0           mov ss, ax                    ; 0
            0000:000b     bc0160         mov sp, 0x6001                ; 0x6001
            0000:000e     8ed8           mov ds, ax                    ; 0
               ; DATA XREF from 0x00000158 (fcn.00000000 + 344)
            0000:0010     8ec0           mov es, ax                    ; 0
            0000:0012     8ee0           mov fs, ax                    ; 0
            0000:0014     8ee8           mov gs, ax                    ; 0
            0000:0016     fc             cld                           ; clear direction flag
            0000:0017     66bf00000000   mov edi, 0                    ; 0
        ┌─< 0000:001d     eb07           jmp 0x26                      ; jump
        │      ; DATA XREF from 0x000000ea (fcn.00000000 + 234)
        │      ; DATA XREF from 0x000000f4 (fcn.00000000 + 244)
        │      ; DATA XREF from 0x00000110 (fcn.00000000 + 272)
        │      ; DATA XREF from 0x00000120 (fcn.00000000 + 288)
        │      ; DATA XREF from 0x00000126 (fcn.00000000 + 294)
        │   0000:001f     90             nop                           ; no operation
        │   0000:0020     0000           add byte [bx + si], al        ; adds src and dst, stores result on dst
        │   0000:0022     0000           add byte [bx + si], al        ; adds src and dst, stores result on dst
        │   0000:0024     0000           add byte [bx + si], al        ; adds src and dst, stores result on dst
        │      ; JMP XREF from 0x0000001d (fcn.00000000 + 29)
        └─> 0000:0026     57             push di                       ; 0
            0000:0027     66b900100000   mov ecx, 0x1000               ; 0x1000
            0000:002d     6631c0         xor eax, eax                  ; 0
            0000:0030     fc             cld                           ; clear direction flag
            0000:0031     f366ab         rep stosd dword es:[di], eax  ; memset(es, 0, 1000)
            0000:0034     5f             pop di                        ; 0
            0000:0035     26668d850010   lea eax, dword es:[di + 0x1000] ; 0x1000
            0000:003b     6683c803       or eax, 3                     ; 0x1003 = 4099
            0000:003f     26668905       mov dword es:[di], eax        ; 0x1003
            0000:0043     26668d850020   lea eax, dword es:[di + 0x2000] ; 0x2000
            0000:0049     6683c803       or eax, 3                     ; 0x2003
            0000:004d     266689850010   mov dword es:[di + 0x1000], eax ; 0x2000
            0000:0053     26668d850030   lea eax, dword es:[di + 0x3000] ; 0x3000
            0000:0059     6683c803       or eax, 3                     ; 0x30003
            0000:005d     266689850020   mov dword es:[di + 0x2000], eax ; 0x3003
            0000:0063     57             push di                       ; 0
            0000:0064     8dbd0030       lea di, word [di + 0x3000]    ; 0x3000
            0000:0068     66b803000000   mov eax, 3                    ; 3
               ; JMP XREF from 0x00000081 (fcn.00000000 + 129)
        ┌─> 0000:006e     26668905       mov dword es:[di], eax        ; es[di] = eax
        ⁝   0000:0072     660500100000   add eax, 0x1000               ; eax += 0x1000
        ⁝   0000:0078     83c708         add di, 8                     ; di += 8
        ⁝   0000:007b     663d00002000   cmp eax, 0x200000             ; compare two operands
        └─< 0000:0081     72eb           jb 0x6e                       ; jump short if below/not above nor equal/carry (cf=1)
            0000:0083     5f             pop di                        ; 0
            0000:0084     b0ff           mov al, 0xff                  ; 255
            0000:0086     e6a1           out 0xa1, al                  ; output to port 0xa1
            0000:0088     e621           out 0x21, al                  ; output to port 0x21
            0000:008a     90             nop                           ; no operation
            0000:008b     90             nop                           ; no operation
            0000:008c     0f011e2060     lidt [0x6020]                 ; load interrupt descriptor table register
            0000:0091     66b8a0000000   mov eax, 0xa0                 ; 0xa0
            0000:0097     0f22e0         mov cr4, eax                  ; Enable  Physical Address Extension and Page Global Enabled
            0000:009a     6689fa         mov edx, edi                  ; 0
            0000:009d     0f22da         mov cr3, edx                  ; Disable  translate linear addresses into physical addresses
               ; DATA XREF from 0x00000092 (fcn.00000000 + 146)
            0000:00a0     66b9800000c0   mov ecx, 0xc0000080           ; 0xc0000080
            0000:00a6     0f32           rdmsr                         ; EDX:EAX = MSR[ECX]; read from model specific register
            0000:00a8     660d00010000   or eax, 0x100                 ; Long Mode Enable
            0000:00ae     0f30           wrmsr                         ; MSR[ECX] = EDX:EAX; write to model specific register
            0000:00b0     0f20c3         mov ebx, cr0                  ;
            0000:00b3     6681cb010000.  or ebx, 0x80000001            ; Enable Protected Mode  and  Paging
            0000:00ba     0f22c3         mov cr0, ebx                  ;
            0000:00bd     0f0116e260     lgdt [0x60e2]                 ; load global descriptor table register
        ┌─< 0000:00c2     ea58610800     ljmp 8:0x6158
        │   0000:00c7     0000           add byte [bx + si], al        ; adds src and dst, stores result on dst
        │   0000:00c9     0000           add byte [bx + si], al        ; adds src and dst, stores result on dst
        │   0000:00cb     0000           add byte [bx + si], al        ; adds src and dst, stores result on dst
        │   0000:00cd     0000           add byte [bx + si], al        ; adds src and dst, stores result on dst
        │   0000:00cf     0000           add byte [bx + si], al        ; adds src and dst, stores result on dst
        │   0000:00d1     0000           add byte [bx + si], al        ; adds src and dst, stores result on dst
        │   0000:00d3     009a2000       add byte [bp + si + 0x20], bl ; adds src and dst, stores result on dst
        │   0000:00d7     0000           add byte [bx + si], al        ; adds src and dst, stores result on dst
        │   0000:00d9     0000           add byte [bx + si], al        ; adds src and dst, stores result on dst
        │   0000:00db     00920000       add byte [bp + si], dl        ; adds src and dst, stores result on dst
        │   0000:00df     90             nop                           ; no operation
        │   0000:00e0     0000           add byte [bx + si], al        ; adds src and dst, stores result on dst
        │   0000:00e2     1a00           sbb al, byte [bx + si]        ; integer subtraction with borrow
        │   0000:00e4     c7             invalid
        │   0000:00e5     60             pushaw
        │   0000:00e6     0000           add byte [bx + si], al        ; adds src and dst, stores result on dst
        │   0000:00e8     a5             movsw word es:[di], word ptr [si] ; ES:[edi] = (word)DS:[esi] (esi+=2, edi+=2)
        │   0000:00e9     1f             pop ds                        ; pops last element of stack and stores the result in argument
        │   0000:00ea     b11f           mov cl, 0x1f                  ; 31 ; moves data from src to dst
        │   0000:00ec     ab             stosw word es:[di], ax        ; store string word
        │   0000:00ed     1f             pop ds                        ; pops last element of stack and stores the result in argument
        │   0000:00ee     a7             cmpsw word [si], word ptr es:[di] ; [0xe0000001c:2]=0xffff ; 60129542172 ; cmp DS:[esi], (word)ES:[edi] (esi+=2, edi+=2)
        │   0000:00ef     1f             pop ds                        ; pops last element of stack and stores the result in argument
        │   0000:00f0     9f             lahf                          ; load status flags into ah register
        │   0000:00f1     1f             pop ds                        ; pops last element of stack and stores the result in argument
        │   0000:00f2     091f           or word [bx], bx              ; logical inclusive or
        │   0000:00f4     b51f           mov ch, 0x1f                  ; 31 ; moves data from src to dst
        │   0000:00f6     a31fd7         mov word [0xd71f], ax         ; [0xd71f:2]=0xffff ; moves data from src to dst
        │   0000:00f9     1f             pop ds                        ; pops last element of stack and stores the result in argument
        │   0000:00fa     8f             invalid
        │   0000:00fb     1f             pop ds                        ; pops last element of stack and stores the result in argument
        │   0000:00fc     b31f           mov bl, 0x1f                  ; 31 ; moves data from src to dst
        │   0000:00fe     011f           add word [bx], bx             ; adds src and dst, stores result on dst
        │   0000:0100     0b1f           or bx, word [bx]              ; logical inclusive or
        │   0000:0102     0b1f           or bx, word [bx]              ; logical inclusive or
        │   0000:0104     d7             xlatb                         ; table look-up translation
        │   0000:0105     1f             pop ds                        ; pops last element of stack and stores the result in argument
        │   0000:0106     fd             std                           ; set direction flag
        │   0000:0107     1f             pop ds                        ; pops last element of stack and stores the result in argument
        │   0000:0108     f31f           pop ds                        ; pops last element of stack and stores the result in argument
        │   0000:010a     c9             leave                         ; one byte alias for mov esp, ebp ; pop ebp
        │   0000:010b     1f             pop ds                        ; pops last element of stack and stores the result in argument
        │   0000:010c     d7             xlatb                         ; table look-up translation
        │   0000:010d     1f             pop ds                        ; pops last element of stack and stores the result in argument
        │   0000:010e     a5             movsw word es:[di], word ptr [si] ; ES:[edi] = (word)DS:[esi] (esi+=2, edi+=2)
        │   0000:010f     1f             pop ds                        ; pops last element of stack and stores the result in argument
        │   0000:0110     b71f           mov bh, 0x1f                  ; 31 ; moves data from src to dst
        │   0000:0112     8d1f           lea bx, word [bx]             ; load effective address
        │   0000:0114     d7             xlatb                         ; table look-up translation
        │   0000:0115     1f             pop ds                        ; pops last element of stack and stores the result in argument
        │   0000:0116     99             cdq                           ; sign extends eax into edx (convert doubleword to quadword)
        │   0000:0117     1f             pop ds                        ; pops last element of stack and stores the result in argument
        │   0000:0118     191f           sbb word [bx], bx             ; integer subtraction with borrow
        │   0000:011a     051fd7         add ax, 0xd71f                ; adds src and dst, stores result on dst
        │   0000:011d     1f             pop ds                        ; pops last element of stack and stores the result in argument
        │   0000:011e     b71f           mov bh, 0x1f                  ; 31 ; moves data from src to dst
        │   0000:0120     b51f           mov ch, 0x1f                  ; 31 ; moves data from src to dst
        │      ; JMP XREF from 0x000000c0 (fcn.00000000 + 192)
        │   0000:0122     0f             invalid
        │   0000:0123     1f             pop ds                        ; pops last element of stack and stores the result in argument
        │   0000:0124     d7             xlatb                         ; table look-up translation
        │   0000:0125     1f             pop ds                        ; pops last element of stack and stores the result in argument
        │   0000:0126     b31f           mov bl, 0x1f                  ; 31 ; moves data from src to dst
        │   0000:0128     011f           add word [bx], bx             ; adds src and dst, stores result on dst
        │   0000:012a     8f             invalid
        │   0000:012b     1f             pop ds                        ; pops last element of stack and stores the result in argument
        │   0000:012c     8f             invalid
        │   0000:012d     1f             pop ds                        ; pops last element of stack and stores the result in argument
        │   0000:012e     0b1f           or bx, word [bx]              ; logical inclusive or
        │   0000:0130     851f           test word [bx], bx            ; [0x8:2]=0x8ec0 ; 8 ; set eflags after comparing two registers (AF, CF, OF, PF, SF, ZF)
        │   0000:0132     a31fd7         mov word [0xd71f], ax         ; [0xd71f:2]=0xffff ; moves data from src to dst
        │   0000:0135     1f             pop ds                        ; pops last element of stack and stores the result in argument
        │   0000:0136     0b1f           or bx, word [bx]              ; logical inclusive or
        │   0000:0138     a31fab         mov word [0xab1f], ax         ; [0xab1f:2]=0xffff ; moves data from src to dst
        │   0000:013b     1f             pop ds                        ; pops last element of stack and stores the result in argument
        │   0000:013c     891f           mov word [bx], bx             ; moves data from src to dst
        │   0000:013e     d7             xlatb                         ; table look-up translation
        │   0000:013f     1f             pop ds                        ; pops last element of stack and stores the result in argument
        │   0000:0140     011f           add word [bx], bx             ; adds src and dst, stores result on dst
        │   0000:0142     d7             xlatb                         ; table look-up translation
        │   0000:0143     1f             pop ds                        ; pops last element of stack and stores the result in argument
        │   0000:0144     db1f           fistp dword [bx]              ; store integer and pop
        │   0000:0146     091f           or word [bx], bx              ; logical inclusive or
        │   0000:0148     c3             ret                           ; return from subroutine. pop 4 bytes from esp and jump there.
        │   0000:0149     1f             pop ds                        ; pops last element of stack and stores the result in argument
        │   0000:014a     93             xchg ax, bx                   ; exchange register/memory with register
        │   0000:014b     1f             pop ds                        ; pops last element of stack and stores the result in argument
        │   0000:014c     0000           add byte [bx + si], al        ; adds src and dst, stores result on dst
        │   0000:014e     0000           add byte [bx + si], al        ; adds src and dst, stores result on dst
        │   0000:0150     0000           add byte [bx + si], al        ; adds src and dst, stores result on dst
        │   0000:0152     0000           add byte [bx + si], al        ; adds src and dst, stores result on dst
        │   0000:0154     0000           add byte [bx + si], al        ; adds src and dst, stores result on dst
        │   0000:0156     0000           add byte [bx + si], al        ; adds src and dst, stores result on dst
        │   0000:0158     66b810008ed8   mov eax, 0xd88e0010           ; moves data from src to dst
        │   0000:015e     8ec0           mov es, ax                    ; moves data from src to dst
        │   0000:0160     8ee0           mov fs, ax                    ; moves data from src to dst
        │   0000:0162     8ee8           mov gs, ax                    ; moves data from src to dst
        │   0000:0164     8ed0           mov ss, ax                    ; moves data from src to dst
        │   0000:0166     bf0080         mov di, 0x8000                ; moves data from src to dst
        │   0000:0169     0b00           or ax, word [bx + si]         ; logical inclusive or
        │   0000:016b     b9f401         mov cx, 0x1f4                 ; 500 ; moves data from src to dst
        │   0000:016e     0000           add byte [bx + si], al        ; adds src and dst, stores result on dst
        │   0000:0170     48             dec ax                        ; decrement by 1
        │   0000:0171     b8201f         mov ax, 0x1f20                ; moves data from src to dst
        │   0000:0174     201f           and byte [bx], bl             ; binary and operation between src and dst, stores result on dst
        │   0000:0176     201f           and byte [bx], bl             ; binary and operation between src and dst, stores result on dst
        │   0000:0178     201f           and byte [bx], bl             ; binary and operation between src and dst, stores result on dst
        │   0000:017a     f348           dec ax                        ; decrement by 1
        │   0000:017c     ab             stosw word es:[di], ax        ; store string word
        │   0000:017d     bf0080         mov di, 0x8000                ; moves data from src to dst
        │   0000:0180     0b00           or ax, word [bx + si]         ; logical inclusive or
        │   0000:0182     48             dec ax                        ; decrement by 1
        │   0000:0183     31c0           xor ax, ax                    ; logical exclusive or
        │   0000:0185     48             dec ax                        ; decrement by 1
        │   0000:0186     31db           xor bx, bx                    ; logical exclusive or
        │   0000:0188     48             dec ax                        ; decrement by 1
        │   0000:0189     31c9           xor cx, cx                    ; logical exclusive or
        │   0000:018b     48             dec ax                        ; decrement by 1
        │   0000:018c     31d2           xor dx, dx                    ; logical exclusive or
        │   0000:018e     b245           mov dl, 0x45                  ; 'E' ; 69 ; moves data from src to dst
        │   0000:0190     80ca6c         or dl, 0x6c                   ; 'l' ; logical inclusive or
        │   0000:0193     b679           mov dh, 0x79                  ; 'y' ; 121 ; moves data from src to dst
        │   0000:0195     80ce6b         or dh, 0x6b                   ; 'k' ; logical inclusive or
        │   0000:0198     20f2           and dl, dh                    ; binary and operation between src and dst, stores result on dst
        │   0000:019a     b600           mov dh, 0                     ; moves data from src to dst
        │   0000:019c     48             dec ax                        ; decrement by 1
        │   0000:019d     bee860         mov si, 0x60e8                ; moves data from src to dst
        │   0000:01a0     0000           add byte [bx + si], al        ; adds src and dst, stores result on dst
        │   0000:01a2     0000           add byte [bx + si], al        ; adds src and dst, stores result on dst
        │   0000:01a4     0000           add byte [bx + si], al        ; adds src and dst, stores result on dst
        │      ; JMP XREF from 0x000001d2 (fcn.00000000 + 466)
       ┌──> 0000:01a6     48             dec ax                        ; decrement by 1
       ⁝│   0000:01a7     833c06         cmp word [si], 6              ; [0x6:2]=0x3192 ; 6 ; compare two operands
       ⁝│   0000:01aa     007427         add byte [si + 0x27], dh      ; adds src and dst, stores result on dst
       ⁝│   0000:01ad     b90400         mov cx, 4                     ; moves data from src to dst
       ⁝│   0000:01b0     0000           add byte [bx + si], al        ; adds src and dst, stores result on dst
       :│      ; JMP XREF from 0x000001c0 (fcn.00000000 + 448)
      ┌───> 0000:01b2     8a1c           mov bl, byte [si]             ; moves data from src to dst
      ⁝⁝│   0000:01b4     06             push es                       ; push word, doubleword or quadword onto the stack
      ⁝⁝│   0000:01b5     30d3           xor bl, dl                    ; logical exclusive or
      ⁝⁝│   0000:01b7     d0eb           shr bl, 1                     ; logic right shift (0 padding)
      ⁝⁝│   0000:01b9     881c           mov byte [si], bl             ; moves data from src to dst
      ⁝⁝│   0000:01bb     06             push es                       ; push word, doubleword or quadword onto the stack
      ⁝⁝│   0000:01bc     48             dec ax                        ; decrement by 1
      ⁝⁝│   0000:01bd     83c002         add ax, 2                     ; adds src and dst, stores result on dst
      └───< 0000:01c0     e2f0           loop 0x1b2                    ; decrement count; jump short if ecx!=0
       ⁝│   0000:01c2     48             dec ax                        ; decrement by 1
       ⁝│   0000:01c3     83e808         sub ax, 8                     ; substract src and dst, stores result on dst
       ⁝│   0000:01c6     48             dec ax                        ; decrement by 1
       ⁝│   0000:01c7     8b0c           mov cx, word [si]             ; moves data from src to dst
       ⁝│   0000:01c9     06             push es                       ; push word, doubleword or quadword onto the stack
       ⁝│   0000:01ca     48             dec ax                        ; decrement by 1
       ⁝│   0000:01cb     890c           mov word [si], cx             ; moves data from src to dst
       ⁝│   0000:01cd     07             pop es                        ; pops last element of stack and stores the result in argument
       ⁝│   0000:01ce     48             dec ax                        ; decrement by 1
       ⁝│   0000:01cf     83c008         add ax, 8                     ; adds src and dst, stores result on dst
       └──< 0000:01d2     ebd2           jmp 0x1a6                     ; jump
       ││      ; JMP XREF from 0x000001ab (fcn.00000000 + 427)
       ││      ; JMP XREF from 0x000001d4 (fcn.00000000 + 468)
       └──> 0000:01d4     ebfe           jmp 0x1d4                     ; jump
        │   0000:01d6     ff             invalid
        │   0000:01d7     ff             invalid
        │   0000:01d8     ff             invalid
        │   0000:01d9     ff             invalid
        │   0000:01da     ff             invalid
        │   0000:01db     ff             invalid
        │   0000:01dc     ff             invalid
        │   0000:01dd     ff             invalid
        │   0000:01de     ff             invalid
        │   0000:01df     ff             invalid
        │   0000:01e0     ff             invalid
        │   0000:01e1     ff             invalid
        │   0000:01e2     ff             invalid
        │   0000:01e3     ff             invalid
        │   0000:01e4     ff             invalid
        │   0000:01e5     ff             invalid
        │   0000:01e6     ff             invalid
        │   0000:01e7     ff             invalid
        │   0000:01e8     ff             invalid
        │   0000:01e9     ff             invalid
        │   0000:01ea     ff             invalid
        │   0000:01eb     ff             invalid
        │   0000:01ec     ff             invalid
        │   0000:01ed     ff             invalid
        │   0000:01ee     ff             invalid
        │   0000:01ef     ff             invalid
        │   0000:01f0     ff             invalid
        │   0000:01f1     ff             invalid
        │   0000:01f2     ff             invalid
        │   0000:01f3     ff             invalid
        │   0000:01f4     ff             invalid
        │   0000:01f5     ff             invalid
        │   0000:01f6     ff             invalid
        │   0000:01f7     ff             invalid
        │   0000:01f8     ff             invalid
        │   0000:01f9     ff             invalid
        │   0000:01fa     ff             invalid
        │   0000:01fb     ff             invalid
        │   0000:01fc     ff             invalid
        │   0000:01fd     ff             invalid
