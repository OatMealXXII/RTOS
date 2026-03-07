.syntax unified
.cpu cortex-m33
.thumb
.align 4

.global _start
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

end_loop:
    b end_loop
