##########################################################################################################################
# File automatically-generated by tool: [projectgenerator] version: [3.1.0] date: [Wed Apr 03 15:48:27 CEST 2019] 
##########################################################################################################################

# ------------------------------------------------
# Generic Makefile (based on gcc)
#
# ChangeLog :
#	2017-02-10 - Several enhancements + project update mode
#   2015-07-22 - first version
# ------------------------------------------------

######################################
# target
######################################
UPDATER_TARGET = lr11xx-updater-tool


######################################
# building variables
######################################
# debug build?
DEBUG = 1
# optimization
OPT = -Og

#######################################
# Git information
# Thanks to https://nullpointer.io/post/easily-embed-version-information-in-software-releases/
#######################################

GIT_VERSION := $(shell git --no-pager describe --tags --always --dirty)
GIT_COMMIT  := $(shell git rev-parse --verify HEAD)
GIT_DATE    := $(firstword $(shell git --no-pager show --date=iso-strict --format="%ad" --name-only))
BUILD_DATE  := $(shell date --iso=seconds)

UPDATER_TARGET_NAME = $(UPDATER_TARGET)_$(GIT_VERSION)

#######################################
# paths
#######################################
# Build path
BUILD_DIR = build

######################################
# source
######################################

# C sources
C_SOURCES =  \
application/src/main.c \
application/src/gui.c \
application/src/lr11xx_hal.c \
application/src/lr1110_modem_hal.c \
application/src/lr11xx_firmware_update.c \
external/STM32CubeL4/Drivers/STM32L4xx_HAL_Driver/Src/stm32l4xx_ll_spi.c \
external/STM32CubeL4/Drivers/STM32L4xx_HAL_Driver/Src/stm32l4xx_ll_tim.c \
external/STM32CubeL4/Drivers/STM32L4xx_HAL_Driver/Src/stm32l4xx_ll_usart.c \
external/STM32CubeL4/Drivers/STM32L4xx_HAL_Driver/Src/stm32l4xx_ll_rcc.c \
external/STM32CubeL4/Drivers/STM32L4xx_HAL_Driver/Src/stm32l4xx_ll_gpio.c \
external/STM32CubeL4/Drivers/STM32L4xx_HAL_Driver/Src/stm32l4xx_ll_pwr.c \
external/STM32CubeL4/Drivers/STM32L4xx_HAL_Driver/Src/stm32l4xx_ll_exti.c \
external/STM32CubeL4/Drivers/STM32L4xx_HAL_Driver/Src/stm32l4xx_ll_utils.c \
external/STM32CubeL4/Drivers/CMSIS/Device/ST/STM32L4xx/Source/Templates/system_stm32l4xx.c \
display_touch/src/lv_port_disp.c \
display_touch/src/semtech_logo.c \
display_touch/src/display.c \
system/src/system_clock.c \
system/src/system_gpio.c \
system/src/system_it.c \
system/src/system_spi.c \
system/src/system_uart.c \
system/src/system_time.c \
system/src/system.c \
lr11xx_driver/src/lr11xx_bootloader.c \
lr11xx_driver/src/lr11xx_system.c \
lr1110_modem_driver/src/lr1110_modem_lorawan.c \
gcc/redirect.c \
gcc/usart_redirect.c

# Integration of the LVGL library
LVGL_DIR = ./external/
CSRCS =
include external/lvgl/lvgl.mk
C_SOURCES += ${CSRCS}

# ASM sources
ASM_SOURCES =  \
external/STM32CubeL4/Drivers/CMSIS/Device/ST/STM32L4xx/Source/Templates/gcc/startup_stm32l476xx.s


#######################################
# binaries
#######################################
PREFIX = arm-none-eabi-
# The gcc compiler bin path can be either defined in make command via GCC_PATH variable (> make GCC_PATH=xxx)
# either it can be added to the PATH environment variable.
ifdef GCC_PATH
CC = $(GCC_PATH)/$(PREFIX)gcc
CPP = $(GCC_PATH)/$(PREFIX)g++
AS = $(GCC_PATH)/$(PREFIX)gcc -x assembler-with-cpp
CP = $(GCC_PATH)/$(PREFIX)objcopy
SZ = $(GCC_PATH)/$(PREFIX)size
else
CC = $(PREFIX)gcc
CPP = $(PREFIX)g++
AS = $(PREFIX)gcc -x assembler-with-cpp
CP = $(PREFIX)objcopy
SZ = $(PREFIX)size
endif
HEX = $(CP) -O ihex
BIN = $(CP) -O binary -S
 
#######################################
# CFLAGS
#######################################
# cpu
CPU = -mcpu=cortex-m4

# fpu
FPU = -mfpu=fpv4-sp-d16

# float-abi
FLOAT-ABI = -mfloat-abi=hard

# mcu
MCU = $(CPU) -mthumb $(FPU) $(FLOAT-ABI)

# macros for gcc
# AS defines
AS_DEFS = 

