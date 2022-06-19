################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
INO_SRCS += \
../BCD_7_Segment.ino 

CPP_SRCS += \
../sloeber.ino.cpp 

LINK_OBJ += \
./sloeber.ino.cpp.o 

INO_DEPS += \
./BCD_7_Segment.ino.d 

CPP_DEPS += \
./sloeber.ino.cpp.d 


# Each subdirectory must supply rules for building sources it contributes
BCD_7_Segment.o: ../BCD_7_Segment.ino
	@echo 'Building file: $<'
	@echo 'Starting C++ compile'
	"/home/tux/Programme/sloeber//arduinoPlugin/packages/arduino/tools/avr-gcc/4.9.2-atmel3.5.4-arduino2/bin/avr-g++" -c -g -Os -Wall -Wextra -std=gnu++11 -fpermissive -fno-exceptions -ffunction-sections -fdata-sections -fno-threadsafe-statics -mmcu=attiny84 -DF_CPU=8000000L -DARDUINO=10802 -DARDUINO_AVR_ATTINYX4 -DARDUINO_ARCH_AVR   -I"/home/tux/Programme/sloeber/arduinoPlugin/packages/ATTinyCore/hardware/avr/1.1.5/cores/tiny" -I"/home/tux/Programme/sloeber/arduinoPlugin/packages/ATTinyCore/hardware/avr/1.1.5/variants/tinyX4_reverse" -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" -D__IN_ECLIPSE__=1 -x c++ "$<"  -o  "$@"
	@echo 'Finished building: $<'
	@echo ' '

sloeber.ino.cpp.o: ../sloeber.ino.cpp
	@echo 'Building file: $<'
	@echo 'Starting C++ compile'
	"/home/tux/Programme/sloeber//arduinoPlugin/packages/arduino/tools/avr-gcc/4.9.2-atmel3.5.4-arduino2/bin/avr-g++" -c -g -Os -Wall -Wextra -std=gnu++11 -fpermissive -fno-exceptions -ffunction-sections -fdata-sections -fno-threadsafe-statics -mmcu=attiny84 -DF_CPU=8000000L -DARDUINO=10802 -DARDUINO_AVR_ATTINYX4 -DARDUINO_ARCH_AVR   -I"/home/tux/Programme/sloeber/arduinoPlugin/packages/ATTinyCore/hardware/avr/1.1.5/cores/tiny" -I"/home/tux/Programme/sloeber/arduinoPlugin/packages/ATTinyCore/hardware/avr/1.1.5/variants/tinyX4_reverse" -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" -D__IN_ECLIPSE__=1 -x c++ "$<"  -o  "$@"
	@echo 'Finished building: $<'
	@echo ' '


