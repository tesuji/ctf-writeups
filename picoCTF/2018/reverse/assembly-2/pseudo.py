def asm2(a, b):
    while a <= 0x1d89:
        b += 1
        a += 0x64
    return b

hex(asm2(0x4,0x2d))
