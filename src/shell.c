#include "console.h"
#include "shell.h"
#include "timer.h"
#include "func.h"

int strcmp(const char *lhs, const char *rhs) {
    while (*lhs && (*lhs == *rhs)) {
        ++lhs;
        ++rhs;
    }
    return *lhs - *rhs;
}

void strcpy(char *dst, const char *src) {
    while (*src != 0) {
        *dst = *src;
        ++src;
        ++dst;
    }
}

void shell_exec(const char *cmd) {
    while (*cmd == ' ') {
        ++cmd;
    }
    if (strcmp(cmd, "uptime") == 0) {
        console_printf("%d\n", uptime());
    } else if (strcmp(cmd, "fault") == 0) {
        ((uint8_t *)0x3fffff)[1] = 0;
    } else if (strcmp(cmd, "shutdown") == 0) {
        console_printf("Goodbye.\n");
        for (int i = 0; i < 120000000; ++i) { continue; }
        shutdown();
    } else if (strcmp(cmd, "") == 0) {
        ;
    } else {
        console_printf("%s: command not found\n", cmd);
    }
}
