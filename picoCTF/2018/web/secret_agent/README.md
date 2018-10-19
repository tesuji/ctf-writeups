# Secret Agent - Points: 200 - (Solves: 475)

Here's a little website that hasn't fully been finished.

But I heard google gets all your info anyway. http://2018shell2.picoctf.com:60372 (link)

## Hint

How can your browser pretend to be something else?

---

```sh
curl -A 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.96 Mobile Safari/537.36 (compatibglebot/2.1; +http://www.google.com/bot.html)' 'http://2018shell2.picoctf.com:60372/flag' | grep pico
            <p style="text-align:center; font-size:30px;"><b>Flag</b>: <code>picoCTF{s3cr3t_ag3nt_m4n_dc320c11}</code></p>
```

picoCTF{s3cr3t_ag3nt_m4n_dc320c11}
