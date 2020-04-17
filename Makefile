AS=i686-elf-as
LD=i686-elf-ld
QEMU=qemu-system-i386
RM=rm -f

.PHONY: all clean

all: reducio.bin

reducio.bin: boot.o
	$(LD) $^ --oformat binary -o $@

boot.o: boot.S
	$(AS) $^ -o $@

run: reducio.bin
	$(QEMU) -drive format=raw,file=$<

clean:
	$(RM) *.bin *.o