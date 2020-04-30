#include <stdint.h>
#include "console.h"

void kernel_main() {
    console_t console;
    console_init(&console);
    console_print(&console, "Reducio!\n");
}
