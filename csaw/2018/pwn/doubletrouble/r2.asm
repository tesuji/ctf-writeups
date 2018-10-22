┌ (fcn) sym.game 633
│   sym.game ();
│           ; var int size @ ebp-0x21c
│           ; var signed int i @ ebp-0x218
│           ; var char *str @ ebp-0x214
│           ; var int money_d @ ebp-0x210
│           ; var int stack_canary @ ebp-0xc
│           ; var int local_8h @ ebp-0x8
│           ; CALL XREF from sym.main (0x804983c)
│           0x08049506      55             push ebp
│           0x08049507      89e5           ebp = esp
│           0x08049509      56             push esi
│           0x0804950a      53             push ebx
│           0x0804950b      81ec20020000   esp -= 0x220
│           0x08049511      e81afcffff     sym.__x86.get_pc_thunk.bx ()
│           0x08049516      81c3ea2a0000   ebx += 0x2aea
│           0x0804951c      65a114000000   eax = dword gs:[0x14]       ; [0x14:4]=-1 ; 20
│           0x08049522      8945f4         dword [stack_canary] = eax
│           0x08049525      31c0           eax = 0
│           0x08049527      83ec08         esp -= 8
│           0x0804952a      8d85f0fdffff   eax = [money_d]
│           0x08049530      50             push eax
│           0x08049531      8d8310e0ffff   eax = [ebx - 0x1ff0]
│           0x08049537      50             push eax                    ; const char *format
│           0x08049538      e8f3faffff     sym.imp.printf ()           ; int printf(const char *format)
│           0x0804953d      83c410         esp += 0x10
│           0x08049540      83ec0c         esp -= 0xc
│           0x08049543      8d8314e0ffff   eax = str.How_long:         ; 0x804a014 ; "How long: "
│           0x08049549      50             push eax                    ; const char *format
│           0x0804954a      e8e1faffff     sym.imp.printf ()           ; int printf(const char *format)
│           0x0804954f      83c410         esp += 0x10
│           0x08049552      83ec08         esp -= 8
│           0x08049555      8d85e4fdffff   eax = [size]
│           0x0804955b      50             push eax
│           0x0804955c      8d831fe0ffff   eax = [ebx - 0x1fe1]
│           0x08049562      50             push eax                    ; const char *format
│           0x08049563      e858fbffff     sym.imp.__isoc99_scanf ()   ; int scanf(const char *format)
│           0x08049568      83c410         esp += 0x10
│           0x0804956b      e8d0faffff     sym.imp.getchar ()          ; int getchar(void)
│           0x08049570      8b85e4fdffff   eax = dword [size]
│           0x08049576      83f840         var = eax - 0x40            ; '@' ; 64
│       ┌─< 0x08049579      7e23           if (var <= 0) goto 0x804959e
│       │   0x0804957b      83ec08         esp -= 8
│       │   0x0804957e      8b83f0ffffff   eax = dword [ebx - 0x10]
│       │   0x08049584      50             push eax
│       │   0x08049585      8d8324e0ffff   eax = str.Flag:_hahahano._But_system_is_at__d ; 0x804a024 ; "Flag: hahahano. But system is at %d"
│       │   0x0804958b      50             push eax                    ; const char *format
│       │   0x0804958c      e89ffaffff     sym.imp.printf ()           ; int printf(const char *format)
│       │   0x08049591      83c410         esp += 0x10
│       │   0x08049594      83ec0c         esp -= 0xc
│       │   0x08049597      6a01           push 1                      ; 1 ; int status
│       │   0x08049599      e8f2faffff     sym.imp.exit ()             ; void exit(int status)
│       │   ; CODE XREF from sym.game (0x8049579)
│       └─> 0x0804959e      c785e8fdffff.  dword [i] = 0
│       ┌─< 0x080495a8      eb68           goto 0x8049612
│       │   ; CODE XREF from sym.game (0x804961e)
│      ┌──> 0x080495aa      83ec0c         esp -= 0xc
│      ⁝│   0x080495ad      6a64           push 0x64                   ; 'd' ; 100 ; size_t size
│      ⁝│   0x080495af      e8bcfaffff     sym.imp.malloc ()           ; void *malloc(size_t size)
│      ⁝│   0x080495b4      83c410         esp += 0x10
│      ⁝│   0x080495b7      8985ecfdffff   dword [str] = eax
│      ⁝│   0x080495bd      83ec0c         esp -= 0xc
│      ⁝│   0x080495c0      8d8348e0ffff   eax = str.Give_me:          ; 0x804a048 ; "Give me: "
│      ⁝│   0x080495c6      50             push eax                    ; const char *format
│      ⁝│   0x080495c7      e864faffff     sym.imp.printf ()           ; int printf(const char *format)
│      ⁝│   0x080495cc      83c410         esp += 0x10
│      ⁝│   0x080495cf      8b83f8ffffff   eax = dword [ebx - 8]
│      ⁝│   0x080495d5      8b00           eax = dword [eax]
│      ⁝│   0x080495d7      83ec04         esp -= 4
│      ⁝│   0x080495da      50             push eax                    ; FILE *stream
│      ⁝│   0x080495db      6a64           push 0x64                   ; 'd' ; 100 ; int size
│      ⁝│   0x080495dd      ffb5ecfdffff   push dword [str]            ; char *s
│      ⁝│   0x080495e3      e868faffff     sym.imp.fgets ()            ; char *fgets(char *s, int size, FILE *stream)
│      ⁝│   0x080495e8      83c410         esp += 0x10
│      ⁝│   0x080495eb      8bb5e8fdffff   esi = dword [i]
│      ⁝│   0x080495f1      8d4601         eax = [esi + 1]             ; 1
│      ⁝│   0x080495f4      8985e8fdffff   dword [i] = eax
│      ⁝│   0x080495fa      83ec0c         esp -= 0xc
│      ⁝│   0x080495fd      ffb5ecfdffff   push dword [str]            ; const char *str
│      ⁝│   0x08049603      e8c8faffff     sym.imp.atof ()             ; double atof(const char *str)
│      ⁝│   0x08049608      83c410         esp += 0x10
│      ⁝│   0x0804960b      dd9cf5f0fdff.  fstp qword [ebp + esi*8 - 0x210]
│      ⁝│   ; CODE XREF from sym.game (0x80495a8)
│      ⁝└─> 0x08049612      8b85e4fdffff   eax = dword [size]
│      ⁝    0x08049618      3985e8fdffff   var = dword [i] - eax       ; [0x13:4]=-1 ; 19
│      └──< 0x0804961e      7c8a           jl 0x80495aa
│           0x08049620      83ec08         esp -= 8
│           0x08049623      8d85f0fdffff   eax = [money_d]
│           0x08049629      50             push eax
│           0x0804962a      8d85e4fdffff   eax = [size]
│           0x08049630      50             push eax
│           0x08049631      e856feffff     sym.printArray ()
│           0x08049636      83c410         esp += 0x10
│           0x08049639      83ec08         esp -= 8
│           0x0804963c      8d85f0fdffff   eax = [money_d]
│           0x08049642      50             push eax
│           0x08049643      8d85e4fdffff   eax = [size]
│           0x08049649      50             push eax
│           0x0804964a      e8a7fbffff     sym.sumArray ()
│           0x0804964f      83c410         esp += 0x10
│           0x08049652      83ec04         esp -= 4
│           0x08049655      8d6424f8       esp = [esp - 8]
│           0x08049659      dd1c24         fstp qword [esp]
│           0x0804965c      8d8352e0ffff   eax = str.Sum:__f           ; 0x804a052 ; "Sum: %f\n"
│           0x08049662      50             push eax                    ; const char *format
│           0x08049663      e8c8f9ffff     sym.imp.printf ()           ; int printf(const char *format)
│           0x08049668      83c410         esp += 0x10
│           0x0804966b      83ec08         esp -= 8
│           0x0804966e      8d85f0fdffff   eax = [money_d]
│           0x08049674      50             push eax
│           0x08049675      8d85e4fdffff   eax = [size]
│           0x0804967b      50             push eax
│           0x0804967c      e8c4fbffff     sym.maxArray ()
│           0x08049681      83c410         esp += 0x10
│           0x08049684      83ec04         esp -= 4
│           0x08049687      8d6424f8       esp = [esp - 8]
│           0x0804968b      dd1c24         fstp qword [esp]
│           0x0804968e      8d835be0ffff   eax = str.Max:__f           ; 0x804a05b ; "Max: %f\n"
│           0x08049694      50             push eax                    ; const char *format
│           0x08049695      e896f9ffff     sym.imp.printf ()           ; int printf(const char *format)
│           0x0804969a      83c410         esp += 0x10
│           0x0804969d      83ec08         esp -= 8
│           0x080496a0      8d85f0fdffff   eax = [money_d]
│           0x080496a6      50             push eax
│           0x080496a7      8d85e4fdffff   eax = [size]
│           0x080496ad      50             push eax
│           0x080496ae      e8f4fbffff     sym.minArray ()
│           0x080496b3      83c410         esp += 0x10
│           0x080496b6      83ec04         esp -= 4
│           0x080496b9      8d6424f8       esp = [esp - 8]
│           0x080496bd      dd1c24         fstp qword [esp]
│           0x080496c0      8d8364e0ffff   eax = str.Min:__f           ; 0x804a064 ; "Min: %f\n"
│           0x080496c6      50             push eax                    ; const char *format
│           0x080496c7      e864f9ffff     sym.imp.printf ()           ; int printf(const char *format)
│           0x080496cc      83c410         esp += 0x10
│           0x080496cf      83ec08         esp -= 8
│           0x080496d2      dd8330e1ffff   fld qword [ebx - 0x1ed0]
│           0x080496d8      8d6424f8       esp = [esp - 8]
│           0x080496dc      dd1c24         fstp qword [esp]
│           0x080496df      dd8338e1ffff   fld qword [ebx - 0x1ec8]
│           0x080496e5      8d6424f8       esp = [esp - 8]
│           0x080496e9      dd1c24         fstp qword [esp]
│           0x080496ec      8d85f0fdffff   eax = [money_d]
│           0x080496f2      50             push eax
│           0x080496f3      8d85e4fdffff   eax = [size]
│           0x080496f9      50             push eax
│           0x080496fa      e80afcffff     sym.findArray ()
│           0x080496ff      83c420         esp += 0x20
│           0x08049702      dd84c5f0fdff.  fld qword [ebp + eax*8 - 0x210]
│           0x08049709      83ec04         esp -= 4
│           0x0804970c      8d6424f8       esp = [esp - 8]
│           0x08049710      dd1c24         fstp qword [esp]
│           0x08049713      8d8370e0ffff   eax = str.My_favorite_number_you_entered_is:__f ; 0x804a070 ; "My favorite number you entered is: %f\n"
│           0x08049719      50             push eax                    ; const char *format
│           0x0804971a      e811f9ffff     sym.imp.printf ()           ; int printf(const char *format)
│           0x0804971f      83c410         esp += 0x10
│           0x08049722      83ec08         esp -= 8
│           0x08049725      8d85f0fdffff   eax = [money_d]
│           0x0804972b      50             push eax
│           0x0804972c      8d85e4fdffff   eax = [size]
│           0x08049732      50             push eax
│           0x08049733      e881fcffff     sym.sortArray ()
│           0x08049738      83c410         esp += 0x10
│           0x0804973b      83ec0c         esp -= 0xc
│           0x0804973e      8d8397e0ffff   eax = str.Sorted_Array:     ; 0x804a097 ; "Sorted Array:"
│           0x08049744      50             push eax                    ; const char *s
│           0x08049745      e836f9ffff     sym.imp.puts ()             ; int puts(const char *s)
│           0x0804974a      83c410         esp += 0x10
│           0x0804974d      83ec08         esp -= 8
│           0x08049750      8d85f0fdffff   eax = [money_d]
│           0x08049756      50             push eax
│           0x08049757      8d85e4fdffff   eax = [size]
│           0x0804975d      50             push eax
│           0x0804975e      e829fdffff     sym.printArray ()
│           0x08049763      83c410         esp += 0x10
│           0x08049766      90
│           0x08049767      8b55f4         edx = dword [stack_canary]
│           0x0804976a      653315140000.  edx ^= dword gs:[0x14]
│       ┌─< 0x08049771      7405           if (!var) goto 0x8049778
│       │   0x08049773      e848010000     sym.__stack_chk_fail_local ()
│       │   ; CODE XREF from sym.game (0x8049771)
│       └─> 0x08049778      8d65f8         esp = [local_8h]
│           0x0804977b      5b             pop ebx
│           0x0804977c      5e             pop esi
│           0x0804977d      5d
└           0x0804977e      c3             return
┌ (fcn) sym.printArray 118
│   sym.printArray (int size, int money_d);
│           ; var signed int i @ ebp-0xc
│           ; var int local_4h @ ebp-0x4
│           ; arg int size @ ebp+0x8
│           ; arg int money_d @ ebp+0xc
│           ; CALL XREFS from sym.game (0x8049631, 0x804975e)
│           0x0804948c      55             push ebp
│           0x0804948d      89e5           mov ebp, esp
│           0x0804948f      53             push ebx
│           0x08049490      83ec14         sub esp, 0x14
│           0x08049493      e898fcffff     call sym.__x86.get_pc_thunk.bx
│           0x08049498      81c3682b0000   add ebx, 0x2b68             ; 'h+'
│           0x0804949e      c745f4000000.  mov dword [i], 0
│       ┌─< 0x080494a5      eb4b           jmp 0x80494f2
│       │   ; CODE XREF from sym.printArray (0x80494fa)
│      ┌──> 0x080494a7      8b45f4         mov eax, dword [i]
│      ⁝│   0x080494aa      8d14c5000000.  lea edx, [eax*8]
│      ⁝│   0x080494b1      8b450c         mov eax, dword [money_d]    ; [0xc:4]=-1 ; 12
│      ⁝│   0x080494b4      01d0           add eax, edx
│      ⁝│   0x080494b6      dd00           fld qword [eax]
│      ⁝│   0x080494b8      8b45f4         mov eax, dword [i]
│      ⁝│   0x080494bb      8d14c5000000.  lea edx, [eax*8]
│      ⁝│   0x080494c2      8b450c         mov eax, dword [money_d]    ; [0xc:4]=-1 ; 12
│      ⁝│   0x080494c5      01d0           add eax, edx
│      ⁝│   0x080494c7      dd00           fld qword [eax]
│      ⁝│   0x080494c9      d9c9           fxch st(1)
│      ⁝│   0x080494cb      83ec08         sub esp, 8
│      ⁝│   0x080494ce      8d6424f8       lea esp, [esp - 8]
│      ⁝│   0x080494d2      dd1c24         fstp qword [esp]
│      ⁝│   0x080494d5      8d6424f8       lea esp, [esp - 8]
│      ⁝│   0x080494d9      dd1c24         fstp qword [esp]
│      ⁝│   0x080494dc      ff75f4         push dword [i]
│      ⁝│   0x080494df      8d8308e0ffff   lea eax, [ebx - 0x1ff8]
│      ⁝│   0x080494e5      50             push eax                    ; const char *format
│      ⁝│   0x080494e6      e845fbffff     call sym.imp.printf         ; int printf(const char *format)
│      ⁝│   0x080494eb      83c420         add esp, 0x20
│      ⁝│   0x080494ee      8345f401       add dword [i], 1
│      ⁝│   ; CODE XREF from sym.printArray (0x80494a5)
│      ⁝└─> 0x080494f2      8b4508         mov eax, dword [size]       ; [0x8:4]=-1 ; 8
│      ⁝    0x080494f5      8b00           mov eax, dword [eax]
│      ⁝    0x080494f7      3945f4         cmp dword [i], eax          ; [0x13:4]=-1 ; 19
│      └──< 0x080494fa      7cab           jl 0x80494a7
│           0x080494fc      90             nop
│           0x080494fd      8b5dfc         mov ebx, dword [local_4h]
│           0x08049500      c9             leave
└           0x08049501      c3             ret
┌ (fcn) sym.sumArray 79
│   sym.sumArray (int *size, double *money_d);
│           ; var int d_ptr @ ebp-0x10
│           ; var unsigned int end @ ebp-0xc
│           ; var double sum @ ebp-0x8
│           ; arg int *size @ ebp+0x8
│           ; arg double *money_d @ ebp+0xc
│           ; CALL XREF from sym.game (0x804964a)
│           0x080491f6      55             push ebp
│           0x080491f7      89e5           mov ebp, esp
│           0x080491f9      83ec10         sub esp, 0x10
│           0x080491fc      e801030000     call sym.__x86.get_pc_thunk.ax
│           0x08049201      05ff2d0000     add eax, 0x2dff
│           0x08049206      d9ee           fldz
│           0x08049208      dd5df8         fstp qword [sum]
│           0x0804920b      8b450c         mov eax, dword [money_d]    ; [0xc:4]=-1 ; 12
│           0x0804920e      8945f0         mov dword [d_ptr], eax
│           0x08049211      8b4508         mov eax, dword [size]       ; [0x8:4]=-1 ; 8
│           0x08049214      8b00           mov eax, dword [eax]
│           0x08049216      8d14c5000000.  lea edx, [eax*8]
│           0x0804921d      8b45f0         mov eax, dword [d_ptr]
│           0x08049220      01d0           add eax, edx
│           0x08049222      8945f4         mov dword [end], eax
│       ┌─< 0x08049225      eb11           jmp 0x8049238
│       │   ; CODE XREF from sym.sumArray (0x804923e)
│      ┌──> 0x08049227      8b45f0         mov eax, dword [d_ptr]
│      ⁝│   0x0804922a      dd00           fld qword [eax]
│      ⁝│   0x0804922c      dd45f8         fld qword [sum]
│      ⁝│   0x0804922f      dec1           faddp st(1)
│      ⁝│   0x08049231      dd5df8         fstp qword [sum]
│      ⁝│   0x08049234      8345f008       add dword [d_ptr], 8
│      ⁝│   ; CODE XREF from sym.sumArray (0x8049225)
│      ⁝└─> 0x08049238      8b45f0         mov eax, dword [d_ptr]
│      ⁝    0x0804923b      3b45f4         cmp eax, dword [end]
│      └──< 0x0804923e      72e7           jb 0x8049227
│           0x08049240      dd45f8         fld qword [sum]
│           0x08049243      c9             leave
└           0x08049244      c3             ret
┌ (fcn) sym.maxArray 98
│   sym.maxArray (int *size, double *arr);
│           ; var signed int i @ ebp-0xc
│           ; var double maximum @ ebp-0x8
│           ; arg int *size @ ebp+0x8
│           ; arg double *arr @ ebp+0xc
│           ; CALL XREF from sym.game (0x804967c)
│           0x08049245      55             push ebp
│           0x08049246      89e5           ebp = esp
│           0x08049248      83ec10         esp -= 0x10
│           0x0804924b      e8b2020000     sym.__x86.get_pc_thunk.ax ()
│           0x08049250      05b02d0000     eax += 0x2db0
│           0x08049255      8b450c         eax = dword [arr]           ; [0xc:4]=-1 ; 12
│           0x08049258      dd00           fld qword [eax]
│           0x0804925a      dd5df8         fstp qword [maximum]
│           0x0804925d      c745f4000000.  dword [i] = 0
│       ┌─< 0x08049264      eb32           goto 0x8049298
│       │   ; CODE XREF from sym.maxArray (0x80492a0)
│      ┌──> 0x08049266      8b45f4         eax = dword [i]
│      ⁝│   0x08049269      8d14c5000000.  edx = [eax*8]
│      ⁝│   0x08049270      8b450c         eax = dword [arr]           ; [0xc:4]=-1 ; 12
│      ⁝│   0x08049273      01d0           eax += edx
│      ⁝│   0x08049275      dd45f8         fld qword [maximum]
│      ⁝│   0x08049278      dd00           fld qword [eax]
│      ⁝│   0x0804927a      dff1           fcomip st(1)
│      ⁝│   0x0804927c      ddd8           fstp st(0)
│     ┌───< 0x0804927e      7614           if (((unsigned) var) <= 0) goto 0x8049294
│     │⁝│   0x08049280      8b45f4         eax = dword [i]
│     │⁝│   0x08049283      8d14c5000000.  edx = [eax*8]
│     │⁝│   0x0804928a      8b450c         eax = dword [arr]           ; [0xc:4]=-1 ; 12
│     │⁝│   0x0804928d      01d0           eax += edx
│     │⁝│   0x0804928f      dd00           fld qword [eax]
│     │⁝│   0x08049291      dd5df8         fstp qword [maximum]
│     │⁝│   ; CODE XREF from sym.maxArray (0x804927e)
│     └───> 0x08049294      8345f401       dword [i] += 1
│      ⁝│   ; CODE XREF from sym.maxArray (0x8049264)
│      ⁝└─> 0x08049298      8b4508         eax = dword [size]          ; [0x8:4]=-1 ; 8
│      ⁝    0x0804929b      8b00           eax = dword [eax]
│      ⁝    0x0804929d      3945f4         var = dword [i] - eax       ; [0x13:4]=-1 ; 19
│      └──< 0x080492a0      7cc4           jl 0x8049266
│           0x080492a2      dd45f8         fld qword [maximum]
│           0x080492a5      c9             leave
└           0x080492a6      c3             return
┌ (fcn) sym.minArray 98
│   sym.minArray (int *size, double *arr);
│           ; var signed int i @ ebp-0xc
│           ; var double mini @ ebp-0x8
│           ; arg int *size @ ebp+0x8
│           ; arg double *arr @ ebp+0xc
│           ; CALL XREF from sym.game (0x80496ae)
│           0x080492a7      55             push ebp
│           0x080492a8      89e5           ebp = esp
│           0x080492aa      83ec10         esp -= 0x10
│           0x080492ad      e850020000     sym.__x86.get_pc_thunk.ax ()
│           0x080492b2      054e2d0000     eax += 0x2d4e               ; 'N-'
│           0x080492b7      8b450c         eax = dword [arr]           ; [0xc:4]=-1 ; 12
│           0x080492ba      dd00           fld qword [eax]
│           0x080492bc      dd5df8         fstp qword [mini]
│           0x080492bf      c745f4000000.  dword [i] = 0
│       ┌─< 0x080492c6      eb32           goto 0x80492fa
│       │   ; CODE XREF from sym.minArray (0x8049302)
│      ┌──> 0x080492c8      8b45f4         eax = dword [i]
│      ⁝│   0x080492cb      8d14c5000000.  edx = [eax*8]
│      ⁝│   0x080492d2      8b450c         eax = dword [arr]           ; [0xc:4]=-1 ; 12
│      ⁝│   0x080492d5      01d0           eax += edx
│      ⁝│   0x080492d7      dd00           fld qword [eax]
│      ⁝│   0x080492d9      dd45f8         fld qword [mini]
│      ⁝│   0x080492dc      dff1           fcomip st(1)
│      ⁝│   0x080492de      ddd8           fstp st(0)
│     ┌───< 0x080492e0      7614           if (((unsigned) var) <= 0) goto 0x80492f6
│     │⁝│   0x080492e2      8b45f4         eax = dword [i]
│     │⁝│   0x080492e5      8d14c5000000.  edx = [eax*8]
│     │⁝│   0x080492ec      8b450c         eax = dword [arr]           ; [0xc:4]=-1 ; 12
│     │⁝│   0x080492ef      01d0           eax += edx
│     │⁝│   0x080492f1      dd00           fld qword [eax]
│     │⁝│   0x080492f3      dd5df8         fstp qword [mini]
│     │⁝│   ; CODE XREF from sym.minArray (0x80492e0)
│     └───> 0x080492f6      8345f401       dword [i] += 1
│      ⁝│   ; CODE XREF from sym.minArray (0x80492c6)
│      ⁝└─> 0x080492fa      8b4508         eax = dword [size]          ; [0x8:4]=-1 ; 8
│      ⁝    0x080492fd      8b00           eax = dword [eax]
│      ⁝    0x080492ff      3945f4         var = dword [i] - eax       ; [0x13:4]=-1 ; 19
│      └──< 0x08049302      7cc4           jl 0x80492c8
│           0x08049304      dd45f8         fld qword [mini]
│           0x08049307      c9             leave
└           0x08049308      c3             return
┌ (fcn) sym.findArray 176
│   sym.findArray (int *size, double *arr, double low, double high);
│           ; var double high_h @ ebp-0x20
│           ; var double low_h @ ebp-0x18
│           ; var int m_size @ ebp-0x4
│           ; arg int *size @ ebp+0x8
│           ; arg double *arr @ ebp+0xc
│           ; arg double low @ ebp+0x10
│           ; arg double high @ ebp+0x18
│           ; CALL XREF from sym.game (0x80496fa)
│           0x08049309      55             push ebp
│           0x0804930a      89e5           ebp = esp
│           0x0804930c      83ec20         esp -= 0x20
│           0x0804930f      e8ee010000     sym.__x86.get_pc_thunk.ax ()
│           0x08049314      05ec2c0000     eax += 0x2cec
│           0x08049319      8b4510         eax = dword [low]           ; [0x10:4]=-1 ; 16
│           0x0804931c      8945e8         dword [low_h] = eax
│           0x0804931f      8b4514         eax = dword [ebp + 0x14]    ; [0x14:4]=-1 ; 20
│           0x08049322      8945ec         dword [ebp - 0x14] = eax
│           0x08049325      8b4518         eax = dword [high]          ; [0x18:4]=-1 ; 24
│           0x08049328      8945e0         dword [high_h] = eax
│           0x0804932b      8b451c         eax = dword [ebp + 0x1c]    ; [0x1c:4]=-1 ; 28
│           0x0804932e      8945e4         dword [ebp - 0x1c] = eax
│           0x08049331      8b4508         eax = dword [size]          ; [0x8:4]=-1 ; 8
│           0x08049334      8b00           eax = dword [eax]
│           0x08049336      8945fc         dword [m_size] = eax
│       ┌─< 0x08049339      eb61           goto 0x804939c
│       │   ; CODE XREF from sym.findArray (0x80493a8)
│      ┌──> 0x0804933b      8b4508         eax = dword [size]          ; [0x8:4]=-1 ; 8
│      ⁝│   0x0804933e      8b00           eax = dword [eax]
│      ⁝│   0x08049340      89c2           edx = eax
│      ⁝│   0x08049342      8b45fc         eax = dword [m_size]
│      ⁝│   0x08049345      29c2           edx -= eax 			; size - m_size
│      ⁝│   0x08049347      89d0           eax = edx
│      ⁝│   0x08049349      8d14c5000000.  edx = [eax*8]
│      ⁝│   0x08049350      8b450c         eax = dword [arr]           ; [0xc:4]=-1 ; 12
│      ⁝│   0x08049353      01d0           eax += edx
│      ⁝│   0x08049355      dd45e8         fld qword [low_h]
│      ⁝│   0x08049358      dd00           fld qword [eax]
│      ⁝│   0x0804935a      dff1           fcomip st(1)
│      ⁝│   0x0804935c      ddd8           fstp st(0)
│     ┌───< 0x0804935e      762f           if (((unsigned) var) <= 0) goto 0x804938f
│     │⁝│   0x08049360      8b4508         eax = dword [size]          ; [0x8:4]=-1 ; 8
│     │⁝│   0x08049363      8b00           eax = dword [eax]
│     │⁝│   0x08049365      89c2           edx = eax
│     │⁝│   0x08049367      8b45fc         eax = dword [m_size]
│     │⁝│   0x0804936a      29c2           edx -= eax
│     │⁝│   0x0804936c      89d0           eax = edx
│     │⁝│   0x0804936e      8d14c5000000.  edx = [eax*8]
│     │⁝│   0x08049375      8b450c         eax = dword [arr]           ; [0xc:4]=-1 ; 12
│     │⁝│   0x08049378      01d0           eax += edx
│     │⁝│   0x0804937a      dd00           fld qword [eax]
│     │⁝│   0x0804937c      dd45e0         fld qword [high_h]
│     │⁝│   0x0804937f      dff1           fcomip st(1)
│     │⁝│   0x08049381      ddd8           fstp st(0)
│    ┌────< 0x08049383      760a           if (((unsigned) var) <= 0) goto 0x804938f
│    ││⁝│   0x08049385      8b4508         eax = dword [size]          ; [0x8:4]=-1 ; 8
│    ││⁝│   0x08049388      8b00           eax = dword [eax]
│    ││⁝│   0x0804938a      2b45fc         eax -= dword [m_size]
│   ┌─────< 0x0804938d      eb28           goto 0x80493b7
│   │││⁝│   ; CODE XREFS from sym.findArray (0x804935e, 0x8049383)
│   │└└───> 0x0804938f      8b4508         eax = dword [size]          ; [0x8:4]=-1 ; 8
│   │  ⁝│   0x08049392      8b00           eax = dword [eax]
│   │  ⁝│   0x08049394      8d5001         edx = [eax + 1]             ; 1
│   │  ⁝│   0x08049397      8b4508         eax = dword [size]          ; [0x8:4]=-1 ; 8
│   │  ⁝│   0x0804939a      8910           dword [eax] = edx
│   │  ⁝│   ; CODE XREF from sym.findArray (0x8049339)
│   │  ⁝└─> 0x0804939c      8b4508         eax = dword [size]          ; [0x8:4]=-1 ; 8
│   │  ⁝    0x0804939f      8b00           eax = dword [eax]
│   │  ⁝    0x080493a1      8b55fc         edx = dword [m_size]
│   │  ⁝    0x080493a4      01d2           edx += edx
│   │  ⁝    0x080493a6      39d0           var = eax - edx
│   │  └──< 0x080493a8      7c91           jl 0x804933b
│   │       0x080493aa      8b4508         eax = dword [size]          ; [0x8:4]=-1 ; 8
│   │       0x080493ad      8b55fc         edx = dword [m_size]
│   │       0x080493b0      8910           dword [eax] = edx
│   │       0x080493b2      b800000000     eax = 0
│   │       ; CODE XREF from sym.findArray (0x804938d)
│   └─────> 0x080493b7      c9             leave
└           0x080493b8      c3             return
┌ (fcn) sym.sortArray 211
│   sym.sortArray (int *size, double *arr);
│           ; var signed int j @ ebp-0x10
│           ; var signed int i @ ebp-0xc
│           ; var double tmp @ ebp-0x8
│           ; arg int *size @ ebp+0x8
│           ; arg double *arr @ ebp+0xc
│           ; CALL XREF from sym.game (0x8049733)
│           0x080493b9      55             push ebp
│           0x080493ba      89e5           ebp = esp
│           0x080493bc      83ec10         esp -= 0x10
│           0x080493bf      e83e010000     sym.__x86.get_pc_thunk.ax ()
│           0x080493c4      053c2c0000     eax += 0x2c3c               ; '<,'
│           0x080493c9      c745f0000000.  dword [j] = 0
│       ┌─< 0x080493d0      e9a2000000     goto 0x8049477
│       │   ; CODE XREF from sym.sortArray (0x804947f)
│      ┌──> 0x080493d5      c745f4000000.  dword [i] = 0
│     ┌───< 0x080493dc      e981000000     goto 0x8049462
│     │⁝│   ; CODE XREF from sym.sortArray (0x804946d)
│    ┌────> 0x080493e1      8b45f4         eax = dword [i]
│    ⁝│⁝│   0x080493e4      8d14c5000000.  edx = [eax*8]
│    ⁝│⁝│   0x080493eb      8b450c         eax = dword [arr]           ; [0xc:4]=-1 ; 12
│    ⁝│⁝│   0x080493ee      01d0           eax += edx
│    ⁝│⁝│   0x080493f0      dd00           fld qword [eax]
│    ⁝│⁝│   0x080493f2      8b45f4         eax = dword [i]
│    ⁝│⁝│   0x080493f5      83c001         eax += 1
│    ⁝│⁝│   0x080493f8      8d14c5000000.  edx = [eax*8]
│    ⁝│⁝│   0x080493ff      8b450c         eax = dword [arr]           ; [0xc:4]=-1 ; 12
│    ⁝│⁝│   0x08049402      01d0           eax += edx
│    ⁝│⁝│   0x08049404      dd00           fld qword [eax]
│    ⁝│⁝│   0x08049406      d9c9           st(1), = ,st(1)
│    ⁝│⁝│   0x08049408      dff1           fcomip st(1)
│    ⁝│⁝│   0x0804940a      ddd8           fstp st(0)
│   ┌─────< 0x0804940c      7650           if (((unsigned) var) <= 0) goto 0x804945e
│   │⁝│⁝│   0x0804940e      8b45f4         eax = dword [i]
│   │⁝│⁝│   0x08049411      8d14c5000000.  edx = [eax*8]
│   │⁝│⁝│   0x08049418      8b450c         eax = dword [arr]           ; [0xc:4]=-1 ; 12
│   │⁝│⁝│   0x0804941b      01d0           eax += edx
│   │⁝│⁝│   0x0804941d      dd00           fld qword [eax]
│   │⁝│⁝│   0x0804941f      dd5df8         fstp qword [tmp]
│   │⁝│⁝│   0x08049422      8b45f4         eax = dword [i]
│   │⁝│⁝│   0x08049425      83c001         eax += 1
│   │⁝│⁝│   0x08049428      8d14c5000000.  edx = [eax*8]
│   │⁝│⁝│   0x0804942f      8b450c         eax = dword [arr]           ; [0xc:4]=-1 ; 12
│   │⁝│⁝│   0x08049432      01c2           edx += eax
│   │⁝│⁝│   0x08049434      8b45f4         eax = dword [i]
│   │⁝│⁝│   0x08049437      8d0cc5000000.  ecx = [eax*8]
│   │⁝│⁝│   0x0804943e      8b450c         eax = dword [arr]           ; [0xc:4]=-1 ; 12
│   │⁝│⁝│   0x08049441      01c8           eax += ecx
│   │⁝│⁝│   0x08049443      dd02           fld qword [edx]
│   │⁝│⁝│   0x08049445      dd18           fstp qword [eax]
│   │⁝│⁝│   0x08049447      8b45f4         eax = dword [i]
│   │⁝│⁝│   0x0804944a      83c001         eax += 1
│   │⁝│⁝│   0x0804944d      8d14c5000000.  edx = [eax*8]
│   │⁝│⁝│   0x08049454      8b450c         eax = dword [arr]           ; [0xc:4]=-1 ; 12
│   │⁝│⁝│   0x08049457      01d0           eax += edx
│   │⁝│⁝│   0x08049459      dd45f8         fld qword [tmp]
│   │⁝│⁝│   0x0804945c      dd18           fstp qword [eax]
│   │⁝│⁝│   ; CODE XREF from sym.sortArray (0x804940c)
│   └─────> 0x0804945e      8345f401       dword [i] += 1
│    ⁝│⁝│   ; CODE XREF from sym.sortArray (0x80493dc)
│    ⁝└───> 0x08049462      8b4508         eax = dword [size]          ; [0x8:4]=-1 ; 8
│    ⁝ ⁝│   0x08049465      8b00           eax = dword [eax]
│    ⁝ ⁝│   0x08049467      83e801         eax -= 1
│    ⁝ ⁝│   0x0804946a      3945f4         var = dword [i] - eax       ; [0x13:4]=-1 ; 19
│    └────< 0x0804946d      0f8c6effffff   jl 0x80493e1
│      ⁝│   0x08049473      8345f001       dword [j] += 1
│      ⁝│   ; CODE XREF from sym.sortArray (0x80493d0)
│      ⁝└─> 0x08049477      8b4508         eax = dword [size]          ; [0x8:4]=-1 ; 8
│      ⁝    0x0804947a      8b00           eax = dword [eax]
│      ⁝    0x0804947c      3945f0         var = dword [j] - eax       ; [0x13:4]=-1 ; 19
│      └──< 0x0804947f      0f8c50ffffff   jl 0x80493d5
│           0x08049485      b801000000     eax = 1
│           0x0804948a      c9
└           0x0804948b      c3             return 1
