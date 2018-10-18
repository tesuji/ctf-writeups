# Safe RSA - Points: 250 - (Solves: 319)

Now that you know about RSA can you help us decrypt this [ciphertext][1]?
We don't have the decryption key but something about those values looks funky..

[1]: https://2018shell2.picoctf.com/static/cbce0e29c24e15b632a0def079c4f6a1/ciphertext

## Hints

- RSA [tutorial][2]
- Hmmm that e value looks kinda small right?
- These are some really big numbers.. Make sure you're using functions that don't lose any precision!

[2]: https://en.wikipedia.org/wiki/RSA_(cryptosystem)

----

```sh
% py solve.py
picoCTF{e_w4y_t00_sm411_a5b5aaac}
```
