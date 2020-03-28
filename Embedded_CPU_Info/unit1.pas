unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ValEdit, Grids,
  StdCtrls, Embedded_GUI_SubArch_List, Types;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    ComboBox1: TComboBox;
    StringGrid1: TStringGrid;
    procedure Button1Click(Sender: TObject);
    procedure ComboBox1Select(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure StringGrid1CompareCells(Sender: TObject;
      ACol, ARow, BCol, BRow: integer; var Result: integer);
  private

  public
    procedure Load(Table: array of TStringArray);

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

const
  Item = 'AVR,ARM';

procedure TForm1.Button1Click(Sender: TObject);
begin
  Close;
end;

procedure TForm1.ComboBox1Select(Sender: TObject);
begin
  case ComboBox1.ItemIndex of
    0:
    begin
      Load(AVRControllerDataList);
    end;
    1:
    begin
      Load(ARMControllerDataList);
    end;
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  StringGrid1.FixedCols := 0;
  StringGrid1.DoubleBuffered := True;
  StringGrid1.TitleFont.Style := [fsBold];
  StringGrid1.AlternateColor := clMoneyGreen;
  StringGrid1.ColumnClickSorts := True;

  ComboBox1.Text := 'AVR';
  ComboBox1.Items.AddCommaText(Item);
  Load(AVRControllerDataList);
end;

procedure TForm1.StringGrid1CompareCells(Sender: TObject;
  ACol, ARow, BCol, BRow: integer; var Result: integer);
var
  i0, i1: integer;

begin
  if TryStrToInt(StringGrid1.Cells[ACol, ARow], i0) and
    TryStrToInt(StringGrid1.Cells[BCol, BRow], i1) then
  begin
    Result := i0 - i1;
  end
  else
  begin
    Result := CompareStr(StringGrid1.Cells[ACol, ARow], StringGrid1.Cells[BCol, BRow]);
  end;
  if Result = 0 then
  begin
    Result := CompareStr(StringGrid1.Cells[2, ARow], StringGrid1.Cells[2, BRow]);
    if Result = 0 then
    begin
      Result := CompareStr(StringGrid1.Cells[0, ARow], StringGrid1.Cells[0, BRow]);
    end;
  end;
  if StringGrid1.SortOrder = soDescending then
  begin
    Result *= -1;
  end;
end;

procedure TForm1.Load(Table: array of TStringArray);
var
  x, y: integer;
begin
  StringGrid1.RowCount := Length(Table);
  StringGrid1.ColCount := Length(Table[0]);
  for y := 0 to Length(Table) - 1 do
  begin
    for x := 0 to Length(Table[y]) - 1 do
    begin
      StringGrid1.Cells[x, y] := Table[y, x];
    end;
  end;
  StringGrid1.AutoSizeColumns;
end;

end.
