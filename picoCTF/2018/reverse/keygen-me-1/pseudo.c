
/**
 Return from 0-35
 Maybe base36
 */
int ord(int ch)
{
  if ('0' <= ch && ch <= '9')
    return ch - '0';
  if ('A' <= ch && ch <= 'Z')
    return ch - 55;
  puts('??');
  exit(0);
}

int validate_key(char *keybuf)
{
  size_t len = strlen(keybuf);
  size_t i = 0;
  size_t j;
  for (j = 0; j < len - 1; ++j) {
    i += (j + 1) * (ord(keybuf[j]) + 1);
  }
  return i % 36 == ord(keybuf[len - 1]) ? 1 : 0;
}

