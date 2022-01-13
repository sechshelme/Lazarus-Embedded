unit Embedded_GUI_XTensa_Project_Options_Form;

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
  Embedded_GUI_Xtensa_Common,
  Embedded_GUI_Xtensa_Project_Templates_Form,
  Embedded_GUI_CPU_Info_Form,
  Embedded_GUI_Embedded_List_Const;

type

  { TXtensa_Project_Options_Form }

  TXtensa_Project_Options_Form = class(TForm)
    Button1: TButton;
    CancelButton: TButton;
    CPU_InfoButton: TButton;
    Memo1: TMemo;
    TemplatesButton: TButton;
    procedure CPU_InfoButtonClick(Sender: TObject);
    procedure TemplatesButtonClick(Sender: TObject);
  private

  public

  end;

var
  Xtensa_Project_Options_Form: TXtensa_Project_Options_Form;

implementation

{$R *.lfm}

{ TXtensa_Project_Options_Form }

procedure TXtensa_Project_Options_Form.CPU_InfoButtonClick(Sender: TObject);
var
  Form: TCPU_InfoForm;
begin
  Form := TCPU_InfoForm.Create(nil);
  Form.Load(ARM_ControllerDataList);
  Form.ShowModal;
  Form.Free;
end;

procedure TXtensa_Project_Options_Form.TemplatesButtonClick(Sender: TObject);
var
  TemplatesForm: TXtensa_Project_Templates_Form;
  i: integer;

begin
  TemplatesForm := TXtensa_Project_Templates_Form.Create(nil);

  for i := 0 to Length(ARM_TemplatesPara) - 1 do begin
    TemplatesForm.ListBox_Template.Items.AddStrings(ARM_TemplatesPara[i].Name);
  end;
  TemplatesForm.ListBox_Template.Caption := ARM_TemplatesPara[0].Name;
  TemplatesForm.ListBox_Template.ItemIndex := 0;

  if TemplatesForm.ShowModal = mrOk then begin
    i := TemplatesForm.ListBox_Template.ItemIndex;

    //ComboBox_ARM_SubArch.Text := ARM_TemplatesPara[i].ARM_SubArch;
    //ComboBox_ARM_Typ_FPC.Text := ARM_TemplatesPara[i].ARM_FPC_Typ;
    //ARM_FlashBase_ComboBox.Text := ARM_TemplatesPara[i].FlashBase;
    //ComboBox_ARM_SubArch.OnChange(Sender);
  end;

  TemplatesForm.Free;
end;

end.
