# what base is this? - Points: 200 - (Solves: 905)

To be successful on your mission, you must be able read data
represented in different ways, such as hexadecimal or binary.
Can you get the flag from this program to prove you are ready?
Connect with nc 2018shell2.picoctf.com 31711.

## Hint

I hear python is a good means (among many) to convert things.
It might help to have multiple windows open

---

Server shell

```sh
% py xpwn.py
[+] Opening connection to 2018shell2.picoctf.com on port 31711: Done
[*] Data stripped: '01100011 01100001 01101011 01100101'
[*] Data stripped: '6170706c65'
[*] Data stripped: '164 151 155 145'
[+] Receiving all data: Done (87B)
[*] Closed connection to 2018shell2.picoctf.com port 31711
You got it! You're super quick!
Flag: picoCTF{delusions_about_finding_values_68051dea}
```

picoCTF{shellc0de_w00h00_b766002c}
