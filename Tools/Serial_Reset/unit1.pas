unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls,
  Serial;

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
  SerialHandle: TSerialHandle;
  com: string;
begin
  SerialHandle := SerOpen('/dev/ttyACM0');
  SerSetParams(SerialHandle, 1200, 8, NoneParity, 1, []);

  SerSetDTR(SerialHandle, True);
  SerSetDTR(SerialHandle, False);
  Sleep(500);
  SerClose(SerialHandle);
  Sleep(500);
end;

end.
