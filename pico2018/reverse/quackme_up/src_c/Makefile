CC := gcc
CFLAGS := -ggdb -m32 -O -Wfatal-errors -Wall -Wextra -fno-pic -funsigned-char

PROG = solution

.PHONY: all clean
all: $(PROG)

solution: rev.o rotation.o
	$(CC) $(CFLAGS) -o $@ $^

%.o: %.c
	$(CC) $(CFLAGS) -c $^

clean:
	rm $(PROG) *.o
