unit Embedded_GUI_Project_Templates_Form;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Buttons,
  Embedded_GUI_Common, Embedded_GUI_Embedded_List_Const, Embedded_GUI_Templates;

type

  { TProjectTemplatesForm }

  TProjectTemplatesForm = class(TForm)
    BitBtn_Ok: TBitBtn;
    BitBtn_Cancel: TBitBtn;
    Label1: TLabel;
    Label2: TLabel;
    ListBox_Template: TListBox;
    ListBox_Example: TListBox;
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
var
  index: Integer;
begin
  LoadFormPos_from_XML(Self);

  Caption := Title + 'Vorlagen';

  for index := 0 to Length(TemplatesPara) - 1 do begin
    ListBox_Template.Items.AddStrings(TemplatesPara[index].Name);
  end;
  ListBox_Template.Caption := TemplatesPara[0].Name;
  ListBox_Template.ItemIndex := 0;
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
