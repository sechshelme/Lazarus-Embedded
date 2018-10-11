program Project1;

{$O-}
type
  TSPI_GPIO = bitpacked record
    p0, p1, p2, p3, SlaveSelect, DataInt, DataOut, Clock: boolean;
  end;

  TButton_GPIO = bitpacked array[0..2] of boolean;

var
  SPI_PORT: TSPI_GPIO absolute PORTB;
  SPI_DDR: TSPI_GPIO absolute DDRB;

  Button_PIN: TButton_GPIO absolute PIND;

  procedure delay;
  var
    i:UInt32;
  begin
    for i:=0 to 65000 do;
  end;

  procedure SPIWriteData(p: PByte; len: byte);
  var
    i: byte;
  begin
    SPI_PORT.SlaveSelect := False;
    for i := 0 to len - 1 do begin
      USIDR := p[i];
      USISR := 1 shl USIOIF;

      repeat
        USICR := (%01 shl USIWM) or (%10 shl USICS) or (1 shl USICLK) or (1 shl USITC);
      until (USISR and (1 shl USIOIF)) <> 0;

    end;
    SPI_PORT.SlaveSelect := True;
  end;

const
  Text0 = 'Lazarus ist Toll !' + #13#10;
  Text1 = 'Hello World !, Hello AVR' + #13#10;
  Text2 = 'SPI als Slave' + #13#10;

begin
  SPI_DDR.DataOut := True;
  SPI_DDR.Clock := True;
  SPI_DDR.SlaveSelect := True;

  repeat
    if not Button_PIN[0] then begin
      SPIWriteData(@Text0[1], Length(Text0));
      delay;
    end;
    if not Button_PIN[1] then begin
      SPIWriteData(@Text1[1], Length(Text1));
      delay;
    end;
    if not Button_PIN[2] then begin
      SPIWriteData(@Text2[1], Length(Text2));
      delay;
    end;
  until 1 = 2;
end.
