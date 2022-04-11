unit ssd1306_i2c_c;
{$MODE OBJFPC}
{$H+}

interface
uses
  CustomDisplay,
  CustomDisplayFrameBuffer1Bit,
  pico_i2c_c,
  pico_gpio_c,
  pico_timer_c,
  pico_c;
const
  ScreenSize128x64x1: TPhysicalScreenInfo =
    (Width: 128; Height: 64; Depth: TDisplayBitDepth.OneBit;ColorOrder: TDisplayColorOrder.BW;ColStart : (0,0,0,0); RowStart : (0,0,0,0));
  ScreenSize128x32x1: TPhysicalScreenInfo =
    (Width: 128; Height: 32; Depth: TDisplayBitDepth.OneBit;ColorOrder: TDisplayColorOrder.BW;ColStart : (0,0,0,0); RowStart : (0,0,0,0));
  ScreenSize96x16x1: TPhysicalScreenInfo =
    (Width: 96; Height: 16; Depth: TDisplayBitDepth.OneBit;ColorOrder: TDisplayColorOrder.BW;ColStart : (0,0,0,0); RowStart : (0,0,0,0));
  ScreenSize64x48x1: TPhysicalScreenInfo =
    (Width: 64; Height: 48; Depth: TDisplayBitDepth.OneBit;ColorOrder: TDisplayColorOrder.BW;ColStart : (0,0,0,0); RowStart : (0,0,0,0));

type
  TSSD1306_I2C = object(TCustomDisplayFrameBuffer1Bit)
    private
      FpI2C : ^TI2C_Inst;
      FPinRST : TPinIdentifier;
      FDisplayAddress : byte;
      FExternalVCC : boolean;
    protected
      procedure WriteCommand(const command : byte); virtual;
      procedure WriteCommandBytes(const command:byte; constref param : array of byte; Count:longInt=-1); virtual;
      procedure WriteCommandWords(const command:byte; constref param : array of word; Count:longInt=-1); virtual;
      procedure WriteData(const data: byte); virtual;
      procedure WriteDataBytes(constref data : array of byte; Count:longInt=-1); virtual;
      procedure WriteDataWords(constref data : array of word; Count:longInt=-1); virtual;
      procedure InitSequence;
      function setDrawArea(const X,Y,Width,Height : word):longWord; virtual;
  public
    constructor Initialize(var I2C : TI2C_Inst;const aDisplayAddress : byte;const aPinRST : TPinIdentifier;aScreenInfo : TPhysicalScreenInfo);
    procedure Reset;
  end;

implementation
const
  CMD_SET_LOW_COLUMN = $00;
  CMD_EXTERNAL_VCC = $01;
  CMD_SWITCH_CAP_VCC = $02;
  CMD_SET_HIGH_COLUMN = $10;

  CMD_MEMORY_MODE = $20;
  CMD_COLUMN_ADDRESS = $21;
  CMD_PAGE_ADDRESS   = $22;
  CMD_RIGHT_HORIZONTAL_SCROLL = $26;
  CMD_LEFT_HORIZONTAL_SCROLL = $27;
  CMD_VERTICAL_AND_RIGHT_HORIZONTAL_SCROLL = $29;
  CMD_VERTICAL_AND_LEFT_HORIZONTAL_SCROLL = $2A;
  CMD_DEACTIVATE_SCROLL = $2E;
  CMD_ACTIVATE_SCROLL = $2F;
  CMD_SET_START_LINE = $40;
  CMD_SET_CONTRAST = $81;
  CMD_CHARGE_PUMP = $8D;
  CMD_SEGMENT_REMAP = $A0;
  CMD_SET_VERTICAL_SCROLL_AREA = $A3;
  CMD_DISPLAY_ALL_ON_RESUME = $A4;
  CMD_DISPLAY_ALL_ON =$A5;
  CMD_NORMAL_DISPLAY = $A6;
  CMD_INVERT_DISPLAY = $A7;
  CMD_SET_MULTIPLEX_RATIO = $A8;
  CMD_DISPLAY_OFF = $AE;
  CMD_DISPLAY_ON = $AF;
  CMD_SET_PAGE_START = $B0;
  CMD_COM_SCAN_INC = $C0;
  CMD_COM_SCAN_DEC = $C8;
  CMD_SET_DISPLAY_OFFSET = $D3;
  CMD_SET_DISPLAY_CLOCK_DIV = $D5;
  CMD_SET_PRECHARGE = $D9;
  CMD_SET_COM_PINS = $DA;
  CMD_SET_VCOM_DETECT = $DB;
  CMD_NOP = $E3;

