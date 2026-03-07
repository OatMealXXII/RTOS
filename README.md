# RTOS: ARM Cortex-M33 Assembly Kernel for RP2350

A lightweight, bare-metal RTOS kernel designed for the **Raspberry Pi Pico 2W**, written entirely in ARM Assembly. This project focuses on high-performance system initialization, including custom XOSC and PLL configurations to achieve a stable **150MHz** system clock.

## Prerequisites

Before building the kernel, ensure your environment is configured with the following cross-compilation toolchains.

### 1. Toolchain Setup by Distribution

#### **Ubuntu / Debian**

```bash
sudo apt update
sudo apt install gcc-arm-none-eabi binutils-arm-none-eabi libnewlib-arm-none-eabi libudev-dev pkg-config

```

#### **Fedora / RHEL**

```bash
sudo dnf install arm-none-eabi-gcc-cs arm-none-eabi-newlib systemd-devel

```

#### **Arch Linux**

```bash
sudo pacman -S arm-none-eabi-gcc arm-none-eabi-binutils arm-none-eabi-newlib systemd pkgconf

```

#### **Alpine Linux**

```bash
sudo apk add gcc-arm-none-eabi binutils-arm-none-eabi udev-dev pkgconfig

```

### 2. Flash Utility

Install the Rust-based UF2 conversion tool. Ensure your Cargo path is exported.

```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source $HOME/.cargo/env
cargo install elf2uf2-rs

```

## Build Pipeline

The build process involves three stages: assembling the source, linking memory addresses, and generating the final UF2 binary.

```bash
# Assemble source into object file
arm-none-eabi-as -mcpu=cortex-m33 -mthumb -o main.o main.S

# Link at Flash base address (0x10000000)
arm-none-eabi-ld -Ttext 0x10000000 -o main.elf main.o

# Convert to UF2 for deployment
elf2uf2-rs main.elf main.uf2

```

## Deployment

1. Connect your **Pico 2W** to your workstation (PC, Laptop not required if you have any devices to flash) while holding the **BOOTSEL** button.
2. Mount the device and copy `main.uf2` to the drive.
3. The system will reboot and initialize the 150MHz PLL ignition sequence.

## Troubleshooting

* **Missing libudev**: If `elf2uf2-rs` fails to compile, verify that the `systemd-devel` (Fedora) or `libudev-dev` (Debian) headers are installed.
* **ASM Newline Warning**: Ensure `main.S` ends with a trailing newline to avoid assembler warnings.

---
