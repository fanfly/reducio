.global _start
.code16

_start:
        mov $0x0e, %ah
        mov $'R', %al
        int $0x10
        mov $'e', %al
        int $0x10
        mov $'d', %al
        int $0x10
        mov $'u', %al
        int $0x10
        mov $'c', %al
        int $0x10
        mov $'i', %al
        int $0x10
        mov $'o', %al
        int $0x10
        mov $'!', %al
        int $0x10
        jmp .

padding:
        .space 512-2 - (. - _start)

magic:
        .byte 0x55, 0xaa
