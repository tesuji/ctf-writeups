# environ - Points: 150 - (Solves: 877)

Sometimes you have to configure environment variables before executing a program.

Can you find the flag we've hidden in an environment variable on the shell server?

---

On the shell server, type

```sh
% env |grep pico
SECRET_FLAG=picoCTF{eNv1r0nM3nT_v4r14Bl3_fL4g_3758492}
```

picoCTF{eNv1r0nM3nT_v4r14Bl3_fL4g_3758492}
