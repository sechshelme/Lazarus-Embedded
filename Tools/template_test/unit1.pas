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
begin
  f := TProjectTemplatesForm.Create(nil);
  if f.ShowModal = mrOk then begin
    ShowMessage('ok');
  end;
  f.Free;
end;

end.
