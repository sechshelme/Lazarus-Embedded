unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls,
  SynHighlighterPas, SynEdit, AVR_CPUInfo, ARM_CPUInfo;

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
    procedure GenerateARM(sl: TStrings);
    procedure GenerateAVR(sl: TStrings);
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

procedure TForm1.GenerateAVR(sl: TStrings);
var
  cpt:AVR_CPUInfo.tcputype;
  cdt : AVR_CPUInfo.tcontrollertype;
  s:String='';
  s2:String='';
  sarr:array[AVR_CPUInfo.tcputype] of String;
begin
  for cpt in AVR_CPUInfo.tcputype do begin
    Str(cpt, s);
    s2:=s2+Copy(s, 5)+',';
    sarr[cpt]:='';
  end;
  Delete(s2, Length(s2), 1);
  sl.Add('  AVR_SubArch_List = '#39 + s2 + #39 + ';');
  sl.Add('');
  for cdt in AVR_CPUInfo.tcontrollertype do begin
    sarr[AVR_CPUInfo.embedded_controllers[cdt].cputype] += AVR_CPUInfo.embedded_controllers[cdt].controllertypestr + ',';
  end;

  sl.Add('  AVR_List: array of string = (');
  for cpt in AVR_CPUInfo.tcputype do begin
    sl.Add('');
    Str(cpt, s);
    sl.Add('    // ' + Copy(s, 5));
    sl.Add('    '#39 +  Copy(sarr[cpt], 1, Length(sarr[cpt]) - 1) + #39 + ',');
  end;
  s := sl[sl.Count - 1];
  Delete(s, Length(s), 1);
  sl[sl.Count - 1] := s;

  sl.Add('  );');
end;

procedure TForm1.GenerateARM(sl: TStrings);
var
  cpt:ARM_CPUInfo.tcputype;
  cdt : ARM_CPUInfo.tcontrollertype;
  s:String='';
  s2:String='';
  sarr:array[ARM_CPUInfo.tcputype] of String;
begin
  for cpt in ARM_CPUInfo.tcputype do begin
    Str(cpt, s);
    s2:=s2+Copy(s, 5)+',';
    sarr[cpt]:='';
  end;
  Delete(s2, Length(s2), 1);
  sl.Add('  ARM_SubArch_List = '#39 + s2 + #39 + ';');
  sl.Add('');
  for cdt in ARM_CPUInfo.tcontrollertype do begin
    sarr[ARM_CPUInfo.embedded_controllers[cdt].cputype] += ARM_CPUInfo.embedded_controllers[cdt].controllertypestr + ',';
  end;

  sl.Add('  ARM_List: array of string = (');
  for cpt in ARM_CPUInfo.tcputype do begin
    sl.Add('');
    Str(cpt, s);
    sl.Add('    // ' + Copy(s, 5));
    sl.Add('    '#39 +  Copy(sarr[cpt], 1, Length(sarr[cpt]) - 1) + #39 + ',');
  end;
  s := sl[sl.Count - 1];
  Delete(s, Length(s), 1);
  sl[sl.Count - 1] := s;

  sl.Add('  );');
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

  GenerateAVR(SynEdit1.Lines);
  SynEdit1.Lines.Add('');
  GenerateARM(SynEdit1.Lines);

//  FindSubArch('avr', SynEdit1.Lines);
//  FindSubArch('arm', SynEdit1.Lines);

  SynEdit1.Lines.Add('');
  SynEdit1.Lines.Add('implementation');
  SynEdit1.Lines.Add('');
  SynEdit1.Lines.Add('begin');
  SynEdit1.Lines.Add('end.');




  SynEdit1.Lines.SaveToFile('../../embedded_subarch_list.pas');

end;

end.
