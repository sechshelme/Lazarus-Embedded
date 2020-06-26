unit Embedded_GUI_Common_FileComboBox;

{$mode objfpc}{$H+}

interface

uses Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls,
  Laz2_XMLCfg;

type

  { TFileNameComboBox }

  TFileNameComboBox = class(TGroupBox)
  private
    FConfigFile: string;
    FmaxCount: integer;
    ComboBox: TComboBox;
    Button: TButton;
    OpenDialog: TOpenDialog;
    procedure ButtonClick(Sender: TObject);
    procedure ComboBox_Insert_Text(cb: TComboBox);
    procedure LoadStrings_from_XML(Key: string; sl: TStrings; Default_Text: TStringArray);
    procedure SaveStrings_to_XML(Key: string; sl: TStrings);

    procedure LoadComboBox_from_XML(cb: TComboBox; Default_Text: TStringArray);
    procedure SaveComboBox_to_XML(cb: TComboBox);
  public
    constructor Create(TheOwner: TComponent; AName: string);
    constructor Create(TheOwner: TComponent; AName: string; ADefaultText: TStringArray);
    destructor Destroy;
    property ConfigFile: string read FConfigFile write FConfigFile;
    property maxCount: integer read FmaxCount write FmaxCount;
  end;

implementation

{$IFNDEF Packages}
type
  TConfigStorage = class(TXMLConfig)
  end;

function GetIDEConfigStorage(const Filename: string; LoadFromDisk: boolean): TConfigStorage;
begin
  Result := TConfigStorage.Create(nil);
  Result.Filename := FileName;
end;

{$ENDIF}

function getParents(c: TWinControl): string;
var
  p: TWinControl;
begin
  Result := '';
  p := c;
  repeat
    Result := p.Name + '/' + Result;
    p := p.Parent;
    //    ShowMessage(Result);
  until p = nil;
end;

{ TFileNameComboBox }

constructor TFileNameComboBox.Create(TheOwner: TComponent; AName: string; ADefaultText: TStringArray);
begin
  inherited Create(TheOwner);
  if AName = '' then begin
    raise EComponentError.Create('TFileNameComboBox.Name ist zwingend');
  end;
  Caption := AName;
  Name := AName;
  FConfigFile := 'config.xml';
  FmaxCount := 20;
  Height := 55;
  ComboBox := TComboBox.Create(Self);
  with ComboBox do begin
    Name := 'ComboBox';
    Parent := Self;
    Top := 5;
    Height := 28;
    Left := 5;
    Width := Self.Width - 43;
    Anchors := [akBottom, akLeft, akRight];
  end;
  LoadComboBox_from_XML(ComboBox, ADefaultText);

  Button := TButton.Create(Self);
  with Button do begin
    Parent := Self;
    Top := 5;
    Left := Self.Width - 38;
    Width := 28;
    Height := 28;
    Caption := '...';
    Anchors := [akBottom, akRight];
    OnClick := @ButtonClick;
  end;

  OpenDialog := TOpenDialog.Create(Self);
end;

constructor TFileNameComboBox.Create(TheOwner: TComponent; AName: string);
begin
  Create(TheOwner, AName, []);
end;

destructor TFileNameComboBox.Destroy;
begin
  OpenDialog.Free;
  Button.Free;
  ComboBox.Free;
  inherited Destroy;
end;

procedure TFileNameComboBox.ComboBox_Insert_Text(cb: TComboBox);
var
  i: integer;
  s: string;
begin
  s := cb.Text;
  i := cb.Items.IndexOf(s);
  if i >= 0 then begin
    cb.Items.Delete(i);
  end;

  cb.Items.Insert(0, s);

  if cb.Items.Count > FmaxCount then begin
    cb.Items.Delete(cb.Items.Count - 1);
  end;

  cb.Text := s;
end;

procedure TFileNameComboBox.ButtonClick(Sender: TObject);
begin
  OpenDialog.FileName := ComboBox.Text;
  if OpenDialog.Execute then begin
    ComboBox.Text := OpenDialog.FileName;
    ComboBox_Insert_Text(ComboBox);
    SaveComboBox_to_XML(ComboBox);
  end;
end;

procedure TFileNameComboBox.LoadStrings_from_XML(Key: string; sl: TStrings; Default_Text: TStringArray);
var
  Cfg: TConfigStorage;
  ct, i: integer;
  s: string;
begin
  Cfg := GetIDEConfigStorage(FConfigFile, True);
  ct := Cfg.GetValue(Key + 'Count', 0);
  sl.Clear;

  for i := 0 to ct - 1 do begin
    s := Cfg.GetValue(Key + 'Item' + i.ToString + '/value', '');
    sl.Add(s);
  end;

  for i := 0 to Length(Default_Text) - 1 do begin
    if sl.Count < FmaxCount then begin
      if sl.IndexOf(Default_Text[i]) < 0 then begin
        sl.Add(Default_Text[i]);
      end;
    end;
  end;

  Cfg.Free;
end;

procedure TFileNameComboBox.SaveStrings_to_XML(Key: string; sl: TStrings);
var
  Cfg: TConfigStorage;
  i: integer;
begin
  Cfg := GetIDEConfigStorage(FConfigFile, True);
  Cfg.DeletePath(Key);
  Cfg.SetValue(Key + 'Count', sl.Count);
  for i := 0 to sl.Count - 1 do begin
    Cfg.SetValue(Key + 'Item' + i.ToString + '/value', sl[i]);
  end;
  Cfg.Free;
end;

procedure TFileNameComboBox.LoadComboBox_from_XML(cb: TComboBox; Default_Text: TStringArray);
var
  Key: string;
begin
  Key := getParents(cb);
  LoadStrings_from_XML(Key, cb.Items, Default_Text);
  if cb.Items.Count > 0 then begin
    cb.Text := cb.Items[0];
  end else begin
    cb.Text := '';
  end;
end;

procedure TFileNameComboBox.SaveComboBox_to_XML(cb: TComboBox);
var
  Key: string;
begin
  Key := getParents(cb);
  SaveStrings_to_XML(Key, cb.Items);
end;

end.
