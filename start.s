.extern kernel_main

.global start

.set MB_MAGIC, 0x1BADBOO2
.set MB_FLAGS, (1 << 0) | (1 << 1)
.set MB_CHECKSUM, (0 - (MB_MAGIC + MB_FLAGS))

.section .mutliboot
    .align 4
    .long MB_MAGIC
    .long MB_FLAGS
    .long MB_CHECKSUM

.section .bss
    .align 16
    stack_bottom:
        .skip 4096
    stack_top:

.section .text
    start:
        mov $stack_top, %esp // set stack pointer

        call kernel_main

        hang:
            cli // Disable CPU interrupts
            hlt // Halt the CPU
            jmp hang // If didn't work - try again

