unit Embedded_GUI_Common_FileComboBox;

{$mode objfpc}{$H+}

interface

uses
  {$IFDEF Packages}
  BaseIDEIntf, LazConfigStorage,  // Bei Packages
  {$ELSE}
  Laz2_XMLCfg,  // Bei normalen Anwendungen
  //  XMLConf,  // Bei normalen Anwendungen
  {$ENDIF}
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TFileNameComboBox }

  TFileNameComboBox = class(TGroupBox)
  private
    IsXML: boolean;
    FDialog: Boolean;
    FConfigFile: string;
    FmaxCount: integer;
    ComboBox: TComboBox;
    Button: TButton;
    OpenDialog: TOpenDialog;
    OpenDirectory: TSelectDirectoryDialog;
    procedure ButtonClick(Sender: TObject);
    procedure ComboBoxEditingDone(Sender: TObject);
    procedure ComboBox_Insert_Text(cb: TComboBox);
    function GetItems: TStrings;
    function GetText: string;
    procedure LoadComboBox_from_XML(cb: TComboBox);
    procedure SaveComboBox_to_XML(cb: TComboBox);
    procedure SetItems(AValue: TStrings);
    procedure SetText(AValue: string);
  public
    constructor Create(AParent: TWinControl; AName: string);
    constructor Create(AParent: TWinControl; AName: string; AIsXML: boolean);
    destructor Destroy; override;
    property Directory: Boolean read FDialog write FDialog;
    property Items: TStrings read GetItems write SetItems;
    property Text: string read GetText write SetText;
    property ConfigFile: string read FConfigFile write FConfigFile;
    property maxCount: integer read FmaxCount write FmaxCount;
  end;

implementation

uses
  Embedded_GUI_Common;

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
  until p = nil;
end;

{ TFileNameComboBox }

constructor TFileNameComboBox.Create(AParent: TWinControl; AName: string; AIsXML: boolean);
begin
  inherited Create(AParent);
  Directory := False;
  if AName = '' then begin
    raise EComponentError.Create('TFileNameComboBox.Name ist zwingend');
  end;
  if not IsValidIdent(AName) then begin
    raise EComponentError.Create('Ungültiger Name');
  end;
  Parent := AParent;
  Caption := AName;
  Name := AName;
  {$IFDEF Packages}
  FConfigFile := Embedded_Options_File;
  {$ELSE}
  FConfigFile := 'config.xml';
  {$ENDIF}
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
    OnEditingDone := @ComboBoxEditingDone;
  end;

  IsXML := AIsXML;
  if IsXML then begin
    LoadComboBox_from_XML(ComboBox);
  end;

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
  OpenDirectory := TSelectDirectoryDialog.Create(Self);
end;

constructor TFileNameComboBox.Create(AParent: TWinControl; AName: string);
begin
  Create(AParent, AName, True);
end;

destructor TFileNameComboBox.Destroy;
begin
  OpenDirectory.Free;
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

procedure TFileNameComboBox.SetItems(AValue: TStrings);
begin
  ComboBox.Items.AddStrings(AValue, True);
  if ComboBox.Items.Count > 0 then begin
    ComboBox.Text := ComboBox.Items[0];
  end;
end;

function TFileNameComboBox.GetItems: TStrings;
begin
  Result := ComboBox.Items;
end;

procedure TFileNameComboBox.SetText(AValue: string);
var
  i: integer;
begin
  i := ComboBox.Items.IndexOf(AValue);
  if i >= 0 then begin
    ComboBox.Items.Delete(i);
  end;

  ComboBox.Items.Insert(0, AValue);

  if ComboBox.Items.Count > FmaxCount then begin
    ComboBox.Items.Delete(ComboBox.Items.Count - 1);
  end;

  ComboBox.Text := AValue;
end;

function TFileNameComboBox.GetText: string;
begin
  Result := ComboBox.Text;
end;

procedure TFileNameComboBox.ButtonClick(Sender: TObject);
begin
  if Directory then begin
    OpenDirectory.FileName := ComboBox.Text;
    if OpenDirectory.Execute then begin
      ComboBox.Text := OpenDirectory.FileName;
      ComboBox_Insert_Text(ComboBox);
      if IsXML then begin
        SaveComboBox_to_XML(ComboBox);
      end;
    end;
  end else begin
    OpenDialog.FileName := ComboBox.Text;
    if OpenDialog.Execute then begin
      ComboBox.Text := OpenDialog.FileName;
      ComboBox_Insert_Text(ComboBox);
      if IsXML then begin
        SaveComboBox_to_XML(ComboBox);
      end;
    end;
  end;
end;

procedure TFileNameComboBox.ComboBoxEditingDone(Sender: TObject);
begin
  ComboBox_Insert_Text(ComboBox);
  if IsXML then begin
    SaveComboBox_to_XML(ComboBox);
  end;
end;

procedure TFileNameComboBox.LoadComboBox_from_XML(cb: TComboBox);
var
  Key: string;
  Cfg: TConfigStorage;
  ct, i: integer;
  s: string;
begin
  Key := getParents(Self);

  Cfg := GetIDEConfigStorage(FConfigFile, True);
  ct := Cfg.GetValue(Key + 'Count', 0);
  cb.Items.Clear;

  for i := 0 to ct - 1 do begin
    s := Cfg.GetValue(Key + 'Item' + i.ToString + '/value', '');
    cb.Items.Add(s);
  end;

  //for i := 0 to Length(Default_Text) - 1 do begin
  //  if cb.Items.Count < FmaxCount then begin
  //    if cb.Items.IndexOf(Default_Text[i]) < 0 then begin
  //      cb.Items.Add(Default_Text[i]);
  //    end;
  //  end;
  //end;

  Cfg.Free;
  if cb.Items.Count > 0 then begin
    cb.Text := cb.Items[0];
  end else begin
    cb.Text := '';
  end;
end;

procedure TFileNameComboBox.SaveComboBox_to_XML(cb: TComboBox);
var
  Cfg: TConfigStorage;
  i: integer;
  Key: string;
begin
  Key := getParents(Self);
  Cfg := GetIDEConfigStorage(FConfigFile, True);
  Cfg.DeletePath(Key);
  Cfg.SetValue(Key + 'Count', cb.Items.Count);
  for i := 0 to cb.Items.Count - 1 do begin
    Cfg.SetValue(Key + 'Item' + i.ToString + '/value', cb.Items[i]);
  end;
  Cfg.Free;
end;

end.
