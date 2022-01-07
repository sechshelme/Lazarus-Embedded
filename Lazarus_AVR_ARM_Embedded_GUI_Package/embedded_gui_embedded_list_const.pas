
// Diese Unit wird automatisch durch das Tool "./Tool/Embedded_List_to_const" erzeugt.
// Die Arrays werden aus "./fpc.src/fpc/compiler/avr/cpuinfo.pas" und
// "./fpc.src/fpc/compiler/arm/cpuinfo.pas" importiert.

unit Embedded_GUI_Embedded_List_Const;

interface

const
  i8086_SubArch_List = 
    '8086,80186,80286,80386,80486,PENTIUM,PENTIUM2,PENTIUM3,PENTIUM4,PENTIUMM';

  i8086_List: array of string = (

    // 8086
    '',

    // 80186
    '',

    // 80286
    '',

    // 80386
    '',

    // 80486
    '',

    // PENTIUM
    '',

    // PENTIUM2
    '',

    // PENTIUM3
    '',

    // PENTIUM4
    '',

    // PENTIUMM
    '');

const
  aarch64_SubArch_List = 
    'ARMV8,ARMV8-A,ARMV8.1-A,ARMV8.2-A,ARMV8.3-A,ARMV8.4-A,ARMV8.5-A,ARMV8.6-A';

// Warnung wurde (noch) nicht unterstützt !!!!!!
// cpuinfp.pas von aarch64 ist anders aufgebaut, daher kann Embedded_GUI_Embedded_List_Const.pas nicht gebaut werden !!!!!!

const
  powerpc64_SubArch_List = 
    '970';

  powerpc64_List: array of string = (

    // 970
    '');

const
  avr_SubArch_List = 
    'AVRTINY,AVR1,AVR2,AVR25,AVR3,AVR31,AVR35,AVR4,AVR5,AVR51,AVR6,AVRXMEGA3';

  avr_List: array of string = (

    // AVRTINY
    'ATTINY4,ATTINY5,ATTINY9,ATTINY10,' +
    'ATTINY20,ATTINY40,ATTINY102,ATTINY104',

    // AVR1
    'ATTINY11,ATTINY12,ATTINY15,ATTINY28',

    // AVR2
    'ATTINY26',

    // AVR25
    'ATTINY13,ATTINY13A,ATTINY24,ATTINY24A,' +
    'ATTINY25,ATTINY43U,ATTINY44,ATTINY44A,' +
    'ATTINY45,ATTINY48,ATTINY84,ATTINY84A,' +
    'ATTINY85,ATTINY87,ATTINY88,ATTINY261,' +
    'ATTINY261A,ATTINY441,ATTINY461,ATTINY461A,' +
    'ATTINY828,ATTINY841,ATTINY861,ATTINY861A,' +
    'ATTINY2313,ATTINY2313A,ATTINY4313',

    // AVR3
    '',

    // AVR31
    '',

    // AVR35
    'AT90USB82,AT90USB162,ATMEGA8U2,ATMEGA16U2,' +
    'ATMEGA32U2,ATTINY167,ATTINY1634',

    // AVR4
    'AT90PWM1,AT90PWM2B,AT90PWM3B,AT90PWM81,' +
    'ATA6285,ATA6286,ATMEGA8,ATMEGA8A,' +
    'ATMEGA8HVA,ATMEGA48,ATMEGA48A,ATMEGA48P,' +
    'ATMEGA48PA,ATMEGA48PB,ATMEGA88,ATMEGA88A,' +
    'ATMEGA88P,ATMEGA88PA,ATMEGA88PB,ATMEGA8515,' +
    'ATMEGA8535',

    // AVR5
    'AVRSIM,AT90CAN32,AT90CAN64,AT90PWM161,' +
    'AT90PWM216,AT90PWM316,AT90USB646,AT90USB647,' +
    'ATMEGA16,ATMEGA16A,ATMEGA16HVA,ATMEGA16HVB,' +
    'ATMEGA16HVBREVB,ATMEGA16M1,ATMEGA16U4,ATMEGA32,' +
    'ATMEGA32A,ATMEGA32C1,ATMEGA32HVB,ATMEGA32HVBREVB,' +
    'ATMEGA32M1,ATMEGA32U4,ATMEGA64,ATMEGA64A,' +
    'ATMEGA64C1,ATMEGA64HVE2,ATMEGA64M1,ATMEGA64RFR2,' +
    'ATMEGA162,ATMEGA164A,ATMEGA164P,ATMEGA164PA,' +
    'ATMEGA165A,ATMEGA165P,ATMEGA165PA,ATMEGA168,' +
    'ATMEGA168A,ATMEGA168P,ATMEGA168PA,ATMEGA168PB,' +
    'ATMEGA169A,ATMEGA169P,ATMEGA169PA,ATMEGA324A,' +
    'ATMEGA324P,ATMEGA324PA,ATMEGA324PB,ATMEGA325,' +
    'ATMEGA325A,ATMEGA325P,ATMEGA325PA,ATMEGA328,' +
    'ATMEGA328P,ATMEGA328PB,ATMEGA329,ATMEGA329A,' +
    'ATMEGA329P,ATMEGA329PA,ATMEGA406,ATMEGA640,' +
    'ATMEGA644,ATMEGA644A,ATMEGA644P,ATMEGA644PA,' +
    'ATMEGA644RFR2,ATMEGA645,ATMEGA645A,ATMEGA645P,' +
    'ATMEGA649,ATMEGA649A,ATMEGA649P,ATMEGA3250,' +
    'ATMEGA3250A,ATMEGA3250P,ATMEGA3250PA,ATMEGA3290,' +
    'ATMEGA3290A,ATMEGA3290P,ATMEGA3290PA,ATMEGA6450,' +
    'ATMEGA6450A,ATMEGA6450P,ATMEGA6490,ATMEGA6490A,' +
    'ATMEGA6490P,ARDUINOLEONARDO,ARDUINOMICRO,ARDUINONANO,' +
    'ARDUINOUNO,ATMEGA324PBXPRO',

    // AVR51
    'AT90CAN128,AT90USB1286,AT90USB1287,ATMEGA128,' +
    'ATMEGA128A,ATMEGA128RFA1,ATMEGA128RFR2,ATMEGA1280,' +
    'ATMEGA1281,ATMEGA1284,ATMEGA1284P,ATMEGA1284RFR2,' +
    'ATMEGA1284PXPLAINED',

    // AVR6
    'ATMEGA256RFR2,ATMEGA2560,ATMEGA2561,ATMEGA2564RFR2,' +
    'ARDUINOMEGA,ATMEGA256RFR2XPRO',

    // AVRXMEGA3
    'ATMEGA808,ATMEGA809,ATMEGA1608,ATMEGA1609,' +
    'ATMEGA3208,ATMEGA3209,ATMEGA4808,ATMEGA4809,' +
    'ATTINY202,ATTINY204,ATTINY212,ATTINY214,' +
    'ATTINY402,ATTINY404,ATTINY406,ATTINY412,' +
    'ATTINY414,ATTINY416,ATTINY416AUTO,ATTINY417,' +
    'ATTINY804,ATTINY806,ATTINY807,ATTINY814,' +
    'ATTINY816,ATTINY817,ATTINY1604,ATTINY1606,' +
    'ATTINY1607,ATTINY1614,ATTINY1616,ATTINY1617,' +
    'ATTINY1624,ATTINY1626,ATTINY1627,ATTINY3214,' +
    'ATTINY3216,ATTINY3217,ARDUINONANOEVERY,ATMEGA4809XPRO,' +
    'ATTINY817XPRO,ATTINY3217XPRO');

const
  x86_64_SubArch_List = 
    'ATHLON64,COREI,COREAVX,COREAVX2';

  x86_64_List: array of string = (

    // ATHLON64
    '',

    // COREI
    '',

    // COREAVX
    '',

    // COREAVX2
    '');

const
  riscv64_SubArch_List = 
    'RV64IMAC,RV64IMA,RV64IM,RV64I';

  riscv64_List: array of string = (

    // RV64IMAC
    '',

    // RV64IMA
    '',

    // RV64IM
    '',

    // RV64I
    '');

const
  powerpc_SubArch_List = 
    '604,750,7400,970';

  powerpc_List: array of string = (

    // 604
    '',

    // 750
    '',

    // 7400
    '',

    // 970
    '');

const
  arm_SubArch_List = 
    'ARMV2,ARMV3,ARMV4,ARMV4T,ARMV5T,ARMV5TE,ARMV5TEJ,ARMV6,ARMV6K,ARMV6T2,ARMV6Z,ARMV6M,ARMV7,ARMV7A,ARMV7R,ARMV7M,ARMV7EM';

  arm_List: array of string = (

    // ARMV2
    '',

    // ARMV3
    '',

    // ARMV4
    '',

    // ARMV4T
    'LPC2114,LPC2124,LPC2194,AT91SAM7S256,' +
    'AT91SAM7SE256,AT91SAM7X256,AT91SAM7XC256,SC32442B',

    // ARMV5T
    '',

    // ARMV5TE
    '',

    // ARMV5TEJ
    '',

    // ARMV6
    '',

    // ARMV6K
    '',

    // ARMV6T2
    '',

    // ARMV6Z
    '',

    // ARMV6M
    'LPC810M021FN8,LPC811M001FDH16,LPC812M101FDH16,LPC812M101FD20,' +
    'LPC812M101FDH20,LPC1110FD20,LPC1111FDH20_002,LPC1111FHN33_101,' +
    'LPC1111FHN33_102,LPC1111FHN33_103,LPC1111FHN33_201,LPC1111FHN33_202,' +
    'LPC1111FHN33_203,LPC1112FD20_102,LPC1112FDH20_102,LPC1112FDH28_102,' +
    'LPC1112FHN33_101,LPC1112FHN33_102,LPC1112FHN33_103,LPC1112FHN33_201,' +
    'LPC1112FHN24_202,LPC1112FHN33_202,LPC1112FHN33_203,LPC1112FHI33_202,' +
    'LPC1112FHI33_203,LPC1113FHN33_201,LPC1113FHN33_202,LPC1113FHN33_203,' +
    'LPC1113FHN33_301,LPC1113FHN33_302,LPC1113FHN33_303,LPC1113FBD48_301,' +
    'LPC1113FBD48_302,LPC1113FBD48_303,LPC1114FDH28_102,LPC1114FN28_102,' +
    'LPC1114FHN33_201,LPC1114FHN33_202,LPC1114FHN33_203,LPC1114FHN33_301,' +
    'LPC1114FHN33_302,LPC1114FHN33_303,LPC1114FHN33_333,LPC1114FHI33_302,' +
    'LPC1114FHI33_303,LPC1114FBD48_301,LPC1114FBD48_302,LPC1114FBD48_303,' +
    'LPC1114FBD48_323,LPC1114FBD48_333,LPC1115FBD48_303,LPC11C12FBD48_301,' +
    'LPC11C14FBD48_301,LPC11C22FBD48_301,LPC11C24FBD48_301,LPC11D14FBD100_302,' +
    'LPC1224FBD48_101,LPC1224FBD48_121,LPC1224FBD64_101,LPC1224FBD64_121,' +
    'LPC1225FBD48_301,LPC1225FBD48_321,LPC1225FBD64_301,LPC1225FBD64_321,' +
    'LPC1226FBD48_301,LPC1226FBD64_301,LPC1227FBD48_301,LPC1227FBD64_301,' +
    'LPC12D27FBD100_301,STM32F030C6,STM32F030C8,STM32F030F4,' +
    'STM32F030K6,STM32F030R8,STM32F050C4,STM32F050C6,' +
    'STM32F050F4,STM32F050F6,STM32F050G4,STM32F050G6,' +
    'STM32F050K4,STM32F050K6,STM32F051C4,STM32F051C6,' +
    'STM32F051C8,STM32F051K4,STM32F051K6,STM32F051K8,' +
    'STM32F051R4,STM32F051R6,STM32F051R8,STM32F091CC,' +
    'STM32F091CB,STM32F091RC,STM32F091RB,STM32F091VC,' +
    'STM32F091VB,STM32G071RB,NUCLEOG071RB,NRF51422_XXAA,' +
    'NRF51422_XXAB,NRF51422_XXAC,NRF51822_XXAA,NRF51822_XXAB,' +
    'NRF51822_XXAC',

    // ARMV7
    '',

    // ARMV7A
    'ALLWINNER_A20,RASPI2',

    // ARMV7R
    '',

    // ARMV7M
    'LPC1311FHN33,LPC1311FHN33_01,LPC1313FHN33,LPC1313FHN33_01,' +
    'LPC1313FBD48,LPC1313FBD48_01,LPC1315FHN33,LPC1315FBD48,' +
    'LPC1316FHN33,LPC1316FBD48,LPC1317FHN33,LPC1317FBD48,' +
    'LPC1317FBD64,LPC1342FHN33,LPC1342FBD48,LPC1343FHN33,' +
    'LPC1343FBD48,LPC1345FHN33,LPC1345FBD48,LPC1346FHN33,' +
    'LPC1346FBD48,LPC1347FHN33,LPC1347FBD48,LPC1347FBD64,' +
    'LPC1754,LPC1756,LPC1758,LPC1764,' +
    'LPC1766,LPC1768,STM32F100X4,STM32F100X6,' +
    'STM32F100X8,STM32F100XB,STM32F100XC,STM32F100XD,' +
    'STM32F100XE,STM32F101X4,STM32F101X6,STM32F101X8,' +
    'STM32F101XB,STM32F101XC,STM32F101XD,STM32F101XE,' +
    'STM32F101XF,STM32F101XG,STM32F102X4,STM32F102X6,' +
    'STM32F102X8,STM32F102XB,STM32F103X4,STM32F103X6,' +
    'STM32F103X8,STM32F103XB,STM32F103XC,STM32F103XD,' +
    'STM32F103XE,STM32F103XF,STM32F103XG,STM32F107X8,' +
    'STM32F107XB,STM32F107XC,STM32F105R8,STM32F105RB,' +
    'STM32F105RC,STM32F105V8,STM32F105VB,STM32F105VC,' +
    'STM32F107RB,STM32F107RC,STM32F107VB,STM32F107VC,' +
    'LM3S1110,LM3S1133,LM3S1138,LM3S1150,' +
    'LM3S1162,LM3S1165,LM3S1166,LM3S2110,' +
    'LM3S2139,LM3S6100,LM3S6110,LM3S1601,' +
    'LM3S1608,LM3S1620,LM3S1635,LM3S1636,' +
    'LM3S1637,LM3S1651,LM3S2601,LM3S2608,' +
    'LM3S2620,LM3S2637,LM3S2651,LM3S6610,' +
    'LM3S6611,LM3S6618,LM3S6633,LM3S6637,' +
    'LM3S8630,LM3S1911,LM3S1918,LM3S1937,' +
    'LM3S1958,LM3S1960,LM3S1968,LM3S1969,' +
    'LM3S2911,LM3S2918,LM3S2919,LM3S2939,' +
    'LM3S2948,LM3S2950,LM3S2965,LM3S6911,' +
    'LM3S6918,LM3S6938,LM3S6950,LM3S6952,' +
    'LM3S6965,LM3S8930,LM3S8933,LM3S8938,' +
    'LM3S8962,LM3S8970,LM3S8971,LM3S5951,' +
    'LM3S5956,LM3S1B21,LM3S2B93,LM3S5B91,' +
    'LM3S9B81,LM3S9B90,LM3S9B92,LM3S9B95,' +
    'LM3S9B96,LM3S5D51,ATSAM3X8E,ARDUINO_DUE,' +
    'FLIP_N_CLICK,THUMB2_BARE',

    // ARMV7EM
    'STM32F401CB,STM32F401RB,STM32F401VB,STM32F401CC,' +
    'STM32F401RC,STM32F401VC,DISCOVERYF401VC,STM32F401CD,' +
    'STM32F401RD,STM32F401VD,STM32F401CE,STM32F401RE,' +
    'NUCLEOF401RE,STM32F401VE,STM32F407VG,DISCOVERYF407VG,' +
    'STM32F407IG,STM32F407ZG,STM32F407VE,STM32F407ZE,' +
    'STM32F407IE,STM32F411CC,STM32F411RC,STM32F411VC,' +
    'STM32F411CE,STM32F411RE,NUCLEOF411RE,STM32F411VE,' +
    'DISCOVERYF411VE,STM32F429VG,STM32F429ZG,STM32F429IG,' +
    'STM32F429VI,STM32F429ZI,DISCOVERYF429ZI,STM32F429II,' +
    'STM32F429VE,STM32F429ZE,STM32F429IE,STM32F429BG,' +
    'STM32F429BI,STM32F429BE,STM32F429NG,STM32F429NI,' +
    'STM32F429NE,STM32F446MC,STM32F446RC,STM32F446VC,' +
    'STM32F446ZC,STM32F446ME,STM32F446RE,NUCLEOF446RE,' +
    'STM32F446VE,STM32F446ZE,STM32F745XE,STM32F745XG,' +
    'STM32F746XE,STM32F746XG,STM32F756XE,STM32F756XG,' +
    'LM4F120H5,XMC4500X1024,XMC4500X768,XMC4502X768,' +
    'XMC4504X512,MK20DX128VFM5,MK20DX128VFT5,MK20DX128VLF5,' +
    'MK20DX128VLH5,TEENSY30,MK20DX128VMP5,MK20DX32VFM5,' +
    'MK20DX32VFT5,MK20DX32VLF5,MK20DX32VLH5,MK20DX32VMP5,' +
    'MK20DX64VFM5,MK20DX64VFT5,MK20DX64VLF5,MK20DX64VLH5,' +
    'MK20DX64VMP5,MK20DX128VLH7,MK20DX128VLK7,MK20DX128VLL7,' +
    'MK20DX128VMC7,MK20DX256VLH7,MK20DX256VLK7,MK20DX256VLL7,' +
    'MK20DX256VMC7,TEENSY31,TEENSY32,MK20DX64VLH7,' +
    'MK20DX64VLK7,MK20DX64VMC7,MK22FN512CAP12,MK22FN512CBP12,' +
    'MK22FN512VDC12,MK22FN512VLH12,MK22FN512VLL12,MK22FN512VMP12,' +
    'FREEDOM_K22F,MK64FN1M0VDC12,MK64FN1M0VLL12,FREEDOM_K64F,' +
    'MK64FN1M0VLQ12,MK64FN1M0VMD12,MK64FX512VDC12,MK64FX512VLL12,' +
    'MK64FX512VLQ12,MK64FX512VMD12,SAMD51P19A,WIO_TERMINAL,' +
    'NRF52832_XXAA,NRF52840_XXAA');

