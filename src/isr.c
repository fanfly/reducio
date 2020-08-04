#include "console.h"
#include "func.h"
#include "isr.h"
#include "timer.h"
#include "keyboard.h"

void isr_handler(state_t *state) {
    int isr_num = state->int_num;
    switch (isr_num) {
    case 14:
        console_printf("Page fault! (at address %d)\n", load_cr2());
        while (1) continue;
        break;
    }
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
    case 1:
        keyboard_callback(state);
        break;
    }
}
