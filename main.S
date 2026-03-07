.syntax unified
.cpu cortex-m33
.thumb
.align 4

.global main
.section .text
.section "vectors", "a", %progbits
    .word 0x20001000  // Initial Stack Pointer
    .word main         // Reset Handler

.type main, %function
main:
    ldr r0, =0x40024000
    ldr r1, =0xFAB11F
    str r1, [r0]

ldr r2, =0x40024004
loop_start:
    ldr r3, [r2]
    cmp r3, #0
    bpl loop_start

    ldr r3, =0x40008000
    ldr r4, =0x01
    str r4, [r3]

end_loop:
    b end_loop