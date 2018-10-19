# Assembly compiler
AS=nasm
# Assembly flags
ASFLAGS=-f elf -s
# Linker
LD=ld
# Linker flags
LDFLAGS=-m elf_i386

SOURCE:= $(wildcard *.asm)
# foo.asm => foo.elf
OUTPUTS=$(SOURCE:.asm=.elf)

all: $(OUTPUTS)

#Create executable
%.elf: %.o
	$(LD) $(LDFLAGS) -o $@ $^

#Compile assembly program
%.o: %.asm
	$(AS) $(ASFLAGS) $^

#Clean folder
clean:
	rm *.elf
