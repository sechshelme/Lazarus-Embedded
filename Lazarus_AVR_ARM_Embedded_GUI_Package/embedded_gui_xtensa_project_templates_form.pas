unit Embedded_GUI_Xtensa_Project_Templates_Form;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Buttons,
  Embedded_GUI_Common;

type

  { TXtensa_Project_Templates_Form }

  TXtensa_Project_Templates_Form = class(TForm)
    BitBtn_Cancel: TBitBtn;
    BitBtn_Ok: TBitBtn;
    Label1: TLabel;
    ListBox_Template: TListBox;
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure ListBox_TemplateDblClick(Sender: TObject);
  private

  public

  end;

var
  Xtensa_Project_Templates_Form: TXtensa_Project_Templates_Form;

implementation

{$R *.lfm}

{ TXtensa_Project_Templates_Form }

procedure TXtensa_Project_Templates_Form.FormCreate(Sender: TObject);
begin
  Caption:=Title + 'Xtensa Vorlagen';
  LoadFormPos_from_XML(Self);
end;

procedure TXtensa_Project_Templates_Form.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  SaveFormPos_to_XML(Self);
end;

procedure TXtensa_Project_Templates_Form.ListBox_TemplateDblClick(
  Sender: TObject);
begin
  BitBtn_Ok.Click;
end;

end.

