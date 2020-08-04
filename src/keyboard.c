#include <stdint.h>
#include <stdbool.h>
#include "func.h"
#include "keyboard.h"
#include "isr.h"
#include "console.h"
#include "shell.h"

#define MAX_LEN 2000

char buffer[MAX_LEN + 1];
int len;
bool lshift, rshift;

#define SHELL_PREFIX "user@reducio:~# "

void init_keyboard(void) {
    len = 0;
    lshift = false;
    rshift = false;
    console_printf("%s", SHELL_PREFIX);
}

char scancode_to_ascii(uint8_t scancode, bool shift) {
    if (scancode >= 2 && scancode < 14) {
        return (shift ? "!@#$%^&*()_+" : "1234567890-=")[scancode - 2];
    } else if (scancode >= 16 && scancode < 28) {
        return (shift ? "QWERTYUIOP{}" : "qwertyuiop[]")[scancode - 16];
    } else if (scancode >= 30 && scancode < 42) {
        return (shift ? "ASDFGHJKL:\"~" : "asdfghjkl;'`")[scancode - 30];
    } else if (scancode >= 43 && scancode < 54) {
        return (shift ? "|ZXCVBNM<>?" : "\\zxcvbnm,./")[scancode - 43];
    } else if (scancode == 57) {
        return ' ';
    } else if (scancode >= 71 && scancode < 84) {
        return "789-456+1230."[scancode - 71];
    }
    return 0;
}

void keyboard_callback(state_t *state) {
    uint8_t scan_code = in_byte(0x60);
    char c;
    switch (scan_code) {
    case 0x2a:
        lshift = true;
        break;
    case 0x36:
        rshift = true;
        break;
    case 0xaa:
        lshift = false;
        break;
    case 0xb6:
        rshift = false;
        break;
    case 0x0e:
        if (len > 0) {
            console_putchar('\b');
            --len;
        }
        break;
    case 0x1c:
        console_putchar('\n');
        buffer[len] = 0;
        shell_exec(buffer);
        console_printf("%s", SHELL_PREFIX);
        len = 0;
        break;
    default:
        c = scancode_to_ascii(scan_code, lshift || rshift);
        if (c && len < MAX_LEN) {
            console_putchar(c);
            buffer[len] = c;
            ++len;
        }
    }
}
