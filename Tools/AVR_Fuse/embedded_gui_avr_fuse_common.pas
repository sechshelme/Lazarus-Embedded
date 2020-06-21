unit Embedded_GUI_AVR_Fuse_Common;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ComCtrls,
  ExtCtrls, FileUtil,
  Embedded_GUI_AVR_Fuse_Burn_Form;

type

  { TFuseCheckBox }

  TFuseCheckBox = class(TCheckBox)
  private
    fMask: byte;
    function GetMask: byte;
  public
    property Mask: byte read GetMask write fMask;
  end;

  { TFuseComboBox }

  TFuseComboBox = class(TComboBox)
  private
    fMask: byte;
    fMasks: array of byte;
    BitStart, BitSize: integer;
    function GetMask: byte;
    procedure SetMask(AValue: byte);
  public
    constructor Create(TheOwner: TComponent); override;
    property Mask: byte read GetMask write SetMask;
    procedure Add(const s: string; AMask: byte);
  end;

  { TBitMaskCheckBox }

  TBitMaskCheckBox = class(TGroupBox)
  private
    Field: array[0..7] of record StaticText:TStaticText; CheckBox:TCheckBox;end;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

  { TFuseTabSheet }

  TFuseTabSheet = class(TTabSheet)
  private
    FuseByte: byte;
    ofs: integer;
    CheckBoxes: array of TFuseCheckBox;
    ComboBoxes: array of TFuseComboBox;
    StaticTexts: array of TStaticText;
    Panel: TPanel;
    FuseLabel: TLabel;
    BitCheckBox:TBitMaskCheckBox;
    FuseEdit: TEdit;
    BurnButton: TButton;
    procedure BurnButtonClick(Sender: TObject);
    procedure SelfChange(Sender: TObject);
  public
    constructor Create(TheOwner: TComponent); override;
    destructor Destroy; override;
    procedure Resize; override;
    procedure NewComboBox(Title: string; AMask: byte);
    procedure AddComboxItem(const s: string; AMask: byte);
    procedure AddCheckBox(const s: string; AMask: byte);
    procedure Clear;
  end;

implementation

{ TBitMaskCheckBox }

constructor TBitMaskCheckBox.Create(AOwner: TComponent);
var
  i,l: Integer;
begin
  inherited Create(AOwner);
  Caption:='Bitmask';    Height:=60;
  l:=                 Length(Field);
  for i := 0 to l - 1 do begin
    Field[i].StaticText := TStaticText.Create(Self);
    Field[i].CheckBox := TCheckBox.Create(Self);
    Field[i].StaticText.Parent :=Self;
    Field[i].CheckBox.Parent :=Self;
    Field[i].StaticText.Top :=10;
    Field[i].StaticText.Caption :=IntToStr(l-i);
    Field[i].CheckBox.Top :=30;
    Field[i].StaticText.Left :=Width div 9*i;
    Field[i].CheckBox.Left :=Width div 9*i;
  end;
end;

destructor TBitMaskCheckBox.Destroy;
var
  i: Integer;
begin
  for i := 0 to Length(Field) - 1 do begin
    Field[i].CheckBox.Free;
    Field[i].StaticText.Free;
  end;
  inherited Destroy;
end;


{ TFuseTabSheet }

constructor TFuseTabSheet.Create(TheOwner: TComponent);
begin
  inherited Create(TheOwner);
  ofs := 5;
  Panel := TPanel.Create(Self);
  FuseLabel := TLabel.Create(Self);
  FuseEdit := TEdit.Create(Self);
  BurnButton := TButton.Create(Self);
  BitCheckBox:=TBitMaskCheckBox.Create(Self);
end;

destructor TFuseTabSheet.Destroy;
begin
  Clear;
  Panel.Free;
  FuseEdit.Free;
  FuseLabel.Free;
  BurnButton.Free;
  BitCheckBox.Free;
  inherited Destroy;
end;

procedure TFuseTabSheet.SelfChange(Sender: TObject);
var
  i: integer;
begin
  FuseByte := 0;
  for i := 0 to Length(CheckBoxes) - 1 do begin
    FuseByte += CheckBoxes[i].Mask;
  end;
  for i := 0 to Length(ComboBoxes) - 1 do begin
    FuseByte += ComboBoxes[i].Mask;
  end;
  FuseEdit.Enabled := True;

  FuseEdit.Text := '0x' + IntToHex(not FuseByte, 2);
  FuseLabel.Caption := FuseByte.ToBinString;
end;

procedure TFuseTabSheet.BurnButtonClick(Sender: TObject);
var
  f: TForm_AVR_Fuse_Burn;
