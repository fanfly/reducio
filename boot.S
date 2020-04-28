.global _start
.code16

_start:
        mov $0x9000, %bp
        mov %bp, %sp
        cli
        lgdt gdt_descriptor
        mov %cr0, %eax
        or $1, %eax
        mov %eax, %cr0
        jmp $0x08, $init_pm

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

gdt_end:

gdt_descriptor:
        .word gdt_end - gdt_start - 1
        .long gdt_start

.code32
init_pm:
        mov $0x10, %ax
        mov %ax, %ds
        mov %ax, %ss
        mov %ax, %es
        mov %ax, %fs
        mov %ax, %gs
        mov $0x90000, %ebp
        mov %ebp, %esp
        mov $0xb8000, %edx
        mov $0x0f, %ah
        mov $'R', %al
        mov %ax, (%edx)
        add $2, %edx
        mov $'e', %al
        mov %ax, (%edx)
        add $2, %edx
        mov $'d', %al
        mov %ax, (%edx)
        add $2, %edx
        mov $'u', %al
        mov %ax, (%edx)
        add $2, %edx
        mov $'c', %al
        mov %ax, (%edx)
        add $2, %edx
        mov $'i', %al
        mov %ax, (%edx)
        add $2, %edx
        mov $'o', %al
        mov %ax, (%edx)
        add $2, %edx
        mov $'!', %al
        mov %ax, (%edx)
        jmp .

padding:
        .space (512 - 2) - (. - _start)

boot_signature:
        .byte 0x55, 0xaa
