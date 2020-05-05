#ifndef KEYBOARD_H
#define KEYBOARD_H

#include "isr.h"

void init_keyboard(void);
void keyboard_callback(state_t *state);

#endif
