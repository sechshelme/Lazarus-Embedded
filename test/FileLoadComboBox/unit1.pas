unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls,
  Laz2_XMLCfg,
  Embedded_GUI_Common_FileComboBox;

type

  { TForm1 }

  TForm1 = class(TForm)
    procedure FormCreate(Sender: TObject);
  private
    fb: TFileNameComboBox;
  public

  end;

var
  Form1: TForm1;


implementation

{$R *.lfm}


{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
  fb := TFileNameComboBox.Create(Self);
  fb.Parent := Self;
  fb.Caption := 'Send File';
  fb.Anchors := [akTop, akLeft, akRight];
  fb.Left := 5;
  fb.Width := Self.Width - 10;
  fb.Top := 5;
end;

end.
