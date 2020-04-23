.global _start
.code16

_start:
        mov $reducio, %bx
        call print
        jmp .

print:
        call write
        push %ax
        push %bx
        mov $0x0e, %ah
        mov $'\r', %al
        int $0x10
        mov $'\n', %al
        int $0x10
        pop %bx
        pop %ax
        ret

write:
        push %ax
        push %bx
        mov $0x0e, %ah

write_loop:
        mov (%bx), %al
        cmp $0, %al
        je write_end
        int $0x10
        inc %bx
        jmp write_loop

write_end:
        pop %bx
        pop %ax
        ret

reducio:
        .string "Reducio!"

padding:
        .space (512 - 2) - (. - _start)

boot_signature:
        .byte 0x55, 0xaa
