# LoadSomeBits - Points: 550 - (Solves: 296)

Can you find the flag encoded inside this [image][1]?
You can also find the file in /problems/loadsomebits_0_d87185d5ab62fa0048494157146e7b78
on the shell server.

[1]: https://2018shell2.picoctf.com/static/0c26fd8e840ff9cae4673a32f7f5fc83/pico2018-special-logo.bmp

## Hints

- Look through the Least Significant Bits for the image
- If you interpret a binary sequence (seq) as ascii and then try interpreting the
  same binary sequence from an offset of 1 (seq[1:]) as ascii do you get something
  similar or completely different?

