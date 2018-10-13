unit Laufschrift;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls;

type

  { TLaufschrift }

  TLaufschrift = class(TPanel)
  public
    Shape: array of TShape;
    MatrixSize: TPoint;
    distance: integer;
    constructor Create(Component: TComponent; AMatrixSize: TPoint);
    procedure PutPixel(x, y: integer; col: boolean = True);
    procedure Line(x0, y0, x1, y1: integer; col: boolean = True);
    procedure Circle(x0, y0, r: integer; col: boolean = True);
    procedure FullCircle(x0, y0, r: integer; col: boolean = True);
    procedure Clear(col: boolean = False);
    function GetPixel(x, y: integer): boolean;
  end;


implementation

{ TLaufschrift }

constructor TLaufschrift.Create(Component: TComponent; AMatrixSize: TPoint);
var
  y, x: integer;
begin
  inherited Create(Component);
  MatrixSize := AMatrixSize;
  with MatrixSize do begin
    SetLength(Shape, x * y);
  end;
  distance := 20;
  Width := MatrixSize.x * distance;
  Height := MatrixSize.y * distance;
  for y := 0 to MatrixSize.y - 1 do begin
    for x := 0 to MatrixSize.x - 1 do begin
      Shape[x + Matrixsize.x * y] := TShape.Create(Self);
      Shape[x + Matrixsize.x * y].parent := Self;
      Shape[x + Matrixsize.x * y].Left := distance * x;
      Shape[x + Matrixsize.x * y].Top := distance * y;
      Shape[x + Matrixsize.x * y].Width := distance;
      Shape[x + Matrixsize.x * y].Height := distance;
      Shape[x + Matrixsize.x * y].Shape := stCircle;
    end;
  end;
end;

procedure TLaufschrift.PutPixel(x, y: integer; col: boolean);
var
  ofs: integer;
begin
  ofs := x + Matrixsize.x * y;
  if (ofs < 0) or (ofs >= Length(Shape)) then begin
//    WriteLn(ofs);
    Exit;
  end;
  if col then begin
    Shape[ofs].Brush.Color := clRed;
  end else begin
    Shape[ofs].Brush.Color := clBlack;
  end;
end;

procedure TLaufschrift.Line(x0, y0, x1, y1: integer; col: boolean);
var
  dx, dy, sx, sy, err, e2: integer;
begin
  dx := abs(x1 - x0);
  if x0 < x1 then begin
    sx := 1;
  end else begin
    sx := -1;
  end;

  dy := -abs(y1 - y0);
  if y0 < y1 then begin
    sy := 1;
  end else begin
    sy := -1;
  end;

  err := dx + dy;

  while (True) do begin
    PutPixel(x0, y0, col);
    if (x0 = x1) and (y0 = y1) then begin
      break;
    end;
    e2 := 2 * err;
    if e2 > dy then begin
      err += dy;
      x0 += sx;
    end;
    if e2 < dx then begin
      err += dx;
      y0 += sy;
    end;
  end;
end;

procedure TLaufschrift.Circle(x0, y0, r: integer; col: boolean);
var
  f, ddF_x, ddF_y, x, y: integer;
begin
  f := 1 - r;
  ddF_x := 0;
  ddF_y := -2 * r;
  x := 0;
  y := r;

  PutPixel(x0, y0 + r, col);
  PutPixel(x0, y0 - r, col);
  PutPixel(x0 + r, y0, col);
  PutPixel(x0 - r, y0, col);

  while (x < y) do begin
    if f >= 0 then begin
      Dec(y);
      ddF_y += 2;
      f += ddF_y;
    end;
    Inc(x);
    ddF_x += 2;
    f += ddF_x + 1;
    PutPixel(x0 + x, y0 + y, col);
    PutPixel(x0 - x, y0 + y, col);
    PutPixel(x0 + x, y0 - y, col);
    PutPixel(x0 - x, y0 - y, col);
    PutPixel(x0 + y, y0 + x, col);
    PutPixel(x0 - y, y0 + x, col);
    PutPixel(x0 + y, y0 - x, col);
    PutPixel(x0 - y, y0 - x, col);
  end;
end;

procedure TLaufschrift.FullCircle(x0, y0, r: integer; col: boolean);
var
  f, ddF_x, ddF_y, x, y: integer;
begin
  f := 1 - r;
  ddF_x := 0;
  ddF_y := -2 * r;
  x := 0;
  y := r;

  Line(x0, y0 + r, x0, y0 - r, col);
  Line(x0 + r, y0, x0 - r, y0, col);
  //  PutPixel(x0, y0 + r, col);
  //  PutPixel(x0, y0 - r, col);
  //  PutPixel(x0 + r, y0, col);
  //  PutPixel(x0 - r, y0, col);

  while (x < y) do begin
    if f >= 0 then begin
      Dec(y);
      ddF_y += 2;
      f += ddF_y;
    end;
    Inc(x);
    ddF_x += 2;
    f += ddF_x + 1;

    Line(x0 + x, y0 + y, x0 - x, y0 + y, col);
    Line(x0 + x, y0 - y, x0 - x, y0 - y, col);

    Line(x0 + y, y0 + x, x0 - y, y0 + x, col);
    Line(x0 + y, y0 - x, x0 - y, y0 - x, col);


    //PutPixel(x0 + x, y0 + y, col);
    //PutPixel(x0 - x, y0 + y, col);

    //PutPixel(x0 + x, y0 - y, col);
    //PutPixel(x0 - x, y0 - y, col);

    //PutPixel(x0 + y, y0 + x, col);
    //PutPixel(x0 - y, y0 + x, col);

    //PutPixel(x0 + y, y0 - x, col);
    //PutPixel(x0 - y, y0 - x, col);
  end;
end;

procedure TLaufschrift.Clear(col: boolean);
var
  i: integer;
begin
  for i := 0 to Length(Shape) - 1 do begin
    if col then begin
      Shape[i].Brush.Color := clRed;
    end else begin
      Shape[i].Brush.Color := clBlack;
    end;
  end;
end;

function TLaufschrift.GetPixel(x, y: integer): boolean;
var
  ofs: integer;
begin
  ofs := x + Matrixsize.x * y;
  if (ofs < 0) or (ofs >= Length(Shape)) then begin
    Exit;
  end;
  Result := Shape[ofs].Brush.Color = clRed;
end;

end.
