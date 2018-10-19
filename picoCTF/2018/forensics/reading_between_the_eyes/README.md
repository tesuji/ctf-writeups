# Reading Between the Eyes - Points: 150 - (Solves: 363)

Stego-Saurus hid a message for you in this [image][1], can you retreive it?

> Hints
> Maybe you can find an online decoder?

[1]: https://2018shell2.picoctf.com/static/24e5dae742c73bafa44d35a29b8a7a06/husky.png

---

Goto http://stylesuxx.github.io/steganography/ and tab Decode

OR use https://github.com/lzutao/golsb

```sh
% ./golsb --decode husky.png | grep pico
picoCTF{r34d1ng_b37w33n_7h3_by73s}
```
