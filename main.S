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
    ldr r0, =0x20000000

end_loop:
    b end_loop