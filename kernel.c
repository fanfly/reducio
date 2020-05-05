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
    console_print("You can use command 'uptime' to print the uptime in "
                  "seconds.\n\n");
    init_timer();
    init_keyboard();
    enable_interrupt();
}
