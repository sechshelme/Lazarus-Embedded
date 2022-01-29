unit ST7735_spi_c;
{$mode objfpc}
{$H+}
{$modeswitch advancedrecords}
{$SCOPEDENUMS ON}


interface
uses
  CustomDisplay,
  CustomDisplay16Bits,
  pico_timer_c,
  pico_gpio_c,
  pico_spi_c,
  pico_c;

type
  TST7735_SPI = object(TCustomDisplay16Bits)
    private
      FpSPI : ^TSPI_Registers;
      FPinDC : TPinIdentifier;
      FPinRST : TPinIdentifier;
      FInTransaction : boolean;
    protected
      procedure WriteCommand(const command : byte); virtual;
      procedure WriteCommandBytes(const command : byte; constref data : array of byte; Count:longInt=-1); virtual;
      procedure WriteCommandWords(const command : byte; constref data : array of word; Count:longInt=-1); virtual;
      procedure WriteData(const data: byte); virtual;
      procedure WriteDataBytes(constref data : array of byte; Count:longInt=-1); virtual;
      procedure WriteDataWords(constref data : array of word; Count:longInt=-1); virtual;
      procedure InitSequence;
    public
      const
        // Physical Width is up to 128 Pixel Physical Height goes up to 160 Pixel
        ScreenSize80x160x16: TPhysicalScreenInfo =
          (Width:  80; Height: 160; Depth: TDisplayBitDepth.SixteenBits;ColorOrder: TDisplayColorOrder.BGR;ColStart : (26,1,26,1); RowStart : (1,26,1,26));
        ScreenSize128x128x16: TPhysicalScreenInfo =
          (Width: 128; Height: 128; Depth: TDisplayBitDepth.SixteenBits;ColorOrder: TDisplayColorOrder.BGR;ColStart : (3,2,1,2); RowStart : (2,3,2,1));
        ScreenSize128x160x16RGB: TPhysicalScreenInfo =
          (Width: 128; Height: 160; Depth: TDisplayBitDepth.SixteenBits;ColorOrder: TDisplayColorOrder.RGB;ColStart : (0,0,0,0); RowStart : (0,0,0,0));

    (*
      Initializes the display
    param
      SPI     The SPI Interface to use
      aPinDC  Pin used for switching between Communication between Data and Command Mode
      aPinRST Pin used to reset the display, not needed by all displays, pass TNativePin.None when not needed
      aPhysicalScreenInfo Information about Width/Height and Bitdepth of the connected screen
    note
      The SPI interface needs to be pre-initialized to required Parameters
      The extra Pins do not need to be initialized
    *)
    constructor Initialize(var SPI : TSpi_Registers;const aPinDC : TPinIdentifier;const aPinRST : TPinIdentifier;aPhysicalScreenInfo : TPhysicalScreenInfo);

    (*
      Sets the rotation of a display in steps of 90 Degrees.
      Usefull when you have no control on how the display is mounted.
    param:
      displayRotation
    *)
    procedure setRotation(const DisplayRotation : TDisplayRotation); virtual;

    (*
      Sets the active drawing area and switches to data mode
    param:
      X,Y Top Left coordinate of paint Area
      Width, Height: Width and Height of Drawing Area
    return:
      Returns the number of Pixels that are included in the Area
    *)
    function setDrawArea(const X,Y,Width,Height : word):longWord; virtual;

    (*
      Sets a single Pixel on the display by drawing currently selected ForegroundColor or provided color
    param:
      x,y : Position of the pixel
      color: Color of the Pixel
    note:
      Drawing single pixel creates a relatively high overhead, so do not overdo single pixel paining
    *)
    procedure drawPixel(const x,y : word; const fgColor : TColor = clForeground); virtual;
  end;

