################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
CPP_SRCS += \
/home/tux/Programme/sloeber/arduinoPlugin/packages/ATTinyCore/hardware/avr/1.1.5/cores/tiny/HardwareSerial.cpp \
/home/tux/Programme/sloeber/arduinoPlugin/packages/ATTinyCore/hardware/avr/1.1.5/cores/tiny/Print.cpp \
/home/tux/Programme/sloeber/arduinoPlugin/packages/ATTinyCore/hardware/avr/1.1.5/cores/tiny/Stream.cpp \
/home/tux/Programme/sloeber/arduinoPlugin/packages/ATTinyCore/hardware/avr/1.1.5/cores/tiny/TinySoftwareSerial.cpp \
/home/tux/Programme/sloeber/arduinoPlugin/packages/ATTinyCore/hardware/avr/1.1.5/cores/tiny/Tone.cpp \
/home/tux/Programme/sloeber/arduinoPlugin/packages/ATTinyCore/hardware/avr/1.1.5/cores/tiny/WMath.cpp \
/home/tux/Programme/sloeber/arduinoPlugin/packages/ATTinyCore/hardware/avr/1.1.5/cores/tiny/WString.cpp \
/home/tux/Programme/sloeber/arduinoPlugin/packages/ATTinyCore/hardware/avr/1.1.5/cores/tiny/abi.cpp \
/home/tux/Programme/sloeber/arduinoPlugin/packages/ATTinyCore/hardware/avr/1.1.5/cores/tiny/main.cpp \
/home/tux/Programme/sloeber/arduinoPlugin/packages/ATTinyCore/hardware/avr/1.1.5/cores/tiny/new.cpp 

C_SRCS += \
/home/tux/Programme/sloeber/arduinoPlugin/packages/ATTinyCore/hardware/avr/1.1.5/cores/tiny/WInterrupts.c \
/home/tux/Programme/sloeber/arduinoPlugin/packages/ATTinyCore/hardware/avr/1.1.5/cores/tiny/wiring.c \
/home/tux/Programme/sloeber/arduinoPlugin/packages/ATTinyCore/hardware/avr/1.1.5/cores/tiny/wiring_analog.c \
/home/tux/Programme/sloeber/arduinoPlugin/packages/ATTinyCore/hardware/avr/1.1.5/cores/tiny/wiring_digital.c \
/home/tux/Programme/sloeber/arduinoPlugin/packages/ATTinyCore/hardware/avr/1.1.5/cores/tiny/wiring_pulse.c \
/home/tux/Programme/sloeber/arduinoPlugin/packages/ATTinyCore/hardware/avr/1.1.5/cores/tiny/wiring_shift.c 

C_DEPS += \
./core/core/WInterrupts.c.d \
./core/core/wiring.c.d \
./core/core/wiring_analog.c.d \
./core/core/wiring_digital.c.d \
./core/core/wiring_pulse.c.d \
./core/core/wiring_shift.c.d 

AR_OBJ += \
./core/core/HardwareSerial.cpp.o \
./core/core/Print.cpp.o \
./core/core/Stream.cpp.o \
./core/core/TinySoftwareSerial.cpp.o \
./core/core/Tone.cpp.o \
./core/core/WInterrupts.c.o \
./core/core/WMath.cpp.o \
./core/core/WString.cpp.o \
./core/core/abi.cpp.o \
./core/core/main.cpp.o \
./core/core/new.cpp.o \
./core/core/wiring.c.o \
./core/core/wiring_analog.c.o \
./core/core/wiring_digital.c.o \
./core/core/wiring_pulse.c.o \
./core/core/wiring_shift.c.o 

CPP_DEPS += \
./core/core/HardwareSerial.cpp.d \
./core/core/Print.cpp.d \
./core/core/Stream.cpp.d \
./core/core/TinySoftwareSerial.cpp.d \
./core/core/Tone.cpp.d \
./core/core/WMath.cpp.d \
./core/core/WString.cpp.d \
./core/core/abi.cpp.d \
./core/core/main.cpp.d \
./core/core/new.cpp.d 


