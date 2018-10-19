# now you don't - Points: 200 - (Solves: 770)

We heard that there is something hidden in this [picture][1].
Can you find it?

[1]: https://2018shell2.picoctf.com/static/eee00c8559a93bfde1241d5e00c2df37/nowYouDont.png

## Hint

    There is an old saying: if you want to hide the treasure, put it in plain sight. Then no one will see it.
    Is it really all one shade of red?

---

```sh
convert nowYouDont.png -monochrome mono.png
viewnior mono.png
```

picoCTF{n0w_y0u_533_m3}
