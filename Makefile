AS=i686-elf-as
LD=i686-elf-ld
CC=i686-elf-gcc
QEMU=qemu-system-i386
RM=rm -f
CFLAGS=-Iinclude -ffreestanding

.PHONY: all run clean

all: bin/reducio.bin

bin/reducio.bin: bin/boot.bin bin/kernel.bin
	cat $^ > $@

bin/boot.bin: bin/boot.o
	$(LD) $^ -Ttext=0x7c00 --oformat binary -o $@

bin/kernel.bin: bin/kernel_entry.o bin/kernel.o bin/console.o bin/func.o \
		bin/idt.o bin/isr.o bin/timer.o \
		bin/keyboard.o bin/shell.o bin/paging.o
	$(LD) $^ -Ttext=0x1000 --oformat binary -o $@

bin/%.o: */%.S
	$(AS) $^ -o $@

bin/%.o: */%.c
	$(CC) $(CFLAGS) -c $^ -o $@

run: bin/reducio.bin
	$(QEMU) -m 1024 -drive format=raw,file=$<

clean:
	$(RM) bin/*.bin bin/*.o
