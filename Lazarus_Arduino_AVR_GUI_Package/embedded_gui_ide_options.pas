unit Embedded_GUI_IDE_Options;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, StdCtrls, Dialogs, ComCtrls,
  IDEUtils, LazConfigStorage, BaseIDEIntf, LazIDEIntf, ProjectIntf, CompOptsIntf, IDEOptionsIntf, IDEOptEditorIntf,
  Embedded_GUI_Find_Comports,
  Embedded_GUI_Common,
  Embedded_GUI_AVR_Common;

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
      Port,
      Baud,
      Bits,
      Parity,
      StopBits,
      FlowControl: string;
    end;
    procedure Save;
    procedure Load;
  end;

var
  Embedded_IDE_Options: TEmbedded_IDE_Options;

type
  (* Frames befindet sich in der Lazarus-IDE unter: "Werkzeuge/Einstellungen.../Umgebung/AVR-Options" *)

  { TEmbedded_IDE_Options_Frame }

  TEmbedded_IDE_Options_Frame = class(TAbstractIDEOptionsEditor)
    ComboBox_Baud: TComboBox;
    ComboBoxAVRdude: TComboBox;
    ComboBoxAVRdudeConf: TComboBox;
    ComboBoxSTFlashPfad: TComboBox;
    ComboBox_Bits: TComboBox;
    ComboBox_FlowControl: TComboBox;
    ComboBox_Parity: TComboBox;
    ComboBox_StopBits: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    PageControl1: TPageControl;
    ComboBox_Port: TComboBox;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
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

procedure TEmbedded_IDE_Options.Load;
var
  Cfg: TConfigStorage;
begin
  Cfg := GetIDEConfigStorage(Embedded_Options_File, True);
  AVR.avrdudePath := Cfg.GetValue(Key_Avrdude_Path, Default_Avrdude_Path);
  AVR.avrdudeConfigPath := Cfg.GetValue(Key_Avrdude_Conf_Path, Default_Avrdude_Conf_Path);
  ARM.STFlashPath := Cfg.GetValue(Key_STFlash_Path, Default_STFlash_Path);

  SerialMonitor.Port := Cfg.GetValue(Key_SerialMonitorPort, UARTDefaultPort);
  SerialMonitor.Baud := Cfg.GetValue(Key_SerialMonitorBaud, UARTDefaultBaud);
  SerialMonitor.Parity := Cfg.GetValue(Key_SerialMonitorParity, UARTDefaultParity);
  SerialMonitor.Bits := Cfg.GetValue(Key_SerialMonitorBits, UARTDefaultBits);
  SerialMonitor.StopBits := Cfg.GetValue(Key_SerialMonitorStopBits, UARTDefaultStopBits);
  SerialMonitor.FlowControl := Cfg.GetValue(Key_SerialMonitorFlowControl, UARTDefaultFlowControl);
  Cfg.Free;
end;

procedure TEmbedded_IDE_Options.Save;
var
  Cfg: TConfigStorage;
begin
  Cfg := GetIDEConfigStorage(Embedded_Options_File, True);
  Cfg.SetValue(Key_Avrdude_Path, AVR.avrdudePath);
  Cfg.SetValue(Key_Avrdude_Conf_Path, AVR.avrdudeConfigPath);
  Cfg.SetValue(Key_STFlash_Path, ARM.STFlashPath);

  Cfg.SetValue(Key_SerialMonitorPort, SerialMonitor.Port);
  Cfg.SetValue(Key_SerialMonitorBaud, SerialMonitor.Baud);
  Cfg.SetValue(Key_SerialMonitorParity, SerialMonitor.Parity);
  Cfg.SetValue(Key_SerialMonitorBits, SerialMonitor.Bits);
  Cfg.SetValue(Key_SerialMonitorStopBits, SerialMonitor.StopBits);
  Cfg.SetValue(Key_SerialMonitorFlowControl, SerialMonitor.FlowControl);
  Cfg.Free;
end;

