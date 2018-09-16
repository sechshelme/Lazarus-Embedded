unit AVR_Project_Options_Frame;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, StdCtrls, Dialogs,
  LazIDEIntf, ProjectIntf, CompOptsIntf, IDEOptionsIntf, IDEOptEditorIntf, IDEExternToolIntf,

  AVR_IDE_Options;

const
  Key_SerialMonitorPort = 'SerialMonitorPort';
  Key_SerialMonitorBaud = 'COM_Port';

type

  { TProjectOptions }

  TProjectOptions = class
    AvrdudeCommand: record
      Path,
      Programmer,
      COM_Port: string;
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
    Label7: TLabel;
    ProgrammerComboBox: TComboBox;
    AVR_Typ_ComboBox: TComboBox;
    HexFile_CheckBox: TCheckBox;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    COMPortComboBox: TComboBox;
    SerialMonitorPort_ComboBox: TComboBox;
    SerialMonitorBaud_ComboBox: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    avrdudePathComboBox: TComboBox;
  private

  public
    function GetTitle: string; override;
    procedure Setup({%H-}ADialog: TAbstractOptionsEditorDialog); override;
    procedure ReadSettings({%H-}AOptions: TAbstractIDEOptions); override;
    procedure WriteSettings({%H-}AOptions: TAbstractIDEOptions); override;
    class function SupportedOptionsClass: TAbstractIDEOptionsClass; override;

    procedure LoadDefaultMask;
    procedure ProjectOptionsToMask;
  end;

implementation

{$R *.lfm}

{ TProjectOptions }

procedure TProjectOptions.Save(AProject: TLazProject);
begin
  with AProject.LazCompilerOptions do begin
    CustomOptions := '-Wp' + ProjectOptions.AVRType;
    if ProjectOptions.AsmFile then begin
      CustomOptions := CustomOptions + LineEnding + '-al';
    end;
  end;

  AProject.LazCompilerOptions.ExecuteAfterCommand := ProjectOptions.AvrdudeCommand.Path + ' -v ' +
    '-patmega328p ' +
    '-c' + ProjectOptions.AvrdudeCommand.Programmer + ' ' +
    '-P' + ProjectOptions.AvrdudeCommand.COM_Port +
    ' -b57600 -D -Uflash:w:Project1.hex:i';

  //    avrdude_ComboBox1.Text := 'avrdude -v -patmega328p -carduino -P/dev/ttyUSB0 -b57600 -D -Uflash:w:Project1.hex:i';

  //  AProject.LazCompilerOptions.ExecuteAfterCommand := ProjectOptions.AvrdudeCommand;

  AProject.CustomData[Key_SerialMonitorPort] := ProjectOptions.SerialMonitorPort;
  AProject.CustomData[Key_SerialMonitorBaud] := ProjectOptions.SerialMonitorBaud;
end;

procedure TProjectOptions.Load(AProject: TLazProject);
var
//  s: string;
  sa:TStringArray;
  p, Index:Integer;
  sl:TStringList;
begin
  sl:=TStringList.Create;
  sl.Text := AProject.LazCompilerOptions.CustomOptions;
  ProjectOptions.AsmFile :=sl.Find('-a', Index);

//  ProjectOptions.AsmFile := pos('-al', sl.Text) > 0;

  //p:=pos('-Wp', s);
  //if p>0 then begin
  //  sa:=Copy(s, p+3).Split(' ');
  //  if Length(sa)>0 then ProjectOptions.AVRType:=sa[0];
  //end;
  sl.Free;
end;

{ TAVR_Project_Options_Frame }

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

  ProjectOptions.AVRType := LazProject.LazCompilerOptions.CustomOptions;

  ProjectOptions.SerialMonitorPort := LazProject.CustomData[Key_SerialMonitorPort];
  ProjectOptions.SerialMonitorBaud := LazProject.CustomData[Key_SerialMonitorBaud];

  SerialMonitorPort_ComboBox.Text := ProjectOptions.SerialMonitorPort;
  SerialMonitorBaud_ComboBox.Text := ProjectOptions.SerialMonitorBaud;
  AVR_Typ_ComboBox.Text := ProjectOptions.AVRType;
end;

procedure TAVR_Project_Options_Frame.WriteSettings(AOptions: TAbstractIDEOptions);
var
  LazProject: TLazProject;
begin
  LazProject := LazarusIDE.ActiveProject;

  ProjectOptions.SerialMonitorPort := SerialMonitorPort_ComboBox.Text;
  ProjectOptions.SerialMonitorBaud := SerialMonitorBaud_ComboBox.Text;
  ProjectOptions.AVRType := AVR_Typ_ComboBox.Text;

  ProjectOptions.Save(LazProject);
end;

class function TAVR_Project_Options_Frame.SupportedOptionsClass: TAbstractIDEOptionsClass;
begin
  Result := TAbstractIDEProjectOptions;
end;

procedure TAVR_Project_Options_Frame.LoadDefaultMask;
begin
  //ProjectOptions.AvrdudeCommand.Path := AVR_Options.avrdudePfad;
  //ProjectOptions.AvrdudeCommand.Programmer := 'arduino';
  //ProjectOptions.AvrdudeCommand.COM_Port := '/dev/ttyUSB0';
  //
  //ProjectOptions.AVRType := 'WpATMEGA328P';
  //ProjectOptions.AsmFile := False;
  //
  //ProjectOptions.SerialMonitorPort := '/dev/ttyUSB0';
  //ProjectOptions.SerialMonitorBaud := '9600';

    with avrdudePathComboBox do begin
      Items.Add('avrdude');
      Items.Add('/usr/bin/avrdude');
      Text := AVR_Options.avrdudePfad;
    end;

    with ProgrammerComboBox do begin
      Items.Add('arduino');
      Items.Add('usbasp');
      Items.Add('stk500v1');
      Text := 'arduino';
    end;

    with COMPortComboBox do begin
      Items.Add('/dev/ttyUSB0');
      Items.Add('/dev/ttyUSB1');
      Items.Add('/dev/ttyUSB2');
      Text := '/dev/ttyUSB0';
    end;

    with AVR_Typ_ComboBox do begin
      Items.Add('ATMEGA328P');
      Text := 'ATMEGA328P';
    end;

    HexFile_CheckBox.Checked := False;

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

  with ProgrammerComboBox do begin
    Text := ProjectOptions.AvrdudeCommand.Programmer;
  end;

  with COMPortComboBox do begin
    Text := ProjectOptions.AvrdudeCommand.COM_Port;
  end;

  with AVR_Typ_ComboBox do begin
    Text := ProjectOptions.AVRType;
  end;

  HexFile_CheckBox.Checked := ProjectOptions.AsmFile;

  with SerialMonitorPort_ComboBox do begin
    Text := ProjectOptions.SerialMonitorPort;
  end;

  with SerialMonitorBaud_ComboBox do begin
    Text := ProjectOptions.SerialMonitorBaud;
  end;


end;

end.
