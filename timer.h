#ifndef TIMER_H
#define TIMER_H

#include <stdint.h>
#include "isr.h"

void init_timer();
void timer_callback(state_t *state);

#endif
