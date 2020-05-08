unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Panel1: TPanel;
    Panel2: TPanel;
    ScrollBox1: TScrollBox;
    procedure Button1Click(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

function getParent(c: TWinControl): string;
var
  p: TWinControl;
begin
  Result := '';
  p := c;
  repeat
    Result := p.Name + '/' + Result;
    p := p.Parent;
  until p = nil;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  s: string = '';
  p: TWinControl;
begin
  Caption := getParent(Button1);
end;

end.

