#include <stdint.h>

void kernel_main() {
    uint16_t *video = (uint16_t *)0xb8000;
    int index;
    for (index = 0; index < 80 * 25; ++index) {
        video[index] = 0;
    }

    char message[] = "Reducio!";
    for (index = 0; message[index]; ++index) {
        video[index] = 0x0f << 8 | message[index];
    }
}
