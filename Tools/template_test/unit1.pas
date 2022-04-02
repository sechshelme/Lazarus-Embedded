unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls,
  Embedded_GUI_Project_Templates_Form,
  Embedded_GUI_Templates;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.Button1Click(Sender: TObject);
var
  f: TProjectTemplatesForm;
  i: integer;
begin
  f := TProjectTemplatesForm.Create(nil);
  if f.ShowModal = mrOk then begin

    i := f.ListBox_Template.ItemIndex;
//    ShowMessage(TemplatesPara[i].Controller);
    ShowMessage(f.getSource);
  end;
  f.Free;
end;

end.
