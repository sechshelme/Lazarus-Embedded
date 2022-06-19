################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
CPP_SRCS += \
/home/tux/Programme/sloeber/arduinoPlugin/packages/ATTinyCore/hardware/avr/1.1.2/cores/tiny/HardwareSerial.cpp \
/home/tux/Programme/sloeber/arduinoPlugin/packages/ATTinyCore/hardware/avr/1.1.2/cores/tiny/Print.cpp \
/home/tux/Programme/sloeber/arduinoPlugin/packages/ATTinyCore/hardware/avr/1.1.2/cores/tiny/TinySoftwareSPI.cpp \
/home/tux/Programme/sloeber/arduinoPlugin/packages/ATTinyCore/hardware/avr/1.1.2/cores/tiny/TinySoftwareSerial.cpp \
/home/tux/Programme/sloeber/arduinoPlugin/packages/ATTinyCore/hardware/avr/1.1.2/cores/tiny/Tone.cpp \
/home/tux/Programme/sloeber/arduinoPlugin/packages/ATTinyCore/hardware/avr/1.1.2/cores/tiny/WMath.cpp \
/home/tux/Programme/sloeber/arduinoPlugin/packages/ATTinyCore/hardware/avr/1.1.2/cores/tiny/WString.cpp \
/home/tux/Programme/sloeber/arduinoPlugin/packages/ATTinyCore/hardware/avr/1.1.2/cores/tiny/main.cpp 

C_SRCS += \
/home/tux/Programme/sloeber/arduinoPlugin/packages/ATTinyCore/hardware/avr/1.1.2/cores/tiny/WInterrupts.c \
/home/tux/Programme/sloeber/arduinoPlugin/packages/ATTinyCore/hardware/avr/1.1.2/cores/tiny/wiring.c \
/home/tux/Programme/sloeber/arduinoPlugin/packages/ATTinyCore/hardware/avr/1.1.2/cores/tiny/wiring_analog.c \
/home/tux/Programme/sloeber/arduinoPlugin/packages/ATTinyCore/hardware/avr/1.1.2/cores/tiny/wiring_digital.c \
/home/tux/Programme/sloeber/arduinoPlugin/packages/ATTinyCore/hardware/avr/1.1.2/cores/tiny/wiring_pulse.c \
/home/tux/Programme/sloeber/arduinoPlugin/packages/ATTinyCore/hardware/avr/1.1.2/cores/tiny/wiring_shift.c 

C_DEPS += \
./core/WInterrupts.c.d \
./core/wiring.c.d \
./core/wiring_analog.c.d \
./core/wiring_digital.c.d \
./core/wiring_pulse.c.d \
./core/wiring_shift.c.d 

AR_OBJ += \
./core/HardwareSerial.cpp.o \
./core/Print.cpp.o \
./core/TinySoftwareSPI.cpp.o \
./core/TinySoftwareSerial.cpp.o \
./core/Tone.cpp.o \
./core/WInterrupts.c.o \
./core/WMath.cpp.o \
./core/WString.cpp.o \
./core/main.cpp.o \
./core/wiring.c.o \
./core/wiring_analog.c.o \
./core/wiring_digital.c.o \
./core/wiring_pulse.c.o \
./core/wiring_shift.c.o 

CPP_DEPS += \
./core/HardwareSerial.cpp.d \
./core/Print.cpp.d \
./core/TinySoftwareSPI.cpp.d \
./core/TinySoftwareSerial.cpp.d \
./core/Tone.cpp.d \
./core/WMath.cpp.d \
./core/WString.cpp.d \
./core/main.cpp.d 


