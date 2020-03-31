unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, EditBtn, FileUtil,
  SynHighlighterPas, SynEdit,
  avr_CPUInfo,
  arm_CPUInfo,
  mips_CPUInfo,
  riscv32_CPUInfo,
  xtensa_CPUInfo;

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
    procedure GenerateXTensa(sl: TStrings);
    procedure GenerateXTensa_Table(sl: TStrings);
    procedure GenerateRisc32(sl: TStrings);
    procedure GenerateRisc32_Table(sl: TStrings);
    procedure GenerateMips(sl: TStrings);
    procedure GenerateMips_Table(sl: TStrings);

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


procedure TForm1.Button2Click(Sender: TObject);
var
  sl, sourceSL: TStringList;
  sa: TStringArray;
  i: integer;
  source_path, dest_path, cpu: string;
begin
  sourceSL := TStringList.Create;
  sl := TStringList.Create;
  source_path := DirectoryEdit1.Directory;
  dest_path := ExtractFileDir(ParamStr(0));
  FindAllFiles(sl, source_path, 'cpuinfo.pas', True);

  CopyFile(source_path + '/compiler/fpcdefs.inc', dest_path + '/src_mod/fpcdefs.inc');
  CopyFile(source_path + '/compiler/cutils.pas', dest_path + '/src_mod/cutils.pas');
  CopyFile(source_path + '/compiler/constexp.pas', dest_path + '/src_mod/constexp.pas');
  CopyFile(source_path + '/compiler/systems.pas', dest_path + '/src_mod/systems.pas');
  CopyFile(source_path + '/compiler/systems.inc', dest_path + '/src_mod/systems.inc');

  sl.LoadFromFile(source_path + '/compiler/globtype.pas');
  sl.Insert(26, 'type');
  sl.Insert(27, '  PUint = word;');
  sl.Insert(28, '  PInt = Smallint;');
  sl.Insert(29, '  AWord = Word;');
  sl.Insert(30, '  AInt = Smallint;');
  sl.Insert(31, '');
  sl.SaveToFile(dest_path + '/src_mod/globtype.pas');

  SynEdit1.Lines.Text := sl.Text;

  sl.Clear;
  sl.Add(source_path + '/compiler/avr/cpuinfo.pas');
  sl.Add(source_path + '/compiler/arm/cpuinfo.pas');
  sl.Add(source_path + '/compiler/xtensa/cpuinfo.pas');
  sl.Add(source_path + '/compiler/riscv32/cpuinfo.pas');
  sl.Add(source_path + '/compiler/mips/cpuinfo.pas');

  //  sl.Add(path + '/compiler/i8086/cpuinfo.pas');
  //  sl.Add(path + '/compiler/aarch64/cpuinfo.pas');
  //  sl.Add(path + '/compiler/powerpc64/cpuinfo.pas');
  //  sl.Add(path + '/compiler/x86_64/cpuinfo.pas');
  //  sl.Add(path + '/compiler/riscv64/cpuinfo.pas');
  //  sl.Add(path + '/compiler/powerpc/cpuinfo.pas');
  //  sl.Add(path + '/compiler/jvm/cpuinfo.pas');
  //  sl.Add(path + '/compiler/sparc/cpuinfo.pas');
  //  sl.Add(path + '/compiler/m68k/cpuinfo.pas');
  //  sl.Add(path + '/compiler/i386/cpuinfo.pas');
  //  sl.Add(path + '/compiler/generic/cpuinfo.pas');
  //  sl.Add(path + '/compiler/sparc64/cpuinfo.pas');

  for i := 0 to sl.Count - 1 do begin
    sa := sl[i].Split('/');
    if Length(sa) > 2 then begin
      cpu := sa[Length(sa) - 2];
    end;
    SynEdit1.Lines.Add(cpu);
    sourceSL.LoadFromFile(sl[i]);
    sourceSL.Text := StringReplace(sourceSL.Text, 'CPUInfo', cpu +
      '_CPUInfo', [rfReplaceAll, rfIgnoreCase]);

    if cpu = 'mips' then sourceSL.Insert(0, '{$define MIPSEL}');

    sourceSL.SaveToFile(dest_path + '/src_mod/' + cpu + '_cpuinfo.pas');
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

  function getFPUType(fpu: AVR_CPUInfo.tfputype): string;
  begin
    Str(fpu, Result);
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

  function getFPUType(fpu: ARM_CPUInfo.tfputype): string;
  begin
    Str(fpu, Result);
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

