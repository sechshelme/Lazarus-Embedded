unit Embedded_GUI_Serial_Monitor;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls, Menus, Spin,
  Serial,
  LazFileUtils, SynEdit,
  //  Input,

  {$IFDEF Komponents}
  BaseIDEIntf,              // Bei Komponente
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
    CheckBox_WordWarp: TCheckBox;
    Clear_Button: TButton;
    Close_Button: TButton;
    CheckBox_AutoScroll: TCheckBox;
    ComboBox_Baud: TComboBox;
    ComboBox_Bits: TComboBox;
    ComboBox_FlowControl: TComboBox;
    ComboBox_Parity: TComboBox;
    ComboBox_Port: TComboBox;
    ComboBox_StopBits: TComboBox;
    Label10: TLabel;
    Label11: TLabel;
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
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    SpinEdit_TimeOut: TSpinEdit;
    SpinEdit_TimerInterval: TSpinEdit;
    SynEdit1: TSynEdit;
    Timer1: TTimer;
    procedure Button_SendClick(Sender: TObject);
    procedure Clear_ButtonClick(Sender: TObject);
    procedure Close_ButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure MenuItem_CloseClick(Sender: TObject);
    procedure ComboBoxChange(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    TempSL: TStrings;
    ReadBuffer: array[0..4096] of byte;
    SubMenuItemArray: array[0..31] of TMenuItem;
    procedure MenuItemClick(Sender: TObject);
  public
    SerialHandle: TSerialHandle;
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
  SerialHandle := 0;
  LoadFormPos(Self);

  TempSL := TStringList.Create;
//  TempSL.LineBreak := #13#10;
  TempSL.LineBreak := #10;
  TempSL.SkipLastLineBreak := True;

  for i := 0 to Length(SubMenuItemArray) - 1 do begin
    SubMenuItemArray[i] := TMenuItem.Create(Self);
    with SubMenuItemArray[i] do begin
      Caption := '<CTRL+' + char(i + 64) + '>';
      Tag := i;
      OnClick := @MenuItemClick;
    end;
    MenuItem1.Insert(i, SubMenuItemArray[i]);
  end;

  SynEdit1.ScrollBars := ssAutoBoth;
  SynEdit1.ParentFont := False;
  SynEdit1.Color := clBlack;
  SynEdit1.Font.Color := clLtGray;
  SynEdit1.Font.Name := 'Monospace';
  SynEdit1.Font.Style := [fsBold];
  SynEdit1.DoubleBuffered := True;

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
  with Embedded_IDE_Options do begin
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
  {$ELSE}
  ComboBox_Port.Text := UARTDefaultPort;
  ComboBox_Baud.Text := UARTDefaultBaud;
  ComboBox_Parity.Text := UARTDefaultParity;
  ComboBox_Bits.Text := UARTDefaultBits;
  ComboBox_StopBits.Text := UARTDefaultStopBits;
  ComboBox_FlowControl.Text := UARTDefaultFlowControl;
  SpinEdit_TimeOut.Value := UARTDefaultTimeOut;
  SpinEdit_TimerInterval.Value := UARTDefaultTimer;

  CheckBox_AutoScroll.Checked := True;
  CheckBox_WordWarp.Checked := False;
  {$ENDIF}

end;

procedure TSerial_Monitor_Form.FormDestroy(Sender: TObject);
begin
  TempSL.Free;
end;

procedure TSerial_Monitor_Form.FormShow(Sender: TObject);
begin
  ComboBox_Port.Items.CommaText := GetSerialPortNames;
  OpenSerial;
end;

procedure TSerial_Monitor_Form.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  CloseSerial;
  SaveFormPos(Self);
end;

procedure TSerial_Monitor_Form.OpenSerial;
var
  Flags: TSerialFlags;
  Parity: TParityType;

begin
  CloseSerial;

  if ComboBox_FlowControl.Text = 'none' then begin
    Flags := [];
  end else begin
    Flags := [RtsCtsFlowControl];
  end;

  Parity := TParityType(ComboBox_Parity.ItemIndex);

  SerialHandle := SerOpen(ComboBox_Port.Text);
  SerSetParams(SerialHandle, StrToInt(ComboBox_Baud.Text), StrToInt(ComboBox_Bits.Text),
    Parity, StrToInt(ComboBox_StopBits.Text), Flags);

  Timer1.Interval := SpinEdit_TimerInterval.Value;
  Timer1.Enabled := True;
end;

procedure TSerial_Monitor_Form.CloseSerial;
begin
  if SerialHandle <> 0 then begin
    Timer1.Enabled := False;
    SerSync(SerialHandle);
    SerFlushOutput(SerialHandle);
    SerClose(SerialHandle);
    SerialHandle := 0;
  end;
end;

procedure TSerial_Monitor_Form.Button_SendClick(Sender: TObject);
begin
  if Length(Edit_Send.Text) > 0 then begin
    SerWrite(SerialHandle, Edit_Send.Text[1], Length(Edit_Send.Text));
  end;
end;

procedure TSerial_Monitor_Form.ComboBoxChange(Sender: TObject);
begin
  CloseSerial;
  OpenSerial;
end;

procedure TSerial_Monitor_Form.Clear_ButtonClick(Sender: TObject);
begin
  SynEdit1.Clear;
end;

procedure TSerial_Monitor_Form.Close_ButtonClick(Sender: TObject);
begin
  Close;
end;

procedure TSerial_Monitor_Form.Timer1Timer(Sender: TObject);
var
  bufCount, SLCount: integer;
const
  maxPuffer: integer = 0;
begin
  Timer1.Enabled := False;
  try
    if SpinEdit_TimeOut.Value = 0 then begin
      bufCount := SerRead(SerialHandle, ReadBuffer, Length(ReadBuffer) - 1);
    end else begin
      bufCount := SerReadTimeout(SerialHandle, ReadBuffer, Length(ReadBuffer) - 1, SpinEdit_TimeOut.Value);
    end;

    if bufCount > maxPuffer then begin
      maxPuffer := bufCount;
//      Caption := maxPuffer.ToString;
    end;

    if bufCount > 0 then begin
      ReadBuffer[bufCount] := 0; // Für PChar

      SLCount := SynEdit1.Lines.Count - 1;

      if SLCount >= 0 then begin
        TempSL.Text := SynEdit1.Lines[SLCount] + PChar(@ReadBuffer[0]);
        SynEdit1.Lines.Delete(SLCount);
      end else begin
        TempSL.Text := PChar(@ReadBuffer[0]);
      end;

      SynEdit1.Lines.AddStrings(TempSL);
      if ReadBuffer[bufCount - 1] = 10 then begin
        SynEdit1.Lines.Add('');
      end;

      if CheckBox_AutoScroll.Checked then begin
        SynEdit1.CaretY := SynEdit1.Lines.Count;
      end;

    end;
  finally
    Timer1.Enabled := True;
  end;
end;


procedure TSerial_Monitor_Form.MenuItem2Click(Sender: TObject);
begin
  //  InputForm.Show;
end;

procedure TSerial_Monitor_Form.MenuItem_CloseClick(Sender: TObject);
begin
  Close;
end;

procedure TSerial_Monitor_Form.MenuItemClick(Sender: TObject);
begin
  Caption := IntToStr(TMenuItem(Sender).Tag);
  SerWrite(SerialHandle, TMenuItem(Sender).Tag, 1);
end;

end.