const
  z80_SubArch_List = 
    'Z80,EZ80';

  z80_List: array of string = (

    // Z80
    '',

    // EZ80
    '');

const
  wasm32_SubArch_List = 
    'WASM32';

  wasm32_List: array of string = (

    // WASM32
    '');

const
  xtensa_SubArch_List = 
    'LX106,LX6';

  xtensa_List: array of string = (

    // LX106
    'ESP8266',

    // LX6
    'ESP32,ESP32_D0WD,ESP32_D2WD,ESP32_S0WD');

const
  riscv32_SubArch_List = 
    'RV32IMAC,RV32IMA,RV32IM,RV32I';

  riscv32_List: array of string = (

    // RV32IMAC
    'FE310G000,FE310G002,HIFIVE1,HIFIVE1REVB,' +
    'REDFIVE,REDFIVETHING,GD32VF103C4,GD32VF103C6,' +
    'GD32VF103C8,GD32VF103CB,GD32VF103R4,GD32VF103R6,' +
    'GD32VF103R8,GD32VF103RB,GD32VF103T4,GD32VF103T6,' +
    'GD32VF103T8,GD32VF103TB,GD32VF103V8,GD32VF103VB',

    // RV32IMA
    '',

    // RV32IM
    '',

    // RV32I
    '');

const
  jvm_SubArch_List = 
    'JVM,JVMDALVIK';

  jvm_List: array of string = (

    // JVM
    '',

    // JVMDALVIK
    '');

const
  sparc_SubArch_List = 
    'SPARCV7,SPARCV8,SPARCV9';

  sparc_List: array of string = (

    // SPARCV7
    '',

    // SPARCV8
    '',

    // SPARCV9
    '');

const
  m68k_SubArch_List = 
    '68000,68020,68040,68060,ISAA,ISAA+,ISAB,ISAC,CFV4E';

  m68k_List: array of string = (

    // 68000
    '',

    // 68020
    '',

    // 68040
    '',

    // 68060
    '',

    // ISAA
    '',

    // ISAA+
    '',

    // ISAB
    '',

    // ISAC
    '',

    // CFV4E
    '');

const
  mips_SubArch_List = 
    'MIPS1,MIPS2,MIPS3,MIPS4,MIPS5,MIPS32,MIPS32R2,PIC32MX';

  mips_List: array of string = (

    // MIPS1
    '',

    // MIPS2
    '',

    // MIPS3
    '',

    // MIPS4
    '',

    // MIPS5
    '',

    // MIPS32
    '',

    // MIPS32R2
    '',

    // PIC32MX
    'PIC32MX110F016B,PIC32MX110F016C,PIC32MX110F016D,PIC32MX120F032B,' +
    'PIC32MX120F032C,PIC32MX120F032D,PIC32MX130F064B,PIC32MX130F064C,' +
    'PIC32MX130F064D,PIC32MX150F128B,PIC32MX150F128C,PIC32MX150F128D,' +
    'PIC32MX210F016B,PIC32MX210F016C,PIC32MX210F016D,PIC32MX220F032B,' +
    'PIC32MX220F032C,PIC32MX220F032D,PIC32MX230F064B,PIC32MX230F064C,' +
    'PIC32MX230F064D,PIC32MX250F128B,PIC32MX250F128C,PIC32MX250F128D,' +
    'PIC32MX775F256H,PIC32MX775F256L,PIC32MX775F512H,PIC32MX775F512L,' +
    'PIC32MX795F512H,PIC32MX795F512L');

const
  i386_SubArch_List = 
    '80386,80486,PENTIUM,PENTIUM2,PENTIUM3,PENTIUM4,PENTIUMM,COREI,COREAVX,COREAVX2';

  i386_List: array of string = (

    // 80386
    '',

    // 80486
    '',

    // PENTIUM
    '',

    // PENTIUM2
    '',

    // PENTIUM3
    '',

    // PENTIUM4
    '',

    // PENTIUMM
    '',

    // COREI
    '',

    // COREAVX
    '',

    // COREAVX2
    '');

const
  sparc64_SubArch_List = 
    'SPARCV9';

  sparc64_List: array of string = (

    // SPARCV9
    '');


type
  Ti8086_ControllerDataList = array of array of String;

const
  i8086_ControllerDataList : Ti8086_ControllerDataList = (
    ('controllertypestr', 'controllerunitstr', 'cputype', 'fputype', 'flashbase', 'flashsize', 'srambase', 'sramsize', 'eeprombase', 'eepromsize', 'bootbase', 'bootsize'));

type
  Taarch64_ControllerDataList = array of array of String;

const
  aarch64_ControllerDataList : Taarch64_ControllerDataList = (
    ('controllertypestr', 'controllerunitstr', 'cputype', 'fputype', 'flashbase', 'flashsize', 'srambase', 'sramsize', 'eeprombase', 'eepromsize', 'bootbase', 'bootsize'),
    ('RASPI3', 'RASPI3', 'armv8a', 'vfp', '$00000000', '$00000000', '$00008000', '$10000000'),
    ('RASPI4', 'RASPI4', 'armv8a', 'vfp', '$00000000', '$00000000', '$00008000', '$10000000'));

type
  Tpowerpc64_ControllerDataList = array of array of String;

const
  powerpc64_ControllerDataList : Tpowerpc64_ControllerDataList = (
    ('controllertypestr', 'controllerunitstr', 'cputype', 'fputype', 'flashbase', 'flashsize', 'srambase', 'sramsize', 'eeprombase', 'eepromsize', 'bootbase', 'bootsize'));

type
  Tavr_ControllerDataList = array of array of String;

