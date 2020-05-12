unit Embedded_GUI_Common;

interface

(* Bei "Packages-Inspector/Einstellungen/Compilereinstellungen/Benutzerdefinierte Einstellungen/"
   ist "-dPackages" eingetragen. *)

uses
  {$IFDEF Packages}
  BaseIDEIntf, LazConfigStorage,  // Bei Packages
  {$ELSE}
  XMLConf,  // Bei normalen Anwendungen
  {$ENDIF}
  SysUtils, StdCtrls, Controls, Classes, Dialogs, Forms;

const
  UARTBaudRates =
    //    '300,600,1200,2400,9600,14400,19200,38400,57600,76800,115200,230400,250000,500000,1000000,2000000';
    '50,75,110,134,150,200,300,600,1200,1800,2400,4800,9600,19200,38400,57600,115200,230400,460800';

  Title = '[Embedded GUI] ';

  Embedded_Systems = 'AVR,ARM,Mips,Riscv32,XTensa';
  Embedded_Options_File = 'embedded_gui_options.xml';

  Key_IDE_Options='IDEOptions/';
  Key_AVRdude = Key_IDE_Options + 'avrdude/';
  Key_STFlash = Key_IDE_Options + 'st_flash/';

  Key_Avrdude_Path = Key_AVRdude + 'pfad/';
  Key_Avrdude_Conf_Path = Key_AVRdude + 'conf_pfad/';
  Key_STFlash_Path = Key_STFlash + 'pfad/';

  {$IFDEF MSWINDOWS}
  Default_Avrdude_Path :TStringArray = ('c:\avrdude\avrdude.exe');
  Default_Avrdude_Conf_Path :TStringArray = ('c:\avrdude\avrdude.conf');
  Default_STFlash_Path = :TStringArray ('c:\st-link\st-flash.exe');
  UARTDefaultPort = 'COM8';
  {$ELSE}
  Default_Avrdude_Path :TStringArray= ('/usr/bin/avrdude','avrdude');
  Default_Avrdude_Conf_Path:TStringArray = ('/etc/avrdude.conf','');
  Default_STFlash_Path:TStringArray = ('/usr/local/bin/st-flash','st-flash');
  UARTDefaultPort = '/dev/ttyUSB0';
  {$ENDIF}

const
  UARTDefaultBaud = '9600';
  UARTDefaultParity = 'none';
  UARTDefaultBits = '8';
  UARTDefaultStopBits = '1';
  UARTDefaultFlowControl = 'none';
  UARTDefaultTimeOut = 10;
  UARTDefaultTimer = 200;

  OutputDefaultLineBreak = 0; // 0 = #10
  OutputDefaultAutoScroll = True;
  OutputDefaultWordWarp = False;

  UARTParitys = 'none,odd,even';
  UARTBitss = '5,6,7,8';
  UARTStopBitss = '1,2';
  UARTFlowControls = 'none,RTS/CTS';

  OutputLineBreaks: TStringArray = ('LF / #10', 'CR / #13', 'CRLF / #13#10');

{ TSerialMonitor_Options }

type
  TSerialMonitor_Options = class(TObject)
  public
    Com_Interface: record
      Port, Baud, Bits, Parity, StopBits, FlowControl: string;
      TimeOut, TimerInterval: integer;
    end;
    Output: record
      LineBreak: integer;
      AutoScroll, WordWarp: boolean;
    end;
    constructor Create;
    procedure Load_from_XML;
    procedure Save_to_XML;
  end;

  { TEmbedded_IDE_Options }

  TEmbedded_IDE_Options = class
  public
    AVR: record
      avrdudePath, avrdudeConfigPath: TStringList;
    end;
    ARM: record
      STFlashPath: TStringList;
    end;
    SerialMonitor_Options: TSerialMonitor_Options;
    constructor Create;
    destructor Destroy; override;
    procedure Save_to_XML;
    procedure Load_from_XML;
  private
  end;

procedure ComboBox_Insert_Text(cb: TComboBox);

procedure LoadFormPos_from_XML(Form: TControl);
procedure SaveFormPos_to_XML(Form: TControl);

procedure LoadStrings_from_XML(Key: string; sl: TStrings; Default_Text: TStringArray = nil);
procedure SaveStrings_to_XML(Key: string; sl: TStrings);

procedure LoadComboBox_from_XML(cb: TComboBox; Default_Text: TStringArray = nil);
procedure SaveComboBox_to_XML(cb: TComboBox);

