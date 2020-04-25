unit sm_unit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls, Menus,
  LazFileUtils, SynEdit;

type

  { TSerial_Monitor_Form }

  TSerial_Monitor_Form = class(TForm)
    AutoScroll_CheckBox1: TCheckBox;
    Memo1: TMemo;
    Timer1: TTimer;
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);

  public
  end;

var
  Serial_Monitor_Form: TSerial_Monitor_Form;

implementation

{$R *.lfm}

{ TSerial_Monitor_Form }

procedure TSerial_Monitor_Form.FormCreate(Sender: TObject);
begin
  Memo1.ScrollBars := ssAutoBoth;
  Memo1.WordWrap := False;
  Memo1.ParentFont := False;

  Timer1.Interval := 200;
  Timer1.Enabled := True;
end;

procedure TSerial_Monitor_Form.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  Timer1.Enabled := False;
end;

function GetChar: char;
var
  b: byte;
begin
  b := random(26) + 97;
  Result := char(b);
end;

function GetString: string;
const
  nr: integer = 0;
var
  i: integer;
  s: string;
begin
  Result := '';
  for i := 0 to Random(80) do begin
    Result += GetChar;
    if Random(10) = 0 then begin
      Result += ' ';
    end;
    if Random(50) = 0 then begin
      str(nr: 8, s);
      Inc(nr);
      Result += LineEnding + s + ':';
    end;
  end;
end;

procedure TSerial_Monitor_Form.Timer1Timer(Sender: TObject);
var
  StringCount: integer;
  s: string;
begin
  Timer1.Enabled := False;
  s := GetString;  // Zufällig erzeugter String

  StringCount := Memo1.Lines.Count - 1;
  Memo1.Lines[StringCount] := Memo1.Lines[StringCount] + s;
//  Memo1.Lines.Append(s);

  //  Memo1.Lines.Text:=Memo1.Lines.Text+s;

  if AutoScroll_CheckBox1.Checked then begin
    Memo1.SelStart := -2;
  end;
  Timer1.Enabled := True;
end;

end.
