ENTRY(start)

SECTIONS {
    . = 1M;

    .rodata BLOCK(4K) : ALIGN(4K) {
        *(.multiboot)
    }

    .text BLOCK(4K) : ALIGN(4K) {
        *(.text)
    }

    .data BLOCK(4K) : ALIGN(4K) {
        *(.gdt)
    }

    .rodata BLOCK(4K) : ALIGN(4K) {
        *(.rodata)
    }

    .data BLOCK(4K) : ALIGN(4K) {
        *(.data)
    }

    .bss BLOCK(4K) : ALIGN(4K) {
        *(COMMON)
        *(.bss)
    }
}
