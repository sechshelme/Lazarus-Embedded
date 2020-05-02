unit Embedded_GUI_IDE_Options;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, StdCtrls, Dialogs, ComCtrls, EditBtn,
  Spin, IDEUtils, LazConfigStorage, BaseIDEIntf, LazIDEIntf, ProjectIntf,
  CompOptsIntf, IDEOptionsIntf, IDEOptEditorIntf, Embedded_GUI_Find_Comports,
  Embedded_GUI_Common, Embedded_GUI_AVR_Common;

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
    SerialMonitor: record
      Com_Interface: record
        Port, Baud, Bits, Parity, StopBits, FlowControl: string;
        TimeOut, TimerInterval: integer;
      end;
      Output: record
        AutoScroll, WordWarp: boolean;
      end;
    end;
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
    CheckBox_WordWarp: TCheckBox;
    CheckBox_AutoScroll: TCheckBox;
    ComboBox_Baud: TComboBox;
    ComboBox_Bits: TComboBox;
    ComboBox_FlowControl: TComboBox;
    ComboBox_Parity: TComboBox;
    ComboBox_Port: TComboBox;
    ComboBox_STFlashPfad: TComboBox;
    Button_ST_Flash: TButton;
    ComboBox_AVRdude_Path: TComboBox;
    ComboBox_AVRdudeConf: TComboBox;
    ComboBox_StopBits: TComboBox;
    GroupBox_Interface: TGroupBox;
    GroupBox_Output: TGroupBox;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    OpenDialog: TOpenDialog;
    PageControl1: TPageControl;
    SpinEdit_TimeOut: TSpinEdit;
    SpinEdit_TimerInterval: TSpinEdit;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    procedure Button_AVRDude_ConfigClick(Sender: TObject);
    procedure Button_AVRDude_PathClick(Sender: TObject);
    procedure Button_ST_FlashClick(Sender: TObject);
  private

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
      AutoScroll := Cfg.GetValue(Key_SerialMonitorAutoScroll, True);
      WordWarp := Cfg.GetValue(Key_SerialMonitorWordWarp, False);
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
  ComboBox_Port.Items.CommaText := GetSerialPortNames;
  ComboBox_Baud.Items.CommaText := UARTBaudRates;
  ComboBox_Parity.Items.CommaText := UARTParitys;
  ComboBox_Bits.Items.CommaText := UARTBitss;
  ComboBox_StopBits.Items.CommaText := UARTStopBitss;
  ComboBox_FlowControl.Items.CommaText := UARTFlowControls;
end;

procedure TEmbedded_IDE_Options_Frame.ReadSettings(AOptions: TAbstractIDEOptions);
begin
  with Embedded_IDE_Options do begin
    SetComboBoxText(ComboBox_AVRdude_Path, AVR.avrdudePath, cstFilename);
    SetComboBoxText(ComboBox_AVRdudeConf, AVR.avrdudeConfigPath, cstFilename);

    SetComboBoxText(ComboBox_STFlashPfad, ARM.STFlashPath, cstFilename);

    with SerialMonitor do begin
      with Com_Interface do begin
        ComboBox_Port.Text := Port;
        ComboBox_Baud.Text := Baud;
        ComboBox_Parity.Text := Parity;
        ComboBox_Bits.Text := Bits;
        ComboBox_StopBits.Text := StopBits;
        ComboBox_FlowControl.Text := FlowControl;

        SpinEdit_TimeOut.Value := TimeOut;
        SpinEdit_TimerInterval.Value := TimerInterval;
      end;

      with Output do begin
        CheckBox_AutoScroll.Checked := AutoScroll;
        CheckBox_WordWarp.Checked := WordWarp;
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
        Port := ComboBox_Port.Text;
        Baud := ComboBox_Baud.Text;
        Parity := ComboBox_Parity.Text;
        Bits := ComboBox_Bits.Text;
        StopBits := ComboBox_StopBits.Text;
        FlowControl := ComboBox_FlowControl.Text;

        TimeOut := SpinEdit_TimeOut.Value;
        TimerInterval := SpinEdit_TimerInterval.Value;
      end;

      with Output do begin
        AutoScroll := CheckBox_AutoScroll.Checked;
        WordWarp := CheckBox_WordWarp.Checked;
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





