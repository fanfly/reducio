# reducio
An attempt to create an operating system from scratch.

## Warning
It is not recommended to run this kernel on a real machine.

## Compilation
You need a cross-compiler `i686-elf-gcc`, a cross-assembler `i686-elf-as` and
a cross-linker `i686-elf-ld` to build the kernel.
You can follow the [tutorial](https://wiki.osdev.org/GCC_Cross-Compiler) at
the OSDev Wiki to compile these tools.

## Features
### Implemented
* Boot from scratch
* Entering 32-bit protect mode
* Screen output
* Interrupt handling
* Timer
* Keyboard input
* Shell
