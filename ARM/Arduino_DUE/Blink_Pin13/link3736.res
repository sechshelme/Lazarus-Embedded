SEARCH_DIR("/home/tux/fpcupdeluxe_stm32/cross/lib/arm-embedded/armv7m/")
SEARCH_DIR("./")
SEARCH_DIR("/home/tux/fpcupdeluxe_stm32/fpc/units/arm-embedded/rtl/")
SEARCH_DIR("/home/tux/fpcupdeluxe_stm32/fpc/units/arm-embedded/rtl-extra/")
SEARCH_DIR("/home/tux/fpcupdeluxe_stm32/fpc/units/arm-embedded/")
SEARCH_DIR("/home/tux/fpcupdeluxe_stm32/fpc/bin/x86_64-linux/")
INPUT (
/n4800/DATEN/Programmierung/Lazarus/Tutorials/Embedded/ARM/Arduino_DUE/Blink_Pin13/lib/arm-embedded/Project1.o
/home/tux/fpcupdeluxe_stm32/fpc/units/arm-embedded/rtl/system.o
/home/tux/fpcupdeluxe_stm32/fpc/units/arm-embedded/rtl/objpas.o
/home/tux/fpcupdeluxe_stm32/fpc/units/arm-embedded/rtl/sam3x8e.o
/home/tux/fpcupdeluxe_stm32/fpc/units/arm-embedded/rtl/cortexm3.o
)
ENTRY(_START)
MEMORY
{
    flash : ORIGIN = 0x00080000, LENGTH = 0x00040000
    ram : ORIGIN = 0x20000000, LENGTH = 0x00010000
}
_stack_top = 0x20010000;
SECTIONS
{
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
