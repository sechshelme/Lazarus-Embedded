unit Embedded_GUI_Serial_Monitor;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls, Menus,
  Serial,
  LazFileUtils,
  //  Input,

  {$IFDEF Komponents}
  BaseIDEIntf,  // Bei Komponente
  Embedded_GUI_IDE_Options,
  {$ELSE}
  IniFiles,  // Bei normalen Anwendungen
  {$ENDIF}

  Embedded_GUI_Common,
  Embedded_GUI_Find_Comports;

type

  { TSerial_Monitor_Form }

  TSerial_Monitor_Form = class(TForm)
    Button_Send: TButton;
    Clear_Button: TButton;
    Close_Button: TButton;
    CheckBox_AutoScroll: TCheckBox;
    ComboBox_Baud: TComboBox;
    ComboBox_Bits: TComboBox;
    ComboBox_FlowControl: TComboBox;
    ComboBox_Parity: TComboBox;
    ComboBox_Port: TComboBox;
    ComboBox_StopBits: TComboBox;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    MenuItem3: TMenuItem;
    MenuItem_Close: TMenuItem;
    Panel1: TPanel;
    Edit_Send: TEdit;
    MainMenu1: TMainMenu;
    Memo1: TMemo;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    Timer1: TTimer;
    procedure Button_SendClick(Sender: TObject);
    procedure Clear_ButtonClick(Sender: TObject);
    procedure Close_ButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure MenuItem_CloseClick(Sender: TObject);
    procedure ComboBoxChange(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    SubMenuItemArray: array[0..31] of TMenuItem;
    procedure MenuItemClick(Sender: TObject);
  public
    ser: record
      Handle: TSerialHandle;
      Flags: TSerialFlags;
      Parity: TParityType;
    end;
    procedure OpenSerial;
    procedure CloseSerial;
  end;

var
  Serial_Monitor_Form: TSerial_Monitor_Form;

implementation

{$R *.lfm}

{ TSerial_Monitor_Form }

procedure TSerial_Monitor_Form.FormCreate(Sender: TObject);
var
  i: integer;
begin
  Caption := Title + 'Serial-Monitor';
  LoadFormPos(Self);

  for i := 0 to Length(SubMenuItemArray) - 1 do begin
    SubMenuItemArray[i] := TMenuItem.Create(Self);
    with SubMenuItemArray[i] do begin
      Caption := '<CTRL+' + char(i + 64) + '>';
      Tag := i;
      OnClick := @MenuItemClick;
    end;
    MenuItem1.Insert(i, SubMenuItemArray[i]);
  end;

  Memo1.ScrollBars := ssAutoBoth;
  Memo1.WordWrap := False;
  Memo1.ParentFont := False;
  Memo1.Color := clBlack;
  Memo1.Font.Color := clLtGray;
  Memo1.Font.Name := 'Monospace';
  Memo1.Font.Style := [fsBold];
  Memo1.DoubleBuffered := True;

  Timer1.Interval := 200;

  ComboBox_Port.Style := csOwnerDrawFixed;
  ComboBox_Port.Items.CommaText := GetSerialPortNames;

  ComboBox_Baud.Style := csOwnerDrawFixed;
  ComboBox_Baud.Items.CommaText := UARTBaudRates;

  ComboBox_Parity.Style := csOwnerDrawFixed;
  ComboBox_Parity.Items.CommaText := UARTParitys;

  ComboBox_Bits.Style := csOwnerDrawFixed;
  ComboBox_Bits.Items.CommaText := UARTBitss;

  ComboBox_StopBits.Style := csOwnerDrawFixed;
  ComboBox_StopBits.Items.CommaText := UARTStopBitss;

  ComboBox_FlowControl.Style := csOwnerDrawFixed;
  ComboBox_FlowControl.Items.CommaText := UARTFlowControls;

  {$IFDEF Komponents}
  ComboBox_Port.Text := Embedded_IDE_Options.SerialMonitor.Port;
  ComboBox_Baud.Text := Embedded_IDE_Options.SerialMonitor.Baud;
  ComboBox_Parity.Text := Embedded_IDE_Options.SerialMonitor.Parity;
  ComboBox_Bits.Text := Embedded_IDE_Options.SerialMonitor.Bits;
  ComboBox_StopBits.Text := Embedded_IDE_Options.SerialMonitor.StopBits;
  ComboBox_FlowControl.Text := Embedded_IDE_Options.SerialMonitor.FlowControl;
  {$ELSE}
  ComboBox_Port.Text := UARTDefaultPort;
  ComboBox_Baud.Text := UARTDefaultBaud;
  ComboBox_Parity.Text := UARTDefaultParity;
  ComboBox_Bits.Text := UARTDefaultBits;
  ComboBox_StopBits.Text := UARTDefaultStopBits;
  ComboBox_FlowControl.Text := UARTDefaultFlowControl;
  {$ENDIF}

end;

procedure TSerial_Monitor_Form.FormHide(Sender: TObject);
begin
  CloseSerial;
end;

procedure TSerial_Monitor_Form.FormShow(Sender: TObject);
begin
  OpenSerial;
end;

procedure TSerial_Monitor_Form.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  SaveFormPos(Self);
end;

procedure TSerial_Monitor_Form.OpenSerial;
begin
  ser.Handle := SerOpen(ComboBox_Port.Text);
  SerSetParams(ser.Handle, StrToInt(ComboBox_Baud.Text), StrToInt(ComboBox_Bits.Text),
    NoneParity, StrToInt(ComboBox_StopBits.Text), ser.Flags);  // ??????????? ser.flags  NoneParity
//  SerSetParams(ser.Handle, StrToInt(ComboBox_Baud.Text), 8, NoneParity, 1, ser.Flags);
  Timer1.Enabled := True;
end;

procedure TSerial_Monitor_Form.CloseSerial;
begin
  Timer1.Enabled := False;
  SerSync(ser.Handle);
  SerFlushOutput(ser.Handle);
  SerClose(ser.Handle);
end;

procedure TSerial_Monitor_Form.MenuItem2Click(Sender: TObject);
begin
  //  InputForm.Show;
end;

procedure TSerial_Monitor_Form.MenuItem_CloseClick(Sender: TObject);
begin
  Timer1.Enabled := False;
  Close;
end;

procedure TSerial_Monitor_Form.Button_SendClick(Sender: TObject);
begin
  if Length(Edit_Send.Text) > 0 then begin
    SerWrite(ser.Handle, Edit_Send.Text[1], Length(Edit_Send.Text));
  end;
end;

procedure TSerial_Monitor_Form.ComboBoxChange(Sender: TObject);
begin
  CloseSerial;
  OpenSerial;
end;

procedure TSerial_Monitor_Form.Clear_ButtonClick(Sender: TObject);
begin
  Memo1.Clear;
end;

procedure TSerial_Monitor_Form.Close_ButtonClick(Sender: TObject);
begin
  Timer1.Enabled := False;
  Close;
end;

procedure TSerial_Monitor_Form.Timer1Timer(Sender: TObject);
var
  i: integer;
  header: array[0..1023] of byte;
  Count: integer;
begin
  //  FillByte(header, SizeOf(header), 0);

  while Timer1.Enabled do begin
    Count := SerReadTimeout(ser.Handle, header, 1024, 10);
    for i := 0 to Count - 1 do begin
      Memo1.Text := Memo1.Text + char(header[i]);
    end;

    if CheckBox_AutoScroll.Checked then begin
      Memo1.SelStart := -2;
    end;
    Application.ProcessMessages;
  end;
end;

procedure TSerial_Monitor_Form.MenuItemClick(Sender: TObject);
begin
  Caption := IntToStr(TMenuItem(Sender).Tag);
  SerWrite(ser.Handle, TMenuItem(Sender).Tag, 1);
end;

end.
