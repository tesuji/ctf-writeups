/*
 gcc -m32 test.c
 ./a.out
 */
#include <inttypes.h>
#include <limits.h>
#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <time.h>
#include <unistd.h>

long cash = 2626;

long get_long(unsigned long long int bet)
{
  uint64_t l = bet;
  printf("l: %" PRId64 "\n", l);
  // 2147483647
  if (l >= LONG_MAX)
    puts("OK");
  else
    puts("NOT");
  return l;
}

int main(int argc, char const *argv[])
{
  long bet_in;
  if (argc >= 2) {
    bet_in = strtoull(argv[1], NULL, 10);
  }
  else {
    bet_in = 2147483646ULL;
  }

  long tmp = cash;
  long bet = get_long(bet_in);
  printf("bet: %ld\n", bet);
  if (bet > cash) {
    puts("You can't bet more than you have!");
  }

  printf("wrong %ld\n", (tmp - bet));
  printf("right %ld\n", (tmp + bet));
  return 0;
}
