# Crypto Warmup 1 - Points: 75 - (Solves: 208)

Crpyto can often be done by hand, here's a message you got
from a friend,
`llkjmlmpadkkc` with the key of `thisisalilkey`.
Can you use this [table][1] to solve it?.

[1]: https://2018shell2.picoctf.com/static/35ed1211d700526e424bd66a566ba500/table.txt

---

```sh
python vigenere.py -d llkjmlmpadkkc -k thisisalilkey
./make_flag.sh SECRETMESSAGE
```

picoCTF{SECRETMESSAGE}
