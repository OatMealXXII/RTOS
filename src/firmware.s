.syntax unified
.cpu cortex-m33
.thumb
.align 4

.section .rodata
.global wifi_firmware_start
wifi_firmware_start:
    .incbin "firmware/43439A0.bin"

.global wifi_firmware_end
wifi_firmware_end:

.global wifi_firmware_size
wifi_firmware_size:
    .word wifi_firmware_end - wifi_firmware_start