# Each subdirectory must supply rules for building sources it contributes
core/HardwareSerial.cpp.o: /home/tux/Programme/sloeber/arduinoPlugin/packages/ATTinyCore/hardware/avr/1.1.2/cores/tiny/HardwareSerial.cpp
	@echo 'Building file: $<'
	@echo 'Starting C++ compile'
	"/home/tux/Programme/sloeber//arduinoPlugin/packages/arduino/tools/avr-gcc/4.9.2-atmel3.5.4-arduino2/bin/avr-g++" -c -g -Os -Wall -Wextra -std=gnu++11 -fpermissive -fno-exceptions -ffunction-sections -fdata-sections -fno-threadsafe-statics -flto -mmcu=attiny2313 -DF_CPU=8000000L -DARDUINO=10802 -DARDUINO_AVR_ATTINYX313 -DARDUINO_ARCH_AVR   -I"/home/tux/Programme/sloeber/arduinoPlugin/packages/ATTinyCore/hardware/avr/1.1.2/cores/tiny" -I"/home/tux/Programme/sloeber/arduinoPlugin/packages/ATTinyCore/hardware/avr/1.1.2/variants/tinyX313" -I"/home/tux/Programme/sloeber/arduinoPlugin/libraries/Stepper/1.1.2" -I"/home/tux/Programme/sloeber/arduinoPlugin/libraries/Stepper/1.1.2/src" -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" -D__IN_ECLIPSE__=1 -x c++ "$<"  -o  "$@"
	@echo 'Finished building: $<'
	@echo ' '

core/Print.cpp.o: /home/tux/Programme/sloeber/arduinoPlugin/packages/ATTinyCore/hardware/avr/1.1.2/cores/tiny/Print.cpp
	@echo 'Building file: $<'
	@echo 'Starting C++ compile'
	"/home/tux/Programme/sloeber//arduinoPlugin/packages/arduino/tools/avr-gcc/4.9.2-atmel3.5.4-arduino2/bin/avr-g++" -c -g -Os -Wall -Wextra -std=gnu++11 -fpermissive -fno-exceptions -ffunction-sections -fdata-sections -fno-threadsafe-statics -flto -mmcu=attiny2313 -DF_CPU=8000000L -DARDUINO=10802 -DARDUINO_AVR_ATTINYX313 -DARDUINO_ARCH_AVR   -I"/home/tux/Programme/sloeber/arduinoPlugin/packages/ATTinyCore/hardware/avr/1.1.2/cores/tiny" -I"/home/tux/Programme/sloeber/arduinoPlugin/packages/ATTinyCore/hardware/avr/1.1.2/variants/tinyX313" -I"/home/tux/Programme/sloeber/arduinoPlugin/libraries/Stepper/1.1.2" -I"/home/tux/Programme/sloeber/arduinoPlugin/libraries/Stepper/1.1.2/src" -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" -D__IN_ECLIPSE__=1 -x c++ "$<"  -o  "$@"
	@echo 'Finished building: $<'
	@echo ' '

core/TinySoftwareSPI.cpp.o: /home/tux/Programme/sloeber/arduinoPlugin/packages/ATTinyCore/hardware/avr/1.1.2/cores/tiny/TinySoftwareSPI.cpp
	@echo 'Building file: $<'
	@echo 'Starting C++ compile'
	"/home/tux/Programme/sloeber//arduinoPlugin/packages/arduino/tools/avr-gcc/4.9.2-atmel3.5.4-arduino2/bin/avr-g++" -c -g -Os -Wall -Wextra -std=gnu++11 -fpermissive -fno-exceptions -ffunction-sections -fdata-sections -fno-threadsafe-statics -flto -mmcu=attiny2313 -DF_CPU=8000000L -DARDUINO=10802 -DARDUINO_AVR_ATTINYX313 -DARDUINO_ARCH_AVR   -I"/home/tux/Programme/sloeber/arduinoPlugin/packages/ATTinyCore/hardware/avr/1.1.2/cores/tiny" -I"/home/tux/Programme/sloeber/arduinoPlugin/packages/ATTinyCore/hardware/avr/1.1.2/variants/tinyX313" -I"/home/tux/Programme/sloeber/arduinoPlugin/libraries/Stepper/1.1.2" -I"/home/tux/Programme/sloeber/arduinoPlugin/libraries/Stepper/1.1.2/src" -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" -D__IN_ECLIPSE__=1 -x c++ "$<"  -o  "$@"
	@echo 'Finished building: $<'
	@echo ' '

