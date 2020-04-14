unit Baud;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TBaudForm }

  TBaudForm = class(TForm)
    Button1: TButton;
    ComboBox1: TComboBox;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  BaudForm: TBaudForm;

implementation

{$R *.lfm}

{ TBaudForm }

procedure TBaudForm.FormCreate(Sender: TObject);
begin
  with ComboBox1 do begin
    Items.Delimiter := ' ';
    Items.DelimitedText := '300 600 1200 2400 9600 14400 19200 38400 57600 76800 115200 230400 250000 500000 1000000 2000000';
    Text := '9600';
  end;
end;

procedure TBaudForm.Button1Click(Sender: TObject);
begin
  Close;
end;

end.

