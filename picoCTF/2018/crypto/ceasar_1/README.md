# caesar cipher 1 - Points: 150 - (Solves: 1137)

This is one of the older ciphers in the books, can you decrypt the [message][1]?

You can find the ciphertext in

    /problems/caesar-cipher-1_1_6fbf7a9ce0aac23bab1c37836cc20c3b

on the shell server.

[1]: https://2018shell2.picoctf.com/static/1496b9c149dea14875a4f750169a7af1/ciphertext

---

```sh
% python github.com/lzutao/classical_cipher/classical_cipher/caesar/caesar.py -c vgefmsaapaxpomqemdoubtqdxoaxypeo
================================================================================
KEY = 12
Most likely message: 'justagoodoldcaesarcipherlcolmdsc'
================================================================================
[+] Continue to bruteforce (y/N)?
```

picoCTF{justagoodoldcaesarcipherlcolmdsc}
