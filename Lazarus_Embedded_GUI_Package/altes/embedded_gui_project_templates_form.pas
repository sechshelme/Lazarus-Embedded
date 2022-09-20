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
    procedure ListBox_TemplateClick(Sender: TObject);
    procedure ListBoxDblClick(Sender: TObject);
  private
  public
    function getSource: string;
  end;

var
  ProjectTemplatesForm: TProjectTemplatesForm;

implementation

{$R *.lfm}

{ TProjectTemplatesForm }

procedure TProjectTemplatesForm.FormCreate(Sender: TObject);
var
  index: integer;
begin
  LoadFormPos_from_XML(Self);

  Caption := Title + 'Vorlagen';

  for index := 0 to Length(TemplatesPara) - 1 do begin
    ListBox_Template.Items.AddStrings(TemplatesPara[index].Name);
  end;
  if ListBox_Template.Count >= 1 then begin
    ListBox_Template.ItemIndex := 0;
  end;
  ListBox_TemplateClick(Sender);
end;

procedure TProjectTemplatesForm.ListBox_TemplateClick(Sender: TObject);
var
  p, i, index: integer;
  s: string;
begin
  index := ListBox_Template.ItemIndex;
  ListBox_Example.Clear;
  for i := 0 to Length(TemplatesPara[index].Examples) - 1 do begin
    p := Pos(LineEnding, TemplatesPara[index].Examples[i]);
    s := Copy(TemplatesPara[index].Examples[i], 3, p - 3);
    ListBox_Example.Items.Add(s);
  end;
  if ListBox_Example.Count >= 2 then begin
    ListBox_Example.ItemIndex := 1;
  end;
end;

procedure TProjectTemplatesForm.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  SaveFormPos_to_XML(Self);
end;

procedure TProjectTemplatesForm.ListBoxDblClick(Sender: TObject);
begin
  BitBtn_Ok.Click;
end;

function TProjectTemplatesForm.getSource: string;
begin
  Result := TemplatesPara[ListBox_Template.ItemIndex].Examples[ListBox_Example.ItemIndex];
end;

end.
