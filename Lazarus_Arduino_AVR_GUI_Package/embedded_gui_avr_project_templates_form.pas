unit Embedded_GUI_AVR_Project_Templates_Form;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Buttons;

type

  { TAVRProjectTemplatesForm }

  TAVRProjectTemplatesForm = class(TForm)
    BitBtn_Ok: TBitBtn;
    BitBtn_Cancel: TBitBtn;
    Label1: TLabel;
    ListBox_Template: TListBox;
    procedure ListBox_TemplateDblClick(Sender: TObject);
  private

  public

  end;

var
  AVRProjectTemplatesForm: TAVRProjectTemplatesForm;

implementation

{$R *.lfm}

{ TAVRProjectTemplatesForm }

procedure TAVRProjectTemplatesForm.ListBox_TemplateDblClick(Sender: TObject);
begin
  BitBtn_Ok.Click;
end;

end.
