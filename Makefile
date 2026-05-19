TARGET = firmware

include config/chip.mk

CC = arm-none-eabi-gcc
OBJCOPY = arm-none-eabi-objcopy

CPU = -mcpu=cortex-m4 -mthumb -mfloat-abi=softfp -mfpu=fpv4-sp-d16

CFLAGS = $(CPU) -O2 -Wall
CFLAGS += -Iapp/inc
CFLAGS += -Iapp/lib/
CFLAGS += -Iapp/lib/ST7789-STM32-master/ST7789
CFLAGS += -Iapp/lib/STM32_USB_Device_Library/Class/HID/Inc/
CFLAGS += -Iapp/lib/STM32_USB_Device_Library/Core/Inc/
CFLAGS += -Iapp/lib/USB_DEVICE/App
CFLAGS += -Iapp/lib/USB_DEVICE/Target
CFLAGS += -Iconfig
CFLAGS += -Iplatform/hal/Inc
CFLAGS += -Iplatform/cmsis/Include
CFLAGS += -Iplatform/cmsis/Device/ST/STM32F4xx/Include
CFLAGS += -DUSE_HAL_DRIVER $(DEFS)

LDFLAGS = -T platform/linker/$(LDSCRIPT) -nostartfiles --specs=nosys.specs --specs=nano.specs

SRC = \
app/src/main.c \
app/lib/ST7789-STM32-master/ST7789/fonts.c \
app/lib/ST7789-STM32-master/ST7789/st7789.c \
app/lib/STM32_USB_Device_Library/Class/HID/Src/usbd_hid.c \
app/lib/STM32_USB_Device_Library/Core/Src/usbd_core.c \
app/lib/STM32_USB_Device_Library/Core/Src/usbd_ioreq.c \
app/lib/STM32_USB_Device_Library/Core/Src/usbd_ctlreq.c \
app/lib/USB_DEVICE/Target/usbd_conf.c \
app/lib/USB_DEVICE/App/usb_device.c \
app/lib/USB_DEVICE/App/usbd_desc.c \
config/clock.c \
platform/startup/$(STARTUP) \
platform/cmsis/Device/ST/STM32F4xx/Source/Templates/system_stm32f4xx.c \
platform/hal/Src/stm32f4xx_hal.c \
platform/hal/Src/stm32f4xx_hal_gpio.c \
platform/hal/Src/stm32f4xx_hal_rcc.c \
platform/hal/Src/stm32f4xx_hal_cortex.c \
platform/hal/Src/stm32f4xx_hal_spi.c \
platform/hal/Src/stm32f4xx_hal_dma.c \
platform/hal/Src/stm32f4xx_hal_pcd.c \
platform/hal/Src/stm32f4xx_hal_pcd_ex.c \
platform/hal/Src/stm32f4xx_ll_usb.c \
platform/hal/Src/stm32f4xx_hal_pwr.c \
platform/hal/Src/stm32f4xx_hal_pwr_ex.c \
platform/hal/Src/stm32f4xx_hal_exti.c \

#after the usbd_conf.c
#app/lib/STM32_USB_Device_Library/Core/Src/usbd_conf_template.c \

all: $(TARGET).elf

$(TARGET).elf:
	mkdir -p build
	$(CC) $(CFLAGS) $(SRC) $(LDFLAGS) -o build/$@
	$(OBJCOPY) -O ihex build/$(TARGET).elf build/$(TARGET).hex
	$(OBJCOPY) -O binary build/$(TARGET).elf build/$(TARGET).bin

clean:
	rm -rf build/*