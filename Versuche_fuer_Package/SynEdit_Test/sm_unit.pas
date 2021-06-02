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
    Button1: TButton;
    SynEdit1: TSynEdit;
    Timer1: TTimer;
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    TempSL: TStrings;
  public
  end;

var
  Serial_Monitor_Form: TSerial_Monitor_Form;

implementation

{$R *.lfm}

{ TSerial_Monitor_Form }

procedure TSerial_Monitor_Form.FormCreate(Sender: TObject);
begin
  SynEdit1.ScrollBars := ssAutoBoth;
  SynEdit1.ParentFont := False;

  TempSL := TStringList.Create;
  TempSL.LineBreak:=#13;

  Timer1.Interval := 200;
  Timer1.Enabled := True;
end;

procedure TSerial_Monitor_Form.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  Timer1.Enabled := False;
  TempSL.Free;
end;

procedure TSerial_Monitor_Form.Button1Click(Sender: TObject);
begin
  SynEdit1.SelStart := 10;
  SynEdit1.SelEnd := 20;
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
      //      str(nr: 8, s);
      //      Inc(nr);
      //      Result += LineEnding + s + ':';
      //Result += #13#10 + s + ':';
      //Result += #13 + s + ':';
    end;

  end;
  str(nr: 8, s);
  Inc(nr);
//  Result := #10 + s + Result + #13;
//Result := s + Result + #13#10;
//Result := #13#10 +s + Result;

Result := s + Result + #13;
//Result := #13 +s + Result;

end;

procedure TSerial_Monitor_Form.Timer1Timer(Sender: TObject);
var
  lc, i, SLCount: integer;
  s: string;
begin
  Timer1.Enabled := False;

  try
    s := GetString;  // Zufällig erzeugter String;
    if Length(s) < 1 then begin
      exit;
    end;
    //    ReadBuffer[bufCount] := 0; // Für PChar

    SLCount := SynEdit1.Lines.Count - 1;

    if SLCount >= 0 then begin
      TempSL.Text := SynEdit1.Lines[SLCount] + s;
      SynEdit1.Lines.Delete(SLCount);
    end else begin
      TempSL.Text := s;
    end;

    SynEdit1.Lines.AddStrings(TempSL);
    if s[Length(s)] = #13 then begin
      SynEdit1.Lines.Add('');
    end;

    if AutoScroll_CheckBox1.Checked then begin
      SynEdit1.CaretY := SynEdit1.Lines.Count;
    end;

  finally
    Timer1.Enabled := True;
  end;
end;

end.
