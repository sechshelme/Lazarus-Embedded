unit Embedded_GUI_Help_Form;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, SynEdit,
  Embedded_GUI_Help_Const,
  Embedded_GUI_Common;

type

  { THelpForm }

  THelpForm = class(TForm)
    Button_Close: TButton;
    Memo1: TMemo;
    procedure Button_CloseClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private

  public
    procedure ShowText(s: string);
  end;

var
  HelpForm: THelpForm;

implementation

{$R *.lfm}

{ THelpForm }

procedure THelpForm.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  SaveFormPos_to_XML(Self);
end;

procedure THelpForm.Button_CloseClick(Sender: TObject);
begin
  Close;
end;

procedure THelpForm.FormCreate(Sender: TObject);
begin
  Caption := Title + 'Help';
  LoadFormPos_from_XML(Self);
end;

procedure THelpForm.ShowText(s: string);
begin
  Memo1.Text := HelpText;
  Memo1.SelStart:=2;
end;

end.

