#include "rotation.h"

unsigned char ror4 (unsigned char value)
{
  return __rolb(value, 4u);
}

unsigned char rol8 (unsigned char value)
{
  return __rorb(value, 8u);
}

unsigned char rol4 (unsigned char value)
{
  return __rolb(value, 4u);
}

unsigned char ror8 (unsigned char value)
{
  return __rorb(value, 8u);
}
