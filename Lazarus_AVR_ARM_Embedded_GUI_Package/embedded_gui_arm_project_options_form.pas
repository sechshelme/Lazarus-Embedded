unit Embedded_GUI_ARM_Project_Options_Form;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, StdCtrls, Dialogs, Buttons,
  //  LazConfigStorage, BaseIDEIntf,
  LazIDEIntf, ProjectIntf, CompOptsIntf, IDEOptionsIntf, IDEOptEditorIntf,
  IDEExternToolIntf,
  //  Laz2_XMLCfg, // Für direkte *.lpi Zugriff

  Embedded_GUI_Common,
  Embedded_GUI_Common_FileComboBox,
  Embedded_GUI_Find_Comports,
  Embedded_GUI_IDE_Options_Frame,
  Embedded_GUI_ARM_Common,
  Embedded_GUI_ARM_Project_Templates_Form,
  Embedded_GUI_CPU_Info_Form,
  Embedded_GUI_Embedded_List_Const;

type

  { TARM_Project_Options_Form }

  TARM_Project_Options_Form = class(TForm)
    ARM_FlashBase_ComboBox: TComboBox;
    BitBtn_Auto_Flash_Base: TBitBtn;
    Button1: TButton;
    CheckBox_Reset: TCheckBox;
    CheckBox_force_USB_Port: TCheckBox;
    CheckBox_Debug: TCheckBox;
    CheckBox_Info: TCheckBox;
    CheckBox_Security: TCheckBox;
    CheckBox_UnLock: TCheckBox;
    CheckBox_Lock: TCheckBox;
    CheckBox_Brownout_Reset: TCheckBox;
    CheckBox_Brownout_Detection: TCheckBox;
    CheckBox_boot: TCheckBox;
    CheckBox_Verify: TCheckBox;
    CheckBox_Erase: TCheckBox;
    CheckBox_ASMFile: TCheckBox;
    CPU_InfoButton: TButton;
    GroupBox_ST_Link: TGroupBox;
    GroupBox_Bossac: TGroupBox;
    GroupBox_Programmer: TGroupBox;
    Label_FlashBase: TLabel;
    OpenDialog: TOpenDialog;
    ComboBox_ARM_Typ_FPC: TComboBox;
    CancelButton: TButton;
    ComboBox_ARM_SubArch: TComboBox;
    Label1: TLabel;
    Label5: TLabel;
    Memo1: TMemo;
    RadioButton_Bossac: TRadioButton;
    RadioButton_st_flash: TRadioButton;
    TemplatesButton: TButton;
    procedure ComboBox_ARM_SubArchChange(Sender: TObject);
    procedure Button_to_FlashBase_Click(Sender: TObject);
    procedure CPU_InfoButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure RadioButton_Programmer_Change(Sender: TObject);
    procedure TemplatesButtonClick(Sender: TObject);
  private
    ComboBox_STLinkPath, ComboBox_BossacPath: TFileNameComboBox;
    procedure ChangeARM_Typ;
  public
    procedure DefaultMask;
    procedure LazProjectToMask(LazProject: TLazProject);
    procedure MaskToLazProject(LazProject: TLazProject);
  end;

var
  ARM_Project_Options_Form: TARM_Project_Options_Form;

implementation

{$R *.lfm}

{ TARM_Project_Options_Form }

// public

