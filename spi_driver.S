@This code is written from AI first
.syntax unified
.cpu cortex-m33
.thumb
.align 4

.global spi_send_byte

.section .text
.type spi_send_byte, %function
spi_send_byte:
    push {r4, lr}
    ldr r1, =0xd0000000
    mov r2, #8
    mov r4, #(1 << 24)
    mov r3, #(1 << 29)

send_loop:
    tst r0, #0x80
    ite ne
    strne r4, [r1, #0x14]
    streq r4, [r1, #0x18]

    str r3, [r1, #0x14]
    nop
    str r3, [r1, #0x18]

    lsl r0, r0, #1
    subs r2, r2, #1
    bne send_loop

    pop {r4, pc}
