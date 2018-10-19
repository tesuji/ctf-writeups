# What's My Name? - Points: 250 - (Solves: 513)

Say my name, say [my name][1].

[1]: https://2018shell2.picoctf.com/static/576d25e6f8ed096557e7a11fb3cec56b/myname.pcap

## Hint

If you visited a website at an IP address, how does it know the name of the domain?

---

```sh
% strings myname.pcap |grep pico
76picoCTF{w4lt3r_wh1t3_d4946f5125fc315cfb62150b6e2aebe7}
```

picoCTF{w4lt3r_wh1t3_d4946f5125fc315cfb62150b6e2aebe7}