const
  avr_ControllerDataList : Tavr_ControllerDataList = (
    ('controllertypestr', 'controllerunitstr', 'cputype', 'fputype', 'flashbase', 'flashsize', 'srambase', 'sramsize', 'eeprombase', 'eepromsize', 'bootbase', 'bootsize'),
    ('AVRSIM', 'AVRSIM', 'avr5', 'soft', '0', '$20000', '256', '32', '0', '4096'),
    ('AT90CAN32', 'AT90CAN32', 'avr5', 'soft', '0', '32768', '256', '2048', '0', '1024'),
    ('AT90CAN64', 'AT90CAN64', 'avr5', 'soft', '0', '65536', '256', '4096', '0', '2048'),
    ('AT90CAN128', 'AT90CAN128', 'avr51', 'soft', '0', '131072', '256', '4096', '0', '4096'),
    ('AT90PWM1', 'AT90PWM1', 'avr4', 'soft', '0', '8192', '256', '512', '0', '512'),
    ('AT90PWM2B', 'AT90PWM2B', 'avr4', 'soft', '0', '8192', '256', '512', '0', '512'),
    ('AT90PWM3B', 'AT90PWM3B', 'avr4', 'soft', '0', '8192', '256', '512', '0', '512'),
    ('AT90PWM81', 'AT90PWM81', 'avr4', 'soft', '0', '8192', '256', '256', '0', '512'),
    ('AT90PWM161', 'AT90PWM161', 'avr5', 'soft', '0', '16384', '256', '1024', '0', '512'),
    ('AT90PWM216', 'AT90PWM216', 'avr5', 'soft', '0', '16384', '256', '1024', '0', '512'),
    ('AT90PWM316', 'AT90PWM316', 'avr5', 'soft', '0', '16384', '256', '1024', '0', '512'),
    ('AT90USB82', 'AT90USB82', 'avr35', 'soft', '0', '8192', '256', '512', '0', '512'),
    ('AT90USB162', 'AT90USB162', 'avr35', 'soft', '0', '16384', '256', '512', '0', '512'),
    ('AT90USB646', 'AT90USB646', 'avr5', 'soft', '0', '65536', '256', '4096', '0', '2048'),
    ('AT90USB647', 'AT90USB647', 'avr5', 'soft', '0', '65536', '256', '4096', '0', '2048'),
    ('AT90USB1286', 'AT90USB1286', 'avr51', 'soft', '0', '131072', '256', '8192', '0', '4096'),
    ('AT90USB1287', 'AT90USB1287', 'avr51', 'soft', '0', '131072', '256', '8192', '0', '4096'),
    ('ATA6285', 'ATA6285', 'avr4', 'soft', '0', '8192', '256', '512', '0', '320'),
    ('ATA6286', 'ATA6286', 'avr4', 'soft', '0', '8192', '256', '512', '0', '320'),
    ('ATMEGA8', 'ATMEGA8', 'avr4', 'soft', '0', '8192', '96', '1024', '0', '512'),
    ('ATMEGA8A', 'ATMEGA8A', 'avr4', 'soft', '0', '8192', '96', '1024', '0', '512'),
    ('ATMEGA8HVA', 'ATMEGA8HVA', 'avr4', 'soft', '0', '8192', '256', '512', '0', '256'),
    ('ATMEGA8U2', 'ATMEGA8U2', 'avr35', 'soft', '0', '8192', '256', '512', '0', '512'),
    ('ATMEGA16', 'ATMEGA16', 'avr5', 'soft', '0', '16384', '96', '1024', '0', '512'),
    ('ATMEGA16A', 'ATMEGA16A', 'avr5', 'soft', '0', '16384', '96', '1024', '0', '512'),
    ('ATMEGA16HVA', 'ATMEGA16HVA', 'avr5', 'soft', '0', '16384', '256', '512', '0', '256'),
    ('ATMEGA16HVB', 'ATMEGA16HVB', 'avr5', 'soft', '0', '16384', '256', '1024', '0', '512'),
    ('ATMEGA16HVBREVB', 'ATMEGA16HVBREVB', 'avr5', 'soft', '0', '16384', '256', '1024', '0', '512'),
    ('ATMEGA16M1', 'ATMEGA16M1', 'avr5', 'soft', '0', '16384', '256', '1024', '0', '512'),
    ('ATMEGA16U2', 'ATMEGA16U2', 'avr35', 'soft', '0', '16384', '256', '512', '0', '512'),
    ('ATMEGA16U4', 'ATMEGA16U4', 'avr5', 'soft', '0', '16384', '256', '1280', '0', '512'),
    ('ATMEGA32', 'ATMEGA32', 'avr5', 'soft', '0', '32768', '96', '2048', '0', '1024'),
    ('ATMEGA32A', 'ATMEGA32A', 'avr5', 'soft', '0', '32768', '96', '2048', '0', '1024'),
    ('ATMEGA32C1', 'ATMEGA32C1', 'avr5', 'soft', '0', '32768', '256', '2048', '0', '1024'),
    ('ATMEGA32HVB', 'ATMEGA32HVB', 'avr5', 'soft', '0', '32768', '256', '2048', '0', '1024'),
    ('ATMEGA32HVBREVB', 'ATMEGA32HVBREVB', 'avr5', 'soft', '0', '32768', '256', '2048', '0', '1024'),
    ('ATMEGA32M1', 'ATMEGA32M1', 'avr5', 'soft', '0', '32768', '256', '2048', '0', '1024'),
    ('ATMEGA32U2', 'ATMEGA32U2', 'avr35', 'soft', '0', '32768', '256', '1024', '0', '1024'),
    ('ATMEGA32U4', 'ATMEGA32U4', 'avr5', 'soft', '0', '32768', '256', '2560', '0', '1024'),
    ('ATMEGA48', 'ATMEGA48', 'avr4', 'soft', '0', '4096', '256', '512', '0', '256'),
    ('ATMEGA48A', 'ATMEGA48A', 'avr4', 'soft', '0', '4096', '256', '512', '0', '256'),
    ('ATMEGA48P', 'ATMEGA48P', 'avr4', 'soft', '0', '4096', '256', '512', '0', '256'),
    ('ATMEGA48PA', 'ATMEGA48PA', 'avr4', 'soft', '0', '4096', '256', '512', '0', '256'),
    ('ATMEGA48PB', 'ATMEGA48PB', 'avr4', 'soft', '0', '4096', '256', '512', '0', '256'),
    ('ATMEGA64', 'ATMEGA64', 'avr5', 'soft', '0', '65536', '256', '4096', '0', '2048'),
    ('ATMEGA64A', 'ATMEGA64A', 'avr5', 'soft', '0', '65536', '256', '4096', '0', '2048'),
    ('ATMEGA64C1', 'ATMEGA64C1', 'avr5', 'soft', '0', '65536', '256', '4096', '0', '2048'),
    ('ATMEGA64HVE2', 'ATMEGA64HVE2', 'avr5', 'soft', '0', '65536', '256', '4096', '0', '1024'),
    ('ATMEGA64M1', 'ATMEGA64M1', 'avr5', 'soft', '0', '65536', '256', '4096', '0', '2048'),
    ('ATMEGA64RFR2', 'ATMEGA64RFR2', 'avr5', 'soft', '0', '65536', '512', '8192', '0', '2048'),
    ('ATMEGA88', 'ATMEGA88', 'avr4', 'soft', '0', '8192', '256', '1024', '0', '512'),
    ('ATMEGA88A', 'ATMEGA88A', 'avr4', 'soft', '0', '8192', '256', '1024', '0', '512'),
    ('ATMEGA88P', 'ATMEGA88P', 'avr4', 'soft', '0', '8192', '256', '1024', '0', '512'),
    ('ATMEGA88PA', 'ATMEGA88PA', 'avr4', 'soft', '0', '8192', '256', '1024', '0', '512'),
    ('ATMEGA88PB', 'ATMEGA88PB', 'avr4', 'soft', '0', '8192', '256', '1024', '0', '512'),
    ('ATMEGA128', 'ATMEGA128', 'avr51', 'soft', '0', '131072', '256', '4096', '0', '4096'),
    ('ATMEGA128A', 'ATMEGA128A', 'avr51', 'soft', '0', '131072', '256', '4096', '0', '4096'),
    ('ATMEGA128RFA1', 'ATMEGA128RFA1', 'avr51', 'soft', '0', '131072', '512', '16384', '0', '4096'),
    ('ATMEGA128RFR2', 'ATMEGA128RFR2', 'avr51', 'soft', '0', '131072', '512', '16384', '0', '4096'),
    ('ATMEGA162', 'ATMEGA162', 'avr5', 'soft', '0', '16384', '256', '1024', '0', '512'),
    ('ATMEGA164A', 'ATMEGA164A', 'avr5', 'soft', '0', '16384', '256', '1024', '0', '512'),
    ('ATMEGA164P', 'ATMEGA164P', 'avr5', 'soft', '0', '16384', '256', '1024', '0', '512'),
    ('ATMEGA164PA', 'ATMEGA164PA', 'avr5', 'soft', '0', '16384', '256', '1024', '0', '512'),
    ('ATMEGA165A', 'ATMEGA165A', 'avr5', 'soft', '0', '16384', '256', '1024', '0', '512'),
    ('ATMEGA165P', 'ATMEGA165P', 'avr5', 'soft', '0', '16384', '256', '1024', '0', '512'),
    ('ATMEGA165PA', 'ATMEGA165PA', 'avr5', 'soft', '0', '16384', '256', '1024', '0', '512'),
    ('ATMEGA168', 'ATMEGA168', 'avr5', 'soft', '0', '16384', '256', '1024', '0', '512'),
    ('ATMEGA168A', 'ATMEGA168A', 'avr5', 'soft', '0', '16384', '256', '1024', '0', '512'),
    ('ATMEGA168P', 'ATMEGA168P', 'avr5', 'soft', '0', '16384', '256', '1024', '0', '512'),
    ('ATMEGA168PA', 'ATMEGA168PA', 'avr5', 'soft', '0', '16384', '256', '1024', '0', '512'),
    ('ATMEGA168PB', 'ATMEGA168PB', 'avr5', 'soft', '0', '16384', '256', '1024', '0', '512'),
    ('ATMEGA169A', 'ATMEGA169A', 'avr5', 'soft', '0', '16384', '256', '1024', '0', '512'),
    ('ATMEGA169P', 'ATMEGA169P', 'avr5', 'soft', '0', '16384', '256', '1024', '0', '512'),
    ('ATMEGA169PA', 'ATMEGA169PA', 'avr5', 'soft', '0', '16384', '256', '1024', '0', '512'),
    ('ATMEGA256RFR2', 'ATMEGA256RFR2', 'avr6', 'soft', '0', '262144', '512', '32768', '0', '8192'),
    ('ATMEGA324A', 'ATMEGA324A', 'avr5', 'soft', '0', '32768', '256', '2048', '0', '1024'),
    ('ATMEGA324P', 'ATMEGA324P', 'avr5', 'soft', '0', '32768', '256', '2048', '0', '1024'),
    ('ATMEGA324PA', 'ATMEGA324PA', 'avr5', 'soft', '0', '32768', '256', '2048', '0', '1024'),
    ('ATMEGA324PB', 'ATMEGA324PB', 'avr5', 'soft', '0', '32768', '256', '2048', '0', '1024'),
    ('ATMEGA325', 'ATMEGA325', 'avr5', 'soft', '0', '32768', '256', '2048', '0', '1024'),
    ('ATMEGA325A', 'ATMEGA325A', 'avr5', 'soft', '0', '32768', '256', '2048', '0', '1024'),
    ('ATMEGA325P', 'ATMEGA325P', 'avr5', 'soft', '0', '32768', '256', '2048', '0', '1024'),
    ('ATMEGA325PA', 'ATMEGA325PA', 'avr5', 'soft', '0', '32768', '256', '2048', '0', '1024'),
    ('ATMEGA328', 'ATMEGA328', 'avr5', 'soft', '0', '32768', '256', '2048', '0', '1024'),
    ('ATMEGA328P', 'ATMEGA328P', 'avr5', 'soft', '0', '32768', '256', '2048', '0', '1024'),
    ('ATMEGA328PB', 'ATMEGA328PB', 'avr5', 'soft', '0', '32768', '256', '2048', '0', '1024'),
    ('ATMEGA329', 'ATMEGA329', 'avr5', 'soft', '0', '32768', '256', '2048', '0', '1024'),
    ('ATMEGA329A', 'ATMEGA329A', 'avr5', 'soft', '0', '32768', '256', '2048', '0', '1024'),
    ('ATMEGA329P', 'ATMEGA329P', 'avr5', 'soft', '0', '32768', '256', '2048', '0', '1024'),
    ('ATMEGA329PA', 'ATMEGA329PA', 'avr5', 'soft', '0', '32768', '256', '2048', '0', '1024'),
    ('ATMEGA406', 'ATMEGA406', 'avr5', 'soft', '0', '40960', '256', '2048', '0', '512'),
    ('ATMEGA640', 'ATMEGA640', 'avr5', 'soft', '0', '65536', '512', '8192', '0', '4096'),
    ('ATMEGA644', 'ATMEGA644', 'avr5', 'soft', '0', '65536', '256', '4096', '0', '2048'),
    ('ATMEGA644A', 'ATMEGA644A', 'avr5', 'soft', '0', '65536', '256', '4096', '0', '2048'),
    ('ATMEGA644P', 'ATMEGA644P', 'avr5', 'soft', '0', '65536', '256', '4096', '0', '2048'),
    ('ATMEGA644PA', 'ATMEGA644PA', 'avr5', 'soft', '0', '65536', '256', '4096', '0', '2048'),
    ('ATMEGA644RFR2', 'ATMEGA644RFR2', 'avr5', 'soft', '0', '65536', '512', '8192', '0', '2048'),
    ('ATMEGA645', 'ATMEGA645', 'avr5', 'soft', '0', '65536', '256', '4096', '0', '2048'),
    ('ATMEGA645A', 'ATMEGA645A', 'avr5', 'soft', '0', '65536', '256', '4096', '0', '2048'),
    ('ATMEGA645P', 'ATMEGA645P', 'avr5', 'soft', '0', '65536', '256', '4096', '0', '2048'),
    ('ATMEGA649', 'ATMEGA649', 'avr5', 'soft', '0', '65536', '256', '4096', '0', '2048'),
    ('ATMEGA649A', 'ATMEGA649A', 'avr5', 'soft', '0', '65536', '256', '4096', '0', '2048'),
    ('ATMEGA649P', 'ATMEGA649P', 'avr5', 'soft', '0', '65536', '256', '4096', '0', '2048'),
    ('ATMEGA808', 'ATMEGA808', 'avrxmega3', 'soft', '0', '8192', '15360', '1024', '5120', '256'),
    ('ATMEGA809', 'ATMEGA809', 'avrxmega3', 'soft', '0', '8192', '15360', '1024', '5120', '256'),
    ('ATMEGA1280', 'ATMEGA1280', 'avr51', 'soft', '0', '131072', '512', '8192', '0', '4096'),
    ('ATMEGA1281', 'ATMEGA1281', 'avr51', 'soft', '0', '131072', '512', '8192', '0', '4096'),
    ('ATMEGA1284', 'ATMEGA1284', 'avr51', 'soft', '0', '131072', '256', '16384', '0', '4096'),
    ('ATMEGA1284P', 'ATMEGA1284P', 'avr51', 'soft', '0', '131072', '256', '16384', '0', '4096'),
    ('ATMEGA1284RFR2', 'ATMEGA1284RFR2', 'avr51', 'soft', '0', '131072', '512', '16384', '0', '4096'),
    ('ATMEGA1608', 'ATMEGA1608', 'avrxmega3', 'soft', '0', '16384', '14336', '2048', '5120', '256'),
    ('ATMEGA1609', 'ATMEGA1609', 'avrxmega3', 'soft', '0', '16384', '14336', '2048', '5120', '256'),
    ('ATMEGA2560', 'ATMEGA2560', 'avr6', 'soft', '0', '262144', '512', '8192', '0', '4096'),
    ('ATMEGA2561', 'ATMEGA2561', 'avr6', 'soft', '0', '262144', '512', '8192', '0', '4096'),
    ('ATMEGA2564RFR2', 'ATMEGA2564RFR2', 'avr6', 'soft', '0', '262144', '512', '32768', '0', '8192'),
    ('ATMEGA3208', 'ATMEGA3208', 'avrxmega3', 'soft', '0', '32768', '12288', '4096', '5120', '256'),
    ('ATMEGA3209', 'ATMEGA3209', 'avrxmega3', 'soft', '0', '32768', '12288', '4096', '5120', '256'),
    ('ATMEGA3250', 'ATMEGA3250', 'avr5', 'soft', '0', '32768', '256', '2048', '0', '1024'),
    ('ATMEGA3250A', 'ATMEGA3250A', 'avr5', 'soft', '0', '32768', '256', '2048', '0', '1024'),
    ('ATMEGA3250P', 'ATMEGA3250P', 'avr5', 'soft', '0', '32768', '256', '2048', '0', '1024'),
    ('ATMEGA3250PA', 'ATMEGA3250PA', 'avr5', 'soft', '0', '32768', '256', '2048', '0', '1024'),
    ('ATMEGA3290', 'ATMEGA3290', 'avr5', 'soft', '0', '32768', '256', '2048', '0', '1024'),
    ('ATMEGA3290A', 'ATMEGA3290A', 'avr5', 'soft', '0', '32768', '256', '2048', '0', '1024'),
    ('ATMEGA3290P', 'ATMEGA3290P', 'avr5', 'soft', '0', '32768', '256', '2048', '0', '1024'),
    ('ATMEGA3290PA', 'ATMEGA3290PA', 'avr5', 'soft', '0', '32768', '256', '2048', '0', '1024'),
    ('ATMEGA4808', 'ATMEGA4808', 'avrxmega3', 'soft', '0', '49152', '10240', '6144', '5120', '256'),
    ('ATMEGA4809', 'ATMEGA4809', 'avrxmega3', 'soft', '0', '49152', '10240', '6144', '5120', '256'),
    ('ATMEGA6450', 'ATMEGA6450', 'avr5', 'soft', '0', '65536', '256', '4096', '0', '2048'),
    ('ATMEGA6450A', 'ATMEGA6450A', 'avr5', 'soft', '0', '65536', '256', '4096', '0', '2048'),
    ('ATMEGA6450P', 'ATMEGA6450P', 'avr5', 'soft', '0', '65536', '256', '4096', '0', '2048'),
    ('ATMEGA6490', 'ATMEGA6490', 'avr5', 'soft', '0', '65536', '256', '4096', '0', '2048'),
    ('ATMEGA6490A', 'ATMEGA6490A', 'avr5', 'soft', '0', '65536', '256', '4096', '0', '2048'),
    ('ATMEGA6490P', 'ATMEGA6490P', 'avr5', 'soft', '0', '65536', '256', '4096', '0', '2048'),
    ('ATMEGA8515', 'ATMEGA8515', 'avr4', 'soft', '0', '8192', '96', '512', '0', '512'),
    ('ATMEGA8535', 'ATMEGA8535', 'avr4', 'soft', '0', '8192', '96', '512', '0', '512'),
    ('ATTINY4', 'ATTINY4', 'avrtiny', 'soft', '0', '512', '64', '32', '0', '0'),
    ('ATTINY5', 'ATTINY5', 'avrtiny', 'soft', '0', '512', '64', '32', '0', '0'),
    ('ATTINY9', 'ATTINY9', 'avrtiny', 'soft', '0', '1024', '64', '32', '0', '0'),
    ('ATTINY10', 'ATTINY10', 'avrtiny', 'soft', '0', '1024', '64', '32', '0', '0'),
    ('ATTINY11', 'ATTINY11', 'avr1', 'soft', '0', '1024', '0', '0', '0', '0'),
    ('ATTINY12', 'ATTINY12', 'avr1', 'soft', '0', '1024', '0', '0', '0', '64'),
    ('ATTINY13', 'ATTINY13', 'avr25', 'soft', '0', '1024', '96', '64', '0', '64'),
    ('ATTINY13A', 'ATTINY13A', 'avr25', 'soft', '0', '1024', '96', '64', '0', '64'),
    ('ATTINY15', 'ATTINY15', 'avr1', 'soft', '0', '1024', '0', '0', '0', '64'),
    ('ATTINY20', 'ATTINY20', 'avrtiny', 'soft', '0', '2048', '64', '128', '0', '0'),
    ('ATTINY24', 'ATTINY24', 'avr25', 'soft', '0', '2048', '96', '128', '0', '128'),
    ('ATTINY24A', 'ATTINY24A', 'avr25', 'soft', '0', '2048', '96', '128', '0', '128'),
    ('ATTINY25', 'ATTINY25', 'avr25', 'soft', '0', '2048', '96', '128', '0', '128'),
    ('ATTINY26', 'ATTINY26', 'avr2', 'soft', '0', '2048', '96', '128', '0', '128'),
    ('ATTINY28', 'ATTINY28', 'avr1', 'soft', '0', '2048', '0', '0', '0', '0'),
    ('ATTINY40', 'ATTINY40', 'avrtiny', 'soft', '0', '4096', '64', '256', '0', '0'),
    ('ATTINY43U', 'ATTINY43U', 'avr25', 'soft', '0', '4096', '96', '256', '0', '64'),
    ('ATTINY44', 'ATTINY44', 'avr25', 'soft', '0', '4096', '96', '256', '0', '256'),
    ('ATTINY44A', 'ATTINY44A', 'avr25', 'soft', '0', '4096', '96', '256', '0', '256'),
    ('ATTINY45', 'ATTINY45', 'avr25', 'soft', '0', '4096', '96', '256', '0', '256'),
    ('ATTINY48', 'ATTINY48', 'avr25', 'soft', '0', '4096', '256', '256', '0', '64'),
    ('ATTINY84', 'ATTINY84', 'avr25', 'soft', '0', '8192', '96', '512', '0', '512'),
    ('ATTINY84A', 'ATTINY84A', 'avr25', 'soft', '0', '8192', '96', '512', '0', '512'),
    ('ATTINY85', 'ATTINY85', 'avr25', 'soft', '0', '8192', '96', '512', '0', '512'),
    ('ATTINY87', 'ATTINY87', 'avr25', 'soft', '0', '8192', '256', '512', '0', '512'),
    ('ATTINY88', 'ATTINY88', 'avr25', 'soft', '0', '8192', '256', '512', '0', '64'),
    ('ATTINY102', 'ATTINY102', 'avrtiny', 'soft', '0', '1024', '64', '32', '0', '0'),
    ('ATTINY104', 'ATTINY104', 'avrtiny', 'soft', '0', '1024', '64', '32', '0', '0'),
    ('ATTINY167', 'ATTINY167', 'avr35', 'soft', '0', '16384', '256', '512', '0', '512'),
    ('ATTINY202', 'ATTINY202', 'avrxmega3', 'soft', '0', '2048', '16256', '128', '5120', '64'),
    ('ATTINY204', 'ATTINY204', 'avrxmega3', 'soft', '0', '2048', '16256', '128', '5120', '64'),
    ('ATTINY212', 'ATTINY212', 'avrxmega3', 'soft', '0', '2048', '16256', '128', '5120', '64'),
    ('ATTINY214', 'ATTINY214', 'avrxmega3', 'soft', '0', '2048', '16256', '128', '5120', '64'),
    ('ATTINY261', 'ATTINY261', 'avr25', 'soft', '0', '2048', '96', '128', '0', '128'),
    ('ATTINY261A', 'ATTINY261A', 'avr25', 'soft', '0', '2048', '96', '128', '0', '128'),
    ('ATTINY402', 'ATTINY402', 'avrxmega3', 'soft', '0', '4096', '16128', '256', '5120', '128'),
    ('ATTINY404', 'ATTINY404', 'avrxmega3', 'soft', '0', '4096', '16128', '256', '5120', '128'),
    ('ATTINY406', 'ATTINY406', 'avrxmega3', 'soft', '0', '4096', '16128', '256', '5120', '128'),
    ('ATTINY412', 'ATTINY412', 'avrxmega3', 'soft', '0', '4096', '16128', '256', '5120', '128'),
    ('ATTINY414', 'ATTINY414', 'avrxmega3', 'soft', '0', '4096', '16128', '256', '5120', '128'),
    ('ATTINY416', 'ATTINY416', 'avrxmega3', 'soft', '0', '4096', '16128', '256', '5120', '128'),
    ('ATTINY416AUTO', 'ATTINY416AUTO', 'avrxmega3', 'soft', '0', '4096', '16128', '256', '5120', '128'),
    ('ATTINY417', 'ATTINY417', 'avrxmega3', 'soft', '0', '4096', '16128', '256', '5120', '128'),
    ('ATTINY441', 'ATTINY441', 'avr25', 'soft', '0', '4096', '256', '256', '0', '256'),
    ('ATTINY461', 'ATTINY461', 'avr25', 'soft', '0', '4096', '96', '256', '0', '256'),
    ('ATTINY461A', 'ATTINY461A', 'avr25', 'soft', '0', '4096', '96', '256', '0', '256'),
    ('ATTINY804', 'ATTINY804', 'avrxmega3', 'soft', '0', '8192', '15872', '512', '5120', '128'),
    ('ATTINY806', 'ATTINY806', 'avrxmega3', 'soft', '0', '8192', '15872', '512', '5120', '128'),
    ('ATTINY807', 'ATTINY807', 'avrxmega3', 'soft', '0', '8192', '15872', '512', '5120', '128'),
    ('ATTINY814', 'ATTINY814', 'avrxmega3', 'soft', '0', '8192', '15872', '512', '5120', '128'),
    ('ATTINY816', 'ATTINY816', 'avrxmega3', 'soft', '0', '8192', '15872', '512', '5120', '128'),
    ('ATTINY817', 'ATTINY817', 'avrxmega3', 'soft', '0', '8192', '15872', '512', '5120', '128'),
    ('ATTINY828', 'ATTINY828', 'avr25', 'soft', '0', '8192', '256', '512', '0', '256'),
    ('ATTINY841', 'ATTINY841', 'avr25', 'soft', '0', '8192', '256', '512', '0', '512'),
    ('ATTINY861', 'ATTINY861', 'avr25', 'soft', '0', '8192', '96', '512', '0', '512'),
    ('ATTINY861A', 'ATTINY861A', 'avr25', 'soft', '0', '8192', '96', '512', '0', '512'),
    ('ATTINY1604', 'ATTINY1604', 'avrxmega3', 'soft', '0', '16384', '15360', '1024', '5120', '256'),
    ('ATTINY1606', 'ATTINY1606', 'avrxmega3', 'soft', '0', '16384', '15360', '1024', '5120', '256'),
    ('ATTINY1607', 'ATTINY1607', 'avrxmega3', 'soft', '0', '16384', '15360', '1024', '5120', '256'),
    ('ATTINY1614', 'ATTINY1614', 'avrxmega3', 'soft', '0', '16384', '14336', '2048', '5120', '256'),
    ('ATTINY1616', 'ATTINY1616', 'avrxmega3', 'soft', '0', '16384', '14336', '2048', '5120', '256'),
    ('ATTINY1617', 'ATTINY1617', 'avrxmega3', 'soft', '0', '16384', '14336', '2048', '5120', '256'),
    ('ATTINY1624', 'ATTINY1624', 'avrxmega3', 'soft', '0', '16384', '14336', '2048', '5120', '256'),
    ('ATTINY1626', 'ATTINY1626', 'avrxmega3', 'soft', '0', '16384', '14336', '2048', '5120', '256'),
    ('ATTINY1627', 'ATTINY1627', 'avrxmega3', 'soft', '0', '16384', '14336', '2048', '5120', '256'),
    ('ATTINY1634', 'ATTINY1634', 'avr35', 'soft', '0', '16384', '256', '1024', '0', '256'),
    ('ATTINY2313', 'ATTINY2313', 'avr25', 'soft', '0', '2048', '96', '128', '0', '128'),
    ('ATTINY2313A', 'ATTINY2313A', 'avr25', 'soft', '0', '2048', '96', '128', '0', '128'),
    ('ATTINY3214', 'ATTINY3214', 'avrxmega3', 'soft', '0', '32768', '14336', '2048', '5120', '256'),
    ('ATTINY3216', 'ATTINY3216', 'avrxmega3', 'soft', '0', '32768', '14336', '2048', '5120', '256'),
    ('ATTINY3217', 'ATTINY3217', 'avrxmega3', 'soft', '0', '32768', '14336', '2048', '5120', '256'),
    ('ATTINY4313', 'ATTINY4313', 'avr25', 'soft', '0', '4096', '96', '256', '0', '256'),
    ('ARDUINOLEONARDO', 'ATMEGA32U4', 'avr5', 'soft', '0', '32768', '256', '2560', '0', '1024'),
    ('ARDUINOMEGA', 'ATMEGA2560', 'avr6', 'soft', '0', '262144', '512', '8192', '0', '4096'),
    ('ARDUINOMICRO', 'ATMEGA32U4', 'avr5', 'soft', '0', '32768', '256', '2560', '0', '1024'),
    ('ARDUINONANO', 'ATMEGA328P', 'avr5', 'soft', '0', '32768', '256', '2048', '0', '1024'),
    ('ARDUINONANOEVERY', 'ATMEGA4809', 'avrxmega3', 'soft', '0', '49152', '10240', '6144', '5120', '256'),
    ('ARDUINOUNO', 'ATMEGA328P', 'avr5', 'soft', '0', '32768', '256', '2048', '0', '1024'),
    ('ATMEGA256RFR2XPRO', 'ATMEGA256RFR2', 'avr6', 'soft', '0', '262144', '512', '32768', '0', '8192'),
    ('ATMEGA324PBXPRO', 'ATMEGA324PB', 'avr5', 'soft', '0', '32768', '256', '2048', '0', '1024'),
    ('ATMEGA1284PXPLAINED', 'ATMEGA1284P', 'avr51', 'soft', '0', '131072', '256', '16384', '0', '4096'),
    ('ATMEGA4809XPRO', 'ATMEGA4809', 'avrxmega3', 'soft', '0', '49152', '10240', '6144', '5120', '256'),
    ('ATTINY817XPRO', 'ATTINY817', 'avrxmega3', 'soft', '0', '8192', '15872', '512', '5120', '128'),
    ('ATTINY3217XPRO', 'ATTINY3217', 'avrxmega3', 'soft', '0', '32768', '14336', '2048', '5120', '256'));

