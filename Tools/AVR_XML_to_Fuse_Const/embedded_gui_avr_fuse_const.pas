// Diese Unit wird durch das Tool "AVR_XML_to_Fuse_Const" generiert

unit Embedded_GUI_AVR_Fuse_Const;

interface

type
  TAVR_Fuse_Data = array of record
    Name: String;
    Fuses: array of record
      Caption, FuseName: String;
      ofs: Byte;
      BitField: array of record
        Caption, Name: String;
        Mask: Byte;
        Values: array of record
          Caption, Name: String;
          Value: Byte;
        end;
      end;
    end;
  end;

const
  AVR_Fuse_Data: TAVR_Fuse_Data = ((
    Name: 'ATmega32HVBrevB';
    Fuses:(
     (Caption: 'LOW'; FuseName: 'lfuse'; ofs: $00; BitField:(
        (Caption: 'Watch-dog Timer always on'; Name: 'WDTON'; Mask: $80; Values: ()),
        (Caption: 'Preserve EEPROM through the Chip Erase cycle'; Name: 'EESAVE'; Mask: $40; Values: ()),
        (Caption: 'Serial program downloading (SPI) enabled'; Name: 'SPIEN'; Mask: $20; Values: ()),
        (Caption: 'Select start-up time'; Name: 'SUT'; Mask: $1C; Values: (
          (Caption: 'Start-up time 14 CK + 4 ms'; Name: '14CK_4MS'; Value: $00),
          (Caption: 'Start-up time 14 CK + 8 ms'; Name: '14CK_8MS'; Value: $01),
          (Caption: 'Start-up time 14 CK + 16 ms'; Name: '14CK_16MS'; Value: $02),
          (Caption: 'Start-up time 14 CK + 32 ms'; Name: '14CK_32MS'; Value: $03),
          (Caption: 'Start-up time 14 CK + 64 ms'; Name: '14CK_64MS'; Value: $04),
          (Caption: 'Start-up time 14 CK + 128 ms'; Name: '14CK_128MS'; Value: $05),
          (Caption: 'Start-up time 14 CK + 256 ms'; Name: '14CK_256MS'; Value: $06),
          (Caption: 'Start-up time 14 CK + 512 ms'; Name: '14CK_512MS'; Value: $07),
        (Caption: 'Oscillator select'; Name: 'OSCSEL'; Mask: $03; Values: (
          (Caption: 'Default'; Name: 'DEFAULT'; Value: $01))),
     (Caption: 'HIGH'; FuseName: 'hfuse'; ofs: $01; BitField:(
        (Caption: 'DUVR mode on'; Name: 'DUVRDINIT'; Mask: $10; Values: ()),
        (Caption: 'Debug Wire enable'; Name: 'DWEN'; Mask: $08; Values: ()),
        (Caption: 'Select Boot Size'; Name: 'BOOTSZ'; Mask: $06; Values: (
          (Caption: 'Boot Flash size=256 words Boot address=$3F00'; Name: '256W_3F00'; Value: $03),
          (Caption: 'Boot Flash size=512 words Boot address=$3E00'; Name: '512W_3E00'; Value: $02),
          (Caption: 'Boot Flash size=1024 words Boot address=$3C00'; Name: '1024W_3C00'; Value: $01),
          (Caption: 'Boot Flash size=2048 words Boot address=$3800'; Name: '2048W_3800'; Value: $00),
        (Caption: 'Boot Reset vector Enabled'; Name: 'BOOTRST'; Mask: $01; Values: ()))),
     (Caption: 'LOCKBIT'; FuseName: 'lock'; ofs: $00; BitField:(
        (Caption: 'Memory Lock'; Name: 'LB'; Mask: $03; Values: (
          (Caption: 'Further programming and verification disabled'; Name: 'PROG_VER_DISABLED'; Value: $00),
          (Caption: 'Further programming disabled'; Name: 'PROG_DISABLED'; Value: $02),
          (Caption: 'No memory lock features enabled'; Name: 'NO_LOCK'; Value: $03),
        (Caption: 'Boot Loader Protection Mode'; Name: 'BLB0'; Mask: $0C; Values: (
          (Caption: 'LPM and SPM prohibited in Application Section'; Name: 'LPM_SPM_DISABLE'; Value: $00),
          (Caption: 'LPM prohibited in Application Section'; Name: 'LPM_DISABLE'; Value: $01),
          (Caption: 'SPM prohibited in Application Section'; Name: 'SPM_DISABLE'; Value: $02),
          (Caption: 'No lock on SPM and LPM in Application Section'; Name: 'NO_LOCK'; Value: $03),
        (Caption: 'Boot Loader Protection Mode'; Name: 'BLB1'; Mask: $30; Values: (
          (Caption: 'LPM and SPM prohibited in Boot Section'; Name: 'LPM_SPM_DISABLE'; Value: $00),
          (Caption: 'LPM prohibited in Boot Section'; Name: 'LPM_DISABLE'; Value: $01),
          (Caption: 'SPM prohibited in Boot Section'; Name: 'SPM_DISABLE'; Value: $02),
          (Caption: 'No lock on SPM and LPM in Boot Section'; Name: 'NO_LOCK'; Value: $03))),
    Name: 'ATmega128A';
    Fuses:(
     (Caption: 'EXTENDED'; FuseName: 'efuse'; ofs: $02; BitField:(
        (Caption: 'ATmega103 Compatibility Mode'; Name: 'M103C'; Mask: $02; Values: ()),
        (Caption: 'Watchdog Timer always on'; Name: 'WDTON'; Mask: $01; Values: ()))),
     (Caption: 'HIGH'; FuseName: 'hfuse'; ofs: $01; BitField:(
        (Caption: 'On-Chip Debug Enabled'; Name: 'OCDEN'; Mask: $80; Values: ()),
        (Caption: 'JTAG Interface Enabled'; Name: 'JTAGEN'; Mask: $40; Values: ()),
        (Caption: 'Serial program downloading (SPI) enabled'; Name: 'SPIEN'; Mask: $20; Values: ()),
        (Caption: 'Preserve EEPROM through the Chip Erase cycle'; Name: 'EESAVE'; Mask: $08; Values: ()),
        (Caption: 'Select Boot Size'; Name: 'BOOTSZ'; Mask: $06; Values: (
          (Caption: 'Boot Flash size=512 words start address=$FE00'; Name: '512W_FE00'; Value: $03),
          (Caption: 'Boot Flash size=1024 words start address=$FC00'; Name: '1024W_FC00'; Value: $02),
          (Caption: 'Boot Flashsize=2048 words start address=$F800'; Name: '2048W_F800'; Value: $01),
          (Caption: 'Boot Flash size=4096 words start address=$F000'; Name: '4096W_F000'; Value: $00),
        (Caption: 'Boot Reset vector Enabled'; Name: 'BOOTRST'; Mask: $01; Values: ()),
        (Caption: 'CKOPT fuse (operation dependent of CKSEL fuses)'; Name: 'CKOPT'; Mask: $10; Values: ()))),
     (Caption: 'LOW'; FuseName: 'lfuse'; ofs: $00; BitField:(
        (Caption: 'Brownout detector trigger level'; Name: 'BODLEVEL'; Mask: $80; Values: (
          (Caption: 'Brown-out detection level at VCC=4.0 V'; Name: '4V0'; Value: $00),
          (Caption: 'Brown-out detection level at VCC=2.7 V'; Name: '2V7'; Value: $01),
        (Caption: 'Brown-out detection enabled'; Name: 'BODEN'; Mask: $40; Values: ()),
        (Caption: 'Select Clock Source'; Name: 'SUT_CKSEL'; Mask: $3F; Values: (
          (Caption: 'Ext. Clock; Start-up time: 6 CK + 0 ms'; Name: 'EXTCLK_6CK_0MS'; Value: $00),
          (Caption: 'Ext. Clock; Start-up time: 6 CK + 4 ms'; Name: 'EXTCLK_6CK_4MS'; Value: $10),
          (Caption: 'Ext. Clock; Start-up time: 6 CK + 64 ms'; Name: 'EXTCLK_6CK_64MS'; Value: $20),
          (Caption: 'Int. RC Osc. 1 MHz; Start-up time: 6 CK + 0 ms'; Name: 'INTRCOSC_1MHZ_6CK_0MS'; Value: $01),
          (Caption: 'Int. RC Osc. 1 MHz; Start-up time: 6 CK + 4 ms'; Name: 'INTRCOSC_1MHZ_6CK_4MS'; Value: $11),
          (Caption: 'Int. RC Osc. 1 MHz; Start-up time: 6 CK + 64 ms'; Name: 'INTRCOSC_1MHZ_6CK_64MS'; Value: $21),
          (Caption: 'Int. RC Osc. 2 MHz; Start-up time: 6 CK + 0 ms'; Name: 'INTRCOSC_2MHZ_6CK_0MS'; Value: $02),
          (Caption: 'Int. RC Osc. 2 MHz; Start-up time: 6 CK + 4 ms'; Name: 'INTRCOSC_2MHZ_6CK_4MS'; Value: $12),
          (Caption: 'Int. RC Osc. 2 MHz; Start-up time: 6 CK + 64 ms'; Name: 'INTRCOSC_2MHZ_6CK_64MS'; Value: $22),
          (Caption: 'Int. RC Osc. 4 MHz; Start-up time: 6 CK + 0 ms'; Name: 'INTRCOSC_4MHZ_6CK_0MS'; Value: $03),
          (Caption: 'Int. RC Osc. 4 MHz; Start-up time: 6 CK + 4 ms'; Name: 'INTRCOSC_4MHZ_6CK_4MS'; Value: $13),
          (Caption: 'Int. RC Osc. 4 MHz; Start-up time: 6 CK + 64 ms'; Name: 'INTRCOSC_4MHZ_6CK_64MS'; Value: $23),
          (Caption: 'Int. RC Osc. 8 MHz; Start-up time: 6 CK + 0 ms'; Name: 'INTRCOSC_8MHZ_6CK_0MS'; Value: $04),
          (Caption: 'Int. RC Osc. 8 MHz; Start-up time: 6 CK + 4 ms'; Name: 'INTRCOSC_8MHZ_6CK_4MS'; Value: $14),
          (Caption: 'Int. RC Osc. 8 MHz; Start-up time: 6 CK + 64 ms'; Name: 'INTRCOSC_8MHZ_6CK_64MS'; Value: $24),
          (Caption: 'Ext. RC Osc.         -  0.9 MHz; Start-up time: 18 CK + 0 ms'; Name: 'EXTRCOSC_XX_0MHZ9_18CK_0MS'; Value: $05),
          (Caption: 'Ext. RC Osc.         -  0.9 MHz; Start-up time: 18 CK + 4 ms'; Name: 'EXTRCOSC_XX_0MHZ9_18CK_4MS'; Value: $15),
          (Caption: 'Ext. RC Osc.         -  0.9 MHz; Start-up time: 18 CK + 64 ms'; Name: 'EXTRCOSC_XX_0MHZ9_18CK_64MS'; Value: $25),
          (Caption: 'Ext. RC Osc.         -  0.9 MHz; Start-up time: 6 CK + 4 ms'; Name: 'EXTRCOSC_XX_0MHZ9_6CK_4MS'; Value: $35),
          (Caption: 'Ext. RC Osc. 0.9 MHz -  3.0 MHz; Start-up time: 18 CK + 0 ms'; Name: 'EXTRCOSC_0MHZ9_3MHZ_18CK_0MS'; Value: $06),
          (Caption: 'Ext. RC Osc. 0.9 MHz -  3.0 MHz; Start-up time: 18 CK + 4 ms'; Name: 'EXTRCOSC_0MHZ9_3MHZ_18CK_4MS'; Value: $16),
          (Caption: 'Ext. RC Osc. 0.9 MHz -  3.0 MHz; Start-up time: 18 CK + 64 ms'; Name: 'EXTRCOSC_0MHZ9_3MHZ_18CK_64MS'; Value: $26),
          (Caption: 'Ext. RC Osc. 0.9 MHz -  3.0 MHz; Start-up time: 6 CK + 4 ms'; Name: 'EXTRCOSC_0MHZ9_3MHZ_6CK_4MS'; Value: $36),
          (Caption: 'Ext. RC Osc. 3.0 MHz -  8.0 MHz; Start-up time: 18 CK + 0 ms'; Name: 'EXTRCOSC_3MHZ_8MHZ_18CK_0MS'; Value: $07),
          (Caption: 'Ext. RC Osc. 3.0 MHz -  8.0 MHz; Start-up time: 18 CK + 4 ms'; Name: 'EXTRCOSC_3MHZ_8MHZ_18CK_4MS'; Value: $17),
          (Caption: 'Ext. RC Osc. 3.0 MHz -  8.0 MHz; Start-up time: 18 CK + 64 ms'; Name: 'EXTRCOSC_3MHZ_8MHZ_18CK_64MS'; Value: $27),
          (Caption: 'Ext. RC Osc. 3.0 MHz -  8.0 MHz; Start-up time: 6 CK + 4 ms'; Name: 'EXTRCOSC_3MHZ_8MHZ_6CK_4MS'; Value: $37),
          (Caption: 'Ext. RC Osc. 8.0 MHz - 12.0 MHz; Start-up time: 18 CK + 0 ms'; Name: 'EXTRCOSC_8MHZ_12MHZ_18CK_0MS'; Value: $08),
          (Caption: 'Ext. RC Osc. 8.0 MHz - 12.0 MHz; Start-up time: 18 CK + 4 ms'; Name: 'EXTRCOSC_8MHZ_12MHZ_18CK_4MS'; Value: $18),
          (Caption: 'Ext. RC Osc. 8.0 MHz - 12.0 MHz; Start-up time: 18 CK + 64 ms'; Name: 'EXTRCOSC_8MHZ_12MHZ_18CK_64MS'; Value: $28),
          (Caption: 'Ext. RC Osc. 8.0 MHz - 12.0 MHz; Start-up time: 6 CK + 4 ms'; Name: 'EXTRCOSC_8MHZ_12MHZ_6CK_4MS'; Value: $38),
          (Caption: 'Ext. Low-Freq. Crystal; Start-up time: 1K CK + 4 ms'; Name: 'EXTLOFXTAL_1KCK_4MS'; Value: $09),
          (Caption: 'Ext. Low-Freq. Crystal; Start-up time: 1K CK + 64 ms'; Name: 'EXTLOFXTAL_1KCK_64MS'; Value: $19),
          (Caption: 'Ext. Low-Freq. Crystal; Start-up time: 32K CK + 64 ms'; Name: 'EXTLOFXTAL_32KCK_64MS'; Value: $29),
          (Caption: 'Ext. Crystal/Resonator Low Freq.; Start-up time: 258 CK + 4 ms'; Name: 'EXTLOFXTALRES_258CK_4MS'; Value: $0A),
          (Caption: 'Ext. Crystal/Resonator Low Freq.; Start-up time: 258 CK + 64 ms'; Name: 'EXTLOFXTALRES_258CK_64MS'; Value: $1A),
          (Caption: 'Ext. Crystal/Resonator Low Freq.; Start-up time: 1K CK + 0 ms'; Name: 'EXTLOFXTALRES_1KCK_0MS'; Value: $2A),
          (Caption: 'Ext. Crystal/Resonator Low Freq.; Start-up time: 1K CK + 4 ms'; Name: 'EXTLOFXTALRES_1KCK_4MS'; Value: $3A),
          (Caption: 'Ext. Crystal/Resonator Low Freq.; Start-up time: 1K CK + 64 ms'; Name: 'EXTLOFXTALRES_1KCK_64MS'; Value: $0B),
          (Caption: 'Ext. Crystal/Resonator Low Freq.; Start-up time: 16K CK + 0 ms'; Name: 'EXTLOFXTALRES_16KCK_0MS'; Value: $1B),
          (Caption: 'Ext. Crystal/Resonator Low Freq.; Start-up time: 16K CK + 4 ms'; Name: 'EXTLOFXTALRES_16KCK_4MS'; Value: $2B),
          (Caption: 'Ext. Crystal/Resonator Low Freq.; Start-up time: 16K CK + 64 ms'; Name: 'EXTLOFXTALRES_16KCK_64MS'; Value: $3B),
          (Caption: 'Ext. Crystal/Resonator Medium Freq.; Start-up time: 258 CK + 4 ms'; Name: 'EXTMEDFXTALRES_258CK_4MS'; Value: $0C),
          (Caption: 'Ext. Crystal/Resonator Medium Freq.; Start-up time: 258 CK + 64 ms'; Name: 'EXTMEDFXTALRES_258CK_64MS'; Value: $1C),
          (Caption: 'Ext. Crystal/Resonator Medium Freq.; Start-up time: 1K CK + 0 ms'; Name: 'EXTMEDFXTALRES_1KCK_0MS'; Value: $2C),
          (Caption: 'Ext. Crystal/Resonator Medium Freq.; Start-up time: 1K CK + 4 ms'; Name: 'EXTMEDFXTALRES_1KCK_4MS'; Value: $3C),
          (Caption: 'Ext. Crystal/Resonator Medium Freq.; Start-up time: 1K CK + 64 ms'; Name: 'EXTMEDFXTALRES_1KCK_64MS'; Value: $0D),
          (Caption: 'Ext. Crystal/Resonator Medium Freq.; Start-up time: 16K CK + 0 ms'; Name: 'EXTMEDFXTALRES_16KCK_0MS'; Value: $1D),
          (Caption: 'Ext. Crystal/Resonator Medium Freq.; Start-up time: 16K CK + 4 ms'; Name: 'EXTMEDFXTALRES_16KCK_4MS'; Value: $2D),
          (Caption: 'Ext. Crystal/Resonator Medium Freq.; Start-up time: 16K CK + 64 ms'; Name: 'EXTMEDFXTALRES_16KCK_64MS'; Value: $3D),
          (Caption: 'Ext. Crystal/Resonator High Freq.; Start-up time: 258 CK + 4 ms'; Name: 'EXTHIFXTALRES_258CK_4MS'; Value: $0E),
          (Caption: 'Ext. Crystal/Resonator High Freq.; Start-up time: 258 CK + 64 ms'; Name: 'EXTHIFXTALRES_258CK_64MS'; Value: $1E),
          (Caption: 'Ext. Crystal/Resonator High Freq.; Start-up time: 1K CK + 0 ms'; Name: 'EXTHIFXTALRES_1KCK_0MS'; Value: $2E),
          (Caption: 'Ext. Crystal/Resonator High Freq.; Start-up time: 1K CK + 4 ms'; Name: 'EXTHIFXTALRES_1KCK_4MS'; Value: $3E),
          (Caption: 'Ext. Crystal/Resonator High Freq.; Start-up time: 1K CK + 64 ms'; Name: 'EXTHIFXTALRES_1KCK_64MS'; Value: $0F),
          (Caption: 'Ext. Crystal/Resonator High Freq.; Start-up time: 16K CK + 0 ms'; Name: 'EXTHIFXTALRES_16KCK_0MS'; Value: $1F),
          (Caption: 'Ext. Crystal/Resonator High Freq.; Start-up time: 16K CK + 4 ms'; Name: 'EXTHIFXTALRES_16KCK_4MS'; Value: $2F),
          (Caption: 'Ext. Crystal/Resonator High Freq.; Start-up time: 16K CK + 64 ms'; Name: 'EXTHIFXTALRES_16KCK_64MS'; Value: $3F))),
     (Caption: 'LOCKBIT'; FuseName: 'lock'; ofs: $00; BitField:(
        (Caption: 'Memory Lock'; Name: 'LB'; Mask: $03; Values: (
          (Caption: 'Further programming and verification disabled'; Name: 'PROG_VER_DISABLED'; Value: $00),
          (Caption: 'Further programming disabled'; Name: 'PROG_DISABLED'; Value: $02),
          (Caption: 'No memory lock features enabled'; Name: 'NO_LOCK'; Value: $03),
        (Caption: 'Boot Loader Protection Mode'; Name: 'BLB0'; Mask: $0C; Values: (
          (Caption: 'LPM and SPM prohibited in Application Section'; Name: 'LPM_SPM_DISABLE'; Value: $00),
          (Caption: 'LPM prohibited in Application Section'; Name: 'LPM_DISABLE'; Value: $01),
          (Caption: 'SPM prohibited in Application Section'; Name: 'SPM_DISABLE'; Value: $02),
          (Caption: 'No lock on SPM and LPM in Application Section'; Name: 'NO_LOCK'; Value: $03),
        (Caption: 'Boot Loader Protection Mode'; Name: 'BLB1'; Mask: $30; Values: (
          (Caption: 'LPM and SPM prohibited in Boot Section'; Name: 'LPM_SPM_DISABLE'; Value: $00),
          (Caption: 'LPM prohibited in Boot Section'; Name: 'LPM_DISABLE'; Value: $01),
          (Caption: 'SPM prohibited in Boot Section'; Name: 'SPM_DISABLE'; Value: $02),
          (Caption: 'No lock on SPM and LPM in Boot Section'; Name: 'NO_LOCK'; Value: $03))),
    Name: 'ATmega6450';
    Fuses:(
     (Caption: 'EXTENDED'; FuseName: 'efuse'; ofs: $02; BitField:(
        (Caption: 'Brown-out Detector trigger level'; Name: 'BODLEVEL'; Mask: $06; Values: (
          (Caption: 'Brown-out detection disabled'; Name: 'DISABLED'; Value: $03),
          (Caption: 'Brown-out detection at VCC=1.8 V'; Name: '1V8'; Value: $02),
          (Caption: 'Brown-out detection at VCC=2.7 V'; Name: '2V7'; Value: $01),
          (Caption: 'Brown-out detection at VCC=4.3 V'; Name: '4V3'; Value: $00),
        (Caption: 'External Reset Disable'; Name: 'RSTDISBL'; Mask: $01; Values: ()))),
     (Caption: 'HIGH'; FuseName: 'hfuse'; ofs: $01; BitField:(
        (Caption: 'On-Chip Debug Enabled'; Name: 'OCDEN'; Mask: $80; Values: ()),
        (Caption: 'JTAG Interface Enabled'; Name: 'JTAGEN'; Mask: $40; Values: ()),
        (Caption: 'Serial program downloading (SPI) enable'; Name: 'SPIEN'; Mask: $20; Values: ()),
        (Caption: 'Watchdog timer always on'; Name: 'WDTON'; Mask: $10; Values: ()),
        (Caption: 'Preserve EEPROM through the Chip Erase cycle'; Name: 'EESAVE'; Mask: $08; Values: ()),
        (Caption: 'Select Boot Size'; Name: 'BOOTSZ'; Mask: $06; Values: (
          (Caption: 'Boot Flash size=512 words Boot address=$7E00'; Name: '512W_7E00'; Value: $03),
          (Caption: 'Boot Flash size=1024 words Boot address=$7C00'; Name: '1024W_7C00'; Value: $02),
          (Caption: 'Boot Flash size=2048 words Boot address=$7800'; Name: '2048W_7800'; Value: $01),
          (Caption: 'Boot Flash size=4096 words Boot address=$7000'; Name: '4096W_7000'; Value: $00),
        (Caption: 'Boot Reset vector Enabled'; Name: 'BOOTRST'; Mask: $01; Values: ()))),
     (Caption: 'LOW'; FuseName: 'lfuse'; ofs: $00; BitField:(
        (Caption: 'Divide clock by 8 internally'; Name: 'CKDIV8'; Mask: $80; Values: ()),
        (Caption: 'Clock output on PORTE7'; Name: 'CKOUT'; Mask: $40; Values: ()),
        (Caption: 'Select Clock Source'; Name: 'SUT_CKSEL'; Mask: $3F; Values: (
          (Caption: 'Ext. Clock; Start-up time: 6 CK + 0 ms'; Name: 'EXTCLK_6CK_0MS'; Value: $00),
          (Caption: 'Ext. Clock; Start-up time: 6 CK + 4.1 ms'; Name: 'EXTCLK_6CK_4MS1'; Value: $10),
          (Caption: 'Ext. Clock; Start-up time: 6 CK + 65 ms'; Name: 'EXTCLK_6CK_65MS'; Value: $20),
          (Caption: 'Int. RC Osc.; Start-up time: 6 CK + 0 ms'; Name: 'INTRCOSC_6CK_0MS'; Value: $02),
          (Caption: 'Int. RC Osc.; Start-up time: 6 CK + 4.1 ms'; Name: 'INTRCOSC_6CK_4MS1'; Value: $12),
          (Caption: 'Int. RC Osc.; Start-up time: 6 CK + 65 ms'; Name: 'INTRCOSC_6CK_65MS'; Value: $22),
          (Caption: 'Ext. Low-Freq. Crystal; Start-up time: 32K CK + 0 ms'; Name: 'EXTLOFXTAL_32KCK_0MS'; Value: $07),
          (Caption: 'Ext. Low-Freq. Crystal; Start-up time: 32K CK + 4.1 ms'; Name: 'EXTLOFXTAL_32KCK_4MS1'; Value: $17),
          (Caption: 'Ext. Low-Freq. Crystal; Start-up time: 32K CK + 65 ms'; Name: 'EXTLOFXTAL_32KCK_65MS'; Value: $27),
          (Caption: 'Ext. Low-Freq. Crystal; Start-up time: 1K CK + 0 ms'; Name: 'EXTLOFXTAL_1KCK_0MS'; Value: $06),
          (Caption: 'Ext. Low-Freq. Crystal; Start-up time: 1K CK + 4.1 ms'; Name: 'EXTLOFXTAL_1KCK_4MS1'; Value: $16),
          (Caption: 'Ext. Low-Freq. Crystal; Start-up time: 1K CK + 65 ms'; Name: 'EXTLOFXTAL_1KCK_65MS'; Value: $26),
          (Caption: 'Ext. Crystal Osc. 0.4-0.9 MHz; Start-up time: 258 CK + 4.1 ms'; Name: 'EXTXOSC_0MHZ4_0MHZ9_258CK_4MS1'; Value: $08),
          (Caption: 'Ext. Crystal Osc. 0.4-0.9 MHz; Start-up time: 258 CK + 65 ms'; Name: 'EXTXOSC_0MHZ4_0MHZ9_258CK_65MS'; Value: $18),
          (Caption: 'Ext. Crystal Osc. 0.4-0.9 MHz; Start-up time: 1K CK + 0 ms'; Name: 'EXTXOSC_0MHZ4_0MHZ9_1KCK_0MS'; Value: $28),
          (Caption: 'Ext. Crystal Osc. 0.4-0.9 MHz; Start-up time: 1K CK + 4.1 ms'; Name: 'EXTXOSC_0MHZ4_0MHZ9_1KCK_4MS1'; Value: $38),
          (Caption: 'Ext. Crystal Osc. 0.4-0.9 MHz; Start-up time: 1K CK + 65 ms'; Name: 'EXTXOSC_0MHZ4_0MHZ9_1KCK_65MS'; Value: $09),
          (Caption: 'Ext. Crystal Osc. 0.4-0.9 MHz; Start-up time: 16K CK + 0 ms'; Name: 'EXTXOSC_0MHZ4_0MHZ9_16KCK_0MS'; Value: $19),
          (Caption: 'Ext. Crystal Osc. 0.4-0.9 MHz; Start-up time: 16K CK + 4.1 ms'; Name: 'EXTXOSC_0MHZ4_0MHZ9_16KCK_4MS1'; Value: $29),
          (Caption: 'Ext. Crystal Osc. 0.4-0.9 MHz; Start-up time: 16K CK + 65 ms'; Name: 'EXTXOSC_0MHZ4_0MHZ9_16KCK_65MS'; Value: $39),
          (Caption: 'Ext. Crystal Osc. 0.9-3.0 MHz; Start-up time: 258 CK + 4.1 ms'; Name: 'EXTXOSC_0MHZ9_3MHZ_258CK_4MS1'; Value: $0A),
          (Caption: 'Ext. Crystal Osc. 0.9-3.0 MHz; Start-up time: 258 CK + 65 ms'; Name: 'EXTXOSC_0MHZ9_3MHZ_258CK_65MS'; Value: $1A),
          (Caption: 'Ext. Crystal Osc. 0.9-3.0 MHz; Start-up time: 1K CK + 0 ms'; Name: 'EXTXOSC_0MHZ9_3MHZ_1KCK_0MS'; Value: $2A),
          (Caption: 'Ext. Crystal Osc. 0.9-3.0 MHz; Start-up time: 1K CK + 4.1 ms'; Name: 'EXTXOSC_0MHZ9_3MHZ_1KCK_4MS1'; Value: $3A),
          (Caption: 'Ext. Crystal Osc. 0.9-3.0 MHz; Start-up time: 1K CK + 65 ms'; Name: 'EXTXOSC_0MHZ9_3MHZ_1KCK_65MS'; Value: $0B),
          (Caption: 'Ext. Crystal Osc. 0.9-3.0 MHz; Start-up time: 16K CK + 0 ms'; Name: 'EXTXOSC_0MHZ9_3MHZ_16KCK_0MS'; Value: $1B),
          (Caption: 'Ext. Crystal Osc. 0.9-3.0 MHz; Start-up time: 16K CK + 4.1 ms'; Name: 'EXTXOSC_0MHZ9_3MHZ_16KCK_4MS1'; Value: $2B),
          (Caption: 'Ext. Crystal Osc. 0.9-3.0 MHz; Start-up time: 16K CK + 65 ms'; Name: 'EXTXOSC_0MHZ9_3MHZ_16KCK_65MS'; Value: $3B),
          (Caption: 'Ext. Crystal Osc. 3.0-8.0 MHz; Start-up time: 258 CK + 4.1 ms'; Name: 'EXTXOSC_3MHZ_8MHZ_258CK_4MS1'; Value: $0C),
          (Caption: 'Ext. Crystal Osc. 3.0-8.0 MHz; Start-up time: 258 CK + 65 ms'; Name: 'EXTXOSC_3MHZ_8MHZ_258CK_65MS'; Value: $1C),
          (Caption: 'Ext. Crystal Osc. 3.0-8.0 MHz; Start-up time: 1K CK + 0 ms'; Name: 'EXTXOSC_3MHZ_8MHZ_1KCK_0MS'; Value: $2C),
          (Caption: 'Ext. Crystal Osc. 3.0-8.0 MHz; Start-up time: 1K CK + 4.1 ms'; Name: 'EXTXOSC_3MHZ_8MHZ_1KCK_4MS1'; Value: $3C),
          (Caption: 'Ext. Crystal Osc. 3.0-8.0 MHz; Start-up time: 1K CK + 65 ms'; Name: 'EXTXOSC_3MHZ_8MHZ_1KCK_65MS'; Value: $0D),
          (Caption: 'Ext. Crystal Osc. 3.0-8.0 MHz; Start-up time: 16K CK + 0 ms'; Name: 'EXTXOSC_3MHZ_8MHZ_16KCK_0MS'; Value: $1D),
          (Caption: 'Ext. Crystal Osc. 3.0-8.0 MHz; Start-up time: 16K CK + 4.1 ms'; Name: 'EXTXOSC_3MHZ_8MHZ_16KCK_4MS1'; Value: $2D),
          (Caption: 'Ext. Crystal Osc. 3.0-8.0 MHz; Start-up time: 16K CK + 65 ms'; Name: 'EXTXOSC_3MHZ_8MHZ_16KCK_65MS'; Value: $3D),
          (Caption: 'Ext. Crystal Osc. 8.0-    MHz; Start-up time: 258 CK + 4.1 ms'; Name: 'EXTXOSC_8MHZ_XX_258CK_4MS1'; Value: $0E),
          (Caption: 'Ext. Crystal Osc. 8.0-    MHz; Start-up time: 258 CK + 65 ms'; Name: 'EXTXOSC_8MHZ_XX_258CK_65MS'; Value: $1E),
          (Caption: 'Ext. Crystal Osc. 8.0-    MHz; Start-up time: 1K CK + 0 ms'; Name: 'EXTXOSC_8MHZ_XX_1KCK_0MS'; Value: $2E),
          (Caption: 'Ext. Crystal Osc. 8.0-    MHz; Start-up time: 1K CK + 4.1 ms'; Name: 'EXTXOSC_8MHZ_XX_1KCK_4MS1'; Value: $3E),
          (Caption: 'Ext. Crystal Osc. 8.0-    MHz; Start-up time: 1K CK + 65 ms'; Name: 'EXTXOSC_8MHZ_XX_1KCK_65MS'; Value: $0F),
          (Caption: 'Ext. Crystal Osc. 8.0-    MHz; Start-up time: 16K CK + 0 ms'; Name: 'EXTXOSC_8MHZ_XX_16KCK_0MS'; Value: $1F),
          (Caption: 'Ext. Crystal Osc. 8.0-    MHz; Start-up time: 16K CK + 4.1 ms'; Name: 'EXTXOSC_8MHZ_XX_16KCK_4MS1'; Value: $2F),
          (Caption: 'Ext. Crystal Osc. 8.0-    MHz; Start-up time: 16K CK + 65 ms'; Name: 'EXTXOSC_8MHZ_XX_16KCK_65MS'; Value: $3F))),
     (Caption: 'LOCKBIT'; FuseName: 'lock'; ofs: $00; BitField:(
        (Caption: 'Memory Lock'; Name: 'LB'; Mask: $03; Values: (
          (Caption: 'Further programming and verification disabled'; Name: 'PROG_VER_DISABLED'; Value: $00),
          (Caption: 'Further programming disabled'; Name: 'PROG_DISABLED'; Value: $02),
          (Caption: 'No memory lock features enabled'; Name: 'NO_LOCK'; Value: $03),
        (Caption: 'Boot Loader Protection Mode'; Name: 'BLB0'; Mask: $0C; Values: (
          (Caption: 'LPM and SPM prohibited in Application Section'; Name: 'LPM_SPM_DISABLE'; Value: $00),
          (Caption: 'LPM prohibited in Application Section'; Name: 'LPM_DISABLE'; Value: $01),
          (Caption: 'SPM prohibited in Application Section'; Name: 'SPM_DISABLE'; Value: $02),
          (Caption: 'No lock on SPM and LPM in Application Section'; Name: 'NO_LOCK'; Value: $03),
        (Caption: 'Boot Loader Protection Mode'; Name: 'BLB1'; Mask: $30; Values: (
          (Caption: 'LPM and SPM prohibited in Boot Section'; Name: 'LPM_SPM_DISABLE'; Value: $00),
          (Caption: 'LPM prohibited in Boot Section'; Name: 'LPM_DISABLE'; Value: $01),
          (Caption: 'SPM prohibited in Boot Section'; Name: 'SPM_DISABLE'; Value: $02),
          (Caption: 'No lock on SPM and LPM in Boot Section'; Name: 'NO_LOCK'; Value: $03))),
    Name: 'ATtiny817';
    Fuses:(
     (Caption: 'APPEND'; FuseName: 'fuse7'; ofs: $07; BitField)):(
     (Caption: 'BODCFG'; FuseName: 'fuse1'; ofs: $01; BitField:(
        (Caption: 'BOD Operation in Active Mode'; Name: 'ACTIVE'; Mask: $0C; Values: (
          (Caption: 'Disabled'; Name: 'DIS'; Value: $00),
          (Caption: 'Enabled'; Name: 'ENABLED'; Value: $01),
          (Caption: 'Sampled'; Name: 'SAMPLED'; Value: $02),
          (Caption: 'Enabled with wake-up halted until BOD is ready'; Name: 'ENWAKE'; Value: $03),
        (Caption: 'BOD Level'; Name: 'LVL'; Mask: $E0; Values: (
          (Caption: '1.8 V'; Name: 'BODLEVEL0'; Value: $00),
          (Caption: '2.1 V'; Name: 'BODLEVEL1'; Value: $01),
          (Caption: '2.6 V'; Name: 'BODLEVEL2'; Value: $02),
          (Caption: '2.9 V'; Name: 'BODLEVEL3'; Value: $03),
          (Caption: '3.3 V'; Name: 'BODLEVEL4'; Value: $04),
          (Caption: '3.7 V'; Name: 'BODLEVEL5'; Value: $05),
          (Caption: '4.0 V'; Name: 'BODLEVEL6'; Value: $06),
          (Caption: '4.2 V'; Name: 'BODLEVEL7'; Value: $07),
        (Caption: 'BOD Sample Frequency'; Name: 'SAMPFREQ'; Mask: $10; Values: (
          (Caption: '1kHz sampling frequency'; Name: '1KHz'; Value: $00),
          (Caption: '125Hz sampling frequency'; Name: '125Hz'; Value: $01),
        (Caption: 'BOD Operation in Sleep Mode'; Name: 'SLEEP'; Mask: $03; Values: (
          (Caption: 'Disabled'; Name: 'DIS'; Value: $00),
          (Caption: 'Enabled'; Name: 'ENABLED'; Value: $01),
          (Caption: 'Sampled'; Name: 'SAMPLED'; Value: $02))),
     (Caption: 'BOOTEND'; FuseName: 'fuse8'; ofs: $08; BitField)):(
     (Caption: 'OSCCFG'; FuseName: 'fuse2'; ofs: $02; BitField:(
        (Caption: 'Frequency Select'; Name: 'FREQSEL'; Mask: $03; Values: (
          (Caption: '16 MHz'; Name: '16MHZ'; Value: $01),
          (Caption: '20 MHz'; Name: '20MHZ'; Value: $02),
        (Caption: 'Oscillator Lock'; Name: 'OSCLOCK'; Mask: $80; Values: ()))),
     (Caption: 'SYSCFG0'; FuseName: 'fuse5'; ofs: $05; BitField:(
        (Caption: 'CRC Source'; Name: 'CRCSRC'; Mask: $C0; Values: (
          (Caption: 'The CRC is performed on the entire Flash (boot, application code and application data section).'; Name: 'FLASH'; Value: $00),
          (Caption: 'The CRC is performed on the boot section of Flash'; Name: 'BOOT'; Value: $01),
          (Caption: 'The CRC is performed on the boot and application code section of Flash'; Name: 'BOOTAPP'; Value: $02),
          (Caption: 'Disable CRC.'; Name: 'NOCRC'; Value: $03),
        (Caption: 'EEPROM Save'; Name: 'EESAVE'; Mask: $01; Values: ()),
        (Caption: 'Reset Pin Configuration'; Name: 'RSTPINCFG'; Mask: $0C; Values: (
          (Caption: 'GPIO mode'; Name: 'GPIO'; Value: $00),
          (Caption: 'UPDI mode'; Name: 'UPDI'; Value: $01),
          (Caption: 'Reset mode'; Name: 'RST'; Value: $02))),
     (Caption: 'SYSCFG1'; FuseName: 'fuse6'; ofs: $06; BitField:(
        (Caption: 'Startup Time'; Name: 'SUT'; Mask: $07; Values: (
          (Caption: '0 ms'; Name: '0MS'; Value: $00),
          (Caption: '1 ms'; Name: '1MS'; Value: $01),
          (Caption: '2 ms'; Name: '2MS'; Value: $02),
          (Caption: '4 ms'; Name: '4MS'; Value: $03),
          (Caption: '8 ms'; Name: '8MS'; Value: $04),
          (Caption: '16 ms'; Name: '16MS'; Value: $05),
          (Caption: '32 ms'; Name: '32MS'; Value: $06),
          (Caption: '64 ms'; Name: '64MS'; Value: $07))),
     (Caption: 'TCD0CFG'; FuseName: 'fuse4'; ofs: $04; BitField:(
        (Caption: 'Compare A Default Output Value'; Name: 'CMPA'; Mask: $01; Values: ()),
        (Caption: 'Compare A Output Enable'; Name: 'CMPAEN'; Mask: $10; Values: ()),
        (Caption: 'Compare B Default Output Value'; Name: 'CMPB'; Mask: $02; Values: ()),
        (Caption: 'Compare B Output Enable'; Name: 'CMPBEN'; Mask: $20; Values: ()),
        (Caption: 'Compare C Default Output Value'; Name: 'CMPC'; Mask: $04; Values: ()),
        (Caption: 'Compare C Output Enable'; Name: 'CMPCEN'; Mask: $40; Values: ()),
        (Caption: 'Compare D Default Output Value'; Name: 'CMPD'; Mask: $08; Values: ()),
        (Caption: 'Compare D Output Enable'; Name: 'CMPDEN'; Mask: $80; Values: ()))),
     (Caption: 'WDTCFG'; FuseName: 'fuse0'; ofs: $00; BitField:(
        (Caption: 'Watchdog Timeout Period'; Name: 'PERIOD'; Mask: $0F; Values: (
          (Caption: 'Watch-Dog timer Off'; Name: 'OFF'; Value: $00),
          (Caption: '8 cycles (8ms)'; Name: '8CLK'; Value: $01),
          (Caption: '16 cycles (16ms)'; Name: '16CLK'; Value: $02),
          (Caption: '32 cycles (32ms)'; Name: '32CLK'; Value: $03),
          (Caption: '64 cycles (64ms)'; Name: '64CLK'; Value: $04),
          (Caption: '128 cycles (0.128s)'; Name: '128CLK'; Value: $05),
          (Caption: '256 cycles (0.256s)'; Name: '256CLK'; Value: $06),
          (Caption: '512 cycles (0.512s)'; Name: '512CLK'; Value: $07),
          (Caption: '1K cycles (1.0s)'; Name: '1KCLK'; Value: $08),
          (Caption: '2K cycles (2.0s)'; Name: '2KCLK'; Value: $09),
          (Caption: '4K cycles (4.1s)'; Name: '4KCLK'; Value: $0A),
          (Caption: '8K cycles (8.2s)'; Name: '8KCLK'; Value: $0B),
        (Caption: 'Watchdog Window Timeout Period'; Name: 'WINDOW'; Mask: $F0; Values: (
          (Caption: 'Window mode off'; Name: 'OFF'; Value: $00),
          (Caption: '8 cycles (8ms)'; Name: '8CLK'; Value: $01),
          (Caption: '16 cycles (16ms)'; Name: '16CLK'; Value: $02),
          (Caption: '32 cycles (32ms)'; Name: '32CLK'; Value: $03),
          (Caption: '64 cycles (64ms)'; Name: '64CLK'; Value: $04),
          (Caption: '128 cycles (0.128s)'; Name: '128CLK'; Value: $05),
          (Caption: '256 cycles (0.256s)'; Name: '256CLK'; Value: $06),
          (Caption: '512 cycles (0.512s)'; Name: '512CLK'; Value: $07),
          (Caption: '1K cycles (1.0s)'; Name: '1KCLK'; Value: $08),
          (Caption: '2K cycles (2.0s)'; Name: '2KCLK'; Value: $09),
          (Caption: '4K cycles (4.1s)'; Name: '4KCLK'; Value: $0A),
          (Caption: '8K cycles (8.2s)'; Name: '8KCLK'; Value: $0B))),
     (Caption: 'LOCKBIT'; FuseName: 'lock'; ofs: $00; BitField:(
        (Caption: 'Lock Bits'; Name: 'LB'; Mask: $FF; Values: (
          (Caption: 'Read and write lock'; Name: 'RWLOCK'; Value: $3A),
          (Caption: 'No locks'; Name: 'NOLOCK'; Value: $C5))));

implementation

begin
end.
