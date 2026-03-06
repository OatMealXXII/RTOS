.syntax unified
.cpu cortex-m33
.thumb

.global main
.section .text

main:
    movs r0, #10
    movs r1, #20

    adds r0, r0, r1

end_loop:
    b end_loop