TARGET = firmware

include config/chip.mk

CC = arm-none-eabi-gcc
OBJCOPY = arm-none-eabi-objcopy

CPU = -mcpu=cortex-m4 -mthumb -mfloat-abi=softfp -mfpu=fpv4-sp-d16

CFLAGS = $(CPU) -O2 -Wall
CFLAGS += -Iapp/inc
CFLAGS += -Iapp/lib/
CFLAGS += -Iapp/lib/ST7789-STM32-master/ST7789
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
config/clock.c \
platform/startup/$(STARTUP) \
platform/cmsis/Device/ST/STM32F4xx/Source/Templates/system_stm32f4xx.c \
platform/hal/Src/stm32f4xx_hal.c \
platform/hal/Src/stm32f4xx_hal_gpio.c \
platform/hal/Src/stm32f4xx_hal_rcc.c \
platform/hal/Src/stm32f4xx_hal_cortex.c \
platform/hal/Src/stm32f4xx_hal_spi.c \
platform/hal/Src/stm32f4xx_hal_dma.c \

all: $(TARGET).elf

$(TARGET).elf:
	mkdir -p build
	$(CC) $(CFLAGS) $(SRC) $(LDFLAGS) -o build/$@
	$(OBJCOPY) -O ihex build/$(TARGET).elf build/$(TARGET).hex
	$(OBJCOPY) -O binary build/$(TARGET).elf build/$(TARGET).bin

clean:
	rm -rf build/*