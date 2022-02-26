unit Embedded_GUI_ARM_Project_Options_Form;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, StdCtrls, Dialogs, Buttons, ComCtrls,
  //  LazConfigStorage, BaseIDEIntf,
  LazIDEIntf, ProjectIntf, CompOptsIntf, IDEOptionsIntf, IDEOptEditorIntf,
  IDEExternToolIntf,
  //  Laz2_XMLCfg, // Für direkte *.lpi Zugriff

  Embedded_GUI_Common,
  Embedded_GUI_Common_FileComboBox,
  Embedded_GUI_Find_Comports,
  Embedded_GUI_IDE_Options_Frame,
  Embedded_GUI_ARM_Common,
  Embedded_GUI_Project_Templates_Form,
  Embedded_GUI_CPU_Info_Form,
  Embedded_GUI_Embedded_List_Const;

type

  { TARM_Project_Options_Form }

  TARM_Project_Options_Form = class(TForm)
    ARM_FlashBase_ComboBox: TComboBox;
    BitBtn_Auto_Flash_Base: TBitBtn;
    Button1: TButton;
    Button2: TButton;
    CheckBox_ASMFile: TCheckBox;
    CheckBox_boot: TCheckBox;
    CheckBox_Brownout_Detection: TCheckBox;
    CheckBox_Brownout_Reset: TCheckBox;
    CheckBox_Debug: TCheckBox;
    CheckBox_Erase: TCheckBox;
    CheckBox_force_USB_Port: TCheckBox;
    CheckBox_Info: TCheckBox;
    CheckBox_Lock: TCheckBox;
    CheckBox_Reset: TCheckBox;
    CheckBox_Security: TCheckBox;
    CheckBox_UF2File: TCheckBox;
    CheckBox_UnLock: TCheckBox;
    CheckBox_Verify: TCheckBox;
    ComboBox_ARM_SubArch: TComboBox;
    ComboBox_ARM_Typ_FPC: TComboBox;
    CPU_InfoButton: TButton;
    GroupBox_Compiler: TGroupBox;
    GroupBox_Programmer: TGroupBox;
    CancelButton: TButton;
    Label1: TLabel;
    Label5: TLabel;
    Label_FlashBase: TLabel;
    Memo1: TMemo;
    PageControl1: TPageControl;
    RadioButton_UF2: TRadioButton;
    RadioButton_Bossac: TRadioButton;
    RadioButton_st_flash: TRadioButton;
    TabSheet_UF2: TTabSheet;
    TabSheet_st_link: TTabSheet;
    TabSheet_Bossac: TTabSheet;
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
    ComboBox_STLinkPath, ComboBox_BossacPath, ComboBox_UF2_UnitPath, ComboBox_UF2_cp_Path, ComboBox_UF2_mount_Path: TFileNameComboBox;
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
  PageControl1.PageIndex := 0;

  // --- Compiler
  with ComboBox_ARM_SubArch do begin
    Items.CommaText := ARM_SubArch_List;
    Style := csOwnerDrawFixed;
  end;

  with ComboBox_ARM_Typ_FPC do begin
    Sorted := True;
  end;

  // --- Programer
  // ST-Link

  ComboBox_STLinkPath := TFileNameComboBox.Create(TabSheet_st_link, 'STLinkPath');
  with ComboBox_STLinkPath do begin
    Caption := 'ST-Link Pfad:';
    Anchors := [akTop, akLeft, akRight];
    Left := 5;
    Width := TabSheet_st_link.Width - 10;
    Top := 10;
  end;

  with ARM_FlashBase_ComboBox do begin
    Sorted := True;
    Items.AddStrings(['0x00000000', '0x00080000', '0x08000000']);
  end;

  // Bossac ( Arduino Due )

  ComboBox_BossacPath := TFileNameComboBox.Create(TabSheet_Bossac, 'BossacPath');
  with ComboBox_BossacPath do begin
    Caption := 'Bossac Pfad:';
    Anchors := [akTop, akLeft, akRight];
    Left := 5;
    Width := TabSheet_Bossac.Width - 10;
    Top := 10;
  end;

  // Rasberry PI Pico

  ComboBox_UF2_UnitPath := TFileNameComboBox.Create(TabSheet_UF2, 'UnitPath');
  with ComboBox_UF2_UnitPath do begin
    Caption := 'Unit Pfad:';
    Directory := True;
    Anchors := [akTop, akLeft, akRight];
    Left := 5;
    Width := TabSheet_UF2.Width - 10;
