# Truly an Artist - Points: 200 - (Solves: 744)

Can you help us find the flag in this [Meta-Material][1]?

You can also find the file in

    /problems/truly-an-artist_4_cdd9e325cf9bacd265b98a7fe336e840.

[1]: https://2018shell2.picoctf.com/static/9b8863e30054675ce78328df28c601db/2018.png

## Hint

    Try looking beyond the image.
    Who created this?

---

```sh
% strings -n10 2018.png | grep pico
picoCTF{look_in_image_13509d38}
```

picoCTF{look_in_image_13509d38}
