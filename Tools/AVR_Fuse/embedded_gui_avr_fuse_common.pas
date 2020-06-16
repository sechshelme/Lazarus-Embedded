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

  { TFuseTabSheet }

  TFuseTabSheet = class(TTabSheet)
  private
    FuseByte: byte;
    //    TabSheet: TTabSheet;
    ofs: integer;
    CheckBox: array of TFuseCheckBox;
    ComboBox: array of TFuseComboBox;
    StaticText: array of TStaticText;
    Panel: TPanel;
    FuseLabel: TLabel;
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

{ TFuseTabSheet }

procedure TFuseTabSheet.SelfChange(Sender: TObject);
var
  i: integer;
begin
  FuseByte := 0;
  for i := 0 to Length(CheckBox) - 1 do begin
    FuseByte += CheckBox[i].Mask;
  end;
  for i := 0 to Length(ComboBox) - 1 do begin
    FuseByte += ComboBox[i].Mask;
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

constructor TFuseTabSheet.Create(TheOwner: TComponent);
begin
  inherited Create(TheOwner);
  ofs := 5;
  Panel := TPanel.Create(Self);
  FuseLabel := TLabel.Create(Self);
  FuseEdit := TEdit.Create(Self);
  BurnButton := TButton.Create(Self);
end;

destructor TFuseTabSheet.Destroy;
begin
  Clear;
  Panel.Free;
  FuseEdit.Free;
  FuseLabel.Free;
  BurnButton.Free;
  inherited Destroy;
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
    Left := 330;
    Top := Self.Height - 80;
    Width := 50;
    Text := 'Burn';
    Anchors := [akBottom, akLeft];
    OnClick := @BurnButtonClick;
  end;

  for i := 0 to Length(ComboBox) - 1 do begin
    ComboBox[i].Width := Width;
  end;
end;

procedure TFuseTabSheet.NewComboBox(Title: string; AMask: byte);
var
  l: integer;
begin
  Inc(ofs, 10);

  l := Length(StaticText);
  SetLength(StaticText, l + 1);
  StaticText[l] := TStaticText.Create(Self);
  with StaticText[l] do begin
    Parent := Self;
    Caption := Title;
    Top := ofs;
    Width := Self.Width;
    Inc(ofs, Height + 5);
  end;

  l := Length(ComboBox);
  SetLength(ComboBox, l + 1);
  ComboBox[l] := TFuseComboBox.Create(Self);
  with ComboBox[l] do begin
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
  if Length(ComboBox) > 0 then begin
    ComboBox[Length(ComboBox) - 1].Add(s, AMask);
  end;
end;

procedure TFuseTabSheet.AddCheckBox(const s: string; AMask: byte);
var
  l: integer;
begin
  l := Length(CheckBox);
  SetLength(CheckBox, l + 1);
  CheckBox[l] := TFuseCheckBox.Create(Self);
  with CheckBox[l] do begin
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
  for j := 0 to Length(StaticText) - 1 do begin
    StaticText[j].Free;
  end;
  SetLength(StaticText, 0);

  for j := 0 to Length(ComboBox) - 1 do begin
    ComboBox[j].Free;
  end;
  SetLength(ComboBox, 0);

  for j := 0 to Length(CheckBox) - 1 do begin
    CheckBox[j].Free;
  end;
  SetLength(CheckBox, 0);
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
