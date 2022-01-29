SEARCH_DIR("/home/tux/fpcupdeluxe_pico/cross/lib/arm-embedded/armv6m/eabi/")
SEARCH_DIR("/n4800/DATEN/Programmierung/Lazarus/Tutorials/Embedded/ARM/Raspberry_pico/Fremdes/pico-fpcexamples-main/units/")
SEARCH_DIR("./")
SEARCH_DIR("/home/tux/fpcupdeluxe_pico/fpc/units/arm-embedded/armv6m/eabi/rtl/")
SEARCH_DIR("/home/tux/fpcupdeluxe_pico/fpc/units/arm-embedded/armv6m/")
SEARCH_DIR("/home/tux/fpcupdeluxe_pico/fpc/units/arm-embedded/")
SEARCH_DIR("/home/tux/fpcupdeluxe_pico/fpc/bin/x86_64-linux/")
INPUT (
/n4800/DATEN/Programmierung/Lazarus/Tutorials/Embedded/ARM/Raspberry_pico/blank/lib/arm-embedded/Project1.o
/n4800/DATEN/Programmierung/Lazarus/Tutorials/Embedded/ARM/Raspberry_pico/Fremdes/pico-fpcexamples-main/units/platform.c.obj
/n4800/DATEN/Programmierung/Lazarus/Tutorials/Embedded/ARM/Raspberry_pico/Fremdes/pico-fpcexamples-main/units/claim.c.obj
/n4800/DATEN/Programmierung/Lazarus/Tutorials/Embedded/ARM/Raspberry_pico/Fremdes/pico-fpcexamples-main/units/clocks.c.obj
/n4800/DATEN/Programmierung/Lazarus/Tutorials/Embedded/ARM/Raspberry_pico/Fremdes/pico-fpcexamples-main/units/xosc.c.obj
/home/tux/fpcupdeluxe_pico/fpc/units/arm-embedded/armv6m/eabi/rtl/system.o
/home/tux/fpcupdeluxe_pico/fpc/units/arm-embedded/armv6m/eabi/rtl/objpas.o
/home/tux/fpcupdeluxe_pico/fpc/units/arm-embedded/armv6m/eabi/rtl/rp2040.o
/n4800/DATEN/Programmierung/Lazarus/Tutorials/Embedded/ARM/Raspberry_pico/Fremdes/pico-fpcexamples-main/units/libgcc-armv6m.a
)
ENTRY(_START)
MEMORY
{
    flash : ORIGIN = 0x10000000, LENGTH = 0x00200000
    ram : ORIGIN = 0x20000000, LENGTH = 0x00042000
}
_stack_top = 0x20042000;
SECTIONS
{
    .boot2 :
    {
    _boot2_start = .;
    KEEP(*(.boot2))
    ASSERT(!( . == _boot2_start ), "RP2040: Error, a device specific 2nd stage bootloader is required for booting");
    ASSERT(( . == _boot2_start + 256 ), "RP2040: Error, 2nd stage bootloader in section .boot2 is required to be 256 bytes");
    } >flash
     .text :
    {
    _text_start = .;
    KEEP(*(.init .init.*))
    *(.text .text.*)
    *(.strings)
    *(.rodata .rodata.*)
    *(.comment)
    . = ALIGN(4);
    _etext = .;
    } >flash
    .note.gnu.build-id : { *(.note.gnu.build-id) } >flash 
    .data :
    {
    _data = .;
    *(.data .data.*)
    *(.time_critical*)
    KEEP (*(.fpc .fpc.n_version .fpc.n_links))
    _edata = .;
    } >ram AT >flash
    .bss :
    {
    _bss_start = .;
    *(.bss .bss.*)
    *(COMMON)
    } >ram
. = ALIGN(4);
_bss_end = . ;
}
_end = .;