{ TEmbedded_IDE_Options_Frame }

function TEmbedded_IDE_Options_Frame.GetTitle: string;
begin
  Result := Title + 'Embedded GUI Optionen';
end;

procedure TEmbedded_IDE_Options_Frame.Setup(ADialog: TAbstractOptionsEditorDialog);
begin
  ComboBoxAVRdude.Text := Default_Avrdude_Path;
  ComboBoxAVRdudeConf.Text := Default_Avrdude_Conf_Path;

  ComboBoxSTFlashPfad.Text := Default_STFlash_Path;

  ComboBox_Port.Items.CommaText := GetSerialPortNames;
  ComboBox_Port.Text := UARTDefaultPort;

  ComboBox_Baud.Items.CommaText := UARTBaudRates;
  ComboBox_Baud.Text := UARTDefaultBaud;

  ComboBox_Parity.Items.CommaText:=UARTParitys;
  ComboBox_Parity.Text:=UARTDefaultParity;

  ComboBox_Bits.Items.CommaText:=UARTBitss;
  ComboBox_Bits.Text:=UARTDefaultBits;

  ComboBox_StopBits.Items.CommaText:=UARTStopBitss;
  ComboBox_StopBits.Text:=UARTDefaultStopBits;

  ComboBox_FlowControl.Items.CommaText:=UARTFlowControls;
  ComboBox_FlowControl.Text:=UARTDefaultFlowControl;

  //  PageControl1.ActivePageIndex:=0;
end;

procedure TEmbedded_IDE_Options_Frame.ReadSettings(AOptions: TAbstractIDEOptions);
begin
  SetComboBoxText(ComboBoxAVRdude, Embedded_IDE_Options.AVR.avrdudePath, cstFilename);
  SetComboBoxText(ComboBoxAVRdudeConf, Embedded_IDE_Options.AVR.avrdudeConfigPath, cstFilename);

  SetComboBoxText(ComboBoxSTFlashPfad, Embedded_IDE_Options.ARM.STFlashPath, cstFilename);

  ComboBox_Port.Text := Embedded_IDE_Options.SerialMonitor.Port;
  ComboBox_Baud.Text := Embedded_IDE_Options.SerialMonitor.Baud;
  ComboBox_Parity.Text := Embedded_IDE_Options.SerialMonitor.Parity;
  ComboBox_Bits.Text := Embedded_IDE_Options.SerialMonitor.Bits;
  ComboBox_StopBits.Text := Embedded_IDE_Options.SerialMonitor.StopBits;
  ComboBox_FlowControl.Text := Embedded_IDE_Options.SerialMonitor.FlowControl;
end;

procedure TEmbedded_IDE_Options_Frame.WriteSettings(AOptions: TAbstractIDEOptions);
begin
  Embedded_IDE_Options.AVR.avrdudePath := ComboBoxAVRdude.Text;
  Embedded_IDE_Options.AVR.avrdudeConfigPath := ComboBoxAVRdudeConf.Text;
  Embedded_IDE_Options.ARM.STFlashPath := ComboBoxSTFlashPfad.Text;

  Embedded_IDE_Options.SerialMonitor.Port := ComboBox_Port.Text;
  Embedded_IDE_Options.SerialMonitor.Baud := ComboBox_Baud.Text;
  Embedded_IDE_Options.SerialMonitor.Parity := ComboBox_Parity.Text;
  Embedded_IDE_Options.SerialMonitor.Bits := ComboBox_Bits.Text;
  Embedded_IDE_Options.SerialMonitor.StopBits := ComboBox_StopBits.Text;
  Embedded_IDE_Options.SerialMonitor.FlowControl := ComboBox_FlowControl.Text;

  Embedded_IDE_Options.Save;
end;

class function TEmbedded_IDE_Options_Frame.SupportedOptionsClass: TAbstractIDEOptionsClass;
begin
  Result := IDEEditorGroups.GetByIndex(GroupEnvironment)^.GroupClass;
end;

end.





