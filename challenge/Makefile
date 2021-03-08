BIN=slippery_rope
all:
	rm -f $(BIN) $(BIN).o
	nasm -f elf64 $(BIN).asm
	ld -z noexecstack -o $(BIN) $(BIN).o
	strip $(BIN)
	rm -f $(BIN).o
clean:
	rm -f $(BIN) $(BIN).o
wipe:
	rm -f $(BIN).asm Makefile
