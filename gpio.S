.syntax unified
.cpu cortex-m33
.thumb
.align 4

.global init_wifi_pin

.section .text
.type init_wifi_pin, %function
init_wifi_pin:
    ldr r0, =0x400200bc
    mov r1, #5
    str r1, [r0]

    ldr r0, =0xd0000000
    mov r1, #(1 << 23)
    str r1, [r0, #0x24]
    str r1, [r0, #0x14]
    bx  lr

.global delay_cycles
.type delay_cycles, %function
delay_cycles:
    subs r0, #1
    bne delay_cycles
    bx lr
