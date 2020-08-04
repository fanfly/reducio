#include <stdint.h>
#include "console.h"
#include "idt.h"
#include "func.h"
#include "timer.h"
#include "keyboard.h"
#include "paging.h"

void kernel_main() {
    load_idt();
    console_init();

    console_printf("\n");
    console_printf("Welcome to Reducio!\n");
    console_printf("\n");
    uint16_t memory_1m = *(uint16_t *)0x90000;
    uint16_t memory_16m = *(uint16_t *)0x90002;

    console_printf("Memory: %d KiB\n", memory_1m + (memory_16m << 6));
    console_printf("\n");

    init_timer();
    init_keyboard();
    enable_interrupt();
    init_paging();
    enable_paging();
}
