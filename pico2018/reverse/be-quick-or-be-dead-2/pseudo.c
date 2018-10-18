#include <stdio.h>

int calculate_key(void)
{
  return fib(0x402);
}

int fib(int x)
{
  if (x <= 1) {
    return x;
  }

  return fib(x - 1) + fib(x - 2);
}

void decrypt_flag(int key)
{
  int k = key;
  for (int i = 0; i <= 0x38; ++i) {
    flag[i] ^= ((char *)&k)[i & 3];
    if ((i & 3) == 3) {
      k += 1;
    }
  }
}

void print_flag(void)
{
  int key = ???;
  decrypt_flag(key);
  puts(flag);
}


int main(void)
{
  print_flag();
  return 0;
}
