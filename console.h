#ifndef CONSOLE_H
#define CONSOLE_H

typedef struct console {
    int offset;
} console_t;

void console_init(console_t *console);
void console_putchar(console_t *console, char c);
void console_print(console_t *console, const char *str);
void console_printnum(console_t *console, int x);

#endif
