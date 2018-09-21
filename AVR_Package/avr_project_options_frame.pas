unit AVR_Project_Options_Frame;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, StdCtrls, Dialogs, EditBtn,
  LazIDEIntf,LazConfigStorage,
  BaseIDEIntf, ProjectIntf, CompOptsIntf, IDEOptionsIntf, IDEOptEditorIntf, IDEExternToolIntf,
  AVR_Common, AVR_IDE_Options;

const
  Key_SerialMonitorPort = 'SerialMonitorPort';
  Key_SerialMonitorBaud = 'COM_Port';

type

  { TProjectOptions }

  TProjectOptions = class
    AvrdudeCommand: record
      Path,
      ConfigPath,
      Programmer,
      COM_Port,
      Baud: string;
    end;
    AVRType,
    SerialMonitorPort,
    SerialMonitorBaud: string;
    AsmFile: boolean;
    procedure Save(AProject: TLazProject);
    procedure Load(AProject: TLazProject);
  end;

var
  ProjectOptions: TProjectOptions;


type

  { TAVR_Project_Options_Frame }

  TAVR_Project_Options_Frame = class(TAbstractIDEOptionsEditor)
    Button1: TButton;
    Button2: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    avrdudeConfigPathComboBox: TComboBox;
    COMPortBaudComboBox: TComboBox;
    OpenDialogAVRPath: TOpenDialog;
    OpenDialogAVRConfigPath: TOpenDialog;
    ProgrammerComboBox: TComboBox;
    AVR_Typ_ComboBox: TComboBox;
    AsmFile_CheckBox: TCheckBox;
    COMPortComboBox: TComboBox;
    SerialMonitorPort_ComboBox: TComboBox;
    SerialMonitorBaud_ComboBox: TComboBox;
    avrdudePathComboBox: TComboBox;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FrameClick(Sender: TObject);
  private

  public
    function GetTitle: string; override;
    procedure Setup({%H-}ADialog: TAbstractOptionsEditorDialog); override;
    procedure ReadSettings({%H-}AOptions: TAbstractIDEOptions); override;
    procedure WriteSettings({%H-}AOptions: TAbstractIDEOptions); override;
    class function SupportedOptionsClass: TAbstractIDEOptionsClass; override;

    procedure LoadDefaultMask;
    procedure ProjectOptionsToMask;
    procedure MaskToProjectOptions;
  end;

implementation

{$R *.lfm}

{ TProjectOptions }


procedure TProjectOptions.Save(AProject: TLazProject);
var
  s: string;
begin
  with AProject.LazCompilerOptions do begin
    CustomOptions := '-Wp' + ProjectOptions.AVRType;
    if ProjectOptions.AsmFile then begin
      CustomOptions := CustomOptions + LineEnding + '-al';
    end;
  end;

  s := ProjectOptions.AvrdudeCommand.Path + ' ' +
    '-C' + ProjectOptions.AvrdudeCommand.ConfigPath + ' ' +
    '-v ' +
    '-p' + ProjectOptions.AVRType + ' ' +
    '-c' + ProjectOptions.AvrdudeCommand.Programmer + ' ';
  if upCase(ProjectOptions.AvrdudeCommand.Programmer) = 'ARDUINO' then begin
    s += '-P' + ProjectOptions.AvrdudeCommand.COM_Port + ' ' +
      '-b' + ProjectOptions.AvrdudeCommand.Baud + ' ';
  end;
  s += '-D -Uflash:w:' + AProject.LazCompilerOptions.TargetFilename + '.hex:i';

  AProject.LazCompilerOptions.ExecuteAfter.Command := s;

  //    avrdude_ComboBox1.Text := 'avrdude -v -patmega328p -carduino -P/dev/ttyUSB0 -b57600 -D -Uflash:w:Project1.hex:i';

  AProject.CustomData[Key_SerialMonitorPort] := ProjectOptions.SerialMonitorPort;
  AProject.CustomData[Key_SerialMonitorBaud] := ProjectOptions.SerialMonitorBaud;
end;

