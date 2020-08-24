unit Insert_Default_Fuse;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils,Dialogs;

type

  { TInsertDefaultFuse }

  TInsertDefaultFuse = class(TObject)
  private
    FuseList, sl: TStringList;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Add(s: string);
    procedure Insert;
  end;

implementation

uses Embedded_GUI_AVR_Default_Fuse_Const;

const

  UName = '../../Lazarus_AVR_ARM_Embedded_GUI_Package/embedded_gui_avr_default_fuse_const.pas';

{ TInsertDefaultFuse }

constructor TInsertDefaultFuse.Create;
begin
  sl := TStringList.Create;
  sl.LoadFromFile(UName);
  ShowMessage(sl.Text);
  FuseList := TStringList.Create;
end;

destructor TInsertDefaultFuse.Destroy;
begin
  sl.SaveToFile(UName);
  sl.Free;
  FuseList.Free;
end;

procedure TInsertDefaultFuse.Add(s: string);
begin
  FuseList.Add(s);
end;

procedure TInsertDefaultFuse.Insert;
var
  p: integer;
begin
  p := 0;
  while (p < sl.Count) and (Pos('Name', sl[p]) = 0) do begin
    Inc(p);
  end;
  sl.Add('blabla2');
end;

end.
