unit Embedded_GUI_Common;

interface

(* Bei "Packages-Inspector/Einstellungen/Compilereinstellungen/Benutzerdefinierte Einstellungen/"
   ist "-dPackages" eingetragen. *)

uses
  {$IFDEF Packages}
  BaseIDEIntf, LazConfigStorage,  // Bei Packages
  PackageLinkIntf,
  {$ELSE}
  Laz2_XMLCfg,  // Bei normalen Anwendungen
  {$ENDIF}
  SysUtils, StdCtrls, Controls, Classes, Dialogs, ComCtrls, Graphics, Forms;

const
  UARTBaudRates =
    '50,75,110,134,150,200,300,600,1200,1800,2400,4800,9600,19200,38400,57600,115200,230400,460800';

  Title = '[Embedded] ';
  Options_Title = Title + 'Optionen (Arduino, STM32, etc.)';

  {$IFDEF Packages}
  Embedded_Options_File = 'embedded_gui_options.xml';
  {$ELSE}
  Embedded_Options_File = 'config.xml';
  {$ENDIF}

  {$IFDEF MSWINDOWS}
  Default_Avrdude_Path: TStringArray = ('c:\avrdude\avrdude.exe', 'c:Programme\avrdude\avrdude.exe');
  Default_Avrdude_Conf_Path: TStringArray = ('c:\avrdude\avrdude.conf');
  Default_STFlash_Path: TStringArray = ('c:\st-link\st-flash.exe');
  Default_Bassac_Path: TStringArray = ('c:\bossa\bossac.exe');
  Default_Raspi_Pico_Unit_Path: TStringArray = ('ARM_Units\Rasberry_Pico\units', '');
  Default_Raspi_Pico_cp_Path: TStringArray = ('c:\windows\system32\xcopy', 'c:\windows\system32\xcopy32', 'c:\windows\command\xcopy');
  Default_Raspi_Pico_mount_Path: TStringArray = ('D:', 'E:', 'F:', 'G:');
  Default_EPS_Path: TStringArray = ('..\Xtensa\ESP8266\UP_Loader\upload.py');
  Default_ESP_Bootloader_Path: TStringArray = ('Tools\ESP');
  Default_Template_Path: TStringArray = ('Templates');
  UARTDefaultPort = 'COM8';
  {$ELSE}
  Default_Avrdude_Path: TStringArray = ('/bin/avrdude', '/usr/bin/avrdude', '/usr/local/bin/avrdude');
  Default_Avrdude_Conf_Path: TStringArray = ('/etc/avrdude.conf', '');
  Default_STFlash_Path: TStringArray = ('/bin/st-flash', '/usr/bin/st-flash', '/usr/local/bin/st-flash');
  Default_Bassac_Path: TStringArray = ('/bin/bossac', '/usr/bin/bossac', '/usr/local/bin/bossac');
  Default_Raspi_Pico_Unit_Path: TStringArray = ('ARM_Units/Rasberry_Pico/units', '');
  Default_Raspi_Pico_cp_Path: TStringArray = ('/bin/cp', '/usr/bin/cp', 'cp');
  Default_Raspi_Pico_mount_Path: TStringArray = ('/media/tux/RPI-RP2');
  Default_EPS_Tool_Path: TStringArray = ('/bin/esptool', '/usr/bin/esptool', 'usr/local/bin/esptool');
  Default_ESP_Bootloader_Path: TStringArray = ('Tools/ESP');
  Default_CustomPrg_Tool_Path: TStringArray = ('/bin/xxx', '/usr/bin/xxx', 'usr/local/bin/xxx');
  Default_CustomPrg_Tool_Command: TStringArray = ('-x');
  Default_Template_Path: TStringArray = ('Templates');
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
  OutputDefaultmaxRow = 5000;
  OutputDefaultmaxRows =
    '0,10,20,50,100,200,500,1000,2000,5000,10000,20000,50000,100000,200000,500000';

  UARTParitys = 'none,odd,even';
  UARTBitss = '5,6,7,8';
  UARTStopBitss = '1,2';
  UARTFlowControls = 'none,RTS/CTS';

  OutputLineBreaks: TStringArray = ('LF / #10', 'CR / #13', 'CRLF / #13#10');

