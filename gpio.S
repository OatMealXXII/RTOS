.syntax unified
.cpu cortex-m33
.thumb
.align 4

.global init_wifi_pin

.section .text
.type init_wifi_pin, %function
init_wifi_pin:
    mov r1, #5
    ldr r0, =0x400200bc
    str r1, [r0]
    ldr r0, =0x400200c0
    str r1, [r0]
    ldr r0, =0x400200c4
    str r1, [r0]
    ldr r0, =0x400200d4
    str r1, [r0]

    ldr r0, =0xd0000000
    ldr r1, =( (1 << 23) | (1 << 24) | (1 << 25) | (1 << 29) )
    str r1, [r0, #0x24]

    ldr r1, =( (1 << 23) | (1 << 25))
    str r1, [r0, #0x14]
    bx  lr

.global delay_cycles
.type delay_cycles, %function
delay_cycles:
    subs r0, #1
    bne delay_cycles
    bx lr