procedure TARM_Project_Options_Form.FormCreate(Sender: TObject);
begin
  Caption := Title + 'ARM Project Options';
  LoadFormPos_from_XML(Self);

  // Compiler
  with ComboBox_ARM_SubArch do begin
    Items.CommaText := ARM_SubArch_List;
    Style := csOwnerDrawFixed;
  end;

  with ComboBox_ARM_Typ_FPC do begin
    Sorted := True;
  end;

  // Programmer
  ComboBox_STLinkPath := TFileNameComboBox.Create(GroupBox_ST_Link, 'STLinkPath');
  with ComboBox_STLinkPath do begin
    Caption := 'ST-Link Pfad:';
    Anchors := [akTop, akLeft, akRight];
    Left := 5;
    Width := GroupBox_ST_Link.Width - 10;
    Top := 10;
  end;

  with ARM_FlashBase_ComboBox do begin
    Sorted := True;
    Items.AddStrings(['0x00000000', '0x08000000']);
  end;

  ComboBox_BossacPath := TFileNameComboBox.Create(GroupBox_Bossac, 'BossacPath');
  with ComboBox_BossacPath do begin
    Caption := 'Bossac Pfad:';
    Anchors := [akTop, akLeft, akRight];
    Left := 5;
    Width := GroupBox_Bossac.Width - 10;
    Top := 10;
  end;
end;

procedure TARM_Project_Options_Form.DefaultMask;
begin
  // Compiler
  with ComboBox_ARM_SubArch do begin
    Text := 'ARMV7M';
    ItemIndex := Items.IndexOf(Text);
    ChangeARM_Typ;
  end;

  with ComboBox_ARM_Typ_FPC do begin
    Text := 'STM32F103X8';
  end;

  with ARM_FlashBase_ComboBox do begin
    Text := '0x08000000';
  end;

  CheckBox_ASMFile.Checked := False;

  // Programmer
  if Embedded_IDE_Options.ARM.STFlashPath.Count > 0 then begin
    ComboBox_STLinkPath.Text := Embedded_IDE_Options.ARM.STFlashPath[0];
  end else begin
    ComboBox_STLinkPath.Text := '';
  end;

  if Embedded_IDE_Options.ARM.BossacPath.Count > 0 then begin
    ComboBox_BossacPath.Text := Embedded_IDE_Options.ARM.BossacPath[0];
  end else begin
    ComboBox_BossacPath.Text := '';
  end;

  RadioButton_Programmer_Change(nil);
end;

procedure TARM_Project_Options_Form.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  SaveFormPos_to_XML(Self);
end;

procedure TARM_Project_Options_Form.Button_to_FlashBase_Click(Sender: TObject);
var
  i: integer;
  s: string;
begin
  for i := 1 to Length(ARM_ControllerDataList) - 1 do begin
    if ARM_ControllerDataList[i, 0] = ComboBox_ARM_Typ_FPC.Text then begin
      s := ARM_ControllerDataList[i, 4].ToInteger.ToHexString(8);
      ARM_FlashBase_ComboBox.Text := '0x' + s;
      Break;
    end;
  end;
end;

procedure TARM_Project_Options_Form.ComboBox_ARM_SubArchChange(Sender: TObject);
begin
  ChangeARM_Typ;
end;

procedure TARM_Project_Options_Form.ChangeARM_Typ;
var
  index: integer;
begin
  index := ComboBox_ARM_SubArch.ItemIndex;
  if (index < 0) or (index >= Length(ARM_SubArch_List)) then begin
    ComboBox_ARM_Typ_FPC.Items.CommaText := '';
  end else begin
    ComboBox_ARM_Typ_FPC.Items.CommaText := ARM_List[index];
  end;
end;

procedure TARM_Project_Options_Form.LazProjectToMask(LazProject: TLazProject);
var
  s, path, p: string;
begin
  // FPC Command
  with LazProject.LazCompilerOptions do begin
    ComboBox_ARM_SubArch.Text := TargetProcessor;
    ComboBox_ARM_SubArch.ItemIndex := ComboBox_ARM_SubArch.Items.IndexOf(ComboBox_ARM_SubArch.Text);
    ChangeARM_Typ;

    s := CustomOptions;
    ComboBox_ARM_Typ_FPC.Text := FindPara(s, '-Wp');
    CheckBox_AsmFile.Checked := Pos('-al', s) > 0;
  end;

  // Programmer Command
  s := LazProject.LazCompilerOptions.ExecuteAfter.Command;
  path := Copy(s, 0, pos(' ', s) - 1);

  p := UpCase(ExtractFileName(path));
  if Pos(UpCase('st-flash'), p) > 0 then begin
    RadioButton_st_flash.Checked := True;
    ComboBox_STLinkPath.Text := path;
    ARM_FlashBase_ComboBox.Text := '0x' + FindPara(s, '0x');
  end;

  if Pos(UpCase('bossac'), p) > 0 then begin
    RadioButton_Bossac.Checked := True;
    ComboBox_BossacPath.Text := path;
  end;

  RadioButton_Programmer_Change(nil);