type

  { TSerialMonitor_Options }

  TSerialMonitor_Options = class(TObject)
  public
    Com_Interface: record
      Port, Baud, Bits, Parity, StopBits, FlowControl: string;
      TimeOut, TimerInterval: integer;
      end;
    Output: record
      LineBreak: integer;
      AutoScroll, WordWarp: boolean;
      maxRows: integer;
      Font: TFont;
      BKColor: TColor;
      end;
    constructor Create;
    destructor Destroy; override;
    procedure Load_from_XML;
    procedure Save_to_XML;
  end;

  { TEmbedded_IDE_Options }
  {$IFDEF Packages}

  TEmbedded_IDE_Options = class(TObject)
  public
    AVR: record
      avrdudePath, avrdudeConfigPath: TStringList;
      end;
    ARM: record
      STFlashPath, BossacPath: TStringList;
      Raspi_Pico: record
        Unit_Path, cp_Path, mount_Path: TStringList;
        end;
      end;
    ESP: record
      Bootloader_Path, Tools_Path: TStringList;
      end;
    CustomProgrammer: record
      Path, Command: TStringList;
    end;
    SerialMonitor_Options: TSerialMonitor_Options;
    Templates_Path: TStringList;
    constructor Create;
    destructor Destroy; override;
    procedure Save_to_XML;
    procedure Load_from_XML;
  private
  end;

  {$ENDIF}

function FindFPCPara(const Source: string; const Sub: string): string;
function FindPara(const Source: string; Sub: TStringArray): string;

procedure ComboBox_Insert_Text(cb: TComboBox);

procedure LoadString_from_XML(Key: string; var s: string; default: string = '');
procedure SaveString_to_XML(Key: string; var s: string);

procedure LoadFormPos_from_XML(Form: TForm);
procedure SaveFormPos_to_XML(Form: TForm);

procedure LoadStrings_from_XML(Key: string; sl: TStrings; Default_Text: TStringArray = nil);
procedure SaveStrings_to_XML(Key: string; sl: TStrings);

procedure LoadComboBox_from_XML(cb: TComboBox; Default_Text: TStringArray = nil);
procedure SaveComboBox_to_XML(cb: TComboBox);

procedure LoadPageControl_from_XML(pc: TPageControl);
procedure SavePageControl_to_XML(pc: TPageControl);

procedure LoadFont_from_XML(Key: string; f: TFont);
procedure SaveFont_to_XML(Key: string; f: TFont);

procedure Load_IDE_Color_from_XML(var col: TColor);
procedure Save_IDE_Color_to_XML(var col: TColor);


implementation

const
  maxComboBoxCount = 20;
  FormPos = '/FormPos/';

  Key_IDE_Options = 'IDEOptions/';
  Key_IDE_Color = Key_IDE_Options + 'Color';

  Key_AVR = Key_IDE_Options + 'AVR/';
  Key_Avrdude_Path = Key_AVR + 'avrdude_path/';
  Key_Avrdude_Conf_Path = Key_AVR + 'avrdude_conf_path/';

  Key_ARM = Key_IDE_Options + 'ARM/';
  Key_STFlash_Path = Key_ARM + 'st_flash_path/';
  Key_Bassac_Path = Key_ARM + 'bossac_path/';
  Key_Raspi_Pico_Unit_Path = Key_ARM + 'raspi_pico_Unit_Path/';
  Key_Raspi_Pico_cp_Path = Key_ARM + 'raspi_pico_cp_Path/';
  Key_Raspi_Pico_mount_Path = Key_ARM + 'raspi_pico_mount_Path/';

  Key_ESP = Key_IDE_Options + 'ESP/';
  Key_ESP_Bootloader_Path = Key_ESP + 'ESP_Bootloader_path';
  Key_ESP_Tool_Path = Key_ESP + 'ESP_Tool_path';

  Key_CustomPrg = Key_IDE_Options + 'CustomPrg/';
  Key_CustomPrg_Path = Key_CustomPrg + 'Path';
  Key_CustomPrg_Command = Key_CustomPrg + 'Command';

  Key_Templates_Path = Key_IDE_Options + 'Templates_Path';

  Key_ComPara = 'COMPortPara/';
  Key_Output = 'OutputScreenPara/';
  Key_SM_Config = 'Serial_Monitor_Config/';

  Key_SerialMonitorPort = Key_SM_Config + Key_ComPara + 'Port';
  Key_SerialMonitorBaud = Key_SM_Config + Key_ComPara + 'Baud';
  Key_SerialMonitorParity = Key_SM_Config + Key_ComPara + 'Parity';
  Key_SerialMonitorBits = Key_SM_Config + Key_ComPara + 'Bits';
  Key_SerialMonitorStopBits = Key_SM_Config + Key_ComPara + 'StopBits';
  Key_SerialMonitorFlowControl = Key_SM_Config + Key_ComPara + 'FlowControl';
  Key_SerialMonitorTimeOut = Key_SM_Config + Key_ComPara + 'TimeOut';
  Key_SerialMonitorTimer = Key_SM_Config + Key_ComPara + 'TimerInterval';

  Key_SerialMonitorLineBreak = Key_SM_Config + Key_Output + 'LineBreak';
  Key_SerialMonitorAutoScroll = Key_SM_Config + Key_Output + 'AutoScroll';
  Key_SerialMonitorWordWarp = Key_SM_Config + Key_Output + 'Wordwarp';
  Key_SerialMonitorMaxRows = Key_SM_Config + Key_Output + 'maxRows';
  Key_SerialMonitorFont = Key_SM_Config + Key_Output + 'Font';
  Key_SerialMonitorBKColor = Key_SM_Config + Key_Output + 'BKColor';


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

