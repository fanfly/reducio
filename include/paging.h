#ifndef PAGING_H
#define PAGING_H

#include <stdint.h>

uint32_t num_available_pages(void);
void init_paging(void);
void enable_paging(void);

#endif
