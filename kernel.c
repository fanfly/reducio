#include <stdint.h>
#include "console.h"
#include "idt.h"
#include "func.h"
#include "timer.h"
#include "keyboard.h"

void kernel_main() {
    load_idt();
    console_init();
    console_print("\nWelcome to Reducio!\n\n");
    uint16_t memory_1m = *(uint16_t *) 0x90000;
    uint16_t memory_16m = *(uint16_t *) 0x90002;
    console_print("Memory: ");
    console_printnum(memory_1m + (memory_16m << 6));
    console_print(" KiB\n\n");
    console_print("You can use command 'uptime' to print the uptime in "
                  "seconds.\n\n");
    init_timer();
    init_keyboard();
    enable_interrupt();
}
