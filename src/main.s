.syntax unified
.cpu cortex-m33
.thumb
.align 4

.global _start
.extern wifi_firmware_start
.extern wifi_firmware_size
.section .text
.section "vectors", "a", %progbits
    .word 0x20000000  // Initial Stack Pointer
    .word _start      // Reset Handler

.type _start, %function
_start:
    LDR R0, =0x40048000
    LDR R1, =0xC4
    STR R1, [R0, #0x0C]

    LDR R2, =0x40048004
wait_xosc:
    LDR R3, [R2]
    TST R3, #(1 << 31)
    BEQ wait_xosc

    LDR R0, =0x40008000
    LDR R1, =0x01
    STR R1, [R0]

    LDR R0, =0x40028008
    LDR R1, =125
    STR R1, [R0]

    LDR R0, =0x4002800C
    LDR R1, =0x52000
    STR R1, [R0]

    LDR R0, =0x40028004
    LDR R1, =0
    STR R1, [R0]

    LDR R0, =0x40028000
wait_pll:
    LDR R1, [R0]
    CMP R1, #0
    bpl wait_pll

    LDR R0, =0x40008000
    LDR R1, =0x02
    STR R1, [R0]

    bl init_wifi_pin
    LDR R0, =1500000
    bl delay_cycles

    LDR R0, =0xd0000018
    MOV R1, #(1 << 25)
    STR R1, [R0]

    LDR R0, =0x60000000
    bl spi_send_data

    LDR R4, =wifi_firmware_start
    LDR R5, =wifi_firmware_size
    LDR R5, [R5]

inject_loop:
    LDRB R0, [R4], #1
    bl spi_send_byte
    subs r5, r5, #1
    bne inject_loop

    LDR R0, =0xd0000014
    MOV R1, #(1 << 25)
    STR R1, [R0]

    LDR R0, =200000
    bl delay_cycles

    LDR R0, =0xd0000018
    MOV R1, #(1 << 25)
    STR R1, [R0]

    LDR R0, =0x64000001
    bl spi_send_data
    LDR R0, =0x00000001
    bl spi_send_data

    LDR R0, =0xd0000014
    MOV R1, #(1 << 25)
    STR R1, [R0]

end_loop:
    b end_loop
