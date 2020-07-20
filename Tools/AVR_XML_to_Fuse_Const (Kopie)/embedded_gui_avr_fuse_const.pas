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
        (Caption: 'Select start-up time'; Name: 'SUT'; Mask: $1C; Values: ((Caption: 'abc'))),
        (Caption: 'Oscillator select'; Name: 'OSCSEL'; Mask: $03; Values: ((Caption: 'abc'))))),
     (Caption: 'HIGH'; FuseName: 'hfuse'; ofs: $01; BitField:(
        (Caption: 'DUVR mode on'; Name: 'DUVRDINIT'; Mask: $10; Values: ()),
        (Caption: 'Debug Wire enable'; Name: 'DWEN'; Mask: $08; Values: ()),
        (Caption: 'Select Boot Size'; Name: 'BOOTSZ'; Mask: $06; Values: ((Caption: 'abc'))),
        (Caption: 'Boot Reset vector Enabled'; Name: 'BOOTRST'; Mask: $01; Values: ()))),
     (Caption: 'LOCKBIT'; FuseName: 'lock'; ofs: $00; BitField:(
        (Caption: 'Memory Lock'; Name: 'LB'; Mask: $03; Values: ((Caption: 'abc'))),
        (Caption: 'Boot Loader Protection Mode'; Name: 'BLB0'; Mask: $0C; Values: ((Caption: 'abc'))),
        (Caption: 'Boot Loader Protection Mode'; Name: 'BLB1'; Mask: $30; Values: ((Caption: 'abc'))))),
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
        (Caption: 'Select Boot Size'; Name: 'BOOTSZ'; Mask: $06; Values: ((Caption: 'abc'))),
        (Caption: 'Boot Reset vector Enabled'; Name: 'BOOTRST'; Mask: $01; Values: ()),
        (Caption: 'CKOPT fuse (operation dependent of CKSEL fuses)'; Name: 'CKOPT'; Mask: $10; Values: ()))),
     (Caption: 'LOW'; FuseName: 'lfuse'; ofs: $00; BitField:(
        (Caption: 'Brownout detector trigger level'; Name: 'BODLEVEL'; Mask: $80; Values: ((Caption: 'abc'))),
        (Caption: 'Brown-out detection enabled'; Name: 'BODEN'; Mask: $40; Values: ()),
        (Caption: 'Select Clock Source'; Name: 'SUT_CKSEL'; Mask: $3F; Values: ((Caption: 'abc'))))),
     (Caption: 'LOCKBIT'; FuseName: 'lock'; ofs: $00; BitField:(
        (Caption: 'Memory Lock'; Name: 'LB'; Mask: $03; Values: ((Caption: 'abc'))),
        (Caption: 'Boot Loader Protection Mode'; Name: 'BLB0'; Mask: $0C; Values: ((Caption: 'abc'))),
        (Caption: 'Boot Loader Protection Mode'; Name: 'BLB1'; Mask: $30; Values: ((Caption: 'abc'))))),
    Name: 'ATmega6450';
    Fuses:(
     (Caption: 'EXTENDED'; FuseName: 'efuse'; ofs: $02; BitField:(
        (Caption: 'Brown-out Detector trigger level'; Name: 'BODLEVEL'; Mask: $06; Values: ((Caption: 'abc'))),
        (Caption: 'External Reset Disable'; Name: 'RSTDISBL'; Mask: $01; Values: ()))),
     (Caption: 'HIGH'; FuseName: 'hfuse'; ofs: $01; BitField:(
        (Caption: 'On-Chip Debug Enabled'; Name: 'OCDEN'; Mask: $80; Values: ()),
        (Caption: 'JTAG Interface Enabled'; Name: 'JTAGEN'; Mask: $40; Values: ()),
        (Caption: 'Serial program downloading (SPI) enable'; Name: 'SPIEN'; Mask: $20; Values: ()),
        (Caption: 'Watchdog timer always on'; Name: 'WDTON'; Mask: $10; Values: ()),
        (Caption: 'Preserve EEPROM through the Chip Erase cycle'; Name: 'EESAVE'; Mask: $08; Values: ()),
        (Caption: 'Select Boot Size'; Name: 'BOOTSZ'; Mask: $06; Values: ((Caption: 'abc'))),
        (Caption: 'Boot Reset vector Enabled'; Name: 'BOOTRST'; Mask: $01; Values: ()))),
     (Caption: 'LOW'; FuseName: 'lfuse'; ofs: $00; BitField:(
        (Caption: 'Divide clock by 8 internally'; Name: 'CKDIV8'; Mask: $80; Values: ()),
        (Caption: 'Clock output on PORTE7'; Name: 'CKOUT'; Mask: $40; Values: ()),
        (Caption: 'Select Clock Source'; Name: 'SUT_CKSEL'; Mask: $3F; Values: ((Caption: 'abc'))))),
     (Caption: 'LOCKBIT'; FuseName: 'lock'; ofs: $00; BitField:(
        (Caption: 'Memory Lock'; Name: 'LB'; Mask: $03; Values: ((Caption: 'abc'))),
        (Caption: 'Boot Loader Protection Mode'; Name: 'BLB0'; Mask: $0C; Values: ((Caption: 'abc'))),
        (Caption: 'Boot Loader Protection Mode'; Name: 'BLB1'; Mask: $30; Values: ((Caption: 'abc'))))),
    Name: 'ATtiny817';
    Fuses:(
     (Caption: 'APPEND'; FuseName: 'fuse7'; ofs: $07; BitField)):(
     (Caption: 'BODCFG'; FuseName: 'fuse1'; ofs: $01; BitField:(
        (Caption: 'BOD Operation in Active Mode'; Name: 'ACTIVE'; Mask: $0C; Values: ((Caption: 'abc'))),
        (Caption: 'BOD Level'; Name: 'LVL'; Mask: $E0; Values: ((Caption: 'abc'))),
        (Caption: 'BOD Sample Frequency'; Name: 'SAMPFREQ'; Mask: $10; Values: ((Caption: 'abc'))),
        (Caption: 'BOD Operation in Sleep Mode'; Name: 'SLEEP'; Mask: $03; Values: ((Caption: 'abc'))))),
     (Caption: 'BOOTEND'; FuseName: 'fuse8'; ofs: $08; BitField)):(
     (Caption: 'OSCCFG'; FuseName: 'fuse2'; ofs: $02; BitField:(
        (Caption: 'Frequency Select'; Name: 'FREQSEL'; Mask: $03; Values: ((Caption: 'abc'))),
        (Caption: 'Oscillator Lock'; Name: 'OSCLOCK'; Mask: $80; Values: ()))),
     (Caption: 'SYSCFG0'; FuseName: 'fuse5'; ofs: $05; BitField:(
        (Caption: 'CRC Source'; Name: 'CRCSRC'; Mask: $C0; Values: ((Caption: 'abc'))),
        (Caption: 'EEPROM Save'; Name: 'EESAVE'; Mask: $01; Values: ()),
        (Caption: 'Reset Pin Configuration'; Name: 'RSTPINCFG'; Mask: $0C; Values: ((Caption: 'abc'))))),
     (Caption: 'SYSCFG1'; FuseName: 'fuse6'; ofs: $06; BitField:(
        (Caption: 'Startup Time'; Name: 'SUT'; Mask: $07; Values: ((Caption: 'abc'))))),
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
        (Caption: 'Watchdog Timeout Period'; Name: 'PERIOD'; Mask: $0F; Values: ((Caption: 'abc'))),
        (Caption: 'Watchdog Window Timeout Period'; Name: 'WINDOW'; Mask: $F0; Values: ((Caption: 'abc'))))),
     (Caption: 'LOCKBIT'; FuseName: 'lock'; ofs: $00; BitField:(
        (Caption: 'Lock Bits'; Name: 'LB'; Mask: $FF; Values: ((Caption: 'abc'))))));

implementation

begin
end.
