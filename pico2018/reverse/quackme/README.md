# quackme - Points: 200 - (Solves: 137)

Can you deal with the Duck Web? Get us the flag from this [program][1].
You can also find the program in
/problems/quackme_1_374d85dc071ada50a08b36597288bcfd.

[1]: https://2018shell2.picoctf.com/static/045aa6ef9d1a761080ef8d6c6b8f052f/main

## Hint

Objdump or something similar is probably a good place to start.

---

```py
s = bytearray.fromhex("2906164f2b35301e511b5b144b085d2b53105451434d5c545d00")
z = bytearray.fromhex("596f752068617665206e6f7720656e746572656420746865204475636b205765")


def xorme(s):
  a, b = s
  return chr(a ^ b)


out = ''.join(map(xorme, zip(s, z)))
print(out)
```

picoCTF{qu4ckm3_6b15c941}
