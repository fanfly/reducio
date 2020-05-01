.code32
.global load_idt
.global test_int
.extern console_printnum

idt_start:
        .word isr0
        .word 0x0008
        .byte 0x00
        .byte 0x8e
        .word 0x00

        .word isr1
        .word 0x0008
        .byte 0x00
        .byte 0x8e
        .word 0x00

idt_end:

idt_descriptor:
        .word idt_end - idt_start - 1
        .long idt_start

isr0:
        movw $0x0730, 0xb80a0
        iret

isr1:
        movw $0x0731, 0xb80a4
        iret

load_idt:
        lidt idt_descriptor
        ret

test_int:
        int $0
        int $1
        ret
