unit Embedded_GUI_AVR_Fuse_TabSheet;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ComCtrls,
  ExtCtrls, FileUtil, LazFileUtils,
  Embedded_GUI_AVR_Fuse_Common,
  Embedded_GUI_Run_Command;

type

  { TFuseTabSheet }

  TFuseTabSheet = class(TTabSheet)
  private
    FFuseName: string;
    FFuseByte: byte;
    ofs: integer;
    CheckBoxes: array of TFuseCheckBox;
    ComboBoxes: array of TFuseComboBox;
    StaticTexts: array of TStaticText;
    Panel: TPanel;
    BitCheckBox: TBitMaskGroup;
    HexFuse: THexGroup;
    BurnButton: TButton;
    StaticTexts_Ctrl: TStaticText;
    procedure BitMaskChange(Sender: TObject);
    procedure BurnButtonClick(Sender: TObject);
    procedure FeatureChange(Sender: TObject);
    procedure HexEditChange(Sender: TObject);
    procedure setFuseByte(AValue: byte);
  public
    constructor Create(TheOwner: TComponent); override;
    destructor Destroy; override;
    procedure Resize; override;
    procedure NewComboBox(Title: string; AMask: byte);
    procedure AddComboxItem(const s: string; AMask: byte);
    procedure AddCheckBox(const s: string; AMask: byte);
    procedure Clear;
    property FuseName: string read FFuseName write FFuseName;
    property FuseByte: byte write setFuseByte;
  end;

var
  AVR_XML_Path: string;

implementation

{ --- TFuseTabSheet ---------------------------------------------------------- }

constructor TFuseTabSheet.Create(TheOwner: TComponent);
begin
  inherited Create(TheOwner);
  ofs := 5;
  FFuseByte := 0;
  Panel := TPanel.Create(Self);
  HexFuse := THexGroup.Create(Self);
  HexFuse.OnChange := @HexEditChange;

  BurnButton := TButton.Create(Self);
  BurnButton.OnClick := @BurnButtonClick;

  StaticTexts_Ctrl := TStaticText.Create(Self);

  BitCheckBox := TBitMaskGroup.Create(Self);
  BitCheckBox.OnChange := @BitMaskChange;
end;

destructor TFuseTabSheet.Destroy;
begin
  Clear;
  Panel.Free;
  HexFuse.Free;
  BurnButton.Free;
  StaticTexts_Ctrl.Free;
  BitCheckBox.Free;
  inherited Destroy;
end;

procedure TFuseTabSheet.FeatureChange(Sender: TObject);
var
  i: integer;
begin
  FFuseByte := 0;
  for i := 0 to Length(CheckBoxes) - 1 do begin
    FFuseByte += CheckBoxes[i].Value;
  end;
  for i := 0 to Length(ComboBoxes) - 1 do begin
    FFuseByte += ComboBoxes[i].Value;
  end;

  setFuseByte(FFuseByte);
  //   HexFuse.Value := FFuseByte;
  // BitCheckBox.Value := FFuseByte;
end;

procedure TFuseTabSheet.BitMaskChange(Sender: TObject);
var
  i: integer;
begin
  FFuseByte := BitCheckBox.Value;

  setFuseByte(FFuseByte);
  //HexFuse.Value := FFuseByte;
  //
  //for i := 0 to Length(CheckBoxes) - 1 do begin
  //  CheckBoxes[i].Value := FFuseByte;
  //end;
  //for i := 0 to Length(ComboBoxes) - 1 do begin
  //  ComboBoxes[i].Value := FFuseByte;
  //end;
end;

procedure TFuseTabSheet.HexEditChange(Sender: TObject);
var
  i: integer;
begin
  FFuseByte := HexFuse.Value;

  setFuseByte(FFuseByte);
  //BitCheckBox.Value := FFuseByte;
  //
  //for i := 0 to Length(CheckBoxes) - 1 do begin
  //  CheckBoxes[i].Value := FFuseByte;
  //end;
  //for i := 0 to Length(ComboBoxes) - 1 do begin
  //  ComboBoxes[i].Value := FFuseByte;
  //end;
end;

procedure TFuseTabSheet.setFuseByte(AValue: byte);
var
  i: integer;
begin
  FFuseByte := AValue;

  BitCheckBox.Value := FFuseByte;
  HexFuse.Value := FFuseByte;

  for i := 0 to Length(CheckBoxes) - 1 do begin
    CheckBoxes[i].Value := FFuseByte;
  end;
  for i := 0 to Length(ComboBoxes) - 1 do begin
    ComboBoxes[i].Value := FFuseByte;
  end;
end;

procedure TFuseTabSheet.BurnButtonClick(Sender: TObject);
var
  avr, fuse: string;
begin
  if Sender is TButton then begin
    if ssCtrl in GetKeyShiftState then begin
      if MessageDlg('Warnung !', 'Folgende Funktion kann den AVR zerstören' + LineEnding + 'Funktion ausführen ?', mtWarning, [mbYes, mbNo, mbCancel], 0) = mrYes then begin

        if not Assigned(Run_Command_Form) then begin
          Run_Command_Form := TRun_Command_Form.Create(nil);
        end;
        Run_Command_Form.Memo1.Clear;

        avr := ExtractFileName(AVR_XML_Path);
        avr := ExtractFileNameWithoutExt(avr);

        fuse := ' -B32 -U' + FFuseName + ':w:0x' + IntToHex(not FFuseByte, 2) + ':m';  // -B32 muss weg ?????????

        Run_Command_Form.RunCommand('avrdude -cusbasp -p' + avr + fuse);
      end;
    end;
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
    Left := 330;
    Top := Self.Height - 50;
    Width := 50;
    Text := 'Burn';
    Anchors := [akBottom, akLeft];
    OnClick := @BurnButtonClick;
  end;

  with StaticTexts_Ctrl do begin
    Parent := Self;
    Left := 390;
    Width := 100;
    Top := Self.Height - 47;
    Text := '(Press [Ctrl])';
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



