# No Login - Points: 200 - (Solves: 410)

Looks like someone started making a website but never got around to
making a login,

but I heard there was a flag if you were the admin.

http://2018shell2.picoctf.com:52920 (link)

## Hint

What is it actually looking for in the cookie?

---

```sh
% curl http://2018shell2.picoctf.com:29568/robots.txt
User-agent: *
Disallow: /74efc.html
% curl http://2018shell2.picoctf.com:29568/74efc.html |grep pico
    <flag>picoCTF{th3_w0rld_1s_4_danger0us_pl4c3_3lli0t_74efc}</flag></p>
```

picoCTF{th3_w0rld_1s_4_danger0us_pl4c3_3lli0t_74efc}
