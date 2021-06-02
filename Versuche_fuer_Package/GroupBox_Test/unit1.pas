unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls;

type
  TNewGroupBox = class(TGroupBox)
  private
    CheckBox: TCheckBox;
    constructor Create(AOwner: TComponent); override;
    procedure Resize; override;
  end;

  TForm1 = class(TForm)
    procedure FormCreate(Sender: TObject);
  private
    NewGroupBox: TNewGroupBox;
  public
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

constructor TNewGroupBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  CheckBox := TCheckBox.Create(Self);
  CheckBox.Parent := Self;
end;

procedure TNewGroupBox.Resize;
begin
  inherited Resize;
  CheckBox.Left := 10;   // Hier Knallt es
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  NewGroupBox := TNewGroupBox.Create(Self);
  NewGroupBox.Parent := Self;
end;

end.
