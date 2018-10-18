# assembly-1 - Points: 200 - (Solves: 298)

> What does asm1(0xee) return?

Submit the flag as a hexadecimal value (starting with '0x').

NOTE: Your submission for this question will NOT be in the normal flag format.

Source located in the directory at

    /problems/assembly-1_1_3d18f926da00c5acd1dbe672938d342d

---

Pseudo code:

```c
int asm1(int a)
{
  if (a <= 0xea) {

  }
  else if (a == 0x6) {

  }
  else {
    return a + 3;
  }
  return a;
}

int main(void)
{
  asm1(0xee);
}
```

FLAG: 0xf1
