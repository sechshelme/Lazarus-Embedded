################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
INO_SRCS += \
../Stepper.ino 

CPP_SRCS += \
../.ino.cpp 

LINK_OBJ += \
./.ino.cpp.o 

INO_DEPS += \
./Stepper.ino.d 

CPP_DEPS += \
./.ino.cpp.d 


# Each subdirectory must supply rules for building sources it contributes
.ino.cpp.o: ../.ino.cpp
	@echo 'Building file: $<'
	@echo 'Starting C++ compile'
	"/home/tux/Programme/sloeber//arduinoPlugin/packages/arduino/tools/avr-gcc/4.9.2-atmel3.5.4-arduino2/bin/avr-g++" -c -g -Os -Wall -Wextra -std=gnu++11 -fpermissive -fno-exceptions -ffunction-sections -fdata-sections -fno-threadsafe-statics -flto -mmcu=attiny2313 -DF_CPU=8000000L -DARDUINO=10802 -DARDUINO_AVR_ATTINYX313 -DARDUINO_ARCH_AVR   -I"/home/tux/Programme/sloeber/arduinoPlugin/packages/ATTinyCore/hardware/avr/1.1.2/cores/tiny" -I"/home/tux/Programme/sloeber/arduinoPlugin/packages/ATTinyCore/hardware/avr/1.1.2/variants/tinyX313" -I"/home/tux/Programme/sloeber/arduinoPlugin/libraries/Stepper/1.1.2" -I"/home/tux/Programme/sloeber/arduinoPlugin/libraries/Stepper/1.1.2/src" -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" -D__IN_ECLIPSE__=1 -x c++ "$<"  -o  "$@"
	@echo 'Finished building: $<'
	@echo ' '

Stepper.o: ../Stepper.ino
	@echo 'Building file: $<'
	@echo 'Starting C++ compile'
	"/home/tux/Programme/sloeber//arduinoPlugin/packages/arduino/tools/avr-gcc/4.9.2-atmel3.5.4-arduino2/bin/avr-g++" -c -g -Os -Wall -Wextra -std=gnu++11 -fpermissive -fno-exceptions -ffunction-sections -fdata-sections -fno-threadsafe-statics -flto -mmcu=attiny2313 -DF_CPU=8000000L -DARDUINO=10802 -DARDUINO_AVR_ATTINYX313 -DARDUINO_ARCH_AVR   -I"/home/tux/Programme/sloeber/arduinoPlugin/packages/ATTinyCore/hardware/avr/1.1.2/cores/tiny" -I"/home/tux/Programme/sloeber/arduinoPlugin/packages/ATTinyCore/hardware/avr/1.1.2/variants/tinyX313" -I"/home/tux/Programme/sloeber/arduinoPlugin/libraries/Stepper/1.1.2" -I"/home/tux/Programme/sloeber/arduinoPlugin/libraries/Stepper/1.1.2/src" -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" -D__IN_ECLIPSE__=1 -x c++ "$<"  -o  "$@"
	@echo 'Finished building: $<'
	@echo ' '