type
  Tx86_64_ControllerDataList = array of array of String;

const
  x86_64_ControllerDataList : Tx86_64_ControllerDataList = (
    ('controllertypestr', 'controllerunitstr', 'cputype', 'fputype', 'flashbase', 'flashsize', 'srambase', 'sramsize', 'eeprombase', 'eepromsize', 'bootbase', 'bootsize'));

type
  Triscv64_ControllerDataList = array of array of String;

const
  riscv64_ControllerDataList : Triscv64_ControllerDataList = (
    ('controllertypestr', 'controllerunitstr', 'cputype', 'fputype', 'flashbase', 'flashsize', 'srambase', 'sramsize', 'eeprombase', 'eepromsize', 'bootbase', 'bootsize'));

type
  Tpowerpc_ControllerDataList = array of array of String;

const
  powerpc_ControllerDataList : Tpowerpc_ControllerDataList = (
    ('controllertypestr', 'controllerunitstr', 'cputype', 'fputype', 'flashbase', 'flashsize', 'srambase', 'sramsize', 'eeprombase', 'eepromsize', 'bootbase', 'bootsize'));

type
  Tarm_ControllerDataList = array of array of String;

const
  arm_ControllerDataList : Tarm_ControllerDataList = (
    ('controllertypestr', 'controllerunitstr', 'cputype', 'fputype', 'flashbase', 'flashsize', 'srambase', 'sramsize', 'eeprombase', 'eepromsize', 'bootbase', 'bootsize'),
    ('LPC810M021FN8', 'LPC8xx', 'armv6m', 'soft', '$00000000', '$00001000', '$10000000', '$00000400'),
    ('LPC811M001FDH16', 'LPC8xx', 'armv6m', 'soft', '$00000000', '$00002000', '$10000000', '$00000800'),
    ('LPC812M101FDH16', 'LPC8xx', 'armv6m', 'soft', '$00000000', '$00004000', '$10000000', '$00001000'),
    ('LPC812M101FD20', 'LPC8xx', 'armv6m', 'soft', '$00000000', '$00004000', '$10000000', '$00001000'),
    ('LPC812M101FDH20', 'LPC8xx', 'armv6m', 'soft', '$00000000', '$00004000', '$10000000', '$00001000'),
    ('LPC1110FD20', 'LPC11XX', 'armv6m', 'soft', '$00000000', '$00001000', '$10000000', '$00000400'),
    ('LPC1111FDH20_002', 'LPC11XX', 'armv6m', 'soft', '$00000000', '$00002000', '$10000000', '$00000800'),
    ('LPC1111FHN33_101', 'LPC11XX', 'armv6m', 'soft', '$00000000', '$00002000', '$10000000', '$00000800'),
    ('LPC1111FHN33_102', 'LPC11XX', 'armv6m', 'soft', '$00000000', '$00002000', '$10000000', '$00000800'),
    ('LPC1111FHN33_103', 'LPC11XX', 'armv6m', 'soft', '$00000000', '$00002000', '$10000000', '$00000800'),
    ('LPC1111FHN33_201', 'LPC11XX', 'armv6m', 'soft', '$00000000', '$00002000', '$10000000', '$00001000'),
    ('LPC1111FHN33_202', 'LPC11XX', 'armv6m', 'soft', '$00000000', '$00002000', '$10000000', '$00001000'),
    ('LPC1111FHN33_203', 'LPC11XX', 'armv6m', 'soft', '$00000000', '$00002000', '$10000000', '$00001000'),
    ('LPC1112FD20_102', 'LPC11XX', 'armv6m', 'soft', '$00000000', '$00004000', '$10000000', '$00001000'),
    ('LPC1112FDH20_102', 'LPC11XX', 'armv6m', 'soft', '$00000000', '$00004000', '$10000000', '$00001000'),
    ('LPC1112FDH28_102', 'LPC11XX', 'armv6m', 'soft', '$00000000', '$00004000', '$10000000', '$00001000'),
    ('LPC1112FHN33_101', 'LPC11XX', 'armv6m', 'soft', '$00000000', '$00004000', '$10000000', '$00000800'),
    ('LPC1112FHN33_102', 'LPC11XX', 'armv6m', 'soft', '$00000000', '$00004000', '$10000000', '$00000800'),
    ('LPC1112FHN33_103', 'LPC11XX', 'armv6m', 'soft', '$00000000', '$00004000', '$10000000', '$00000800'),
    ('LPC1112FHN33_201', 'LPC11XX', 'armv6m', 'soft', '$00000000', '$00004000', '$10000000', '$00001000'),
    ('LPC1112FHN24_202', 'LPC11XX', 'armv6m', 'soft', '$00000000', '$00004000', '$10000000', '$00001000'),
    ('LPC1112FHN33_202', 'LPC11XX', 'armv6m', 'soft', '$00000000', '$00004000', '$10000000', '$00001000'),
    ('LPC1112FHN33_203', 'LPC11XX', 'armv6m', 'soft', '$00000000', '$00004000', '$10000000', '$00001000'),
    ('LPC1112FHI33_202', 'LPC11XX', 'armv6m', 'soft', '$00000000', '$00004000', '$10000000', '$00001000'),
    ('LPC1112FHI33_203', 'LPC11XX', 'armv6m', 'soft', '$00000000', '$00004000', '$10000000', '$00001000'),
    ('LPC1113FHN33_201', 'LPC11XX', 'armv6m', 'soft', '$00000000', '$00006000', '$10000000', '$00001000'),
    ('LPC1113FHN33_202', 'LPC11XX', 'armv6m', 'soft', '$00000000', '$00006000', '$10000000', '$00001000'),
    ('LPC1113FHN33_203', 'LPC11XX', 'armv6m', 'soft', '$00000000', '$00006000', '$10000000', '$00001000'),
    ('LPC1113FHN33_301', 'LPC11XX', 'armv6m', 'soft', '$00000000', '$00006000', '$10000000', '$00002000'),
    ('LPC1113FHN33_302', 'LPC11XX', 'armv6m', 'soft', '$00000000', '$00006000', '$10000000', '$00002000'),
    ('LPC1113FHN33_303', 'LPC11XX', 'armv6m', 'soft', '$00000000', '$00006000', '$10000000', '$00002000'),
    ('LPC1113FBD48_301', 'LPC11XX', 'armv6m', 'soft', '$00000000', '$00006000', '$10000000', '$00002000'),
    ('LPC1113FBD48_302', 'LPC11XX', 'armv6m', 'soft', '$00000000', '$00006000', '$10000000', '$00002000'),
    ('LPC1113FBD48_303', 'LPC11XX', 'armv6m', 'soft', '$00000000', '$00006000', '$10000000', '$00002000'),
    ('LPC1114FDH28_102', 'LPC11XX', 'armv6m', 'soft', '$00000000', '$00008000', '$10000000', '$00001000'),
    ('LPC1114FN28_102', 'LPC11XX', 'armv6m', 'soft', '$00000000', '$00008000', '$10000000', '$00001000'),
    ('LPC1114FHN33_201', 'LPC11XX', 'armv6m', 'soft', '$00000000', '$00008000', '$10000000', '$00001000'),
    ('LPC1114FHN33_202', 'LPC11XX', 'armv6m', 'soft', '$00000000', '$00008000', '$10000000', '$00001000'),
    ('LPC1114FHN33_203', 'LPC11XX', 'armv6m', 'soft', '$00000000', '$00008000', '$10000000', '$00001000'),
    ('LPC1114FHN33_301', 'LPC11XX', 'armv6m', 'soft', '$00000000', '$00008000', '$10000000', '$00002000'),
    ('LPC1114FHN33_302', 'LPC11XX', 'armv6m', 'soft', '$00000000', '$00008000', '$10000000', '$00002000'),
    ('LPC1114FHN33_303', 'LPC11XX', 'armv6m', 'soft', '$00000000', '$00008000', '$10000000', '$00002000'),
    ('LPC1114FHN33_333', 'LPC11XX', 'armv6m', 'soft', '$00000000', '$0000E000', '$10000000', '$00002000'),
    ('LPC1114FHI33_302', 'LPC11XX', 'armv6m', 'soft', '$00000000', '$00008000', '$10000000', '$00002000'),
    ('LPC1114FHI33_303', 'LPC11XX', 'armv6m', 'soft', '$00000000', '$00008000', '$10000000', '$00002000'),
    ('LPC1114FBD48_301', 'LPC11XX', 'armv6m', 'soft', '$00000000', '$00008000', '$10000000', '$00002000'),
    ('LPC1114FBD48_302', 'LPC11XX', 'armv6m', 'soft', '$00000000', '$00008000', '$10000000', '$00002000'),
    ('LPC1114FBD48_303', 'LPC11XX', 'armv6m', 'soft', '$00000000', '$00008000', '$10000000', '$00002000'),
    ('LPC1114FBD48_323', 'LPC11XX', 'armv6m', 'soft', '$00000000', '$0000C000', '$10000000', '$00002000'),
    ('LPC1114FBD48_333', 'LPC11XX', 'armv6m', 'soft', '$00000000', '$0000E000', '$10000000', '$00002000'),
    ('LPC1115FBD48_303', 'LPC11XX', 'armv6m', 'soft', '$00000000', '$00010000', '$10000000', '$00002000'),
    ('LPC11C12FBD48_301', 'LPC11XX', 'armv6m', 'soft', '$00000000', '$00004000', '$10000000', '$00002000'),
    ('LPC11C14FBD48_301', 'LPC11XX', 'armv6m', 'soft', '$00000000', '$00008000', '$10000000', '$00002000'),
    ('LPC11C22FBD48_301', 'LPC11XX', 'armv6m', 'soft', '$00000000', '$00004000', '$10000000', '$00002000'),
    ('LPC11C24FBD48_301', 'LPC11XX', 'armv6m', 'soft', '$00000000', '$00008000', '$10000000', '$00002000'),
    ('LPC11D14FBD100_302', 'LPC11XX', 'armv6m', 'soft', '$00000000', '$00008000', '$10000000', '$00002000'),
    ('LPC1224FBD48_101', 'LPC122X', 'armv6m', 'soft', '$00000000', '$00008000', '$10000000', '$00001000'),
    ('LPC1224FBD48_121', 'LPC122X', 'armv6m', 'soft', '$00000000', '$0000C000', '$10000000', '$00001000'),
    ('LPC1224FBD64_101', 'LPC122X', 'armv6m', 'soft', '$00000000', '$00008000', '$10000000', '$00001000'),
    ('LPC1224FBD64_121', 'LPC122X', 'armv6m', 'soft', '$00000000', '$0000C000', '$10000000', '$00001000'),
    ('LPC1225FBD48_301', 'LPC122X', 'armv6m', 'soft', '$00000000', '$00010000', '$10000000', '$00002000'),
    ('LPC1225FBD48_321', 'LPC122X', 'armv6m', 'soft', '$00000000', '$00014000', '$10000000', '$00002000'),
    ('LPC1225FBD64_301', 'LPC122X', 'armv6m', 'soft', '$00000000', '$00010000', '$10000000', '$00002000'),
    ('LPC1225FBD64_321', 'LPC122X', 'armv6m', 'soft', '$00000000', '$00014000', '$10000000', '$00002000'),
    ('LPC1226FBD48_301', 'LPC122X', 'armv6m', 'soft', '$00000000', '$00018000', '$10000000', '$00002000'),
    ('LPC1226FBD64_301', 'LPC122X', 'armv6m', 'soft', '$00000000', '$00018000', '$10000000', '$00002000'),
    ('LPC1227FBD48_301', 'LPC122X', 'armv6m', 'soft', '$00000000', '$00020000', '$10000000', '$00002000'),
    ('LPC1227FBD64_301', 'LPC122X', 'armv6m', 'soft', '$00000000', '$00020000', '$10000000', '$00002000'),
    ('LPC12D27FBD100_301', 'LPC122X', 'armv6m', 'soft', '$00000000', '$00020000', '$10000000', '$00002000'),
    ('LPC1311FHN33', 'LPC13XX', 'armv7m', 'soft', '$00000000', '$00002000', '$10000000', '$00001000'),
    ('LPC1311FHN33_01', 'LPC13XX', 'armv7m', 'soft', '$00000000', '$00002000', '$10000000', '$00001000'),
    ('LPC1313FHN33', 'LPC13XX', 'armv7m', 'soft', '$00000000', '$00008000', '$10000000', '$00002000'),
    ('LPC1313FHN33_01', 'LPC13XX', 'armv7m', 'soft', '$00000000', '$00008000', '$10000000', '$00002000'),
    ('LPC1313FBD48', 'LPC13XX', 'armv7m', 'soft', '$00000000', '$00008000', '$10000000', '$00002000'),
    ('LPC1313FBD48_01', 'LPC13XX', 'armv7m', 'soft', '$00000000', '$00008000', '$10000000', '$00002000'),
    ('LPC1315FHN33', 'LPC13XX', 'armv7m', 'soft', '$00000000', '$00008000', '$10000000', '$00002000'),
    ('LPC1315FBD48', 'LPC13XX', 'armv7m', 'soft', '$00000000', '$00008000', '$10000000', '$00002000'),
    ('LPC1316FHN33', 'LPC13XX', 'armv7m', 'soft', '$00000000', '$0000C000', '$10000000', '$00002000'),
    ('LPC1316FBD48', 'LPC13XX', 'armv7m', 'soft', '$00000000', '$0000C000', '$10000000', '$00002000'),
    ('LPC1317FHN33', 'LPC13XX', 'armv7m', 'soft', '$00000000', '$00010000', '$10000000', '$00002000'),
    ('LPC1317FBD48', 'LPC13XX', 'armv7m', 'soft', '$00000000', '$00010000', '$10000000', '$00002000'),
    ('LPC1317FBD64', 'LPC13XX', 'armv7m', 'soft', '$00000000', '$00010000', '$10000000', '$00002000'),
    ('LPC1342FHN33', 'LPC13XX', 'armv7m', 'soft', '$00000000', '$00004000', '$10000000', '$00001000'),
    ('LPC1342FBD48', 'LPC13XX', 'armv7m', 'soft', '$00000000', '$00004000', '$10000000', '$00001000'),
    ('LPC1343FHN33', 'LPC13XX', 'armv7m', 'soft', '$00000000', '$00008000', '$10000000', '$00002000'),
    ('LPC1343FBD48', 'LPC13XX', 'armv7m', 'soft', '$00000000', '$00008000', '$10000000', '$00002000'),
    ('LPC1345FHN33', 'LPC13XX', 'armv7m', 'soft', '$00000000', '$00008000', '$10000000', '$00002000'),
    ('LPC1345FBD48', 'LPC13XX', 'armv7m', 'soft', '$00000000', '$00008000', '$10000000', '$00002000'),
    ('LPC1346FHN33', 'LPC13XX', 'armv7m', 'soft', '$00000000', '$0000C000', '$10000000', '$00002000'),
    ('LPC1346FBD48', 'LPC13XX', 'armv7m', 'soft', '$00000000', '$0000C000', '$10000000', '$00002000'),
    ('LPC1347FHN33', 'LPC13XX', 'armv7m', 'soft', '$00000000', '$00010000', '$10000000', '$00002000'),
    ('LPC1347FBD48', 'LPC13XX', 'armv7m', 'soft', '$00000000', '$00010000', '$10000000', '$00002000'),
    ('LPC1347FBD64', 'LPC13XX', 'armv7m', 'soft', '$00000000', '$00010000', '$10000000', '$00002000'),
    ('LPC2114', 'LPC21x4', 'armv4t', 'soft', '$00000000', '$00040000', '$40000000', '$00004000'),
    ('LPC2124', 'LPC21x4', 'armv4t', 'soft', '$00000000', '$00040000', '$40000000', '$00004000'),
    ('LPC2194', 'LPC21x4', 'armv4t', 'soft', '$00000000', '$00040000', '$40000000', '$00004000'),
    ('LPC1754', 'LPC1754', 'armv7m', 'soft', '$00000000', '$00020000', '$10000000', '$00004000'),
    ('LPC1756', 'LPC1756', 'armv7m', 'soft', '$00000000', '$00040000', '$10000000', '$00004000'),
    ('LPC1758', 'LPC1758', 'armv7m', 'soft', '$00000000', '$00080000', '$10000000', '$00008000'),
    ('LPC1764', 'LPC1764', 'armv7m', 'soft', '$00000000', '$00020000', '$10000000', '$00004000'),
    ('LPC1766', 'LPC1766', 'armv7m', 'soft', '$00000000', '$00040000', '$10000000', '$00008000'),
    ('LPC1768', 'LPC1768', 'armv7m', 'soft', '$00000000', '$00080000', '$10000000', '$00008000'),
    ('AT91SAM7S256', 'AT91SAM7x256', 'armv4t', 'soft', '$00000000', '$00040000', '$00200000', '$00010000'),
    ('AT91SAM7SE256', 'AT91SAM7x256', 'armv4t', 'soft', '$00000000', '$00040000', '$00200000', '$00010000'),
    ('AT91SAM7X256', 'AT91SAM7x256', 'armv4t', 'soft', '$00000000', '$00040000', '$00200000', '$00010000'),
    ('AT91SAM7XC256', 'AT91SAM7x256', 'armv4t', 'soft', '$00000000', '$00040000', '$00200000', '$00010000'),
    ('STM32F030C6', 'STM32F0XX', 'armv6m', 'soft', '$08000000', '$00008000', '$20000000', '$00001000'),
    ('STM32F030C8', 'STM32F0XX', 'armv6m', 'soft', '$08000000', '$00010000', '$20000000', '$00002000'),
    ('STM32F030F4', 'STM32F0XX', 'armv6m', 'soft', '$08000000', '$00004000', '$20000000', '$00001000'),
    ('STM32F030K6', 'STM32F0XX', 'armv6m', 'soft', '$08000000', '$00008000', '$20000000', '$00001000'),
    ('STM32F030R8', 'STM32F0XX', 'armv6m', 'soft', '$08000000', '$00010000', '$20000000', '$00002000'),
    ('STM32F050C4', 'STM32F0XX', 'armv6m', 'soft', '$08000000', '$00004000', '$20000000', '$00001000'),
    ('STM32F050C6', 'STM32F0XX', 'armv6m', 'soft', '$08000000', '$00008000', '$20000000', '$00001000'),
    ('STM32F050F4', 'STM32F0XX', 'armv6m', 'soft', '$08000000', '$00004000', '$20000000', '$00001000'),
    ('STM32F050F6', 'STM32F0XX', 'armv6m', 'soft', '$08000000', '$00008000', '$20000000', '$00001000'),
    ('STM32F050G4', 'STM32F0XX', 'armv6m', 'soft', '$08000000', '$00004000', '$20000000', '$00001000'),
    ('STM32F050G6', 'STM32F0XX', 'armv6m', 'soft', '$08000000', '$00008000', '$20000000', '$00001000'),
    ('STM32F050K4', 'STM32F0XX', 'armv6m', 'soft', '$08000000', '$00004000', '$20000000', '$00001000'),
    ('STM32F050K6', 'STM32F0XX', 'armv6m', 'soft', '$08000000', '$00008000', '$20000000', '$00001000'),
    ('STM32F051C4', 'STM32F0XX', 'armv6m', 'soft', '$08000000', '$00004000', '$20000000', '$00001000'),
    ('STM32F051C6', 'STM32F0XX', 'armv6m', 'soft', '$08000000', '$00008000', '$20000000', '$00001000'),
    ('STM32F051C8', 'STM32F0XX', 'armv6m', 'soft', '$08000000', '$00010000', '$20000000', '$00002000'),
    ('STM32F051K4', 'STM32F0XX', 'armv6m', 'soft', '$08000000', '$00004000', '$20000000', '$00001000'),
    ('STM32F051K6', 'STM32F0XX', 'armv6m', 'soft', '$08000000', '$00008000', '$20000000', '$00001000'),
    ('STM32F051K8', 'STM32F0XX', 'armv6m', 'soft', '$08000000', '$00010000', '$20000000', '$00002000'),
    ('STM32F051R4', 'STM32F0XX', 'armv6m', 'soft', '$08000000', '$00004000', '$20000000', '$00001000'),
    ('STM32F051R6', 'STM32F0XX', 'armv6m', 'soft', '$08000000', '$00008000', '$20000000', '$00001000'),
    ('STM32F051R8', 'STM32F0XX', 'armv6m', 'soft', '$08000000', '$00010000', '$20000000', '$00002000'),
    ('STM32F091CC', 'STM32F0XX', 'armv6m', 'soft', '$08000000', '$00040000', '$20000000', '$00008000'),
    ('STM32F091CB', 'STM32F0XX', 'armv6m', 'soft', '$08000000', '$00020000', '$20000000', '$00008000'),
    ('STM32F091RC', 'STM32F0XX', 'armv6m', 'soft', '$08000000', '$00040000', '$20000000', '$00008000'),
    ('STM32F091RB', 'STM32F0XX', 'armv6m', 'soft', '$08000000', '$00020000', '$20000000', '$00008000'),
    ('STM32F091VC', 'STM32F0XX', 'armv6m', 'soft', '$08000000', '$00040000', '$20000000', '$00008000'),
    ('STM32F091VB', 'STM32F0XX', 'armv6m', 'soft', '$08000000', '$00020000', '$20000000', '$00008000'),
    ('STM32F100X4', 'STM32F10X_LD', 'armv7m', 'soft', '$08000000', '$00004000', '$20000000', '$00001000'),
    ('STM32F100X6', 'STM32F10X_LD', 'armv7m', 'soft', '$08000000', '$00008000', '$20000000', '$00001000'),
    ('STM32F100X8', 'STM32F10X_MD', 'armv7m', 'soft', '$08000000', '$00010000', '$20000000', '$00002000'),
    ('STM32F100XB', 'STM32F10X_MD', 'armv7m', 'soft', '$08000000', '$00020000', '$20000000', '$00002000'),
    ('STM32F100XC', 'STM32F10X_HD', 'armv7m', 'soft', '$08000000', '$00040000', '$20000000', '$00006000'),
    ('STM32F100XD', 'STM32F10X_HD', 'armv7m', 'soft', '$08000000', '$00060000', '$20000000', '$00008000'),
    ('STM32F100XE', 'STM32F10X_HD', 'armv7m', 'soft', '$08000000', '$00080000', '$20000000', '$00008000'),
    ('STM32F101X4', 'STM32F10X_LD', 'armv7m', 'soft', '$08000000', '$00004000', '$20000000', '$00001000'),
    ('STM32F101X6', 'STM32F10X_LD', 'armv7m', 'soft', '$08000000', '$00008000', '$20000000', '$00001800'),
    ('STM32F101X8', 'STM32F10X_MD', 'armv7m', 'soft', '$08000000', '$00010000', '$20000000', '$00002800'),
    ('STM32F101XB', 'STM32F10X_MD', 'armv7m', 'soft', '$08000000', '$00020000', '$20000000', '$00004000'),
    ('STM32F101XC', 'STM32F10X_HD', 'armv7m', 'soft', '$08000000', '$00040000', '$20000000', '$00008000'),
    ('STM32F101XD', 'STM32F10X_HD', 'armv7m', 'soft', '$08000000', '$00060000', '$20000000', '$0000C000'),
    ('STM32F101XE', 'STM32F10X_HD', 'armv7m', 'soft', '$08000000', '$00080000', '$20000000', '$0000C000'),
    ('STM32F101XF', 'STM32F10X_XL', 'armv7m', 'soft', '$08000000', '$000C0000', '$20000000', '$00014000'),
    ('STM32F101XG', 'STM32F10X_XL', 'armv7m', 'soft', '$08000000', '$00100000', '$20000000', '$00014000'),
    ('STM32F102X4', 'STM32F10X_LD', 'armv7m', 'soft', '$08000000', '$00004000', '$20000000', '$00001000'),
    ('STM32F102X6', 'STM32F10X_LD', 'armv7m', 'soft', '$08000000', '$00008000', '$20000000', '$00001800'),
    ('STM32F102X8', 'STM32F10X_MD', 'armv7m', 'soft', '$08000000', '$00010000', '$20000000', '$00002800'),
    ('STM32F102XB', 'STM32F10X_MD', 'armv7m', 'soft', '$08000000', '$00020000', '$20000000', '$00004000'),
    ('STM32F103X4', 'STM32F10X_LD', 'armv7m', 'soft', '$08000000', '$00004000', '$20000000', '$00001000'),
    ('STM32F103X6', 'STM32F10X_LD', 'armv7m', 'soft', '$08000000', '$00008000', '$20000000', '$00002800'),
    ('STM32F103X8', 'STM32F10X_MD', 'armv7m', 'soft', '$08000000', '$00010000', '$20000000', '$00005000'),
    ('STM32F103XB', 'STM32F10X_MD', 'armv7m', 'soft', '$08000000', '$00020000', '$20000000', '$00005000'),
    ('STM32F103XC', 'STM32F10X_HD', 'armv7m', 'soft', '$08000000', '$00040000', '$20000000', '$0000C000'),
    ('STM32F103XD', 'STM32F10X_HD', 'armv7m', 'soft', '$08000000', '$00060000', '$20000000', '$00010000'),
    ('STM32F103XE', 'STM32F10X_HD', 'armv7m', 'soft', '$08000000', '$00080000', '$20000000', '$00010000'),
    ('STM32F103XF', 'STM32F10X_XL', 'armv7m', 'soft', '$08000000', '$000C0000', '$20000000', '$00018000'),
    ('STM32F103XG', 'STM32F10X_XL', 'armv7m', 'soft', '$08000000', '$00100000', '$20000000', '$00018000'),
    ('STM32F107X8', 'STM32F10X_CONN', 'armv7m', 'soft', '$08000000', '$00010000', '$20000000', '$00010000'),
    ('STM32F107XB', 'STM32F10X_CONN', 'armv7m', 'soft', '$08000000', '$00020000', '$20000000', '$00010000'),
    ('STM32F107XC', 'STM32F10X_CONN', 'armv7m', 'soft', '$08000000', '$00040000', '$20000000', '$00010000'),
    ('STM32F105R8', 'STM32F10X_CL', 'armv7m', 'soft', '$08000000', '$00010000', '$20000000', '$00010000'),
    ('STM32F105RB', 'STM32F10X_CL', 'armv7m', 'soft', '$08000000', '$00020000', '$20000000', '$00010000'),
    ('STM32F105RC', 'STM32F10X_CL', 'armv7m', 'soft', '$08000000', '$00040000', '$20000000', '$00010000'),
    ('STM32F105V8', 'STM32F10X_CL', 'armv7m', 'soft', '$08000000', '$00010000', '$20000000', '$00010000'),
    ('STM32F105VB', 'STM32F10X_CL', 'armv7m', 'soft', '$08000000', '$00020000', '$20000000', '$00010000'),
    ('STM32F105VC', 'STM32F10X_CL', 'armv7m', 'soft', '$08000000', '$00040000', '$20000000', '$00010000'),
    ('STM32F107RB', 'STM32F10X_CL', 'armv7m', 'soft', '$08000000', '$00020000', '$20000000', '$00010000'),
    ('STM32F107RC', 'STM32F10X_CL', 'armv7m', 'soft', '$08000000', '$00040000', '$20000000', '$00010000'),
    ('STM32F107VB', 'STM32F10X_CL', 'armv7m', 'soft', '$08000000', '$00020000', '$20000000', '$00010000'),
    ('STM32F107VC', 'STM32F10X_CL', 'armv7m', 'soft', '$08000000', '$00040000', '$20000000', '$00010000'),
    ('STM32F401CB', 'STM32F401XX', 'armv7em', 'soft', '$08000000', '$00020000', '$20000000', '$00010000'),
    ('STM32F401RB', 'STM32F401XX', 'armv7em', 'soft', '$08000000', '$00020000', '$20000000', '$00010000'),
    ('STM32F401VB', 'STM32F401XX', 'armv7em', 'soft', '$08000000', '$00020000', '$20000000', '$00010000'),
    ('STM32F401CC', 'STM32F401XX', 'armv7em', 'soft', '$08000000', '$00040000', '$20000000', '$00010000'),
    ('STM32F401RC', 'STM32F401XX', 'armv7em', 'soft', '$08000000', '$00040000', '$20000000', '$00010000'),
    ('STM32F401VC', 'STM32F401XX', 'armv7em', 'soft', '$08000000', '$00040000', '$20000000', '$00010000'),
    ('DISCOVERYF401VC', 'STM32F401XX', 'armv7em', 'soft', '$08000000', '$00040000', '$20000000', '$00010000'),
    ('STM32F401CD', 'STM32F401XX', 'armv7em', 'soft', '$08000000', '$00060000', '$20000000', '$00018000'),
    ('STM32F401RD', 'STM32F401XX', 'armv7em', 'soft', '$08000000', '$00060000', '$20000000', '$00018000'),
    ('STM32F401VD', 'STM32F401XX', 'armv7em', 'soft', '$08000000', '$00060000', '$20000000', '$00018000'),
    ('STM32F401CE', 'STM32F401XX', 'armv7em', 'soft', '$08000000', '$00080000', '$20000000', '$00018000'),
    ('STM32F401RE', 'STM32F401XE', 'armv7em', 'soft', '$08000000', '$00080000', '$20000000', '$00018000'),
    ('NUCLEOF401RE', 'STM32F401XE', 'armv7em', 'soft', '$08000000', '$00080000', '$20000000', '$00018000'),
    ('STM32F401VE', 'STM32F401XX', 'armv7em', 'soft', '$08000000', '$00080000', '$20000000', '$00018000'),
    ('STM32F407VG', 'STM32F407XX', 'armv7em', 'soft', '$08000000', '$00100000', '$20000000', '$00020000'),
    ('DISCOVERYF407VG', 'STM32F407XX', 'armv7em', 'soft', '$08000000', '$00100000', '$20000000', '$00020000'),
    ('STM32F407IG', 'STM32F407XX', 'armv7em', 'soft', '$08000000', '$00100000', '$20000000', '$00020000'),
    ('STM32F407ZG', 'STM32F407XX', 'armv7em', 'soft', '$08000000', '$00100000', '$20000000', '$00020000'),
    ('STM32F407VE', 'STM32F407XX', 'armv7em', 'soft', '$08000000', '$00080000', '$20000000', '$00020000'),
    ('STM32F407ZE', 'STM32F407XX', 'armv7em', 'soft', '$08000000', '$00080000', '$20000000', '$00020000'),
    ('STM32F407IE', 'STM32F407XX', 'armv7em', 'soft', '$08000000', '$00080000', '$20000000', '$00020000'),
    ('STM32F411CC', 'STM32F411XE', 'armv7em', 'soft', '$08000000', '$00040000', '$20000000', '$00020000'),
    ('STM32F411RC', 'STM32F411XE', 'armv7em', 'soft', '$08000000', '$00040000', '$20000000', '$00020000'),
    ('STM32F411VC', 'STM32F411XE', 'armv7em', 'soft', '$08000000', '$00040000', '$20000000', '$00020000'),
    ('STM32F411CE', 'STM32F411XE', 'armv7em', 'soft', '$08000000', '$00080000', '$20000000', '$00020000'),
    ('STM32F411RE', 'STM32F411XE', 'armv7em', 'soft', '$08000000', '$00080000', '$20000000', '$00020000'),
    ('NUCLEOF411RE', 'STM32F411XE', 'armv7em', 'soft', '$08000000', '$00080000', '$20000000', '$00020000'),
    ('STM32F411VE', 'STM32F411XE', 'armv7em', 'soft', '$08000000', '$00080000', '$20000000', '$00020000'),
    ('DISCOVERYF411VE', 'STM32F411XE', 'armv7em', 'soft', '$08000000', '$00080000', '$20000000', '$00020000'),
    ('STM32F429VG', 'STM32F429XX', 'armv7em', 'soft', '$08000000', '$00100000', '$20000000', '$00030000'),
    ('STM32F429ZG', 'STM32F429XX', 'armv7em', 'soft', '$08000000', '$00100000', '$20000000', '$00030000'),
    ('STM32F429IG', 'STM32F429XX', 'armv7em', 'soft', '$08000000', '$00100000', '$20000000', '$00030000'),
    ('STM32F429VI', 'STM32F429XX', 'armv7em', 'soft', '$08000000', '$00200000', '$20000000', '$00030000'),
    ('STM32F429ZI', 'STM32F429XX', 'armv7em', 'soft', '$08000000', '$00200000', '$20000000', '$00030000'),
    ('DISCOVERYF429ZI', 'STM32F429XX', 'armv7em', 'soft', '$08000000', '$00200000', '$20000000', '$00030000'),
    ('STM32F429II', 'STM32F429XX', 'armv7em', 'soft', '$08000000', '$00200000', '$20000000', '$00030000'),
    ('STM32F429VE', 'STM32F429XX', 'armv7em', 'soft', '$08000000', '$00080000', '$20000000', '$00030000'),
    ('STM32F429ZE', 'STM32F429XX', 'armv7em', 'soft', '$08000000', '$00080000', '$20000000', '$00030000'),
    ('STM32F429IE', 'STM32F429XX', 'armv7em', 'soft', '$08000000', '$00080000', '$20000000', '$00030000'),
    ('STM32F429BG', 'STM32F429XX', 'armv7em', 'soft', '$08000000', '$00100000', '$20000000', '$00030000'),
    ('STM32F429BI', 'STM32F429XX', 'armv7em', 'soft', '$08000000', '$00200000', '$20000000', '$00030000'),
    ('STM32F429BE', 'STM32F429XX', 'armv7em', 'soft', '$08000000', '$00080000', '$20000000', '$00030000'),
    ('STM32F429NG', 'STM32F429XX', 'armv7em', 'soft', '$08000000', '$00100000', '$20000000', '$00030000'),
    ('STM32F429NI', 'STM32F429XX', 'armv7em', 'soft', '$08000000', '$00200000', '$20000000', '$00030000'),
    ('STM32F429NE', 'STM32F429XX', 'armv7em', 'soft', '$08000000', '$00080000', '$20000000', '$00030000'),
    ('STM32F446MC', 'STM32F446XX', 'armv7em', 'soft', '$08000000', '$00040000', '$20000000', '$00020000'),
    ('STM32F446RC', 'STM32F446XX', 'armv7em', 'soft', '$08000000', '$00040000', '$20000000', '$00020000'),
    ('STM32F446VC', 'STM32F446XX', 'armv7em', 'soft', '$08000000', '$00040000', '$20000000', '$00020000'),
    ('STM32F446ZC', 'STM32F446XX', 'armv7em', 'soft', '$08000000', '$00040000', '$20000000', '$00020000'),
    ('STM32F446ME', 'STM32F446XX', 'armv7em', 'soft', '$08000000', '$00080000', '$20000000', '$00020000'),
    ('STM32F446RE', 'STM32F446XX', 'armv7em', 'soft', '$08000000', '$00080000', '$20000000', '$00020000'),
    ('NUCLEOF446RE', 'STM32F446XX', 'armv7em', 'soft', '$08000000', '$00080000', '$20000000', '$00020000'),
    ('STM32F446VE', 'STM32F446XX', 'armv7em', 'soft', '$08000000', '$00080000', '$20000000', '$00020000'),
    ('STM32F446ZE', 'STM32F446XX', 'armv7em', 'soft', '$08000000', '$00080000', '$20000000', '$00020000'),
    ('STM32F745XE', 'STM32F745', 'armv7em', 'soft', '$08000000', '$00080000', '$20010000', '$00040000'),
    ('STM32F745XG', 'STM32F745', 'armv7em', 'soft', '$08000000', '$00100000', '$20010000', '$00040000'),
    ('STM32F746XE', 'STM32F746', 'armv7em', 'soft', '$08000000', '$00080000', '$20010000', '$00040000'),
    ('STM32F746XG', 'STM32F746', 'armv7em', 'soft', '$08000000', '$00100000', '$20010000', '$00040000'),
    ('STM32F756XE', 'STM32F756', 'armv7em', 'soft', '$08000000', '$00080000', '$20010000', '$00040000'),
    ('STM32F756XG', 'STM32F756', 'armv7em', 'soft', '$08000000', '$00100000', '$20010000', '$00040000'),
    ('STM32G071RB', 'STM32G071XX', 'armv6m', 'soft', '$08000000', '$00020000', '$20000000', '$00009000'),
    ('NUCLEOG071RB', 'STM32G071XX', 'armv6m', 'soft', '$08000000', '$00020000', '$20000000', '$00009000'),
    ('LM3S1110', 'LM3FURY', 'armv7m', 'soft', '$00000000', '$00010000', '$20000000', '$00004000'),
    ('LM3S1133', 'LM3FURY', 'armv7m', 'soft', '$00000000', '$00010000', '$20000000', '$00004000'),
    ('LM3S1138', 'LM3FURY', 'armv7m', 'soft', '$00000000', '$00010000', '$20000000', '$00004000'),
    ('LM3S1150', 'LM3FURY', 'armv7m', 'soft', '$00000000', '$00010000', '$20000000', '$00004000'),
    ('LM3S1162', 'LM3FURY', 'armv7m', 'soft', '$00000000', '$00010000', '$20000000', '$00004000'),
    ('LM3S1165', 'LM3FURY', 'armv7m', 'soft', '$00000000', '$00010000', '$20000000', '$00004000'),
    ('LM3S1166', 'LM3FURY', 'armv7m', 'soft', '$00000000', '$00010000', '$20000000', '$00004000'),
    ('LM3S2110', 'LM3FURY', 'armv7m', 'soft', '$00000000', '$00010000', '$20000000', '$00004000'),
    ('LM3S2139', 'LM3FURY', 'armv7m', 'soft', '$00000000', '$00010000', '$20000000', '$00004000'),
    ('LM3S6100', 'LM3FURY', 'armv7m', 'soft', '$00000000', '$00010000', '$20000000', '$00004000'),
    ('LM3S6110', 'LM3FURY', 'armv7m', 'soft', '$00000000', '$00010000', '$20000000', '$00004000'),
    ('LM3S1601', 'LM3FURY', 'armv7m', 'soft', '$00000000', '$00020000', '$20000000', '$00008000'),
    ('LM3S1608', 'LM3FURY', 'armv7m', 'soft', '$00000000', '$00020000', '$20000000', '$00008000'),
    ('LM3S1620', 'LM3FURY', 'armv7m', 'soft', '$00000000', '$00020000', '$20000000', '$00008000'),
    ('LM3S1635', 'LM3FURY', 'armv7m', 'soft', '$00000000', '$00020000', '$20000000', '$00008000'),
    ('LM3S1636', 'LM3FURY', 'armv7m', 'soft', '$00000000', '$00020000', '$20000000', '$00008000'),
    ('LM3S1637', 'LM3FURY', 'armv7m', 'soft', '$00000000', '$00020000', '$20000000', '$00008000'),
    ('LM3S1651', 'LM3FURY', 'armv7m', 'soft', '$00000000', '$00020000', '$20000000', '$00008000'),
    ('LM3S2601', 'LM3FURY', 'armv7m', 'soft', '$00000000', '$00020000', '$20000000', '$00008000'),
    ('LM3S2608', 'LM3FURY', 'armv7m', 'soft', '$00000000', '$00020000', '$20000000', '$00008000'),
    ('LM3S2620', 'LM3FURY', 'armv7m', 'soft', '$00000000', '$00020000', '$20000000', '$00008000'),
    ('LM3S2637', 'LM3FURY', 'armv7m', 'soft', '$00000000', '$00020000', '$20000000', '$00008000'),
    ('LM3S2651', 'LM3FURY', 'armv7m', 'soft', '$00000000', '$00020000', '$20000000', '$00008000'),
    ('LM3S6610', 'LM3FURY', 'armv7m', 'soft', '$00000000', '$00020000', '$20000000', '$00008000'),
    ('LM3S6611', 'LM3FURY', 'armv7m', 'soft', '$00000000', '$00020000', '$20000000', '$00008000'),
    ('LM3S6618', 'LM3FURY', 'armv7m', 'soft', '$00000000', '$00020000', '$20000000', '$00008000'),
    ('LM3S6633', 'LM3FURY', 'armv7m', 'soft', '$00000000', '$00020000', '$20000000', '$00008000'),
    ('LM3S6637', 'LM3FURY', 'armv7m', 'soft', '$00000000', '$00020000', '$20000000', '$00008000'),
    ('LM3S8630', 'LM3FURY', 'armv7m', 'soft', '$00000000', '$00020000', '$20000000', '$00008000'),
    ('LM3S1911', 'LM3FURY', 'armv7m', 'soft', '$00000000', '$00040000', '$20000000', '$00010000'),
    ('LM3S1918', 'LM3FURY', 'armv7m', 'soft', '$00000000', '$00040000', '$20000000', '$00010000'),
    ('LM3S1937', 'LM3FURY', 'armv7m', 'soft', '$00000000', '$00040000', '$20000000', '$00010000'),
    ('LM3S1958', 'LM3FURY', 'armv7m', 'soft', '$00000000', '$00040000', '$20000000', '$00010000'),
    ('LM3S1960', 'LM3FURY', 'armv7m', 'soft', '$00000000', '$00040000', '$20000000', '$00010000'),
    ('LM3S1968', 'LM3FURY', 'armv7m', 'soft', '$00000000', '$00040000', '$20000000', '$00010000'),
    ('LM3S1969', 'LM3FURY', 'armv7m', 'soft', '$00000000', '$00040000', '$20000000', '$00010000'),
    ('LM3S2911', 'LM3FURY', 'armv7m', 'soft', '$00000000', '$00040000', '$20000000', '$00010000'),
    ('LM3S2918', 'LM3FURY', 'armv7m', 'soft', '$00000000', '$00040000', '$20000000', '$00010000'),
    ('LM3S2919', 'LM3FURY', 'armv7m', 'soft', '$00000000', '$00040000', '$20000000', '$00010000'),
    ('LM3S2939', 'LM3FURY', 'armv7m', 'soft', '$00000000', '$00040000', '$20000000', '$00010000'),
    ('LM3S2948', 'LM3FURY', 'armv7m', 'soft', '$00000000', '$00040000', '$20000000', '$00010000'),
    ('LM3S2950', 'LM3FURY', 'armv7m', 'soft', '$00000000', '$00040000', '$20000000', '$00010000'),
    ('LM3S2965', 'LM3FURY', 'armv7m', 'soft', '$00000000', '$00040000', '$20000000', '$00010000'),
    ('LM3S6911', 'LM3FURY', 'armv7m', 'soft', '$00000000', '$00040000', '$20000000', '$00010000'),
    ('LM3S6918', 'LM3FURY', 'armv7m', 'soft', '$00000000', '$00040000', '$20000000', '$00010000'),
    ('LM3S6938', 'LM3FURY', 'armv7m', 'soft', '$00000000', '$00040000', '$20000000', '$00010000'),
    ('LM3S6950', 'LM3FURY', 'armv7m', 'soft', '$00000000', '$00040000', '$20000000', '$00010000'),
    ('LM3S6952', 'LM3FURY', 'armv7m', 'soft', '$00000000', '$00040000', '$20000000', '$00010000'),
    ('LM3S6965', 'LM3FURY', 'armv7m', 'soft', '$00000000', '$00040000', '$20000000', '$00010000'),
    ('LM3S8930', 'LM3FURY', 'armv7m', 'soft', '$00000000', '$00040000', '$20000000', '$00010000'),
    ('LM3S8933', 'LM3FURY', 'armv7m', 'soft', '$00000000', '$00040000', '$20000000', '$00010000'),
    ('LM3S8938', 'LM3FURY', 'armv7m', 'soft', '$00000000', '$00040000', '$20000000', '$00010000'),
    ('LM3S8962', 'LM3FURY', 'armv7m', 'soft', '$00000000', '$00040000', '$20000000', '$00010000'),
    ('LM3S8970', 'LM3FURY', 'armv7m', 'soft', '$00000000', '$00040000', '$20000000', '$00010000'),
    ('LM3S8971', 'LM3FURY', 'armv7m', 'soft', '$00000000', '$00040000', '$20000000', '$00010000'),
    ('LM3S5951', 'LM3TEMPEST', 'armv7m', 'soft', '$00000000', '$00040000', '$20000000', '$00010000'),
    ('LM3S5956', 'LM3TEMPEST', 'armv7m', 'soft', '$00000000', '$00040000', '$20000000', '$00010000'),
    ('LM3S1B21', 'LM3TEMPEST', 'armv7m', 'soft', '$00000000', '$00040000', '$20000000', '$00018000'),
    ('LM3S2B93', 'LM3TEMPEST', 'armv7m', 'soft', '$00000000', '$00040000', '$20000000', '$00018000'),
    ('LM3S5B91', 'LM3TEMPEST', 'armv7m', 'soft', '$00000000', '$00040000', '$20000000', '$00018000'),
    ('LM3S9B81', 'LM3TEMPEST', 'armv7m', 'soft', '$00000000', '$00040000', '$20000000', '$00018000'),
    ('LM3S9B90', 'LM3TEMPEST', 'armv7m', 'soft', '$00000000', '$00040000', '$20000000', '$00018000'),
    ('LM3S9B92', 'LM3TEMPEST', 'armv7m', 'soft', '$00000000', '$00040000', '$20000000', '$00018000'),
    ('LM3S9B95', 'LM3TEMPEST', 'armv7m', 'soft', '$00000000', '$00040000', '$20000000', '$00018000'),
    ('LM3S9B96', 'LM3TEMPEST', 'armv7m', 'soft', '$00000000', '$00040000', '$20000000', '$00018000'),
    ('LM3S5D51', 'LM3TEMPEST', 'armv7m', 'soft', '$00000000', '$00080000', '$20000000', '$00018000'),
    ('LM4F120H5', 'LM4F120', 'armv7em', 'soft', '$00000000', '$00040000', '$20000000', '$00008000'),
    ('SC32442B', 'SC32442b', 'armv4t', 'soft', '$00000000', '$00000000', '$00000000', '$08000000'),
    ('XMC4500X1024', 'XMC4500', 'armv7em', 'soft', '$08000000', '$00100000', '$20000000', '$00010000'),
    ('XMC4500X768', 'XMC4500', 'armv7em', 'soft', '$08000000', '$000C0000', '$20000000', '$00010000'),
    ('XMC4502X768', 'XMC4502', 'armv7em', 'soft', '$08000000', '$000C0000', '$20000000', '$00010000'),
    ('XMC4504X512', 'XMC4504', 'armv7em', 'soft', '$08000000', '$00080000', '$20000000', '$00010000'),
    ('ALLWINNER_A20', 'ALLWINNER_A20', 'armv7a', 'vfpv4', '$00000000', '$00000000', '$40000000', '$80000000'),
    ('MK20DX128VFM5', 'MK20D5', 'armv7em', 'soft', '$00000000', '$00020000', '$20000000', '$00002000'),
    ('MK20DX128VFT5', 'MK20D5', 'armv7em', 'soft', '$00000000', '$00020000', '$20000000', '$00002000'),
    ('MK20DX128VLF5', 'MK20D5', 'armv7em', 'soft', '$00000000', '$00020000', '$20000000', '$00002000'),
    ('MK20DX128VLH5', 'MK20D5', 'armv7em', 'soft', '$00000000', '$00020000', '$20000000', '$00002000'),
    ('TEENSY30', 'MK20D5', 'armv7em', 'soft', '$00000000', '$00020000', '$20000000', '$00002000'),
    ('MK20DX128VMP5', 'MK20D5', 'armv7em', 'soft', '$00000000', '$00020000', '$20000000', '$00002000'),
    ('MK20DX32VFM5', 'MK20D5', 'armv7em', 'soft', '$00000000', '$00008000', '$20000000', '$00001000'),
    ('MK20DX32VFT5', 'MK20D5', 'armv7em', 'soft', '$00000000', '$00008000', '$20000000', '$00001000'),
    ('MK20DX32VLF5', 'MK20D5', 'armv7em', 'soft', '$00000000', '$00008000', '$20000000', '$00001000'),
    ('MK20DX32VLH5', 'MK20D5', 'armv7em', 'soft', '$00000000', '$00008000', '$20000000', '$00001000'),
    ('MK20DX32VMP5', 'MK20D5', 'armv7em', 'soft', '$00000000', '$00008000', '$20000000', '$00001000'),
    ('MK20DX64VFM5', 'MK20D5', 'armv7em', 'soft', '$00000000', '$00010000', '$20000000', '$00002000'),
    ('MK20DX64VFT5', 'MK20D5', 'armv7em', 'soft', '$00000000', '$00010000', '$20000000', '$00002000'),
    ('MK20DX64VLF5', 'MK20D5', 'armv7em', 'soft', '$00000000', '$00010000', '$20000000', '$00002000'),
    ('MK20DX64VLH5', 'MK20D5', 'armv7em', 'soft', '$00000000', '$00010000', '$20000000', '$00002000'),
    ('MK20DX64VMP5', 'MK20D5', 'armv7em', 'soft', '$00000000', '$00010000', '$20000000', '$00002000'),
    ('MK20DX128VLH7', 'MK20D7', 'armv7em', 'soft', '$00000000', '$00020000', '$20000000', '$00004000'),
    ('MK20DX128VLK7', 'MK20D7', 'armv7em', 'soft', '$00000000', '$00020000', '$20000000', '$00004000'),
    ('MK20DX128VLL7', 'MK20D7', 'armv7em', 'soft', '$00000000', '$00020000', '$20000000', '$00004000'),
    ('MK20DX128VMC7', 'MK20D7', 'armv7em', 'soft', '$00000000', '$00020000', '$20000000', '$00004000'),
    ('MK20DX256VLH7', 'MK20D7', 'armv7em', 'soft', '$00000000', '$00040000', '$20000000', '$00008000'),
    ('MK20DX256VLK7', 'MK20D7', 'armv7em', 'soft', '$00000000', '$00040000', '$20000000', '$00008000'),
    ('MK20DX256VLL7', 'MK20D7', 'armv7em', 'soft', '$00000000', '$00040000', '$20000000', '$00008000'),
    ('MK20DX256VMC7', 'MK20D7', 'armv7em', 'soft', '$00000000', '$00040000', '$20000000', '$00008000'),
    ('TEENSY31', 'MK20D7', 'armv7em', 'soft', '$00000000', '$00040000', '$20000000', '$00008000'),
    ('TEENSY32', 'MK20D7', 'armv7em', 'soft', '$00000000', '$00040000', '$20000000', '$00008000'),
    ('MK20DX64VLH7', 'MK20D7', 'armv7em', 'soft', '$00000000', '$00010000', '$20000000', '$00002000'),
    ('MK20DX64VLK7', 'MK20D7', 'armv7em', 'soft', '$00000000', '$00010000', '$20000000', '$00002000'),
    ('MK20DX64VMC7', 'MK20D7', 'armv7em', 'soft', '$00000000', '$00010000', '$20000000', '$00002000'),
    ('MK22FN512CAP12', 'MK22F51212', 'armv7em', 'soft', '$00000000', '$00080000', '$20000000', '$00010000'),
    ('MK22FN512CBP12', 'MK22F51212', 'armv7em', 'soft', '$00000000', '$00080000', '$20000000', '$00010000'),
    ('MK22FN512VDC12', 'MK22F51212', 'armv7em', 'soft', '$00000000', '$00080000', '$20000000', '$00010000'),
    ('MK22FN512VLH12', 'MK22F51212', 'armv7em', 'soft', '$00000000', '$00080000', '$20000000', '$00010000'),
    ('MK22FN512VLL12', 'MK22F51212', 'armv7em', 'soft', '$00000000', '$00080000', '$20000000', '$00010000'),
    ('MK22FN512VMP12', 'MK22F51212', 'armv7em', 'soft', '$00000000', '$00080000', '$20000000', '$00010000'),
    ('FREEDOM_K22F', 'MK22F51212', 'armv7em', 'soft', '$00000000', '$00080000', '$20000000', '$00010000'),
    ('MK64FN1M0VDC12', 'MK64F12', 'armv7em', 'soft', '$00000000', '$00100000', '$20000000', '$00030000'),
    ('MK64FN1M0VLL12', 'MK64F12', 'armv7em', 'soft', '$00000000', '$00100000', '$20000000', '$00030000'),
    ('FREEDOM_K64F', 'MK64F12', 'armv7em', 'soft', '$00000000', '$00100000', '$20000000', '$00030000'),
    ('MK64FN1M0VLQ12', 'MK64F12', 'armv7em', 'soft', '$00000000', '$00100000', '$20000000', '$00030000'),
    ('MK64FN1M0VMD12', 'MK64F12', 'armv7em', 'soft', '$00000000', '$00100000', '$20000000', '$00030000'),
    ('MK64FX512VDC12', 'MK64F12', 'armv7em', 'soft', '$00000000', '$00080000', '$20000000', '$00020000'),
    ('MK64FX512VLL12', 'MK64F12', 'armv7em', 'soft', '$00000000', '$00080000', '$20000000', '$00020000'),
    ('MK64FX512VLQ12', 'MK64F12', 'armv7em', 'soft', '$00000000', '$00080000', '$20000000', '$00020000'),
    ('MK64FX512VMD12', 'MK64F12', 'armv7em', 'soft', '$00000000', '$00080000', '$20000000', '$00020000'),
    ('ATSAM3X8E', 'SAM3X8E', 'armv7m', 'soft', '$00080000', '$00040000', '$20000000', '$00010000'),
    ('SAMD51P19A', 'SAMD51P19A', 'armv7em', 'fpv4_sp_d16', '$00000000', '$00080000', '$20000000', '$00030000'),
    ('ARDUINO_DUE', 'SAM3X8E', 'armv7m', 'soft', '$00080000', '$00040000', '$20000000', '$00010000'),
    ('FLIP_N_CLICK', 'SAM3X8E', 'armv7m', 'soft', '$00080000', '$00040000', '$20000000', '$00010000'),
    ('WIO_TERMINAL', 'SAMD51P19A', 'armv7em', 'fpv4_sp_d16', '$00004000', '$0007C000', '$20000000', '$00030000'),
    ('NRF51422_XXAA', 'NRF51', 'armv6m', 'soft', '$00000000', '$00040000', '$20000000', '$00004000'),
    ('NRF51422_XXAB', 'NRF51', 'armv6m', 'soft', '$00000000', '$00020000', '$20000000', '$00004000'),
    ('NRF51422_XXAC', 'NRF51', 'armv6m', 'soft', '$00000000', '$00040000', '$20000000', '$00008000'),
    ('NRF51822_XXAA', 'NRF51', 'armv6m', 'soft', '$00000000', '$00040000', '$20000000', '$00004000'),
    ('NRF51822_XXAB', 'NRF51', 'armv6m', 'soft', '$00000000', '$00020000', '$20000000', '$00004000'),
    ('NRF51822_XXAC', 'NRF51', 'armv6m', 'soft', '$00000000', '$00040000', '$20000000', '$00008000'),
    ('NRF52832_XXAA', 'NRF52', 'armv7em', 'soft', '$00000000', '$00080000', '$20000000', '$00010000'),
    ('NRF52840_XXAA', 'NRF52', 'armv7em', 'soft', '$00000000', '$00080000', '$20000000', '$00010000'),
    ('RASPI2', 'RASPI2', 'armv7a', 'vfpv4', '$00000000', '$00000000', '$00008000', '$10000000'),
    ('THUMB2_BARE', 'THUMB2_BARE', 'armv7m', 'soft', '$00000000', '$00002000', '$20000000', '$00000400'));

