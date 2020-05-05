unit Embedded_GUI_IDE_Options;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, StdCtrls, Dialogs, ComCtrls, EditBtn,
  Spin, ExtCtrls, IDEUtils, LazConfigStorage, BaseIDEIntf, LazIDEIntf,
  ProjectIntf, CompOptsIntf, IDEOptionsIntf, IDEOptEditorIntf,
  Embedded_GUI_Find_Comports,
  Embedded_GUI_Common,
  Embedded_GUI_AVR_Common,
  Embedded_GUI_Serial_Monitor_Interface_Options_Frame,
  Embedded_GUI_Serial_Monitor_Output_Options_Frame;

type

  { TEmbedded_IDE_Options }

  TEmbedded_IDE_Options = class
  public
    AVR: record
      avrdudePath, avrdudeConfigPath: string;
    end;
    ARM: record
      STFlashPath: string;
    end;
    SerialMonitor: TSerialMonitor_Options;
    constructor Create;
  private
    procedure Save_to_XML;
    procedure Load_from_XML;
  end;

var
  Embedded_IDE_Options: TEmbedded_IDE_Options;

type
  (* Frames befindet sich in der Lazarus-IDE unter: "Werkzeuge/Einstellungen.../Umgebung/AVR-Options" *)

  { TEmbedded_IDE_Options_Frame }

  TEmbedded_IDE_Options_Frame = class(TAbstractIDEOptionsEditor)
    Button_AVRDude_Path: TButton;
    Button_AVRDude_Config: TButton;
    ComboBox_STFlashPfad: TComboBox;
    Button_ST_Flash: TButton;
    ComboBox_AVRdude_Path: TComboBox;
    ComboBox_AVRdudeConf: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    OpenDialog: TOpenDialog;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    procedure Button_AVRDude_ConfigClick(Sender: TObject);
    procedure Button_AVRDude_PathClick(Sender: TObject);
    procedure Button_ST_FlashClick(Sender: TObject);
  private
    SM_Interface_Frame: TSM_Interface_Frame;
    SM_Output_Frame: TSM_Output_Frame;
  public
    function GetTitle: string; override;
    procedure Setup({%H-}ADialog: TAbstractOptionsEditorDialog); override;
    procedure ReadSettings({%H-}AOptions: TAbstractIDEOptions); override;
    procedure WriteSettings({%H-}AOptions: TAbstractIDEOptions); override;
    class function SupportedOptionsClass: TAbstractIDEOptionsClass; override;
  end;

implementation

{$R *.lfm}

{ TEmbedded_IDE_Options }

procedure TEmbedded_IDE_Options.Load_from_XML;
var
  Cfg: TConfigStorage;
begin
  Cfg := GetIDEConfigStorage(Embedded_Options_File, True);
  AVR.avrdudePath := Cfg.GetValue(Key_Avrdude_Path, Default_Avrdude_Path);
  AVR.avrdudeConfigPath := Cfg.GetValue(Key_Avrdude_Conf_Path, Default_Avrdude_Conf_Path);
  ARM.STFlashPath := Cfg.GetValue(Key_STFlash_Path, Default_STFlash_Path);

  with SerialMonitor do begin
    with Com_Interface do begin
      Port := Cfg.GetValue(Key_SerialMonitorPort, UARTDefaultPort);
      Baud := Cfg.GetValue(Key_SerialMonitorBaud, UARTDefaultBaud);
      Parity := Cfg.GetValue(Key_SerialMonitorParity, UARTDefaultParity);
      Bits := Cfg.GetValue(Key_SerialMonitorBits, UARTDefaultBits);
      StopBits := Cfg.GetValue(Key_SerialMonitorStopBits, UARTDefaultStopBits);
      FlowControl := Cfg.GetValue(Key_SerialMonitorFlowControl, UARTDefaultFlowControl);

      TimeOut := Cfg.GetValue(Key_SerialMonitorTimeOut, UARTDefaultTimeOut);
      TimerInterval := Cfg.GetValue(Key_SerialMonitorTimer, UARTDefaultTimer);
    end;
    with Output do begin
      LineBreak := Cfg.GetValue(Key_SerialMonitorLineBreak, OutputDefaultLineBreak);
      AutoScroll := Cfg.GetValue(Key_SerialMonitorAutoScroll, OutputDefaultAutoScroll);
      WordWarp := Cfg.GetValue(Key_SerialMonitorWordWarp, OutputDefaultWordWarp);
    end;
  end;
  Cfg.Free;