# C defines
C_DEFS =  \
-DLV_CONF_INCLUDE_SIMPLE \
-DUSE_FULL_LL_DRIVER \
-DSTM32L476xx \
-DGIT_VERSION=\"$(GIT_VERSION)\" \
-DGIT_COMMIT=\"$(GIT_COMMIT)\" \
-DGIT_DATE=\"$(GIT_DATE)\" \
-DBUILD_DATE=\"$(BUILD_DATE)\"


# AS includes
AS_INCLUDES = 

# C includes
C_INCLUDES =  \
-Iapplication/inc \
-Iexternal/STM32CubeL4/Drivers/CMSIS/Device/ST/STM32L4xx/Include \
-Iexternal/STM32CubeL4/Drivers/CMSIS/Core/Include \
-Iexternal/STM32CubeL4/Drivers/STM32L4xx_HAL_Driver/Inc \
-Idisplay_touch/inc \
-Iexternal/lvgl \
-Iexternal/lvgl/src/lv_core \
-Iexternal/lvgl/src/lv_draw \
-Iexternal/lvgl/src/lv_font \
-Iexternal/lvgl/src/lv_hal \
-Iexternal/lvgl/src/lv_misc \
-Iexternal/lvgl/src/lv_objx \
-Iexternal/lvgl/src/lv_themes \
-Iexternal/lvgl/src \
-Isystem/inc \
-Ilr11xx_driver/src \
-Ilr1110_modem_driver/src \
-Ihci \
-Ihci/Command/Inc

# compile gcc flags
ASFLAGS = $(MCU) $(AS_DEFS) $(AS_INCLUDES) $(OPT) -Wall -fdata-sections -ffunction-sections

CFLAGS = $(MCU) $(C_DEFS) $(C_INCLUDES) $(OPT) -Wall -fdata-sections -ffunction-sections -std=c99

ifeq ($(DEBUG), 1)
CFLAGS += -g -gdwarf-2
endif

CPPFLAGS = $(MCU) $(C_DEFS) $(C_INCLUDES) $(OPT) -Wall -fdata-sections -ffunction-sections -std=c++11
ifeq ($(DEBUG), 1)
CPPFLAGS += -g -gdwarf-2
endif


# Generate dependency information
CFLAGS += -MMD -MP -MF"$(@:%.o=%.d)"
CPPFLAGS += -MMD -MP -MF"$(@:%.o=%.d)"


#######################################
# LDFLAGS
#######################################
# link script
LDSCRIPT = gcc/STM32L476RGTx_FLASH.ld

# libraries
LIBS = -lc -lm -lnosys 
LIBDIR = 
LDFLAGS = $(MCU) --specs=nosys.specs -T$(LDSCRIPT) $(LIBDIR) $(LIBS) -Wl,-Map=$(BUILD_DIR)/$(UPDATER_TARGET).map,--cref -Wl,--gc-sections

# default action: build all
all: target

target: $(BUILD_DIR)/$(UPDATER_TARGET).elf $(BUILD_DIR)/$(UPDATER_TARGET).bin $(BUILD_DIR)/$(UPDATER_TARGET_NAME).elf $(BUILD_DIR)/$(UPDATER_TARGET_NAME).hex $(BUILD_DIR)/$(UPDATER_TARGET_NAME).bin


#######################################
# build the application
#######################################

## For the main application
# list of objects
OBJECTS = $(addprefix $(BUILD_DIR)/,$(notdir $(C_SOURCES:.c=.o)))
vpath %.c $(sort $(dir $(C_SOURCES)))

# list of ASM program objects
OBJECTS += $(addprefix $(BUILD_DIR)/,$(notdir $(ASM_SOURCES:.s=.o)))
vpath %.s $(sort $(dir $(ASM_SOURCES)))


$(BUILD_DIR)/%.o: %.c Makefile | $(BUILD_DIR) 
	$(CC) -c $(CFLAGS) -Wa,-a,-ad,-alms=$(BUILD_DIR)/$(notdir $(<:.c=.lst)) $< -o $@

$(BUILD_DIR)/%.o: %.s Makefile | $(BUILD_DIR)
	$(AS) -c $(CFLAGS) $< -o $@

$(BUILD_DIR)/$(UPDATER_TARGET_NAME).elf: $(OBJECTS) Makefile
	$(CPP) $(OBJECTS) $(LDFLAGS) -o $@
	$(SZ) $@

$(BUILD_DIR)/$(UPDATER_TARGET).elf: $(OBJECTS) Makefile
	$(CPP) $(OBJECTS) $(LDFLAGS) -o $@
	$(SZ) $@

$(BUILD_DIR)/%.hex: $(BUILD_DIR)/%.elf | $(BUILD_DIR)
	$(HEX) $< $@
	
$(BUILD_DIR)/%.bin: $(BUILD_DIR)/%.elf | $(BUILD_DIR)
	$(BIN) $< $@
	
$(BUILD_DIR):
	mkdir $@


print-%  : ; @echo $* = $($*)

#######################################
# clean up
#######################################
clean:
	-rm -fR $(BUILD_DIR)
  
#######################################
# dependencies
#######################################
-include $(wildcard $(BUILD_DIR)/*.d)

# *** EOF ***
