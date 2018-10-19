.intel_syntax noprefix
.bits 32

.global asm2

asm2:
	; a @ ebp+0x8
	; b @ ebp+0xc
	;
	push   	ebp
	mov    	ebp,esp
	sub    	esp,0x10
	mov    	eax,DWORD PTR [b]
	mov 	DWORD PTR [ebp-0x4],eax
	mov    	eax,DWORD PTR [a]
	mov	DWORD PTR [ebp-0x8],eax
	jmp    	part_b
part_a:
	add    	DWORD PTR [ebp-0x4],0x1
	add	DWORD PTR [a],0x64
part_b:
	cmp    	DWORD PTR [a],0x1d89
	jle    	part_a
	mov    	eax,DWORD PTR [ebp-0x4]
	mov	esp,ebp
	pop	ebp
	ret
