# are you root? - Points: 550 - (Solves: 144)

Can you get root access through this [service][1] and get the flag?
Connect with nc 2018shell2.picoctf.com 41208
[Source][2].

[1]: https://2018shell2.picoctf.com/static/5c15a7b45758c8ba564f31d6537513f7/auth
[2]: https://2018shell2.picoctf.com/static/5c15a7b45758c8ba564f31d6537513f7/auth.c

## Hints

If only the program used calloc to zero out the memory..

---

Not reset user after allocating from malloc.

```sh
% py solve.py REMOTE
[+] Opening connection to 2018shell2.picoctf.com on port 41208: Done
Logged in as "root"

Enter your command:
> picoCTF{m3sS1nG_w1tH_tH3_h43p_bc7d345a}


Enter your command:
>
```
