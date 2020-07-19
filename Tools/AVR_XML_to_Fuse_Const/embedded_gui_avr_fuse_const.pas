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
    Fuses:((
      Caption: 'LOW'; FuseName: 'lfuse'; ofs: '$00';
      Caption: 'HIGH'; FuseName: 'hfuse'; ofs: '$01';
      Caption: 'LOCKBIT'; FuseName: 'lock'; ofs: '$00';
    Name: 'ATmega128A';
    Fuses(
      Caption: 'EXTENDED'; FuseName: 'efuse'; ofs: '$02';
      Caption: 'HIGH'; FuseName: 'hfuse'; ofs: '$01';
      Caption: 'LOW'; FuseName: 'lfuse'; ofs: '$00';
      Caption: 'LOCKBIT'; FuseName: 'lock'; ofs: '$00';
    Name: 'ATmega6450';
    Fuses(
      Caption: 'EXTENDED'; FuseName: 'efuse'; ofs: '$02';
      Caption: 'HIGH'; FuseName: 'hfuse'; ofs: '$01';
      Caption: 'LOW'; FuseName: 'lfuse'; ofs: '$00';
      Caption: 'LOCKBIT'; FuseName: 'lock'; ofs: '$00';
    Name: 'ATtiny817';
    Fuses(
      Caption: 'APPEND'; FuseName: 'fuse7'; ofs: '$07';
      Caption: 'BODCFG'; FuseName: 'fuse1'; ofs: '$01';
      Caption: 'BOOTEND'; FuseName: 'fuse8'; ofs: '$08';
      Caption: 'OSCCFG'; FuseName: 'fuse2'; ofs: '$02';
      Caption: 'SYSCFG0'; FuseName: 'fuse5'; ofs: '$05';
      Caption: 'SYSCFG1'; FuseName: 'fuse6'; ofs: '$06';
      Caption: 'TCD0CFG'; FuseName: 'fuse4'; ofs: '$04';
      Caption: 'WDTCFG'; FuseName: 'fuse0'; ofs: '$00';
      Caption: 'LOCKBIT'; FuseName: 'lock'; ofs: '$00');

implementation

begin
end.