core/TinySoftwareSerial.cpp.o: /home/tux/Programme/sloeber/arduinoPlugin/packages/ATTinyCore/hardware/avr/1.1.2/cores/tiny/TinySoftwareSerial.cpp
	@echo 'Building file: $<'
	@echo 'Starting C++ compile'
	"/home/tux/Programme/sloeber//arduinoPlugin/packages/arduino/tools/avr-gcc/4.9.2-atmel3.5.4-arduino2/bin/avr-g++" -c -g -Os -Wall -Wextra -std=gnu++11 -fpermissive -fno-exceptions -ffunction-sections -fdata-sections -fno-threadsafe-statics -flto -mmcu=attiny2313 -DF_CPU=8000000L -DARDUINO=10802 -DARDUINO_AVR_ATTINYX313 -DARDUINO_ARCH_AVR   -I"/home/tux/Programme/sloeber/arduinoPlugin/packages/ATTinyCore/hardware/avr/1.1.2/cores/tiny" -I"/home/tux/Programme/sloeber/arduinoPlugin/packages/ATTinyCore/hardware/avr/1.1.2/variants/tinyX313" -I"/home/tux/Programme/sloeber/arduinoPlugin/libraries/Stepper/1.1.2" -I"/home/tux/Programme/sloeber/arduinoPlugin/libraries/Stepper/1.1.2/src" -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" -D__IN_ECLIPSE__=1 -x c++ "$<"  -o  "$@"
	@echo 'Finished building: $<'
	@echo ' '

core/Tone.cpp.o: /home/tux/Programme/sloeber/arduinoPlugin/packages/ATTinyCore/hardware/avr/1.1.2/cores/tiny/Tone.cpp
	@echo 'Building file: $<'
	@echo 'Starting C++ compile'
	"/home/tux/Programme/sloeber//arduinoPlugin/packages/arduino/tools/avr-gcc/4.9.2-atmel3.5.4-arduino2/bin/avr-g++" -c -g -Os -Wall -Wextra -std=gnu++11 -fpermissive -fno-exceptions -ffunction-sections -fdata-sections -fno-threadsafe-statics -flto -mmcu=attiny2313 -DF_CPU=8000000L -DARDUINO=10802 -DARDUINO_AVR_ATTINYX313 -DARDUINO_ARCH_AVR   -I"/home/tux/Programme/sloeber/arduinoPlugin/packages/ATTinyCore/hardware/avr/1.1.2/cores/tiny" -I"/home/tux/Programme/sloeber/arduinoPlugin/packages/ATTinyCore/hardware/avr/1.1.2/variants/tinyX313" -I"/home/tux/Programme/sloeber/arduinoPlugin/libraries/Stepper/1.1.2" -I"/home/tux/Programme/sloeber/arduinoPlugin/libraries/Stepper/1.1.2/src" -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" -D__IN_ECLIPSE__=1 -x c++ "$<"  -o  "$@"
	@echo 'Finished building: $<'
	@echo ' '

core/WInterrupts.c.o: /home/tux/Programme/sloeber/arduinoPlugin/packages/ATTinyCore/hardware/avr/1.1.2/cores/tiny/WInterrupts.c
	@echo 'Building file: $<'
	@echo 'Starting C compile'
	"/home/tux/Programme/sloeber//arduinoPlugin/packages/arduino/tools/avr-gcc/4.9.2-atmel3.5.4-arduino2/bin/avr-gcc" -c -g -Os -Wall -Wextra -std=gnu11 -ffunction-sections -fdata-sections -flto -fno-fat-lto-objects -mmcu=attiny2313 -DF_CPU=8000000L -DARDUINO=10802 -DARDUINO_AVR_ATTINYX313 -DARDUINO_ARCH_AVR   -I"/home/tux/Programme/sloeber/arduinoPlugin/packages/ATTinyCore/hardware/avr/1.1.2/cores/tiny" -I"/home/tux/Programme/sloeber/arduinoPlugin/packages/ATTinyCore/hardware/avr/1.1.2/variants/tinyX313" -I"/home/tux/Programme/sloeber/arduinoPlugin/libraries/Stepper/1.1.2" -I"/home/tux/Programme/sloeber/arduinoPlugin/libraries/Stepper/1.1.2/src" -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" -D__IN_ECLIPSE__=1 "$<"  -o  "$@"
	@echo 'Finished building: $<'
	@echo ' '

