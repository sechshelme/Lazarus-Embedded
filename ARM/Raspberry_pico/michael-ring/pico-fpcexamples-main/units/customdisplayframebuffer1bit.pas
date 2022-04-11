unit CustomDisplayFrameBuffer1Bit;

{$mode ObjFPC}{$H+}

interface

uses
  CustomDisplay;

type
  TCustomDisplayFrameBuffer1Bit = object(TCustomDisplay)
  private
    FrameBuffer : array of byte;
    i2cHack : byte;
  protected
    procedure enablei2cHack;
  public
    constructor Initialize;
    procedure clearScreen; virtual;
    procedure updateScreen;
    procedure drawPixel(const x,y : word; const fgColor : TColor = clForeground); virtual;
    (*
      Draws a Text on the display
    param:
      TheText The String to draw
      x,y Top left position of string to draw
    *)
    procedure drawText(const TheText : String; const x,y : word; const fgColor : TColor = clForeground; const bgColor : TColor = clTransparent); virtual;
    procedure setRotation(const DisplayRotation : TDisplayRotation); virtual;
    (*
      Draws a vertical line on the display
    param:
      x,y : Start position of the line
      height: height of line in pixels
      fgColor: color to use for painting the line
    *)
    procedure drawFastVLine(const  x, y : word ; height : word; const fgColor : TColor = clForeground); virtual;

    (*
      Draws a horizontal line on the display
    param:
      x,y : Start position of the line
      width: width of line
      fgColor: color to use for painting the line
    *)
    procedure drawFastHLine(const  x, y : word; width : word; const fgColor : TColor = clForeground); virtual;
    procedure fillRect(const x,y,width,height : word; const fgColor : TColor = clForeground); virtual;
    procedure setPhysicalScreenInfo(screenInfo : TPhysicalScreenInfo); virtual;
  end;

implementation
constructor TCustomDisplayFrameBuffer1Bit.Initialize;
begin
  inherited;
  i2cHack := 0;
end;

procedure TCustomDisplayFrameBuffer1Bit.enableI2CHack;
begin
  i2chack := 1;
end;

procedure TCustomDisplayFrameBuffer1Bit.setPhysicalScreenInfo(screenInfo : TPhysicalScreenInfo);
begin
  inherited;
  setLength(FrameBuffer,screenInfo.Width*screenInfo.Height div 8+i2cHack);
end;

procedure TCustomDisplayFrameBuffer1Bit.setRotation(const DisplayRotation : TDisplayRotation);
begin
  FRotation := DisplayRotation;
  if (DisplayRotation = TDisplayRotation.None) or (DisplayRotation = TDisplayRotation.UpsideDown) then
  begin
    FScreenWidth := PhysicalScreenInfo.Width;
    FScreenHeight := PhysicalScreenInfo.Height;
  end
  else
  begin
    FScreenWidth := PhysicalScreenInfo.Height;
    FScreenHeight := PhysicalScreenInfo.Width;
  end;
end;

procedure TCustomDisplayFrameBuffer1Bit.drawFastVLine(const x,y : word; height : word; const fgColor : TColor = clForeground);
var
  i : word;
begin
  for i := y to y + height do
    DrawPixel(x,i,fgColor);
end;

procedure TCustomDisplayFrameBuffer1Bit.drawFastHLine(const x,y : word; width : word; const fgColor : TColor = clForeground);
var
  i : word;
begin
  for i := x to x + width do
    DrawPixel(i,y,fgColor);
end;

procedure TCustomDisplayFrameBuffer1Bit.fillRect(const x,y,width,height : word; const fgColor : TColor = clForeground);
var
  i,j : word;
begin
  for i := x to word(x + width) -1 do
    for j := y to height -1 do
      DrawPixel(i,j,fgColor);
end;


procedure TCustomDisplayFrameBuffer1Bit.clearScreen;
var
  i : integer;
begin
  if BackgroundColor = clBlack then
    for i := Low(FrameBuffer) to High(FrameBuffer) do
      FrameBuffer[i] := 0
  else
    for i := Low(FrameBuffer) to High(FrameBuffer) do
      FrameBuffer[i] := $ff;
end;

procedure TCustomDisplayFrameBuffer1Bit.drawText(const TheText : String; const x,y : word; const fgColor : TColor = clForeground; const bgColor : TColor = clTransparent);
var
  i : longWord;
  charstart,pixelPos : longWord;
  fx,fy : longWord;
  divFactor,pixel,pixels : byte;
begin
  divFactor := 8;
  for i := 1 to length(TheText) do
  begin
    if (x+(i-1)*fontInfo.Width <= ScreenWidth) and (y <= ScreenHeight) then
    begin
      charstart := pos(TheText[i],FontInfo.Charmap)-1;
      if charstart > 0 then
      begin
        for fy := 0 to FontInfo.Height-1 do
        begin
          pixelPos := charStart * fontInfo.BytesPerChar+fy*(fontInfo.BytesPerChar div fontInfo.Height);
          for fx := 0 to FontInfo.width-1 do
          begin
            pixels := FontInfo.pFontData^[pixelPos + (fx div divFactor)];
            pixel := (pixels shr ((7-(fx and %111)))) and %1;
            if (pixel = 1) then
              drawPixel(x+(i-1)*fontInfo.Width+fx,y+fy,fgColor)
            else
              if bgColor <> clTransparent then
                drawPixel(x+(i-1)*fontInfo.Width+fx,y+fy,bgColor);
          end;
        end;
      end
      else
        if bgColor <> clTransparent then
          fillRect(x+(i-1)*fontInfo.Width,y,fontInfo.Width,fontInfo.Height,bgColor);
    end;
  end;
end;

procedure TCustomDisplayFrameBuffer1Bit.drawPixel(const x,y : word; const fgColor : TColor = clForeground);
var
  offset : longWord;
  _x,_y : word;
  _fgColor : TColor;
begin
  if (x >= ScreenWidth) or (y >= ScreenHeight) then
    exit;
  if fgColor = clTransparent then
    exit;
  if Rotation = TDisplayRotation.None then
  begin
    _x := x;
    _y := y;
  end
  else if Rotation = TDisplayRotation.Right then
  begin
    _x := screenWidth - y - 1;
    _y := x;
  end
  else if Rotation = TDisplayRotation.Left then
  begin
    _x := y;
    _y := screenHeight - x - 1;
  end
  else
  begin
    _x := screenWidth - x - 1;
    _y := screenHeight - y - 1;
  end;

  if fgColor = clForeground then
    _fgColor := foregroundColor
  else
    _fgColor := fgColor;


  Offset := (_y div 8)+_x*(ScreenHeight div 8);
  //Offset := _x + (y div 8) * ScreenWidth;
  if _fgColor <> clBlack then
    FrameBuffer[Offset+I2CHack] := FrameBuffer[Offset+I2CHack] or (1 shl (_y and %111))
  else
    FrameBuffer[Offset+I2CHack] := FrameBuffer[Offset+I2CHack] and (not(1 shl (_y and %111)));
end;

procedure TCustomDisplayFrameBuffer1Bit.updateScreen;
begin
  setDrawArea(0,0,PhysicalScreenInfo.Width,PhysicalScreenInfo.Height);
  if I2CHack = 1 then
    FrameBuffer[0] := $40;
  WriteDataBytes(FrameBuffer);
end;

end.