end;

procedure TEmbedded_IDE_Options.Save_to_XML;
var
  Cfg: TConfigStorage;
begin
  Cfg := GetIDEConfigStorage(Embedded_Options_File, True);
  Cfg.SetValue(Key_Avrdude_Path, AVR.avrdudePath);
  Cfg.SetValue(Key_Avrdude_Conf_Path, AVR.avrdudeConfigPath);
  Cfg.SetValue(Key_STFlash_Path, ARM.STFlashPath);

  with SerialMonitor do begin
    with Com_Interface do begin
      Cfg.SetValue(Key_SerialMonitorPort, Port);
      Cfg.SetValue(Key_SerialMonitorBaud, Baud);
      Cfg.SetValue(Key_SerialMonitorParity, Parity);
      Cfg.SetValue(Key_SerialMonitorBits, Bits);
      Cfg.SetValue(Key_SerialMonitorStopBits, StopBits);
      Cfg.SetValue(Key_SerialMonitorFlowControl, FlowControl);

      Cfg.SetValue(Key_SerialMonitorTimeOut, TimeOut);
      Cfg.SetValue(Key_SerialMonitorTimer, TimerInterval);
    end;
    with Output do begin
      Cfg.SetValue(Key_SerialMonitorLineBreak, LineBreak);
      Cfg.SetValue(Key_SerialMonitorAutoScroll, AutoScroll);
      Cfg.SetValue(Key_SerialMonitorWordWarp, WordWarp);
    end;
  end;
  Cfg.Free;
end;

constructor TEmbedded_IDE_Options.Create;
begin
  inherited Create;
  Load_from_XML;
end;

{ TEmbedded_IDE_Options_Frame }

procedure TEmbedded_IDE_Options_Frame.Button_ST_FlashClick(Sender: TObject);
begin
  OpenDialog.FileName := ComboBox_STFlashPfad.Text;
  if OpenDialog.Execute then begin
    ComboBox_STFlashPfad.Text := OpenDialog.FileName;
  end;
end;

procedure TEmbedded_IDE_Options_Frame.Button_AVRDude_PathClick(Sender: TObject);
begin
  OpenDialog.FileName := ComboBox_AVRdude_Path.Text;
  if OpenDialog.Execute then begin
    ComboBox_AVRdude_Path.Text := OpenDialog.FileName;
  end;
end;

procedure TEmbedded_IDE_Options_Frame.Button_AVRDude_ConfigClick(Sender: TObject);
begin
  OpenDialog.FileName := ComboBox_AVRdudeConf.Text;
  if OpenDialog.Execute then begin
    ComboBox_AVRdudeConf.Text := OpenDialog.FileName;
  end;
end;

function TEmbedded_IDE_Options_Frame.GetTitle: string;
begin
  Result := Title + 'Embedded GUI Optionen';
end;

