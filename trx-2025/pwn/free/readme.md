# Free the monsters (solves 17)

> While I was waiting for monster hunter wilds to come out, I bumped into this one.
> But I haven't been able to finish it yet... It seems impossible! A friend of mine
> said he keeps the solvecript in his garage, but his older brother told him not to
> show anyone...
>
> nc monsters.ctf.theromanxpl0.it 7009

## Investigate the program
Put the binary in ida or ghidra, we have the decompilation of `main`:
```c
int __fastcall main(int argc, const char **argv, const char **envp)
{
  int choice; // [rsp+4h] [rbp-Ch] BYREF
  unsigned __int64 v5; // [rsp+8h] [rbp-8h]

  v5 = __readfsqword(0x28u);
  setup();
  banner();
  while ( 1 )
  {
    menu();
    __isoc99_scanf("%d", &choice);
    switch ( choice )
    {
      case 1:
        print_player_info();                    // leak
        break;
      case 2:
        select_quest();
        break;
      case 3:
        embark_quest();
        break;
      case 4:
        change_equipment();
        break;
      case 5:
        return 0;
      default:
        puts("Invalid choice");
        break;
    }
  }
}
```

There is a leak in `setup`:
```c
  read(0, aHunter, 32uLL);
  aHunter[strcspn(aHunter, "\n")] = 0;
```

But aHunter (`char[32]`) is right before `helmet` pointer. So if we fill `aHunter` up,
we could leak `helmet` pointer in `print_player_info()`.

```
.data:0000000000006028 ; char aHunter[32]
.data:0000000000006048 ; Equip *helmet
```

To make the decompilation easier, I defined some structs:
```c
// used in change_equipment() and print_player_info()
struct Equip
{
  __int64 atk;
  __int64 def;
  char name[32];
};

// used in embark_quest() and select_quest()
struct Monster
{
  __int64 atk;
  __int64 def;
  __int64 health;
  char name[24];
};

// used in embark_quest() and select_quest()
struct Quest
{
  __int64 point;
  char name[32];
  Monster *monster;
};
```

What interesting is these structs have the same size (0x30) so if they freed,
they would be pushed into the same tcache bin.

### `print_player_info`

No input required. Used for leaks.

### `select_quest` and `embark_quest`

Level up the player to allow them to have equipments.
No inputs required minor inputting a *int* to select the quest.

### `change_equipment`

There are 13 equipments (`struct Equip`) available. If the player's level > 999.
They could modify all 13 equipments. Minor the level checking, each equipment
has the same code pattern:
```c
        printf("What do you want to do?\n1. Equip helmet\n2. Unequip helmet\n> ");
        __isoc99_scanf("%d", &choice);
        if ( choice == 1 )
        {
          helmet = (Equip *)malloc(0x30uLL);
          printf("Enter helmet name: ");
          read(0, helmet->name, 0x20uLL);
          printf("Enter helmet attack: ");
          __isoc99_scanf("%llu", helmet);
          printf("Enter helmet defense: ");
          __isoc99_scanf("%llu", &helmet->def);
        }
        else
        {
          if ( choice != 2 )
            goto l_invalid;
          free(helmet);                         // double free
        }
```

Input 1 to `alloc` (equip), 2 to `free` (unequip), with a double free vulnerability.
Here `helmet` (and other equipments) is never set to `NULL` after freed, so we could
free it again. And it's used after freed in `print_player_info()` to leak the
mangled heap pointers.

## Strategy

What we have:
* a double free primitive (chunksize 0x40).
* a heap address leak in `aHunter` var in `print_player_info`.
What we don't have:
* a way to write to freed chunks.

What we want: tcache poisoning to get arbitrary read/write primitive.

But freeing a chunk twice in tcache (since glibc 2.32) will segfault. But fastbins have
no check like that. We'll use the [fastbin_dup technique][1] to create an overlapping
chunk inside one of the equipments to overwrite the next freed chunks in tcache.
This would allow us to use the `tcache_poisoning` technique to gain arb read/write.

