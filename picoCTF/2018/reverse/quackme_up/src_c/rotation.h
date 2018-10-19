#ifndef ROTATION_H_INCLUDED
#define ROTATION_H_INCLUDED

#if defined(__x86_64__) || defined(__i386__)
# include <x86intrin.h>
#else
# error "Use GCC to build"
#endif

unsigned char rol4 (unsigned char x);
unsigned char rol8 (unsigned char x);
unsigned char ror4 (unsigned char x);
unsigned char ror8 (unsigned char x);

#endif /* ROTATION_H_INCLUDED */
