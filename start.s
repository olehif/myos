.extern kernel_main

.global start

.set MB_MAGIC, 0x1BADB002
.set MB_FLAGS, (1 << 0) | (1 << 1)
.set MB_CHECKSUM, (0 - (MB_MAGIC + MB_FLAGS))

.section .multiboot
    .align 4
    .long MB_MAGIC
    .long MB_FLAGS
    .long MB_CHECKSUM

.section .gdt
    gdt_start:

    gdt_null:
      .long 0x0
      .long 0x0

    gdt_code:
      .word 0xffff     # limit 0-15
      .word 0x0        # base 0-15
      .byte 0x0        # base 16-23
      .byte 0b10011010 # flags, type
      .byte 0b11001111 # flags, limit 16-19
      .byte 0x0        # base 24-31

    gdt_data:
      .word 0xffff     # limit 0-15
      .word 0x0        # base 0-15
      .byte 0x0        # base 16-23
      .byte 0b10010010 # flags, type
      .byte 0b11001111 # flags, limit 16-19
      .byte 0x0        # base 24-31

    gdt_end:

    gdt_descriptor:
      .word gdt_end - gdt_start - 1
      .word gdt_start

.section .bss
    .align 16
    stack_bottom:
        .skip 4096
    stack_top:

.section .text
    start:
        mov $stack_top, %esp

        lgdt (gdt_descriptor)

        call kernel_main

        hang:
            cli
            hlt
            jmp hang

