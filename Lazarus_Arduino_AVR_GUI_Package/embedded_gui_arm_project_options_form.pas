unit Embedded_GUI_ARM_Project_Options_Form;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    AsmFile_CheckBox: TCheckBox;
    avrdudePathComboBox: TComboBox;
    AVR_Typ_FPC_ComboBox: TComboBox;
    Button1: TButton;
    CancelButton: TButton;
    ComboBox1: TComboBox;
    Label1: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Memo1: TMemo;
    OkButton: TButton;
    TemplatesButton: TButton;
    procedure ComboBox1Change(Sender: TObject);
    procedure TemplatesButtonClick(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.ComboBox1Change(Sender: TObject);
begin

end;

procedure TForm1.TemplatesButtonClick(Sender: TObject);
begin

end;

end.

