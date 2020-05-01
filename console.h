#ifndef CONSOLE_H
#define CONSOLE_H

typedef struct console {
    int offset;
} console_t;

void console_init();
void console_putchar(char c);
void console_print(const char *str);
void console_printnum(int x);

#endif
