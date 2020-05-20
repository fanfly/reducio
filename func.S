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
