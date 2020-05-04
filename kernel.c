#include <stdint.h>
#include "console.h"
#include "idt.h"
#include "func.h"
#include "timer.h"

void kernel_main() {
    load_idt();
    console_init();
    console_print("Reducio!\n");
    init_timer();
    enable_interrupt();
}
