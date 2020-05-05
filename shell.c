#include "console.h"
#include "shell.h"
#include "timer.h"
#include "func.h"

int strcmp(const char *lhs, const char *rhs) {
    if (*lhs == 0 && *rhs == 0) {
        return 0;
    } else if (*lhs == 0) {
        return -1;
    } else if (*rhs == 0) {
        return 1;
    } else {
        if (*lhs != *rhs) {
            return (*lhs < *rhs) ? -1 : 1;
        } else {
            return strcmp(lhs + 1, rhs + 1);
        }
    }
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
        console_printnum(uptime());
        console_print("\n");
    } else if (strcmp(cmd, "") != 0) {
        console_print(cmd);
        console_print(": command not found\n");
    }
}
