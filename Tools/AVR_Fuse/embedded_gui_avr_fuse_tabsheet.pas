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
    fOffset: Byte;
    FuseByte: byte;
    ofs: integer;
    CheckBoxes: array of TFuseCheckBox;
    ComboBoxes: array of TFuseComboBox;
    StaticTexts: array of TStaticText;
    Panel: TPanel;
    BitCheckBox: TBitMaskGroup;
    HexFuse: THexGroup;
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
    property Offset:Byte read fOffset write fOffset;
  end;

implementation

{ --- TFuseTabSheet ---------------------------------------------------------- }

constructor TFuseTabSheet.Create(TheOwner: TComponent);
begin
  inherited Create(TheOwner);
  ofs := 5;
  Panel := TPanel.Create(Self);
  HexFuse := THexGroup.Create(Self);
  HexFuse.OnChange := @HexEditChange;

  BurnButton := TButton.Create(Self);
  BurnButton.OnClick := @BurnButtonClick;

  BitCheckBox := TBitMaskGroup.Create(Self);
  BitCheckBox.OnChange := @BitMaskChange;
end;

destructor TFuseTabSheet.Destroy;
begin
  Clear;
  Panel.Free;
  HexFuse.Free;
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

  HexFuse.Value := FuseByte;
  BitCheckBox.Value := FuseByte;
end;

procedure TFuseTabSheet.BitMaskChange(Sender: TObject);
var
  i: integer;
begin
  FuseByte := BitCheckBox.Value;
  HexFuse.Value := FuseByte;

  for i := 0 to Length(CheckBoxes) - 1 do begin
    CheckBoxes[i].Value := FuseByte;
  end;
  for i := 0 to Length(ComboBoxes) - 1 do begin
    ComboBoxes[i].Value := FuseByte;
  end;
end;

procedure TFuseTabSheet.HexEditChange(Sender: TObject);
var
  i: integer;
begin
  FuseByte := HexFuse.Value;
  BitCheckBox.Value := FuseByte;

  for i := 0 to Length(CheckBoxes) - 1 do begin
    CheckBoxes[i].Value := FuseByte;
  end;
  for i := 0 to Length(ComboBoxes) - 1 do begin
    ComboBoxes[i].Value := FuseByte;
  end;
end;

procedure TFuseTabSheet.BurnButtonClick(Sender: TObject);
var
  Form: TForm_AVR_Fuse_Burn;
begin
  if Sender is TButton then begin
    Form := TForm_AVR_Fuse_Burn.Create(Self);
    Form.ShowModal;
    Form.Free;
  end;
end;

procedure TFuseTabSheet.Resize;
var
  i: integer;
begin
  inherited Resize;
  with Panel do begin
    Parent := Self;
    Top := Self.Height - 110;
    Height := 2;
    Left := 0;
    Width := Self.Width;
    Anchors := [akBottom, akLeft, akRight];
  end;

  with HexFuse do begin
    Parent := Self;
    Left := 200;
    Top := Self.Height - 100;
    Anchors := [akBottom, akLeft];
  end;

  with BitCheckBox do begin
    Parent := Self;
    Left := 10;
    Top := Self.Height - 100;
    Anchors := [akBottom, akLeft];
  end;

  with BurnButton do begin
    Parent := Self;
    Left := 530;
    Top := Self.Height - 100;
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
  ComboBoxes[l] := TFuseComboBox.Create(Self, AMask);
  with ComboBoxes[l] do begin
    Parent := Self;
    Style := csOwnerDrawFixed;
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