end;

procedure TARM_Project_Options_Form.MaskToLazProject(LazProject: TLazProject);
var
  s: string;
begin
  // FPC_Command
  LazProject.LazCompilerOptions.TargetProcessor := ComboBox_ARM_SubArch.Text;
  s := '-Wp' + ComboBox_ARM_Typ_FPC.Text;
  if CheckBox_AsmFile.Checked then begin
    s += LineEnding + '-al';
  end;
  LazProject.LazCompilerOptions.CustomOptions := s;

  // Programmer Command
  if RadioButton_st_flash.Checked then begin
    s := ComboBox_STLinkPath.Text + ' write ' + LazProject.LazCompilerOptions.TargetFilename + '.bin ' + ARM_FlashBase_ComboBox.Text;
    LazProject.LazCompilerOptions.ExecuteAfter.Command := s;
  end;

  if RadioButton_Bossac.Checked then begin
    // /n4800/DATEN/Programmierung/Lazarus/Tutorials/Embedded/bossac/BOSSA-1.7.0/bin/bossac -e -w -v -b  /n4800/DATEN/Programmierung/Lazarus/Tutorials/Embedded/ARM/Arduino_DUE/von_MIR/Project1.bin -R
    s := ComboBox_BossacPath.Text + ' -e -w -v -b  ' + LazProject.LazCompilerOptions.TargetFilename + '.bin -R';
    LazProject.LazCompilerOptions.ExecuteAfter.Command := s;
  end;
end;

procedure TARM_Project_Options_Form.TemplatesButtonClick(Sender: TObject);
var
  TemplatesForm: TARMProjectTemplatesForm;
  i: integer;

begin
  TemplatesForm := TARMProjectTemplatesForm.Create(nil);

  for i := 0 to Length(ARM_TemplatesPara) - 1 do begin
    TemplatesForm.ListBox_Template.Items.AddStrings(ARM_TemplatesPara[i].Name);
  end;
  TemplatesForm.ListBox_Template.Caption := ARM_TemplatesPara[0].Name;
  TemplatesForm.ListBox_Template.ItemIndex := 0;

  if TemplatesForm.ShowModal = mrOk then begin
    i := TemplatesForm.ListBox_Template.ItemIndex;

    ComboBox_ARM_SubArch.Text := ARM_TemplatesPara[i].ARM_SubArch;
    ComboBox_ARM_Typ_FPC.Text := ARM_TemplatesPara[i].ARM_FPC_Typ;
    ARM_FlashBase_ComboBox.Text := ARM_TemplatesPara[i].FlashBase;
    ComboBox_ARM_SubArch.OnChange(Sender);
  end;

  TemplatesForm.Free;
end;

procedure TARM_Project_Options_Form.FormDestroy(Sender: TObject);
begin
  ComboBox_STLinkPath.Free;
  ComboBox_BossacPath.Free;
end;

procedure TARM_Project_Options_Form.RadioButton_Programmer_Change(Sender: TObject);
begin
  GroupBox_ST_Link.Enabled := RadioButton_st_flash.Checked;
  GroupBox_Bossac.Enabled := RadioButton_Bossac.Checked;
end;

procedure TARM_Project_Options_Form.CPU_InfoButtonClick(Sender: TObject);
var
  Form: TCPU_InfoForm;
begin
  Form := TCPU_InfoForm.Create(nil);
  Form.Load(ARM_ControllerDataList);
  Form.ShowModal;
  Form.Free;
end;

end.
