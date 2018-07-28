unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls;

type

  { T7Segment }

  T7Segment = class(TPanel)
    procedure Draw(DigitValue: byte);
  end;


  { TForm1 }

  TForm1 = class(TForm)
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    Panel: array of T7Segment;
    Digit: array of byte;
  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
const
  w = 40;
  h = w * 2;
var
  i: integer;
begin
  SetLength(Digit, 4);
  SetLength(Panel, Length(Digit));
  for i := 0 to Length(Panel) - 1 do begin
    Panel[i] := T7Segment.Create(Self);
    with Panel[i] do begin
      Color := clBlack;
      Width := w;
      Left := (w + 4) * i;
      Height := h;
      Parent := Self;
    end;
  end;
end;

procedure TForm1.FormPaint(Sender: TObject);
var
  i: integer;
begin
  for i := 0 to Length(Panel) - 1 do begin
    with Panel[i] do begin
      Draw(Digit[i]);
    end;
  end;
end;


procedure TForm1.Timer1Timer(Sender: TObject);

  procedure ModDivDigit(val: UInt16);
  begin
    Digit[0] := val div 1000;
    Digit[1] := val div 100 mod 10;
    Digit[2] := val div 10 mod 10;
    Digit[3] := val mod 10;
  end;

  procedure ModDivDigitHex(val: UInt16);
  begin
    Digit[0] := val shr 12;
    Digit[1] := val shr 8 and %1111;
    Digit[2] := val shr 4 and %1111;
    Digit[3] := val and %1111;
  end;

  procedure IntToDigit(val: UInt16);
  var
    achr: byte;
    leer: boolean;
  begin
    achr := 0;
    leer := True;
    while (val >= 1000) do begin
      Dec(val, 1000);
      Inc(achr);
      leer := False;
    end;
    if leer then begin
      achr := 16;
    end;
    Digit[0] := achr;

    achr := 0;
    while (val >= 100) do begin
      Dec(val, 100);
      Inc(achr);
      leer := False;
    end;
    if leer then begin
      achr := 16;
    end;
    Digit[1] := achr;

    achr := 0;
    while (val >= 10) do begin
      Dec(val, 10);
      Inc(achr);
      leer := False;
    end;
    if leer then begin
      achr := 16;
    end;
    Digit[2] := achr;

    achr := 0;
    while (val >= 1) do begin
      Dec(val);
      Inc(achr);
    end;
    Digit[3] := achr;
  end;

const
  MyValue: UInt16 = 0;
begin
  Inc(MyValue);
  //  if MyValue >= 2000 then begin
  //    MyValue := 0;
  //  end;
  //  IntToDigit(MyValue);

  ModDivDigitHex(MyValue);

  Invalidate;
  //  Repaint;

end;

{ T7Segment }

procedure T7Segment.Draw(DigitValue: byte);
const
  DigitMaske: packed array[0..16] of byte = (
    %00111111,  // = 0
    %00000110,  // = 1
    %01011011,  // = 2
    %01001111,  // = 3
    %01100110,  // = 4
    %01101101,  // = 5
    %01111101,  // = 6
    %00000111,  // = 7
    %01111111,  // = 8
    %01100111,  // = 9
    %01110111,  // = a
    %01111100,  // = b
    %00111001,  // = c
    %01011110,  // = d
    %01111001,  // = e
    %01110001,  // = f
    %00000000); // blank
  r = 6;
var
  p: byte;

begin
  if DigitValue >= Length(DigitMaske) then begin
    Exit;
  end;
  p := DigitMaske[DigitValue];
  Canvas.Pen.Width := 5;
  Canvas.Pen.Color := clYellow;

  // A
  if p and %00000001 = %00000001 then begin
    Canvas.Line(r * 2, r, Width - r * 2, r);
  end;

  // B
  if p and %00000010 = %00000010 then begin
    Canvas.Line(Width - r, r * 2, Width - r, Height div 2 - r);
  end;

  // C
  if p and %00000100 = %00000100 then begin
    Canvas.Line(Width - r, Height div 2 + r, Width - r, Height - r * 2);
  end;

  // D
  if p and %00001000 = %00001000 then begin
    Canvas.Line(r * 2, Height - r, Width - r * 2, Height - r);
  end;

  // E
  if p and %00010000 = %00010000 then begin
    Canvas.Line(r, Height div 2 + r, r, Height - r * 2);
  end;

  // F
  if p and %00100000 = %00100000 then begin
    Canvas.Line(r, r * 2, r, Height div 2 - r);
  end;

  // G
  if p and %01000000 = %01000000 then begin
    Canvas.Line(r * 2, Height div 2, Width - r * 2, Height div 2);
  end;

end;

end.
