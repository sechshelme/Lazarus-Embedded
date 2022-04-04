unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls,
  Laz2_XMLCfg;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Memo1: TMemo;
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
  xml: TXMLConfig;
  i:Integer;
  s:String;
begin
  xml := TXMLConfig.Create(nil);
  xml.Filename:='ATmega328.xml';
  s:=xml.GetValue('/variants/variant/ordercode[1]', 'abc');
  Memo1.Lines.Add(s);


  xml.Free;
end;

end.
