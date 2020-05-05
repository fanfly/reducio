#include <stdint.h>
#include "console.h"
#include "isr.h"
#include "func.h"
#include "timer.h"

#define FREQ 100

int tick;

void init_timer(void) {
    tick = 0;
    uint32_t val = 1193182 / FREQ;
    out_byte(0x43, 0x36);
    out_byte(0x40, val & 0xff);
    out_byte(0x40, (val >> 8) & 0xff);
}

void timer_callback(state_t *state) {
    ++tick;
}

int uptime(void) {
    return tick / 100;
}
