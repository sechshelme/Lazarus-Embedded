unit Embedded_GUI_Project_Options_Form;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, StdCtrls, Dialogs, Buttons, ComCtrls,
  LazIDEIntf, ProjectIntf, CompOptsIntf, IDEOptionsIntf, IDEOptEditorIntf,
  IDEExternToolIntf,
  //  Laz2_XMLCfg, // Für direkte *.lpi Zugriff

  Embedded_GUI_Common,
  Embedded_GUI_Common_FileComboBox,
  Embedded_GUI_Find_Comports,
  Embedded_GUI_Frame_IDE_Options,
  Embedded_GUI_Project_Templates_Form,
  Embedded_GUI_CPU_Info_Form,
  Embedded_GUI_Embedded_List_Const, Types,

  Embedded_GUI_Frame_Programmer_AVRDude,
  Embedded_GUI_Frame_Programmer_STFlash,
  Embedded_GUI_Frame_Programmer_Bossac,
  Embedded_GUI_Frame_Programmer_UF2,
  Embedded_GUI_Frame_Programmer_ESPTool,
  Embedded_GUI_Frame_Programmer_CustomPrg;

type

  { TProject_Options_Form }

  TProject_Options_Form = class(TForm)
    ButtonHelp: TButton;
    Button1: TButton;
    CheckBox_ASMFile: TCheckBox;
    CheckBox_UF2File: TCheckBox;
    ComboBox_SubArch: TComboBox;
    ComboBox_Arch: TComboBox;
    ComboBox_Controller: TComboBox;
    CPU_InfoButton: TButton;
    GroupBox_Compiler: TGroupBox;
    GroupBox_Programmer: TGroupBox;
    CancelButton: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label5: TLabel;
    Memo1: TMemo;
    RadioButton_Custom: TRadioButton;
    RadioButton_None: TRadioButton;
    RadioButton_ESP_Tool: TRadioButton;
    RadioButton_AVRDude: TRadioButton;
    RadioButton_UF2: TRadioButton;
    RadioButton_Bossac: TRadioButton;
    RadioButton_ST_Flash: TRadioButton;
    TemplatesButton: TButton;
    procedure ButtonHelpClick(Sender: TObject);
    procedure ComboBox_ArchChange(Sender: TObject);
    procedure ComboBox_ControllerChange(Sender: TObject);
    procedure ComboBox_SubArchChange(Sender: TObject);
    procedure CPU_InfoButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure RadioButton_Programmer_Change(Sender: TObject);
    procedure TemplatesButtonClick(Sender: TObject);
  private
    Frame_AVRDude:TFrame_AVRDude;
    Frame_STFlash:TFrame_STFlash;
    Frame_Bossac:TFrame_Bossac;
    Frame_UF2:TFrame_UF2;
    Frame_ESPTool:TFrame_ESPTool;
    Frame_CustomPrg: TFrame_CustomPrg;
    FIsNewProject: Boolean;
    SubArchList: string;
    List: TStringArray;
    FProjectSource: string;
  public
    property ProjectSource: string read FProjectSource;
    property IsNewProject: Boolean write FIsNewProject;
    procedure DefaultMask;
    procedure LazProjectToMask(LazProject: TLazProject);
    procedure MaskToLazProject(LazProject: TLazProject);
  end;

var
  Project_Options_Form: TProject_Options_Form;

implementation

{$R *.lfm}

{ TProject_Options_Form }

// public