core/WMath.cpp.o: /home/tux/Programme/sloeber/arduinoPlugin/packages/ATTinyCore/hardware/avr/1.1.2/cores/tiny/WMath.cpp
	@echo 'Building file: $<'
	@echo 'Starting C++ compile'
	"/home/tux/Programme/sloeber//arduinoPlugin/packages/arduino/tools/avr-gcc/4.9.2-atmel3.5.4-arduino2/bin/avr-g++" -c -g -Os -Wall -Wextra -std=gnu++11 -fpermissive -fno-exceptions -ffunction-sections -fdata-sections -fno-threadsafe-statics -flto -mmcu=attiny2313 -DF_CPU=8000000L -DARDUINO=10802 -DARDUINO_AVR_ATTINYX313 -DARDUINO_ARCH_AVR   -I"/home/tux/Programme/sloeber/arduinoPlugin/packages/ATTinyCore/hardware/avr/1.1.2/cores/tiny" -I"/home/tux/Programme/sloeber/arduinoPlugin/packages/ATTinyCore/hardware/avr/1.1.2/variants/tinyX313" -I"/home/tux/Programme/sloeber/arduinoPlugin/libraries/Stepper/1.1.2" -I"/home/tux/Programme/sloeber/arduinoPlugin/libraries/Stepper/1.1.2/src" -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" -D__IN_ECLIPSE__=1 -x c++ "$<"  -o  "$@"
	@echo 'Finished building: $<'
	@echo ' '

core/WString.cpp.o: /home/tux/Programme/sloeber/arduinoPlugin/packages/ATTinyCore/hardware/avr/1.1.2/cores/tiny/WString.cpp
	@echo 'Building file: $<'
	@echo 'Starting C++ compile'
	"/home/tux/Programme/sloeber//arduinoPlugin/packages/arduino/tools/avr-gcc/4.9.2-atmel3.5.4-arduino2/bin/avr-g++" -c -g -Os -Wall -Wextra -std=gnu++11 -fpermissive -fno-exceptions -ffunction-sections -fdata-sections -fno-threadsafe-statics -flto -mmcu=attiny2313 -DF_CPU=8000000L -DARDUINO=10802 -DARDUINO_AVR_ATTINYX313 -DARDUINO_ARCH_AVR   -I"/home/tux/Programme/sloeber/arduinoPlugin/packages/ATTinyCore/hardware/avr/1.1.2/cores/tiny" -I"/home/tux/Programme/sloeber/arduinoPlugin/packages/ATTinyCore/hardware/avr/1.1.2/variants/tinyX313" -I"/home/tux/Programme/sloeber/arduinoPlugin/libraries/Stepper/1.1.2" -I"/home/tux/Programme/sloeber/arduinoPlugin/libraries/Stepper/1.1.2/src" -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" -D__IN_ECLIPSE__=1 -x c++ "$<"  -o  "$@"
	@echo 'Finished building: $<'
	@echo ' '