procedure TSSD1306_I2C.InitSequence;
begin
  FExternalVCC := false;
  //Set Display off
  WriteCommand(CMD_DISPLAY_OFF);

  // Set Display Clock Divide Ratio / OSC Frequency
  WriteCommandBytes(CMD_SET_DISPLAY_CLOCK_DIV,[$80]);

  // Set Multiplex Ratio
  WriteCommandBytes(CMD_SET_MULTIPLEX_RATIO,[PhysicalScreenInfo.Height-1]);

  // Set Display Offset
  WriteCommandBytes(CMD_SET_DISPLAY_OFFSET,[$00]);

  // Set Display Start Line
  WriteCommand(CMD_SET_START_LINE or $00);

  // Set Charge Pump
  if FExternalVCC then
    WriteCommandBytes(CMD_CHARGE_PUMP,[$10])
  else
    WriteCommandBytes(CMD_CHARGE_PUMP,[$14]);

  WriteCommandBytes(CMD_MEMORY_MODE,[$00]);

  // Set Segment Re-Map
  WriteCommand(CMD_SEGMENT_REMAP or $01);

  // Set Com Output Scan Direction
  WriteCommand(CMD_COM_SCAN_DEC);

  // Set COM Hardware Configuration
  if (PhysicalScreenInfo = ScreenSize128x32x1) then
  begin
    WriteCommandBytes(CMD_SET_COM_PINS,[$02]);
    WriteCommandBytes(CMD_SET_CONTRAST,[$8F])
  end
  else if (PhysicalScreenInfo = ScreenSize128x64x1) then
  begin
    WriteCommandBytes(CMD_SET_COM_PINS,[$12]);
    if FExternalVCC then
      WriteCommandBytes(CMD_SET_CONTRAST,[$9F])
    else
      WriteCommandBytes(CMD_SET_CONTRAST,[$CF]);
  end
  else if (PhysicalScreenInfo = ScreenSize96x16x1) then
  begin
    WriteCommandBytes(CMD_SET_COM_PINS,[$02]);
    if FExternalVCC then
      WriteCommandBytes(CMD_SET_CONTRAST,[$10])
    else
      WriteCommandBytes(CMD_SET_CONTRAST,[$AF]);
  end;

   // Set Pre-Charge Period
  if FExternalVCC then
    WriteCommandBytes(CMD_SET_PRECHARGE,[$22])
  else
    WriteCommandBytes(CMD_SET_PRECHARGE,[$F1]);

  // Set VCOMH Deselect Level
  WriteCommandBytes(CMD_SET_VCOM_DETECT,[$40]);

  // Set all pixels OFF
  WriteCommand(CMD_DISPLAY_ALL_ON_RESUME);

  // Set display not inverted
  WriteCommand(CMD_NORMAL_DISPLAY);
  WriteCommand(CMD_DEACTIVATE_SCROLL);
  // Set display On
  WriteCommand(CMD_DISPLAY_ON);
  Rotation := TDisplayRotation.None;
end;

function TSSD1306_I2C.setDrawArea(const X,Y,Width,Height : word):longWord;
begin
  {$PUSH}
  {$WARN 4079 OFF}
  Result := 0;
  if (X >=PhysicalScreenInfo.Width) or (Y >=PhysicalScreenInfo.Height) then
    exit;

  //if X+Width >PhysicalScreenInfo.Width then
  //  Width := PhysicalScreenInfo.Width-X;
  //if Y+Height > PhysicalScreenInfo.Height then
  //  Height := PhysicalScreenInfo.Height-Y;

  WriteCommandBytes(CMD_MEMORY_MODE,[$01]);
  WriteCommandBytes(CMD_PAGE_ADDRESS,[Y shr 3,(Word(Y+Height-1) shr 3)]);
  WriteCommandBytes(CMD_COLUMN_ADDRESS,[X,Word(X+Width-1)]);
  Result := Width*Height shr 3;
  {$POP}
end;

constructor TSSD1306_I2C.Initialize(var I2C : TI2C_Inst;const aDisplayAddress : byte;const aPinRST : TPinIdentifier;aScreenInfo : TPhysicalScreenInfo);
begin
  inherited Initialize;
  enableI2CHack;
  FpI2C := @I2C;
  FDisplayAddress := aDisplayAddress;
  FPinRST := aPinRST;
  PhysicalScreenInfo :=  aScreenInfo;
  BackgroundColor := clBlack;
  ForegroundColor := clWhite;

  if aPinRST > -1 then
  begin
    gpio_init(aPinRST);
    gpio_set_dir(aPinRST,TGPIODirection.GPIO_OUT);
    gpio_put(aPinRST,true);
  end;
  initSequence;
end;

procedure TSSD1306_I2C.Reset;
begin
  if FPinRST > -1 then
  begin
    gpio_put(FPinRST,true);
    busy_wait_us_32(100000);
    gpio_put(FPinRST,false);
    busy_wait_us_32(100000);
    gpio_put(FPinRST,true);
    busy_wait_us_32(200000);
  end;
end;

procedure TSSD1306_I2C.WriteCommand(const command: Byte);
var
  data : array[0..1] of byte;
begin
  data[0]:= $80;
  data[1]:= command;
  i2c_write_blocking(FpI2C^,FDisplayAddress,data,2,false);
end;

procedure TSSD1306_I2C.WriteCommandBytes(const command:byte; constref param : array of byte; Count:longInt=-1);
var
  data : array[0..8] of byte;
  i : integer;
begin
  if count = -1 then
    count := High(data)+1;
  data[0]:= $80;
  data[1]:= command;
  i2c_write_blocking(FpI2C^,FDisplayAddress,data,2,false);
  for i := 1 to count do
    data[i]:= param[i-1];
  i2c_write_blocking(FpI2C^,FDisplayAddress,data,count,false);
end;

procedure TSSD1306_I2C.WriteCommandWords(const command:byte; constref param : array of word; Count:longInt=-1);
begin

end;

procedure TSSD1306_I2C.WriteData(const data: byte);
var
  _data : array[0..1] of byte;
begin
  _data[0] := $40;
  _data[1] := data;
  i2c_write_blocking(FpI2C^,FDisplayAddress,_data,2,false);
end;

procedure TSSD1306_I2C.WriteDataBytes(constref data: array of byte;Count:longInt=-1);
begin
  if count = -1 then
    count := High(data)+1;
  i2c_write_blocking(FpI2C^,FDisplayAddress,data,count,false);
end;

procedure TSSD1306_I2C.WriteDataWords(constref data: array of word;Count:longInt=-1);
begin
end;

{$WARN 5028 OFF}
begin
end.
