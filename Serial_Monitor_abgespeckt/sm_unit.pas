unit sm_unit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls, Menus,
  Serial,
  LazFileUtils;

type

  { TSerial_Monitor_Form }

  TSerial_Monitor_Form = class(TForm)
    Button1: TButton;
    Button_Send: TButton;
    Edit_Send: TEdit;
    Memo1: TMemo;
    Timer1: TTimer;
    procedure Button1Click(Sender: TObject);
    procedure Button_SendClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);

  public
    SerialHandle: TSerialHandle;
  end;

var
  Serial_Monitor_Form: TSerial_Monitor_Form;

implementation

{$R *.lfm}

{ TSerial_Monitor_Form }

procedure TSerial_Monitor_Form.FormCreate(Sender: TObject);
begin
  Memo1.ScrollBars := ssAutoBoth;
  Memo1.WordWrap := False;
  Memo1.ParentFont := False;

  Timer1.Interval := 200;

  SerialHandle := SerOpen('/dev/ttyUSB0');
  SerSetParams(SerialHandle, 1200, 8, NoneParity, 1, []);
  Timer1.Enabled := True;
end;

procedure TSerial_Monitor_Form.Button_SendClick(Sender: TObject);
begin
  if Length(Edit_Send.Text) > 0 then begin
    SerWrite(SerialHandle, Edit_Send.Text[1], Length(Edit_Send.Text));
  end;
end;

procedure TSerial_Monitor_Form.Button1Click(Sender: TObject);
begin
  Close;
end;

procedure TSerial_Monitor_Form.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  Timer1.Enabled := False;
  SerSync(SerialHandle);
  SerFlushOutput(SerialHandle);
  SerClose(SerialHandle);
end;

procedure TSerial_Monitor_Form.Timer1Timer(Sender: TObject);
var
  i: integer;
  buf: array[0..4096] of byte;
  Count: integer;
begin

//  while Timer1.Enabled do begin
    Count := SerReadTimeout(SerialHandle, buf, Length(buf), 10);
    for i := 0 to Count - 1 do begin
      Memo1.Text := Memo1.Text + char(buf[i]);
    end;

    Memo1.SelStart := -2;
    Application.ProcessMessages;
//  end;
end;

end.
