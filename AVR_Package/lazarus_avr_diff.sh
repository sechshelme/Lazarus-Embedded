#!/bin/bash
diff -up fpcupdeluxe_avr_original_2/lazarus/components/ideintf/compoptsintf.pas fpcupdeluxe_avrpackage/lazarus/components/ideintf/compoptsintf.pas > lazarus_avr.patch
diff -up fpcupdeluxe_avr_original_2/lazarus/ide/compileroptions.pp fpcupdeluxe_avrpackage/lazarus/ide/compileroptions.pp >> lazarus_avr.patch
diff -up fpcupdeluxe_avr_original_2/lazarus/ide/project.pp fpcupdeluxe_avrpackage/lazarus/ide/project.pp >> test.patch
