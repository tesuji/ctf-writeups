CC := gcc
CFLAGS := -m32 -Wfatal-errors -Wall -Wextra

test_overflow: test_overflow.o
	$(CC) $(CFLAGS) -o $@ $^

%.o: %.c
	$(CC) $(CFLAGS) -c $^

.PHONY: clean
clean:
	rm *.o test_overflow