core/main.cpp.o: /home/tux/Programme/sloeber/arduinoPlugin/packages/ATTinyCore/hardware/avr/1.1.2/cores/tiny/main.cpp
	@echo 'Building file: $<'
	@echo 'Starting C++ compile'
	"/home/tux/Programme/sloeber//arduinoPlugin/packages/arduino/tools/avr-gcc/4.9.2-atmel3.5.4-arduino2/bin/avr-g++" -c -g -Os -Wall -Wextra -std=gnu++11 -fpermissive -fno-exceptions -ffunction-sections -fdata-sections -fno-threadsafe-statics -flto -mmcu=attiny2313 -DF_CPU=8000000L -DARDUINO=10802 -DARDUINO_AVR_ATTINYX313 -DARDUINO_ARCH_AVR   -I"/home/tux/Programme/sloeber/arduinoPlugin/packages/ATTinyCore/hardware/avr/1.1.2/cores/tiny" -I"/home/tux/Programme/sloeber/arduinoPlugin/packages/ATTinyCore/hardware/avr/1.1.2/variants/tinyX313" -I"/home/tux/Programme/sloeber/arduinoPlugin/libraries/Stepper/1.1.2" -I"/home/tux/Programme/sloeber/arduinoPlugin/libraries/Stepper/1.1.2/src" -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" -D__IN_ECLIPSE__=1 -x c++ "$<"  -o  "$@"
	@echo 'Finished building: $<'
	@echo ' '

core/wiring.c.o: /home/tux/Programme/sloeber/arduinoPlugin/packages/ATTinyCore/hardware/avr/1.1.2/cores/tiny/wiring.c
	@echo 'Building file: $<'
	@echo 'Starting C compile'
	"/home/tux/Programme/sloeber//arduinoPlugin/packages/arduino/tools/avr-gcc/4.9.2-atmel3.5.4-arduino2/bin/avr-gcc" -c -g -Os -Wall -Wextra -std=gnu11 -ffunction-sections -fdata-sections -flto -fno-fat-lto-objects -mmcu=attiny2313 -DF_CPU=8000000L -DARDUINO=10802 -DARDUINO_AVR_ATTINYX313 -DARDUINO_ARCH_AVR   -I"/home/tux/Programme/sloeber/arduinoPlugin/packages/ATTinyCore/hardware/avr/1.1.2/cores/tiny" -I"/home/tux/Programme/sloeber/arduinoPlugin/packages/ATTinyCore/hardware/avr/1.1.2/variants/tinyX313" -I"/home/tux/Programme/sloeber/arduinoPlugin/libraries/Stepper/1.1.2" -I"/home/tux/Programme/sloeber/arduinoPlugin/libraries/Stepper/1.1.2/src" -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" -D__IN_ECLIPSE__=1 "$<"  -o  "$@"
	@echo 'Finished building: $<'
	@echo ' '

core/wiring_analog.c.o: /home/tux/Programme/sloeber/arduinoPlugin/packages/ATTinyCore/hardware/avr/1.1.2/cores/tiny/wiring_analog.c
	@echo 'Building file: $<'
	@echo 'Starting C compile'
	"/home/tux/Programme/sloeber//arduinoPlugin/packages/arduino/tools/avr-gcc/4.9.2-atmel3.5.4-arduino2/bin/avr-gcc" -c -g -Os -Wall -Wextra -std=gnu11 -ffunction-sections -fdata-sections -flto -fno-fat-lto-objects -mmcu=attiny2313 -DF_CPU=8000000L -DARDUINO=10802 -DARDUINO_AVR_ATTINYX313 -DARDUINO_ARCH_AVR   -I"/home/tux/Programme/sloeber/arduinoPlugin/packages/ATTinyCore/hardware/avr/1.1.2/cores/tiny" -I"/home/tux/Programme/sloeber/arduinoPlugin/packages/ATTinyCore/hardware/avr/1.1.2/variants/tinyX313" -I"/home/tux/Programme/sloeber/arduinoPlugin/libraries/Stepper/1.1.2" -I"/home/tux/Programme/sloeber/arduinoPlugin/libraries/Stepper/1.1.2/src" -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" -D__IN_ECLIPSE__=1 "$<"  -o  "$@"
	@echo 'Finished building: $<'
	@echo ' '

