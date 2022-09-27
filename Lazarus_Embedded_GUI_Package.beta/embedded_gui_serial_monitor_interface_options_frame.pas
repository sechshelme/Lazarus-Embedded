unit Embedded_GUI_Serial_Monitor_Interface_Options_Frame;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, StdCtrls, Spin, Dialogs,

  Embedded_GUI_Common,
  Embedded_GUI_Find_Comports;

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
    constructor Create(TheOwner: TComponent); override;
  end;

implementation

{$R *.lfm}

{ TSM_Interface_Frame }

constructor TSM_Interface_Frame.Create(TheOwner: TComponent);
begin
  inherited Create(TheOwner);

  with ComboBox_Port do begin
    Items.CommaText := GetSerialPortNames;
//    Style := csOwnerDrawFixed;
  end;

  with ComboBox_Baud do begin
    Items.CommaText := UARTBaudRates;
    Style := csOwnerDrawFixed;
  end;

  with ComboBox_Parity do begin
    Items.CommaText := UARTParitys;
    Style := csOwnerDrawFixed;
  end;

  with ComboBox_Bits do begin
    Items.CommaText := UARTBitss;
    Style := csOwnerDrawFixed;
  end;

  with ComboBox_StopBits do begin
    Items.CommaText := UARTStopBitss;
    Style := csOwnerDrawFixed;
  end;

  with ComboBox_FlowControl do begin
    Items.CommaText := UARTFlowControls;
    Style := csOwnerDrawFixed;
  end;
end;

end.

