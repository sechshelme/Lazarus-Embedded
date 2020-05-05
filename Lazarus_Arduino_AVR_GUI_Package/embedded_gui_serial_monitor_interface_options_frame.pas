unit Embedded_GUI_Serial_Monitor_Interface_Options_Frame;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, StdCtrls, Spin;

type

  { TSM_Interface_Frame }

  TSM_Interface_Frame = class(TFrame)
    ComboBox_Baud: TComboBox;
    ComboBox_Bits: TComboBox;
    ComboBox_FlowControl: TComboBox;
    ComboBox_Parity: TComboBox;
    ComboBox_Port: TComboBox;
    ComboBox_StopBits: TComboBox;
    Label10: TLabel;
    Label11: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    SpinEdit_TimeOut: TSpinEdit;
    SpinEdit_TimerInterval: TSpinEdit;
  private

  public

  end;

implementation

{$R *.lfm}

{ TSM_Interface_Frame }

end.