//    Width := Self.Width - 10;
    Top := 10;
  end;

  ComboBox_UF2_cp_Path := TFileNameComboBox.Create(TabSheet_UF2, 'cpPath');
  with ComboBox_UF2_cp_Path do begin
    Caption := 'cp Pfad:';
    Anchors := [akTop, akLeft, akRight];
    Left := 5;
    Width := TabSheet_UF2.Width - 10;
//    Width := Self.Width - 10;
    Top := 80;
  end;

  ComboBox_UF2_mount_Path := TFileNameComboBox.Create(TabSheet_UF2, 'mountPath');
  with ComboBox_UF2_mount_Path do begin
    Caption := 'Mount Pfad:';
    Directory := True;
    Anchors := [akTop, akLeft, akRight];
    Left := 5;
    Width := TabSheet_UF2.Width - 10;
//    Width := Self.Width - 10;
    Top := 150;
  end;

end;

procedure TARM_Project_Options_Form.DefaultMask;
begin
  // --- Compiler
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
  CheckBox_UF2File.Checked := False;

  // --- Programer
  // ST-Link
  if Embedded_IDE_Options.ARM.STFlashPath.Count > 0 then begin
    ComboBox_STLinkPath.Text := Embedded_IDE_Options.ARM.STFlashPath[0];
  end else begin
    ComboBox_STLinkPath.Text := '';
  end;

  // Bossac
  if Embedded_IDE_Options.ARM.BossacPath.Count > 0 then begin
    ComboBox_BossacPath.Text := Embedded_IDE_Options.ARM.BossacPath[0];
  end else begin
    ComboBox_BossacPath.Text := '';
  end;

  // Rasberry PI Pico
  if Embedded_IDE_Options.ARM.Raspi_Pico.Unit_Path.Count > 0 then begin
    ComboBox_UF2_UnitPath.Text := Embedded_IDE_Options.ARM.Raspi_Pico.Unit_Path[0];
  end else begin
    ComboBox_UF2_UnitPath.Text := '';
  end;

  if Embedded_IDE_Options.ARM.Raspi_Pico.cp_Path.Count > 0 then begin
    ComboBox_UF2_cp_Path.Text := Embedded_IDE_Options.ARM.Raspi_Pico.cp_Path[0];
  end else begin
    ComboBox_UF2_cp_Path.Text := '';
  end;

  if Embedded_IDE_Options.ARM.Raspi_Pico.mount_Path.Count > 0 then begin
    ComboBox_UF2_mount_Path.Text := Embedded_IDE_Options.ARM.Raspi_Pico.mount_Path[0];
  end else begin
    ComboBox_UF2_mount_Path.Text := '';
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
  sa: TStringArray;
begin
  // --- FPC Command
  with LazProject.LazCompilerOptions do begin
    ComboBox_ARM_SubArch.Text := TargetProcessor;
    ComboBox_ARM_SubArch.ItemIndex := ComboBox_ARM_SubArch.Items.IndexOf(ComboBox_ARM_SubArch.Text);
    ChangeARM_Typ;

    s := CustomOptions;
    ComboBox_ARM_Typ_FPC.Text := FindPara(s, '-Wp');
    CheckBox_AsmFile.Checked := Pos('-al', s) > 0;
    CheckBox_UF2File.Checked := Pos('-Xu', s) > 0;
  end;

  // --- Programmer Command
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

  // Rasberry PI Pico
  if Pos(UpCase('.uf2 '), s) > 0 then begin
    RadioButton_UF2.Checked := True;
    //    ComboBox_UF2_UnitPath.Text := path;
    ComboBox_UF2_cp_Path.Text := path;
    sa := s.Split(' ');
    if Length(sa) >= 3 then begin
      ComboBox_UF2_mount_Path.Text := sa[2];
    end else begin
      ComboBox_UF2_mount_Path.Text := '';
    end;
  end;

  RadioButton_Programmer_Change(nil);
end;

procedure TARM_Project_Options_Form.MaskToLazProject(LazProject: TLazProject);
var
  s, sf: string;
