.extern kernel_main
.global _start

.code32
_start:
        call kernel_main
        jmp .