# Each subdirectory must supply rules for building sources it contributes
core/core/HardwareSerial.cpp.o: /home/tux/Programme/sloeber/arduinoPlugin/packages/ATTinyCore/hardware/avr/1.1.5/cores/tiny/HardwareSerial.cpp
	@echo 'Building file: $<'
	@echo 'Starting C++ compile'
	"/home/tux/Programme/sloeber//arduinoPlugin/packages/arduino/tools/avr-gcc/4.9.2-atmel3.5.4-arduino2/bin/avr-g++" -c -g -Os -Wall -Wextra -std=gnu++11 -fpermissive -fno-exceptions -ffunction-sections -fdata-sections -fno-threadsafe-statics -mmcu=attiny84 -DF_CPU=8000000L -DARDUINO=10802 -DARDUINO_AVR_ATTINYX4 -DARDUINO_ARCH_AVR   -I"/home/tux/Programme/sloeber/arduinoPlugin/packages/ATTinyCore/hardware/avr/1.1.5/cores/tiny" -I"/home/tux/Programme/sloeber/arduinoPlugin/packages/ATTinyCore/hardware/avr/1.1.5/variants/tinyX4_reverse" -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" -D__IN_ECLIPSE__=1 -x c++ "$<"  -o  "$@"
	@echo 'Finished building: $<'
	@echo ' '

core/core/Print.cpp.o: /home/tux/Programme/sloeber/arduinoPlugin/packages/ATTinyCore/hardware/avr/1.1.5/cores/tiny/Print.cpp
	@echo 'Building file: $<'
	@echo 'Starting C++ compile'
	"/home/tux/Programme/sloeber//arduinoPlugin/packages/arduino/tools/avr-gcc/4.9.2-atmel3.5.4-arduino2/bin/avr-g++" -c -g -Os -Wall -Wextra -std=gnu++11 -fpermissive -fno-exceptions -ffunction-sections -fdata-sections -fno-threadsafe-statics -mmcu=attiny84 -DF_CPU=8000000L -DARDUINO=10802 -DARDUINO_AVR_ATTINYX4 -DARDUINO_ARCH_AVR   -I"/home/tux/Programme/sloeber/arduinoPlugin/packages/ATTinyCore/hardware/avr/1.1.5/cores/tiny" -I"/home/tux/Programme/sloeber/arduinoPlugin/packages/ATTinyCore/hardware/avr/1.1.5/variants/tinyX4_reverse" -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" -D__IN_ECLIPSE__=1 -x c++ "$<"  -o  "$@"
	@echo 'Finished building: $<'
	@echo ' '

core/core/Stream.cpp.o: /home/tux/Programme/sloeber/arduinoPlugin/packages/ATTinyCore/hardware/avr/1.1.5/cores/tiny/Stream.cpp
	@echo 'Building file: $<'
	@echo 'Starting C++ compile'
	"/home/tux/Programme/sloeber//arduinoPlugin/packages/arduino/tools/avr-gcc/4.9.2-atmel3.5.4-arduino2/bin/avr-g++" -c -g -Os -Wall -Wextra -std=gnu++11 -fpermissive -fno-exceptions -ffunction-sections -fdata-sections -fno-threadsafe-statics -mmcu=attiny84 -DF_CPU=8000000L -DARDUINO=10802 -DARDUINO_AVR_ATTINYX4 -DARDUINO_ARCH_AVR   -I"/home/tux/Programme/sloeber/arduinoPlugin/packages/ATTinyCore/hardware/avr/1.1.5/cores/tiny" -I"/home/tux/Programme/sloeber/arduinoPlugin/packages/ATTinyCore/hardware/avr/1.1.5/variants/tinyX4_reverse" -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" -D__IN_ECLIPSE__=1 -x c++ "$<"  -o  "$@"
	@echo 'Finished building: $<'
	@echo ' '

