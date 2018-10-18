#!/usr/bin/env
import os
import sys
#
import z3


def mychr(ch):
    if ch < 10:
        return chr(0x30 + ch)

    if ch < 36:
        return chr(0x41 + ch - 10)

    raise Exception("It's impossible!!!")


def check_valid_range(x):
    return z3.And(x >= 0, x <= 36)


def calculate(solver, xs):


    MOD_BASE = z3.BitVecVal(36, 8)

    solver.add(((xs[0] + xs[1]) % MOD_BASE) == 14)
    solver.add(((xs[2] + xs[3]) % MOD_BASE) == 24)
    solver.add(((xs[2] - xs[0]) % MOD_BASE) == 6)
    solver.add(((xs[1] + xs[3] + xs[5]) % MOD_BASE) == 4)
    solver.add(((xs[2] + xs[4] + xs[6]) % MOD_BASE) == 13)
    solver.add(((xs[3] + xs[4] + xs[5]) % MOD_BASE) == 22)
    solver.add(((xs[6] + xs[8] + xs[10]) % MOD_BASE) == 31)
    solver.add(((xs[1] + xs[4] + xs[7]) % MOD_BASE) == 7)
    solver.add(((xs[9] + xs[12] + xs[15]) % MOD_BASE) == 20)
    solver.add(((xs[13] + xs[14] + xs[15]) % MOD_BASE) == 12)
    solver.add(((xs[8] + xs[9] + xs[10]) % MOD_BASE) == 27)
    solver.add(((xs[7] + xs[12] + xs[13]) % MOD_BASE) == 23)


def main():
    with open('map2.txt', 'r') as f:
        cipher, chalbox = eval(f.read())

    length, gates, check = chalbox

    solver = z3.Solver()
    key = z3.BitVec('key', length)
    b = [(key >> i) & 1 for i in range(length)]

    for name, args in gates:
        if name == 'true':
            b.append(1)
        else:
            u1 = b[args[0][0]] ^ args[0][1]
            u2 = b[args[1][0]] ^ args[1][1]
            if name == 'or':
                b.append(u1 | u2)
            elif name == 'xor':
                b.append(u1 ^ u2)

    solver.add((b[check[0]] ^ check[1]) == True)

    rv = solver.check()
    if rv == z3.unsat:
        print("No solution")
        sys.exit(1)
    elif rv == z3.unknown:
        print("Failed to solve")
        print(solver.model())
        sys.exit(1)

    model = solver.model()
    print(model)


if __name__ == '__main__':
    main()
