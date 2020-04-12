unit Input;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, Buttons;

type

  { TInputForm }

  TInputForm = class(TForm)
    SpeedButtonLefr: TSpeedButton;
    SpeedButtonUp: TSpeedButton;
    SpeedButtonDown: TSpeedButton;
    SpeedButtonRight: TSpeedButton;
    procedure SpeedButtonClick(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  InputForm: TInputForm;

implementation

uses
  Unit1;

{$R *.lfm}

{ TInputForm }

procedure TInputForm.SpeedButtonClick(Sender: TObject);
var
  t: byte;
begin
  if TSpeedButton(Sender).Tag = 0 then begin
    t := 30;
  end;  // Up
  if TSpeedButton(Sender).Tag = 1 then begin
    t := 17;
  end;  // Left
  if TSpeedButton(Sender).Tag = 2 then begin
    t := 16;
  end;  // Right
  if TSpeedButton(Sender).Tag = 3 then begin
    t := 31;
  end;  // Down


  Form1.ser.SendByte(t);
end;

end.
