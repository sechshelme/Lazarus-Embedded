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
    Button1: TButton;
    OpenDialog1: TOpenDialog;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    LoadFile, SaveFile: TFileNameComboBox;
  public

  end;

var
  Form1: TForm1;


implementation

{$R *.lfm}


{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
  LoadFile := TFileNameComboBox.Create(Self, 'Load');
  LoadFile.Parent := Self;
  LoadFile.Anchors := [akTop, akLeft, akRight];
  LoadFile.Left := 5;
  LoadFile.Width := Self.Width - 10;
  LoadFile.Top := 5;

  SaveFile := TFileNameComboBox.Create(Self, 'Save');
  SaveFile.Parent := Self;
  SaveFile.Anchors := [akTop, akLeft, akRight];
  SaveFile.Left := 5;
  SaveFile.Width := Self.Width - 10;
  SaveFile.Top := 65;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  Caption := LoadFile.ClassName + '    ' + LoadFile.Name;
  LoadFile.Name:='test';
  SaveFile.Name:='test';
end;

end.


