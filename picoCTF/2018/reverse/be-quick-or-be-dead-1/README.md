# be-quick-or-be-dead-1 - Points: 200 - (Solves: 251)

You find [this][2] when searching for some music,
which leads you to [be-quick-or-be-dead-1][1].

Can you run it fast enough?

You can also find the executable in

    /problems/be-quick-or-be-dead-1_3_aeb48854203a88fb1da963f41ae06a1c

[1]: https://www.youtube.com/watch?v=CTt1vk9nM9c
[2]: https://www.youtube.com/watch?v=CTt1vk9nM9c

---

```sh
% gdb ./be-quick-or-be-dead-1
break *0x0000000000400840
r
jump *0x000000000040084f
```

picoCTF{why_bother_doing_unnecessary_computation_27f28e71}
