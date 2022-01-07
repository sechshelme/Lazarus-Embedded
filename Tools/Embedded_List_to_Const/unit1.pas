unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  //  Embedded_GUI_SubArch_List,
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, EditBtn,
  Buttons, FileUtil, SynEdit, SynHighlighterPas, IniFiles;

type

  { TForm1 }

  TForm1 = class(TForm)
    Close_Btn: TBitBtn;
    Generate_BitBtn: TBitBtn;
    DirectoryEdit1: TDirectoryEdit;
    SynEdit1: TSynEdit;
    SynPasSyn1: TSynPasSyn;
    procedure Generate_BitBtnClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    function FindText(s: string; var ofs: integer): string;
    function Comma(sl: TStringList): string;
    function ControllerDataType(s: string): string;
    function AddSubArch(sl: TStrings; cpu: string): TStringList;
    function AddNewCommaText(sl: TStrings): string;
    procedure AddCPUData(sl, SubArchList: TStrings; cpu: string);
    procedure AddControllerDataList(sl: TStrings; cpu: string);
  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
var
  ini: TIniFile;
begin
  ini := TIniFile.Create('config.ini');
  Left := ini.ReadInteger('pos', 'Left', 100);
  Width := ini.ReadInteger('pos', 'Width', 500);
  Top := ini.ReadInteger('pos', 'Top', 50);
  Height := ini.ReadInteger('pos', 'Height', 400);
  DirectoryEdit1.Directory := ini.ReadString('options', 'path', '/home/tux/fpc.src/fpc');
  ini.Free;
  SynEdit1.ScrollBars := ssAutoBoth;
end;

procedure TForm1.FormClose(Sender: TObject; var CloseAction: TCloseAction);
var
  ini: TIniFile;
begin
  ini := TIniFile.Create('config.ini');
  ini.WriteInteger('pos', 'Left', Left);
  ini.WriteInteger('pos', 'Width', Width);
  ini.WriteInteger('pos', 'Top', Top);
  ini.WriteInteger('pos', 'Height', Height);
  ini.WriteString('options', 'path', DirectoryEdit1.Directory);
  ini.Free;
end;

