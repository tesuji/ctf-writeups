# quackme up - Points: 350 - (Solves: 157)

The duck puns continue.
Can you crack, I mean quack this [program][1] as well?
You can find the program in
/problems/quackme-up_4_5cc9019c8499d6d124cd8e8109a0f95b
on the shell server.

[1]: https://2018shell2.picoctf.com/static/6e068b4a5cd05bd84fac735d4223a916/main

---

```sh
% make -C src_c clean && make -C src_c
% ./src_c/solution
70 69 63 6F 43 54 46 7B 71 75 34 63 6B 6D 33 5F 32 65 34 62 39 34 66 63 7D
picoCTF{qu4ckm3_2e4b94fc}
```

Or in Python, Rust and Golang:

```sh
% python src_py/main.py
picoCTF{qu4ckm3_2e4b94fc}
```

```sh
% cd src_go
% go run main.go
picoCTF{qu4ckm3_2e4b94fc}
```

```sh
% cd src_rs/rotation
% cargo run
    Finished dev [unoptimized + debuginfo] target(s) in 0.01s
     Running `target/debug/rotation`
picoCTF{qu4ckm3_2e4b94fc}
```
