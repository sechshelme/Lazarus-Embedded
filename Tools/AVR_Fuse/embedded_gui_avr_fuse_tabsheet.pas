unit Embedded_GUI_AVR_Fuse_TabSheet;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ComCtrls,
  ExtCtrls, FileUtil,
  Embedded_GUI_AVR_Fuse_Common,
  Embedded_GUI_AVR_Fuse_Burn_Form;

type

  { TFuseTabSheet }

  TFuseTabSheet = class(TTabSheet)
  private
    FuseByte: byte;
    ofs: integer;
    CheckBoxes: array of TFuseCheckBox;
    ComboBoxes: array of TFuseComboBox;
    StaticTexts: array of TStaticText;
    Panel: TPanel;
    BitCheckBox: TBitMaskGroup;
    HexEdit: THexGroup;
    BurnButton: TButton;
    procedure BitMaskChange(Sender: TObject);
    procedure BurnButtonClick(Sender: TObject);
    procedure FeatureChange(Sender: TObject);
    procedure HexEditChange(Sender: TObject);
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

{ --- TFuseTabSheet ---------------------------------------------------------- }

constructor TFuseTabSheet.Create(TheOwner: TComponent);
begin
  inherited Create(TheOwner);
  ofs := 5;
  Panel := TPanel.Create(Self);
  HexEdit := THexGroup.Create(Self);
  HexEdit.OnChange:=@HexEditChange;

  BurnButton := TButton.Create(Self);
  BurnButton.OnClick := @BurnButtonClick;

  BitCheckBox := TBitMaskGroup.Create(Self);
  BitCheckBox.OnChange := @BitMaskChange;
end;

destructor TFuseTabSheet.Destroy;
begin
  Clear;
  Panel.Free;
  HexEdit.Free;
  BurnButton.Free;
  BitCheckBox.Free;
  inherited Destroy;
end;

procedure TFuseTabSheet.FeatureChange(Sender: TObject);
var
  i: integer;
begin
  FuseByte := 0;
  for i := 0 to Length(CheckBoxes) - 1 do begin
    FuseByte += CheckBoxes[i].Value;
  end;
  for i := 0 to Length(ComboBoxes) - 1 do begin
    FuseByte += ComboBoxes[i].Value;
  end;

  HexEdit.Caption := IntToHex(FuseByte, 2);              // zum Test
  HexEdit.Value := FuseByte;
  BitCheckBox.Value := FuseByte;
end;

procedure TFuseTabSheet.BitMaskChange(Sender: TObject);
var
  i: Integer;
begin
  FuseByte := BitCheckBox.Value;

  for i := 0 to Length(CheckBoxes) - 1 do begin
    CheckBoxes[i].Value:=FuseByte;
  end;
  for i := 0 to Length(ComboBoxes) - 1 do begin
    ComboBoxes[i].Value:=FuseByte;
  end;
  HexEdit.Caption := IntToHex(FuseByte, 2); // zum Test
  HexEdit.Value := FuseByte;
end;

procedure TFuseTabSheet.HexEditChange(Sender: TObject);
var
  i: Integer;
begin
  FuseByte:=HexEdit.Value;

  for i := 0 to Length(CheckBoxes) - 1 do begin
    CheckBoxes[i].Value:=FuseByte;
  end;
  for i := 0 to Length(ComboBoxes) - 1 do begin
    ComboBoxes[i].Value:=FuseByte;
  end;
  HexEdit.Caption := IntToHex(FuseByte, 2); // zum Test
  BitCheckBox.Value := FuseByte;
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
    OnChange := @FeatureChange;
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
    OnChange := @FeatureChange;
    Inc(ofs, Height);
  end;
end;

procedure TFuseTabSheet.Clear;
var
  i: integer;
begin
  for i := 0 to Length(StaticTexts) - 1 do begin
    StaticTexts[i].Free;
  end;
  SetLength(StaticTexts, 0);

  for i := 0 to Length(ComboBoxes) - 1 do begin
    ComboBoxes[i].Free;
  end;
  SetLength(ComboBoxes, 0);

  for i := 0 to Length(CheckBoxes) - 1 do begin
    CheckBoxes[i].Free;
  end;
  SetLength(CheckBoxes, 0);
end;

end.

