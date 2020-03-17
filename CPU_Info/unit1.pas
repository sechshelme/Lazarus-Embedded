unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ValEdit, Grids,
  StdCtrls, Embedded_GUI_SubArch_List;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    StringGrid1: TStringGrid;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private

  public
    procedure Load(Table: array of TStringArray);

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.Button1Click(Sender: TObject);
begin
  Load(ARMControllerDataList);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  StringGrid1.FixedCols := 0;
end;

procedure TForm1.Load(Table: array of TStringArray);
var
  x, y: integer;
begin
  StringGrid1.RowCount := Length(Table);
  StringGrid1.ColCount := Length(Table[0]);
  for y := 0 to Length(Table) - 1 do begin
    for x := 0 to Length(Table[y]) - 1 do begin
      //       StringGrid1.Cells[y, x] := x.ToString;
      StringGrid1.Cells[x, y] := Table[y, x];
    end;
  end;
end;

end.

