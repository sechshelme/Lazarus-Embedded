unit CustomDisplay16bits;

{$mode ObjFPC}{$H+}

interface

uses
  CustomDisplay;

type
  TCustomDisplay16Bits = object(TCustomDisplay)
  protected
    (*
      Convert a RGB Value consisting of 8 bits per color to 16Bit Value in 565 format
    *)
    function color24to16(color888:TColor):word;

    (*
      Convert a RGB Value consisting of 8 bits per color to 16Bit Value in 565 format and Swaps High/Low Byte
    *)
    //function color24to16S(color888:TColor):word;

  public
    procedure clearScreen; virtual;

    (*
      Draws a Text on the display
    param:
      TheText The String to draw
      x,y Top left position of string to draw
    *)
    procedure drawText(const TheText : String; const x,y : word; const fgColor : TColor = clForeground; const bgColor : TColor = clTransparent); virtual;

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
  end;

implementation

procedure TCustomDisplay16Bits.drawFastHLine(const x,y : word; width : word; const fgColor : TColor = clForeground);
var
  i : integer;
  _fgColor,_width,_height : word;
  buffer : array[1..320] of word;
begin
  if clipToScreen(x,y,width,1,_width,_height) = false then
    exit;
  if fgColor = clForeground then
    _fgColor := color24to16(foregroundColor)
  else
    _fgColor := color24to16(fgColor);

  setDrawArea(x,y,_width,_height);

  for i := 1 to _width do
    buffer[i] := _fgColor;
  WriteDataWords(buffer,_width);
end;

procedure TCustomDisplay16Bits.drawFastVLine(const x,y : word; height : word; const fgColor : TColor = clForeground);
var
  i : integer;
  _fgColor,_width,_height : word;
  buffer : array[1..320] of word;
begin
  if clipToScreen(x,y,1,height,_width,_height) = false then
    exit;
  if fgColor = clForeground then
    _fgColor := color24to16(foregroundColor)
  else
    _fgColor := color24to16(fgColor);

  setDrawArea(x,y,1,_height);

  for i := 1 to _height do
    buffer[i] := _fgColor;
  WriteDataWords(buffer,_height);
end;

procedure TCustomDisplay16Bits.fillRect(const x,y,width,height : word; const fgColor : TColor = clForeground);
var
  i : word;
  _fgColor,_width,_height : word;
  buffer : array[1..320] of word;
begin
  if clipToScreen(x,y,width,height,_width,_height) = false then
    exit;
  if fgColor = clForeground then
    _fgColor := color24to16(foregroundColor)
  else
    _fgColor := color24to16(fgColor);

  if _width > _height then
  begin
    for i := 1 to _width do
      buffer[i] := _fgColor;
    for i := 0 to _Height -1 do
    begin
      SetDrawArea(x,y,_width,y);
      WriteDataWords(buffer,_width);
    end;
  end
  else
  begin
    for i := 1 to _height do
      buffer[i] := _fgColor;
    for i := 0 to _Width-1 do
    begin
      SetDrawArea(x,y,x,_height);
      WriteDataWords(buffer,_height);
    end;
  end
end;

procedure TCustomDisplay16Bits.clearScreen;
var
  i : integer;
  _bgColor : word;
  buffer : array[1..320] of word;
begin
  _bgColor := color24to16(FBackgroundColor);
  for i := 1 to ScreenWidth do
    buffer[i] := _bgColor;
  SetDrawArea(0,0,ScreenWidth,ScreenHeight);
  for i := 1 to ScreenHeight do
    WriteDataWords(buffer,ScreenWidth);
end;


procedure TCustomDisplay16Bits.drawText(const TheText : String; const x,y : word; const fgColor : TColor = clForeground; const bgColor : TColor = clTransparent);
var
  i,j : longWord;
  charstart,pixelPos : longWord;
  fx,fy : longWord;
  divFactor,pixel,pixels : byte;
  AntialiasColors : array[0..3] of TColor;
begin
  divFactor := 8;
  if FontInfo.BitsPerPixel = 2 then
  begin
    CalculateAntialiasColors(fgColor,bgColor,AntialiasColors);
    divFactor := 4;
  end;
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
            if FontInfo.BitsPerPixel = 2 then
            begin
              pixel := (pixels shr ((3-(fx and %11)) * 2)) and %11;
              if (pixel > 0) then
                drawPixel(x+(i-1)*fontInfo.Width+fx,y+fy,AntialiasColors[pixel])
              else
                if (bgColor <> clTransparent) then
                  drawPixel(x+(i-1)*fontInfo.Width+fx,y+fy,AntialiasColors[0]);
            end
            else
            begin
              pixel := (pixels shr ((7-(fx and %111)))) and %1;
              if (pixel = 1) then
                drawPixel(x+(i-1)*fontInfo.Width+fx,y+fy,fgColor)
              else
                if bgColor <> clTransparent then
                  drawPixel(x+(i-1)*fontInfo.Width+fx,y+fy,bgColor);
            end;
          end;
        end;
      end
      else
        if bgColor <> clTransparent then
          fillRect(x+(i-1)*fontInfo.Width,y,fontInfo.Width,fontInfo.Height,bgColor);
    end;
  end;
end;

function TCustomDisplay16Bits.color24to16(color888:TColor):word;
var
  red,green,blue : byte;
begin
  Red := (color888 shr (16+3)) and $1f;
  Green := (color888 shr (8+2)) and $3f;
  Blue := (color888 shr (0+3)) and $1f;
  //if PhysicalScreenInfo.ColorOrder = TDisplayColorOrder.RGB then
    Result := (Red shl 11) + (Green shl 5) + Blue
  //else
  //  Result := (Blue shl 11) + (Green shl 5) + Red;
end;

(*function TCustomDisplay16Bits.color24to16S(color888:TColor):word;
var
  red,green,blue : byte;
begin
  Red := (color888 shr (16+3)) and $1f;
  Green := (color888 shr (8+2)) and $3f;
  Blue := (color888 shr (0+3)) and $1f;
  Result := (Red shl 11) + (Green shl 5) + Blue;
  Result := (Result shr 8) + (Result shl 8);
end;
*)
end.

