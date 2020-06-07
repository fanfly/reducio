.code32
.global in_byte
.global out_byte
.global enable_interrupt
.global load_cr0
.global store_cr0
.global load_cr2
.global store_cr2
.global load_cr3
.global store_cr3

in_byte:
        mov 4(%esp), %edx
        mov $0, %eax
        in %dx, %al
        ret

out_byte:
        mov 4(%esp), %edx
        mov 8(%esp), %al
        out %al, %dx
        ret

enable_interrupt:
        sti
        ret


load_cr0:
        mov %cr0, %eax
        ret

store_cr0:
        mov 4(%esp), %eax
        mov %eax, %cr0
        ret

load_cr2:
        mov %cr2, %eax
        ret

store_cr2:
        mov 4(%esp), %eax
        mov %eax, %cr2
        ret

load_cr3:
        mov %cr3, %eax
        ret

store_cr3:
        mov 4(%esp), %eax
        mov %eax, %cr3
        ret

.global shutdown
shutdown:
        cli

        /* turn off paging */
        mov %cr0, %eax
        and $0x7fffffff, %eax
        mov %eax, %cr0
        mov $0, %eax
        mov %eax, %cr3

        jmp $0x18, $protected16

.code16
protected16:
        mov $0x20, %ax
        mov %ax, %ds
        mov %ax, %ss
        mov %ax, %es
        mov %ax, %fs
        mov %ax, %gs

        /* disable protected mode */
        mov %cr0, %eax
        and $0xfffffffe, %eax
        mov %eax, %cr0
        jmp $0, $real16

real16:
        mov $0, %ax
        mov %ax, %ds
        mov %ax, %ss
        mov %ax, %es
        mov %ax, %fs
        mov %ax, %gs
        lidt real_idt_descriptor
        sti

        mov $0x1000, %ax
        mov %ss, %ax
        mov $0xf000, %sp
        mov $0x5307, %ax
        mov $0x0001, %bx
        mov $0x0003, %cx
        int $0x15
        jmp .

real_idt_descriptor:
        .word 0x03ff
        .long 0
