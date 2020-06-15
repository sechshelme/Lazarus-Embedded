unit Embedded_GUI_AVR_Fuse_Burn_Form;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls,
  Embedded_GUI_Common;

type

  { TForm_AVR_Fuse_Burn }

  TForm_AVR_Fuse_Burn = class(TForm)
    Button_Close: TButton;
    Button_Burn: TButton;
    Memo1: TMemo;
    procedure Button_BurnClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  Form_AVR_Fuse_Burn: TForm_AVR_Fuse_Burn;

implementation

{$R *.lfm}

{ TForm_AVR_Fuse_Burn }

procedure TForm_AVR_Fuse_Burn.FormCreate(Sender: TObject);
begin
  Caption := Title + 'AVR Fuse Burn';
  LoadFormPos_from_XML(self);
  Memo1.Color:=clRed;
  Memo1.Font.Color:=clWhite;
  Memo1.Font.Style:=[fsBold];
  Memo1.Text:='Warnung: Diese Funktion kann den AVR zerstören !!';
end;

procedure TForm_AVR_Fuse_Burn.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  SaveFormPos_to_XML(Self);
end;

procedure TForm_AVR_Fuse_Burn.Button_BurnClick(Sender: TObject);
begin
  if ssCtrl in GetKeyShiftState then begin
    ShowMessage('brennen');
  end;
end;

end.

