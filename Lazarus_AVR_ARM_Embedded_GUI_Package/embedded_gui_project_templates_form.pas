unit Embedded_GUI_Project_Templates_Form;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Buttons,
  Embedded_GUI_Common;

type

  { TProjectTemplatesForm }

  TProjectTemplatesForm = class(TForm)
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
  ProjectTemplatesForm: TProjectTemplatesForm;

implementation

{$R *.lfm}

{ TProjectTemplatesForm }

procedure TProjectTemplatesForm.FormCreate(Sender: TObject);
begin
  LoadFormPos_from_XML(Self);
end;

procedure TProjectTemplatesForm.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  SaveFormPos_to_XML(Self);
end;

procedure TProjectTemplatesForm.ListBox_TemplateDblClick(Sender: TObject);
begin
  BitBtn_Ok.Click;
end;

end.
