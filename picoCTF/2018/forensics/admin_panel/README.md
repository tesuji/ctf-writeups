# admin panel - Points: 150 - (Solves: 892)

We captured some [traffic][1] logging into the admin panel,
can you find the password?

> Hints
> Tools like wireshark are pretty good for analyzing pcap files.

[1]: https://2018shell2.picoctf.com/static/1a6db339e11fa100ef52d944edaa9612/data.pcap

---

```sh
% strings data.pcap|grep pico
user=admin&password=picoCTF{n0ts3cur3_b186631d}
```

picoCTF{n0ts3cur3_b186631d}
