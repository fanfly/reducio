#ifndef TIMER_H
#define TIMER_H

#include "isr.h"

void init_timer(void);
void timer_callback(state_t *state);
int uptime(void);

#endif
