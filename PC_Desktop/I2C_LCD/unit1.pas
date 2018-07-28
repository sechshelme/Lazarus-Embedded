unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls, PairSplitter, ComCtrls, BaseUnix, I2C, I2C_LCD, I2CEEPROM, Types;

type

  { TForm1 }

  TForm1 = class(TForm)
    BackLight: TToggleBox;
    Blink: TToggleBox;
    Button1: TButton;
    BtnSendEEPROM: TButton;
    BtnLoadEEPROM: TButton;
    Clear: TButton;
    Display: TToggleBox;
    HelloWorldBtn: TButton;
    Home: TButton;
    LCDCursor: TToggleBox;
    LeftBtn: TButton;
    Memo1: TMemo;
    Memo2: TMemo;
    PageControl1: TPageControl;
    RightBtn: TButton;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    procedure BtnLoadEEPROMClick(Sender: TObject);
    procedure BtnSendEEPROMClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BlinkChange(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure HelloWorldBtnClick(Sender: TObject);
    procedure DisplayChange(Sender: TObject);
    procedure HomeClick(Sender: TObject);
    procedure ClearClick(Sender: TObject);
    procedure LCDCursorChange(Sender: TObject);
    procedure BackLightChange(Sender: TObject);
    procedure LeftBtnClick(Sender: TObject);
    procedure RightBtnClick(Sender: TObject);
  private
    I2C: TI2C;
    LCD: TLCD;
    EEPROM0: TI2CEEPROM;
  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}


{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
const
  herz: TCharMap = (%00000, %01010, %11111, %11111, %01110, %00100, %00000, %00000);
var
  i: integer;
begin
  I2C := TI2C.Create('/dev/i2c-1');
  LCD := TLCD.Create(I2C, $3F);
  LCD.Clear;

  LCD.createChar(3, herz);
  LCD.setCursor(0, 0);
  LCD.Write(#3 + ' Hello I²C ' + #3);
  //    lcd.leftToRight(false);

  EEPROM0 := TI2CEEPROM.Create(I2C, $54);

  Memo1.Clear;
  for i := 0 to 10 do begin
    Memo1.Lines.Add('Hello World ' + IntToStr(i));
  end;

end;

procedure TForm1.Button1Click(Sender: TObject);
const
  herz2: TCharMap = (%10001, %01010, %11111, %11111, %01110, %00100, %00000, %00000);
begin
  LCD.createChar(3, herz2);
end;

procedure TForm1.BtnSendEEPROMClick(Sender: TObject);
begin
  EEPROM0.Position := 0;
  EEPROM0.WriteString(Memo1.Text);
  EEPROM0.WriteString('handschuh !');
end;

procedure TForm1.BtnLoadEEPROMClick(Sender: TObject);
begin
  EEPROM0.Position := 0;
  Memo2.Text := EEPROM0.ReadString;
  Memo2.Lines.Add(EEPROM0.ReadString);
end;

procedure TForm1.HelloWorldBtnClick(Sender: TObject);
begin
  LCD.setCursor(0, 0);
  //  LCD.Autoscroll(true);
  LCD.Write(#3' Hello World '#3);
  LCD.setCursor(5, 1);
  LCD.Write('Lazarus');
end;

procedure TForm1.BlinkChange(Sender: TObject);
begin
  LCD.blink(Blink.Checked);
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  EEPROM0.Free;
  LCD.Free;
  I2C.Free;
end;

procedure TForm1.DisplayChange(Sender: TObject);
begin
  LCD.display(Display.Checked);
end;

procedure TForm1.HomeClick(Sender: TObject);
begin
  LCD.home;
  LCD.Write('home');
end;

procedure TForm1.ClearClick(Sender: TObject);
begin
  LCD.Clear;
end;

procedure TForm1.LCDCursorChange(Sender: TObject);
begin
  LCD.cursor(LCDCursor.Checked);
end;

procedure TForm1.BackLightChange(Sender: TObject);
begin
  LCD.backlight(BackLight.Checked);
end;

procedure TForm1.LeftBtnClick(Sender: TObject);
begin
  LCD.scrollDisplayLeft;
end;

procedure TForm1.RightBtnClick(Sender: TObject);
begin
  LCD.scrollDisplayRight;
end;

end.
