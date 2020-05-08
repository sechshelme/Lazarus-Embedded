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

  {$IFDEF Packages}
  Embedded_Options_File = 'embedded_gui_options.xml';
  {$ELSE}
  XMLConfigFile = 'config.xml'; // Bei normalen Anwendungen
  {$ENDIF}

  Key_AVRdude = 'avrdude/';
  Key_STFlash = 'st_flash/';

  Key_Avrdude_Path = Key_AVRdude + 'pfad/value';
  Key_Avrdude_Conf_Path = Key_AVRdude + 'conf_pfad/value';
  Key_STFlash_Path = Key_STFlash + 'pfad/value';

  {$IFDEF MSWINDOWS}
  Default_Avrdude_Path = 'c:\avrdude\avrdude.exe';
  Default_Avrdude_Conf_Path = 'c:\avrdude\avrdude.conf';
  Default_STFlash_Path = 'c:\st-link\st-flash.exe';
  UARTDefaultPort = 'COM8';
  {$ELSE}
  Default_Avrdude_Path = '/usr/bin/avrdude';
  Default_Avrdude_Conf_Path = '/etc/avrdude.conf';
  Default_STFlash_Path = '/usr/local/bin/st-flash';
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


procedure ComboBox_Insert(cb: TComboBox);

procedure LoadFormPos_from_XML(Form: TControl);
procedure SaveFormPos_to_XML(Form: TControl);

procedure LoadComboBox_from_XML(cb: TComboBox; Default_Text: string = '');
procedure SaveComboBox_to_XML(cb: TComboBox);

implementation

const
  maxComboBoxCount = 20;
  FormPos = '/FormPos/';

function getParents(c: TWinControl): string;
var
  p: TWinControl;
begin
  Result := '';
  p := c;
  repeat
    Result := p.Name + '/' + Result;
    p := p.Parent;
  until (p = nil) or (Pos('FRAME', UpCase(p.ClassName)) > 0) or (Pos('FORM', UpCase(p.ClassName)) > 0);
  Result := p.Name + '/' + Result;
end;

procedure ComboBox_Insert(cb: TComboBox);
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
  {$IFDEF Packages}
  Cfg: TConfigStorage;
  {$ELSE}
  Cfg: TXMLConfig;
  {$ENDIF}
begin
  {$IFDEF Packages}
  Cfg := GetIDEConfigStorage(Embedded_Options_File, True);
  {$ELSE}
  Cfg := TXMLConfig.Create(nil);
  Cfg.Filename := XMLConfigFile;
  {$ENDIF}
  Form.Left := Cfg.GetValue(Form.Name + FormPos + 'Left', Form.Left);
  Form.Top := Cfg.GetValue(Form.Name + FormPos + 'Top', Form.Top);
  Form.Width := Cfg.GetValue(Form.Name + FormPos + 'Width', Form.Width);
  Form.Height := Cfg.GetValue(Form.Name + FormPos + 'Height', Form.Height);
  Cfg.Free;
end;

procedure SaveFormPos_to_XML(Form: TControl);
var
  {$IFDEF Packages}
  Cfg: TConfigStorage;
  {$ELSE}
  Cfg: TXMLConfig;
  {$ENDIF}
begin
  {$IFDEF Packages}
  Cfg := GetIDEConfigStorage(Embedded_Options_File, True);
  {$ELSE}
  Cfg := TXMLConfig.Create(nil);
  Cfg.Filename := XMLConfigFile;
  {$ENDIF}
  Cfg.SetValue(Form.Name + FormPos + 'Left', Form.Left);
  Cfg.SetValue(Form.Name + FormPos + 'Top', Form.Top);
  Cfg.SetValue(Form.Name + FormPos + 'Width', Form.Width);
  Cfg.SetValue(Form.Name + FormPos + 'Height', Form.Height);
  Cfg.Free;
end;

procedure LoadComboBox_from_XML(cb: TComboBox; Default_Text: string = '');
var
  {$IFDEF Packages}
  Cfg: TConfigStorage;
  {$ELSE}
  Cfg: TXMLConfig;
  {$ENDIF}
  ct, i: integer;
  Key, s: string;
begin
  {$IFDEF Packages}
  Cfg := GetIDEConfigStorage(Embedded_Options_File, True);
  {$ELSE}
  Cfg := TXMLConfig.Create(nil);
  Cfg.Filename := XMLConfigFile;
  {$ENDIF}
  Key := getParents(cb);
  ct := Cfg.GetValue(Key + 'Count', 0);
  cb.Text := Cfg.GetValue(Key + 'Text', Default_Text);
  cb.Items.Clear;

  for i := 0 to ct - 1 do begin
    s := Cfg.GetValue(Key + 'Item' + i.ToString + '/value', '');
    cb.Items.Add(s);
  end;

  if (Default_Text <> '') and (cb.Items.Count < maxComboBoxCount) then begin
    i := cb.Items.IndexOf(Default_Text);
    if i < 0 then begin
      cb.Items.Add(Default_Text);
    end;
  end;

  Cfg.Free;
end;

procedure SaveComboBox_to_XML(cb: TComboBox);
var
  {$IFDEF Packages}
  Cfg: TConfigStorage;
  {$ELSE}
  Cfg: TXMLConfig;
  {$ENDIF}
  i: integer;
  Key: string;
begin
  {$IFDEF Packages}
  Cfg := GetIDEConfigStorage(Embedded_Options_File, True);
  {$ELSE}
  Cfg := TXMLConfig.Create(nil);
  Cfg.Filename := XMLConfigFile;
  {$ENDIF}
  Key := getParents(cb);
  Cfg.SetValue(Key + 'Count', cb.Items.Count);
  Cfg.SetValue(Key + 'Text', cb.Text);
  for i := 0 to cb.Items.Count - 1 do begin
    Cfg.SetValue(Key + 'Item' + i.ToString + '/value', cb.Items[i]);
  end;
  Cfg.Free;
end;

end.
