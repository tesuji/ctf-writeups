# learn gdb - Points: 300 - (Solves: 528)

Using a debugging tool will be extremely useful on your missions.
Can you run this [program][1] in gdb and find the flag?
You can find the file in /problems/learn-gdb_0_716957192e537ac769f0975c74b34194 on the shell server.

[1]: https://2018shell2.picoctf.com/static/58c2e42eecc19e464af2c0dac8da7a77/run

## Hint

- Try setting breakpoints in gdb
- Try and find a point in the program after the flag has been read into memory to break on
- Where is the flag being written in memory?

---

```sh
% gdb -q ./run
(gdb) b*0x004008a8
Breakpoint 1 at 0x4008a8
(gdb) r
Starting program: /problems/learn-gdb_0_716957192e537ac769f0975c74b34194/run
Decrypting the Flag into global variable 'flag_buf'
.....................................
Breakpoint 1, 0x00000000004008a8 in decrypt_flag ()
(gdb) x/s flag_buf
0x137e010:  "picoCTF{gDb_iS_sUp3r_u53fuL_a6c61d82}"
(gdb)
```
