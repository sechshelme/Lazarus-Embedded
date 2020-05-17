unit Embedded_GUI_Serial_Monitor_Options_Form;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ComCtrls, Buttons,
  {$IFDEF Packages}
  BaseIDEIntf, LazConfigStorage,  // Bei Packages
  {$ELSE}
  XMLConf,  // Bei normalen Anwendungen
  {$ENDIF}
  Embedded_GUI_Common,
  Embedded_GUI_Find_Comports,
  Embedded_GUI_Serial_Monitor_Interface_Options_Frame,
  Embedded_GUI_Serial_Monitor_Output_Options_Frame;

type

  { TSerialMonitor_Options_Form }

  TSerialMonitor_Options_Form = class(TForm)
    Btn_Close: TBitBtn;
    Btn_Apply: TBitBtn;
    Btn_Ok: TBitBtn;
    PageControl_SM_Options: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    procedure Btn_ApplyClick(Sender: TObject);
    procedure Btn_OkClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    SM_Interface_Frame: TSM_Interface_Frame;
    SM_Output_Frame: TSM_Output_Frame;
  public
  end;

var
  SerialMonitor_Options_Form: TSerialMonitor_Options_Form;

implementation

{$R *.lfm}

uses
  Embedded_GUI_Serial_Monitor_Form;

{ TSerialMonitor_Options_Form }

procedure TSerialMonitor_Options_Form.FormCreate(Sender: TObject);
begin
  Caption := Title + 'Serial-Monitor Optionen';
  LoadFormPos_from_XML(Self);
  LoadPageControl_from_XML(PageControl_SM_Options);

  SM_Interface_Frame := TSM_Interface_Frame.Create(Self);
  SM_Interface_Frame.Parent := Self.TabSheet1;
  SM_Output_Frame := TSM_Output_Frame.Create(Self);
  SM_Output_Frame.Parent := Self.TabSheet2;

  SM_Interface_Frame.ComboBox_Port.Items.CommaText := GetSerialPortNames;
  SM_Interface_Frame.ComboBox_Baud.Items.CommaText := UARTBaudRates;
  SM_Interface_Frame.ComboBox_Parity.Items.CommaText := UARTParitys;
  SM_Interface_Frame.ComboBox_Bits.Items.CommaText := UARTBitss;
  SM_Interface_Frame.ComboBox_StopBits.Items.CommaText := UARTStopBitss;
  SM_Interface_Frame.ComboBox_FlowControl.Items.CommaText := UARTFlowControls;

  SM_Output_Frame.RadioGroup_LineBreak.Items.AddStrings(OutputLineBreaks, True);
  SM_Output_Frame.ComboBox_maxRows.Items.CommaText:=OutputDefaultmaxRows;
end;

procedure TSerialMonitor_Options_Form.FormHide(Sender: TObject);
begin
  SaveFormPos_to_XML(Self);
  SavePageControl_to_XML(PageControl_SM_Options);
end;

procedure TSerialMonitor_Options_Form.Btn_OkClick(Sender: TObject);
begin
  Btn_ApplyClick(Sender);
  Close;
end;

procedure TSerialMonitor_Options_Form.Btn_ApplyClick(Sender: TObject);
begin
  with Serial_Monitor_Form.SerialMonitor_Options do begin
    with Com_Interface do begin
      Port := SM_Interface_Frame.ComboBox_Port.Text;
      Baud := SM_Interface_Frame.ComboBox_Baud.Text;
      Bits := SM_Interface_Frame.ComboBox_Bits.Text;
      Parity := SM_Interface_Frame.ComboBox_Parity.Text;
      StopBits := SM_Interface_Frame.ComboBox_StopBits.Text;
      FlowControl := SM_Interface_Frame.ComboBox_FlowControl.Text;
      TimeOut := SM_Interface_Frame.SpinEdit_TimeOut.Value;
      TimerInterval := SM_Interface_Frame.SpinEdit_TimerInterval.Value;
    end;

    with Output do begin
      LineBreak := SM_Output_Frame.RadioGroup_LineBreak.ItemIndex;
      AutoScroll := SM_Output_Frame.CheckBox_AutoScroll.Checked;
      WordWarp := SM_Output_Frame.CheckBox_WordWarp.Checked;
      maxRows:=StrToInt(SM_Output_Frame.ComboBox_maxRows.Text);
    end;
    {$IFNDEF Packages}
    Save_to_XML;
    {$ENDIF}
  end;

  Serial_Monitor_Form.CloseSerial;
  Serial_Monitor_Form.OpenSerial;
end;

procedure TSerialMonitor_Options_Form.FormShow(Sender: TObject);
begin
  with Serial_Monitor_Form.SerialMonitor_Options do begin
    with Com_Interface do begin
      SM_Interface_Frame.ComboBox_Port.Text := Port;
      SM_Interface_Frame.ComboBox_Baud.Text := Baud;
      SM_Interface_Frame.ComboBox_Bits.Text := Bits;
      SM_Interface_Frame.ComboBox_Parity.Text := Parity;
      SM_Interface_Frame.ComboBox_StopBits.Text := StopBits;
      SM_Interface_Frame.ComboBox_FlowControl.Text := FlowControl;
      SM_Interface_Frame.SpinEdit_TimeOut.Value := TimeOut;
      SM_Interface_Frame.SpinEdit_TimerInterval.Value := TimerInterval;
    end;

    with Output do begin
      SM_Output_Frame.RadioGroup_LineBreak.ItemIndex := LineBreak;
      SM_Output_Frame.CheckBox_AutoScroll.Checked := AutoScroll;
      SM_Output_Frame.CheckBox_WordWarp.Checked := WordWarp;
      SM_Output_Frame.ComboBox_maxRows.Text:=IntToStr(maxRows);
    end;
  end;
end;

end.
