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

  { TBitMaskGroupBox }

  TBitMaskGroupBox = class(TGroupBox)
  private
    Field: array[0..7] of record
      StaticText: TStaticText;
      CheckBox: TCheckBox;
    end;
    function GetMask: byte;
    procedure SetMask(AValue: byte);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Resize; override;
    property Mask: byte read GetMask write SetMask;
  end;

  { THexGroupBox }

  THexGroupBox = class(TGroupBox)
  private
    StaticText: TStaticText;
    Edit: TEdit;
    function GetMask: byte;
    procedure SetMask(AValue: byte);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Mask: byte read GetMask write SetMask;
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
    BitCheckBox: TBitMaskGroupBox;
    HexEdit: THexGroupBox;
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

{ THexGroupBox }

function THexGroupBox.GetMask: byte;
begin
  Result := StrToInt(Edit.Text);
end;

procedure THexGroupBox.SetMask(AValue: byte);
begin
  Edit.Text := '0x' + IntToHex(not AValue, 2);
end;

constructor THexGroupBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Caption := 'Fuse';
  Height := 60;
  Width := 100;
  Edit := TEdit.Create(Self);
  StaticText := TStaticText.Create(Self);
  with StaticText do begin
    Parent := Self;
//    Text := '0x';
  end;
  with Edit do begin
    Parent := Self;
    Left := 20;
    Width := 60;
  end;
end;

destructor THexGroupBox.Destroy;
begin
  Edit.Free;
  StaticText.Free;
  inherited Destroy;
end;

{ TBitMaskGroupBox }

function TBitMaskGroupBox.GetMask: byte;
begin

end;

procedure TBitMaskGroupBox.SetMask(AValue: byte);
var
  i: Integer;
begin
  for i := 0 to Length(Field) - 1 do begin
    Field[i].CheckBox.Checked:=(1 shl i) and AValue > 0;
  end;
end;

constructor TBitMaskGroupBox.Create(AOwner: TComponent);
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
    end;
  end;
end;

destructor TBitMaskGroupBox.Destroy;
var
  i: integer;
begin
  for i := 0 to Length(Field) - 1 do begin
    Field[i].CheckBox.Free;
    Field[i].StaticText.Free;
  end;
  inherited Destroy;
end;

procedure TBitMaskGroupBox.Resize;
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

{ --- TFuseTabSheet ---------------------------------------------------------- }

constructor TFuseTabSheet.Create(TheOwner: TComponent);
begin
  inherited Create(TheOwner);
  ofs := 5;
  Panel := TPanel.Create(Self);
  FuseLabel := TLabel.Create(Self);
  HexEdit := THexGroupBox.Create(Self);
  BurnButton := TButton.Create(Self);
  BitCheckBox := TBitMaskGroupBox.Create(Self);
end;

destructor TFuseTabSheet.Destroy;
begin
  Clear;
  Panel.Free;
  HexEdit.Free;
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
  //  FuseEdit.Enabled := True;

  HexEdit.Text := IntToHex(FuseByte, 2);
  HexEdit.Mask := FuseByte;
  BitCheckBox.Mask:=FuseByte;
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

  with HexEdit do begin
    Parent := Self;
    Left := 300;
    Top := Self.Height - 80;
    Anchors := [akBottom, akLeft];
  end;

  with BitCheckBox do begin
    Parent := Self;
    Left := 10;
    Top := Self.Height - 80;
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