begin
  // --- FPC_Command
  LazProject.LazCompilerOptions.TargetProcessor := ComboBox_ARM_SubArch.Text;
  s := '-Wp' + ComboBox_ARM_Typ_FPC.Text;
  if CheckBox_AsmFile.Checked then begin
    s += LineEnding + '-al';
  end;
  if CheckBox_UF2File.Checked then begin
    s += LineEnding + '-Xu';
  end;
  LazProject.LazCompilerOptions.CustomOptions := s;

  // --- Programmer Command
  // ST-Link
  if RadioButton_st_flash.Checked then begin
    s := ComboBox_STLinkPath.Text + ' write ' + LazProject.LazCompilerOptions.TargetFilename + '.bin ' + ARM_FlashBase_ComboBox.Text;
    LazProject.LazCompilerOptions.ExecuteAfter.Command := s;
  end;

  // Bossac
  if RadioButton_Bossac.Checked then begin
    // /n4800/DATEN/Programmierung/Lazarus/Tutorials/Embedded/bossac/BOSSA-1.7.0/bin/bossac -e -w -v -b  /n4800/DATEN/Programmierung/Lazarus/Tutorials/Embedded/ARM/Arduino_DUE/von_MIR/Project1.bin -R
    s := ComboBox_BossacPath.Text + ' -e -w -v -b  ' + LazProject.LazCompilerOptions.TargetFilename + '.bin -R';
    LazProject.LazCompilerOptions.ExecuteAfter.Command := s;
  end;

  // Rasberry PI Pico
  if RadioButton_UF2.Checked then begin
    sf := LazProject.LazCompilerOptions.TargetFilename + '.uf2';
    s := ComboBox_UF2_cp_Path.Text + ' ' + sf + ' ' + ComboBox_UF2_mount_Path.Text + DirectorySeparator + sf;
    LazProject.LazCompilerOptions.ExecuteAfter.Command := s;

    LazProject.LazCompilerOptions.OtherUnitFiles:=ComboBox_UF2_UnitPath.Text;// Was passiert bei mehreren Pfaden ???????
  end;
end;

procedure TARM_Project_Options_Form.TemplatesButtonClick(Sender: TObject);
var
  TemplatesForm: TProjectTemplatesForm;
  i: integer;

begin
  TemplatesForm := TProjectTemplatesForm.Create(nil);
  TemplatesForm.Caption := Title + 'ARM Vorlagen';

  for i := 0 to Length(ARM_TemplatesPara) - 1 do begin
    TemplatesForm.ListBox_Template.Items.AddStrings(ARM_TemplatesPara[i].Name);
  end;
  TemplatesForm.ListBox_Template.Caption := ARM_TemplatesPara[0].Name;
  TemplatesForm.ListBox_Template.ItemIndex := 0;

  if TemplatesForm.ShowModal = mrOk then begin
    i := TemplatesForm.ListBox_Template.ItemIndex;

    ComboBox_ARM_SubArch.Text := ARM_TemplatesPara[i].ARM_SubArch;
    ComboBox_ARM_Typ_FPC.Text := ARM_TemplatesPara[i].ARM_FPC_Typ;
    CheckBox_UF2File.Checked := ARM_TemplatesPara[i].Create_UF2_File;

    ARM_FlashBase_ComboBox.Text := ARM_TemplatesPara[i].FlashBase;
    ComboBox_ARM_SubArch.OnChange(Sender);


    RadioButton_st_flash.Checked := ARM_TemplatesPara[i].Programmer = 'st-flash';
    RadioButton_UF2.Checked := ARM_TemplatesPara[i].Programmer = 'uf2';
    RadioButton_Bossac.Checked := ARM_TemplatesPara[i].Programmer = 'bossac';
  end;

  TemplatesForm.Free;
end;

procedure TARM_Project_Options_Form.FormDestroy(Sender: TObject);
begin
end;

procedure TARM_Project_Options_Form.RadioButton_Programmer_Change(Sender: TObject);
begin
  TabSheet_st_link.Enabled := RadioButton_st_flash.Checked;
  TabSheet_Bossac.Enabled := RadioButton_Bossac.Checked;
  TabSheet_UF2.Enabled := RadioButton_UF2.Checked;
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