procedure TEmbedded_IDE_Options_Frame.Setup(ADialog: TAbstractOptionsEditorDialog);
begin
  SM_Interface_Frame := TSM_Interface_Frame.Create(Self);
  SM_Interface_Frame.Parent := Self.TabSheet3;
  SM_Output_Frame := TSM_Output_Frame.Create(Self);
  SM_Output_Frame.Parent := Self.TabSheet4;

  SM_Interface_Frame.ComboBox_Port.Items.CommaText := GetSerialPortNames;
  SM_Interface_Frame.ComboBox_Baud.Items.CommaText := UARTBaudRates;
  SM_Interface_Frame.ComboBox_Parity.Items.CommaText := UARTParitys;
  SM_Interface_Frame.ComboBox_Bits.Items.CommaText := UARTBitss;
  SM_Interface_Frame.ComboBox_StopBits.Items.CommaText := UARTStopBitss;
  SM_Interface_Frame.ComboBox_FlowControl.Items.CommaText := UARTFlowControls;

  SM_Output_Frame.RadioGroup_LineBreak.Items.CommaText := OutputLineBreaks;
end;

procedure TEmbedded_IDE_Options_Frame.ReadSettings(AOptions: TAbstractIDEOptions);
begin
  with Embedded_IDE_Options do begin
    SetComboBoxText(ComboBox_AVRdude_Path, AVR.avrdudePath, cstFilename);
    SetComboBoxText(ComboBox_AVRdudeConf, AVR.avrdudeConfigPath, cstFilename);

    SetComboBoxText(ComboBox_STFlashPfad, ARM.STFlashPath, cstFilename);

    with SerialMonitor do begin
      with Com_Interface do begin
        SM_Interface_Frame.ComboBox_Port.Text := Port;
        SM_Interface_Frame.ComboBox_Baud.Text := Baud;
        SM_Interface_Frame.ComboBox_Parity.Text := Parity;
        SM_Interface_Frame.ComboBox_Bits.Text := Bits;
        SM_Interface_Frame.ComboBox_StopBits.Text := StopBits;
        SM_Interface_Frame.ComboBox_FlowControl.Text := FlowControl;

        SM_Interface_Frame.SpinEdit_TimeOut.Value := TimeOut;
        SM_Interface_Frame.SpinEdit_TimerInterval.Value := TimerInterval;
      end;

      with Output do begin
        SM_Output_Frame.RadioGroup_LineBreak.ItemIndex := LineBreak;
        SM_Output_Frame.CheckBox_AutoScroll.Checked := AutoScroll;
        SM_Output_Frame.CheckBox_WordWarp.Checked := WordWarp;
      end;
    end;
  end;
end;

procedure TEmbedded_IDE_Options_Frame.WriteSettings(AOptions: TAbstractIDEOptions);
begin
  with Embedded_IDE_Options do begin
    AVR.avrdudePath := ComboBox_AVRdude_Path.Text;
    AVR.avrdudeConfigPath := ComboBox_AVRdudeConf.Text;
    ARM.STFlashPath := ComboBox_STFlashPfad.Text;

    with SerialMonitor do begin
      with Com_Interface do begin
        Port := SM_Interface_Frame.ComboBox_Port.Text;
        Baud := SM_Interface_Frame.ComboBox_Baud.Text;
        Parity := SM_Interface_Frame.ComboBox_Parity.Text;
        Bits := SM_Interface_Frame.ComboBox_Bits.Text;
        StopBits := SM_Interface_Frame.ComboBox_StopBits.Text;
        FlowControl := SM_Interface_Frame.ComboBox_FlowControl.Text;

        TimeOut := SM_Interface_Frame.SpinEdit_TimeOut.Value;
        TimerInterval := SM_Interface_Frame.SpinEdit_TimerInterval.Value;
      end;

      with Output do begin
        LineBreak := SM_Output_Frame.RadioGroup_LineBreak.ItemIndex;
        AutoScroll := SM_Output_Frame.CheckBox_AutoScroll.Checked;
        WordWarp := SM_Output_Frame.CheckBox_WordWarp.Checked;
      end;
    end;

    Embedded_IDE_Options.Save_to_XML;
  end;
end;

class function TEmbedded_IDE_Options_Frame.SupportedOptionsClass: TAbstractIDEOptionsClass;
begin
  Result := IDEEditorGroups.GetByIndex(GroupEnvironment)^.GroupClass;
end;

end.






