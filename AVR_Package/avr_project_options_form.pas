unit AVR_Project_Options_Form;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, StdCtrls, Dialogs, Buttons,
  LazConfigStorage, BaseIDEIntf,
  LazIDEIntf, ProjectIntf, CompOptsIntf, IDEOptionsIntf, IDEOptEditorIntf,
  IDEExternToolIntf,
  Laz2_XMLCfg, // Für direkte *.lpi Zugriff

  AVR_IDE_Options, AVR_Common;

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

  { TProjectOptionsForm }

  TProjectOptionsForm = class(TForm)
    AsmFile_CheckBox: TCheckBox;
    avrdudeConfigPathComboBox: TComboBox;
    avrdudePathComboBox: TComboBox;
    AVR_Typ_ComboBox: TComboBox;
    Button1: TButton;
    Button2: TButton;
    TemplatesButton: TButton;
    COMPortBaudComboBox: TComboBox;
    COMPortComboBox: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    OkButton: TButton;
    CancelButton: TButton;
    OpenDialogAVRConfigPath: TOpenDialog;
    OpenDialogAVRPath: TOpenDialog;
    ProgrammerComboBox: TComboBox;
    SerialMonitorBaud_ComboBox: TComboBox;
    SerialMonitorPort_ComboBox: TComboBox;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure OkButtonClick(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
    procedure TemplatesButtonClick(Sender: TObject);
  private

  public
    procedure LoadDefaultMask;
    procedure ProjectOptionsToMask;
    procedure MaskToProjectOptions;
  end;

var
  ProjectOptionsForm: TProjectOptionsForm;

implementation

{$R *.lfm}

const
  Key_ProjectOptions_Left = 'project_options_form_left/value';
  Key_ProjectOptions_Top = 'project_options_form_top/value';

  Key_SerialMonitorPort = 'SerialMonitorPort';
  Key_SerialMonitorBaud = 'COM_Port';

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

  s := ProjectOptions.AvrdudeCommand.Path + ' ';
  if ProjectOptions.AvrdudeCommand.ConfigPath <> '' then begin
    s += '-C' + ProjectOptions.AvrdudeCommand.ConfigPath + ' ';
  end;

  s += '-v ' +
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


{ TProjectOptionsForm }

procedure TProjectOptionsForm.CancelButtonClick(Sender: TObject);
begin
  Close;
end;

procedure TProjectOptionsForm.TemplatesButtonClick(Sender: TObject);
var
  Form: TForm;
  okB, cancelB: TBitBtn;
  cb: TListBox;
  l: TLabel;
begin
  Form := TForm.Create(nil);
  with Form do begin
    Position := poScreenCenter;
    ClientWidth := 400;
    ClientHeight := 300;
  end;

  l := TLabel.Create(Form);
  with l do begin
    Left := 10;
    Top := 25;
    Text := 'Board:';
    Parent := Form;
  end;

  okB := TBitBtn.Create(Form);
  with okB do begin
    Kind := bkOK;
    //    Caption:='Ok';
    Width := 75;
    Height := 25;
    Left := Form.ClientWidth - 100;
    Top := Form.ClientHeight - 50;
    Anchors := [akRight, akBottom];
    Parent := Form;
  end;

  cancelB := TBitBtn.Create(Form);
  with cancelB do begin
    Kind := bkCancel;
    //    Caption:='Cancel';
    Width := 75;
    Height := 25;
    Left := Form.ClientWidth - 200;
    Top := Form.ClientHeight - 50;
    Anchors := [akRight, akBottom];
    Parent := Form;
  end;

  cb := TListBox.Create(Form);
  with cb do begin
    Parent := Form;
    Top := 50;
    Left := 10;
    Width := Form.ClientWidth - 20;
    Height := Form.ClientHeight - 110;
    Anchors := [akLeft, akTop, akRight, akBottom];
    Text := 'Arduino UNO';
    Items.Add(Text);
    Items.Add('Arduino Nano (old Bootloader)');
    Items.Add('Arduino Nano');
  end;

  if Form.ShowModal = mrOk then begin
    case cb.ItemIndex of
      0: begin
        ProgrammerComboBox.Text := 'arduino';
        COMPortComboBox.Text := '/dev/ttyACM0';
        COMPortBaudComboBox.Text := '115200';
        AVR_Typ_ComboBox.Text := 'ATMEGA328P';
      end;
      1: begin
        ProgrammerComboBox.Text := 'arduino';
        COMPortComboBox.Text := '/dev/ttyUSB0';
        COMPortBaudComboBox.Text := '57600';
        AVR_Typ_ComboBox.Text := 'ATMEGA328P';
      end;
      2: begin
        ProgrammerComboBox.Text := 'arduino';
        COMPortComboBox.Text := '/dev/ttyUSB0';
        COMPortBaudComboBox.Text := '115200';
        AVR_Typ_ComboBox.Text := 'ATMEGA328P';
      end;
    end;
  end;

  Form.Free;
end;

procedure TProjectOptionsForm.LoadDefaultMask;
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
    Items.CommaText := '57600,115200';
    Text := '57600';
  end;

  with AVR_Typ_ComboBox do begin
    Items.CommaText := AVR5_Typ;
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
    Items.CommaText := AVR_UARTBaudRates;
    Text := '9600';
  end;

end;

procedure TProjectOptionsForm.ProjectOptionsToMask;
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

procedure TProjectOptionsForm.MaskToProjectOptions;
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

procedure TProjectOptionsForm.OkButtonClick(Sender: TObject);
begin
  //  Close;
end;

procedure TProjectOptionsForm.FormCreate(Sender: TObject);

var
  Cfg: TConfigStorage;
begin
  Cfg := GetIDEConfigStorage(AVR_Options_File, True);
  Left := StrToInt(Cfg.GetValue(Key_ProjectOptions_Left, '100'));
  Top := StrToInt(Cfg.GetValue(Key_ProjectOptions_Top, '50'));
  Cfg.Free;
end;

procedure TProjectOptionsForm.FormClose(Sender: TObject; var CloseAction: TCloseAction);
var
  Cfg: TConfigStorage;
begin
  Cfg := GetIDEConfigStorage(AVR_Options_File, False);
  Cfg.SetDeleteValue(Key_ProjectOptions_Left, IntToStr(Left), '100');
  Cfg.SetDeleteValue(Key_ProjectOptions_Top, IntToStr(Top), '50');
  Cfg.Free;
end;

procedure TProjectOptionsForm.Button1Click(Sender: TObject);
begin
  OpenDialogAVRPath.FileName := avrdudePathComboBox.Text;
  if OpenDialogAVRPath.Execute then begin
    avrdudePathComboBox.Text := OpenDialogAVRPath.FileName;
  end;
end;

procedure TProjectOptionsForm.Button2Click(Sender: TObject);
begin
  OpenDialogAVRConfigPath.FileName := avrdudeConfigPathComboBox.Text;
  if OpenDialogAVRConfigPath.Execute then begin
    avrdudeConfigPathComboBox.Text := OpenDialogAVRConfigPath.FileName;
  end;
end;

end.
