unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, Laufschrift, BaseUnix;

type

  TBall = record
    pos: TPoint;
    size: integer;
  end;

  TBalls = array of TBall;

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Label1: TLabel;
    Timer1: TTimer;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    Balls: TBalls;
    max: TPoint;
    maxBallSize: integer;

    I2CHandle: longint;
    vram: array of byte;
    procedure Repaint_I2C;
  public
    Laufschrift: TLaufschrift;
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

var
  i2C_Addr: longint = $04;
  comName, s: string;

const
  I2C_SLAVE = 1795;


procedure TForm1.FormCreate(Sender: TObject);
var
  l, i: integer;
begin
  Randomize;
  maxBallSize := 8;
  max.x := 64;
  max.y := 8;
  SetLength(vram, max.x);
  Laufschrift := TLaufschrift.Create(Self, Point(max.X, max.Y));
  Laufschrift.Parent := Self;
  l := 10;
  SetLength(Balls, l);
  for i := 0 to l - 1 do begin
    with Balls[i] do begin
      pos.x := Random(max.X);
      pos.y := Random(max.Y);
      size := Random(maxBallSize);
    end;
  end;

  I2CHandle := FpOpen('/dev/i2c-1', O_RDWR);
  if I2CHandle = -1 then begin
    ShowMessage('Kann I²C nicht öffnen, Error:' + IntToStr(I2CHandle));
  end;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  FpClose(I2CHandle);
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  Timer1.Enabled := not Timer1.Enabled;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  x, y: integer;
  b: boolean;
begin
  Laufschrift.Clear();
  for x := 0 to Label1.Width do begin
    for y := 0 to Label1.Height do begin
      b := byte (Label1.Canvas.Pixels[x, y]) > 100;
      WriteLn(byte (Label1.Canvas.Pixels[x, y]));
      Laufschrift.PutPixel(x, y, b);
    end;
  end;

end;

procedure TForm1.Timer1Timer(Sender: TObject);
var
  i: integer;
begin
  Laufschrift.Clear();
  for i := 0 to Length(Balls) - 1 do begin
    with Balls[i] do begin
      Laufschrift.FullCircle(pos.x, pos.y, size, True);
      if size >= 1 then begin
        Laufschrift.FullCircle(pos.x, pos.y, size - 1, False);
      end;

      Inc(size);
      if size > maxBallSize then begin
        size := 0;
        pos.x := Random(max.X);
        pos.y := Random(max.Y);
      end;
    end;

  end;
  Repaint_I2C;
end;

procedure TForm1.Repaint_I2C;
var
  x, y, p, l: integer;
  b: byte;
  buf: packed array[0..16] of byte;
begin
  fpIOCtl(I2CHandle, I2C_SLAVE, pointer(i2C_Addr));

  for p := 0 to 3 do begin
    buf[0] := p;
    for x := 0 to 15 do begin
      b := 0;
      for y := 0 to 7 do begin
        if Laufschrift.GetPixel(p * 16 + x, y) then begin

          b := b or (1 shl y);
        end;

      end;
      buf[x + 1] := b;

    end;
    FpWrite(I2CHandle, buf, 17);
  end;
end;

end.
