unit Insert_Default_Fuse;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Dialogs;

type

  { TInsertDefaultFuse }

  TInsertDefaultFuse = class(TObject)
  private
    FuseList, sl: TStringList;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Add(s: string);
    procedure Insert(AVR_Name: string);
  end;

implementation

//uses
//  Embedded_GUI_AVR_Default_Fuse_Const;

const
  UName = 'embedded_gui_avr_default_fuse_const.pas';

{ TInsertDefaultFuse }

constructor TInsertDefaultFuse.Create;
begin
  sl := TStringList.Create;
  sl.LoadFromFile(UName);
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

procedure TInsertDefaultFuse.Insert(AVR_Name: string);
var
  p: integer;
begin
  p := 0;
  while (p < sl.Count) and (Pos('(Name:', sl[p]) = 0) do begin
    Inc(p);
  end;
  if Pos(#39+AVR_Name+#39, sl.Text) = 0 then begin
    sl.Insert(p, '    (Name: '#39 + AVR_Name + #39'; Data: ({' + FuseList.CommaText + '})),');
  end;
  FuseList.Clear;
end;

end.
