unit Unit1;

{$mode objfpc}{$H+}

interface

uses
//  Embedded_GUI_SubArch_List,
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, EditBtn,
  Buttons, FileUtil, SynEdit, SynHighlighterPas;

type

  { TForm1 }

  TForm1 = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    DirectoryEdit1: TDirectoryEdit;
    SynEdit1: TSynEdit;
    SynPasSyn1: TSynPasSyn;
    procedure BitBtn2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    procedure AddSubArch(sl: TStrings; cpu: string);
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
  DirectoryEdit1.Directory := '/home/tux/fpc.src/fpc';
end;

procedure TForm1.AddSubArch(sl: TStrings; cpu: string);
var
  source_SL: TStringList;
  p: integer;
  s, s1: string;
  sa: TStringArray;
begin
  if Pos('generic', cpu) > 0 then begin
    Exit;
  end;
  source_SL := TStringList.Create;
  source_SL.LoadFromFile(cpu);
  s := source_SL.Text;
  p := Pos('cputypestr', s);
  s1 := '';
  if p > 0 then begin
    repeat
      Inc(p);
    until s[p] = #39;
    Inc(p);
    while s[p] <> ')' do begin
      Inc(p);
      if s[p] = #39 then begin
        Inc(p);

        repeat
          s1 += s[p];
          Inc(p);
        until s[p] = #39;
        s1 += ',';
      end;

    end;
    Delete(s1, Length(s1) - 1, 2); // Letztes Komma löschen

    sa := cpu.Split('/');
    if Length(sa) >= 2 then begin
      sl.Add('const');
      sl.Add('  ' + sa[Length(sa) - 2] + '_SubArch_List = ');
      sl.Add('    '#39 + s1 + #39 + ';');
      sl.Add('');
    end;

  end;
  source_SL.Free;
end;

procedure TForm1.BitBtn2Click(Sender: TObject);
var
  i: integer;
  CPU_SL: TStringList;
begin
  CPU_SL := TStringList.Create;
  FindAllFiles(CPU_SL, DirectoryEdit1.Directory, 'cpuinfo.pas', True);
  SynEdit1.Clear;

  SynEdit1.Lines.Add('');
  SynEdit1.Lines.Add(
    '// Diese Unit wird automatisch durch das Tool "./Tool/Embedded_List_to_const" erzeugt.');
  SynEdit1.Lines.Add('// Die Arrays werden aus "./fpc.src/fpc/compiler/avr/cpuinfo.pas" und');
  SynEdit1.Lines.Add('// "./fpc.src/fpc/compiler/arm/cpuinfo.pas" importiert.');
  SynEdit1.Lines.Add('');
  SynEdit1.Lines.Add('unit');
  SynEdit1.Lines.Add('  Embedded_GUI_SubArch_List;');
  SynEdit1.Lines.Add('');
  SynEdit1.Lines.Add('interface');
  SynEdit1.Lines.Add('');

  for i := 0 to CPU_SL.Count - 1 do begin
    AddSubArch(SynEdit1.Lines, CPU_SL[i]);
  end;

  SynEdit1.Lines.Add('');
  SynEdit1.Lines.Add('implementation');
  SynEdit1.Lines.Add('');
  SynEdit1.Lines.Add('begin');
  SynEdit1.Lines.Add('end.');

  SynEdit1.Lines.SaveToFile('embedded_gui_subarch_list.pas');
  // SynEdit1.Lines.SaveToFile('../../Lazarus_Arduino_AVR_GUI_Package/embedded_gui_subarch_list.pas');
  CPU_SL.Free;
end;

end.