procedure TProject_Options_Form.FormCreate(Sender: TObject);
const FrameTop=40;
begin
  LoadFormPos_from_XML(Self);

  // --- Compiler
  with ComboBox_Arch do begin
    Items.CommaText := 'avr,arm,xtensa';
    Style := csOwnerDrawFixed;
  end;

  with ComboBox_SubArch do begin
    Style := csOwnerDrawFixed;
  end;

  with ComboBox_Controller do begin
    Sorted := True;
  end;

  // --- Programmer

  // AVRDude
  Frame_AVRDude:=TFrame_AVRDude.Create(GroupBox_Programmer);
  Frame_AVRDude.Parent:=GroupBox_Programmer;
  Frame_AVRDude.Anchors:=[akBottom,akLeft,akRight,akTop];
  Frame_AVRDude.Top:=FrameTop;
  Frame_AVRDude.Align:=alBottom;

  // ST-Link
  Frame_STFlash:=TFrame_STFlash.Create(GroupBox_Programmer);
  Frame_STFlash.Parent:=GroupBox_Programmer;
  Frame_STFlash.Anchors:=[akBottom,akLeft,akRight,akTop];
  Frame_STFlash.Top:=FrameTop;
  Frame_STFlash.Align:=alBottom;

  // Bossac ( Arduino Due )
  Frame_Bossac:=TFrame_Bossac.Create(GroupBox_Programmer);
  Frame_Bossac.Parent:=GroupBox_Programmer;
  Frame_Bossac.Anchors:=[akBottom,akLeft,akRight,akTop];
  Frame_Bossac.Top:=FrameTop;
  Frame_Bossac.Align:=alBottom;

  // Rasberry PI Pico
  Frame_UF2:=TFrame_UF2.Create(GroupBox_Programmer);
  Frame_UF2.Parent:=GroupBox_Programmer;
  Frame_UF2.Anchors:=[akBottom,akLeft,akRight,akTop];
  Frame_UF2.Top:=FrameTop;
  Frame_UF2.Align:=alBottom;

  // ESP32 / ES8266
  Frame_ESPTool:=TFrame_ESPTool.Create(GroupBox_Programmer);
  Frame_ESPTool.Parent:=GroupBox_Programmer;
  Frame_ESPTool.Anchors:=[akBottom,akLeft,akRight,akTop];
  Frame_ESPTool.Top:=FrameTop;
  Frame_ESPTool.Align:=alBottom;

  // Custom Programmer
  Frame_CustomPrg:=TFrame_CustomPrg.Create(GroupBox_Programmer);
  Frame_CustomPrg.Parent:=GroupBox_Programmer;
  Frame_CustomPrg.Anchors:=[akBottom,akLeft,akRight,akTop];
  Frame_CustomPrg.Top:=FrameTop;
  Frame_CustomPrg.Align:=alBottom;

  DefaultMask;
end;

procedure TProject_Options_Form.FormShow(Sender: TObject);
begin
  if FIsNewProject then
  Caption := Title + 'New Project'else   Caption := Title + 'Project Options';
end;

procedure TProject_Options_Form.DefaultMask;
begin
  // --- Compiler
  with ComboBox_Arch do begin
    Text := 'avr';
    ItemIndex := Items.IndexOf(Text);
  end;

  with ComboBox_SubArch do begin
    Text := 'AVR5';
    Items.CommaText := AVR_SubArch_List;
    ItemIndex := Items.IndexOf(Text);
  end;

  with ComboBox_Controller do begin
    Text := 'atmega328p';
    Frame_AVRDude.Controller := Text;;
  end;

  CheckBox_ASMFile.Checked := False;
  CheckBox_UF2File.Checked := False;

  // --- Programer

  // AVRDude
  Frame_AVRDude.DefaultMask;

  // ST-Link
  Frame_STFlash.DefaultMask;

  // Bossac
  Frame_Bossac.DefaultMask;

  // Rasberry PI Pico
  Frame_UF2.DefaultMask;

  // ESP32 / ESP8266
  Frame_ESPTool.DefaultMask;

  // Custom Prgrammer
  Frame_CustomPrg.DefaultMask;


  RadioButton_Programmer_Change(nil);
end;

procedure TProject_Options_Form.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  SaveFormPos_to_XML(Self);
end;

procedure TProject_Options_Form.ComboBox_ArchChange(Sender: TObject);
begin
  if ComboBox_Arch.Text = 'avr' then begin
    SubArchList := AVR_SubArch_List;
    List := avr_List;
  end;
  if ComboBox_Arch.Text = 'arm' then begin
    SubArchList := ARM_SubArch_List;
    List := arm_List;
  end;
  if ComboBox_Arch.Text = 'xtensa' then begin
    SubArchList := xtensa_SubArch_List;
    List := xtensa_List;
  end;
  ComboBox_SubArch.Items.CommaText := SubArchList;

  ComboBox_SubArchChange(Sender);
end;

procedure TProject_Options_Form.ComboBox_ControllerChange(Sender: TObject);
begin
  Frame_AVRDude.Controller := ComboBox_Controller.Text;;
  Frame_STFlash.Controller := ComboBox_Controller.Text;;
end;

procedure TProject_Options_Form.ButtonHelpClick(Sender: TObject);
begin
  ShowMessage('Für folgende Programmer muss folgende Baud eingestellt werden:' + LineEnding + LineEnding +
  'Arduino UNO: 1152000' + LineEnding +
  'Arduino Nano old: 57600' + LineEnding +
  'Arduino Nano: 1152000' + LineEnding +
  'Arduino Mega: 1152000' + LineEnding +
  'STK500v1: ???' + LineEnding +
  'usbas, usbtiny, avr109: Braucht kein Baud');
