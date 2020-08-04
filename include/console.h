#ifndef CONSOLE_H
#define CONSOLE_H

typedef struct console {
    int offset;
} console_t;

void console_init();
void console_putchar(char c);
void console_printf(const char *str, ...);

#endif
