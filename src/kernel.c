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

    init_timer();
    init_keyboard();
    enable_interrupt();

    init_paging();
    enable_paging();
}
