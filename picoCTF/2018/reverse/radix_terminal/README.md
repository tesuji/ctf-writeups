# Radix's Terminal - Points: 400 - (Solves: 273)

Can you find the password to [Radix's login][1]?
You can also find the executable in
/problems/radix-s-terminal_1_35b3f86ea999e44d72e988ef4035e872?

[1]: https://2018shell2.picoctf.com/static/2f848bb17aae35fb0fc703cbe15afbef/radix

## Hints

https://en.wikipedia.org/wiki/Base64

---

```sh
% rabin2 -z radix
000 0x00000850 0x08048850  56  57 (.rodata) ascii cGljb0NURntiQXNFXzY0X2VOQ29EaU5nX2lTX0VBc1lfMTg3NTk3NDV9
001 0x00000889 0x08048889  26  27 (.rodata) ascii Please provide a password!
002 0x000008a4 0x080488a4  30  31 (.rodata) ascii Congrats, now where's my flag?
003 0x000008c3 0x080488c3  19  20 (.rodata) ascii Incorrect Password!
000 0x00001060 0x0804a060  64  65 (.data) ascii ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/
% base64 -d <<< cGljb0NURntiQXNFXzY0X2VOQ29EaU5nX2lTX0VBc1lfMTg3NTk3NDV9
picoCTF{bAsE_64_eNCoDiNg_iS_EAsY_18759745}
```
