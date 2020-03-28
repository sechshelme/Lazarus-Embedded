#!/bin/bash
cp /home/tux/fpc.src/fpc/compiler/avr/cpuinfo.pas ./src_mod/avr_cpuinfo.pas
sed s/"Unit CPUInfo;"/"Unit AVR_CPUInfo;"/g ./src_mod/avr_cpuinfo.pas -i

cp /home/tux/fpc.src/fpc/compiler/arm/cpuinfo.pas ./src_mod/arm_cpuinfo.pas
sed s/"Unit CPUInfo;"/"Unit ARM_CPUInfo;"/g ./src_mod/arm_cpuinfo.pas -i


cp /home/tux/fpc.src/fpc/compiler/globtype.pas ./src_mod/globtype.pas
sed 26a"\ " ./src_mod/globtype.pas -i
sed 26a"  PUint = word;" ./src_mod/globtype.pas -i
sed 26a"  PInt = Smallint;" ./src_mod/globtype.pas -i
sed 26a"  AWord = Word;" ./src_mod/globtype.pas -i
sed 26a"  AInt = Smallint;" ./src_mod/globtype.pas -i
sed 26a"type" ./src_mod/globtype.pas -i

cp /home/tux/fpc.src/fpc/compiler/fpcdefs.inc ./src_mod/fpcdefs.inc

