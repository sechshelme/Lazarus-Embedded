unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormPaint(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

type
  T1Bit = 0..1;
  T2Bit = 0..3;
  T3Bit = 0..7;
  T4Bit = 0..15;
  TBitInt = bitpacked record
    case byte of
      0: (b3: T3Bit;
        b4: T4Bit;);
      1: (Value: UInt16);
  end;

var
  BitInt: TBitInt;

procedure TForm1.Button1Click(Sender: TObject);
begin
  BitInt.b4 := %1001;
  Repaint;
end;

procedure TForm1.FormPaint(Sender: TObject);
const
  r = 10;
var
  i: integer;
begin
  for i := 0 to 15 do begin
    if BitInt.Value and (1 shl i) = 1 shl i then begin
      Canvas.Brush.Color := clRed;
    end else begin
      Canvas.Brush.Color := clYellow;
    end;
    Canvas.Ellipse((16 - i) * r, r, (16 - i) * r + 10, r * 2);
  end;
end;

end.
