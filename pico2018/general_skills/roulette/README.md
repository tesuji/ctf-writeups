# roulette - Points: 350 - (Solves: 196)

This Online [Roulette][1] Service is in Beta.
Can you find a way to win $1,000,000,000 and get the flag?
[Source][2].
Connect with nc 2018shell2.picoctf.com 48312

[1]: https://2018shell2.picoctf.com/static/2d8417ef7707fec56592db02da54575e/roulette
[2]: https://2018shell2.picoctf.com/static/2d8417ef7707fec56592db02da54575e/roulette.c

## Hints

There are 2 bugs!

----

```c
// ctags -x --c-kinds=vd roulette.c
HOTSTREAK        macro         9 roulette.c       #define HOTSTREAK 3
MAX_NUM_LEN      macro         8 roulette.c       #define MAX_NUM_LEN 12
MAX_WINS         macro        10 roulette.c       #define MAX_WINS 16
NUM_LOSE_MSGS    macro        16 roulette.c       #define NUM_LOSE_MSGS 5
NUM_WIN_MSGS     macro        15 roulette.c       #define NUM_WIN_MSGS 10
ONE_BILLION      macro        11 roulette.c       #define ONE_BILLION 1000000000
ROULETTE_SIZE    macro        12 roulette.c       #define ROULETTE_SIZE 36
ROULETTE_SLOWS   macro        14 roulette.c       #define ROULETTE_SLOWS 16
ROULETTE_SPINS   macro        13 roulette.c       #define ROULETTE_SPINS 128
cash             variable     18 roulette.c       long cash = 0;
lose_msgs1       variable    107 roulette.c       const char *lose_msgs1[NUM_LOSE_MSGS] = {
lose_msgs2       variable    115 roulette.c       const char *lose_msgs2[NUM_LOSE_MSGS] = {
win_msgs         variable     94 roulette.c       const char *win_msgs[NUM_WIN_MSGS] = {
wins             variable     19 roulette.c       long wins = 0;
// ctags -x --c-kinds=f roulette.c
get_bet          function     56 roulette.c       long get_bet() {
get_choice       function     69 roulette.c       long get_choice() {
get_long         function     25 roulette.c       long get_long() {
get_rand         function     45 roulette.c       long get_rand() {
is_digit         function     21 roulette.c       int is_digit(char c) {
main             function    182 roulette.c       int main(int argc, char *argv[]) {
play_roulette    function    163 roulette.c       void play_roulette(long choice, long bet) {
print_flag       function     81 roulette.c       int print_flag() {
spin_roulette    function    123 roulette.c       void spin_roulette(long spin) {
```

The bug functions:

- get_long, int conversion from unsigned long long int to long int.
- get_rand, get the cash (or seed ifself) and the all the rand

```sh
$ py xpwn.py REMOTE
[+] Opening connection to 2018shell2.picoctf.com on port 48312: Done
[*] seed: 3232
[*] current balance: 3232
[*] sleep 6.140365527209647
[*] current balance: 3232
[*] sleep 6.140365527209647
[*] current balance: 3232
[*] sleep 6.140365527209647
[*] current balance: 3232
[*] sleep 6.140365527209647
[*] current balance: 300003233
[*] sleep 6.140365527209647
[*] current balance: 600003234
[*] sleep 6.140365527209647
[*] current balance: 900003235
[*] sleep 6.140365527209647
[+] Receiving all data: Done (1.45KB)
[*] Closed connection to 2018shell2.picoctf.com port 48312
Choose a number (1-36)
>
Spinning the Roulette for a chance to win $3694967294!

Roulette  :  32

WRONG
Just give up!

*** Current Balance: $1200003236 ***
Wow, I can't believe you did it.. You deserve this flag!
picoCTF{1_h0p3_y0u_f0uNd_b0tH_bUg5_8fb4d984}
```

## References

https://stackoverflow.com/questions/5416414/signed-unsigned-comparisons
http://www.cplusplus.com/reference/climits/
https://piazza.com/class/jkimphnvxey1qo?cid=233
