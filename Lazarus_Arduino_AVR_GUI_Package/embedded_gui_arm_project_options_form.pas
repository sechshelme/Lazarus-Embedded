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
  Embedded_GUI_Find_Comports,
  Embedded_GUI_IDE_Options_Frame,
  Embedded_GUI_ARM_Common,
  Embedded_GUI_ARM_Project_Templates_Form,
  Embedded_GUI_CPU_Info_Form,
  Embedded_GUI_SubArch_List;

type

  { TARM_Project_Options_Form }

  TARM_Project_Options_Form = class(TForm)
    CheckBox_ASMFile: TCheckBox;
    BitBtn1: TBitBtn;
    ARM_FlashBase_ComboBox: TComboBox;
    CPU_InfoButton: TButton;
    Label2: TLabel;
    OpenDialog: TOpenDialog;
    STLinkPathComboBox: TComboBox;
    ARM_Typ_FPC_ComboBox: TComboBox;
    Button1: TButton;
    CancelButton: TButton;
    ARM_SubArch_ComboBox: TComboBox;
    Label1: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Memo1: TMemo;
    OkButton: TButton;
    TemplatesButton: TButton;
    procedure ARM_SubArch_ComboBoxChange(Sender: TObject);
    procedure Button_AVRDude_Path_Click(Sender: TObject);
    procedure Button_to_FlashBase_Click(Sender: TObject);
    procedure CPU_InfoButtonClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure OkButtonClick(Sender: TObject);
    procedure TemplatesButtonClick(Sender: TObject);
  private
    procedure ChangeARM;
  public
    IsNewProject: boolean;
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
  IsNewProject := False;
end;

procedure TARM_Project_Options_Form.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  SaveFormPos_to_XML(Self);
end;

procedure TARM_Project_Options_Form.FormActivate(Sender: TObject);
begin
  LoadComboBox_from_XML(STLinkPathComboBox);
  if Embedded_IDE_Options.ARM.STFlashPath.Count > 0 then begin
    STLinkPathComboBox.Text := Embedded_IDE_Options.ARM.STFlashPath[0];
  end else begin
    STLinkPathComboBox.Text := '';
  end;
  ComboBox_Insert_Text(STLinkPathComboBox);

  with ARM_SubArch_ComboBox do begin
    Items.CommaText := ARM_SubArch_List;
    Style := csOwnerDrawFixed;
    Text := 'ARMV7M';
  end;

  with ARM_Typ_FPC_ComboBox do begin
    Sorted := True;
    Text := 'STM32F103X8';
  end;

  with ARM_FlashBase_ComboBox do begin
    Sorted := True;
    Text := '0x08000000';
    Items.AddStrings(['0x00000000', '0x08000000']);
  end;

  CheckBox_ASMFile.Checked := False;

  LoadComboBox_from_XML(STLinkPathComboBox);

  if IsNewProject then begin
    if Embedded_IDE_Options.ARM.STFlashPath.Count > 0 then begin
      STLinkPathComboBox.Text := Embedded_IDE_Options.ARM.STFlashPath[0];
    end else begin
      STLinkPathComboBox.Text := '';
    end;
  end else begin
    STLinkPathComboBox.Text := ARM_ProjectOptions.stlink_Command.Path;

    ARM_SubArch_ComboBox.Text := ARM_ProjectOptions.ARM_SubArch;
    ARM_Typ_FPC_ComboBox.Text := ARM_ProjectOptions.ARM_FPC_Typ;

    ARM_FlashBase_ComboBox.Text := ARM_ProjectOptions.stlink_Command.FlashBase;

    CheckBox_ASMFile.Checked := ARM_ProjectOptions.AsmFile;
  end;
  ComboBox_Insert_Text(STLinkPathComboBox);

  ChangeARM;
end;

procedure TARM_Project_Options_Form.OkButtonClick(Sender: TObject);
begin
  ComboBox_Insert_Text(STLinkPathComboBox);
  SaveComboBox_to_XML(STLinkPathComboBox);

  ARM_ProjectOptions.ARM_SubArch := ARM_SubArch_ComboBox.Text;
  ARM_ProjectOptions.ARM_FPC_Typ := ARM_Typ_FPC_ComboBox.Text;

  ARM_ProjectOptions.stlink_Command.Path := STLinkPathComboBox.Text;
  ARM_ProjectOptions.stlink_Command.FlashBase := ARM_FlashBase_ComboBox.Text;

  ARM_ProjectOptions.AsmFile := CheckBox_ASMFile.Checked;
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

    ARM_SubArch_ComboBox.Text := ARM_TemplatesPara[i].ARM_SubArch;
    ARM_Typ_FPC_ComboBox.Text := ARM_TemplatesPara[i].ARM_FPC_Typ;
    ARM_FlashBase_ComboBox.Text := ARM_TemplatesPara[i].FlashBase;
    ARM_SubArch_ComboBox.OnChange(Sender);
  end;

  TemplatesForm.Free;
end;

procedure TARM_Project_Options_Form.Button_to_FlashBase_Click(Sender: TObject);
var
  i: integer;
  s: string;
begin
  for i := 1 to Length(ARM_ControllerDataList) - 1 do begin
    if ARM_ControllerDataList[i, 0] = ARM_Typ_FPC_ComboBox.Text then begin
      s := ARM_ControllerDataList[i, 4].ToInteger.ToHexString(8);
      ARM_FlashBase_ComboBox.Text := '0x' + s;
      Break;
    end;
  end;
end;

procedure TARM_Project_Options_Form.ARM_SubArch_ComboBoxChange(Sender: TObject);
begin
  ChangeARM;
end;

procedure TARM_Project_Options_Form.Button_AVRDude_Path_Click(Sender: TObject);
begin
  OpenDialog.FileName := STLinkPathComboBox.Text;
  if OpenDialog.Execute then begin
    STLinkPathComboBox.Text := OpenDialog.FileName;
    ComboBox_Insert_Text(STLinkPathComboBox);
  end;
end;

// private

procedure TARM_Project_Options_Form.ChangeARM;
var
  ind: integer;
begin
  ind := ARM_SubArch_ComboBox.ItemIndex;
  if (ind < 0) or (ind >= Length(ARM_SubArch_List)) then begin
    ARM_Typ_FPC_ComboBox.Items.CommaText := '';
  end else begin
    ARM_Typ_FPC_ComboBox.Items.CommaText := ARM_List[ind];
  end;
end;

end.
