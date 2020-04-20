unit Embedded_GUI_ARM_Project_Templates_Form;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Buttons,

  Embedded_GUI_Common;

type

  { TARMProjectTemplatesForm }

  TARMProjectTemplatesForm = class(TForm)
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
  ARMProjectTemplatesForm: TARMProjectTemplatesForm;

implementation

{$R *.lfm}

{ TARMProjectTemplatesForm }

procedure TARMProjectTemplatesForm.ListBox_TemplateDblClick(Sender: TObject);
begin
  BitBtn_Ok.Click;
end;

procedure TARMProjectTemplatesForm.FormCreate(Sender: TObject);
begin
  Caption:=Title + 'ARM Vorlagen';
  LoadFormPos(Self);
end;

procedure TARMProjectTemplatesForm.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  SaveFormPos(Self);
end;

end.