core/core/TinySoftwareSerial.cpp.o: /home/tux/Programme/sloeber/arduinoPlugin/packages/ATTinyCore/hardware/avr/1.1.5/cores/tiny/TinySoftwareSerial.cpp
	@echo 'Building file: $<'
	@echo 'Starting C++ compile'
	"/home/tux/Programme/sloeber//arduinoPlugin/packages/arduino/tools/avr-gcc/4.9.2-atmel3.5.4-arduino2/bin/avr-g++" -c -g -Os -Wall -Wextra -std=gnu++11 -fpermissive -fno-exceptions -ffunction-sections -fdata-sections -fno-threadsafe-statics -mmcu=attiny84 -DF_CPU=8000000L -DARDUINO=10802 -DARDUINO_AVR_ATTINYX4 -DARDUINO_ARCH_AVR   -I"/home/tux/Programme/sloeber/arduinoPlugin/packages/ATTinyCore/hardware/avr/1.1.5/cores/tiny" -I"/home/tux/Programme/sloeber/arduinoPlugin/packages/ATTinyCore/hardware/avr/1.1.5/variants/tinyX4_reverse" -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" -D__IN_ECLIPSE__=1 -x c++ "$<"  -o  "$@"
	@echo 'Finished building: $<'
	@echo ' '

core/core/Tone.cpp.o: /home/tux/Programme/sloeber/arduinoPlugin/packages/ATTinyCore/hardware/avr/1.1.5/cores/tiny/Tone.cpp
	@echo 'Building file: $<'
	@echo 'Starting C++ compile'
	"/home/tux/Programme/sloeber//arduinoPlugin/packages/arduino/tools/avr-gcc/4.9.2-atmel3.5.4-arduino2/bin/avr-g++" -c -g -Os -Wall -Wextra -std=gnu++11 -fpermissive -fno-exceptions -ffunction-sections -fdata-sections -fno-threadsafe-statics -mmcu=attiny84 -DF_CPU=8000000L -DARDUINO=10802 -DARDUINO_AVR_ATTINYX4 -DARDUINO_ARCH_AVR   -I"/home/tux/Programme/sloeber/arduinoPlugin/packages/ATTinyCore/hardware/avr/1.1.5/cores/tiny" -I"/home/tux/Programme/sloeber/arduinoPlugin/packages/ATTinyCore/hardware/avr/1.1.5/variants/tinyX4_reverse" -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" -D__IN_ECLIPSE__=1 -x c++ "$<"  -o  "$@"
	@echo 'Finished building: $<'
	@echo ' '

core/core/WInterrupts.c.o: /home/tux/Programme/sloeber/arduinoPlugin/packages/ATTinyCore/hardware/avr/1.1.5/cores/tiny/WInterrupts.c
	@echo 'Building file: $<'
	@echo 'Starting C compile'
	"/home/tux/Programme/sloeber//arduinoPlugin/packages/arduino/tools/avr-gcc/4.9.2-atmel3.5.4-arduino2/bin/avr-gcc" -c -g -Os -Wall -Wextra -std=gnu11 -ffunction-sections -fdata-sections -mmcu=attiny84 -DF_CPU=8000000L -DARDUINO=10802 -DARDUINO_AVR_ATTINYX4 -DARDUINO_ARCH_AVR   -I"/home/tux/Programme/sloeber/arduinoPlugin/packages/ATTinyCore/hardware/avr/1.1.5/cores/tiny" -I"/home/tux/Programme/sloeber/arduinoPlugin/packages/ATTinyCore/hardware/avr/1.1.5/variants/tinyX4_reverse" -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" -D__IN_ECLIPSE__=1 "$<"  -o  "$@"
	@echo 'Finished building: $<'
	@echo ' '