end;

procedure TProject_Options_Form.ComboBox_SubArchChange(Sender: TObject);
var
  index: integer;
begin
  index := ComboBox_SubArch.ItemIndex;
  if (index < 0) or (index >= Length(List)) then begin
    ComboBox_Controller.Items.CommaText := '';
  end else begin
    ComboBox_Controller.Items.CommaText := List[index];
  end;
end;

procedure TProject_Options_Form.LazProjectToMask(LazProject: TLazProject);
var
  cmd, ProgrammerPath, ProgrammerName: string;
begin
  // --- FPC Command
  with LazProject.LazCompilerOptions do begin
    ComboBox_Arch.Text := TargetCPU;
    ComboBox_Arch.ItemIndex := ComboBox_Arch.Items.IndexOf(ComboBox_Arch.Text);
    ComboBox_ArchChange(nil);
    ComboBox_SubArch.Text := TargetProcessor;
    ComboBox_SubArch.ItemIndex := ComboBox_SubArch.Items.IndexOf(ComboBox_SubArch.Text);
    ComboBox_SubArchChange(nil);

    cmd := CustomOptions;
    ComboBox_Controller.Text := FindFPCPara(cmd, '-Wp');
    ComboBox_Controller.Items.IndexOf(ComboBox_Controller.Text);
    CheckBox_AsmFile.Checked := Pos('-al', cmd) > 0;
    CheckBox_UF2File.Checked := Pos('-Xu', cmd) > 0;
  end;

  // --- Programmer Command
  cmd := LazProject.LazCompilerOptions.ExecuteAfter.Command;
  cmd := StringReplace(cmd, '"', '', [rfIgnoreCase, rfReplaceAll]);
  ProgrammerPath := Copy(cmd, 0, pos(' ', cmd) - 1);
  cmd := Copy(cmd, pos(' ', cmd) - 1);
  ProgrammerName := ExtractFileName(ProgrammerPath);

  // none
  if ProgrammerName = '' then begin
    RadioButton_None.Checked := True;
  end else

  // AVRDude
  if Pos('avrdude', ProgrammerName) > 0 then begin
    RadioButton_AVRDude.Checked := True;
    Frame_AVRDude.LazProjectToMask(ProgrammerPath, cmd);
  end else

  // ST-Link
  if Pos('st-flash', ProgrammerName) > 0 then begin
    RadioButton_ST_Flash.Checked := True;
    Frame_STFlash.LazProjectToMask(ProgrammerPath, cmd);
  end else

  // Bossac
  if Pos('bossac', ProgrammerName) > 0 then begin
    RadioButton_Bossac.Checked := True;
    Frame_Bossac.LazProjectToMask(ProgrammerPath, cmd);
  end else

  // Rasberry PI Pico
  if Pos(UpCase('.uf2 '), UpCase(cmd)) > 0 then begin
    RadioButton_UF2.Checked := True;
    Frame_UF2.LazProjectToMask(ProgrammerPath, cmd);
  end else

  // ESP32 / ESP8266
  if Pos('esptool', ProgrammerName) > 0 then begin
    RadioButton_ESP_Tool.Checked := True;
    Frame_ESPTool.LazProjectToMask(ProgrammerPath, cmd);
  end else begin

  // Custom Programmer
    RadioButton_Custom.Checked := True;
    Frame_CustomPrg.LazProjectToMask(ProgrammerPath, cmd);
  end;


  RadioButton_Programmer_Change(nil);
end;

procedure TProject_Options_Form.MaskToLazProject(LazProject: TLazProject);
var
  cmd: string;
