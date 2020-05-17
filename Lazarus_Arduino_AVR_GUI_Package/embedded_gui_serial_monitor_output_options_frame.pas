unit Embedded_GUI_Serial_Monitor_Output_Options_Frame;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, ExtCtrls, StdCtrls;

type

  { TSM_Output_Frame }

  TSM_Output_Frame = class(TFrame)
    CheckBox_AutoScroll: TCheckBox;
    CheckBox_WordWarp: TCheckBox;
    ComboBox_maxRows: TComboBox;
    Label1: TLabel;
    RadioGroup_LineBreak: TRadioGroup;
  private

  public

  end;

implementation

{$R *.lfm}

{ TSM_Output_Frame }

end.

