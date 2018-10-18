#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#include "rotation.h"

char g_enc_flag[] = "\x11\x80\x20\xE0\x22\x53\x72\xA1\x01\x41\x55\x20\xA0\xC0\x25\xE3\x35\x40\x55\x30\x85\x55\x70\x20\xC1";

static void decrypt(char *buf);
static void encrypt(char *buf);
static void print_hex(char *buf, size_t len);

int main(int argc, char **argv)
{
  if (argc > 1) {
    char *buf = strdup(argv[1]);
    encrypt(buf);
    free(buf);
    return 0;
  }

  decrypt(g_enc_flag);
  puts(g_enc_flag);
  return 0;
}

static void encrypt(char *buf)
{
  size_t len = strlen(buf);
  char ch;

  for (size_t i = 0; i < len; ++i) {
    ch = rol4(buf[i]) ^ 0x16;
    buf[i] = ror8(ch);
  }

  print_hex(buf, len);
}

static void decrypt(char *buf)
{
  size_t len = strlen(buf);
  char ch;

  for (size_t i = 0; i < len; ++i) {
    ch = rol8(buf[i]) ^ 0x16;
    buf[i] = ror4(ch);
  }

  print_hex(buf, len);
}

static void print_hex(char *buf, size_t len)
{
  for (size_t i = 0; i < len; ++i) {
    printf("%02X ", buf[i]);
  }
  putchar('\n');
}
