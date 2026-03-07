.syntax unified
.cpu cortex-m33
.thumb
.align 4

.global _start
.extern wifi_firmware_start
.extern wifi_firmware_size
.section .text
.section "vectors", "a", %progbits
    .word 0x20001000  // Initial Stack Pointer
    .word _start      // Reset Handler

.type _start, %function
_start:
    ldr r0, =0x40024000
    ldr r1, =0xFAB11F
    str r1, [r0]

    ldr r2, =0x40024004
wait_xosc:
    ldr r3, [r2]
    cmp r3, #0
    bpl wait_xosc

    ldr r0, =0x40008000
    ldr r1, =0x01
    str r1, [r0]

    ldr r0, =0x40028008
    ldr r1, =125
    str r1, [r0]

    ldr r0, =0x4002800C
    ldr r1, =0x52000
    str r1, [r0]

    ldr r0, =0x40028004
    ldr r1, =0
    str r1, [r0]

    ldr r0, =0x40028000
wait_pll:
    ldr r1, [r0]
    cmp r1, #0
    bpl wait_pll

    ldr r0, =0x40008000
    ldr r1, =0x02
    str r1, [r0]

    bl init_wifi_pin
    ldr r0, =1500000
    bl delay_cycles

    ldr r0, =0xd0000018
    mov r1, #(1 << 25)
    str r1, [r0]

    ldr r0, =0x60000000
    bl spi_send_data

    ldr r4, =wifi_firmware_start
    ldr r5, =wifi_firmware_size
    ldr r5, [r5]

inject_loop:
    ldrb r0, [r4], #1
    bl spi_send_byte
    subs r5, r5, #1
    bne inject_loop

    ldr r0, =0xd0000014
    mov r1, #(1 << 25)
    str r1, [r0]

    ldr r0, =200000
    bl delay_cycles

    ldr r0, =0xd0000018
    mov r1, #(1 << 25)
    str r1, [r0]

    ldr r0, =0x64000001
    bl spi_send_data
    ldr r0, =0x00000001
    bl spi_send_data

    ldr r0, =0xd0000014
    mov r1, #(1 << 25)
    str r1, [r0]

end_loop:
    b end_loop
