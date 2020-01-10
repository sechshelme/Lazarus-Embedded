unit AVR_Project_Templates_Form;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Buttons;

type

  { TProjectTemplatesForm }

  TProjectTemplatesForm = class(TForm)
    BitBtn_Ok: TBitBtn;
    BitBtn_Cancel: TBitBtn;
    Label1: TLabel;
    ListBox_Template: TListBox;
    procedure FormCreate(Sender: TObject);
    procedure ListBox_TemplateDblClick(Sender: TObject);
  private

  public

  end;

var
  ProjectTemplatesForm: TProjectTemplatesForm;

implementation

{$R *.lfm}

{ TProjectTemplatesForm }

procedure TProjectTemplatesForm.FormCreate(Sender: TObject);
begin
  with ListBox_Template do begin
    Text := 'Arduino UNO';
    Items.Add(Text);
    Items.Add('Arduino Nano (old Bootloader)');
    Items.Add('Arduino Nano');
    Items.Add('ATmega328P');
    Items.Add('ATtiny2313A');
  end;
end;

procedure TProjectTemplatesForm.ListBox_TemplateDblClick(Sender: TObject);
begin
  BitBtn_Ok.Click;
end;

end.
