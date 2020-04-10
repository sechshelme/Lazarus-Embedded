unit Embedded_GUI_CPU_Info_Form;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Buttons, StdCtrls,
  Grids,
  BaseIDEIntf,
  LazConfigStorage,

  // Embedded ( Eigene Units )
  Embedded_GUI_Common,
  Embedded_GUI_SubArch_List;

type

  { TCPU_InfoForm }

  TCPU_InfoForm = class(TForm)
    BitBtn_Ok: TBitBtn;
    ComboBox1: TComboBox;
    StringGrid1: TStringGrid;
    ToggleBox1: TToggleBox;
    procedure ComboBox1Select(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure StringGrid1CompareCells(Sender: TObject;
      ACol, ARow, BCol, BRow: integer; var Result: integer);
    procedure ToggleBox1Change(Sender: TObject);
  private

  public
    procedure Load(var Table: array of TStringArray);
  end;

var
  CPU_InfoForm: TCPU_InfoForm;

implementation

{$R *.lfm}

{ TCPU_InfoForm }

procedure TCPU_InfoForm.FormCreate(Sender: TObject);
var
  Cfg: TConfigStorage;
begin
  Caption:=Title + 'CPU Info';
  Cfg := GetIDEConfigStorage(Embedded_Options_File, True);
  Left := StrToInt(Cfg.GetValue(Key_CPU_Info_Left, '100'));
  Top := StrToInt(Cfg.GetValue(Key_CPU_Info_Top, '50'));
  Width := StrToInt(Cfg.GetValue(Key_CPU_Info_Width, '500'));
  Height := StrToInt(Cfg.GetValue(Key_CPU_Info_Height, '500'));
  Cfg.Free;

  StringGrid1.FixedCols := 0;
  StringGrid1.DoubleBuffered := True;
  StringGrid1.TitleFont.Style := [fsBold];
  StringGrid1.AlternateColor := clMoneyGreen;
  StringGrid1.ColumnClickSorts := True;

  ComboBox1.Text := 'AVR';
  ComboBox1.Items.AddCommaText(Embedded_Systems);
  ComboBox1Select(Sender);
end;

procedure TCPU_InfoForm.StringGrid1CompareCells(Sender: TObject;
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

procedure TCPU_InfoForm.ToggleBox1Change(Sender: TObject);
begin
  ComboBox1Select(Sender);
end;

procedure TCPU_InfoForm.FormClose(Sender: TObject; var CloseAction: TCloseAction);
var
  Cfg: TConfigStorage;
begin
  Cfg := GetIDEConfigStorage(Embedded_Options_File, True);
  Cfg.SetDeleteValue(Key_CPU_Info_Left, IntToStr(Left), '100');
  Cfg.SetDeleteValue(Key_CPU_Info_Top, IntToStr(Top), '50');
  Cfg.SetDeleteValue(Key_CPU_Info_Width, IntToStr(Width), '500');
  Cfg.SetDeleteValue(Key_CPU_Info_Height, IntToStr(Height), '500');
  Cfg.Free;
end;

procedure TCPU_InfoForm.ComboBox1Select(Sender: TObject);
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

procedure TCPU_InfoForm.Load(var Table: array of TStringArray);
var
  x, y, i: integer;
begin
  StringGrid1.RowCount := Length(Table);
  StringGrid1.ColCount := 0;
  for y := 0 to Length(Table) - 1 do begin
    if StringGrid1.ColCount<Length(Table[y]) then begin
      StringGrid1.ColCount := Length(Table[y]);
    end;

    for x := 0 to Length(Table[y]) - 1 do begin
      if TryStrToInt(Table[y, x], i) then begin
        if ToggleBox1.Checked then begin
          StringGrid1.Cells[x, y] := '$' + Table[y, x].ToInteger.ToHexString;
        end else begin
          StringGrid1.Cells[x, y] := UInt32(Table[y, x].ToInteger).ToString;
        end;
      end else begin
        StringGrid1.Cells[x, y] := Table[y, x];
      end;
    end;
  end;
  StringGrid1.AutoSizeColumns;
end;

end.