core/core/WMath.cpp.o: /home/tux/Programme/sloeber/arduinoPlugin/packages/ATTinyCore/hardware/avr/1.1.5/cores/tiny/WMath.cpp
	@echo 'Building file: $<'
	@echo 'Starting C++ compile'
	"/home/tux/Programme/sloeber//arduinoPlugin/packages/arduino/tools/avr-gcc/4.9.2-atmel3.5.4-arduino2/bin/avr-g++" -c -g -Os -Wall -Wextra -std=gnu++11 -fpermissive -fno-exceptions -ffunction-sections -fdata-sections -fno-threadsafe-statics -mmcu=attiny84 -DF_CPU=8000000L -DARDUINO=10802 -DARDUINO_AVR_ATTINYX4 -DARDUINO_ARCH_AVR   -I"/home/tux/Programme/sloeber/arduinoPlugin/packages/ATTinyCore/hardware/avr/1.1.5/cores/tiny" -I"/home/tux/Programme/sloeber/arduinoPlugin/packages/ATTinyCore/hardware/avr/1.1.5/variants/tinyX4_reverse" -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" -D__IN_ECLIPSE__=1 -x c++ "$<"  -o  "$@"
	@echo 'Finished building: $<'
	@echo ' '

core/core/WString.cpp.o: /home/tux/Programme/sloeber/arduinoPlugin/packages/ATTinyCore/hardware/avr/1.1.5/cores/tiny/WString.cpp
	@echo 'Building file: $<'
	@echo 'Starting C++ compile'
	"/home/tux/Programme/sloeber//arduinoPlugin/packages/arduino/tools/avr-gcc/4.9.2-atmel3.5.4-arduino2/bin/avr-g++" -c -g -Os -Wall -Wextra -std=gnu++11 -fpermissive -fno-exceptions -ffunction-sections -fdata-sections -fno-threadsafe-statics -mmcu=attiny84 -DF_CPU=8000000L -DARDUINO=10802 -DARDUINO_AVR_ATTINYX4 -DARDUINO_ARCH_AVR   -I"/home/tux/Programme/sloeber/arduinoPlugin/packages/ATTinyCore/hardware/avr/1.1.5/cores/tiny" -I"/home/tux/Programme/sloeber/arduinoPlugin/packages/ATTinyCore/hardware/avr/1.1.5/variants/tinyX4_reverse" -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" -D__IN_ECLIPSE__=1 -x c++ "$<"  -o  "$@"
	@echo 'Finished building: $<'
	@echo ' '

core/core/abi.cpp.o: /home/tux/Programme/sloeber/arduinoPlugin/packages/ATTinyCore/hardware/avr/1.1.5/cores/tiny/abi.cpp
	@echo 'Building file: $<'
	@echo 'Starting C++ compile'
	"/home/tux/Programme/sloeber//arduinoPlugin/packages/arduino/tools/avr-gcc/4.9.2-atmel3.5.4-arduino2/bin/avr-g++" -c -g -Os -Wall -Wextra -std=gnu++11 -fpermissive -fno-exceptions -ffunction-sections -fdata-sections -fno-threadsafe-statics -mmcu=attiny84 -DF_CPU=8000000L -DARDUINO=10802 -DARDUINO_AVR_ATTINYX4 -DARDUINO_ARCH_AVR   -I"/home/tux/Programme/sloeber/arduinoPlugin/packages/ATTinyCore/hardware/avr/1.1.5/cores/tiny" -I"/home/tux/Programme/sloeber/arduinoPlugin/packages/ATTinyCore/hardware/avr/1.1.5/variants/tinyX4_reverse" -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" -D__IN_ECLIPSE__=1 -x c++ "$<"  -o  "$@"
	@echo 'Finished building: $<'
	@echo ' '

