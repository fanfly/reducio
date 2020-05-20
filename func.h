#ifndef FUNC_H
#define FUNC_H

#include <stdint.h>

uint8_t in_byte(uint16_t port);
void out_byte(uint16_t port, uint8_t value);

void enable_interrupt(void);

uint32_t load_cr0(void);
void store_cr0(uint32_t value);
uint32_t load_cr2(void);
void store_cr2(uint32_t value);
uint32_t load_cr3(void);
void store_cr3(uint32_t value);

#endif
