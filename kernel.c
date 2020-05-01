#include <stdint.h>
#include "console.h"
#include "idt.h"

void kernel_main() {
    load_idt();
    console_init();
    console_print("Reducio!\n");
    test_int();
}
