unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ValEdit, Grids,
  StdCtrls, Embedded_GUI_SubArch_List, Types, IniFiles;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    ComboBox1: TComboBox;
    StringGrid1: TStringGrid;
    ToggleBox1: TToggleBox;
    procedure Button1Click(Sender: TObject);
    procedure ComboBox1Select(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure StringGrid1CompareCells(Sender: TObject;
      ACol, ARow, BCol, BRow: integer; var Result: integer);
    procedure ToggleBox1Change(Sender: TObject);
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
  Item = 'AVR,ARM,Mips,Riscv32,XTensa';

procedure TForm1.Button1Click(Sender: TObject);
begin
  Close;
end;

procedure TForm1.ComboBox1Select(Sender: TObject);
begin
  case ComboBox1.ItemIndex of
    0: begin
      Load(AVR_ControllerDataList);
    end;
    1: begin
      Load(ARM_ControllerDataList);
    end;
    2: begin
      Load(Mips_ControllerDataList);
    end;
    3: begin
      Load(Riscv32_ControllerDataList);
    end;
    4: begin
      Load(XTensa_ControllerDataList);
    end;
  end;
end;

procedure TForm1.FormClose(Sender: TObject; var CloseAction: TCloseAction);
var
  ini: TIniFile;
begin
  ini := TIniFile.Create('config.ini');
  ini.WriteInteger('pos', 'Left', Left);
  ini.WriteInteger('pos', 'Width', Width);
  ini.WriteInteger('pos', 'Top', Top);
  ini.WriteInteger('pos', 'Height', Height);
  ini.Free;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  ini: TIniFile;
begin
  ini := TIniFile.Create('config.ini');
  Left := ini.ReadInteger('pos', 'Left', 100);
  Width := ini.ReadInteger('pos', 'Width', 500);
  Top := ini.ReadInteger('pos', 'Top', 50);
  Height := ini.ReadInteger('pos', 'Height', 400);
  ini.Free;

  StringGrid1.FixedCols := 0;
  StringGrid1.DoubleBuffered := True;
  StringGrid1.TitleFont.Style := [fsBold];
  StringGrid1.AlternateColor := clMoneyGreen;
  StringGrid1.ColumnClickSorts := True;

  ComboBox1.Text := 'AVR';
  ComboBox1.Items.AddCommaText(Item);
  ComboBox1.ItemIndex := 0;
  ComboBox1Select(Sender);
end;

procedure TForm1.StringGrid1CompareCells(Sender: TObject;
  ACol, ARow, BCol, BRow: integer; var Result: integer);
var
  i0, i1: integer;

begin
  if TryStrToInt(StringGrid1.Cells[ACol, ARow], i0) and
    TryStrToInt(StringGrid1.Cells[BCol, BRow], i1) then begin
    Result := i0 - i1;
  end else begin
    Result := CompareStr(StringGrid1.Cells[ACol, ARow], StringGrid1.Cells[BCol, BRow]);
  end;
  if Result = 0 then begin
    Result := CompareStr(StringGrid1.Cells[2, ARow], StringGrid1.Cells[2, BRow]);
    if Result = 0 then begin
      Result := CompareStr(StringGrid1.Cells[0, ARow], StringGrid1.Cells[0, BRow]);
    end;
  end;
  if StringGrid1.SortOrder = soDescending then begin
    Result *= -1;
  end;
end;

procedure TForm1.ToggleBox1Change(Sender: TObject);
begin
  ComboBox1Select(Sender);
end;

procedure TForm1.Load(Table: array of TStringArray);
var
  x, y, i: integer;
  ui: UInt64;
begin
  StringGrid1.RowCount := Length(Table);
  StringGrid1.ColCount := 0;
  for y := 0 to Length(Table) - 1 do begin
    if StringGrid1.ColCount < Length(Table[y]) then begin
      StringGrid1.ColCount := Length(Table[y]);
    end;

    for x := 0 to Length(Table[y]) - 1 do begin
      if TryStrToInt(Table[y, x], i) then begin
        if ToggleBox1.Checked then begin
          ui := StrToInt64(Table[y, x]);
          StringGrid1.Cells[x, y] := '$' + IntToHex(ui, 8);
        end else begin
          ui := StrToInt64(Table[y, x]);
          StringGrid1.Cells[x, y] := IntToStr(ui);
        end;
      end else begin
        StringGrid1.Cells[x, y] := Table[y, x];
      end;
    end;
  end;
  StringGrid1.AutoSizeColumns;
end;

end.
