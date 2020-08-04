.global _start
.code16

_start:
        // Read sectors from drive.
        mov $10, %al             // number of sectors to read
        mov $2, %cl              // starting sector number
        mov $0, %ch              // cylinder number
        mov $0, %dh              // head number
        mov $0x1000, %bx         // address of memory buffer
        mov $0x02, %ah           // set AH := 02h
        int $0x13                // interrupt 13h

        mov $0xe801, %ax
        int $0x15
        mov %ax, memory_1m
        mov %bx, memory_16m

        // Enter protect mode.
        cli
        lgdt gdt_descriptor
        mov %cr0, %eax
        or $1, %eax
        mov %eax, %cr0
        jmp $0x08, $init_protect_mode

gdt_start:
        .space 8

gdt_code:
        .word 0xffff
        .word 0x0000
        .byte 0x00
        .byte 0x9a
        .byte 0xcf
        .byte 0x00

gdt_data:
        .word 0xffff
        .word 0x0000
        .byte 0x00
        .byte 0x92
        .byte 0xcf
        .byte 0x00

gdt_code16:
        .word 0xffff
        .word 0x0000
        .byte 0x00
        .byte 0x9a
        .byte 0x0f
        .byte 0x00

gdt_data16:
        .word 0xffff
        .word 0x0000
        .byte 0x00
        .byte 0x92
        .byte 0x0f
        .byte 0x00

gdt_end:

gdt_descriptor:
        .word gdt_end - gdt_start - 1
        .long gdt_start

memory_1m:
        .word 0
memory_16m:
        .word 0

.code32
init_protect_mode:
        mov $0x10, %ax
        mov %ax, %ds
        mov %ax, %ss
        mov %ax, %es
        mov %ax, %fs
        mov %ax, %gs
        mov $0x90000, %ebp
        mov %ebp, %esp
        movw memory_1m, %ax
        movw %ax, 0x90000
        movw memory_16m, %ax
        movw %ax, 0x90002
        call 0x1000
        jmp .

padding:
        .space (512 - 2) - (. - _start)

boot_signature:
        .byte 0x55, 0xaa