implementation
const
  ST7735_MADCTL_MY =  $80;
  ST7735_MADCTL_MX =  $40;
  ST7735_MADCTL_MV =  $20;
  ST7735_MADCTL_ML =  $10;
  ST7735_MADCTL_MH =  $04;
  ST7735_MADCTL_RGB = $00;
  ST7735_MADCTL_BGR = $08;

  ST7735_NOP     =$00;
  ST7735_SWRESET =$01;
  ST7735_RDDID   =$04;
  ST7735_RDDST   =$09;

  ST7735_SLPIN   =$10;
  ST7735_SLPOUT  =$11;
  ST7735_PTLON   =$12;
  ST7735_NORON   =$13;

  ST7735_INVOFF  =$20;
  ST7735_INVON   =$21;
  ST7735_DISPOFF =$28;
  ST7735_DISPON  =$29;
  ST7735_CASET   =$2A;
  ST7735_RASET   =$2B;
  ST7735_RAMWR   =$2C;
  ST7735_RAMRD   =$2E;

  ST7735_PTLAR   =$30;
  ST7735_COLMOD  =$3A;
  ST7735_MADCTL  =$36;

  ST7735_FRMCTR1 =$B1;
  ST7735_FRMCTR2 =$B2;
  ST7735_FRMCTR3 =$B3;
  ST7735_INVCTR  =$B4;
  ST7735_DISSET5 =$B6;

  ST7735_PWCTR1  =$C0;
  ST7735_PWCTR2  =$C1;
  ST7735_PWCTR3  =$C2;
  ST7735_PWCTR4  =$C3;
  ST7735_PWCTR5  =$C4;
  ST7735_VMCTR1  =$C5;

  ST7735_RDID1   =$DA;
  ST7735_RDID2   =$DB;
  ST7735_RDID3   =$DC;
  ST7735_RDID4   =$DD;
  ST7735_PWCTR6  =$FC;

  ST7735_GMCTRP1 =$E0;
  ST7735_GMCTRN1 =$E1;

constructor TST7735_SPI.Initialize(var SPI : TSpi_Registers;const aPinDC : TPinIdentifier;const aPinRST : TPinIdentifier;aPhysicalScreenInfo : TPhysicalScreenInfo);
begin
    FpSPI := @SPI;
    FPinDC := aPinDC;
    FPinRST := aPinRST;
    PhysicalScreenInfo :=  aPhysicalScreenInfo;

    if APinDC > -1 then
    begin
      gpio_init(APinDC);
      gpio_set_dir(APinDC,TGPIODirection.GPIO_OUT);
      gpio_put(APinDC,false);
    end;
    if APinRST > -1 then
    begin
      gpio_init(APinRST);
      gpio_set_dir(APinRST,TGPIODirection.GPIO_OUT);
      gpio_put(APinRST,true);
    end;
    InitSequence;
end;

procedure TST7735_SPI.InitSequence;
const
  col1 : array of byte = ($09,$16,$09,$20,$21,$1B,$13,$19,$17,$15,$1E,$2B,$04,$05,$02,$0E);
  col2 : array of byte = ($0B,$14,$08,$1E,$22,$1D,$18,$1E,$1B,$1A,$24,$2B,$06,$06,$02,$0F);
begin
  WriteCommand(ST7735_SWRESET);
  busy_wait_us_32(50000);

  writecommand(ST7735_SLPOUT);   // Sleep out
  busy_wait_us_32(500000);

  writeCommandBytes(ST7735_COLMOD,[$05]);
  busy_wait_us_32(10000);

  writeCommandBytes(ST7735_FRMCTR1,[$00,$06,$03]);
  busy_wait_us_32(10000);

  writeCommandBytes(ST7735_MADCTL,[$40+ST7735_MADCTL_BGR]);
  writeCommandBytes(ST7735_DISSET5,[$15,$02]);
  writeCommandBytes(ST7735_INVCTR,[$00]);
  writeCommandBytes(ST7735_PWCTR1,[$02,$70]);
  busy_wait_us_32(10000);
  writeCommandBytes(ST7735_PWCTR2,[$05]);
  writeCommandBytes(ST7735_PWCTR3,[$01,$02]);
  writeCommandBytes(ST7735_VMCTR1,[$3C,$38]);
  busy_wait_us_32(10000);
  writeCommandBytes(ST7735_PWCTR6,[$11,$15]);
  writeCommandBytes(ST7735_GMCTRP1,col1);
  writeCommandBytes(ST7735_GMCTRP1,col2);
  busy_wait_us_32(10000);

  writeCommandWords(ST7735_CASET,[2,129]);    // Column address set
  writeCommandWords(ST7735_RASET,[2,129]);    // Row address set

  writeCommand(ST7735_NORON);    // Normal display mode on
  writeCommand(ST7735_INVON);
  busy_wait_us_32(120000);
  writeCommand(ST7735_DISPON);    //Display on
  busy_wait_us_32(120000);
  setRotation(TDisplayRotation.None);
  foregroundColor := clBlack;
  backgroundColor := clWhite;
end;

procedure TST7735_SPI.setRotation(const displayRotation : TDisplayRotation);
var
  ColMode : byte;
