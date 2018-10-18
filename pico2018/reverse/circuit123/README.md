# circuit123 - Points: 800 - (Solves: 131)

Can you crack the key to [decrypt][1] [map2][2] for us?
The key to [map1][1] is 11443513758266689915.

[1]: https://2018shell2.picoctf.com/static/e67721d394259b4aeb8ac7e32f05288a/decrypt.py
[2]: https://2018shell2.picoctf.com/static/e67721d394259b4aeb8ac7e32f05288a/map2.txt
[3]: https://2018shell2.picoctf.com/static/e67721d394259b4aeb8ac7e32f05288a/map1.txt

## Hints

Have you heard of z3?

---

```sh
% py solve.py
[key = 219465169949186335766963147192904921805]
% py ./decrypt.py 219465169949186335766963147192904921805 map2.txt
Attempting to decrypt map2.txt...
Congrats the flag for map2.txt is: picoCTF{36cc0cc10d273941c34694abdb21580d__aw350m3_ari7hm37ic__}
```
