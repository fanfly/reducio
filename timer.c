#include <stdint.h>
#include "console.h"
#include "isr.h"
#include "func.h"
#include "timer.h"

int tick;

void init_timer() {
    tick = 0;
    uint32_t val = 1193182 / 100;
    out_byte(0x43, 0x36);
    out_byte(0x40, val & 0xff);
    out_byte(0x40, (val >> 8) & 0xff);
}

void timer_callback(state_t *state) {
    ++tick;
    int sec = tick / 100;
    console_print("\rUptime: ");
    console_printnum(sec);
    console_print(" second");
    if (sec > 1) {
        console_print("s");
    }
}
