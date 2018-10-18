# in out error - Points: 275 - (Solves: 668)

Can you utlize stdin, stdout, and stderr to get the flag from this [program][1]?
You can also find it in /problems/in-out-error_1_24ebc7186086f0f9a710de008628c561 on the shell server

[1]: https://2018shell2.picoctf.com/static/0d4867de7f7e5757410f23bfa00a6aae/in-out-error

## Hint

Maybe you can split the stdout and stderr output?

---

```sh
% echo "Please may I have the flag?" | ./in-out-error >/dev/null
picoCTF{p1p1ng_1S_4_7h1ng_7b9360ca}
```
