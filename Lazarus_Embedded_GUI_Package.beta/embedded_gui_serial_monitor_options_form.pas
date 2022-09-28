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
  Embedded_GUI_Frame_Serial_Monitor_Interface_Options,
  Embedded_GUI_Frame_Serial_Monitor_Output_Options;

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
    Frame_SerialMonitor_Interface: TFrame_SerialMonitor_Interface;
    Frame_SerialMonitor_SM_Output: TFrame_SerialMonitor_Output;
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

  Frame_SerialMonitor_Interface := TFrame_SerialMonitor_Interface.Create(Self);
  Frame_SerialMonitor_Interface.Parent := Self.TabSheet1;
  Frame_SerialMonitor_SM_Output := TFrame_SerialMonitor_Output.Create(Self);
  Frame_SerialMonitor_SM_Output.Parent := Self.TabSheet2;
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
      Port := Frame_SerialMonitor_Interface.ComboBox_Port.Text;
      Baud := Frame_SerialMonitor_Interface.ComboBox_Baud.Text;
      Bits := Frame_SerialMonitor_Interface.ComboBox_Bits.Text;
      Parity := Frame_SerialMonitor_Interface.ComboBox_Parity.Text;
      StopBits := Frame_SerialMonitor_Interface.ComboBox_StopBits.Text;
      FlowControl := Frame_SerialMonitor_Interface.ComboBox_FlowControl.Text;
      TimeOut := Frame_SerialMonitor_Interface.SpinEdit_TimeOut.Value;
      TimerInterval := Frame_SerialMonitor_Interface.SpinEdit_TimerInterval.Value;
    end;

    with Output do begin
      LineBreak := Frame_SerialMonitor_SM_Output.RadioGroup_LineBreak.ItemIndex;
      AutoScroll := Frame_SerialMonitor_SM_Output.CheckBox_AutoScroll.Checked;
      WordWarp := Frame_SerialMonitor_SM_Output.CheckBox_WordWarp.Checked;
      maxRows := StrToInt(Frame_SerialMonitor_SM_Output.ComboBox_maxRows.Text);
      BKColor:=Frame_SerialMonitor_SM_Output.Label_Color.Color;
      Font.Assign(Frame_SerialMonitor_SM_Output.Label_Color.Font);

      Serial_Monitor_Form.SynEdit1.Font.Assign(Font);
      Serial_Monitor_Form.SynEdit1.Color := BKColor;
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
      Frame_SerialMonitor_Interface.ComboBox_Port.Text := Port;
      Frame_SerialMonitor_Interface.ComboBox_Baud.Text := Baud;
      Frame_SerialMonitor_Interface.ComboBox_Bits.Text := Bits;
      Frame_SerialMonitor_Interface.ComboBox_Parity.Text := Parity;
      Frame_SerialMonitor_Interface.ComboBox_StopBits.Text := StopBits;
      Frame_SerialMonitor_Interface.ComboBox_FlowControl.Text := FlowControl;
      Frame_SerialMonitor_Interface.SpinEdit_TimeOut.Value := TimeOut;
      Frame_SerialMonitor_Interface.SpinEdit_TimerInterval.Value := TimerInterval;
    end;

    with Output do begin
      Frame_SerialMonitor_SM_Output.RadioGroup_LineBreak.ItemIndex := LineBreak;
      Frame_SerialMonitor_SM_Output.CheckBox_AutoScroll.Checked := AutoScroll;
      Frame_SerialMonitor_SM_Output.CheckBox_WordWarp.Checked := WordWarp;
      Frame_SerialMonitor_SM_Output.ComboBox_maxRows.Text := IntToStr(maxRows);

      Frame_SerialMonitor_SM_Output.Label_Color.Color:=BKColor;
      Frame_SerialMonitor_SM_Output.Label_Color.Font.Assign(Font);
    end;
  end;
end;

end.
