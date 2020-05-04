#include "console.h"
#include "func.h"
#include "isr.h"
#include "timer.h"

void isr_handler(state_t *state) {
    return;
}

void irq_handler(state_t *state) {
    int irq_num = state->int_num - 32;
    if (irq_num >= 8) {
        out_byte(0xa0, 0x20);
    }
    out_byte(0x20, 0x20);
    
    switch (irq_num) {
    case 0:
        timer_callback(state);
        break;
    }
}