function FindFPCPara(const Source: string; const Sub: string): string;
var
  p, Index: integer;
begin
  p := pos(Sub, Source);
  Result := '';
  if p > 0 then begin
    p += Length(Sub);
    Index := p;
    while (Index <= Length(Source)) and (Source[Index] > #32) do begin
      Result += Source[Index];
      Inc(Index);
    end;
  end;
end;

function FindPara(const Source: string; Sub: TStringArray): string;
var
  p, i, Index: integer;
begin
  Result := '';
  i := 0;
  while (i < Length(Sub)) and (Result = '') do begin
    sub[i] := ' ' + Sub[i];
    p := pos(Sub[i], Source);
    while Copy(Source, p + Length(Sub[i]), 1) = ' ' do begin
      Inc(p);
    end;
    if p > 0 then begin
      p += Length(Sub[i]);
      Index := p;
      while (Index <= Length(Source)) and (Source[Index] > #32) do begin
        Result += Source[Index];
        Inc(Index);
      end;
    end;
    Inc(i);
  end;
end;

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

procedure LoadString_from_XML(Key: string; var s: string; default: string = '');
var
  Cfg: TConfigStorage;
begin
  Cfg := GetIDEConfigStorage(Embedded_Options_File, True);
  s := Cfg.GetValue(Key, default);
  Cfg.Free;
end;

procedure SaveString_to_XML(Key: string; var s: string);
var
  Cfg: TConfigStorage;
begin
  Cfg := GetIDEConfigStorage(Embedded_Options_File, True);
  Cfg.SetValue(Key, s);
  Cfg.Free;
end;

procedure LoadFormPos_from_XML(Form: TForm);
var
  Cfg: TConfigStorage;
  col: TColor;
begin
  Cfg := GetIDEConfigStorage(Embedded_Options_File, True);
  Form.Left := Cfg.GetValue(Form.Name + FormPos + 'Left', Form.Left);
  Form.Top := Cfg.GetValue(Form.Name + FormPos + 'Top', Form.Top);
  Form.Width := Cfg.GetValue(Form.Name + FormPos + 'Width', Form.Width);
  Form.Height := Cfg.GetValue(Form.Name + FormPos + 'Height', Form.Height);
  Cfg.Free;
  Load_IDE_Color_from_XML(col);
  Form.Color := col;
  Form.Position := poDefaultPosOnly;
end;

procedure SaveFormPos_to_XML(Form: TForm);
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
  Cfg.DeletePath(Key);
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

procedure LoadPageControl_from_XML(pc: TPageControl);
var
  Cfg: TConfigStorage;
  Key: string;
begin
  Key := getParents(pc);
  Cfg := GetIDEConfigStorage(Embedded_Options_File, True);
  pc.PageIndex := Cfg.GetValue(Key + 'PageIndex', 0);
  Cfg.Free;
end;

procedure SavePageControl_to_XML(pc: TPageControl);
var
  Cfg: TConfigStorage;
  Key: string;
begin
  Key := getParents(pc);
  Cfg := GetIDEConfigStorage(Embedded_Options_File, True);
  Cfg.SetValue(Key + 'PageIndex', pc.PageIndex);
  Cfg.Free;
end;

procedure LoadFont_from_XML(Key: string; f: TFont);
var
  Cfg: TConfigStorage;
begin
  Cfg := GetIDEConfigStorage(Embedded_Options_File, True);
  f.Color := Cfg.GetValue(Key + '/Color', 0);
  f.Name := Cfg.GetValue(Key + '/Name', '');
  f.Size := Cfg.GetValue(Key + '/Size', 0);
  f.Style := [];
  if Cfg.GetValue(Key + '/Style/Bold', True) then begin
    f.Style := f.Style + [fsBold];
  end;
  if Cfg.GetValue(Key + '/Style/Italic', False) then begin
    f.Style := f.Style + [fsItalic];
  end;
  if Cfg.GetValue(Key + '/Style/StrikeOut', False) then begin
    f.Style := f.Style + [fsStrikeOut];
  end;
  if Cfg.GetValue(Key + '/Style/UnderLine', False) then begin
    f.Style := f.Style + [fsUnderline];
  end;
  Cfg.Free;
end;

procedure SaveFont_to_XML(Key: string; f: TFont);
var
  Cfg: TConfigStorage;
begin
  Cfg := GetIDEConfigStorage(Embedded_Options_File, True);
  Cfg.SetValue(Key + '/Color', f.Color);
  Cfg.SetValue(Key + '/Name', f.Name);
  Cfg.SetValue(Key + '/Size', f.Size);

  Cfg.SetValue(Key + '/Style/Bold', fsBold in f.Style);
  Cfg.SetValue(Key + '/Style/Italic', fsItalic in f.Style);
  Cfg.SetValue(Key + '/Style/StrikeOut', fsStrikeOut in f.Style);
  Cfg.SetValue(Key + '/Style/UnderLine', fsUnderline in f.Style);

  Cfg.Free;
end;

procedure Load_IDE_Color_from_XML(var col: TColor);
var
  Cfg: TConfigStorage;
begin
  Cfg := GetIDEConfigStorage(Embedded_Options_File, True);
  col := Cfg.GetValue(Key_IDE_Color, $E0F0E0);
  Cfg.Free;
end;

procedure Save_IDE_Color_to_XML(var col: TColor);
var
  Cfg: TConfigStorage;
begin
  Cfg := GetIDEConfigStorage(Embedded_Options_File, True);
  Cfg.SetValue(Key_IDE_Color, col);
  Cfg.Free;
end;

{ TSerialMonitor_Options }

constructor TSerialMonitor_Options.Create;
begin
  inherited Create;
  Output.Font := TFont.Create;
end;

destructor TSerialMonitor_Options.Destroy;
begin
  inherited Destroy;
  Output.Font.Free;
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
    maxRows := Cfg.GetValue(Key_SerialMonitorMaxRows, OutputDefaultmaxRow);
    BKColor := Cfg.GetValue(Key_SerialMonitorBKColor, clRed);
  end;
  Cfg.Free;
  LoadFont_from_XML(Key_SerialMonitorFont, Output.Font);
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
    Cfg.SetValue(Key_SerialMonitorMaxRows, maxRows);
    Cfg.SetValue(Key_SerialMonitorBKColor, BKColor);
  end;
  Cfg.Free;
  SaveFont_to_XML(Key_SerialMonitorFont, Output.Font);
end;

{ TEmbedded_IDE_Options }

{$IFDEF Packages}
constructor TEmbedded_IDE_Options.Create;
begin
  inherited Create;
  SerialMonitor_Options := TSerialMonitor_Options.Create;

  AVR.avrdudePath := TStringList.Create;
  AVR.avrdudeConfigPath := TStringList.Create;

  ARM.STFlashPath := TStringList.Create;
  ARM.BossacPath := TStringList.Create;
  ARM.Raspi_Pico.Unit_Path := TStringList.Create;
  ARM.Raspi_Pico.cp_Path := TStringList.Create;
  ARM.Raspi_Pico.mount_Path := TStringList.Create;

  ESP.Tools_Path := TStringList.Create;
  ESP.Bootloader_Path := TStringList.Create;

  CustomProgrammer.Path := TStringList.Create;
  CustomProgrammer.Command := TStringList.Create;

  Templates_Path := TStringList.Create;
end;

destructor TEmbedded_IDE_Options.Destroy;
begin
  AVR.avrdudePath.Free;
  AVR.avrdudeConfigPath.Free;

  ARM.STFlashPath.Free;
  ARM.BossacPath.Free;
  ARM.Raspi_Pico.Unit_Path.Free;
  ARM.Raspi_Pico.cp_Path.Free;
  ARM.Raspi_Pico.mount_Path.Free;

  ESP.Tools_Path.Free;
  ESP.Bootloader_Path.Free;

  CustomProgrammer.Path.Free;
  CustomProgrammer.Command.Free;

  Templates_Path.Free;

  SerialMonitor_Options.Free;
  inherited Destroy;
end;

procedure TEmbedded_IDE_Options.Load_from_XML;
var
  ThisPackage: TPackageLink;
  PackagePath: string;
begin
  ThisPackage := PkgLinks.FindLinkWithPkgName('embedded_gui_package');
  PackagePath := ThisPackage.LPKFilename;
  PackagePath := ExtractFilePath(PackagePath);

  LoadStrings_from_XML(Key_Avrdude_Path, AVR.avrdudePath, Default_Avrdude_Path);
  LoadStrings_from_XML(Key_Avrdude_Conf_Path, AVR.avrdudeConfigPath, Default_Avrdude_Conf_Path);

  LoadStrings_from_XML(Key_STFlash_Path, ARM.STFlashPath, Default_STFlash_Path);
  LoadStrings_from_XML(Key_Bassac_Path, ARM.BossacPath, Default_Bassac_Path);

  LoadStrings_from_XML(Key_Raspi_Pico_Unit_Path, ARM.Raspi_Pico.Unit_Path, [PackagePath + Default_Raspi_Pico_Unit_Path[0]]);
  LoadStrings_from_XML(Key_Raspi_Pico_cp_Path, ARM.Raspi_Pico.cp_Path, Default_Raspi_Pico_cp_Path);
  LoadStrings_from_XML(Key_Raspi_Pico_mount_Path, ARM.Raspi_Pico.mount_Path, Default_Raspi_Pico_mount_Path);

  LoadStrings_from_XML(Key_ESP_Tool_Path, ESP.Tools_Path, Default_EPS_Tool_Path);
  LoadStrings_from_XML(Key_ESP_Bootloader_Path, ESP.Bootloader_Path, [PackagePath + Default_ESP_Bootloader_Path[0]]);

  LoadStrings_from_XML(Key_CustomPrg_Path, CustomProgrammer.Path, Default_CustomPrg_Tool_Path);
  LoadStrings_from_XML(Key_CustomPrg_Command, CustomProgrammer.Command, Default_CustomPrg_Tool_Command);

  LoadStrings_from_XML(Key_Templates_Path, Templates_Path, [PackagePath + Default_Template_Path[0]]);

  SerialMonitor_Options.Load_from_XML;
end;

procedure TEmbedded_IDE_Options.Save_to_XML;
begin
  SaveStrings_to_XML(Key_Avrdude_Path, AVR.avrdudePath);
  SaveStrings_to_XML(Key_Avrdude_Conf_Path, AVR.avrdudeConfigPath);

  SaveStrings_to_XML(Key_STFlash_Path, ARM.STFlashPath);
  SaveStrings_to_XML(Key_Bassac_Path, ARM.BossacPath);

  SaveStrings_to_XML(Key_Raspi_Pico_Unit_Path, ARM.Raspi_Pico.Unit_Path);
  SaveStrings_to_XML(Key_Raspi_Pico_cp_Path, ARM.Raspi_Pico.cp_Path);
  SaveStrings_to_XML(Key_Raspi_Pico_mount_Path, ARM.Raspi_Pico.mount_Path);

  SaveStrings_to_XML(Key_ESP_Tool_Path, ESP.Tools_Path);
  SaveStrings_to_XML(Key_ESP_Bootloader_Path, ESP.Bootloader_Path);

  SaveStrings_to_XML(Key_Templates_Path, Templates_Path);

  SerialMonitor_Options.Save_to_XML;
end;

{$ENDIF}

end.
