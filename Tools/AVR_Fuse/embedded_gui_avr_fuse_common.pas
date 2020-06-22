unit Embedded_GUI_AVR_Fuse_Common;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ComCtrls,
  ExtCtrls, FileUtil,
  Embedded_GUI_AVR_Fuse_Burn_Form;

type
  TSenderProc = procedure(Sender: TObject) of object;

  { TFuseCheckBox }

  TFuseCheckBox = class(TCheckBox)
  private
    FMask: byte;
    function GetValue: byte;
    procedure SetValue(AValue: byte);
  public
    property Mask: byte write FMask;
    property Value: byte read GetValue write SetValue;
  end;

  { TFuseComboBox }

  TFuseComboBox = class(TComboBox)
  private
    FMask: byte;
    FMasks: array of byte;
    BitStart, BitSize: integer;
    procedure SetMask(AValue: byte);
    function GetValue: byte;
    procedure SetValue(AValue: byte);
  public
    property Mask: byte write SetMask;
    property Value: byte read GetValue write SetValue;
    constructor Create(TheOwner: TComponent); override;
    procedure Add(const s: string; AMask: byte);
  end;

  { TBitMaskGroup }

  TBitMaskGroup = class(TGroupBox)
  private
    Field: array[0..7] of record
      StaticText: TStaticText;
      CheckBox: TCheckBox;
    end;
    procedure CheckBoxChange(Sender: TObject);
    function GetValue: byte;
    procedure SetValue(AValue: byte);
  public
    OnChange: TSenderProc;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Resize; override;
    property Value: byte read GetValue write SetValue;
  end;

  { THexGroup }

  THexGroup = class(TGroupBox)
  private
    StaticText: TStaticText;
    Edit: TEdit;
    procedure EditChange(Sender: TObject);
    function GetValue: byte;
    procedure SetValue(AValue: byte);
  public
    OnChange: TSenderProc;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Value: byte read GetValue write SetValue;
  end;

implementation

{ THexGroup }

function THexGroup.GetValue: byte;
var
  i: Longint;
begin
  if (Edit.Caption <> '') and TryStrToInt(Edit.Caption, i) and (i in [0..255]) then begin
    Result := not (StrToInt(Edit.Text));
  end else begin
    Result := 0;
  end;
end;

procedure THexGroup.EditChange(Sender: TObject);
var
  i: integer;
begin
  if (Edit.Caption <> '') and TryStrToInt(Edit.Caption, i) and (i in [0..255]) then begin
    Edit.Color := clYellow;
    if Assigned(OnChange) then begin
      OnChange(Sender);
    end;
  end else begin
    Edit.Color := $D0D0FF;
  end;
end;

procedure THexGroup.SetValue(AValue: byte);
begin
  Edit.Text := '0x' + IntToHex(not AValue, 2);
//  Edit.Text := IntToHex(not AValue, 2);
end;

constructor THexGroup.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Caption := 'Fuse';
  Height := 60;
  Width := 100;
  Edit := TEdit.Create(Self);
  StaticText := TStaticText.Create(Self);
  with StaticText do begin
    Parent := Self;
  end;
  with Edit do begin
    Parent := Self;
    Left := 20;
    Width := 60;
    OnChange := @EditChange;
  end;
end;

destructor THexGroup.Destroy;
begin
  Edit.Free;
  StaticText.Free;
  inherited Destroy;
end;

{ TBitMaskGroup }

function TBitMaskGroup.GetValue: byte;
var
  i: integer;
begin
  Result := 0;
  for i := 0 to Length(Field) - 1 do begin
    if Field[i].CheckBox.Checked then begin
      Result += 1 shl (Length(Field) - i - 1);
    end;
  end;
end;

procedure TBitMaskGroup.CheckBoxChange(Sender: TObject);
begin
  if Assigned(OnChange) then begin
    OnChange(Sender);
  end;
end;

procedure TBitMaskGroup.SetValue(AValue: byte);
var
  i: integer;
begin
  for i := 0 to Length(Field) - 1 do begin
    Field[i].CheckBox.Checked := (1 shl (Length(Field) - i - 1)) and AValue > 0;
  end;
end;

constructor TBitMaskGroup.Create(AOwner: TComponent);
var
  i, l: integer;
begin
  inherited Create(AOwner);
  Caption := 'Bitmask';
  Height := 60;
  Width := 150;
  l := Length(Field);
  for i := 0 to l - 1 do begin
    with Field[i] do begin
      StaticText := TStaticText.Create(Self);
      CheckBox := TCheckBox.Create(Self);
      CheckBox.OnChange := @CheckBoxChange;
    end;
  end;
end;

destructor TBitMaskGroup.Destroy;
var
  i: integer;
begin
  for i := 0 to Length(Field) - 1 do begin
    Field[i].CheckBox.Free;
    Field[i].StaticText.Free;
  end;
  inherited Destroy;
end;

procedure TBitMaskGroup.Resize;
var
  i, l: integer;
begin
  inherited Resize;
  l := Length(Field);
  for i := 0 to l - 1 do begin
    with Field[i] do begin
      if Assigned(StaticText) then begin
        StaticText.Parent := Self;
        StaticText.Top := 2;
        StaticText.Caption := IntToStr(l - i - 1);
        StaticText.Left := Width div l * i + 7;
      end;
      if Assigned(CheckBox) then begin
        CheckBox.Parent := Self;
        CheckBox.Top := 18;
        CheckBox.Left := Width div l * i;
      end;
    end;
  end;
end;

{ TFuseCheckBox }

function TFuseCheckBox.GetValue: byte;
begin
  if Checked then begin
    Result := FMask;
  end else begin
    Result := 0;
  end;
end;

procedure TFuseCheckBox.SetValue(AValue: byte);
begin
  Checked:=(AValue and FMask)>0;
end;

{ TFuseComboBox }

function TFuseComboBox.GetValue: byte;
begin
  Result := (not (FMasks[ItemIndex] shl BitStart)) and FMask;
end;

procedure TFuseComboBox.SetMask(AValue: byte);
var
  s: string;
  i: integer;
begin
  FMask := AValue;
  s := BinStr(AValue, 8);
  i := 8;
  while (s[i] = '0') and (i >= 1) do begin
    Dec(i);
  end;
  BitStart := i;
  while (s[i] = '1') and (i >= 1) do begin
    Dec(i);
  end;
  BitSize := BitStart - i;
  BitStart := 8 - BitStart;
end;

procedure TFuseComboBox.SetValue(AValue: byte);
begin
 // ????????????????????????????'
end;

constructor TFuseComboBox.Create(TheOwner: TComponent);
begin
  inherited Create(TheOwner);
  SetLength(FMasks, 0);
end;

procedure TFuseComboBox.Add(const s: string; AMask: byte);
var
  l: integer;
begin
  Items.Add(s + ' (' + (BinStr(not AMask, BitSize)) + ')');
  ItemIndex := 0;
  l := Length(FMasks);
  SetLength(FMasks, l + 1);
  FMasks[l] := AMask;
end;

end.
