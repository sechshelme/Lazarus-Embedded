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
    ComboBox_STLinkPath: TComboBox;
    ComboBox_ARM_Typ_FPC: TComboBox;
    Button1: TButton;
    CancelButton: TButton;
    ComboBox_ARM_SubArch: TComboBox;
    Label1: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Memo1: TMemo;
    OkButton: TButton;
    TemplatesButton: TButton;
    procedure ComboBox_ARM_SubArchChange(Sender: TObject);
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
  LoadComboBox_from_XML(ComboBox_STLinkPath);
  if Embedded_IDE_Options.ARM.STFlashPath.Count > 0 then begin
    ComboBox_STLinkPath.Text := Embedded_IDE_Options.ARM.STFlashPath[0];
  end else begin
    ComboBox_STLinkPath.Text := '';
  end;
  ComboBox_Insert_Text(ComboBox_STLinkPath);

  with ComboBox_ARM_SubArch do begin
    Items.CommaText := ARM_SubArch_List;
    Style := csOwnerDrawFixed;
    Text := 'ARMV7M';
  end;

  with ComboBox_ARM_Typ_FPC do begin
    Sorted := True;
    Text := 'STM32F103X8';
  end;

  with ARM_FlashBase_ComboBox do begin
    Sorted := True;
    Text := '0x08000000';
    Items.AddStrings(['0x00000000', '0x08000000']);
  end;

  CheckBox_ASMFile.Checked := False;

  LoadComboBox_from_XML(ComboBox_STLinkPath);

  if IsNewProject then begin
    if Embedded_IDE_Options.ARM.STFlashPath.Count > 0 then begin
      ComboBox_STLinkPath.Text := Embedded_IDE_Options.ARM.STFlashPath[0];
    end else begin
      ComboBox_STLinkPath.Text := '';
    end;
  end else begin
    ComboBox_STLinkPath.Text := ARM_ProjectOptions.stlink_Command.Path;

    ComboBox_ARM_SubArch.Text := ARM_ProjectOptions.ARM_SubArch;
    ComboBox_ARM_Typ_FPC.Text := ARM_ProjectOptions.ARM_FPC_Typ;

    ARM_FlashBase_ComboBox.Text := ARM_ProjectOptions.stlink_Command.FlashBase;

    CheckBox_ASMFile.Checked := ARM_ProjectOptions.AsmFile;
  end;
  ComboBox_Insert_Text(ComboBox_STLinkPath);

  ChangeARM;
end;

procedure TARM_Project_Options_Form.OkButtonClick(Sender: TObject);
begin
  ComboBox_Insert_Text(ComboBox_STLinkPath);
  SaveComboBox_to_XML(ComboBox_STLinkPath);

  ARM_ProjectOptions.ARM_SubArch := ComboBox_ARM_SubArch.Text;
  ARM_ProjectOptions.ARM_FPC_Typ := ComboBox_ARM_Typ_FPC.Text;

  ARM_ProjectOptions.stlink_Command.Path := ComboBox_STLinkPath.Text;
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

    ComboBox_ARM_SubArch.Text := ARM_TemplatesPara[i].ARM_SubArch;
    ComboBox_ARM_Typ_FPC.Text := ARM_TemplatesPara[i].ARM_FPC_Typ;
    ARM_FlashBase_ComboBox.Text := ARM_TemplatesPara[i].FlashBase;
    ComboBox_ARM_SubArch.OnChange(Sender);
  end;

  TemplatesForm.Free;
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
  ChangeARM;
end;

procedure TARM_Project_Options_Form.Button_AVRDude_Path_Click(Sender: TObject);
begin
  OpenDialog.FileName := ComboBox_STLinkPath.Text;
  if OpenDialog.Execute then begin
    ComboBox_STLinkPath.Text := OpenDialog.FileName;
    ComboBox_Insert_Text(ComboBox_STLinkPath);
  end;
end;

// private

procedure TARM_Project_Options_Form.ChangeARM;
var
  ind: integer;
begin
  ind := ComboBox_ARM_SubArch.ItemIndex;
  if (ind < 0) or (ind >= Length(ARM_SubArch_List)) then begin
    ComboBox_ARM_Typ_FPC.Items.CommaText := '';
  end else begin
    ComboBox_ARM_Typ_FPC.Items.CommaText := ARM_List[ind];
  end;
end;

end.
