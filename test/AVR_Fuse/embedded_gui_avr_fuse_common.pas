unit Embedded_GUI_AVR_Fuse_Common;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ComCtrls,
  FileUtil;

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

implementation

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
  Result := (not(fMasks[ItemIndex] shl BitStart)) and fMask;
//  Result := not Result;
//  Result := Result and fMask;
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
  //    ShowMessage(BinStr(AValue,8)+'   '+BitStart.ToString+'   '+i.ToString+'   '+BitSize.ToString);

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
