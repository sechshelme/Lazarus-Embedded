unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls,
  SynHighlighterPas, SynEdit;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    SynEdit1: TSynEdit;
    SynPasSyn1: TSynPasSyn;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
  SynEdit1.ScrollBars := ssAutoBoth;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  sl: TStringList;
  SubArchList:String='';
  s: string;
  i: integer;
begin
  SynEdit1.Clear;
  sl := TStringList.Create;

  sl.LoadFromFile('/home/tux/fpc.src/fpc/rtl/embedded/Makefile');


  for i := 0 to sl.Count - 1 do begin
    s := sl[i];
    if pos('ifeq ($(SUBARCH),avr', s) > 0 then begin
      Delete(s, 1, 17);
      Delete(s, Length(s), 1);
      SubArchList+=s+',';
    end;
  end;
  Delete(SubArchList, Length(SubArchList), 1);
  SynEdit1.Lines.Add('const');
  SynEdit1.Lines.Add('  SubArchList = ''' + SubArchList + ''';');

  sl.Free;
end;

end.


