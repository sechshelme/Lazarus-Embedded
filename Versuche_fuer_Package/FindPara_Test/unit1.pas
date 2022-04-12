unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Edit1: TEdit;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

function FindPara(const Source: string; Sub: string; FirstSpace: boolean = True): string;
var
  p, Index: integer;
begin
  if FirstSpace then begin
    sub := ' ' + Sub;
  end;
  p := pos(Sub, Source);
  while Copy(Source, p + Length(Sub), 1) = ' ' do begin
    Inc(p);
  end;
  Result := '';
  if p > 0 then begin
    p += Length(Sub);
    Index := p;
    while (Index <= Length(Source)) and (Source[Index] > #32) do begin
      Result += Source[Index];
      Inc(Index);
    end;
  end;
  Result := '*' + Result + '*';
end;

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
  Memo1.Clear;
  Edit1.Text := '/usr/bin/avrdude -C/etc/av-prdude.conf -v -x           -p           atmega328p -c arduino -P/dev/ttyACM0 -b115200 -U flash:w:Project1.hex:i';
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  s: string;
begin
  s := Edit1.Text;
  Memo1.Lines.Add(FindPara(s, '-C'));
  Memo1.Lines.Add(FindPara(s, '-p'));
  Memo1.Lines.Add(FindPara(s, '-c'));
  Memo1.Lines.Add(FindPara(s, '-P'));
  Memo1.Lines.Add(FindPara(s, '-b'));
  Memo1.Lines.Add(FindPara(s, '-U'));
  Memo1.Lines.Add(FindPara(s, '-x'));
end;




end.