core/wiring_digital.c.o: /home/tux/Programme/sloeber/arduinoPlugin/packages/ATTinyCore/hardware/avr/1.1.2/cores/tiny/wiring_digital.c
	@echo 'Building file: $<'
	@echo 'Starting C compile'
	"/home/tux/Programme/sloeber//arduinoPlugin/packages/arduino/tools/avr-gcc/4.9.2-atmel3.5.4-arduino2/bin/avr-gcc" -c -g -Os -Wall -Wextra -std=gnu11 -ffunction-sections -fdata-sections -flto -fno-fat-lto-objects -mmcu=attiny2313 -DF_CPU=8000000L -DARDUINO=10802 -DARDUINO_AVR_ATTINYX313 -DARDUINO_ARCH_AVR   -I"/home/tux/Programme/sloeber/arduinoPlugin/packages/ATTinyCore/hardware/avr/1.1.2/cores/tiny" -I"/home/tux/Programme/sloeber/arduinoPlugin/packages/ATTinyCore/hardware/avr/1.1.2/variants/tinyX313" -I"/home/tux/Programme/sloeber/arduinoPlugin/libraries/Stepper/1.1.2" -I"/home/tux/Programme/sloeber/arduinoPlugin/libraries/Stepper/1.1.2/src" -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" -D__IN_ECLIPSE__=1 "$<"  -o  "$@"
	@echo 'Finished building: $<'
	@echo ' '

core/wiring_pulse.c.o: /home/tux/Programme/sloeber/arduinoPlugin/packages/ATTinyCore/hardware/avr/1.1.2/cores/tiny/wiring_pulse.c
	@echo 'Building file: $<'
	@echo 'Starting C compile'
	"/home/tux/Programme/sloeber//arduinoPlugin/packages/arduino/tools/avr-gcc/4.9.2-atmel3.5.4-arduino2/bin/avr-gcc" -c -g -Os -Wall -Wextra -std=gnu11 -ffunction-sections -fdata-sections -flto -fno-fat-lto-objects -mmcu=attiny2313 -DF_CPU=8000000L -DARDUINO=10802 -DARDUINO_AVR_ATTINYX313 -DARDUINO_ARCH_AVR   -I"/home/tux/Programme/sloeber/arduinoPlugin/packages/ATTinyCore/hardware/avr/1.1.2/cores/tiny" -I"/home/tux/Programme/sloeber/arduinoPlugin/packages/ATTinyCore/hardware/avr/1.1.2/variants/tinyX313" -I"/home/tux/Programme/sloeber/arduinoPlugin/libraries/Stepper/1.1.2" -I"/home/tux/Programme/sloeber/arduinoPlugin/libraries/Stepper/1.1.2/src" -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" -D__IN_ECLIPSE__=1 "$<"  -o  "$@"
	@echo 'Finished building: $<'
	@echo ' '

core/wiring_shift.c.o: /home/tux/Programme/sloeber/arduinoPlugin/packages/ATTinyCore/hardware/avr/1.1.2/cores/tiny/wiring_shift.c
	@echo 'Building file: $<'
	@echo 'Starting C compile'
	"/home/tux/Programme/sloeber//arduinoPlugin/packages/arduino/tools/avr-gcc/4.9.2-atmel3.5.4-arduino2/bin/avr-gcc" -c -g -Os -Wall -Wextra -std=gnu11 -ffunction-sections -fdata-sections -flto -fno-fat-lto-objects -mmcu=attiny2313 -DF_CPU=8000000L -DARDUINO=10802 -DARDUINO_AVR_ATTINYX313 -DARDUINO_ARCH_AVR   -I"/home/tux/Programme/sloeber/arduinoPlugin/packages/ATTinyCore/hardware/avr/1.1.2/cores/tiny" -I"/home/tux/Programme/sloeber/arduinoPlugin/packages/ATTinyCore/hardware/avr/1.1.2/variants/tinyX313" -I"/home/tux/Programme/sloeber/arduinoPlugin/libraries/Stepper/1.1.2" -I"/home/tux/Programme/sloeber/arduinoPlugin/libraries/Stepper/1.1.2/src" -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" -D__IN_ECLIPSE__=1 "$<"  -o  "$@"
	@echo 'Finished building: $<'
	@echo ' '


