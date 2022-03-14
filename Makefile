ASM = nasm
ASMFLAGS = -f elf64

TARGET = main


.PHONY: clean

dict.o: dict.asm lib.inc
	$(ASM) $(ASMFLAGS) -o $@ $<

lib.o: lib.asm
	$(ASM) $(ASMFLAGS) -o $@ $<

main.o: main.asm lib.inc words.inc colon.inc 
	$(ASM) $(ASMFLAGS) -o $@ $<

main: main.o dict.o lib.o
	ld -o $@ $^

clean: 
	rm -rf $(TARGET) *.o

