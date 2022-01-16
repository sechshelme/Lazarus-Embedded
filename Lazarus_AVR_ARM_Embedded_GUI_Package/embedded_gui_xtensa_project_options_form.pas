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
    CheckBox_AsmFile: TCheckBox;
    ComboBox_Xtensa_SubArch: TComboBox;
    ComboBox_Xtensa_Typ_FPC: TComboBox;
    CPU_InfoButton: TButton;
    Label1: TLabel;
    Label5: TLabel;
    Memo1: TMemo;
    TemplatesButton: TButton;
    procedure ComboBox_Xtensa_SubArchChange(Sender: TObject);
    procedure CPU_InfoButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure TemplatesButtonClick(Sender: TObject);
  private
    procedure ChangeXtensa_Typ;
  public
    procedure DefaultMask;
    procedure LazProjectToMask(LazProject: TLazProject);
    procedure MaskToLazProject(LazProject: TLazProject);
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
  Form.Load(xtensa_ControllerDataList);
  Form.ShowModal;
  Form.Free;
end;

procedure TXtensa_Project_Options_Form.ComboBox_Xtensa_SubArchChange(
  Sender: TObject);
begin
  ChangeXtensa_Typ;
end;

procedure TXtensa_Project_Options_Form.FormCreate(Sender: TObject);
begin
  Caption := Title + 'Xtensa Project Options';
  LoadFormPos_from_XML(Self);

  // Compiler
  with ComboBox_Xtensa_SubArch do begin
    Items.CommaText := xtensa_SubArch_List;
    //    ItemIndex := 3;                    // ???????????????
    Style := csOwnerDrawFixed;
  end;

  with ComboBox_Xtensa_Typ_FPC do begin
    Sorted := True;
  end;

  CheckBox_AsmFile.Checked := False;

  // AVRDude_Command

  // ...................
end;

procedure TXtensa_Project_Options_Form.TemplatesButtonClick(Sender: TObject);
var
  TemplatesForm: TXtensa_Project_Templates_Form;
  i: integer;

begin
  TemplatesForm := TXtensa_Project_Templates_Form.Create(nil);

  for i := 0 to Length(Xtensa_TemplatesPara) - 1 do begin
    TemplatesForm.ListBox_Template.Items.AddStrings(Xtensa_TemplatesPara[i].Name);
  end;
  TemplatesForm.ListBox_Template.Caption := Xtensa_TemplatesPara[0].Name;
  TemplatesForm.ListBox_Template.ItemIndex := 0;

  if TemplatesForm.ShowModal = mrOk then begin
    i := TemplatesForm.ListBox_Template.ItemIndex;

    //ComboBox_ARM_SubArch.Text := Xtensa_TemplatesPara[i].ARM_SubArch;
    //ComboBox_ARM_Typ_FPC.Text := Xtensa_TemplatesPara[i].ARM_FPC_Typ;
    //ARM_FlashBase_ComboBox.Text := Xtensa_TemplatesPara[i].FlashBase;
    ComboBox_Xtensa_SubArch.OnChange(Sender);
  end;

  TemplatesForm.Free;
end;

procedure TXtensa_Project_Options_Form.ChangeXtensa_Typ;
  var
    index: integer;
  begin
    index := ComboBox_Xtensa_SubArch.ItemIndex;
    if (index < 0) or (index >= Length(xtensa_SubArch_List)) then begin
      ComboBox_Xtensa_Typ_FPC.Items.Text := '';
    end else begin
      ComboBox_Xtensa_Typ_FPC.Items.CommaText := xtensa_List[index];
    end;
  end;

procedure TXtensa_Project_Options_Form.DefaultMask;
begin
  // Compiler
  with ComboBox_Xtensa_SubArch do begin
    Text := 'lx6';
    ItemIndex := Items.IndexOf(Text);
    ChangeXtensa_Typ;
  end;

  with ComboBox_Xtensa_Typ_FPC do begin
    Text := 'ESP32';
  end;

  CheckBox_AsmFile.Checked := False;

  // AVRDude_Command
  // ........................
end;

procedure TXtensa_Project_Options_Form.LazProjectToMask(LazProject: TLazProject);
var
  s: String;
begin
  // FPC_Command
  with LazProject.LazCompilerOptions do begin
    ComboBox_Xtensa_SubArch.Text := TargetProcessor;
    ComboBox_Xtensa_SubArch.ItemIndex := ComboBox_Xtensa_SubArch.Items.IndexOf(ComboBox_Xtensa_SubArch.Text);
    ChangeXtensa_Typ;

    s := CustomOptions;
    ComboBox_Xtensa_Typ_FPC.Text := FindPara(s, '-Wp');
    CheckBox_AsmFile.Checked := Pos('-al', s) > 0;
  end;


  // AVRDude_Command
  // ........................

end;

procedure TXtensa_Project_Options_Form.MaskToLazProject(LazProject: TLazProject);
var
  s: String;
begin

    // FPC_Command
    LazProject.LazCompilerOptions.TargetProcessor := ComboBox_Xtensa_SubArch.Text;
    s := '-Wp' + ComboBox_Xtensa_Typ_FPC.Text;
    if CheckBox_AsmFile.Checked then begin
      s += LineEnding + '-al';
    end;
    LazProject.LazCompilerOptions.CustomOptions := s;

    // AVRDude_Command

  // ........................
end;

end.