procedure TProjectOptions.Load(AProject: TLazProject);
var
  s: string;

  function Find(const Source, v: string): string;
  var
    p, Index: integer;
  begin
    p := pos(v, Source);
    Result := '';
    if p > 0 then begin
      p += Length(v);
      Index := p;
      while (Index <= Length(Source)) and (s[Index] > #32) do begin
        Result += Source[Index];
        Inc(Index);
      end;
    end;
  end;

begin
  s := AProject.LazCompilerOptions.CustomOptions;
  ProjectOptions.AsmFile := Pos('-al', s) > 0;
  ProjectOptions.AVRType := Find(s, '-Wp');

  s := AProject.LazCompilerOptions.ExecuteAfter.Command;
  ProjectOptions.AvrdudeCommand.Path := Copy(s, 0, pos(' ', s) - 1);
  ProjectOptions.AvrdudeCommand.ConfigPath := Find(s, '-C');
  ProjectOptions.AvrdudeCommand.Programmer := Find(s, '-c');
  ProjectOptions.AvrdudeCommand.COM_Port := Find(s, '-P');
  ProjectOptions.AvrdudeCommand.Baud := Find(s, '-b');

  ProjectOptions.SerialMonitorPort := AProject.CustomData[Key_SerialMonitorPort];
  ProjectOptions.SerialMonitorBaud := AProject.CustomData[Key_SerialMonitorBaud];
end;

{ TAVR_Project_Options_Frame }

procedure TAVR_Project_Options_Frame.Button1Click(Sender: TObject);
begin
  OpenDialogAVRPath.FileName := avrdudePathComboBox.Text;
  if OpenDialogAVRPath.Execute then begin
    avrdudePathComboBox.Text := OpenDialogAVRPath.FileName;
  end;
end;

procedure TAVR_Project_Options_Frame.Button2Click(Sender: TObject);
begin
  OpenDialogAVRConfigPath.FileName := avrdudeConfigPathComboBox.Text;
  if OpenDialogAVRConfigPath.Execute then begin
    avrdudeConfigPathComboBox.Text := OpenDialogAVRConfigPath.FileName;
  end;
end;

procedure TAVR_Project_Options_Frame.FrameClick(Sender: TObject);
begin
end;

function TAVR_Project_Options_Frame.GetTitle: string;
begin
  Result := 'AVR_Project Optionen';
end;

procedure TAVR_Project_Options_Frame.Setup(ADialog: TAbstractOptionsEditorDialog);
begin
  // Do nothing
end;

procedure TAVR_Project_Options_Frame.ReadSettings(AOptions: TAbstractIDEOptions);
var
  LazProject: TLazProject;
begin
  LazProject := LazarusIDE.ActiveProject;
  ProjectOptions.Load(LazProject);
end;

procedure TAVR_Project_Options_Frame.WriteSettings(AOptions: TAbstractIDEOptions);
var
  LazProject: TLazProject;
begin
  LazProject := LazarusIDE.ActiveProject;
  ProjectOptions.Save(LazProject);
end;

class function TAVR_Project_Options_Frame.SupportedOptionsClass: TAbstractIDEOptionsClass;
begin
  Result := TAbstractIDEProjectOptions;
end;

procedure TAVR_Project_Options_Frame.LoadDefaultMask;
const
  AVR5_Typ =  // fpcsrc/rtl/embedded/Makefile
    'atmega645 atmega165a atmega649a atmega32u4 atmega168p atmega3250pa atmega3290a ' +
    'atmega165p atmega16u4 atmega6490p atmega324p atmega328 atmega64m1 atmega645p ' +
    'atmega329a atmega324pa atmega32hvb at90pwm316 at90usb646 atmega16 atmega644 ' +
    'at90can64 at90can32 at90pwm216 atmega3250a atmega3290pa atmega325p atmega328p ' +
    'atmega3250 atmega329 atmega32a atmega6490 atmega168a atmega164pa atmega645a ' +
    'atmega3290p atmega644p atmega164a atmega162 atmega32c1 atmega324a atmega169a ' +
    'atmega644a atmega3290 atmega64a atmega169p atmega32 atmega168pa atmega16m1 ' +
    'atmega16hvb atmega164p atmega325a atmega640 atmega6450 atmega329p at90usb647 ' +
    'atmega168 atmega6490a atmega32m1 atmega64c1 atmega644pa atmega325pa atmega6450a ' +
    'atmega329pa atmega6450p atmega64 atmega165pa atmega16a atmega649 atmega649p ' +
    'atmega3250p atmega325 atmega169pa avrsim';

begin

  with avrdudePathComboBox do begin
    Items.Add('avrdude');
    Items.Add('/usr/bin/avrdude');
    Text := AVR_Options.avrdudePfad;
  end;

  with avrdudeConfigPathComboBox do begin
    Items.Add('/etc/avrdude.conf');
    Items.Add('avrdude.conf');
    Text := AVR_Options.avrdudeConfigPath;
  end;

  with ProgrammerComboBox do begin
    Items.Add('arduino');
    Items.Add('usbasp');
    Items.Add('stk500v1');
    Text := 'arduino';
  end;

  with COMPortComboBox do begin
    Items.DelimitedText := ',';
    Items.DelimitedText := GetSerialPortNames;
    Text := '/dev/ttyUSB0';
  end;

  with COMPortBaudComboBox do begin
    Items.Add('57600');
    Items.Add('115200');
    Text := '57600';
  end;

  with AVR_Typ_ComboBox do begin
    Items.DelimitedText := ' ';
    Items.DelimitedText := AVR5_Typ;
    Sorted := True;
    Text := 'ATMEGA328P';
  end;

  AsmFile_CheckBox.Checked := False;

  with SerialMonitorPort_ComboBox do begin
    Items.Add('/dev/ttyUSB0');
    Items.Add('/dev/ttyUSB1');
    Items.Add('/dev/ttyUSB2');
    Text := '/dev/ttyUSB0';
  end;

  with SerialMonitorBaud_ComboBox do begin
    Items.Add('4800');
    Items.Add('9600');
    Items.Add('19200');
    Text := '9600';
  end;

end;

procedure TAVR_Project_Options_Frame.ProjectOptionsToMask;
begin

  with avrdudePathComboBox do begin
    Text := ProjectOptions.AvrdudeCommand.Path;
  end;

  with avrdudeConfigPathComboBox do begin
    Text := ProjectOptions.AvrdudeCommand.ConfigPath;
  end;

  with ProgrammerComboBox do begin
    Text := ProjectOptions.AvrdudeCommand.Programmer;
  end;

  with COMPortComboBox do begin
    Text := ProjectOptions.AvrdudeCommand.COM_Port;
  end;

  with COMPortBaudComboBox do begin
    Text := ProjectOptions.AvrdudeCommand.Baud;
  end;

  with AVR_Typ_ComboBox do begin
    Text := ProjectOptions.AVRType;
  end;

  AsmFile_CheckBox.Checked := ProjectOptions.AsmFile;

  with SerialMonitorPort_ComboBox do begin
    Text := ProjectOptions.SerialMonitorPort;
  end;

  with SerialMonitorBaud_ComboBox do begin
    Text := ProjectOptions.SerialMonitorBaud;
  end;

end;

procedure TAVR_Project_Options_Frame.MaskToProjectOptions;
begin
  ProjectOptions.AvrdudeCommand.Path := avrdudePathComboBox.Text;
  ProjectOptions.AvrdudeCommand.ConfigPath := avrdudeConfigPathComboBox.Text;
  ProjectOptions.AvrdudeCommand.Programmer := ProgrammerComboBox.Text;
  ProjectOptions.AvrdudeCommand.COM_Port := COMPortComboBox.Text;
  ProjectOptions.AvrdudeCommand.Baud := COMPortBaudComboBox.Text;

  ProjectOptions.AVRType := AVR_Typ_ComboBox.Text;
  ProjectOptions.AsmFile := AsmFile_CheckBox.Checked;

  ProjectOptions.SerialMonitorPort := SerialMonitorPort_ComboBox.Text;
  ProjectOptions.SerialMonitorBaud := SerialMonitorBaud_ComboBox.Text;
end;

end.
