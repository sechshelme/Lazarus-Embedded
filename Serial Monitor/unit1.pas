unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls, Menus, synaser, LazFileUtils, Input, Baud;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    CheckBox1: TCheckBox;
    ComboBox1: TComboBox;
    ComboBoxBaud: TComboBox;
    Edit1: TEdit;
    MainMenu1: TMainMenu;
    Memo1: TMemo;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    Timer1: TTimer;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    SubMenuItemArray: array[0..31] of TMenuItem;

    procedure MenuItemClick(Sender: TObject);

  public
    ser: TBlockSerial;
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }


procedure TForm1.FormCreate(Sender: TObject);
var
  sl: TStringList;
  i: integer;
  bf: TBaudForm;
  baud: integer;
begin
  bf := TBaudForm.Create(self);
  bf.ShowModal;

  baud := StrToInt(bf.ComboBox1.Text);

  bf.Free;

  for i := 0 to Length(SubMenuItemArray) - 1 do begin
    SubMenuItemArray[i] := TMenuItem.Create(Self);
    with SubMenuItemArray[i] do begin
      Caption := '<CTRL+' + char(i + 64) + '>';
      Tag := i;
      OnClick := @MenuItemClick;
    end;
    MenuItem1.Insert(i, SubMenuItemArray[i]);
  end;


  ComboBox1.Items.CommaText := GetSerialPortNames;

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
  Sleep(1000);
  Timer1.Interval := 100;
  Timer1.Enabled := True;

  Memo1.DoubleBuffered := True;

end;

procedure TForm1.MenuItem2Click(Sender: TObject);
begin
  InputForm.Show;
end;

procedure TForm1.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  Timer1.Enabled := False;
  ser.Free;
end;


procedure TForm1.Button1Click(Sender: TObject);
begin
  ser.SendBuffer(Pointer(Edit1.Text), Length(Edit1.Text));
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  Memo1.Clear;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
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

procedure TForm1.MenuItemClick(Sender: TObject);
begin
  Caption := IntToStr(TMenuItem(Sender).Tag);
  ser.SendByte(TMenuItem(Sender).Tag);
end;

end.
