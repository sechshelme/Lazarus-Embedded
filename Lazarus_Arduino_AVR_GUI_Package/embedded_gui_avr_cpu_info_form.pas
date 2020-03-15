unit Embedded_GUI_AVR_CPU_Info_Form;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Buttons, StdCtrls,

  // Embedded ( Eigene Units )
  Embedded_GUI_SubArch_List;

type

  { TAVR_CPU_InfoForm }

  TAVR_CPU_InfoForm = class(TForm)
    BitBtn_Ok: TBitBtn;
    Memo1: TMemo;
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  AVR_CPU_InfoForm: TAVR_CPU_InfoForm;

implementation

{$R *.lfm}

{ TAVR_CPU_InfoForm }

procedure TAVR_CPU_InfoForm.FormCreate(Sender: TObject);
var
  x, y: integer;
  s:String;

  //function f(s:String):String;
  //begin
  //  Str(123:20, Result);
  //end;

begin
  for y := 0 to Length(AVRControllerDataList) - 1 do begin
    s:='';
    for x := 0 to Length(AVRControllerDataList[y]) - 1 do begin
      s+=Format('%20s', [AVRControllerDataList[y, x]]);
    end;
    Memo1.Lines.Add(s);
  end;
end;

end.