implementation

const
  maxComboBoxCount = 20;
  FormPos = '/FormPos/';

{$IFNDEF Packages}
type
  TConfigStorage = class(TXMLConfig)
  end;

function GetIDEConfigStorage(const Filename: string; LoadFromDisk: boolean): TConfigStorage;
begin
  Result := TConfigStorage.Create(nil);
  Result.Filename := FileName;
end;

{$ENDIF}

function getParents(c: TWinControl): string;
var
  p: TWinControl;
begin
  Result := '';
  p := c;
  repeat
    Result := p.Name + '/' + Result;
    p := p.Parent;
  until p = nil;
end;

procedure ComboBox_Insert_Text(cb: TComboBox);
var
  i: integer;
  s: string;
begin
  s := cb.Text;
  i := cb.Items.IndexOf(s);
  if i >= 0 then begin
    cb.Items.Delete(i);
  end;

  cb.Items.Insert(0, s);

  if cb.Items.Count > maxComboBoxCount then begin
    cb.Items.Delete(cb.Items.Count - 1);
  end;

  cb.Text := s;
end;

procedure LoadFormPos_from_XML(Form: TControl);
var
  Cfg: TConfigStorage;
begin
  Cfg := GetIDEConfigStorage(Embedded_Options_File, True);
  Form.Left := Cfg.GetValue(Form.Name + FormPos + 'Left', Form.Left);
  Form.Top := Cfg.GetValue(Form.Name + FormPos + 'Top', Form.Top);
  Form.Width := Cfg.GetValue(Form.Name + FormPos + 'Width', Form.Width);
  Form.Height := Cfg.GetValue(Form.Name + FormPos + 'Height', Form.Height);
  Cfg.Free;
end;

procedure SaveFormPos_to_XML(Form: TControl);
var
  Cfg: TConfigStorage;
begin
  Cfg := GetIDEConfigStorage(Embedded_Options_File, True);
  Cfg.SetValue(Form.Name + FormPos + 'Left', Form.Left);
  Cfg.SetValue(Form.Name + FormPos + 'Top', Form.Top);
  Cfg.SetValue(Form.Name + FormPos + 'Width', Form.Width);
  Cfg.SetValue(Form.Name + FormPos + 'Height', Form.Height);
  Cfg.Free;
end;

procedure LoadStrings_from_XML(Key: string; sl: TStrings; Default_Text: TStringArray);
var
  Cfg: TConfigStorage;
  ct, i: integer;
  s: string;
begin
  Cfg := GetIDEConfigStorage(Embedded_Options_File, True);
  ct := Cfg.GetValue(Key + 'Count', 0);
  sl.Clear;

  for i := 0 to ct - 1 do begin
    s := Cfg.GetValue(Key + 'Item' + i.ToString + '/value', '');
    sl.Add(s);
  end;

  for i := 0 to Length(Default_Text) - 1 do begin
    if sl.Count < maxComboBoxCount then begin
      if sl.IndexOf(Default_Text[i]) < 0 then begin
        sl.Add(Default_Text[i]);
      end;
    end;
  end;

  Cfg.Free;
end;

procedure SaveStrings_to_XML(Key: string; sl: TStrings);
var
  Cfg: TConfigStorage;
  i: integer;
begin
  Cfg := GetIDEConfigStorage(Embedded_Options_File, True);
  Cfg.SetValue(Key + 'Count', sl.Count);
  for i := 0 to sl.Count - 1 do begin
    Cfg.SetValue(Key + 'Item' + i.ToString + '/value', sl[i]);
  end;
  Cfg.Free;
end;

procedure LoadComboBox_from_XML(cb: TComboBox; Default_Text: TStringArray);
var
  Key: string;
begin
  Key := getParents(cb);
  LoadStrings_from_XML(Key, cb.Items, Default_Text);
  if cb.Items.Count > 0 then begin
    cb.Text := cb.Items[0];
  end else begin
    cb.Text := '';
  end;
end;

procedure SaveComboBox_to_XML(cb: TComboBox);
var
  Key: string;
begin
  Key := getParents(cb);
  SaveStrings_to_XML(Key, cb.Items);
end;