begin
  colStart := PhysicalScreenInfo.ColStart[byte(displayRotation)];
  rowStart := PhysicalScreenInfo.RowStart[byte(displayRotation)];
  if PhysicalScreenInfo.ColorOrder = TDisplayColorOrder.RGB then
    colMode := ST7735_MADCTL_RGB
  else
    colMode := ST7735_MADCTL_BGR;
  case displayRotation of
    TDisplayRotation.None:
    begin
      FScreenWidth := PhysicalScreenInfo.Width;
      FScreenHeight := PhysicalScreenInfo.Height;
      WriteCommandBytes(ST7735_MADCTL,[ST7735_MADCTL_MX + ST7735_MADCTL_MY + colMode]);
    end;
    TDisplayRotation.Right: begin
      FScreenWidth := PhysicalScreenInfo.Height;
      FScreenHeight := PhysicalScreenInfo.Width;
      WriteCommandBytes(ST7735_MADCTL,[ST7735_MADCTL_MY + ST7735_MADCTL_MV + colMode]);
    end;
    TDisplayRotation.UpsideDown:
    begin
      FScreenWidth := PhysicalScreenInfo.Width;
      FScreenHeight := PhysicalScreenInfo.Height;
      WriteCommandBytes(ST7735_MADCTL,[colMode]);
    end;
    TDisplayRotation.Left: begin
      FScreenWidth := PhysicalScreenInfo.Height;
      FScreenHeight := PhysicalScreenInfo.Width;
      WriteCommandBytes(ST7735_MADCTL,[ST7735_MADCTL_MX + ST7735_MADCTL_MV + colMode]);
    end;
  end;
end;

function TST7735_SPI.setDrawArea(const X,Y,Width,Height : word):longWord;
begin
  {$PUSH}
  {$WARN 4079 OFF}
  Result := 0;
  WriteCommandWords(ST7735_CASET,[X+rowStart,X+rowStart+Width-1]);
  WriteCommandWords(ST7735_RASET,[Y+colStart,Y+colStart+Height-1]);
  WriteCommand(ST7735_RAMWR);
  Result := Width*Height;
  {$POP}
end;

procedure TST7735_SPI.drawPixel(const x,y : word; const fgColor : TColor = clForeground);
var
  _fgColor : word;
begin
  if (x >= ScreenWidth) or (y >= ScreenHeight) then
    exit;
  WriteCommandWords(ST7735_CASET,[X+rowStart,X+rowStart]);
  WriteCommandWords(ST7735_RASET,[Y+colStart,Y+colStart]);
  WriteCommand(ST7735_RAMWR);
  _fgColor := color24to16(fgColor);
  WriteData(hi(_fgColor));
  WriteData(lo(_fgColor));
end;

procedure TST7735_SPI.WriteCommand(const command: Byte);
var
  data: array[0..0] of byte;
begin
  data[0] := command;
  gpio_put(FPinDC,false);
  spi_write_blocking(FpSPI^,data,1);
  gpio_put(FPinDC,true);
end;

procedure TST7735_SPI.WriteCommandBytes(const command : byte; constref data : array of byte; Count:longInt=-1);
var
  _data : array[0..0] of byte;
begin
  if count = -1 then
    count := High(data)+1;
  _data[0]:= command;
  gpio_put(FPinDC,false);
  spi_write_blocking(FpSPI^,_data,1);
  gpio_put(FPinDC,true);
  spi_write_blocking(FpSPI^,data,count);
end;

procedure TST7735_SPI.WriteCommandWords(const command : byte; constref data : array of word; Count:longInt=-1);
var
  _data : array[0..0] of byte;
begin
  if count = -1 then
    count := High(data)+1;
  _data[0]:= command;
  gpio_put(FPinDC,false);
  spi_write_blocking(FpSPI^,_data,1);
  gpio_put(FPinDC,true);
  spi_write_blocking_hl(FpSPI^,data,count);
end;

procedure TST7735_SPI.WriteData(const data: byte);
var
  _data : array[0..0] of byte;
begin
  _data[0] := data;
  gpio_put(FPinDC,true);
  spi_write_blocking(FpSPI^,_data,1);
end;

procedure TST7735_SPI.WriteDataBytes(constref data: array of byte;Count:longInt=-1);
begin
  if count = -1 then
    count := High(data)+1;
  gpio_put(FPinDC,true);
  spi_write_blocking(FpSPI^,data,count);
end;

procedure TST7735_SPI.WriteDataWords(constref data: array of word;Count:longInt=-1);
begin
  if count = -1 then
    count := High(data)+1;
  gpio_put(FPinDC,true);
  spi_write_blocking_hl(FpSPI^,data,count);
end;

{$WARN 5028 OFF}
begin
end.
