unit Embedded_GUI_AVR_Project_Templates_Form;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Buttons,

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
begin
  Caption:=Title + 'AVR Vorlagen';
  LoadFormPos(Self);
end;

procedure TAVRProjectTemplatesForm.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  SaveFormPos(Self);
end;

end.
