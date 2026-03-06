ENTRY(main)

MEMORY{
    FLASH (rx) : ORIGIN = 0x00000000, LENGTH = 4096K
    RAM (rwx) : ORIGIN = 0x20000000, LENGTH = 520K
}

SECTIONS {
    .text : {
        *(.text*)
    } > FLASH

    __TopStack = ORIGIN(RAM) + LENGTH(RAM);
}