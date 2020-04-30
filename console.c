#include <stdint.h>
#include "console.h"
#include "func.h"

#define VIDEO_MEMORY ((uint16_t *)0x000b8000)

void console_update(const console_t *console) {
    out_byte(0x3d4, 14);
    out_byte(0x3d5, (console->offset >> 8) & 0xff);
    out_byte(0x3d4, 15);
    out_byte(0x3d5, console->offset & 0xff);
}

void console_init(console_t *console) {
    console->offset = 0;
    for (int i = 0; i < 80 * 25; ++i) {
        VIDEO_MEMORY[i] = 0x07 << 8 | ' ';
    }
    console_update(console);
}

void console_putchar(console_t *console, char c) {
    if (c == '\n') {
        console->offset = (console->offset / 80 + 1) * 80;
    } else {
        VIDEO_MEMORY[console->offset] = 0x07 << 8 | c;
        ++console->offset;
    }
    console->offset %= (80 * 25);
    console_update(console);
}

void console_print(console_t *console, const char *str) {
    while (*str) {
        console_putchar(console, *str);
        ++str;
    }
}

void console_printnum(console_t *console, int x) {
    if (x < 0) {
        console_putchar(console, '-');
        x = -x;
    } else if (x == 0) {
        console_putchar(console, '0');
    }
    char stack[32];
    int len = 0;
    while (x) {
        stack[len] = '0' + (x % 10);
        ++len;
        x /= 10;
    }
    for (int i = len - 1; i >= 0; --i) {
        console_putchar(console, stack[i]);
    }
}
