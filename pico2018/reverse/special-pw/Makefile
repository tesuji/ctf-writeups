CC := gcc
CFLAGS := -ggdb -m32 -Wfatal-errors -Wall -Wextra -fno-pic

PROG = pseudo solve

.PHONY: all clean
all: $(PROG)

pseudo: pseudo.o
	$(CC) $(CFLAGS) -o $@ $^

solve: solve.o
	$(CC) $(CFLAGS) -o $@ $^

%.o: %.c
	$(CC) $(CFLAGS) -c $^

clean:
	rm $(PROG) *.o