type
  Tz80_ControllerDataList = array of array of String;

const
  z80_ControllerDataList : Tz80_ControllerDataList = (
    ('controllertypestr', 'controllerunitstr', 'cputype', 'fputype', 'flashbase', 'flashsize', 'srambase', 'sramsize', 'eeprombase', 'eepromsize', 'bootbase', 'bootsize'));

type
  Twasm32_ControllerDataList = array of array of String;

const
  wasm32_ControllerDataList : Twasm32_ControllerDataList = (
    ('controllertypestr', 'controllerunitstr', 'cputype', 'fputype', 'flashbase', 'flashsize', 'srambase', 'sramsize', 'eeprombase', 'eepromsize', 'bootbase', 'bootsize'));

type
  Txtensa_ControllerDataList = array of array of String;

const
  xtensa_ControllerDataList : Txtensa_ControllerDataList = (
    ('controllertypestr', 'controllerunitstr', 'cputype', 'fputype', 'abi', 'flashbase', 'flashsize', 'srambase', 'sramsize', 'eeprombase', 'eepromsize', 'bootbase', 'bootsize'),
    ('ESP8266', 'ESP8266', 'lx106', 'soft', 'abi_xtensa_call0', '$40000000', '1024', '$40070000', '520'),
    ('ESP32', 'ESP32', 'lx6', 'hard', 'abi_xtensa_windowed', '$40000000', '2'),
    ('ESP32_D0WD', 'ESP32_D0WD', 'lx6', 'hard', 'abi_xtensa_windowed', '$40000000', '448', '$40070000', '520'),
    ('ESP32_D2WD', 'ESP32_D2WD', 'lx6', 'hard', 'abi_xtensa_windowed', '$40000000', '448', '$40070000', '520'),
    ('ESP32_S0WD', 'ESP32_S0WD', 'lx6', 'hard', 'abi_xtensa_windowed', '$40000000', '448', '$40070000', '520'));

