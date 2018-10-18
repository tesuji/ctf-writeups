#include <stdio.h>

#define BASE 36

int main(int argc, char const *argv[])
{
  setvbuf(stdout, NULL, _IONBF, 0);

  if (argc <= 1) {
    puts("Usage: ./activate <PRODUCT_KEY>");
    return -1;
  }

  if (check_valid_key(argv[1]) == 0) {
    puts("Please Provide a VALID 16 byte Product Key.");
    return -1;
  }

  if (validate_key(argv[1]) == 0) {
    puts("INVALID Product Key.");
    return -1;
  }

  puts("Product Activated Successfully: ");
  print_flag();

  return 0;
}

int check_valid_key(char *key)
{
  if (key == NULL)
    return 0;

  char ch = *key;
  size_t i = 0;
  for (i = 0; (ch = key[i]) != 0; ++i) {
    if (check_valid_char(ch) == 0) {
      break;
    }
  }

  return (i == 16) ? i: 0;
}

int check_valid_char(char ch)
{
  if ('0' <= ch && ch <= '9')
    return 1;
  if ('A' <= ch && ch <= 'Z')
    return 1;
  return 0;
}

int validate_key(char *key)
{
  size_t len = strlen(key);
  if (
      key_constraint_01(key, len)
      && key_constraint_02(key, len)
      && key_constraint_03(key, len)
      && key_constraint_04(key, len)
      && key_constraint_05(key, len)
      && key_constraint_06(key, len)
      && key_constraint_07(key, len)
      && key_constraint_08(key, len)
      && key_constraint_09(key, len)
      && key_constraint_10(key, len)
      && key_constraint_11(key, len)
      && key_constraint_12(key, len)
    ) {
    return 1;
  }
  return 0;
}

int key_constraint_01(char *key, size_t len)
{
  return mymod(ord(key[0]) + ord(key[1]), BASE) == 14 ? 1 : 0;
}

int key_constraint_02(char *key, size_t len)
{
  return mymod(ord(key[2]) + ord(key[3]), BASE) == 24 ? 1 : 0;
}

int key_constraint_03(char *key, size_t len)
{
  return mymod(ord(key[2]) - ord(key[0]), BASE) == 6 ? 1 : 0;
}

int key_constraint_04(char *key, size_t len)
{
  return mymod(ord(key[1]) + ord(key[3]) + ord(key[5]), BASE) == 4 ? 1 : 0;
}

int key_constraint_05(char *key, size_t len)
{
  return mymod(ord(key[2]) + ord(key[4]) + ord(key[6]), BASE) == 13 ? 1 : 0;
}

int key_constraint_06(char *key, size_t len)
{
  return mymod(ord(key[3]) + ord(key[4]) + ord(key[5]), BASE) == 22 ? 1 : 0;
}

int key_constraint_07(char *key, size_t len)
{
  return mymod(ord(key[6]) + ord(key[8]) + ord(key[10]), BASE) == 31 ? 1 : 0;
}

int key_constraint_08(char *key, size_t len)
{
  return mymod(ord(key[1]) + ord(key[4]) + ord(key[7]), BASE) == 7 ? 1 : 0;
}

int key_constraint_09(char *key, size_t len)
{
  return mymod(ord(key[9]) + ord(key[12]) + ord(key[15]), BASE) == 20 ? 1 : 0;
}

int key_constraint_10(char *key, size_t len)
{
  return mymod(ord(key[13]) + ord(key[14]) + ord(key[15]), BASE) == 12 ? 1 : 0;
}

int key_constraint_11(char *key, size_t len)
{
  return mymod(ord(key[8]) + ord(key[9]) + ord(key[10]), BASE) == 27 ? 1 : 0;
}

int key_constraint_12(char *key, size_t len)
{
  return mymod(ord(key[7]) + ord(key[12]) + ord(key[13]), BASE) == 23 ? 1 : 0;
}

int ord(char ch)
{
  if ('0' <= ch && ch <= '9')
    return ch - '0';
  if ('A' <= ch && ch <= 'Z')
    return ch - ('A' - 10);
  puts("Found Invalid Character!");
  exit(0);
}

int mymod(int a, int b)
{
  int rs = a % b;
  return (rs < 0) ? b + rs : rs;
}
