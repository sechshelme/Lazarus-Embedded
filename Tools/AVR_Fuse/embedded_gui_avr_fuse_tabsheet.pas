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
//    FuseLabel: TLabel;
    BitCheckBox: TBitMaskGroup;
    HexEdit: THexGroup;
    BurnButton: TButton;
    procedure BitCheckBoxBitMaskGroupChange(Sender: TObject);
    procedure BurnButtonClick(Sender: TObject);
    procedure FeatureChange(Sender: TObject);
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
//  FuseLabel := TLabel.Create(Self);
  HexEdit := THexGroup.Create(Self);
  BurnButton := TButton.Create(Self);
  BitCheckBox := TBitMaskGroup.Create(Self);
  BitCheckBox.OnBitMaskGroupChange := @BitCheckBoxBitMaskGroupChange;
end;

destructor TFuseTabSheet.Destroy;
begin
  Clear;
  Panel.Free;
  HexEdit.Free;
//  FuseLabel.Free;
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
    FuseByte += ComboBoxes[i].Mask;
  end;

  HexEdit.Caption := IntToHex(FuseByte, 2);              // zum Test
  HexEdit.Value := FuseByte;
  BitCheckBox.Value := FuseByte;


//  FuseLabel.Caption := FuseByte.ToBinString; // zum Test
end;

procedure TFuseTabSheet.BitCheckBoxBitMaskGroupChange(Sender: TObject);
begin
  FuseByte := BitCheckBox.Value;
  HexEdit.Caption := IntToHex(FuseByte, 2); // zum Test
  HexEdit.Value := FuseByte;

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

//  with FuseLabel do begin
//    Parent := Self;
//    Left := 400;
//    Top := Self.Height - 80;
//    Anchors := [akBottom, akLeft];
//  end;

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

end.

