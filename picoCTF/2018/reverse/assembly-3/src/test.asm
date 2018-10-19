%include "macro.inc"

section .text
	global _start
_start:
	push ebp
	mov ebp, esp
	push DwORD 0x00
	push DwORD 0x00
	push DwORD 0x00
	push DwORD 0x00
	push DwORD 0xcc85310c
	push DwORD 0xda0f9ac5
	push DwORD 0xf238999b
	call asm3
	mov esp, ebp
	pop ebp
	exit 0
asm3:
	push   	ebp
	mov    	ebp,esp
	mov	eax,0xb6 		; eax = 0x000000b6
	xor	al,al 			; eax = 0x00000000
	mov	ah,BYTE [ebp+0x8]  	; eax = 0x0000c500
	sal	ax,0x10			; eax = 0x00000000
	sub	al,BYTE [ebp+0xf] 	; eax = 0x000000cc
	add	ah,BYTE [ebp+0xd] 	; eax = 0x000031cc
	xor	ax,WORD [ebp+0x12] 	; eax = 0x000031cc
	mov	esp, ebp
	pop	ebp
	ret
