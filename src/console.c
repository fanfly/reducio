#include <stdint.h>
#include "console.h"
#include "func.h"

#define VIDEO_MEMORY ((uint16_t *)0x000b8000)

int offset;

void console_update() {
    out_byte(0x3d4, 14);
    out_byte(0x3d5, (offset >> 8) & 0xff);
    out_byte(0x3d4, 15);
    out_byte(0x3d5, offset & 0xff);
}

void console_init() {
    offset = 0;
    for (int i = 0; i < 80 * 25; ++i) {
        VIDEO_MEMORY[i] = 0x07 << 8 | ' ';
    }
    console_update();
}

void console_putchar(char c) {
    switch (c) {
    case '\n':
        offset = (offset / 80 + 1) * 80;
        break;
    case '\r':
        offset = offset / 80 * 80;
        break;
    case '\b':
        if (offset > 0) {
            --offset;
            VIDEO_MEMORY[offset] = 0x07 << 8 | ' ';
        }
        break;
    default:
        VIDEO_MEMORY[offset] = 0x07 << 8 | c;
        ++offset;
    }
    if (offset >= 80 * 25) {
        for (int i = 0; i < 80 * 25; ++i) {
            if (i < 80 * 24) {
                VIDEO_MEMORY[i] = VIDEO_MEMORY[i + 80];
            } else {
                VIDEO_MEMORY[i] = 0x07 << 8 | ' ';
            }
        }
        offset -= 80;
    }
    console_update();
}

void console_print(const char *str) {
    while (*str) {
        console_putchar(*str);
        ++str;
    }
}

void console_printnum(int x) {
    if (x < 0) {
        console_putchar('-');
        x = -x;
    } else if (x == 0) {
        console_putchar('0');
    }
    char stack[32];
    int len = 0;
    while (x) {
        stack[len] = '0' + (x % 10);
        ++len;
        x /= 10;
    }
    for (int i = len - 1; i >= 0; --i) {
        console_putchar(stack[i]);
    }
}
