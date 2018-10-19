# script me - Points: 500 - (Solves: 344)

Can you understand the language and answer the questions to retrieve the flag?
Connect to the service with nc 2018shell2.picoctf.com 1542

## Hints

Maybe try writing a python script?

----

First sight::

    % nc 2018shell2.picoctf.com 1542
    Rules:
    () + () = ()()                                      => [combine]
    ((())) + () = ((())())                              => [absorb-right]
    () + ((())) = (()(()))                              => [absorb-left]
    (())(()) + () = (())(()())                          => [combined-absorb-right]
    () + (())(()) = (()())(())                          => [combined-absorb-left]
    (())(()) + ((())) = ((())(())(()))                  => [absorb-combined-right]
    ((())) + (())(()) = ((())(())(()))                  => [absorb-combined-left]
    () + (()) + ((())) = (()()) + ((())) = ((()())(())) => [left-associative]

    Example:
    (()) + () = () + (()) = (()())

    Let's start with a warmup.
    ()() + (()()) = ???