begin
  if Sender is TButton then begin
    f := TForm_AVR_Fuse_Burn.Create(Self);
    f.ShowModal;
    f.Free;
  end;
end;

procedure TFuseTabSheet.Resize;
var
  i: integer;
begin
  inherited Resize;
  with Panel do begin
    Parent := Self;
    Top := Self.Height - 90;
    Height := 2;
    Left := 0;
    Width := Self.Width;
    Anchors := [akBottom, akLeft, akRight];
  end;

  with FuseLabel do begin
    Parent := Self;
    Left := 10;
    Top := Self.Height - 80;
    Anchors := [akBottom, akLeft];
  end;

  with FuseEdit do begin
    Parent := Self;
    Enabled := False;
    Left := 230;
    Top := Self.Height - 80;
    Width := 50;
    Anchors := [akBottom, akLeft];
  end;

  with BurnButton do begin
    Parent := Self;
    Left := 530;
    Top := Self.Height - 80;
    Width := 50;
    Text := 'Burn';
    Anchors := [akBottom, akLeft];
    OnClick := @BurnButtonClick;
  end;

  with BitCheckBox do begin
  Parent:=Self;
  Left:=330;
  Top := Self.Height - 80;
  Anchors := [akBottom, akLeft];
  end;

  for i := 0 to Length(ComboBoxes) - 1 do begin
    ComboBoxes[i].Width := Width;
  end;
end;

procedure TFuseTabSheet.NewComboBox(Title: string; AMask: byte);
var
  l: integer;
begin
  Inc(ofs, 10);

  l := Length(StaticTexts);
  SetLength(StaticTexts, l + 1);
  StaticTexts[l] := TStaticText.Create(Self);
  with StaticTexts[l] do begin
    Parent := Self;
    Caption := Title;
    Top := ofs;
    Width := Self.Width;
    Inc(ofs, Height + 5);
  end;

  l := Length(ComboBoxes);
  SetLength(ComboBoxes, l + 1);
  ComboBoxes[l] := TFuseComboBox.Create(Self);
  with ComboBoxes[l] do begin
    Parent := Self;
    Style := csOwnerDrawFixed;
    Mask := AMask;
    Top := ofs;
    OnChange := @SelfChange;
    Inc(ofs, Height + 10);
  end;
end;

procedure TFuseTabSheet.AddComboxItem(const s: string; AMask: byte);
begin
  if Length(ComboBoxes) > 0 then begin
    ComboBoxes[Length(ComboBoxes) - 1].Add(s, AMask);
  end;
end;

procedure TFuseTabSheet.AddCheckBox(const s: string; AMask: byte);
var
  l: integer;
begin
  l := Length(CheckBoxes);
  SetLength(CheckBoxes, l + 1);
  CheckBoxes[l] := TFuseCheckBox.Create(Self);
  with CheckBoxes[l] do begin
    Parent := Self;
    Caption := s;
    Mask := AMask;
    Top := ofs;
    OnChange := @SelfChange;
    Inc(ofs, Height);
  end;
end;

procedure TFuseTabSheet.Clear;
var
  j: integer;
begin
  for j := 0 to Length(StaticTexts) - 1 do begin
    StaticTexts[j].Free;
  end;
  SetLength(StaticTexts, 0);

  for j := 0 to Length(ComboBoxes) - 1 do begin
    ComboBoxes[j].Free;
  end;
  SetLength(ComboBoxes, 0);

  for j := 0 to Length(CheckBoxes) - 1 do begin
    CheckBoxes[j].Free;
  end;
  SetLength(CheckBoxes, 0);
end;

{ TFuseCheckBox }

function TFuseCheckBox.GetMask: byte;
begin
  if Checked then begin
    Result := fMask;
  end else begin
    Result := 0;
  end;
end;

{ TFuseComboBox }

function TFuseComboBox.GetMask: byte;
begin
  Result := (not (fMasks[ItemIndex] shl BitStart)) and fMask;
end;

procedure TFuseComboBox.SetMask(AValue: byte);
var
  s: string;
  i: integer;
begin
  fMask := AValue;
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

constructor TFuseComboBox.Create(TheOwner: TComponent);
begin
  inherited Create(TheOwner);
  SetLength(fMasks, 0);
end;

procedure TFuseComboBox.Add(const s: string; AMask: byte);
var
  l: integer;
begin
  Items.Add(s + ' (' + (BinStr(AMask, BitSize)) + ')');
  ItemIndex := 0;
  l := Length(fMasks);
  SetLength(fMasks, l + 1);
  fMasks[l] := AMask;
end;

end.