core/core/main.cpp.o: /home/tux/Programme/sloeber/arduinoPlugin/packages/ATTinyCore/hardware/avr/1.1.5/cores/tiny/main.cpp
	@echo 'Building file: $<'
	@echo 'Starting C++ compile'
	"/home/tux/Programme/sloeber//arduinoPlugin/packages/arduino/tools/avr-gcc/4.9.2-atmel3.5.4-arduino2/bin/avr-g++" -c -g -Os -Wall -Wextra -std=gnu++11 -fpermissive -fno-exceptions -ffunction-sections -fdata-sections -fno-threadsafe-statics -mmcu=attiny84 -DF_CPU=8000000L -DARDUINO=10802 -DARDUINO_AVR_ATTINYX4 -DARDUINO_ARCH_AVR   -I"/home/tux/Programme/sloeber/arduinoPlugin/packages/ATTinyCore/hardware/avr/1.1.5/cores/tiny" -I"/home/tux/Programme/sloeber/arduinoPlugin/packages/ATTinyCore/hardware/avr/1.1.5/variants/tinyX4_reverse" -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" -D__IN_ECLIPSE__=1 -x c++ "$<"  -o  "$@"
	@echo 'Finished building: $<'
	@echo ' '

core/core/new.cpp.o: /home/tux/Programme/sloeber/arduinoPlugin/packages/ATTinyCore/hardware/avr/1.1.5/cores/tiny/new.cpp
	@echo 'Building file: $<'
	@echo 'Starting C++ compile'
	"/home/tux/Programme/sloeber//arduinoPlugin/packages/arduino/tools/avr-gcc/4.9.2-atmel3.5.4-arduino2/bin/avr-g++" -c -g -Os -Wall -Wextra -std=gnu++11 -fpermissive -fno-exceptions -ffunction-sections -fdata-sections -fno-threadsafe-statics -mmcu=attiny84 -DF_CPU=8000000L -DARDUINO=10802 -DARDUINO_AVR_ATTINYX4 -DARDUINO_ARCH_AVR   -I"/home/tux/Programme/sloeber/arduinoPlugin/packages/ATTinyCore/hardware/avr/1.1.5/cores/tiny" -I"/home/tux/Programme/sloeber/arduinoPlugin/packages/ATTinyCore/hardware/avr/1.1.5/variants/tinyX4_reverse" -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" -D__IN_ECLIPSE__=1 -x c++ "$<"  -o  "$@"
	@echo 'Finished building: $<'
	@echo ' '

core/core/wiring.c.o: /home/tux/Programme/sloeber/arduinoPlugin/packages/ATTinyCore/hardware/avr/1.1.5/cores/tiny/wiring.c
	@echo 'Building file: $<'
	@echo 'Starting C compile'
	"/home/tux/Programme/sloeber//arduinoPlugin/packages/arduino/tools/avr-gcc/4.9.2-atmel3.5.4-arduino2/bin/avr-gcc" -c -g -Os -Wall -Wextra -std=gnu11 -ffunction-sections -fdata-sections -mmcu=attiny84 -DF_CPU=8000000L -DARDUINO=10802 -DARDUINO_AVR_ATTINYX4 -DARDUINO_ARCH_AVR   -I"/home/tux/Programme/sloeber/arduinoPlugin/packages/ATTinyCore/hardware/avr/1.1.5/cores/tiny" -I"/home/tux/Programme/sloeber/arduinoPlugin/packages/ATTinyCore/hardware/avr/1.1.5/variants/tinyX4_reverse" -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" -D__IN_ECLIPSE__=1 "$<"  -o  "$@"
	@echo 'Finished building: $<'
	@echo ' '

core/core/wiring_analog.c.o: /home/tux/Programme/sloeber/arduinoPlugin/packages/ATTinyCore/hardware/avr/1.1.5/cores/tiny/wiring_analog.c
	@echo 'Building file: $<'
	@echo 'Starting C compile'
	"/home/tux/Programme/sloeber//arduinoPlugin/packages/arduino/tools/avr-gcc/4.9.2-atmel3.5.4-arduino2/bin/avr-gcc" -c -g -Os -Wall -Wextra -std=gnu11 -ffunction-sections -fdata-sections -mmcu=attiny84 -DF_CPU=8000000L -DARDUINO=10802 -DARDUINO_AVR_ATTINYX4 -DARDUINO_ARCH_AVR   -I"/home/tux/Programme/sloeber/arduinoPlugin/packages/ATTinyCore/hardware/avr/1.1.5/cores/tiny" -I"/home/tux/Programme/sloeber/arduinoPlugin/packages/ATTinyCore/hardware/avr/1.1.5/variants/tinyX4_reverse" -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" -D__IN_ECLIPSE__=1 "$<"  -o  "$@"
	@echo 'Finished building: $<'
	@echo ' '

