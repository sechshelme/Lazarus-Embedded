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
    SpinEdit_Timer: TSpinEdit;
    SynEdit1: TSynEdit;
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
  LoadFormPos(Self);

  TempSL := TStringList.Create;

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
  ComboBox_Port.Text := Embedded_IDE_Options.SerialMonitor.Port;
  ComboBox_Baud.Text := Embedded_IDE_Options.SerialMonitor.Baud;
  ComboBox_Parity.Text := Embedded_IDE_Options.SerialMonitor.Parity;
  ComboBox_Bits.Text := Embedded_IDE_Options.SerialMonitor.Bits;
  ComboBox_StopBits.Text := Embedded_IDE_Options.SerialMonitor.StopBits;
  ComboBox_FlowControl.Text := Embedded_IDE_Options.SerialMonitor.FlowControl;
  SpinEdit_TimeOut.Value := Embedded_IDE_Options.SerialMonitor.TimeOut;
  SpinEdit_Timer.Value := Embedded_IDE_Options.SerialMonitor.Timer;
  {$ELSE}
  ComboBox_Port.Text := UARTDefaultPort;
  ComboBox_Baud.Text := UARTDefaultBaud;
  ComboBox_Parity.Text := UARTDefaultParity;
  ComboBox_Bits.Text := UARTDefaultBits;
  ComboBox_StopBits.Text := UARTDefaultStopBits;
  ComboBox_FlowControl.Text := UARTDefaultFlowControl;
  SpinEdit_TimeOut.Value := UARTDefaultTimeOut;
  SpinEdit_Timer.Value := UARTDefaultTimer;
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
  CloseSerial;
  SaveFormPos(Self);
  TempSL.Free;
end;

procedure TSerial_Monitor_Form.OpenSerial;
var
  Flags: TSerialFlags;
  Parity: TParityType;

begin
  if ComboBox_FlowControl.Text = 'none' then begin
    Flags := [];
  end else begin
    Flags := [RtsCtsFlowControl];
  end;

  Parity := TParityType(ComboBox_Parity.ItemIndex);

  SerialHandle := SerOpen(ComboBox_Port.Text);
  SerSetParams(SerialHandle, StrToInt(ComboBox_Baud.Text), StrToInt(ComboBox_Bits.Text),
    Parity, StrToInt(ComboBox_StopBits.Text), Flags);

  Timer1.Interval := SpinEdit_Timer.Value;
  Timer1.Enabled := True;
end;

procedure TSerial_Monitor_Form.CloseSerial;
begin
  Timer1.Enabled := False;
  SerSync(SerialHandle);
  SerFlushOutput(SerialHandle);
  SerClose(SerialHandle);
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

//procedure TSerial_Monitor_Form.Timer1Timer(Sender: TObject);
//var
//  buf: array[0..4095] of byte;
//  sl, bufCount, SLCount: integer;
//  s: string;
//begin
//  Timer1.Enabled := False;
//  bufCount := SerReadTimeout(SerialHandle, buf, Length(buf), SpinEdit_TimeOut.Value);
//  //  bufCount := SerReadTimeout(SerialHandle, buf, Length(buf));
//  //    for i := 0 to Count - 1 do begin
//  //      SynEdit1.Text := SynEdit1.Text + char(buf[i]);
//  //    end;
//  if bufCount > 0 then begin
//    sl := SynEdit1.SelStart;
//    SetLength(s, bufCount);
//    Move(buf, s[1], bufCount);
//
//    SLCount := SynEdit1.Lines.Count - 1;
//    SynEdit1.Lines[SLCount] := SynEdit1.Lines[SLCount] + s;
//
//
//    if CheckBox_AutoScroll.Checked then begin
//      SynEdit1.SelStart := -2;
////      SynEdit1.SelStart := 10;
////      SynEdit1.SelLength := 10;
//      SynEdit1.VertScrollBar.Position:=1000000;
//    end else begin
////      SynEdit1.SelStart := sl;
//    end;
//  end;
//  Caption:=sl.ToString;
//
//  //    Application.ProcessMessages;
//  //  end;
//  Timer1.Enabled := True;
//end;

procedure TSerial_Monitor_Form.Timer1Timer(Sender: TObject);
var
  bufCount, SLCount, i: integer;
begin
  Timer1.Enabled := False;
  try
    bufCount := SerReadTimeout(SerialHandle, ReadBuffer, Length(ReadBuffer) - 1, SpinEdit_TimeOut.Value);
    if bufCount > 0 then begin
      ReadBuffer[bufCount] := 0;
      TempSL.Text := PChar(@ReadBuffer[0]);

      SLCount := SynEdit1.Lines.Count - 1;
      if SLCount < 1 then begin
        SynEdit1.Lines.Add(TempSL[0]);
      end else begin
        SynEdit1.Lines[SLCount] := SynEdit1.Lines[SLCount] + TempSL[0];
      end;

      for i := 1 to TempSL.Count - 1 do begin
        SynEdit1.Lines.Add(TempSL[i]);
      end;

//      if ReadBuffer[bufCount - 1] in [10, 13] then begin
        if ReadBuffer[bufCount - 1] in [13] then begin
        SynEdit1.Lines.Add('');
      end;
      //SynEdit1.Text := SynEdit1.Text + TempSL.Text;


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
