int key;
char flag[] = '???';

void calc(int a)
{
  if (n <= 4) {
    return n*n + 0x2345;
  }
  return ((calc(n - 1) - calc(n - 2)) + (calc(n - 3) - calc(n - 4))) + (calc(n - 5) * 0x1234);
}

void get_key()
{
  key = calc(0x186b5);
}

void decrypt_flag(int key)
{
  for (int i = 0; i < 0x29; ++i)
  {
    flag[i] ^= ((char *)&k)[i & 3];
    if ((i & 3) == 3) {
      k += 1;
    }
  }
}

int main(int argc, char const *argv[])
{
  decrypt_flag(key);
  return 0;
}
