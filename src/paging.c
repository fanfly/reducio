#include <stdint.h>
#include "paging.h"
#include "func.h"

void **pages;
uint32_t num_pages;

uint32_t *page_directory;
uint32_t *page_table;

void *alloc_page(void) {
    return pages[--num_pages];
}

void free_page(void *page) {
    pages[num_pages++] = page;
}

void init_physical_memory(void) {
    int n = *(uint16_t *)0x9000;  // memory above 16 MiB, in 64 KiB blocks
    pages = (void **)0x136500;
    for (int i = 0; i < n * 4; ++i) {
        free_page((void *)(0x1000000 + ((uint32_t)i << 12)));
    }
}

uint32_t num_available_pages(void) {
    return num_pages;
}

void init_paging(void) {
    init_physical_memory();
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