begin
  // --- FPC_Command
  if UpCase(ComboBox_Arch.Text) = 'XTENSA' then begin
    LazProject.LazCompilerOptions.TargetOS := 'FreeRTOS';
  end else begin
    LazProject.LazCompilerOptions.TargetOS := 'Embedded';
  end;
  LazProject.LazCompilerOptions.TargetCPU := ComboBox_Arch.Text;
  LazProject.LazCompilerOptions.TargetProcessor := ComboBox_SubArch.Text;
  cmd := '-Wp' + ComboBox_Controller.Text;
  if CheckBox_AsmFile.Checked then begin
    cmd += LineEnding + '-al';
  end;
  if CheckBox_UF2File.Checked then begin
    cmd += LineEnding + '-Xu';
  end;
  LazProject.LazCompilerOptions.CustomOptions := cmd;

  // --- Programmer Command

  // AVRDude
  if RadioButton_AVRDude.Checked then begin
    Frame_AVRDude.MaskToLazProject(LazProject);
  end;

  // ST-Link
  if RadioButton_ST_Flash.Checked then begin
    Frame_STFlash.MaskToLazProject(LazProject);
  end;

  // Bossac
  if RadioButton_Bossac.Checked then begin
    Frame_Bossac.MaskToLazProject(LazProject);
  end;

  // Rasberry PI Pico
  if RadioButton_UF2.Checked then begin
    Frame_UF2.MaskToLazProject(LazProject);
  end;

  // ESP32 / ESP8266
  if RadioButton_ESP_Tool.Checked then begin
    Frame_ESPTool.MaskToLazProject(LazProject);
  end;

  // Custom Programmer
  if RadioButton_Custom.Checked then begin
    Frame_CustomPrg.MaskToLazProject(LazProject);
  end;

  // none
  if RadioButton_None.Checked then begin
    LazProject.LazCompilerOptions.ExecuteAfter.Command := '';
  end;

end;

procedure TProject_Options_Form.TemplatesButtonClick(Sender: TObject);
var
  TemplatesForm: TProjectTemplatesForm;
  index: integer;

begin
  TemplatesForm := TProjectTemplatesForm.Create(nil);
  TemplatesForm.IsNewProject := FIsNewProject;

  if TemplatesForm.ShowModal = mrOk then begin
    index := TemplatesForm.ListBox_Board.ItemIndex;
    if index >= 0 then begin

      // --- FPC_Command
      ComboBox_Arch.Text := TemplatesPara[index].Arch;
      ComboBox_Arch.ItemIndex := ComboBox_Arch.Items.IndexOf(ComboBox_Arch.Text);
      ComboBox_ArchChange(nil);
      ComboBox_SubArch.Text := TemplatesPara[index].SubArch;
      ComboBox_SubArch.ItemIndex := ComboBox_SubArch.Items.IndexOf(ComboBox_SubArch.Text);
      ComboBox_SubArchChange(nil);
      ComboBox_Controller.Text := TemplatesPara[index].Controller;

      // --- Programmer Command
      RadioButton_AVRDude.Checked := TemplatesPara[index].Programmer = 'avrdude';
      RadioButton_ST_Flash.Checked := TemplatesPara[index].Programmer = 'st-flash';
      RadioButton_UF2.Checked := TemplatesPara[index].Programmer = 'uf2';
      RadioButton_Bossac.Checked := TemplatesPara[index].Programmer = 'bossac';
      RadioButton_ESP_Tool.Checked := TemplatesPara[index].Programmer = 'ESPTool';

      CheckBox_UF2File.Checked := TemplatesPara[index].Programmer = 'uf2';
      FProjectSource := TemplatesForm.getSource;

      // AVRDude
      Frame_AVRDude.TemplateToMask(index);

      // ST-Link
      Frame_STFlash.TemplateToMask(index);

      // Bossac
      Frame_Bossac.TemplateToMask(index);

      // Rasberry PI Pico
      Frame_UF2.TemplateToMask(index);

      // ESP32 / ESP8266
      Frame_ESPTool.TemplateToMask(index);

    end;
  end;
  TemplatesForm.Free;
end;

procedure TProject_Options_Form.RadioButton_Programmer_Change(Sender: TObject);
begin
  Frame_AVRDude.Visible := RadioButton_AVRDude.Checked;
  Frame_STFlash.Visible := RadioButton_ST_Flash.Checked;
  Frame_Bossac.Visible := RadioButton_Bossac.Checked;
  Frame_UF2.Visible := RadioButton_UF2.Checked;
  Frame_ESPTool.Visible := RadioButton_ESP_Tool.Checked;
  Frame_CustomPrg.Visible := RadioButton_Custom.Checked;
end;

procedure TProject_Options_Form.CPU_InfoButtonClick(Sender: TObject);
var
  CPU_InfoForm: TCPU_InfoForm;
  s: String;
begin
  CPU_InfoForm := TCPU_InfoForm.Create(nil);
  s := ComboBox_Arch.Text;
  CPU_InfoForm.ComboBox_Controller.ItemIndex := CPU_InfoForm.ComboBox_Controller.Items.IndexOf(s);
  CPU_InfoForm.ComboBox_Controller.Text := s;
  CPU_InfoForm.ComboBox_ControllerSelect(Sender);
  CPU_InfoForm.ShowModal;
  CPU_InfoForm.Free;
end;

end.