function TForm1.Comma(sl: TStringList): string;
begin
  Result := sl.CommaText;
  Result := StringReplace(Result, ',', #39', '#39, [rfReplaceAll, rfIgnoreCase]);
  Result := StringReplace(Result, 'cpu_', '', [rfReplaceAll, rfIgnoreCase]);
  Result := StringReplace(Result, 'fpu_', '', [rfReplaceAll, rfIgnoreCase]);
end;

function TForm1.FindText(s: string; var ofs: integer): string;
begin
  while not (s[ofs] in ['0'..'9', 'a'..'z', 'A'..'Z', '_', '$']) do begin
    Inc(ofs);
  end;
  Result := '';
  repeat
    Result += s[ofs];
    Inc(ofs);
  until not (s[ofs] in ['0'..'9', 'a'..'z', 'A'..'Z', '_', '$']);
end;

function TForm1.ControllerDataType(s: string): string;
var
  ofs: integer;
  s1: string;
begin
  ofs := Pos('tcontrollerdatatype', s);
  Inc(ofs, 19);
  FindText(s, ofs);
  s1 := FindText(s, ofs);
  Result := s1;
  repeat
    while not (s[ofs] in [';', ',']) do begin
      Inc(ofs);
    end;
    s1 := FindText(s, ofs);
    if s1 <> 'end' then begin
      Result += #39', '#39 + s1;
    end;
  until s1 = 'end';
end;

function TForm1.AddSubArch(sl: TStrings; cpu: string): TStringList;
var
  source_SL: TStringList;
  p: integer;
  s, s1: string;
  sa: TStringArray;
begin
  Result := TStringList.Create;
  if Pos('generic', cpu) > 0 then begin
    Exit;
  end;
  source_SL := TStringList.Create;
  source_SL.LoadFromFile(cpu);
  s := source_SL.Text;
  source_SL.Free;
  p := Pos('cputypestr', s);
  if p > 0 then begin
    while s[p] <> ')' do begin
      Inc(p);
      if s[p] = #39 then begin
        Inc(p);
        if s[p] <> #39 then begin
          s1 := '';
          repeat
            s1 += s[p];
            Inc(p);
          until s[p] = #39;
          Result.Add(s1);
        end;
      end;
    end;

    sa := cpu.Split('/');
    if Length(sa) >= 2 then begin
      sl.Add('const');
      sl.Add('  ' + sa[Length(sa) - 2] + '_SubArch_List = ');
      sl.Add('    '#39 + Result.CommaText + #39 + ';');
    end;

  end;
end;

function TForm1.AddNewCommaText(sl: TStrings): string;
var
  i: integer;
begin
  if sl.Count = 0 then begin
    Result := '    '#39#39',';
  end else begin
    Result := '    ' + #39;
    for i := 0 to sl.Count - 1 do begin
      Result := Result + sl[i] + ',';
      if (i <> sl.Count - 1) and (i mod 4 = 3) then begin
        Result += #39 + ' +' + LineEnding + '    ' + #39;
      end;

    end;
    Delete(Result, Length(Result), 1);
    Result := Result + #39 + ',';
  end;
end;

procedure TForm1.AddCPUData(sl, SubArchList: TStrings; cpu: string);
var
  source_SL: TStringList;
  SubArchData: array of TStringList;
  ofs, i: integer;
  s, s1, s2: string;
  sa: TStringArray;
begin
  if Pos('generic', cpu) > 0 then begin
    Exit;
  end;
  source_SL := TStringList.Create;
  source_SL.LoadFromFile(cpu);
  s := source_SL.Text;
  source_SL.Free;
  SetLength(SubArchData, SubArchList.Count);
  for i := 0 to Length(SubArchData) - 1 do begin
    SubArchData[i] := TStringList.Create;
  end;
  ofs := 1;
  ofs := Pos('embedded_controllers', s, ofs);
  if ofs > 0 then begin
    while ofs > 0 do begin
      ofs := Pos('controllertypestr', s, ofs);
      if ofs > 0 then begin
        s1 := '';
        s2 := '';
        ofs := Pos(#39, s, ofs);
        Inc(ofs);
        if s[ofs] <> #39 then begin
          repeat
            s1 += s[ofs];
            Inc(ofs);
          until s[ofs] = #39;

          ofs := Pos('cpu_', s, ofs);
          Inc(ofs, 4);
          repeat
            s2 += s[ofs];
            Inc(ofs);
          until not (s[ofs] in ['0'..'9', 'a'..'z', 'A'..'Z', '_']);

          i := 0;

          while UpCase(s2) <> UpCase(SubArchList[i]) do begin
            Inc(i);
          end;

          SubArchData[i].Add(s1);
        end;
      end;
    end;

    sa := cpu.Split('/');
    if Length(sa) >= 2 then begin
      sl.Add('');
      sl.Add('  ' + sa[Length(sa) - 2] + '_List: array of string = (');
    end;

    for i := 0 to Length(SubArchData) - 1 do begin
      sl.Add('');
      sl.Add('    // ' + SubArchList[i]);
      sl.Add(AddNewCommaText(SubArchData[i]));
    end;
    s := sl[sl.Count - 1];
    Delete(s, Length(s), 1);
    sl[sl.Count - 1] := s + ');';
    sl.Add('');
  end;

  for i := 0 to Length(SubArchData) - 1 do begin
    SubArchData[i].Free;
  end;
end;

procedure TForm1.AddControllerDataList(sl: TStrings; cpu: string);
var
  source_SL, sl1: TStringList;
  ofs: integer;
  s, s1: string;
  sa: TStringArray;
begin
  if Pos('generic', cpu) > 0 then begin
    Exit;
  end;
  source_SL := TStringList.Create;
  sl1 := TStringList.Create;
  source_SL.LoadFromFile(cpu);
  s := source_SL.Text;
  source_SL.Free;

  sa := cpu.Split('/');
  if Length(sa) >= 2 then begin
    sl.Add('');
    s1 := sa[Length(sa) - 2];
    sl.Add('type');
    sl.Add('  T' + s1 + '_ControllerDataList = array of array of String;');
    sl.Add('');
    sl.Add('const');
    sl.Add('  ' + s1 + '_ControllerDataList : T' + s1 + '_ControllerDataList = (');
  end;

  ofs := Pos('embedded_controllers', s);
  sl.Add('    ('#39 + ControllerDataType(s) + #39'),');

  if ofs > 0 then begin
    while (ofs > 0) do begin
      ofs := Pos('(', s, ofs);
      ofs := Pos('(', s, ofs);

      repeat
        FindText(s, ofs);
        while not (s[ofs] in [';', ')']) do begin
          Inc(ofs);
        end;
      until s[ofs] = ')';

      repeat
        Inc(ofs);
      until s[ofs] in [',', ')'];

      if s[ofs] = ',' then begin
        repeat
          repeat
            ofs := Pos(':', s, ofs);

            sl1.Add(FindText(s, ofs));

            while not (s[ofs] in [';', ')']) do begin
              Inc(ofs);
            end;
            while not (s[ofs] in ['0'..'9', 'a'..'z', 'A'..'Z', '_', '+', '-', '*', '/', '$', ')']) do begin

              Inc(ofs);
            end;
          until s[ofs] = ')';

          sl.Add('    ('#39 + Comma(sl1) + #39'),');
          sl1.Clear;
          repeat
            Inc(ofs);
          until s[ofs] in [',', ')'];
        until s[ofs] = ')';
      end;

      ofs := Pos('embedded_controllers', s, ofs);
    end;
    s := sl[sl.Count - 1];
    Delete(s, Length(s), 1);
    sl[sl.Count - 1] := s + ');';
  end;

  sl1.Free;
end;

procedure TForm1.Generate_BitBtnClick(Sender: TObject);
const
  UName = 'Embedded_GUI_Embedded_List_Const';
var
  i: integer;
  CPU_SL, SubArchList: TStringList;
begin
  CPU_SL := TStringList.Create;
  FindAllFiles(CPU_SL, DirectoryEdit1.Directory, 'cpuinfo.pas', True);
  SynEdit1.Clear;

  SynEdit1.Lines.Add('');
  SynEdit1.Lines.Add('// Diese Unit wird automatisch durch das Tool "./Tool/Embedded_List_to_const" erzeugt.');
  SynEdit1.Lines.Add('// Die Arrays werden aus "./fpc.src/fpc/compiler/avr/cpuinfo.pas" und');
  SynEdit1.Lines.Add('// "./fpc.src/fpc/compiler/arm/cpuinfo.pas" importiert.');
  SynEdit1.Lines.Add('');
  SynEdit1.Lines.Add('unit ' + UName + ';');
  SynEdit1.Lines.Add('');
  SynEdit1.Lines.Add('interface');
  SynEdit1.Lines.Add('');

  for i := 0 to CPU_SL.Count - 1 do begin
    SubArchList := AddSubArch(SynEdit1.Lines, CPU_SL[i]);
    if pos('aarch64', CPU_SL[i]) = 0 then begin
      AddCPUData(SynEdit1.Lines, SubArchList, CPU_SL[i]);
    end else begin
      SynEdit1.Lines.Add('');
      SynEdit1.Lines.Add('// Warnung wurde (noch) nicht unterstützt !!!!!!');
      SynEdit1.Lines.Add('// cpuinfp.pas von aarch64 ist anders aufgebaut, daher kann Embedded_GUI_Embedded_List_Const.pas nicht gebaut werden !!!!!!');
      SynEdit1.Lines.Add('');
    end;

    SubArchList.Free;
  end;

  for i := 0 to CPU_SL.Count - 1 do begin
    AddControllerDataList(SynEdit1.Lines, CPU_SL[i]);
  end;

  SynEdit1.Lines.Add('');
  SynEdit1.Lines.Add('implementation');
  SynEdit1.Lines.Add('');
  SynEdit1.Lines.Add('begin');
  SynEdit1.Lines.Add('end.');

  SynEdit1.Lines.SaveToFile('../../Lazarus_AVR_ARM_Embedded_GUI_Package/' + LowerCase(UName) + '.pas');
//  SynEdit1.Lines.SaveToFile('../../Lazarus_Arduino_AVR_GUI_Package/' + LowerCase(UName) + '.pas');
  CPU_SL.Free;
end;

end.
