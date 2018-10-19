# absolutely relative - Points: 250 - (Solves: 674)

In a filesystem, everything is relative ¯\\\_(ツ)\_/¯.
Can you find a way to get a flag from this [program][1]?
You can find it in /problems/absolutely-relative_4_bef88c36784b44d2585bb4d2dbe074bd on the shell server.
[Source][2].

[1]: https://2018shell2.picoctf.com/static/94e0cff2fa6fb11f5c85edccb8144415/absolutely-relative
[2]: https://2018shell2.picoctf.com/static/94e0cff2fa6fb11f5c85edccb8144415/absolutely-relative.c

## Hint

Do you have to run the program in the same directory? (⊙.☉)7
Ever used a text editor? Check out the program 'nano'

---

```sh
% mkdir ~/problems
% cd $_
% ln -s /problems/absolutely-relative_4_bef88c36784b44d2585bb4d2dbe074bd/{absolutely-relative,flag.txt} ./
% echo yes > permission.txt
% ./absolutely-relative
You have the write permissions.
picoCTF{3v3r1ng_1$_r3l3t1v3_3b69633f}
```
