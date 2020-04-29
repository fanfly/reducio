AS=i686-elf-as
LD=i686-elf-ld
CC=i686-elf-gcc
QEMU=qemu-system-i386
RM=rm -f

.PHONY: all clean

all: reducio.bin

reducio.bin: boot.bin kernel.bin
	cat $^ > $@

boot.bin: boot.o
	$(LD) $^ -Ttext=0x7c00 --oformat binary -o $@

kernel.bin: kernel_entry.o kernel.o
	$(LD) $^ -Ttext=0x1000 --oformat binary -o $@

boot.o: boot.S
	$(AS) $^ -o $@

kernel_entry.o: kernel_entry.S
	$(AS) $^ -o $@

kernel.o: kernel.c
	$(CC) -ffreestanding -c $^ -o $@

run: reducio.bin
	$(QEMU) -drive format=raw,file=$<

clean:
	$(RM) *.bin *.o