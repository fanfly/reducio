.code32
.global in_byte
.global out_byte
.global enable_interrupt

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
