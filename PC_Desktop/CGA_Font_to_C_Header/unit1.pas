unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Image1: TImage;
    Image2: TImage;
    procedure Button1Click(Sender: TObject);
    procedure FormPaint(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.Button1Click(Sender: TObject);
var
  i, x, y: integer;
  b: byte;
  f: Text;
const
  max = 128;
begin
  Image1.Picture.LoadFromFile('cga.bmp');
  Image1.Width := Image1.Picture.Width;
  Image1.Height := Image1.Picture.Height;

  Image2.Width := 256 * 8;
  Image2.Height := 8;
  Image2.Picture.Bitmap.Width := Image2.Width;
  Image2.Picture.Bitmap.Height := Image2.Height;


  with Image2.Picture.Bitmap do begin
    Canvas.Brush.Color := clRed;
    Canvas.FillRect(0, 0, Width, Height);
  end;


  for i := 0 to 7 do begin
    Image2.Picture.Bitmap.Canvas.CopyRect(Rect(i * 256, 0, i * 256 + 256, 8),
      Image1.Picture.Bitmap.Canvas, Rect(0, i * 8, 256, i * 8 + 8));
  end;

  WriteLn(Image1.Picture.Bitmap.PixelFormat);
  WriteLn(Image2.Picture.Bitmap.PixelFormat);
  WriteLn(clWhite);
  WriteLn(clBlack);

  AssignFile(f, '/n4800/DATEN/Programmierung/Arduino/Eclipse/Laufschrift/cgafont.h');
  Rewrite(f);

  WriteLn(f, '/* Wird automatishc generiert */' + LineEnding);

  WriteLn(f, '#ifndef CGAFONT_H_');
  WriteLn(f, '#define CGAFONT_H_' + LineEnding);

  WriteLn(f, 'unsigned char maxChar = ', max, ';'+LineEnding);

  WriteLn(f, 'unsigned char cgafont[', max, '][8]={');
  for i := 0 to max - 1 do begin

    Write(f, '    { ');
    for x := 0 to 7 do begin

      b := 0;
      for y := 0 to 7 do begin
        if Image2.Picture.Bitmap.Canvas.Pixels[i * 8 + x, y] = clBlack then begin
          b := b + (1 shl y);
        end;
      end;

      Write(f, b: 4);
      if x <> 7 then begin
        Write(f, ',');
      end;
    end;
    Write(f, ' }');
    //    if i <> 255 then begin
    Write(f, ',');
    //    end else begin
    //      Write(f, ' ');
    //    end;
    Write(f, '    // ', i: 4);
    WriteLn(f);
  end;

  WriteLn(f, '};' + LineEnding);


  WriteLn(f, '#endif /* CGAFONT_H_ */');

  CloseFile(f);

end;

procedure TForm1.FormPaint(Sender: TObject);
begin
end;


end.
