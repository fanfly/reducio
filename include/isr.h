#ifndef ISR_H
#define ISR_H

#include <stdint.h>

typedef struct state {
    uint32_t ds;
    uint32_t edi;
    uint32_t esi;
    uint32_t ebp;
    uint32_t esp;
    uint32_t ebx;
    uint32_t edx;
    uint32_t ecx;
    uint32_t eax;
    uint32_t int_num;
    uint32_t err;
    uint32_t eip;
    uint32_t cs;
    uint32_t eflags;
    uint32_t useresp;
    uint32_t ss;
} state_t;

void isr_handler(state_t *state);
void irq_handler(state_t *state);

#endif
