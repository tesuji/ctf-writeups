# Inspect Me - Points: 125 - (Solves: 888)

Inpect this code! http://2018shell2.picoctf.com:47428 ([link][1])

[1]: http://2018shell2.picoctf.com:47428/

---

```sh
% curl -q http://2018shell2.picoctf.com:47428/ http://2018shell2.picoctf.com:47428/mycss.css http://2018shell2.picoctf.com:47428/myjs.js 2>/dev/null |grep part
  <!-- I learned HTML! Here's part 1/3 of the flag: picoCTF{ur_4_real_1nspe -->
/* I learned CSS! Here's part 2/3 of the flag: ct0r_g4dget_e96dd105} */function openTab(tabName,elmnt,color) {
/* I learned JavaScript! Here's part 3/3 of the flag:  */
```

picoCTF{ur_4_real_1nspect0r_g4dget_e96dd105}
