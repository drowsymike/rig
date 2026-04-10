# rig

## Description
Firmware for a password storage device based on STM32F401CC / STM32F411CC microcontrollers.  
Written in C.

## Target Hardware
- MCU: STM32F401CC / STM32F411CC
- Architecture: ARM Cortex-M4

## Functionality
- PC interaction in HID mode
- Automation of input of passwords, identifiers, tokens and other sensitive information
- Switching to data reset mode, followed by requesting a new fingerprint
- User authentication using a fingerprint
- Selecting an account for authentication
- Select accounts using the list on the built-in display
- Storing events in non-volatile flash memory
- Secure storage of passwords
- Access to stored data via device interface

## Accompanying source code
- Module for fingerprint scanner: https://github.com/leftboardcuttenstring/stm32_hal_r557_driver/tree/rig_submodule
- Module for SD memory card: none
- Module for LCD screen: the library is used: https://github.com/Floyd-Fish/ST7789-STM32
- Module for init the device as a HID device: none

## Project Structure
- `app/` — source files
- `config/` — project config
- `platform/` — startup-files, linker scripts etc.

## Requirements
- ARM GCC Toolchain
- STM32 HAL / CMSIS
- Make