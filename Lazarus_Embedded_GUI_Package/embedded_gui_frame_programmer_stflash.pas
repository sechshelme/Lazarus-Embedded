unit Embedded_GUI_Frame_Programmer_STFlash;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, LResources, Forms, Controls, StdCtrls, Buttons,

  ProjectIntf,

  Embedded_GUI_Common,
  Embedded_GUI_Find_Comports,
  Embedded_GUI_Common_FileComboBox,
  Embedded_GUI_Embedded_List_Const,
  Embedded_GUI_Project_Templates_Form,
  Embedded_GUI_Frame_IDE_Options;

type

  { TFrame_STFlash }

  TFrame_STFlash = class(TFrame)
    BitBtn_Auto_Flash_Base: TBitBtn;
    ComboBox_ARM_FlashBase: TComboBox;
    Label_FlashBase: TLabel;
    ScrollBox1: TScrollBox;
    procedure BitBtn_Auto_Flash_BaseClick(Sender: TObject);
  private
    FController: String;
  public
    ComboBox_STLinkPath:TFileNameComboBox;
    property Controller: String write FController;
    constructor Create(TheOwner: TComponent); override;
    procedure DefaultMask;
    procedure LazProjectToMask(var prg, cmd: string);
    procedure MaskToLazProject(LazProject: TLazProject);
    procedure TemplateToMask(index: Integer);
  end;

implementation

{$R *.lfm}

{ TFrame_STFlash }

procedure TFrame_STFlash.BitBtn_Auto_Flash_BaseClick(Sender: TObject);
var
  i: integer;
  s: string;
begin
  for i := 1 to Length(ARM_ControllerDataList) - 1 do begin
    if ARM_ControllerDataList[i, 0] = FController then begin
      s := ARM_ControllerDataList[i, 4].ToInteger.ToHexString(8);
      ComboBox_ARM_FlashBase.Text := '0x' + s;
      Break;
    end;
  end;
end;

constructor TFrame_STFlash.Create(TheOwner: TComponent);
begin
  inherited Create(TheOwner);
  ComboBox_STLinkPath := TFileNameComboBox.Create(ScrollBox1, 'STLinkPath');
  with ComboBox_STLinkPath do begin
    Caption := 'ST-Link Path:';
    Anchors := [akTop, akLeft, akRight];
    Left := 5;
    Width := ScrollBox1.Width - 10;
    Top := 10;
  end;

  with ComboBox_ARM_FlashBase do begin
    Sorted := True;
    Items.AddStrings(['0x00000000', '0x00080000', '0x08000000']);
  end;
end;

procedure TFrame_STFlash.DefaultMask;
begin
  with ComboBox_ARM_FlashBase do begin
    Text := '0x08000000';
  end;

  if Embedded_IDE_Options.ARM.STFlashPath.Count > 0 then begin
    ComboBox_STLinkPath.Text := Embedded_IDE_Options.ARM.STFlashPath[0];
  end else begin
    ComboBox_STLinkPath.Text := '';
  end;
end;

procedure TFrame_STFlash.LazProjectToMask(var prg, cmd: string);
begin
  ComboBox_STLinkPath.Text := prg;
  ComboBox_ARM_FlashBase.Text := '0x' + FindPara(cmd, ['0x']);
end;

procedure TFrame_STFlash.MaskToLazProject(LazProject: TLazProject);
begin
  LazProject.LazCompilerOptions.ExecuteAfter.Command :=
    ComboBox_STLinkPath.Text + ' write ' + LazProject.LazCompilerOptions.TargetFilename + '.bin ' + ComboBox_ARM_FlashBase.Text;
end;

procedure TFrame_STFlash.TemplateToMask(index: Integer);
begin
  ComboBox_ARM_FlashBase.Text := TemplatesPara[index].stlink.FlashBase;
end;

initialization

end.

