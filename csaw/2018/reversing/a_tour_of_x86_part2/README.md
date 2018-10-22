# A Tour of x86 - Part 2

Open stage2 in a disassembler, and figure out how to jump to the rest of the code!

-Elyk

Edit (09/15 12:30 AM) - Uploaded new stage-2.bin to make the challenge easier

- [stage-1.asm](https://ctf.csaw.io/files/5493326a39ff51037fcc065046530a17/stage-1.asm)
- [Makefile](https://ctf.csaw.io/files/21d756db9e6fe1faafdfd031416a1994/Makefile)
- [stage-2.bin](https://ctf.csaw.io/files/4d38769563475c2eef0a1542a479c00b/stage-2.bin)

---

## Proof of Flag
flag{0ne_sm411_JMP_for_x86_on3_m4ss1ve_1eap_4_Y0U}

## Summary
Patched out a halt instruction to allow the "os" to do its decryption stuff.

## Proof of Solving
From the previous stage we know that the contents of the file stage-2.bin will
be loaded at address 0x6000 and execution will be redirected at that address.
The problem is that the first byte of the second stage is a halt instruction.
By simply changing that to a 0x90 = nop and rebuilding the image we allow the
rest of the code to run. It probably does some crypto stuff but I didn’t have to
look through it as it writes the flag to the framebuffer.

