; FILE: macro.asm -- Header file to be included in other files
; MSSV: 15520599

%define stdin 0
%define stdout 1
%define sys_exit 1
%define sys_fork 2
%define sys_read 3
%define sys_write 4
%define sys_open 5
%define sys_close 6

section .data
	newline db 0xa, 0x0
	newline_len equ 2

section .text ; new modification
; print str, len
%macro print 2
	; write(stdout, len, str)
	mov ecx, %1
	mov edx, %2
	mov ebx, stdout
	mov eax, sys_write
	int 0x80
%endmacro

%macro printl 0
	; write(stdout, newline_len, newline);
	mov ecx, newline
	mov edx, newline_len
	mov ebx, stdout
	mov eax, sys_write
	int 0x80
%endmacro

%macro exit 1
	; exit(%1)
	mov ebx, %1
	mov eax, sys_exit
	int 0x80
%endmacro

%macro prologue 1
	; %1: number of bytes to allocate to local vars
	push ebp
	mov ebp, esp
	sub esp, %1
%endmacro

%macro epilogue 0
	mov esp, ebp
	pop ebp
	ret
%endmacro

;------------------------------------------
; int slen(String message)
; String length calculation function
%macro slen 1
    push    ebx
    mov 	eax, %1
    mov     ebx, eax

nextchar:
    cmp     byte [eax], 0
    jz      finished
    inc     eax
    jmp     nextchar

finished:
    sub     eax, ebx
    pop     ebx
    ret
%endmacro
