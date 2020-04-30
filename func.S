.global in_byte, out_byte
.code32

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
