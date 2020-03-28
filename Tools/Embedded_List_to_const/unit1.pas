unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, EditBtn, FileUtil,
  SynHighlighterPas, SynEdit, AVR_CPUInfo, ARM_CPUInfo;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    DirectoryEdit1: TDirectoryEdit;
    SynEdit1: TSynEdit;
    SynPasSyn1: TSynPasSyn;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    procedure GenerateAVR(sl: TStrings);
    procedure GenerateAVR_Table(sl: TStrings);
    procedure GenerateARM(sl: TStrings);
    procedure GenerateARM_Table(sl: TStrings);
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
  DirectoryEdit1.Directory := '/home/tux/fpc.src/fpc/compiler';
end;


procedure TForm1.Button2Click(Sender: TObject);
var
  sl, sourceSL: TStringList;
  i: integer;
  path:String;
begin
  sourceSL:=TStringList.Create;
  path:=ExtractFileDir(ParamStr(0));
  Caption:=path;;
  sl := FindAllFiles(DirectoryEdit1.Directory, 'cpuinfo.pas', True);
  SynEdit1.Lines.Text := sl.Text;
  for i := 0 to sl.Count - 1 do begin
    sourceSL.LoadFromFile(sl[i]);
    sourceSL.Text:=StringReplace(sourceSL.Text,'end', 'ende', [rfReplaceAll, rfIgnoreCase]);
//    sourceSL.SaveToFile(path+'/src_mod/'+'cpuinfo.pas'+i.ToString);
  end;
  sl.Free;
  sourceSL.Free;
end;

procedure TForm1.GenerateAVR(sl: TStrings);
var
  cpt: AVR_CPUInfo.tcputype;
  cdt: AVR_CPUInfo.tcontrollertype;
  s: string = '';
  s2: string = '';
  sarr: array[AVR_CPUInfo.tcputype] of string;