core/core/wiring_digital.c.o: /home/tux/Programme/sloeber/arduinoPlugin/packages/ATTinyCore/hardware/avr/1.1.5/cores/tiny/wiring_digital.c
	@echo 'Building file: $<'
	@echo 'Starting C compile'
	"/home/tux/Programme/sloeber//arduinoPlugin/packages/arduino/tools/avr-gcc/4.9.2-atmel3.5.4-arduino2/bin/avr-gcc" -c -g -Os -Wall -Wextra -std=gnu11 -ffunction-sections -fdata-sections -mmcu=attiny84 -DF_CPU=8000000L -DARDUINO=10802 -DARDUINO_AVR_ATTINYX4 -DARDUINO_ARCH_AVR   -I"/home/tux/Programme/sloeber/arduinoPlugin/packages/ATTinyCore/hardware/avr/1.1.5/cores/tiny" -I"/home/tux/Programme/sloeber/arduinoPlugin/packages/ATTinyCore/hardware/avr/1.1.5/variants/tinyX4_reverse" -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" -D__IN_ECLIPSE__=1 "$<"  -o  "$@"
	@echo 'Finished building: $<'
	@echo ' '

core/core/wiring_pulse.c.o: /home/tux/Programme/sloeber/arduinoPlugin/packages/ATTinyCore/hardware/avr/1.1.5/cores/tiny/wiring_pulse.c
	@echo 'Building file: $<'
	@echo 'Starting C compile'
	"/home/tux/Programme/sloeber//arduinoPlugin/packages/arduino/tools/avr-gcc/4.9.2-atmel3.5.4-arduino2/bin/avr-gcc" -c -g -Os -Wall -Wextra -std=gnu11 -ffunction-sections -fdata-sections -mmcu=attiny84 -DF_CPU=8000000L -DARDUINO=10802 -DARDUINO_AVR_ATTINYX4 -DARDUINO_ARCH_AVR   -I"/home/tux/Programme/sloeber/arduinoPlugin/packages/ATTinyCore/hardware/avr/1.1.5/cores/tiny" -I"/home/tux/Programme/sloeber/arduinoPlugin/packages/ATTinyCore/hardware/avr/1.1.5/variants/tinyX4_reverse" -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" -D__IN_ECLIPSE__=1 "$<"  -o  "$@"
	@echo 'Finished building: $<'
	@echo ' '

core/core/wiring_shift.c.o: /home/tux/Programme/sloeber/arduinoPlugin/packages/ATTinyCore/hardware/avr/1.1.5/cores/tiny/wiring_shift.c
	@echo 'Building file: $<'
	@echo 'Starting C compile'
	"/home/tux/Programme/sloeber//arduinoPlugin/packages/arduino/tools/avr-gcc/4.9.2-atmel3.5.4-arduino2/bin/avr-gcc" -c -g -Os -Wall -Wextra -std=gnu11 -ffunction-sections -fdata-sections -mmcu=attiny84 -DF_CPU=8000000L -DARDUINO=10802 -DARDUINO_AVR_ATTINYX4 -DARDUINO_ARCH_AVR   -I"/home/tux/Programme/sloeber/arduinoPlugin/packages/ATTinyCore/hardware/avr/1.1.5/cores/tiny" -I"/home/tux/Programme/sloeber/arduinoPlugin/packages/ATTinyCore/hardware/avr/1.1.5/variants/tinyX4_reverse" -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" -D__IN_ECLIPSE__=1 "$<"  -o  "$@"
	@echo 'Finished building: $<'
	@echo ' '


