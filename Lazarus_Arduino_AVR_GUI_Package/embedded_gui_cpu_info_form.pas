unit Embedded_GUI_CPU_Info_Form;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Buttons, StdCtrls,

  BaseIDEIntf, LazConfigStorage,

  // Embedded ( Eigene Units )
  Embedded_GUI_Common,
  Embedded_GUI_SubArch_List;

type

  { TCPU_InfoForm }

  TCPU_InfoForm = class(TForm)
    BitBtn_Ok: TBitBtn;
    Memo1: TMemo;
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private

  public
    procedure Load(var Table: array of TStringArray);
  end;

var
  CPU_InfoForm: TCPU_InfoForm;

implementation

{$R *.lfm}

{ TCPU_InfoForm }

procedure TCPU_InfoForm.FormCreate(Sender: TObject);
var
  Cfg: TConfigStorage;
begin
  Cfg := GetIDEConfigStorage(Embedded_Options_File, True);
  Left := StrToInt(Cfg.GetValue(Key_CPU_Info_Left, '100'));
  Top := StrToInt(Cfg.GetValue(Key_CPU_Info_Top, '50'));
  Width := StrToInt(Cfg.GetValue(Key_CPU_Info_Width, '500'));
  Height := StrToInt(Cfg.GetValue(Key_CPU_Info_Height, '500'));
  Cfg.Free;
end;

procedure TCPU_InfoForm.FormClose(Sender: TObject; var CloseAction: TCloseAction);
var
  Cfg: TConfigStorage;
begin
  Cfg := GetIDEConfigStorage(Embedded_Options_File, True);
  Cfg.SetDeleteValue(Key_CPU_Info_Left, IntToStr(Left), '100');
  Cfg.SetDeleteValue(Key_CPU_Info_Top, IntToStr(Top), '50');
  Cfg.SetDeleteValue(Key_CPU_Info_Width, IntToStr(Width), '500');
  Cfg.SetDeleteValue(Key_CPU_Info_Height, IntToStr(Height), '500');
  Cfg.Free;
end;

procedure TCPU_InfoForm.Load(var Table: array of TStringArray);
var
  x, y: integer;
  s: string;
begin
  for y := 0 to Length(Table) - 1 do begin
    s := '';
    for x := 0 to Length(Table[y]) - 1 do begin
      s += Format('%20s', [Table[y, x]]);
    end;
    Memo1.Lines.Add(s);
  end;
end;

end.

