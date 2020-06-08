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
    fMask: Byte;
    function GetMask: Byte;
  public
    property Mask: Byte read GetMask write fMask;
  end;

  { TFuseComboBox }

  TFuseComboBox = class(TComboBox)
  private
    fMask: Byte;
    fMasks: array of Byte;
    function GetMask: Byte;
  public
    constructor Create(TheOwner: TComponent); override;
    property Mask: Byte read GetMask write fMask;
    procedure Add(const s: string; AMask: byte);
  end;

implementation

{ TFuseComboBox }

function TFuseComboBox.GetMask: Byte;
begin
 // Result := fMasks[ItemIndex] * fMask;
  Result := (Items.Count-1-fMasks[ItemIndex]) * (fMask-Items.Count);
//    Result:=Items.Count-Result;
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
  Items.Add(s);
  ItemIndex:=0;
  l := Length(fMasks);
  SetLength(fMasks, l + 1);
  fMasks[l] := AMask;
end;

{ TFuseCheckBox }

function TFuseCheckBox.GetMask: Byte;
begin
  if Checked then begin
    Result := fMask;
  end else begin
    Result := 0;
  end;
end;

end.
