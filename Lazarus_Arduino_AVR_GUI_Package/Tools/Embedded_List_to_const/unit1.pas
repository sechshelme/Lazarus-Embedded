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
    procedure FindSubArch(Sub: String; l: TStrings);
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

  Caption:={$I %FPCVERSION%};
  Caption:=LCLVersion;
end;

procedure TForm1.FindSubArch(Sub: String; l: TStrings);
var
  AVR_List, SL_Source: TStringList;
  SubArchList:String='';
  SubArch, s, s2: string;
  i:Integer;

begin
  SL_Source := TStringList.Create;
  AVR_List := TStringList.Create;

  SL_Source.LoadFromFile('/home/tux/fpc.src/fpc/rtl/embedded/Makefile');

  i := 0;
  repeat
    s := SL_Source[i];
    if pos('ifeq ($(SUBARCH),'+Sub, s) > 0 then begin
      SubArch := s;
      Delete(SubArch, 1, 17);
      Delete(SubArch, Length(SubArch), 1);
      SubArchList += SubArch + ',';

      Inc(i);
      s := SL_Source[i];
      s2 := s;
      Delete(s2, 1, 10);
      if s2[Length(s2)] = '\' then begin
        Delete(s2, Length(s2), 1);
      end;
      s2 := StringReplace(s2, ' ', ',', [rfReplaceAll]);
      AVR_List.Add('    // ' + SubArch);
      AVR_List.Add('    '#39 + s2 + #39' +');

      while pos('\', s) > 0 do begin
        Inc(i);
        s := SL_Source[i];
        s2 := s;
        Delete(s2, 1, 3);
        if s2[Length(s2)] = '\' then begin
          Delete(s2, Length(s2), 1);
        end;
        s2 := StringReplace(s2, ' ', ',', [rfReplaceAll]);
        AVR_List.Add('    '#39 + s2 + #39' +');
      end;
      AVR_List[AVR_List.Count - 1] := StringReplace(AVR_List[AVR_List.Count - 1], ' +', ',', []);
      AVR_List.Add('');
    end;
    Inc(i);
  until i >= SL_Source.Count;

  s := AVR_List[AVR_List.Count - 2];
  Delete(s, Length(s), 1);
  AVR_List[AVR_List.Count - 2] := s;

  AVR_List.Delete(AVR_List.Count - 1);
  Delete(SubArchList, Length(SubArchList), 1);



  L.Add('  ' + Sub + '_SubArch_List = ''' + SubArchList + ''';');
  L.Add('');
  L.Add('  ' + Sub + '_List: array of string = (');
  L.Add('');


  for i := 0 to AVR_List.Count - 1 do begin
    L.Add(AVR_List[i]);
  end;
  L.Add(');');
  L.Add('');

  AVR_List.Free;
  SL_Source.Free;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  SynEdit1.Clear;

  SynEdit1.Lines.Add('');
  SynEdit1.Lines.Add('// Diese Unit wird automatisch durch das Tool "./Tool/Embedded_List_to_const" erzeugt.');
  SynEdit1.Lines.Add('// Die Arrays werden aus "./fpcsrc/fpc/rtl/embedded/Makefile" importiert.');
  SynEdit1.Lines.Add('');
  SynEdit1.Lines.Add('unit');
  SynEdit1.Lines.Add('  Embedded_SubArch_List;');
  SynEdit1.Lines.Add('');
  SynEdit1.Lines.Add('interface');
  SynEdit1.Lines.Add('');
  SynEdit1.Lines.Add('const');

  FindSubArch('avr', SynEdit1.Lines);
//  FindSubArch('arm', SynEdit1.Lines);

  SynEdit1.Lines.Add('');
  SynEdit1.Lines.Add('implementation');
  SynEdit1.Lines.Add('');
  SynEdit1.Lines.Add('begin');
  SynEdit1.Lines.Add('end.');

  SynEdit1.Lines.SaveToFile('../../embedded_subarch_list.pas');

end;

end.
