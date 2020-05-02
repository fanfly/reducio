.code32
.extern console_printnum
.global load_idt

.macro set_idt i
        .word isr\i
        .word 0x0008
        .byte 0x00
        .byte 0x8e
        .word 0x00
.endm

idt_start:
        set_idt 0
        set_idt 1
        set_idt 2
        set_idt 3
idt_end:

idt_descriptor:
        .word idt_end - idt_start - 1
        .long idt_start

.macro set_isr i
isr\i:
        push %ebp
        mov %esp, %ebp
        push $msg_prefix
        call console_print
        add $4, %esp
        pop %ebp

        push %ebp
        mov %esp, %ebp
        push $\i
        call console_printnum
        add $4, %esp
        pop %ebp

        push %ebp
        mov %esp, %ebp
        push $msg_suffix
        call console_print
        add $4, %esp
        pop %ebp

        iret
.endm

        set_isr 0
        set_isr 1
        set_isr 2
        set_isr 3

msg_prefix:
        .string "Interrupt: "

msg_suffix:
        .string "\n"

load_idt:
        lidt idt_descriptor
        ret