[1]: https://github.com/shellphish/how2heap/blob/master/glibc_2.35/fastbin_dup.c
[2]: https://github.com/shellphish/how2heap/blob/master/glibc_2.35/tcache_poisoning.c

### Creating an overlapping chunk to poison tcache.

hexdump of "helmet" **before** creating overlapping chunk:
```
+0310 0x5647263c1310  00 00 00 00 00 00 00 00  41 00 00 00 00 00 00 00  │........│A.......│
+0320 0x5647263c1320  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  │........│........│ <== helmet
+0330 0x5647263c1330  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  │........│A.......│ <== .atk and .defence field
+0340 0x5647263c1340  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  │........│........│
+0350 0x5647263c1350  61 61 61 61 00 00 00 00  41 00 00 00 00 00 00 00  │aaaa....│A.......│ <== chest
+0330 0x5647263c1330  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  │........│A.......│ <== .atk and .defence field
+0370 0x5647263c1370  61 61 61 61 00 00 00 00  00 00 00 00 00 00 00 00  │aaaa....│........│
+0380 0x5647263c1380  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  │........│........│
```

hexdump of "helmet" **after** creating overlapping chunk:
```
+0310 0x5647263c1310  00 00 00 00 00 00 00 00  41 00 00 00 00 00 00 00  │........│A.......│
+0320 0x5647263c1320  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  │........│........│ <== helmet
+0330 0x5647263c1330  00 00 00 00 00 00 00 00  41 00 00 00 00 00 00 00  │........│A.......│ <= fake chunksize
+0340 0x5647263c1340  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  │........│........│ <== overlapped chunk: BEGIN
+0350 0x5647263c1350  61 61 61 61 00 00 00 00  41 00 00 00 00 00 00 00  │aaaa....│A.......│
+0340 0x5647263c1340  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  │........│........│ <== chest
+0370 0x5647263c1370  61 61 61 61 00 00 00 00  00 00 00 00 00 00 00 00  │aaaa....│........│ ^== overlapped chunk: END
+0380 0x5647263c1380  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  │........│........│
```

With that, we could control the chunksize, the `.next` field of `chest` when freed.

### Leak libc address

What we now have:
* an overlapping chunk to do tcache poisoning to gain arb read/write.
* heap address leaks in `aHunter` var in `print_player_info`.

What we want:
* a libc leak to:
  + leak stack address to gain control of saved RIP.
  + or exploit FSOP on stdout object.

I just chose to rewrite the stack for my taste.

Reasons for requiring libc leak:
+ there is no IO stream (`FILE *`) objects on the heap to exploit FSOP.
+ `__free_hook` (or `__malloc_hook`) are not used since glibc 2.34.
+ glibc is full-RELRO, we cannot overwrite its `.got`.

---

We could overwrite `chunksize = 0x421` of `chest`, free it (now pushed to unsortedbins)
to leak libc. But before that, we need to write 2 fakechunks of size 0x20 at `0x5647263c1350 + 0x420`,
by using tcache poisoning to malloc there and write fakechunks.

But why? Just compile and run the small C program and you'll see:
```c
void main()
{
	long *a = malloc(0x30);
	long *b = malloc(0x30);

	a[-1] = 0x421;
	// Uncomment 3 lines below to make it works.
	//long *c = (void*)((long)&a[-2] + 0x420);
	//c[1] = 0x21;
	//c[5] = 0x21;
	free(a);
	printf("key  = %#lx\n", a[1]);
	printf("leak = %#lx\n", a[0]);
}
```

### Using arbitrary read/write to control RIP

Now we have a libc leak. We could leak stack address from `libc.environ` and calculate main saved RIP address.
Then write gadgets into main saved RIP.

## Solve script

This file: [run.py](./run.py).
