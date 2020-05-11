unit Embedded_GUI_Serial_Monitor_Form;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls, Menus, Spin,
  Serial,
  LazFileUtils, SynEdit,
  //  Input,

  {$IFDEF Packages}
  BaseIDEIntf,              // Bei Packages
  {$ELSE}
  IniFiles,  // Bei normalen Projekt
  {$ENDIF}

  Embedded_GUI_Common,
  Embedded_GUI_Find_Comports,
  Embedded_GUI_Serial_Monitor_Send_File_Form,
  Embedded_GUI_Serial_Monitor_Options_Form;

type

  { TSerial_Monitor_Form }

  TSerial_Monitor_Form = class(TForm)
    Button_Send: TButton;
    Clear_Button: TButton;
    Close_Button: TButton;
    ComboBox_SendString: TComboBox;
    MenuItem3: TMenuItem;
    MenuItem_Options: TMenuItem;
    MenuItem_Optionen: TMenuItem;
    MenuItem_SendFile: TMenuItem;
    MenuItem_Close: TMenuItem;
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
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
    procedure MenuItem_OptionenClick(Sender: TObject);
    procedure MenuItem_CloseClick(Sender: TObject);
    procedure ComboBoxChange(Sender: TObject);
    procedure MenuItem_SendFileClick(Sender: TObject);
    procedure RadioGroup_LineBreakSelectionChanged(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    TempSL: TStrings;
    //    Send_ComboBox_Key: string;
    ReadBuffer: array[0..4096] of byte;
    SubMenuItemArray: array[0..31] of TMenuItem;
    procedure MenuItemClick(Sender: TObject);
  public
    SerialHandle: TSerialHandle;
    SerialMonitor_Options: TSerialMonitor_Options;
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
  LoadFormPos_from_XML(Self);

  TempSL := TStringList.Create;
  TempSL.SkipLastLineBreak := True;

  SerialMonitor_Options := TSerialMonitor_Options.Create;
  SerialMonitor_Options.Load_from_XML;
  SerialMonitor_Options_Form := TSerialMonitor_Options_Form.Create(Self);
  SerialMonitor_SendFile_Form := TSerialMonitor_SendFile_Form.Create(Self);

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
  SynEdit1.ReadOnly := True;

  LoadComboBox_from_XML(ComboBox_SendString, ['Hello World !', 'Hallo Welt !']);

  Timer1.Interval := 200;
end;

procedure TSerial_Monitor_Form.FormDestroy(Sender: TObject);
begin
  SerialMonitor_Options.Free;
  TempSL.Free;
end;

procedure TSerial_Monitor_Form.FormShow(Sender: TObject);
begin
  OpenSerial;
end;

procedure TSerial_Monitor_Form.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  CloseSerial;
  SaveFormPos_to_XML(Self);
end;

procedure TSerial_Monitor_Form.OpenSerial;
var
  Flags: TSerialFlags;
  Par: TParityType;
begin
  CloseSerial;

  with SerialMonitor_Options.Com_Interface do begin
    if FlowControl = 'none' then begin
      Flags := [];
    end else begin
      Flags := [RtsCtsFlowControl];
    end;

    case Parity of
      'none': begin
        Par := NoneParity;
      end;
      'odd': begin
        Par := OddParity;
      end;
      'even': begin
        Par := EvenParity;
      end;
    end;

    SerialHandle := SerOpen(Port);
    SerSetParams(SerialHandle, StrToInt(Baud), StrToInt(Bits), Par, StrToInt(StopBits), Flags);

    Timer1.Interval := TimerInterval;
    Timer1.Enabled := True;
  end;
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
var
  i: integer;
  s: string;
begin
  s := ComboBox_SendString.Text;
  if Length(s) > 0 then begin
    SerWrite(SerialHandle, s[1], Length(s));

    ComboBox_Insert_Text(ComboBox_SendString);
    SaveComboBox_to_XML(ComboBox_SendString);
  end;
end;

procedure TSerial_Monitor_Form.ComboBoxChange(Sender: TObject);
begin
  CloseSerial;
  OpenSerial;
end;

procedure TSerial_Monitor_Form.MenuItem_SendFileClick(Sender: TObject);
begin
  SerialMonitor_SendFile_Form.Show;
end;

procedure TSerial_Monitor_Form.RadioGroup_LineBreakSelectionChanged(Sender: TObject);
const
  LB: array[0..2] of string[2] = (#10, #13, #13#10);
begin
  TempSL.LineBreak := LB[SerialMonitor_Options.Output.LineBreak];
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
    with SerialMonitor_Options.Com_Interface do begin
      if TimeOut = 0 then begin
        bufCount := SerRead(SerialHandle, ReadBuffer, Length(ReadBuffer) - 1);
      end else begin
        bufCount := SerReadTimeout(SerialHandle, ReadBuffer, Length(ReadBuffer) - 1, TimeOut);
      end;
    end;

    //if bufCount > maxPuffer then begin
    //  maxPuffer := bufCount;
    //  Caption := maxPuffer.ToString;
    //end;

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

      if (TempSL.LineBreak = #10) or (TempSL.LineBreak = #13#10) then begin
        if ReadBuffer[bufCount - 1] = 10 then begin
          SynEdit1.Lines.Add('');
        end;
      end else begin
        if TempSL.LineBreak = #13 then begin
          if ReadBuffer[bufCount - 1] = 13 then begin
            SynEdit1.Lines.Add('');
          end;
        end;
      end;

      if SerialMonitor_Options.Output.AutoScroll then begin
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

procedure TSerial_Monitor_Form.MenuItem_OptionenClick(Sender: TObject);
begin
  SerialMonitor_Options_Form.Show;
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
