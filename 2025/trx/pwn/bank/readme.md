# TRX Bank (1 solve)

> To all our Valued Customers, at TRX Bank we aim to provide only
> the top-notch banking and customer experience; all reports about
> so-called "data leaks" are baseless slander from our competitors.
> nc bank.ctf.theromanxpl0.it 7010

---

I didn't solve this challenge on time (I was busy with other things).
However, this challenge is really interesting. "leave", "Marco"
and other solvers have given good hints after the CTF ended.

## Vulnerabilities

What we have:
* a un-init leak in `transfer()` (send `-` in transaction).
  If before calling `transfer`, we call:
  + `deposit()`:
    => leak pie (deposit + 266)
  + `close_account()`:
    => leak heap via index 29 of `tmp` buf.
  + `open_account()`:
    => leak stack address.
  + invalid option so `puts("invalid")` is called:
    => leak libc address.

What we can do with that:
* use `secret_backdor()` (check PIE), to write in range `fp_rand + 0x60:0xd8`.
  but since codecvt is memsetted to 0, we cannot use FSOP.
  + could set `fp_rand->_fileno = 0` to read from stdin instead of urandom.
  + point `fp->_lock` (offset 0x28) to a controlled mem, `(u64)fp->_lock = 0`
    whenever fd is read.

NEWS in glibc 2.40: `FILE._pad1` renamed to `_prevchain` ([Code][1]).
So `fclose` calls this:
```c
void
_IO_un_link (struct _IO_FILE_plus *fp)
{
  // redacted ...
      if (_IO_list_all == NULL)
  ;
      else if (_IO_vtable_offset ((FILE *) fp) == 0)
  {
    FILE **pr = fp->file._prevchain;
    FILE *nx = fp->file._chain;
    *pr = nx;
    if (nx != NULL)
      nx->_prevchain = pr;
```

So basically it is:
```
*(u64*)_prevchain = _chain
*(u64*)((u64)_chain + 0xb8) = _prevchain
```

It we set `fclose` saved-rbp to `_prevchain`, `_chain ` to rop address on heap,
we'll pivot the stack via `pop rbp; ret` (in `fclose()`) and `leave; ret`
(in `leave()`) gadgets.

[1]: https://elixir.bootlin.com/glibc/glibc-2.40/source/libio/genops.c#L82

## Caveats

* The `fd_rand` already pre-reads / buffers 0x1000 bytes from `/dev/urandom`.
  So you have to drain that buffer (by calling open and free acounts repeatedly)
  to make it read from stdin by overriding `fp_rand->_fileno = 0` in
  `secret_backdor()`.

* My solve script runs painfully slow on the remote (in fact it's just timeout).
  Kinda hard to optimize it with all the bruteforce for the leaks.

## Solve script

[run.py](./run.py)

Demo on local machine:
```bash
> py run.py
[+] Starting local process './chal_patched': pid 1095510
[*] -- step 1: leaking
[+] leak pie: Done
[*] LEAK: pie_leak = 0x55984e7ae545
[+] leak heap: Done
[*] LEAK: heap_leak = 0x559869949a00
[*] CALC: fp_rand_lock_addr = 0x559869948390
[+] leak stack: Done
[*] LEAK: stack_leak = 0x7fff0309cb88
[*] CALC: fclose_rbp_ptr = 0x7fff0309ca20
[+] leak libc: Done
[*] LEAK: libc_leak = 0x7f8fb928d05a
[*] -- step 2: write ropchains from stdin
[+] set fp_rand->_fileno=0 to prevent reading more from urandom: Done
[*] fp_rand buffers 0x1000 bytes from urandom
[*] we read 0x3bd bytes, remaining 0xc43 bytes
[+] draining fp_rand->buffer: Done
[*]     remaining 0x7 bytes
[*] Loaded 116 cached gadgets for './glibc/libc.so.6'
[*] remember to restore fd to be used in fclose(fp_rand)
[+] duration: 2.1514997482299805
[*] Switching to interactive mode
We're sorry to see you go! Your refund will arrive approximately in 83 days!
$ pwd
/home/hacker/ctfs/2025/trx/pwn/bank/dist
```
