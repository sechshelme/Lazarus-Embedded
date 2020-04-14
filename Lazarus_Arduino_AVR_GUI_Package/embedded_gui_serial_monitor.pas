unit Embedded_GUI_Serial_Monitor;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls, Menus,
  Serial,
  LazFileUtils,
//  Input,

  {$IFDEF Komponets}
  BaseIDEIntf,  // Bei Komponente
  LazConfigStorage,
  {$ELSE}
  IniFiles,  // Bei normalen Anwendungen
  {$ENDIF}

  Embedded_GUI_Common,
  Embedded_GUI_Find_Comports;

type

  { TSerial_Monitor_Form }

  TSerial_Monitor_Form = class(TForm)
    Button1: TButton;
    Clear_Button: TButton;
    Close_Button: TButton;
    CheckBox1: TCheckBox;
    Port_ComboBox: TComboBox;
    Baud_ComboBox: TComboBox;
    Edit1: TEdit;
    MainMenu1: TMainMenu;
    Memo1: TMemo;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    Timer1: TTimer;
    procedure Baud_ComboBoxChange(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Clear_ButtonClick(Sender: TObject);
    procedure Close_ButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure Port_ComboBoxChange(Sender: TObject);
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

  for i := 0 to Length(SubMenuItemArray) - 1 do begin
    SubMenuItemArray[i] := TMenuItem.Create(Self);
    with SubMenuItemArray[i] do begin
      Caption := '<CTRL+' + char(i + 64) + '>';
      Tag := i;
      OnClick := @MenuItemClick;
    end;
    MenuItem1.Insert(i, SubMenuItemArray[i]);
  end;

  Port_ComboBox.Style := csOwnerDrawFixed;
  Port_ComboBox.Items.CommaText := GetSerialPortNames;
  Port_ComboBox.Text := '/dev/ttyUSB0';
  Baud_ComboBox.Items.CommaText := UARTBaudRates;
  Baud_ComboBox.Text := '9600';
//  Baud_ComboBox.Style := csOwnerDrawFixed;

  ser.Handle := SerOpen('/dev/ttyUSB0');

  SerSetParams(ser.Handle, 9600, 8, NoneParity, 1, ser.Flags);

  {$IFDEF MSWINDOWS}
  ser.Handle := SerOpen('COM8');
  {$ELSE}
  ser.Handle := SerOpen('/dev/ttyUSB0');
  {$ENDIF}

  //  Sleep(1000);

  Memo1.ScrollBars := ssAutoBoth;
  Memo1.WordWrap := False;
  Memo1.ParentFont := False;
  Memo1.Color := clBlack;
  Memo1.Font.Color := clLtGray;
  Memo1.Font.Name := 'Monospace';
  Memo1.Font.Style := [fsBold];

  //  Memo1.Lines.Add('Device: ' + ser.Device + '   Status: ' + ser.LastErrorDesc +    ' ' + IntToStr(ser.LastError));
  //  Sleep(1000);
  Timer1.Interval := 100;
  Timer1.Enabled := True;

  Memo1.DoubleBuffered := True;
end;

procedure TSerial_Monitor_Form.MenuItem2Click(Sender: TObject);
begin
//  InputForm.Show;
end;

procedure TSerial_Monitor_Form.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  Timer1.Enabled := False;
  SerSync(ser.Handle);
  SerFlushOutput(ser.Handle);
  SerClose(ser.Handle);
end;

procedure TSerial_Monitor_Form.Button1Click(Sender: TObject);
begin
  if Length(Edit1.Text) > 0 then begin
    SerWrite(ser.Handle, Edit1.Text[1], Length(Edit1.Text));
  end;
end;

procedure TSerial_Monitor_Form.Port_ComboBoxChange(Sender: TObject);
begin
  Timer1.Enabled := False;
  SerSync(ser.Handle);
  SerFlushOutput(ser.Handle);
  SerClose(ser.Handle);

  ser.Handle := SerOpen(Port_ComboBox.Text);
  SerSetParams(ser.Handle, StrToInt(Baud_ComboBox.Text), 8, NoneParity, 1, ser.Flags);
  Timer1.Enabled := True;
end;

procedure TSerial_Monitor_Form.Baud_ComboBoxChange(Sender: TObject);
begin
  SerSetParams(ser.Handle, StrToInt(Baud_ComboBox.Text), 8, NoneParity, 1, ser.Flags);
end;

procedure TSerial_Monitor_Form.Clear_ButtonClick(Sender: TObject);
begin
  Memo1.Clear;
end;

procedure TSerial_Monitor_Form.Close_ButtonClick(Sender: TObject);
begin
  Timer1.Enabled:=False;
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

    if CheckBox1.Checked then begin
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
