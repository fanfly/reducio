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
        set_idt 4
        set_idt 5
        set_idt 6
        set_idt 7
        set_idt 8
        set_idt 9
        set_idt 10
        set_idt 11
        set_idt 12
        set_idt 13
        set_idt 14
        set_idt 15
        set_idt 16
        set_idt 17
        set_idt 18
        set_idt 19
        set_idt 20
        set_idt 21
        set_idt 22
        set_idt 23
        set_idt 24
        set_idt 25
        set_idt 26
        set_idt 27
        set_idt 28
        set_idt 29
        set_idt 30
        set_idt 31
idt_end:

idt_descriptor:
        .word idt_end - idt_start - 1
        .long idt_start

.macro set_isr i
isr\i:
        cli
        push $0
        push $\i
        jmp isr_common_stub
        iret
.endm

.macro set_isr_err i
isr\i:
        cli
        push $\i
        jmp isr_common_stub
        iret
.endm

        set_isr 0
        set_isr 1
        set_isr 2
        set_isr 3
        set_isr 4
        set_isr 5
        set_isr 6
        set_isr 7
        set_isr_err 8
        set_isr 9
        set_isr_err 10
        set_isr_err 11
        set_isr_err 12
        set_isr_err 13
        set_isr_err 14
        set_isr 15
        set_isr 16
        set_isr_err 17
        set_isr 18
        set_isr 19
        set_isr 20
        set_isr 21
        set_isr 22
        set_isr 23
        set_isr 24
        set_isr 25
        set_isr 26
        set_isr 27
        set_isr 28
        set_isr 29
        set_isr 30
        set_isr 31

isr_common_stub:
        pusha
        mov %ds, %ax
        push %eax
        
        mov $0x10, %ax
        mov %ax, %ds
        mov %ax, %es
        mov %ax, %fs
        mov %ax, %gs
        mov %ax, %ss

        call isr_handler
        
        pop %eax
        mov %ax, %ds
        mov %ax, %es
        mov %ax, %fs
        mov %ax, %gs
        mov %ax, %ss

        popa
        add $8, %esp
        iret

isr_handler:
        push %ebp
        mov %esp, %ebp
        sub $4, %esp
        movw $msg_prefix, (%esp)
        call console_print

        /*
         * information in stack
         * =======================
         * base pointer:         4
         * instruction pointer:  4
         * data selector:        4
         * all registers:       32
         * interrupt number:     4
         * error code:           4
         */
        mov 44(%ebp), %edx
        mov %edx, (%esp)
        call console_printnum

        movw $msg_suffix, (%esp)
        call console_print
        add $4, %esp
        pop %ebp

        ret

msg_prefix:
        .string "Interrupt: "

msg_suffix:
        .string "\n"

load_idt:
        lidt idt_descriptor
        ret
