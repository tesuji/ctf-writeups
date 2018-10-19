# pipe - Points: 110 - (Solves: 595)

During your adventure, you will likely encounter a situation
where you need to process data that you receive over the network
rather than through a file.
Can you find a way to save the output from this program and
search for the flag?
Connect with `2018shell2.picoctf.com 37542`.

---

```sh
$ nc 2018shell2.picoctf.com 37542 | grep picoCTF
picoCTF{almost_like_mario_a6975cdb}
```
