program Project1;

uses
  intrinsics;

{$O-,J-}

//const
//  Smily: array[0..1, 0..7] of byte = ((
//    %11111111,
//    %11111111,
//    %11111111,
//    %11111111,
//    %11111111,
//    %11111111,
//    %11111111,
//    %11111111), (
//
//    %00000000,
//    %00000000,
//    %00000000,
//    %00000000,
//    %00000000,
//    %00000000,
//    %00000000,
//    %00000000));

const
  Smily: array[0..1, 0..7] of byte = ((
    %00111100,
    %01000010,
    %10100101,
    %10000001,
    %11000011,
    %10111101,
    %01000010,
    %00111100), (

    %00111100,
    %01000010,
    %10100101,
    %10000001,
    %10111101,
    %11000011,
    %01000010,
    %00111100));



type
  TSPIGPIO = bitpacked record
    //    DataOut, Clock, SlaveSelect, p3, p4, p5, p6, p7: boolean;
    DataIn, DataOut, Clock, SlaveSelect, p0, p1, p2, p3: boolean;
  end;

var
  SPI_PORT: TSPIGPIO absolute PORTB;
  SPI_DDR: TSPIGPIO absolute DDRB;

  i, j: byte;
  p: uint16 = 0;
  Counter: uint16 = 0;
  Data: array[0..1] of byte;

begin
  SPI_DDR.DataOut := True;
  SPI_DDR.Clock := True;
  SPI_DDR.SlaveSelect := True;

  repeat
    //Data[0] := 1 shl p;
    //if Counter > 37 then begin
    //  Data[1] := Smily[0, p];
    //  //      Data[1] := %1010101010;
    //end else begin
    //  Data[1] := Smily[1, p];
    //  //      Data[1] := %0101010101;
    //end;
    //
    //Inc(p);
    //if p >= 8 then begin
    //  p := 0;
    //  Inc(counter);
    //  if Counter >= 75 then begin
    //    counter := 0;
    //  end;
    //end;


    Inc(p);
    if p >= 8 then begin
      p := 0;
    end;

    Data[0] := 1 shl p;
    if Counter > 300 then begin
      Data[1] := Smily[0, p];
      //      Data[1] := %1010101010;
    end else begin
      Data[1] := Smily[1, p];
      //      Data[1] := %0101010101;
    end;

    Inc(Counter);
    if Counter >= 600 then begin
      Counter := 0;
    end;

    SPI_Port.SlaveSelect := False;
    for j := 1 downto 0 do begin
      for i := 7 downto 0 do begin
        SPI_Port.DataOut := (Data[j] and (1 shl i)) <> 0;

        SPI_Port.Clock := True;
        SPI_Port.Clock := False;
      end;
    end;
    SPI_Port.SlaveSelect := True;

  until False;
end.
