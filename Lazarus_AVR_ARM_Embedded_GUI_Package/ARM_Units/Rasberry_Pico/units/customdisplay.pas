unit CustomDisplay;
{$mode objfpc}
{$H+}
{$modeswitch advancedrecords}
{$SCOPEDENUMS ON}

{
  This file is part of Pascal Microcontroller Board Framework (MBF)
  Copyright (c) 2015 -  Michael Ring
  based on Pascal eXtended Library (PXL)
  Copyright (c) 2000 - 2015  Yuriy Kotsarenko
  Graphics routines based on TFT_eSPI Library
  Copyright (c) 2020 Bodmer (https://github.com/Bodmer)
  Copyright (c) 2012 Adafruit Industries.  All rights reserved.

  This program is free software: you can redistribute it and/or modify it under the terms of the FPC modified GNU
  Library General Public License for more

  This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied
  warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the FPC modified GNU Library General Public
  License for more details.
}
{$WARN 6058 off : Call to subroutine "$1" marked as inline is not inlined}
interface
type
  TColor = -$7FFFFFFF-1..$7FFFFFFF;

const
  clBlack   = TColor($000000);
  clMaroon  = TColor($800000);
  clGreen   = TColor($008000);
  clOlive   = TColor($808000);
  clNavy    = TColor($000080);
  clPurple  = TColor($800080);
  clTeal    = TColor($008080);
  clGray    = TColor($808080);
  clSilver  = TColor($C0C0C0);
  clRed     = TColor($FF0000);
  clLime    = TColor($00FF00);
  clYellow  = TColor($00FFFF);
  clBlue    = TColor($0000FF);
  clFuchsia = TColor($FF00FF);
  clAqua    = TColor($00FFFF);
  clLtGray  = TColor($C0C0C0);
  clDkGray  = TColor($808080);
  clWhite   = TColor($FFFFFF);
  clForeground = -3;
  clBackground = -2;
  clTransparent = -1;

type
  TDisplayBitDepth = (OneBit=1,TwoBits=2,SixteenBits=16);
  TDisplayRotation = (None=0,Right=1,UpsideDown=2,Left=3);
  TDisplayColorOrder = (RGB=0,BGR,BW);
  TCorner = (TopLeft,TopRight,BottomLeft,BottomRight);

  TFontData = array [0..MaxInt-1] of byte;
  TImageData = array [0..MaxInt-1] of byte;
  TIndexData = array [0..255] of TColor;

  TRowBuffer = array [0..MaxInt-1] of byte;

  TFontInfo = record
    Width,Height : Word;
    BitsPerPixel : byte;
    BytesPerChar : Word;
    Charmap : String;
    pFontData : ^TFontData;
    pRowBuffer : ^TRowBuffer;
  end;

  TImageInfo = record
    Width,Height : word;
    BitsPerPixel : byte;
    BytesPerLine : byte;
    pIndexData : ^TIndexData;
    pImageData : ^TImageData;
  end;

  TPhysicalScreenInfo = record
    Width, Height: word;
    Depth : TDisplayBitDepth;
    ColorOrder : TDisplayColorOrder;
    ColStart, RowStart : array[0..3] of word;
    class operator =(a,b : TPhysicalScreenInfo) : boolean;
  end;

type TCustomDisplay = object
  private
    FPhysicalScreenInfo : TPhysicalScreenInfo;
    FFontInfo : TFontInfo;
    procedure drawCircleHelper(const x,y : word; radius : word; const corner : TCorner;const fgColor:TColor=clForeground);
    procedure fillCircleHelper(const x,y : word; radius : word; const corner : TCorner; delta : word; const fgColor:TColor=clForeground);
  protected
    colStart : word;
    rowStart : word;
    FScreenWidth : word;
    FScreenHeight : word;
    FForegroundColor : TColor;
    FBackgroundColor : TColor;
    FRotation : TDisplayRotation;
    procedure CalculateAntialiasColors(const fgColor,bgColor : TColor; out AntiAliasColors : array of TColor); virtual;
    procedure swapValues(var a,b : word); inline;
    procedure swapValues(var a,b : longInt); inline;
    procedure setPhysicalScreenInfo(screenInfo : TPhysicalScreenInfo); virtual;
    procedure WriteCommand(const command : byte); virtual; abstract;
    procedure WriteCommandBytes(const command:byte; constref param : array of byte; Count:longInt=-1); virtual; abstract;
    procedure WriteCommandWords(const command:byte; constref param : array of word; Count:longInt=-1); virtual; abstract;
    procedure WriteData(const data: byte); virtual; abstract;
    procedure WriteDataBytes(constref data : array of byte; Count:longInt=-1); virtual; abstract;
    procedure WriteDataWords(constref data : array of word; Count:longInt=-1); virtual; abstract;
    property PhysicalScreenInfo : TPhysicalScreenInfo read FPhysicalScreenInfo write setPhysicalScreenInfo;
    procedure setRotation(const DisplayRotation : TDisplayRotation); virtual; abstract;
    function  setDrawArea(const X,Y,Width,Height : word) : longWord; virtual ; abstract;
    function clipToScreen(const x,y,width,height : word; out newWidth,newHeight : word) : boolean;
  public
    constructor Initialize;
    procedure drawPixel(const x,y : word; const fgColor : TColor = clForeground); virtual; abstract;
    //procedure drawChar(const x,y : word; const c : char; const size : byte; const color : TColor=-1; const bg : TColor = -1); virtual; abstract;
    procedure drawText(const TheText : String; const x,y : word; const fgColor : TColor = clForeground; const bgColor : TColor = clTransparent); virtual; abstract;
    procedure drawLine(x0,y0,x1,y1 : word; const fgColor : TColor = clForeground); virtual;
    procedure drawFastVLine(const  x, y : word ; height : word; const fgColor : TColor = clForeground); virtual; abstract;
    procedure drawFastHLine(const  x, y : word; width : word; const fgColor : TColor = clForeground); virtual; abstract;

    procedure drawRect(const x,y,width,height : word; const fgColor : TColor = clForeground);
    procedure fillRect(const x,y,width,height : word; const fgColor : TColor = clForeground); virtual; abstract;

    procedure drawRoundRect(const x,y,width,height : word; const radius : word; const fgColor : TColor = clForeground);
    procedure fillRoundRect(const x,y,width,height : word; const radius : word; const fgColor : TColor = clForeground);

    procedure drawCircle(const x,y : word; radius : word; const fgColor : TColor = clForeground);
    procedure fillCircle(const x,y : word; radius : word; const fgColor : TColor = clForeground);

    procedure drawEllipse(const x,y : word; const radiusx,radiusy : word; const fgColor : TColor = clForeground);
    procedure fillEllipse(const x,y : word; const radiusx,radiusy : word; const fgColor : TColor = clForeground);

    procedure drawTriangle(const x0,y0,x1,y1,x2,y2 : word; const fgColor : TColor = clForeground);
    procedure fillTriangle(x0,y0,x1,y1,x2,y2 : word; const fgColor : TColor = clForeground);

    procedure drawImage(const x,y : word; constref ImageInfo: TImageInfo;const fgColor : TColor = clForeground; const bgColor : TColor = clTransparent);

    (*
      Activates a font for text output
    param:
      TheFontInfo
    *)
    procedure setFontInfo(const FontInfo : TFontInfo);

    property ForegroundColor : TColor read FForegroundColor write FForegroundColor;
    property BackgroundColor : TColor read FBackgroundColor write FBackgroundColor;
    property ScreenWidth : word read FScreenWidth;
    property ScreenHeight : word read FScreenHeight;
    property Rotation : TDisplayRotation read FRotation write setRotation;
    property FontInfo : TFontInfo read FFontInfo write setFontInfo;
end;

implementation

constructor TCustomDisplay.Initialize;
begin
  colStart := 0;
  rowStart := 0;
  FForegroundColor := 0;
  FBackgroundColor := 0;
  FScreenWidth := 0;
  FScreenHeight := 0;
end;

procedure TCustomDisplay.setPhysicalScreenInfo(screenInfo : TPhysicalScreenInfo);
begin
  FPhysicalScreenInfo := screenInfo;
  FScreenWidth :=  FPhysicalScreenInfo.Width;
  FScreenHeight :=  FPhysicalScreenInfo.Height;
  FRotation := TDisplayRotation.None;
end;

function TCustomDisplay.clipToScreen(const x,y,width,height : word; out newWidth,newHeight : word) : boolean;
begin
  result := false;
  if (x >= ScreenWidth) or (y >= ScreenHeight) then
    exit;
  if x + width > ScreenWidth then
    newwidth := ScreenWidth - x
  else
    newWidth := width;
  if y + height > ScreenHeight then
    newheight := ScreenHeight - y
  else
    newHeight := height;
  if (newWidth = 0) or (newHeight = 0) or (newWidth > ScreenWidth) or (newHeight > ScreenHeight) then
    exit;
  result := true;
end;

procedure TCustomDisplay.swapValues(var a,b : word); inline;
begin
  a := a xor b;
  b := b xor a;
  a := a xor b;
end;

procedure TCustomDisplay.swapValues(var a,b : longInt); inline;
begin
  a := a xor b;
  b := b xor a;
  a := a xor b;
end;

class operator TPhysicalScreenInfo.= (a,b : TPhysicalScreenInfo) : boolean;
begin
  Result := (a.Width = b.Width) and (a.Height = b.Height) and (a.Depth = b.Depth);
end;

procedure TCustomDisplay.setFontInfo(const FontInfo : TFontInfo);
begin
  FFontInfo := FontInfo;
end;

procedure TCustomDisplay.CalculateAntialiasColors(const fgColor,bgColor : TColor; out AntiAliasColors : array of TColor);
begin
  AntiAliasColors[%00] := bgColor;
  AntiAliasColors[%11] := fgColor;

  //Set some simple defaults (effectively kills antialiasing)
  AntiAliasColors[%01] := AntiAliasColors[%00];
  AntiAliasColors[%10] := AntiAliasColors[%11];
end;

procedure TCustomDisplay.drawCircleHelper(const x,y : word; radius : word; const corner : TCorner;const fgColor:TColor=clForeground);
var
  f : longInt;
  ddF_x,ddF_y : longInt;
  _x : longInt;
begin
  f := 1 - radius;
  ddF_x := 1;
  ddF_y := -2 * radius;
  _x := 0;

  while _x < radius do
  begin
    if f >= 0 then
    begin
      radius := radius - 1;
      ddF_y := ddF_y + 2;
      f := f + ddF_y;
    end;
    _x := _x + 1;
    ddF_x := ddF_X + 2;
    f := f + ddF_x;
    case corner of
      TCorner.BottomLeft : begin
        drawPixel(x + _x, y + radius, fgColor);
        drawPixel(x + radius, y + _x, fgColor);
      end;
      TCorner.TopRight : begin
        drawPixel(x + _x, y - radius, fgColor);
        drawPixel(x + radius, y - _x, fgColor);
      end;
      TCorner.Bottomright : begin
        drawPixel(x - radius, y + _x, fgColor);
        drawPixel(x - _x, y + radius, fgColor);
      end;
      TCorner.TopLeft : begin
        drawPixel(x - radius, y - _x, fgColor);
        drawPixel(x - _x, y - radius, fgColor);
      end;
    end;
  end;
end;

procedure TCustomDisplay.fillCircleHelper(const x,y : word; radius : word; const corner : TCorner; delta : word; const fgColor:TColor=clForeground);
var
  f,ddF_x,ddF_y,_y : longInt;
begin
  f := 1 - radius;
  ddF_x := 1;
  ddF_y := -2*radius;
  _y := 0;

  delta := delta + 1;

  while _y < radius do
  begin
    if f >= 0 then
    begin
      if corner = TCorner.TopLeft then
        drawFastHLine(x - _y, y + radius, _y + _y + delta, fgColor);
      if corner = TCorner.TopRight then
        drawFastHLine(x - _y, y - radius, _y + _y + delta, fgColor);
      radius := radius - 1;
      ddF_y := ddF_y + 2;
      f := f +ddF_y;
    end;

    _y := _y + 1;
    ddF_x := ddF_x + 2;
    f := f + ddF_x;

    if corner = TCorner.TopLeft then
      drawFastHLine(x - radius, y + _y, radius + radius + delta, fgColor);
    if corner = Tcorner.TopRight then
      drawFastHLine(x - radius, y - _y, radius + radius + delta, fgColor);
  end;
end;

procedure TCustomDisplay.drawRect(const x,y,width,height : word; const fgColor : TColor = clForeground);
begin
  drawFastHLine(x, y, width, fgColor);
  drawFastHLine(x, word(y + height) - 1, width, fgColor);
  // Avoid drawing corner pixels twice
  drawFastVLine(x, y+1, height-2, fgColor);
  drawFastVLine(word(x + width) - 1, y+1, height-2, fgColor);
end;

procedure TCustomDisplay.drawRoundRect(const x,y,width,height : word; const radius : word; const fgColor : TColor = clForeground);
begin
   drawFastHLine(x + radius,    y,              width  - radius - radius, fgColor); // Top
   drawFastHLine(x + radius,    word(y + height) - 1, width  - radius - radius, fgColor); // Bottom
   drawFastVLine(x,             y + radius,     height - radius - radius, fgColor); // Left
   drawFastVLine(word(x + width) - 1, word(y + radius),     height - radius - radius, fgColor); // Right
   // draw four corners
   drawCircleHelper(x + radius,             y + radius,              radius, TCorner.TopLeft, fgColor);
   drawCircleHelper(word(x + width) - radius - 1, y + radius,              radius, TCorner.TopRight, fgColor);
   drawCircleHelper(word(x + width) - radius - 1, word(y + height) - radius - 1, radius, TCorner.BottomLeft, fgColor);
   drawCircleHelper(x + radius,             word(y + height) - radius - 1, radius, TCorner.BottomRight, fgColor);
end;

procedure TCustomDisplay.fillRoundRect(const x,y,width,height : word; const radius : word; const fgColor : TColor = clForeground);
begin
  fillRect(x, y + radius, width, height - radius - radius, fgColor);
  // draw four corners
  fillCircleHelper(x + radius, word(y + height) - radius - 1, radius, TCorner.TopLeft,    width - radius - radius - 1, fgColor);
  fillCircleHelper(x + radius, y + radius,              radius, TCorner.BottomLeft, width - radius - radius - 1, fgColor);
end;

procedure TCustomDisplay.drawCircle(const x,y : word; radius : word; const fgColor : TColor = clForeground);
var
  _x,dx,dy,p : longint;
begin
  _x := 1;
  dx := 1;
  dy := radius+radius;
  p  := -(radius shr 1);

  // These are ordered to minimise coordinate changes in x or y
  // drawPixel can then send fewer bounding box commands
  drawPixel(x + radius, y, fgColor);
  drawPixel(x - radius, y, fgColor);
  drawPixel(x, y - radius, fgColor);
  drawPixel(x, y + radius, fgColor);

  while _x < radius do
  begin
    if (p>=0) then
    begin
      dy:= dy -2;
      p := p - dy;
      radius := radius -1;
    end;

    dx := dx +2;
    p := p + dx;

    // These are ordered to minimise coordinate changes in x or y
    // drawPixel can then send fewer bounding box commands
    drawPixel(x + _x, y + radius, fgColor);
    drawPixel(x - _x, y + radius, fgColor);
    drawPixel(x - _x, y - radius, fgColor);
    drawPixel(x + _x, y - radius, fgColor);
    if (radius <> _x ) then
    begin
      drawPixel(x + radius, y + _x, fgColor);
      drawPixel(x - radius, y + _x, fgColor);
      drawPixel(x - radius, y - _x, fgColor);
      drawPixel(x + radius, y - _x, fgColor);
    end;
    _x := _x+1;
  end;
end;

procedure TCustomDisplay.fillCircle(const x,y : word; radius : word; const fgColor : TColor = clForeground);
var
  _x,dx,dy,p : longInt;

begin
  _x := 0;
  dx := 1;
  dy := radius+radius;
  p := -(radius shr 1);

  drawFastHLine(x - radius, y, dy+1, fgColor);

  while _x < radius do
  begin
    if p >= 0 then
    begin
      drawFastHLine(x - _x, y + radius, dx, fgColor);
      drawFastHLine(x - _x, y - radius, dx, fgColor);
      dy := dy -2;
      p := p - dy;
      radius := radius - 1;
    end;

    dx := dx + 2;
    p := p + dx;
    _x := _x + 1;

    drawFastHLine(x - radius, y + _x, dy+1, fgColor);
    drawFastHLine(x - radius, y - _x, dy+1, fgColor);
  end;
end;

procedure TCustomDisplay.drawEllipse(const x,y : word; const radiusx,radiusy : word; const fgColor : TColor = clForeground);
var
  _x,_y,rx2,ry2,fx2,fy2,s : longInt;
begin
  if (radiusx<2) or (radiusy<2) then
    exit;

  rx2 := radiusx * radiusx;
  ry2 := radiusy * radiusy;
  fx2 := 4 * rx2;
  fy2 := 4 * ry2;
  //TODO
  //for _x = 0, y = ry, s = 2*ry2+rx2*(1-2*ry); ry2*x <= rx2*y; x++) {
  begin
    // These are ordered to minimise coordinate changes in x or y
    // drawPixel can then send fewer bounding box commands
    drawPixel(x + _x, y + _y, fgColor);
    drawPixel(x - _x, y + _y, fgColor);
    drawPixel(x - _x, y - _y, fgColor);
    drawPixel(x + _x, y - _y, fgColor);
    if s >= 0 then
    begin
      s := s + fx2 * (1 - _y);
      _y := _y - 1;
    end;
    s := s + ry2 * ((4 * _x) + 6);
  end;
  //TODO
  //for (x = rx, y = 0, s = 2*rx2+ry2*(1-2*rx); rx2*y <= ry2*x; y++) {
  begin
    // These are ordered to minimise coordinate changes in x or y
    // drawPixel can then send fewer bounding box commands
    drawPixel(x + _x, y + _y, fgColor);
    drawPixel(x - _x, y + _y, fgColor);
    drawPixel(x - _x, y - _y, fgColor);
    drawPixel(x + _x, y - _y, fgColor);
    if s >= 0 then
    begin
      s := s + fy2 * (1 - _x);
      _x := _x - 1;
    end;
    s := s + rx2 * ((4 * _y) + 6);
  end;
end;

procedure TCustomDisplay.fillEllipse(const x,y : word; const radiusx,radiusy : word; const fgColor : TColor = clForeground);
var
  _x,_y,rx2,ry2,fx2,fy2,s : longInt;
begin
  if (radiusx<2) or (radiusy<2) then
    exit;
  rx2 := radiusx * radiusx;
  ry2 := radiusy * radiusy;
  fx2 := 4 * rx2;
  fy2 := 4 * ry2;
  //TODO
  //for (x = 0, y = ry, s = 2*ry2+rx2*(1-2*ry); ry2*x <= rx2*y; x++)
  begin
    drawFastHLine(x - _x, y - _y, _x + _x + 1, fgColor);
    drawFastHLine(x - _x, y + _y, _x + _x + 1, fgColor);

    if s >= 0 then
    begin
      s := s + fx2 * (1 - _y);
      _y := _y - 1;
    end;
    s := s + ry2 * ((4 * _x) + 6);
  end;
  //TODO
  //for (x = rx, y = 0, s = 2*rx2+ry2*(1-2*rx); rx2*y <= ry2*x; y++) {
  begin
    drawFastHLine(x - _x, y - _y, _x + _x + 1, fgColor);
    drawFastHLine(x - _x, y + _y, _x + _x + 1, fgColor);

    if s >= 0 then
    begin
      s := s + fy2 * (1 - _x);
      _x := _x - 1;
    end;
    s := s + rx2 * ((4 * _y) + 6);
  end;
end;

procedure TCustomDisplay.drawTriangle(const x0,y0,x1,y1,x2,y2 : word; const fgColor : TColor = clForeground);
begin
  drawLine(x0, y0, x1, y1, fgColor);
  drawLine(x1, y1, x2, y2, fgColor);
  drawLine(x2, y2, x0, y0, fgColor);
end;

procedure TCustomDisplay.fillTriangle(x0,y0,x1,y1,x2,y2 : word; const fgColor : TColor = clForeground);
var
  a, b, y, last : longInt;
  dx01,dy01,dx02,dy02,dx12,dy12,sa,sb : longInt;
begin
  // Sort coordinates by Y order (y2 >= y1 >= y0)
  if (y0 > y1) then
  begin
    swapValues(y0, y1);
    swapValues(x0, x1);
  end;
  if (y1 > y2) then
  begin
    swapValues(y2, y1);
    swapValues(x2, x1);
  end;

  if (y0 > y1) then
  begin
    swapValues(y0, y1);
    swapValues(x0, x1);
  end;

  if y0 = y2 then
  begin
    // Handle awkward all-on-same-line case as its own thing
    a := x0;
    b := x0;
    if x1 < a then
      a := x1
    else if x1 > b then
      b := x1;
    if x2 < a then
      a := x2
    else if x2 > b then
      b := x2;
    drawFastHLine(a, y0, b - a + 1, fgColor);
    exit;
  end;

  dx01 := x1 - x0;
  dy01 := y1 - y0;
  dx02 := x2 - x0;
  dy02 := y2 - y0;
  dx12 := x2 - x1;
  dy12 := y2 - y1;
  sa := 0;
  sb := 0;

  // For upper part of triangle, find scanline crossings for segments
  // 0-1 and 0-2.  If y1=y2 (flat-bottomed triangle), the scanline y1
  // is included here (and second loop will be skipped, avoiding a /0
  // error there), otherwise scanline y1 is skipped here and handled
  // in the second loop...which also avoids a /0 error here if y0=y1
  // (flat-topped triangle).
  if y1 = y2 then
    last := y1  // Include y1 scanline
  else
    last := y1 - 1; // Skip it

  for y := y0 to last do
  begin
    a := x0 + sa div dy01;
    b := x0 + sb div dy02;
    sa := sa + dx01;
    sb := sb + dx02;
    if a > b then
      swapValues(a, b);
    drawFastHLine(a, y, b - a + 1, fgColor);
  end;

  // For lower part of triangle, find scanline crossings for segments
  // 0-2 and 1-2.  This loop is skipped if y1=y2.
  sa := dx12 * (y - y1);
  sb := dx02 * (y - y0);
  for y := y to y2 do
  begin
    a := x1 + sa div dy12;
    b := x0 + sb div dy02;
    sa := sa + dx12;
    sb := sb + dx02;

    if a > b then
      swapValues(a, b);
    drawFastHLine(a, y, b - a + 1, fgColor);
  end;
end;

procedure TCustomDisplay.drawImage(const x,y : word; constref ImageInfo: TImageInfo;const fgColor : TColor = clForeground; const bgColor : TColor = clTransparent);
var
  bit : byte;
  _x,_y : word;
  _fgColor : TColor;
  xline : byte;
begin
  if ImageInfo.BitsPerPixel = 1 then
  begin
    for _y := 0 to ImageInfo.Height-1 do
    begin
      for _x := 0 to ((ImageInfo.Width-1) div 8) do
      begin
        xline := ImageInfo.pImageData^[_y*ImageInfo.BytesPerLine + _x];
        for bit := 7 downto 0 do
          if (_x shl 3) + bit < ImageInfo.Width then
            if  (xline and (%1 shl bit)) <> 0 then
              drawPixel(word(x + (_x shl 3)) + 7 - bit,y + _y,fgColor)
            else
              if bgColor <> clTransparent then
                drawPixel(word(x + (_x shl 3)) + 7 - bit,word(y + _y),bgColor)
      end;
    end;
  end
  else if ImageInfo.BitsPerPixel = 2 then
  begin
  end
  else if ImageInfo.BitsPerPixel = 4 then
  begin
    for _y := 0 to ImageInfo.Height-1 do
    begin
      for _x := 0 to ((ImageInfo.Width-1) div 2) do
      begin
        xline := ImageInfo.pImageData^[_y*ImageInfo.BytesPerLine + _x];
        _fgColor := ImageInfo.pIndexData^[xline shr 4];
        if _fgColor <> clTransparent then
          drawPixel(word(x + (_x shl 1)),word(y + _y),_fgColor)
        else
          if bgColor <> clTransparent then
            if bgColor = clBackground then
              drawPixel(word(x + (_x shl 1)+1),word(y + _y),backgroundColor)
            else
              drawPixel(word(x + (_x shl 1)+1),word(y + _y),bgColor);

        _fgColor := ImageInfo.pIndexData^[xline and $0f];
        if _fgColor <> clTransparent then
          drawPixel(word(x + (_x shl 1)+1),word(y + _y),_fgColor)
        else
          if bgColor <> clTransparent then
            if bgColor = clBackground then
              drawPixel(word(x + (_x shl 1)+1),word(y + _y),backgroundColor)
            else
              drawPixel(word(x + (_x shl 1)+1),word(y + _y),bgColor);
      end;
    end;
  end
  else if ImageInfo.BitsPerPixel = 8 then
  begin
  end;
end;

procedure TCustomDisplay.drawLine(x0,y0,x1,y1 : word; const fgColor : TColor = clForeground);
var
  steep : boolean;
  dx,dy,err,ystep,xs,dlen : longInt;
begin
  steep := abs(y1 - y0) > abs(x1 - x0);
  if (steep) then
  begin
    swapValues(x0, y0);
    swapValues(x1, y1);
  end;

  if x0 > x1 then
  begin
    swapValues(x0, x1);
    swapValues(y0, y1);
  end;

  dx := x1 - x0;
  dy := abs(y1 - y0);

  err := dx shr 1;
  ystep := -1;
  xs := x0;
  dlen := 0;

  if y0 < y1 then
    ystep := 1;

  // Split into steep and not steep for FastH/V separation
  if steep then
  begin
    for x0 := x0 to x1 do
    begin
      dlen := dlen + 1;
      err := err - dy;
      if err < 0 then
      begin
        err := err + dx;
        if dlen = 1 then
          drawPixel(y0, xs, fgColor)
        else
          drawFastVLine(y0, xs, dlen, fgColor);
        dlen := 0;
        y0 := y0 + ystep;
        xs := x0 + 1;
      end;
    end;
    if dlen > 0 then
      drawFastVLine(y0, xs, dlen, fgColor);
  end
  else
  begin
    for x0 := x0 to x1 do
    begin
      dlen := dlen + 1;
      err := err - dy;
      if err < 0 then
      begin
        err := err + dx;
        if dlen = 1 then
          drawPixel(xs, y0, fgColor)
        else
          drawFastHLine(xs, y0, dlen, fgColor);
        dlen := 0;
        y0 := y0 + ystep;
        xs := x0 + 1;
      end;
    end;
    if dlen > 0 then
      drawFastHLine(xs, y0, dlen, fgColor);
  end;
end;

end.