type
  Triscv32_ControllerDataList = array of array of String;

const
  riscv32_ControllerDataList : Triscv32_ControllerDataList = (
    ('controllertypestr', 'controllerunitstr', 'cputype', 'fputype', 'flashbase', 'flashsize', 'srambase', 'sramsize', 'eeprombase', 'eepromsize', 'bootbase', 'bootsize'),
    ('FE310G000', 'FE310G000', 'rv32imac', 'none', '$20400000', '$01000000', '$80000000', '$00004000'),
    ('FE310G002', 'FE310G002', 'rv32imac', 'none', '$20010000', '$00400000', '$80000000', '$00004000'),
    ('HIFIVE1', 'FE310G000', 'rv32imac', 'none', '$20400000', '$01000000', '$80000000', '$00004000'),
    ('HIFIVE1REVB', 'FE310G002', 'rv32imac', 'none', '$20010000', '$00400000', '$80000000', '$00004000'),
    ('REDFIVE', 'FE310G002', 'rv32imac', 'none', '$20010000', '$00400000', '$80000000', '$00004000'),
    ('REDFIVETHING', 'FE310G002', 'rv32imac', 'none', '$20010000', '$02400000', '$80000000', '$00004000'),
    ('GD32VF103C4', 'GD32VF103XX', 'rv32imac', 'none', '$08000000', '$00004000', '$20000000', '$00001800'),
    ('GD32VF103C6', 'GD32VF103XX', 'rv32imac', 'none', '$08000000', '$00008000', '$20000000', '$00002800'),
    ('GD32VF103C8', 'GD32VF103XX', 'rv32imac', 'none', '$08000000', '$00010000', '$20000000', '$00005000'),
    ('GD32VF103CB', 'GD32VF103XX', 'rv32imac', 'none', '$08000000', '$00020000', '$20000000', '$00008000'),
    ('GD32VF103R4', 'GD32VF103XX', 'rv32imac', 'none', '$08000000', '$00004000', '$20000000', '$00001800'),
    ('GD32VF103R6', 'GD32VF103XX', 'rv32imac', 'none', '$08000000', '$00008000', '$20000000', '$00002800'),
    ('GD32VF103R8', 'GD32VF103XX', 'rv32imac', 'none', '$08000000', '$00010000', '$20000000', '$00005000'),
    ('GD32VF103RB', 'GD32VF103XX', 'rv32imac', 'none', '$08000000', '$00020000', '$20000000', '$00008000'),
    ('GD32VF103T4', 'GD32VF103XX', 'rv32imac', 'none', '$08000000', '$00004000', '$20000000', '$00001800'),
    ('GD32VF103T6', 'GD32VF103XX', 'rv32imac', 'none', '$08000000', '$00008000', '$20000000', '$00002800'),
    ('GD32VF103T8', 'GD32VF103XX', 'rv32imac', 'none', '$08000000', '$00010000', '$20000000', '$00005000'),
    ('GD32VF103TB', 'GD32VF103XX', 'rv32imac', 'none', '$08000000', '$00020000', '$20000000', '$00008000'),
    ('GD32VF103V8', 'GD32VF103XX', 'rv32imac', 'none', '$08000000', '$00010000', '$20000000', '$00005000'),
    ('GD32VF103VB', 'GD32VF103XX', 'rv32imac', 'none', '$08000000', '$00020000', '$20000000', '$00008000'));

