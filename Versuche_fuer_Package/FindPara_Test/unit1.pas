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

function FindPara(const Source: string; Sub: TStringArray; InsertFirstSpace: boolean = True): string;
var
  p, i, Index: integer;
begin
  Result := '';
  i := 0;
  while (i < Length(Sub)) and (Result = '') do begin
    if InsertFirstSpace then begin
      sub[i] := ' ' + Sub[i];
    end;
    p := pos(Sub[i], Source);
    while Copy(Source, p + Length(Sub[i]), 1) = ' ' do begin
      Inc(p);
    end;
    if p > 0 then begin
      p += Length(Sub[i]);
      Index := p;
      while (Index <= Length(Source)) and (Source[Index] > #32) do begin
        Result += Source[Index];
        Inc(Index);
      end;
    end;
    Inc(i);
  end;
  Result := '*' + Result + '*';
end;

function FindPara(const Source: string; Sub: string; InsertFirstSpace: boolean = True): string;
begin
  Result := FindPara(Source, [Sub], InsertFirstSpace);
end;

function FindBossacPara(Source, SubShort, SubLong: string): boolean;
begin
  Source := Source + ' ';
  if (Pos(SubShort + ' ', Source) > 0) or (Pos(SubLong + '=1 ', Source) > 0) or (Pos(SubLong + ' ', Source) > 0) then begin
    Result := True;
  end else begin
    Result := False;
  end;
end;

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
  Memo1.Clear;
  Edit1.Text := '/usr/bin/avrdude -C/etc/av-prdude.conf -v -x           -p           atmega328p -c arduino -P/dev/ttyACM0 -b115200 -U flash:w:Project1.hex:i';
  Edit1.Text :=
    '/bin/python3 -yhallo -I /n4800/DATEN/Programmierung/Lazarus/Tutorials/Embedded/Xtensa/ESP8266/UP_Loader/upload.py --chipesp8266 --port /dev/ttyUSB0 --baud 115200 --before default_reset --after hard_reset write_flash 0x0 /n4800/DATEN/Programmierung/Lazarus/Tutorials/Embedded/Xtensa/ESP8266/Erster_Versuch/Project1.bin';
  Edit1.Text := '/bin/bossac -v --boot=1 -s -R -a -w Project1.bin';
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  s: string;
begin
  s := Edit1.Text;
  Memo1.Lines.Add(FindPara(s, '-y'));
  Memo1.Lines.Add(FindPara(s, ['-p']));
  Memo1.Lines.Add(FindPara(s, ['-c']));
  Memo1.Lines.Add(FindPara(s, ['-P']));
  Memo1.Lines.Add(FindPara(s, ['-b']));
  Memo1.Lines.Add(FindPara(s, ['-U']));
  Memo1.Lines.Add(FindPara(s, ['-x']));
  Memo1.Lines.Add(FindPara(s, ['--chip', '-c']));
  Memo1.Lines.Add(FindPara(s, ['-c', '--chip']));
  Memo1.Lines.Add(FindPara(s, ['--port', '-p']));
  Memo1.Lines.Add(FindPara(s, ['--baud', '-b']));

  if FindBossacPara(s, '-b', '--boot') then begin
    Memo1.Lines.Add('True');
  end else begin
    Memo1.Lines.Add('False');
  end;
  if FindBossacPara(s, '-c', '--bod') then begin
    Memo1.Lines.Add('True');
  end else begin
    Memo1.Lines.Add('False');
  end;
end;




end.
