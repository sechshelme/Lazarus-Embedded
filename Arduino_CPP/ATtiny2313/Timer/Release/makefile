################################################################################
# Automatically-generated file. Do not edit!
################################################################################

-include ../makefile.init

RM := rm -f

# All of the sources participating in the build are defined here
-include sources.mk
-include subdir.mk
-include core/core/subdir.mk
-include objects.mk

ifneq ($(MAKECMDGOALS),clean)
ifneq ($(strip $(CC_DEPS)),)
-include $(CC_DEPS)
endif
ifneq ($(strip $(C++_DEPS)),)
-include $(C++_DEPS)
endif
ifneq ($(strip $(C_UPPER_DEPS)),)
-include $(C_UPPER_DEPS)
endif
ifneq ($(strip $(CXX_DEPS)),)
-include $(CXX_DEPS)
endif
ifneq ($(strip $(ASM_DEPS)),)
-include $(ASM_DEPS)
endif
ifneq ($(strip $(INO_DEPS)),)
-include $(INO_DEPS)
endif
ifneq ($(strip $(PDE_DEPS)),)
-include $(PDE_DEPS)
endif
ifneq ($(strip $(S_UPPER_DEPS)),)
-include $(S_UPPER_DEPS)
endif
ifneq ($(strip $(CPP_DEPS)),)
-include $(CPP_DEPS)
endif
ifneq ($(strip $(C_DEPS)),)
-include $(C_DEPS)
endif
endif

-include ../makefile.defs

# Add inputs and outputs from these tool invocations to the build variables 
AR += \
/n4800/DATEN/Programmierung/Arduino/ATtiny2313/Release/arduino.ar \

ELF += \
ATtiny2313_Timer.elf \

HEX += \
ATtiny2313_Timer.hex \


# All Target
all: ATtiny2313_Timer

# Tool invocations
ATtiny2313_Timer: $(HEX)
	@echo 'Building target: $@'
	@echo 'Printing size:'
	"/home/tux/Programme/sloeber//arduinoPlugin/packages/arduino/tools/avr-gcc/4.9.2-atmel3.5.4-arduino2/bin/avr-size" -A "/n4800/DATEN/Programmierung/Arduino/ATtiny2313/Release/ATtiny2313_Timer.elf"
	@echo 'Finished building target: $@'
	@echo ' '

/n4800/DATEN/Programmierung/Arduino/ATtiny2313/Release/arduino.ar: $(AR_OBJ)
	@echo 'Starting archiver'
	"/home/tux/Programme/sloeber//arduinoPlugin/packages/arduino/tools/avr-gcc/4.9.2-atmel3.5.4-arduino2/bin/avr-ar" rcs    /n4800/DATEN/Programmierung/Arduino/ATtiny2313/Release/arduino.ar $(AR_OBJ)
	@echo 'Finished building: $@'
	@echo ' '

ATtiny2313_Timer.elf: $(LINK_OBJ) $(AR)
	@echo 'Starting combiner'
	"/home/tux/Programme/sloeber//arduinoPlugin/packages/arduino/tools/avr-gcc/4.9.2-atmel3.5.4-arduino2/bin/avr-gcc" -Wall -Wextra -Os -Wl,--gc-sections -mmcu=attiny2313 -o "/n4800/DATEN/Programmierung/Arduino/ATtiny2313/Release/ATtiny2313_Timer.elf"   $(LINK_OBJ) $(AR)   /n4800/DATEN/Programmierung/Arduino/ATtiny2313/Release/arduino.ar  "-L/n4800/DATEN/Programmierung/Arduino/ATtiny2313/Release" -lm
	@echo 'Finished building: $@'
	@echo ' '

ATtiny2313_Timer.hex: $(ELF)
	@echo 'Create eeprom image'
	${A.RECIPE.OBJCOPY.EEP.PATTERN}
	${A.RECIPE.OBJCOPY.HEX.PATTERN}
	@echo 'Finished building: $@'
	@echo ' '

# Other Targets
clean:
	-$(RM) $(C_UPPER_DEPS)$(PDE_DEPS)$(C_DEPS)$(AR)$(CC_DEPS)$(AR_OBJ)$(C++_DEPS)$(LINK_OBJ)$(CXX_DEPS)$(ASM_DEPS)$(HEX)$(INO_DEPS)$(SIZEDUMMY)$(S_UPPER_DEPS)$(ELF)$(CPP_DEPS)
	-@echo ' '

.PHONY: all clean dependents
.SECONDARY:

-include ../makefile.targets
