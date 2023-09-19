PROG=hello_world
all:
	nasm -f elf64 $(PROG).asm -o $(PROG).o
	ld $(PROG).o -o $(PROG).out

clean:
	rm -f *.o *.out
