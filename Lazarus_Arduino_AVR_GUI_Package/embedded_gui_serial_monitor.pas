unit Embedded_GUI_Serial_Monitor;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  Menus,

  synaser, // Package "laz_synapse"


   BaseIDEIntf,
  LazConfigStorage,

  Embedded_GUI_Common,
  Embedded_GUI_Find_Comports, Embedded_GUI_AVR_Common;

type

  { TSerial_Monitor_Form }

  TSerial_Monitor_Form = class(TForm)
    Send_Button: TButton;
    Clear_Button: TButton;
    CheckBox1: TCheckBox;
    Edit1: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    MainMenu1: TMainMenu;
    Memo1: TMemo;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    SerialMonitorBaud_ComboBox: TComboBox;
    SerialMonitorPort_ComboBox: TComboBox;
    Timer1: TTimer;
    procedure Send_ButtonClick(Sender: TObject);
    procedure Clear_ButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    SubMenuItemArray: array[0..31] of TMenuItem;
    procedure MenuItemClick(Sender: TObject);
  public
    ser: TBlockSerial;
    procedure LoadDefaultMask;
    procedure ProjectOptionsToMask;
    procedure MaskToProjectOptions;
  end;

var
  Serial_Monitor_Form: TSerial_Monitor_Form;

implementation

{$R *.lfm}

{ TSerial_Monitor_Form }

procedure TSerial_Monitor_Form.FormCreate(Sender: TObject);
var
  Cfg: TConfigStorage;
  sl: TStringList;
  i: integer;
//  bf: TBaudForm;
  baud: integer;
begin
  Caption:=Title + 'Serial - Monitor';
  Cfg := GetIDEConfigStorage(Embedded_Options_File, True);
  Left := StrToInt(Cfg.GetValue(Key_SerialMonitor_Left, '100'));
  Top := StrToInt(Cfg.GetValue(Key_SerialMonitor_Top, '50'));
  Width := StrToInt(Cfg.GetValue(Key_SerialMonitor_Width, '500'));
  Height := StrToInt(Cfg.GetValue(Key_SerialMonitor_Height, '500'));
  Cfg.Free;

//  bf := TBaudForm.Create(self);
//  bf.ShowModal;

//  baud := StrToInt(bf.ComboBox1.Text);
baud:=9600;

//  bf.Free;

  for i := 0 to Length(SubMenuItemArray) - 1 do begin
    SubMenuItemArray[i] := TMenuItem.Create(Self);
    with SubMenuItemArray[i] do begin
      Caption := '<CTRL+' + char(i + 64) + '>';
      Tag := i;
      OnClick := @MenuItemClick;
    end;
    MenuItem1.Insert(i, SubMenuItemArray[i]);
  end;


//  ComboBox1.Items.CommaText := GetSerialPortNames;

  ser := TBlockSerial.Create;
  ser.LinuxLock := False;
  ser.Purge;

  {$IFDEF MSWINDOWS}
  ser.Connect('COM8');
  {$ELSE}
  //  ser.Connect('/dev/ttyACM2');
  ser.Connect('/dev/ttyUSB0');
  {$ENDIF}

  Sleep(1000);
  //ser.Config(9600, 8, 'N', SB1, False, False);
  ser.Config(baud, 8, 'N', SB1, False, False);

  Memo1.ScrollBars := ssAutoBoth;
  Memo1.WordWrap := False;
  Memo1.ParentFont := False;
  Memo1.Color := clBlack;
  Memo1.Font.Color := clLtGray;
  Memo1.Font.Name := 'Monospace';
  Memo1.Lines.Add('Device: ' + ser.Device + '   Status: ' + ser.LastErrorDesc +
    ' ' + IntToStr(ser.LastError));
  Memo1.DoubleBuffered := True;

  Sleep(1000);
  Timer1.Interval := 100;
  Timer1.Enabled := True;
end;

procedure TSerial_Monitor_Form.FormClose(Sender: TObject; var CloseAction: TCloseAction);
var
  Cfg: TConfigStorage;
begin
  Timer1.Enabled := False;
  ser.Free;

  Cfg := GetIDEConfigStorage(Embedded_Options_File, True);
  Cfg.SetDeleteValue(Key_SerialMonitor_Left, IntToStr(Left), '100');
  Cfg.SetDeleteValue(Key_SerialMonitor_Top, IntToStr(Top), '50');
  Cfg.SetDeleteValue(Key_SerialMonitor_Width, IntToStr(Width), '500');
  Cfg.SetDeleteValue(Key_SerialMonitor_Height, IntToStr(Height), '500');
  Cfg.Free;
end;

procedure TSerial_Monitor_Form.Timer1Timer(Sender: TObject);
var
  s: string;
  l: integer;
begin
  while Timer1.Enabled and (ser.CanRead(10)) do begin
    l := ser.WaitingData;
    SetLength(s, l);
    ser.RecvBuffer(@s[1], l);
    Memo1.Text := Memo1.Text + s;
    if CheckBox1.Checked then begin
      Memo1.SelStart := -2;
    end;
    Application.ProcessMessages;
  end;
end;

procedure TSerial_Monitor_Form.MenuItemClick(Sender: TObject);
begin
  ser.SendByte(TMenuItem(Sender).Tag);
end;

procedure TSerial_Monitor_Form.Clear_ButtonClick(Sender: TObject);
begin
  Memo1.Clear;
end;

procedure TSerial_Monitor_Form.Send_ButtonClick(Sender: TObject);
begin
  ser.SendBuffer(Pointer(Edit1.Text), Length(Edit1.Text));
end;

procedure TSerial_Monitor_Form.LoadDefaultMask;
begin
  with SerialMonitorPort_ComboBox do begin
    Items.CommaText := GetSerialPortNames;
    Text := '/dev/ttyUSB0';
  end;

  with SerialMonitorBaud_ComboBox do begin
    Items.CommaText := UARTBaudRates;
    Text := '9600';
  end;
end;

procedure TSerial_Monitor_Form.ProjectOptionsToMask;
begin
  with SerialMonitorPort_ComboBox do begin
//    Text := AVR_ProjectOptions.SerialMonitor.Port;
  end;

  with SerialMonitorBaud_ComboBox do begin
//    Text := AVR_ProjectOptions.SerialMonitor.Baud;
  end;
end;

procedure TSerial_Monitor_Form.MaskToProjectOptions;
begin
//    AVR_ProjectOptions.SerialMonitor.Port := SerialMonitorPort_ComboBox.Text;
//    AVR_ProjectOptions.SerialMonitor.Baud := SerialMonitorBaud_ComboBox.Text;
end;

end.