procedure TForm1.GenerateXTensa(sl: TStrings);
var
  cpt: xtensa_CPUInfo.tcputype;
  cdt: xtensa_CPUInfo.tcontrollertype;
  s: string = '';
  s2: string = '';
  sarr: array[xtensa_CPUInfo.tcputype] of string;
begin
  for cpt in xtensa_CPUInfo.tcputype do begin
    Str(cpt, s);
    s2 := s2 + Copy(s, 5) + ',';
    sarr[cpt] := '';
  end;
  Delete(s2, Length(s2), 1);
  sl.Add('const');
  sl.Add('  XTEensa_SubArch_List = '#39 + s2 + #39 + ';');
  sl.Add('');
  for cdt in xtensa_CPUInfo.tcontrollertype do begin
    sarr[xtensa_CPUInfo.embedded_controllers[cdt].cputype] +=
      xtensa_CPUInfo.embedded_controllers[cdt].controllertypestr + ',';
  end;

  sl.Add('  XTEensa_List: array of string = (');
  for cpt in xtensa_CPUInfo.tcputype do begin
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

procedure TForm1.GenerateXTensa_Table(sl: TStrings);
//{$I systems.inc}

var
  cdt: XTensa_CPUInfo.tcontrollertype;
  s: string;

  function getCPUType(cpu: XTensa_CPUInfo.tcputype): string;
  begin
    Str(cpu, Result);
    Delete(Result, 1, 4);
  end;

  function getFPUType(fpu: XTensa_CPUInfo.tfputype): string;
  begin
    Str(fpu, Result);
    Delete(Result, 1, 4);
  end;

  //function getABIType(abi: tabi): string;
  //begin
  //  Str(abi, Result);
  //  Delete(Result, 1, 4);
  //end;

begin
  sl.Add('type');
  sl.Add('  TXTensaControllerDataList = array of array of String;');
  sl.Add('');
  sl.Add('const');
  sl.Add('  XTensaControllerDataList : TXTensaControllerDataList = (');
  sl.Add('  ('#39'controllertypestr'#39', '#39' controllerunitstr'#39', '#39' cputype'#39', '#39' fputype'#39', '#39' abi'#39', '#39' flashbase'#39',');
  sl.Add('   '#39'flashsize'#39', '#39' srambase'#39', '#39' sramsize'#39', '#39' eeprombase'#39', '#39' eepromsize'#39', '#39' bootbase'#39', '#39' bootsize'#39'),');

  for cdt in XTensa_CPUInfo.tcontrollertype do begin
    s := '  ('#39 + XTensa_CPUInfo.embedded_controllers[cdt].controllertypestr +
      #39', ' + #39 + XTensa_CPUInfo.embedded_controllers[cdt].controllerunitstr +
      #39', ' + #39 + getCPUType(XTensa_CPUInfo.embedded_controllers[cdt].cputype) +
      #39', ' + #39 + getFPUType(XTensa_CPUInfo.embedded_controllers[cdt].fputype) +
//      #39', ' + #39 + getABIType(XTensa_CPUInfo.embedded_controllers[cdt].abi) +
      #39', ' + #39 + 'abi' +
      #39', ' + #39 + IntToStr(XTensa_CPUInfo.embedded_controllers[cdt].flashbase) +
      #39', ' + #39 + IntToStr(XTensa_CPUInfo.embedded_controllers[cdt].flashsize) +
      #39', ' + #39 + IntToStr(XTensa_CPUInfo.embedded_controllers[cdt].srambase) +
      #39', ' + #39 + IntToStr(XTensa_CPUInfo.embedded_controllers[cdt].sramsize) +
      #39', ' + #39 + IntToStr(XTensa_CPUInfo.embedded_controllers[cdt].eeprombase) +
      #39', ' + #39 + IntToStr(XTensa_CPUInfo.embedded_controllers[cdt].eepromsize) +
      #39', ' + #39 + IntToStr(XTensa_CPUInfo.embedded_controllers[cdt].bootbase) +
      #39', ' + #39 + IntToStr(XTensa_CPUInfo.embedded_controllers[cdt].bootsize) +
      #39'),';
    sl.Add(s);
  end;
  s := sl[sl.Count - 1];
  Delete(s, Length(s), 1);
  sl[sl.Count - 1] := s + ');';
end;

procedure TForm1.GenerateRisc32(sl: TStrings);
var
  cpt: riscv32_CPUInfo.tcputype;
  cdt: riscv32_CPUInfo.tcontrollertype;
  s: string = '';
  s2: string = '';
  sarr: array[riscv32_CPUInfo.tcputype] of string;
begin
  for cpt in riscv32_CPUInfo.tcputype do begin
    Str(cpt, s);
    s2 := s2 + Copy(s, 5) + ',';
    sarr[cpt] := '';
  end;
  Delete(s2, Length(s2), 1);
  sl.Add('const');
  sl.Add('  Riscv32_SubArch_List = '#39 + s2 + #39 + ';');
  sl.Add('');
  for cdt in riscv32_CPUInfo.tcontrollertype do begin
    sarr[riscv32_CPUInfo.embedded_controllers[cdt].cputype] +=
      riscv32_CPUInfo.embedded_controllers[cdt].controllertypestr + ',';
  end;

  sl.Add('  Riscv32_List: array of string = (');
  for cpt in riscv32_CPUInfo.tcputype do begin
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

procedure TForm1.GenerateRisc32_Table(sl: TStrings);
var
  cdt: Riscv32_CPUInfo.tcontrollertype;
  s: string;

  function getCPUType(cpu: Riscv32_CPUInfo.tcputype): string;
  begin
    Str(cpu, Result);
    Delete(Result, 1, 4);
  end;

  function getFPUType(fpu: Riscv32_CPUInfo.tfputype): string;
  begin
    Str(fpu, Result);
    Delete(Result, 1, 4);
  end;

begin
  sl.Add('type');
  sl.Add('  TRiscv32ControllerDataList = array of array of String;');
  sl.Add('');
  sl.Add('const');
  sl.Add('  Riscv32ControllerDataList : TRiscv32ControllerDataList = (');
  sl.Add('  ('#39'controllertypestr'#39', '#39' controllerunitstr'#39', '#39' cputype'#39', '#39' fputype'#39', '#39' flashbase'#39',');
  sl.Add('   '#39'flashsize'#39', '#39' srambase'#39', '#39' sramsize'#39', '#39' eeprombase'#39', '#39' eepromsize'#39', '#39' bootbase'#39', '#39' bootsize'#39'),');

  for cdt in Riscv32_CPUInfo.tcontrollertype do begin
    s := '  ('#39 + Riscv32_CPUInfo.embedded_controllers[cdt].controllertypestr +
      #39', ' + #39 + Riscv32_CPUInfo.embedded_controllers[cdt].controllerunitstr +
      #39', ' + #39 + getCPUType(Riscv32_CPUInfo.embedded_controllers[cdt].cputype) +
      #39', ' + #39 + getFPUType(Riscv32_CPUInfo.embedded_controllers[cdt].fputype) +
      #39', ' + #39 + IntToStr(Riscv32_CPUInfo.embedded_controllers[cdt].flashbase) +
      #39', ' + #39 + IntToStr(Riscv32_CPUInfo.embedded_controllers[cdt].flashsize) +
      #39', ' + #39 + IntToStr(Riscv32_CPUInfo.embedded_controllers[cdt].srambase) +
      #39', ' + #39 + IntToStr(Riscv32_CPUInfo.embedded_controllers[cdt].sramsize) +
      #39', ' + #39 + IntToStr(Riscv32_CPUInfo.embedded_controllers[cdt].eeprombase) +
      #39', ' + #39 + IntToStr(Riscv32_CPUInfo.embedded_controllers[cdt].eepromsize) +
      #39', ' + #39 + IntToStr(Riscv32_CPUInfo.embedded_controllers[cdt].bootbase) +
      #39', ' + #39 + IntToStr(Riscv32_CPUInfo.embedded_controllers[cdt].bootsize) +
      #39'),';
    sl.Add(s);
  end;
  s := sl[sl.Count - 1];
  Delete(s, Length(s), 1);
  sl[sl.Count - 1] := s + ');';
end;

procedure TForm1.GenerateMips(sl: TStrings);
var
  cpt: Mips_CPUInfo.tcputype;
  cdt: Mips_CPUInfo.tcontrollertype;
  s: string = '';
  s2: string = '';
  sarr: array[Mips_CPUInfo.tcputype] of string;
begin
  for cpt in Mips_CPUInfo.tcputype do begin
    Str(cpt, s);
    s2 := s2 + Copy(s, 5) + ',';
    sarr[cpt] := '';
  end;
  Delete(s2, Length(s2), 1);
  sl.Add('const');
  sl.Add('  Mips_SubArch_List = '#39 + s2 + #39 + ';');
  sl.Add('');
  for cdt in Mips_CPUInfo.tcontrollertype do begin
    sarr[Mips_CPUInfo.embedded_controllers[cdt].cputype] +=
      Mips_CPUInfo.embedded_controllers[cdt].controllertypestr + ',';
  end;

  sl.Add('  Mips_List: array of string = (');
  for cpt in Mips_CPUInfo.tcputype do begin
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

procedure TForm1.GenerateMips_Table(sl: TStrings);
var
  cdt: Mips_CPUInfo.tcontrollertype;
  s: string;

  function getCPUType(cpu: Mips_CPUInfo.tcputype): string;
  begin
    Str(cpu, Result);
    Delete(Result, 1, 4);
  end;

  function getFPUType(cpu: Mips_CPUInfo.tfputype): string;
  begin
    Str(cpu, Result);
    Delete(Result, 1, 4);
  end;

begin
  sl.Add('type');
  sl.Add('  TMipsControllerDataList = array of array of String;');
  sl.Add('');
  sl.Add('const');
  sl.Add('  MipsControllerDataList : TMipsControllerDataList = (');
  sl.Add('  ('#39'controllertypestr'#39', '#39' controllerunitstr'#39', '#39' cputype'#39', '#39' fputype'#39', '#39' flashbase'#39',');
  sl.Add('   '#39'flashsize'#39', '#39' srambase'#39', '#39' sramsize'#39', '#39' eeprombase'#39', '#39' eepromsize'#39', '#39' bootbase'#39', '#39' bootsize'#39'),');

  for cdt in Mips_CPUInfo.tcontrollertype do begin
    s := '  ('#39 + Mips_CPUInfo.embedded_controllers[cdt].controllertypestr +
      #39', ' + #39 + Mips_CPUInfo.embedded_controllers[cdt].controllerunitstr +
      #39', ' + #39 + getCPUType(Mips_CPUInfo.embedded_controllers[cdt].cputype) +
      #39', ' + #39 + getFPUType(Mips_CPUInfo.embedded_controllers[cdt].fputype) +
      #39', ' + #39 + IntToStr(Mips_CPUInfo.embedded_controllers[cdt].flashbase) +
      #39', ' + #39 + IntToStr(Mips_CPUInfo.embedded_controllers[cdt].flashsize) +
      #39', ' + #39 + IntToStr(Mips_CPUInfo.embedded_controllers[cdt].srambase) +
      #39', ' + #39 + IntToStr(Mips_CPUInfo.embedded_controllers[cdt].sramsize) +
      #39', ' + #39 + IntToStr(Mips_CPUInfo.embedded_controllers[cdt].eeprombase) +
      #39', ' + #39 + IntToStr(Mips_CPUInfo.embedded_controllers[cdt].eepromsize) +
      #39', ' + #39 + IntToStr(Mips_CPUInfo.embedded_controllers[cdt].bootbase) +
      #39', ' + #39 + IntToStr(Mips_CPUInfo.embedded_controllers[cdt].bootsize) +
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
  GenerateXTensa(SynEdit1.Lines);
  SynEdit1.Lines.Add('');
  GenerateRisc32(SynEdit1.Lines);
  SynEdit1.Lines.Add('');
  GenerateMips(SynEdit1.Lines);
  SynEdit1.Lines.Add('');

  GenerateAVR_Table(SynEdit1.Lines);
  SynEdit1.Lines.Add('');
  GenerateARM_Table(SynEdit1.Lines);
  SynEdit1.Lines.Add('');
  GenerateXTensa_Table(SynEdit1.Lines);
  SynEdit1.Lines.Add('');
  GenerateRisc32_Table(SynEdit1.Lines);
  SynEdit1.Lines.Add('');
  GenerateMips_Table(SynEdit1.Lines);
  SynEdit1.Lines.Add('');

  SynEdit1.Lines.Add('implementation');
  SynEdit1.Lines.Add('');
  SynEdit1.Lines.Add('begin');
  SynEdit1.Lines.Add('end.');

  SynEdit1.Lines.SaveToFile('../../Lazarus_Arduino_AVR_GUI_Package/embedded_gui_subarch_list.pas');
end;

end.