var
  Key_SerialMonitorPort, Key_SerialMonitorBaud, Key_SerialMonitorParity, Key_SerialMonitorBits, Key_SerialMonitorStopBits, Key_SerialMonitorFlowControl, Key_SerialMonitorTimeOut, Key_SerialMonitorTimer, Key_SerialMonitorLineBreak, Key_SerialMonitorAutoScroll, Key_SerialMonitorWordWarp: string;

{ TSerialMonitor_Options }

constructor TSerialMonitor_Options.Create;
const
  i = 'COMPortPara/';
  o = 'OutputScreenPara/';
  n = 'Serial_Monitor_Config/';
begin
  inherited Create;

  Key_SerialMonitorPort := n + i + 'Port';
  Key_SerialMonitorBaud := n + i + 'Baud';
  Key_SerialMonitorParity := n + i + 'Parity';
  Key_SerialMonitorBits := n + i + 'Bits';
  Key_SerialMonitorStopBits := n + i + 'StopBits';
  Key_SerialMonitorFlowControl := n + i + 'FlowControl';
  Key_SerialMonitorTimeOut := n + i + 'TimeOut';
  Key_SerialMonitorTimer := n + i + 'TimerInterval';

  Key_SerialMonitorLineBreak := n + o + 'LineBreak';
  Key_SerialMonitorAutoScroll := n + o + 'AutoScroll';
  Key_SerialMonitorWordWarp := n + o + 'Wordwarp';
//  Load_from_XML;
end;

procedure TSerialMonitor_Options.Load_from_XML;
var
  Cfg: TConfigStorage;
begin
  Cfg := GetIDEConfigStorage(Embedded_Options_File, True);
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
  Cfg.Free;
end;

procedure TSerialMonitor_Options.Save_to_XML;
var
  Cfg: TConfigStorage;
begin
  Cfg := GetIDEConfigStorage(Embedded_Options_File, True);
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
  Cfg.Free;
end;

{ TEmbedded_IDE_Options }

constructor TEmbedded_IDE_Options.Create;
begin
  inherited Create;
  SerialMonitor_Options := TSerialMonitor_Options.Create;

  AVR.avrdudePath:=TStringList.Create;
  AVR.avrdudeConfigPath:= TStringList.Create;
  ARM.STFlashPath:= TStringList.Create;

//  Load_from_XML;
end;

destructor TEmbedded_IDE_Options.Destroy;
begin
  AVR.avrdudePath.Free; AVR.avrdudeConfigPath.Free;
  ARM.STFlashPath.Free;
  SerialMonitor_Options.Free;
  inherited Destroy;
end;

procedure TEmbedded_IDE_Options.Load_from_XML;
//var
//  Cfg: TConfigStorage;
begin
//  Cfg := GetIDEConfigStorage(Embedded_Options_File, True);
  LoadStrings_from_XML(Key_Avrdude_Path, AVR.avrdudePath, Default_Avrdude_Path);
  LoadStrings_from_XML(Key_Avrdude_Conf_Path, AVR.avrdudeConfigPath, Default_Avrdude_Conf_Path);
  LoadStrings_from_XML(Key_STFlash_Path, ARM.STFlashPath, Default_STFlash_Path);

//  AVR.avrdudePath := Cfg.GetValue(Key_Avrdude_Path, Default_Avrdude_Path);
//  AVR.avrdudeConfigPath := Cfg.GetValue(Key_Avrdude_Conf_Path, Default_Avrdude_Conf_Path);
//  ARM.STFlashPath := Cfg.GetValue(Key_STFlash_Path, Default_STFlash_Path);

  SerialMonitor_Options.Load_from_XML;
//  Cfg.Free;
end;

procedure TEmbedded_IDE_Options.Save_to_XML;
//var
//  Cfg: TConfigStorage;
begin
  SaveStrings_to_XML(Key_Avrdude_Path, AVR.avrdudePath);
  SaveStrings_to_XML(Key_Avrdude_Conf_Path, AVR.avrdudeConfigPath);
  SaveStrings_to_XML(Key_STFlash_Path, ARM.STFlashPath);
//
//  Cfg := GetIDEConfigStorage(Embedded_Options_File, True);
//  Cfg.SetValue(Key_Avrdude_Path, AVR.avrdudePath);
//  Cfg.SetValue(Key_Avrdude_Conf_Path, AVR.avrdudeConfigPath);
//  Cfg.SetValue(Key_STFlash_Path, ARM.STFlashPath);

  SerialMonitor_Options.Save_to_XML;
//  Cfg.Free;
end;

end.
