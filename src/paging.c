#include <stdint.h>
#include "paging.h"
#include "func.h"

uint32_t *page_directory;
uint32_t *page_table;

void init_paging(void) {
    page_directory = (uint32_t *)0x9c000;
    page_table = (uint32_t *)0x9d000;
    for (int i = 0; i < 1024; ++i) {
        page_table[i] = ((uint32_t)i << 12) | 0x3;
    }
    for (int i = 0; i < 1024; ++i) {
        if (i == 0) {
            page_directory[i] = (uint32_t)page_table | 0x3;
        } else {
            page_directory[i] = 0x2;
        }
    }
}

void enable_paging(void) {
    store_cr3((uint32_t)page_directory);
    store_cr0(load_cr0() | 0x80000000);
}
