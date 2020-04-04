unit Embedded_GUI_AVR_Project_Templates_Form;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Buttons,
  BaseIDEIntf, LazConfigStorage,

  Embedded_GUI_Common;

type

  { TAVRProjectTemplatesForm }

  TAVRProjectTemplatesForm = class(TForm)
    BitBtn_Ok: TBitBtn;
    BitBtn_Cancel: TBitBtn;
    Label1: TLabel;
    ListBox_Template: TListBox;
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure ListBox_TemplateDblClick(Sender: TObject);
  private

  public

  end;

var
  AVRProjectTemplatesForm: TAVRProjectTemplatesForm;

implementation

{$R *.lfm}

{ TAVRProjectTemplatesForm }

procedure TAVRProjectTemplatesForm.ListBox_TemplateDblClick(Sender: TObject);
begin
  BitBtn_Ok.Click;
end;

procedure TAVRProjectTemplatesForm.FormCreate(Sender: TObject);
var
  Cfg: TConfigStorage;
begin
  Caption:=Title + 'AVR Vorlagen';
  Cfg := GetIDEConfigStorage(Embedded_Options_File, True);
  Left := StrToInt(Cfg.GetValue(Key_AVR_Templates_Left, '90'));
  Top := StrToInt(Cfg.GetValue(Key_AVR_Templates_Top, '60'));
  Width := StrToInt(Cfg.GetValue(Key_AVR_Templates_Width, '300'));
  Height := StrToInt(Cfg.GetValue(Key_AVR_Templates_Height, '400'));
  Cfg.Free;
end;

procedure TAVRProjectTemplatesForm.FormClose(Sender: TObject; var CloseAction: TCloseAction);
var
  Cfg: TConfigStorage;
begin
  Cfg := GetIDEConfigStorage(Embedded_Options_File, True);
  Cfg.SetDeleteValue(Key_AVR_Templates_Left, IntToStr(Left), '90');
  Cfg.SetDeleteValue(Key_AVR_Templates_Top, IntToStr(Top), '60');
  Cfg.SetDeleteValue(Key_AVR_Templates_Width, IntToStr(Width), '300');
  Cfg.SetDeleteValue(Key_AVR_Templates_Height, IntToStr(Height), '400');
  Cfg.Free;
end;

end.
