program wordclocksim;
{$MODE OBJFPC}
{$H+}
{$MEMORY 20000,20000}
uses
  pico_spi_c,
  st7789_spi_c,
  CustomDisplay,
  pico_gpio_c,
  pico_timer_c,
  pico_c,
  Fonts.BitstreamVeraSansMono13x24;
const
  clockface : array [0..9] of array[0..10] of char =
    (
      ('I','T','K','I','S','G','H','A','L','F','E'),
      ('T','E','N','Y','Q','U','A','R','T','E','R'),
      ('D','T','W','E','N','T','Y','F','I','V','E'),
      ('T','O','P','A','S','T','E','F','O','U','R'),
      ('F','I','V','E','T','W','O','N','I','N','E'),
      ('T','H','R','E','E','T','W','E','L','V','E'),
      ('B','E','L','E','V','E','N','O','N','E','S'),
      ('S','E','V','E','N','W','E','I','G','H','T'),
      ('I','T','E','N','S','I','X','T','I','E','S'),
      ('T','I','N','E','O','I','C','L','O','C','K')
    );
type
  timeSlice = record
    index,row,column,len : byte;
  end;
const
  hours : array of timeSlice =
    (
      (index: 0;row: 5;column:5;len:6), // Twelve
      (index: 1;row: 6;column:7;len:3), // One
      (index: 2;row: 4;column:4;len:3), // Two
      (index: 3;row: 5;column:0;len:5), // Three
      (index: 4;row: 3;column:7;len:4), // Four
      (index: 5;row: 4;column:0;len:4), // Five
      (index: 6;row: 8;column:4;len:3), // Six
      (index: 7;row: 7;column:0;len:5), // Seven
      (index: 8;row: 7;column:6;len:5), // Eight
      (index: 9;row: 4;column:7;len:4), // Nine
      (index:10;row: 8;column:1;len:3), // Ten
      (index:11;row: 6;column:1;len:6) // Eleven
    );

  minutes : array of timeSlice =
    (
      (index: 0;row:9;column:4;len:1), // O
      (index: 0;row:9;column:6;len:5), // CLOCK

      (index: 5;row: 2;column:7;len:4), // FIVE
      (index: 5;row: 3;column:2;len:4), // PAST

      (index:10;row: 1;column:0;len:3), // TEN
      (index:10;row: 3;column:2;len:4), // PAST

      (index:15;row: 0;column:7;len:1), // A
      (index:15;row: 1;column:4;len:7), // QUARTER
      (index:15;row: 3;column:2;len:4), // PAST

      (index:20;row: 2;column:1;len:6), // TWENTY
      (index:20;row: 3;column:2;len:4), // PAST

      (index:25;row: 2;column:1;len:6), // TWENTY
      (index:25;row: 2;column:7;len:4), // FIVE
      (index:25;row: 3;column:2;len:4), // PAST

      (index:30;row: 0;column:6;len:4), // HALF
      (index:30;row: 3;column:2;len:4), // PAST

      (index:35;row: 2;column:1;len:6), // TWENTY
      (index:35;row: 2;column:7;len:4), // FIVE
      (index:35;row: 3;column:0;len:2), // TO

      (index:40;row: 2;column:1;len:6), // TWENTY
      (index:40;row: 3;column:0;len:2), // TO

      (index:45;row: 0;column:7;len:1), // A
      (index:45;row: 1;column:4;len:7), // QUARTER
      (index:45;row: 3;column:0;len:2), // TO

      (index:50;row: 1;column:0;len:3), // TEN
      (index:50;row: 3;column:0;len:2), // TO

      (index:55;row: 2;column:7;len:4), // FIVE
      (index:55;row: 3;column:0;len:2)  // TO

      );

var
  tft : Tst7789_SPI;
  lastHour,lastMinute : byte;

procedure drawHour(Hour,Minute:byte);
var
  column : byte;
