# Assembly compiler
AS=nasm
# Assembly flags
ASFLAGS=-f elf -s
# Linker
CC=gcc
# Linker flags
CFLAGS=-m32

SOURCE:= $(wildcard *.asm)
# foo.asm => foo.elf
OUTPUTS=$(SOURCE:.asm=.elf)

all: $(OUTPUTS)

#Create executable
%.elf: %.o
	$(CC) $(CFLAGS) -o $@ $^

#Compile assembly program
%.o: %.asm
	$(AS) $(ASFLAGS) $^

#Clean folder
clean:
	rm *.elf