begin
  for cpt in AVR_CPUInfo.tcputype do begin
    Str(cpt, s);
    s2 := s2 + Copy(s, 5) + ',';
    sarr[cpt] := '';
  end;
  Delete(s2, Length(s2), 1);
  sl.Add('const');
  sl.Add('  AVR_SubArch_List = '#39 + s2 + #39 + ';');
  sl.Add('');
  for cdt in AVR_CPUInfo.tcontrollertype do begin
    sarr[AVR_CPUInfo.embedded_controllers[cdt].cputype] +=
      AVR_CPUInfo.embedded_controllers[cdt].controllertypestr + ',';
  end;

  sl.Add('  AVR_List: array of string = (');
  for cpt in AVR_CPUInfo.tcputype do begin
    sl.Add('');
    Str(cpt, s);
    sl.Add('    // ' + Copy(s, 5));
    sl.Add('    '#39 + Copy(sarr[cpt], 1, Length(sarr[cpt]) - 1) + #39 + ',');
  end;
  s := sl[sl.Count - 1];
  Delete(s, Length(s), 1);
  sl[sl.Count - 1] := s;

  sl.Add('  );');
  sl.Add('');
end;

procedure TForm1.GenerateAVR_Table(sl: TStrings);
var
  cdt: AVR_CPUInfo.tcontrollertype;
  s: string;

  function getCPUType(cpu: AVR_CPUInfo.tcputype): string;
  begin
    Str(cpu, Result);
    Delete(Result, 1, 4);
  end;

  function getFPUType(cpu: AVR_CPUInfo.tfputype): string;
  begin
    Str(cpu, Result);
    Delete(Result, 1, 4);
  end;

begin
  sl.Add('type');
  sl.Add('  TAVRControllerDataList = array of array of String;');
  sl.Add('');
  sl.Add('const');
  sl.Add('  AVRControllerDataList : TAVRControllerDataList = (');
  sl.Add('  ('#39'controllertypestr'#39', '#39' controllerunitstr'#39', '#39' cputype'#39', '#39' fputype'#39', '#39' flashbase'#39',');
  sl.Add('   '#39'flashsize'#39', '#39' srambase'#39', '#39' sramsize'#39', '#39' eeprombase'#39', '#39' eepromsize'#39'),');

  for cdt in AVR_CPUInfo.tcontrollertype do begin
    s := '  ('#39 + AVR_CPUInfo.embedded_controllers[cdt].controllertypestr +
      #39', ' + #39 + AVR_CPUInfo.embedded_controllers[cdt].controllerunitstr +
      #39', ' + #39 + getCPUType(AVR_CPUInfo.embedded_controllers[cdt].cputype) +
      #39', ' + #39 + getFPUType(AVR_CPUInfo.embedded_controllers[cdt].fputype) +
      #39', ' + #39 + IntToStr(AVR_CPUInfo.embedded_controllers[cdt].flashbase) +
      #39', ' + #39 + IntToStr(AVR_CPUInfo.embedded_controllers[cdt].flashsize) +
      #39', ' + #39 + IntToStr(AVR_CPUInfo.embedded_controllers[cdt].srambase) +
      #39', ' + #39 + IntToStr(AVR_CPUInfo.embedded_controllers[cdt].sramsize) +
      #39', ' + #39 + IntToStr(AVR_CPUInfo.embedded_controllers[cdt].eeprombase) +
      #39', ' + #39 + IntToStr(AVR_CPUInfo.embedded_controllers[cdt].eepromsize) +
      #39'),';
    sl.Add(s);
  end;
  s := sl[sl.Count - 1];
  Delete(s, Length(s), 1);
  sl[sl.Count - 1] := s + ');';
end;

procedure TForm1.GenerateARM(sl: TStrings);
var
  cpt: ARM_CPUInfo.tcputype;
  cdt: ARM_CPUInfo.tcontrollertype;
  s: string = '';
  s2: string = '';
  sarr: array[ARM_CPUInfo.tcputype] of string;
begin
  for cpt in ARM_CPUInfo.tcputype do begin
    Str(cpt, s);
    s2 := s2 + Copy(s, 5) + ',';
    sarr[cpt] := '';
  end;
  Delete(s2, Length(s2), 1);
  sl.Add('const');
  sl.Add('  ARM_SubArch_List = '#39 + s2 + #39 + ';');
  sl.Add('');
  for cdt in ARM_CPUInfo.tcontrollertype do begin
    sarr[ARM_CPUInfo.embedded_controllers[cdt].cputype] +=
      ARM_CPUInfo.embedded_controllers[cdt].controllertypestr + ',';
  end;

  sl.Add('  ARM_List: array of string = (');
  for cpt in ARM_CPUInfo.tcputype do begin
    sl.Add('');
    Str(cpt, s);
    sl.Add('    // ' + Copy(s, 5));
    sl.Add('    '#39 + Copy(sarr[cpt], 1, Length(sarr[cpt]) - 1) + #39 + ',');
  end;
  s := sl[sl.Count - 1];
  Delete(s, Length(s), 1);
  sl[sl.Count - 1] := s;

  sl.Add('  );');
  sl.Add('');
end;

procedure TForm1.GenerateARM_Table(sl: TStrings);
var
  cdt: ARM_CPUInfo.tcontrollertype;
  s: string;

  function getCPUType(cpu: ARM_CPUInfo.tcputype): string;
  begin
    Str(cpu, Result);
    Delete(Result, 1, 4);
  end;

  function getFPUType(cpu: ARM_CPUInfo.tfputype): string;
  begin
    Str(cpu, Result);
    Delete(Result, 1, 4);
  end;

begin
  sl.Add('type');
  sl.Add('  TARMControllerDataList = array of array of String;');
  sl.Add('');
  sl.Add('const');
  sl.Add('  ARMControllerDataList : TARMControllerDataList = (');
  sl.Add('  ('#39'controllertypestr'#39', '#39' controllerunitstr'#39', '#39' cputype'#39', '#39' fputype'#39', '#39' flashbase'#39',');
  sl.Add('   '#39'flashsize'#39', '#39' srambase'#39', '#39' sramsize'#39', '#39' eeprombase'#39', '#39' eepromsize'#39', '#39' bootbase'#39', '#39' bootsize'#39'),');

  for cdt in ARM_CPUInfo.tcontrollertype do begin
    s := '  ('#39 + ARM_CPUInfo.embedded_controllers[cdt].controllertypestr +
      #39', ' + #39 + ARM_CPUInfo.embedded_controllers[cdt].controllerunitstr +
      #39', ' + #39 + getCPUType(ARM_CPUInfo.embedded_controllers[cdt].cputype) +
      #39', ' + #39 + getFPUType(ARM_CPUInfo.embedded_controllers[cdt].fputype) +
      #39', ' + #39 + IntToStr(ARM_CPUInfo.embedded_controllers[cdt].flashbase) +
      #39', ' + #39 + IntToStr(ARM_CPUInfo.embedded_controllers[cdt].flashsize) +
      #39', ' + #39 + IntToStr(ARM_CPUInfo.embedded_controllers[cdt].srambase) +
      #39', ' + #39 + IntToStr(ARM_CPUInfo.embedded_controllers[cdt].sramsize) +
      #39', ' + #39 + IntToStr(ARM_CPUInfo.embedded_controllers[cdt].eeprombase) +
      #39', ' + #39 + IntToStr(ARM_CPUInfo.embedded_controllers[cdt].eepromsize) +
      #39', ' + #39 + IntToStr(ARM_CPUInfo.embedded_controllers[cdt].bootbase) +
      #39', ' + #39 + IntToStr(ARM_CPUInfo.embedded_controllers[cdt].bootsize) +
      #39'),';
    sl.Add(s);
  end;
  s := sl[sl.Count - 1];
  Delete(s, Length(s), 1);
  sl[sl.Count - 1] := s + ');';
end;

// Ebedded Systeme:
// arm, avr, mipsel(mips), i386, x86_64, i8086, m68k, risc32, risc64, xtensa

// https://svn.freepascal.org/cgi-bin/viewvc.cgi/trunk/compiler/systems/i_embed.pas?revision=44363&view=markup

procedure TForm1.Button1Click(Sender: TObject);
begin
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

  GenerateAVR(SynEdit1.Lines);
  SynEdit1.Lines.Add('');
  GenerateARM(SynEdit1.Lines);
  SynEdit1.Lines.Add('');
  GenerateAVR_Table(SynEdit1.Lines);
  SynEdit1.Lines.Add('');
  GenerateARM_Table(SynEdit1.Lines);

  //  FindSubArch('avr', SynEdit1.Lines);
  //  FindSubArch('arm', SynEdit1.Lines);

  SynEdit1.Lines.Add('');
  SynEdit1.Lines.Add('implementation');
  SynEdit1.Lines.Add('');
  SynEdit1.Lines.Add('begin');
  SynEdit1.Lines.Add('end.');

  SynEdit1.Lines.SaveToFile('../../embedded_gui_subarch_list.pas');
end;

end.