begin
  if Minute >=35 then
    inc(Hour);
  Hour := Hour mod 12;
  if lastHour = Hour then
    exit;
  for column := hours[hour].column to hours[hour].column + hours[hour].len-1 do
    tft.drawText(clockface[hours[hour].row][column],9+column*21,hours[hour].row*24,clWhite);
  for column := hours[lastHour].column to hours[lastHour].column + hours[lastHour].len-1 do
    tft.drawText(clockface[hours[lastHour].row][column],9+column*21,hours[lastHour].row*24,$202020);
  lastHour := hour;
end;

procedure drawMinute(Minute:byte);
var
  canDelete : boolean;
  column : byte;
  i,j,count : byte;
  drawed : array[0..2] of word;
begin
  Minute := (Minute div 5) * 5;
  if lastMinute = Minute then
    exit;
  count := 0;
  drawed[0] := $ffff;
  drawed[1] := $ffff;
  drawed[2] := $ffff;
  for i := low(minutes) to high(minutes) do
  begin
    if minutes[i].index = Minute then
    begin
      for column := minutes[i].column to minutes[i].column + minutes[i].len-1 do
        tft.drawText(clockface[minutes[i].row][column],9+column*21,minutes[i].row*24,clWhite);
      drawed[count] := minutes[i].column + (minutes[i].row shl 4) + (minutes[i].len shl 8);
      inc(count);
    end;
  end;
  for i := low(minutes) to high(minutes) do
  begin
    if minutes[i].index = lastMinute then
    begin
      canDelete := true;
      for j := 0 to count-1 do
      begin
        if minutes[i].column + (minutes[i].row shl 4)  + (minutes[i].len shl 8) = drawed[j] then
          canDelete := false;
        if minutes[i].column + (minutes[i].row shl 4) = drawed[j] and $ff then
        begin
          if drawed[j] shr 8 > minutes[i].len then
            canDelete := false;
          if drawed[j] shr 8 < minutes[i].len then
          begin
            for column := minutes[i].column + (drawed[j] shr 8) to minutes[i].column + minutes[i].len-1 do
              tft.drawText(clockface[minutes[i].row][column],9+column*21,minutes[i].row*24,$202020);
            canDelete := false;
          end;
        end;
      end;
      if canDelete = true then
        for column := minutes[i].column to minutes[i].column + minutes[i].len-1 do
          tft.drawText(clockface[minutes[i].row][column],9+column*21,minutes[i].row*24,$202020);
    end;
  end;
  lastMinute := Minute;
end;
var
  row,column,hour,minute,i : integer;
begin
  gpio_init(TPicoPin.LED);
  gpio_set_dir(TPicoPin.LED,TGPIODirection.GPIO_OUT);

  spi_init(spi,20000000);
  gpio_set_function(TPicoPin.SPI_CS,  TGPIOFunction.GPIO_FUNC_SPI);
  gpio_set_function(TPicoPin.SPI_SCK, TGPIOFunction.GPIO_FUNC_SPI);
  gpio_set_function(TPicoPin.SPI_TX,  TGPIOFunction.GPIO_FUNC_SPI);

  tft.Initialize(spi,TPicoPin.GP16,TPicoPin.GP14,tft.ScreenSize240x240x16);
  tft.setFontInfo(BitstreamVeraSansMono13x24);

  tft.ForegroundColor := $808080;
  tft.BackgroundColor := clBlack;
  tft.SetRotation(TDisplayRotation.None);
  tft.ClearScreen;
  for row := 0 to 9 do
    for column := 0 to 10 do
    begin
      tft.drawText(clockface[row][column],9+column*21,row*24,$202020);
    end;
  tft.drawText(clockface[0][0],9+0*21,0,clWhite);
  tft.drawText(clockface[0][1],9+1*21,0,clWhite);
  tft.drawText(clockface[0][3],9+3*21,0,clWhite);
  tft.drawText(clockface[0][4],9+4*21,0,clWhite);

  repeat
    gpio_put(TPicoPin.LED,true);
    lastHour := 23;
    lastMinute := 55;
    repeat
      for hour := 0 to 23 do
      begin
        for minute := 0 to 59 do
        begin
          drawHour(hour,minute);
          drawMinute(minute);
          busy_wait_us(300000);
        end;
      end;
    until 1=0;
  until 1=0;
end.
