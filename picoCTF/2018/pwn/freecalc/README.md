# freecalc - Points: 750 - (Solves: 7)

Things are heating up!
Can you help us exploit this [program][1] and get us the flag?
Connect with nc 2018shell2.picoctf.com 54291
[Source][2].
[libc.so.6][3]

[1]: https://2018shell2.picoctf.com/static/ee1bc4f1a4b1d9d41c7851174c401b06/calc
[2]: https://2018shell2.picoctf.com/static/ee1bc4f1a4b1d9d41c7851174c401b06/calc.c
[3]: https://2018shell2.picoctf.com/static/ee1bc4f1a4b1d9d41c7851174c401b06/libc.so.6

## Hints

- You probably need to leak both a heap address and a libc address
- Define a function as: ...
- Make sure you are run/debug with the provided libc on the shell server

---

How to debug program with [custom elf interpreter][custom]?

[custom]: https://stackoverflow.com/questions/28463987/how-to-debug-program-with-custom-elf-interpreter

Explanation here: https://github.com/hpmv1/ctf/wiki/picoctf-2018-freecalc

```sh

```
