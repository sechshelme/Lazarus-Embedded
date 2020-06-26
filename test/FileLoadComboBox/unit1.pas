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
    Button2: TButton;
    OpenDialog1: TOpenDialog;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    LoadFile, SaveFile, ModifFile: TFileNameComboBox;
  public

  end;

var
  Form1: TForm1;


implementation

{$R *.lfm}


{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
  LoadFile := TFileNameComboBox.Create(Self, 'Load',['a,','c,','d,']);
  with LoadFile do begin
    Anchors := [akTop, akLeft, akRight];
    Left := 5;
    Width := Self.Width - 10;
    Top := 5;
  end;

  SaveFile := TFileNameComboBox.Create(Self, 'SaveFile');
  with SaveFile do begin
    Caption:='Hallo';
    Anchors := [akTop, akLeft, akRight];
    Left := 5;
    Width := Self.Width - 10;
    Top := 65;
  end;

  ModifFile := TFileNameComboBox.Create(Self, 'Modif');
  with ModifFile do begin
    Anchors := [akTop, akLeft, akRight];
    Left := 5;
    Width := Self.Width - 10;
    Top := 126;
  end;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  Caption := LoadFile.Text;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  Close;
end;

end.