type
  Tjvm_ControllerDataList = array of array of String;

const
  jvm_ControllerDataList : Tjvm_ControllerDataList = (
    ('controllertypestr', 'controllerunitstr', 'cputype', 'fputype', 'flashbase', 'flashsize', 'srambase', 'sramsize', 'eeprombase', 'eepromsize', 'bootbase', 'bootsize'));

type
  Tsparc_ControllerDataList = array of array of String;

const
  sparc_ControllerDataList : Tsparc_ControllerDataList = (
    ('controllertypestr', 'controllerunitstr', 'cputype', 'fputype', 'flashbase', 'flashsize', 'srambase', 'sramsize', 'eeprombase', 'eepromsize', 'bootbase', 'bootsize'));

type
  Tm68k_ControllerDataList = array of array of String;

const
  m68k_ControllerDataList : Tm68k_ControllerDataList = (
    ('controllertypestr', 'controllerunitstr', 'cputype', 'fputype', 'flashbase', 'flashsize', 'srambase', 'sramsize', 'eeprombase', 'eepromsize', 'bootbase', 'bootsize'));

type
  Tmips_ControllerDataList = array of array of String;

const
  mips_ControllerDataList : Tmips_ControllerDataList = (
    ('controllertypestr', 'controllerunitstr', 'cputype', 'fputype', 'flashbase', 'flashsize', 'srambase', 'sramsize', 'eeprombase', 'eepromsize', 'bootbase', 'bootsize'),
    ('PIC32MX110F016B', 'PIC32MX1xxFxxxB', 'pic32mx', 'soft', '$9d000000', '$00004000', '$A0000000', '$00001000', '0', '0', '$BFC00000', '$00000BEF'),
    ('PIC32MX110F016C', 'PIC32MX1xxFxxxC', 'pic32mx', 'soft', '$9d000000', '$00004000', '$A0000000', '$00001000', '0', '0', '$BFC00000', '$00000BEF'),
    ('PIC32MX110F016D', 'PIC32MX1xxFxxxD', 'pic32mx', 'soft', '$9d000000', '$00004000', '$A0000000', '$00001000', '0', '0', '$BFC00000', '$00000BEF'),
    ('PIC32MX120F032B', 'PIC32MX1xxFxxxB', 'pic32mx', 'soft', '$9d000000', '$00008000', '$A0000000', '$00002000', '0', '0', '$BFC00000', '$00000BEF'),
    ('PIC32MX120F032C', 'PIC32MX1xxFxxxC', 'pic32mx', 'soft', '$9d000000', '$00008000', '$A0000000', '$00002000', '0', '0', '$BFC00000', '$00000BEF'),
    ('PIC32MX120F032D', 'PIC32MX1xxFxxxD', 'pic32mx', 'soft', '$9d000000', '$00008000', '$A0000000', '$00002000', '0', '0', '$BFC00000', '$00000BEF'),
    ('PIC32MX130F064B', 'PIC32MX1xxFxxxB', 'pic32mx', 'soft', '$9d000000', '$00010000', '$A0000000', '$00004000', '0', '0', '$BFC00000', '$00000BEF'),
    ('PIC32MX130F064C', 'PIC32MX1xxFxxxC', 'pic32mx', 'soft', '$9d000000', '$00010000', '$A0000000', '$00004000', '0', '0', '$BFC00000', '$00000BEF'),
    ('PIC32MX130F064D', 'PIC32MX1xxFxxxD', 'pic32mx', 'soft', '$9d000000', '$00010000', '$A0000000', '$00004000', '0', '0', '$BFC00000', '$00000BEF'),
    ('PIC32MX150F128B', 'PIC32MX1xxFxxxB', 'pic32mx', 'soft', '$9d000000', '$00020000', '$A0000000', '$00008000', '0', '0', '$BFC00000', '$00000BEF'),
    ('PIC32MX150F128C', 'PIC32MX1xxFxxxC', 'pic32mx', 'soft', '$9d000000', '$00020000', '$A0000000', '$00008000', '0', '0', '$BFC00000', '$00000BEF'),
    ('PIC32MX150F128D', 'PIC32MX1xxFxxxD', 'pic32mx', 'soft', '$9d000000', '$00020000', '$A0000000', '$00008000', '0', '0', '$BFC00000', '$00000BEF'),
    ('PIC32MX210F016B', 'PIC32MX2xxFxxxB', 'pic32mx', 'soft', '$9d000000', '$00004000', '$A0000000', '$00001000', '0', '0', '$BFC00000', '$00000BEF'),
    ('PIC32MX210F016C', 'PIC32MX2xxFxxxC', 'pic32mx', 'soft', '$9d000000', '$00004000', '$A0000000', '$00001000', '0', '0', '$BFC00000', '$00000BEF'),
    ('PIC32MX210F016D', 'PIC32MX2xxFxxxD', 'pic32mx', 'soft', '$9d000000', '$00004000', '$A0000000', '$00001000', '0', '0', '$BFC00000', '$00000BEF'),
    ('PIC32MX220F032B', 'PIC32MX2xxFxxxB', 'pic32mx', 'soft', '$9d000000', '$00008000', '$A0000000', '$00002000', '0', '0', '$BFC00000', '$00000BEF'),
    ('PIC32MX220F032C', 'PIC32MX2xxFxxxC', 'pic32mx', 'soft', '$9d000000', '$00008000', '$A0000000', '$00002000', '0', '0', '$BFC00000', '$00000BEF'),
    ('PIC32MX220F032D', 'PIC32MX2xxFxxxD', 'pic32mx', 'soft', '$9d000000', '$00008000', '$A0000000', '$00002000', '0', '0', '$BFC00000', '$00000BEF'),
    ('PIC32MX230F064B', 'PIC32MX2xxFxxxB', 'pic32mx', 'soft', '$9d000000', '$00010000', '$A0000000', '$00004000', '0', '0', '$BFC00000', '$00000BEF'),
    ('PIC32MX230F064C', 'PIC32MX2xxFxxxC', 'pic32mx', 'soft', '$9d000000', '$00010000', '$A0000000', '$00004000', '0', '0', '$BFC00000', '$00000BEF'),
    ('PIC32MX230F064D', 'PIC32MX2xxFxxxD', 'pic32mx', 'soft', '$9d000000', '$00010000', '$A0000000', '$00004000', '0', '0', '$BFC00000', '$00000BEF'),
    ('PIC32MX250F128B', 'PIC32MX2xxFxxxB', 'pic32mx', 'soft', '$9d000000', '$00020000', '$A0000000', '$00008000', '0', '0', '$BFC00000', '$00000BEF'),
    ('PIC32MX250F128C', 'PIC32MX2xxFxxxC', 'pic32mx', 'soft', '$9d000000', '$00020000', '$80000000', '$00008000', '0', '0', '$BFC00000', '$00000BEF'),
    ('PIC32MX250F128D', 'PIC32MX2xxFxxxD', 'pic32mx', 'soft', '$9d000000', '$00020000', '$A0000000', '$00008000', '0', '0', '$BFC00000', '$00000BEF'),
    ('PIC32MX775F256H', 'PIC32MX7x5FxxxH', 'pic32mx', 'soft', '$9d000000', '$00040000', '$A0000000', '$00010000', '0', '0', '$BFC00000', '$00002FEF'),
    ('PIC32MX775F256L', 'PIC32MX7x5FxxxL', 'pic32mx', 'soft', '$9d000000', '$00040000', '$A0000000', '$00010000', '0', '0', '$BFC00000', '$00002FEF'),
    ('PIC32MX775F512H', 'PIC32MX7x5FxxxH', 'pic32mx', 'soft', '$9d000000', '$00080000', '$A0000000', '$00010000', '0', '0', '$BFC00000', '$00002FEF'),
    ('PIC32MX775F512L', 'PIC32MX7x5FxxxL', 'pic32mx', 'soft', '$9d000000', '$00080000', '$A0000000', '$00010000', '0', '0', '$BFC00000', '$00002FEF'),
    ('PIC32MX795F512H', 'PIC32MX7x5FxxxH', 'pic32mx', 'soft', '$9d000000', '$00080000', '$A0000000', '$00020000', '0', '0', '$BFC00000', '$00002FEF'),
    ('PIC32MX795F512L', 'PIC32MX7x5FxxxL', 'pic32mx', 'soft', '$9d000000', '$00080000', '$A0000000', '$00020000', '0', '0', '$BFC00000', '$00002FEF'));

type
  Ti386_ControllerDataList = array of array of String;

const
  i386_ControllerDataList : Ti386_ControllerDataList = (
    ('controllertypestr', 'controllerunitstr', 'cputype', 'fputype', 'flashbase', 'flashsize', 'srambase', 'sramsize', 'eeprombase', 'eepromsize', 'bootbase', 'bootsize'));

type
  Tsparc64_ControllerDataList = array of array of String;

const
  sparc64_ControllerDataList : Tsparc64_ControllerDataList = (
    ('controllertypestr', 'controllerunitstr', 'cputype', 'fputype', 'flashbase', 'flashsize', 'srambase', 'sramsize', 'eeprombase', 'eepromsize', 'bootbase', 'bootsize'));

implementation

begin
end.
