	.file "blink.pp"
# Begin asmlist al_procedures

.section .text.n_main,"ax"
	.balign 4
.Lj3:
	.long	U_$P$BLINK_$$_CFG
.Lj4:
	.long	U_$P$BLINK_$$_CFG+4
.Lj5:
	.long	U_$P$BLINK_$$_CFG+6
.Lj6:
	.long	U_$P$BLINK_$$_CFG+8
.Lj7:
	.long	U_$P$BLINK_$$_CFG+10
	.balign 4
.globl	main
main:
.globl	PASCALMAIN
PASCALMAIN:
#   Start of abi_call0 entry localsize=0
#  Decreasing stack pointer by localsize=16 using A8 register
	addi	a1,a1,-16
#  Storing reg a12 at offset=12
	s32i	a12,a1,12
#  Storing reg a0 at offset=8
	s32i	a0,a1,8
	call0	FPC_INIT_FUNC_TABLE
	movi	a2,4
	l32r	a3,.Lj3
	s32i	a2,a3,0
	movi	a2,1
	l32r	a3,.Lj4
	s16i	a2,a3,0
	movi	a2,0
	l32r	a3,.Lj5
	s16i	a2,a3,0
	movi	a2,0
	l32r	a3,.Lj6
	s16i	a2,a3,0
	movi	a2,0
	l32r	a3,.Lj7
	s16i	a2,a3,0
	l32r	a2,.Lj3
	call0	gpio_config
	movi	a3,2
	movi	a2,2
	call0	gpio_set_direction
.Lj8:
	call0	fpc_get_output
	mov		a12,a2
	mov		a3,a12
	movi	a4,46
	movi	a2,0
	call0	fpc_write_text_char
	call0	fpc_iocheck
	mov		a2,a12
	call0	fpc_writeln_end
	call0	fpc_iocheck
	movi	a3,0
	movi	a2,2
	call0	gpio_set_level
	movi	a2,100
	call0	vTaskDelay
	call0	fpc_get_output
	mov		a12,a2
	mov		a3,a12
	movi	a4,42
	movi	a2,0
	call0	fpc_write_text_char
	call0	fpc_iocheck
	mov		a2,a12
	call0	fpc_writeln_end
	call0	fpc_iocheck
	movi	a3,1
	movi	a2,2
	call0	gpio_set_level
	movi	a2,100
	call0	vTaskDelay
	j		.Lj8
	call0	fpc_do_exit
#  Restoring reg a12 from offset=12
	l32i	a12,a1,12
#  Restoring reg a0 from offset=8
	l32i	a0,a1,8
#  Restoring stack pointer
	addi	a1,a1,16
	ret
.Le0:
	.size	main, .Le0 - main

.section .text.n_FPC_INIT_FUNC_TABLE,"ax"
.globl	FPC_INIT_FUNC_TABLE
FPC_INIT_FUNC_TABLE:
	.balign 4
	addi	a1,a1,-16
	s32i	a0,a1,12
	call0	INIT$_$SYSTEM
	call0	INIT$_$CONSOLEIO
	call0	INIT$_$HEAPMGR
	call0	INIT$_$ESP8266
	l32i	a0,a1,12
	addi	a1,a1,16
	ret

.section .text.n_FPC_FINALIZE_FUNC_TABLE,"ax"
.globl	FPC_FINALIZE_FUNC_TABLE
FPC_FINALIZE_FUNC_TABLE:
	.balign 4
	addi	a1,a1,-16
	s32i	a0,a1,12
	call0	FINALIZE$_$CONSOLEIO
	l32i	a0,a1,12
	addi	a1,a1,16
	ret
# End asmlist al_procedures
# Begin asmlist al_globals

.section .bss.n_u_$p$blink_$$_cfg,"aw",%nobits
	.balign 4
	.size U_$P$BLINK_$$_CFG,12
U_$P$BLINK_$$_CFG:
	.zero 12

.section .data.n_INITFINAL
	.balign 4
.globl	INITFINAL
INITFINAL:
	.long	4,0
	.long	INIT$_$SYSTEM
	.long	0
	.long	INIT$_$CONSOLEIO
	.long	FINALIZE$_$CONSOLEIO
	.long	INIT$_$HEAPMGR
	.long	0
	.long	INIT$_$ESP8266
	.long	0
.Le1:
	.size	INITFINAL, .Le1 - INITFINAL

.section .data.n_FPC_THREADVARTABLES
	.balign 4
.globl	FPC_THREADVARTABLES
FPC_THREADVARTABLES:
	.long	1
	.long	THREADVARLIST_$SYSTEM$indirect
.Le2:
	.size	FPC_THREADVARTABLES, .Le2 - FPC_THREADVARTABLES

.section .data.n_FPC_RESOURCESTRINGTABLES
	.balign 4
.globl	FPC_RESOURCESTRINGTABLES
FPC_RESOURCESTRINGTABLES:
	.long	0
.Le3:
	.size	FPC_RESOURCESTRINGTABLES, .Le3 - FPC_RESOURCESTRINGTABLES

.section .data.n_FPC_WIDEINITTABLES
	.balign 4
.globl	FPC_WIDEINITTABLES
FPC_WIDEINITTABLES:
	.long	0
.Le4:
	.size	FPC_WIDEINITTABLES, .Le4 - FPC_WIDEINITTABLES

.section .data.n_FPC_RESSTRINITTABLES
	.balign 4
.globl	FPC_RESSTRINITTABLES
FPC_RESSTRINITTABLES:
	.long	0
.Le5:
	.size	FPC_RESSTRINITTABLES, .Le5 - FPC_RESSTRINITTABLES

.section .fpc.n_version,"aw"
	.balign 4
__fpc_ident:
	.ascii	"FPC 3.3.1-9884-g307c284f6a [2022/01/08] for xtensa "
	.ascii	"- freertos"
.Le6:
	.size	__fpc_ident, .Le6 - __fpc_ident

.section .data.n___stklen
	.balign 4
.globl	__stklen
__stklen:
	.long	65536
.Le7:
	.size	__stklen, .Le7 - __stklen

.section .data.n___heapsize
	.balign 4
.globl	__heapsize
__heapsize:
	.long	0
.Le8:
	.size	__heapsize, .Le8 - __heapsize

.section .bss.n___fpc_initialheap,"aw",%nobits
	.balign 4
	.globl __fpc_initialheap
	.size __fpc_initialheap,4
__fpc_initialheap:
	.zero 4

.section .data.n___fpc_valgrind
	.balign 4
.globl	__fpc_valgrind
__fpc_valgrind:
	.byte	0
.Le9:
	.size	__fpc_valgrind, .Le9 - __fpc_valgrind
# End asmlist al_globals

