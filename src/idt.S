.code32
.extern isr_handler
.extern irq_handler
.global load_idt

.macro set_idt_isr i
        .word isr\i
        .word 0x0008
        .byte 0x00
        .byte 0x8e
        .word 0x00
.endm

.macro set_idt_irq i, j
        .word irq\j
        .word 0x0008
        .byte 0x00
        .byte 0x8e
        .word 0x00
.endm

idt_start:
        set_idt_isr 0
        set_idt_isr 1
        set_idt_isr 2
        set_idt_isr 3
        set_idt_isr 4
        set_idt_isr 5
        set_idt_isr 6
        set_idt_isr 7
        set_idt_isr 8
        set_idt_isr 9
        set_idt_isr 10
        set_idt_isr 11
        set_idt_isr 12
        set_idt_isr 13
        set_idt_isr 14
        set_idt_isr 15
        set_idt_isr 16
        set_idt_isr 17
        set_idt_isr 18
        set_idt_isr 19
        set_idt_isr 20
        set_idt_isr 21
        set_idt_isr 22
        set_idt_isr 23
        set_idt_isr 24
        set_idt_isr 25
        set_idt_isr 26
        set_idt_isr 27
        set_idt_isr 28
        set_idt_isr 29
        set_idt_isr 30
        set_idt_isr 31

        set_idt_irq 32, 0
        set_idt_irq 33, 1
        set_idt_irq 34, 2
        set_idt_irq 35, 3
        set_idt_irq 36, 4
        set_idt_irq 37, 5
        set_idt_irq 38, 6
        set_idt_irq 39, 7
        set_idt_irq 40, 8
        set_idt_irq 41, 9
        set_idt_irq 42, 10
        set_idt_irq 43, 11
        set_idt_irq 44, 12
        set_idt_irq 45, 13
        set_idt_irq 46, 14
        set_idt_irq 47, 15

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

.macro set_irq i, j
irq\j:
        cli
        push $0
        push $\i
        jmp irq_common_stub
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
        set_irq 32, 0
        set_irq 33, 1
        set_irq 34, 2
        set_irq 35, 3
        set_irq 36, 4
        set_irq 37, 5
        set_irq 38, 6
        set_irq 39, 7
        set_irq 40, 8
        set_irq 41, 9
        set_irq 42, 10
        set_irq 43, 11
        set_irq 44, 12
        set_irq 45, 13
        set_irq 46, 14
        set_irq 47, 15

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

        push %esp
        call isr_handler
        add $4, %esp
        
        pop %eax
        mov %ax, %ds
        mov %ax, %es
        mov %ax, %fs
        mov %ax, %gs
        mov %ax, %ss

        popa
        add $8, %esp
        iret

irq_common_stub:
        pusha
        mov %ds, %ax
        push %eax
        
        mov $0x10, %ax
        mov %ax, %ds
        mov %ax, %es
        mov %ax, %fs
        mov %ax, %gs
        mov %ax, %ss
        
        push %esp
        call irq_handler
        add $4, %esp
        
        pop %eax
        mov %ax, %ds
        mov %ax, %es
        mov %ax, %fs
        mov %ax, %gs
        mov %ax, %ss

        popa
        add $8, %esp
        iret

load_idt:
        mov $0x20, %dx
        mov $0x11, %al
        out %al, %dx

        mov $0xa0, %dx
        mov $0x11, %al
        out %al, %dx

        mov $0x21, %dx
        mov $0x20, %al
        out %al, %dx
        
        mov $0xa1, %dx
        mov $0x28, %al
        out %al, %dx
        
        mov $0x21, %dx
        mov $0x04, %al
        out %al, %dx
        
        mov $0xa1, %dx
        mov $0x02, %al
        out %al, %dx
        
        mov $0x21, %dx
        mov $0x01, %al
        out %al, %dx
        
        mov $0xa1, %dx
        mov $0x01, %al
        out %al, %dx
        
        mov $0x21, %dx
        mov $0x00, %al
        out %al, %dx
        
        mov $0xa1, %dx
        mov $0x00, %al
        out %al, %dx
        
        lidt idt_descriptor
        ret
