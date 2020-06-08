unit Embedded_GUI_AVR_Fuse_Form;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ComCtrls,
  FileUtil,
  Laz2_XMLCfg, laz2_XMLRead, laz2_XMLWrite, laz2_DOM,
  //  XMLConf, XMLRead, XMLWrite, DOM,
  Embedded_GUI_Common,
  Embedded_GUI_AVR_Fuse_Common;

type

  { TForm1 }

  TForm1 = class(TForm)
    ComboBox1: TComboBox;
    Label1: TLabel;
    PageControl1: TPageControl;
    procedure ComboBox1Change(Sender: TObject);
    procedure CreateTab(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    procedure FuseTabCheckBoxChange(Sender: TObject);
    function IsAttribut(Node: TDOMNode; const NodeName, NodeValue: string): boolean;
    function GetAttribut(Node: TDOMNode; const NodeName: string): string;
    procedure Read_Value_Group(const Attr_name: string; Node: TDOMNode; cm: TFuseComboBox);
    procedure ClearTabs;
  private
    path: string;
    FuseTab: array[0..3] of record
      FuseByte: byte;
      TabSheet: TTabSheet;
      ofs: integer;
      CheckBox: array of TFuseCheckBox;
      ComboBox: array of TFuseComboBox;
      StaticText: array of TStaticText;
      FuseText: TStaticText;
      FuseEdit: TEdit;
    end;
  public
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

/// --- private

function TForm1.IsAttribut(Node: TDOMNode; const NodeName, NodeValue: string): boolean;
var
  i: integer;
begin
  Result := False;
  if Node.HasAttributes then begin
    for i := 0 to Node.Attributes.Length - 1 do begin
      if Node.Attributes[i].NodeName = NodeName then begin
        if Node.Attributes[i].NodeValue = NodeValue then begin
          Result := True;
        end;
      end;
    end;
  end;
end;

function TForm1.GetAttribut(Node: TDOMNode; const NodeName: string): string;
var
  i: integer;
begin
  Result := '';
  if Node.HasAttributes then begin
    for i := 0 to Node.Attributes.Length - 1 do begin
      if Node.Attributes[i].NodeName = NodeName then begin
        Result := Node.Attributes[i].NodeValue;
      end;
    end;
  end;
end;

procedure TForm1.ClearTabs;
var
  i, j: integer;
begin
  for i := 0 to Length(FuseTab) - 1 do begin
    FuseTab[i].TabSheet.TabVisible := False;
    with FuseTab[i] do begin
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
      FuseText.Enabled := False;
      FuseEdit.Enabled := False;
      ofs := 5;
    end;
  end;
end;

procedure TForm1.Read_Value_Group(const Attr_name: string; Node: TDOMNode; cm: TFuseComboBox);
var
  Node_Value_Group, Node_Value: TDOMNode;
  s: string;
begin
  Node_Value_Group := Node.FirstChild;
  while Node_Value_Group <> nil do begin
    if IsAttribut(Node_Value_Group, 'name', Attr_name) then begin
      Node_Value := Node_Value_Group.FirstChild;
      while Node_Value <> nil do begin
        s := GetAttribut(Node_Value, 'caption');
        s += ' (' + GetAttribut(Node_Value, 'name') + ')';
        cm.Add(s, GetAttribut(Node_Value, 'value').ToInteger);
        Node_Value := Node_Value.NextSibling;
      end;
    end;
    Node_Value_Group := Node_Value_Group.NextSibling;
  end;

end;

/// --- public

procedure TForm1.CreateTab(Sender: TObject);
var
  FuseName: string;
  aktFuse, i, l: integer;
  doc: TXMLDocument;
  Node_Modules, Node_Module, Node_Register_group, Node_Register, Node_Bitfield: TDOMNode;

  function GetFuse(FuseName: string): integer;
  begin
    case FuseName of
      'LOW', 'BYTE0': begin
        Result := 0;
      end;
      'HIGH': begin
        Result := 1;
      end;
      'EXTENDED': begin
        Result := 2;
      end;
      'LOCKBIT': begin
        Result := 3;
      end;
      else begin
        ShowMessage('Ungültiger Fuse-Name');
        Result := 0;
      end;
    end;
  end;

begin
  ReadXMLFile(doc, path);

  for i := 0 to Length(FuseTab) - 1 do begin
    FuseTab[i].ofs := 5;
  end;

  Node_Modules := doc.DocumentElement.FindNode('modules');
  if Node_Modules <> nil then begin

    Node_Module := Node_Modules.FirstChild;
    while Node_Module <> nil do begin
      if Node_Module.NodeName = 'module' then begin
        if (IsAttribut(Node_Module, 'name', 'FUSE')) or (IsAttribut(Node_Module, 'name', 'LOCKBIT')) then begin

          Node_Register_group := Node_Module.FirstChild;
          if Node_Register_group <> nil then begin
            Node_Register := Node_Register_group.FirstChild;
            while Node_Register <> nil do begin

              FuseName := GetAttribut(Node_Register, 'name');
              aktFuse := GetFuse(FuseName);
              FuseTab[aktFuse].TabSheet.TabVisible := True;
              FuseTab[aktFuse].FuseText.Enabled := True;
              FuseTab[aktFuse].FuseEdit.Enabled := True;

              Node_Bitfield := Node_Register.FirstChild;
              while Node_Bitfield <> nil do begin

                with FuseTab[aktFuse] do begin
                  if GetAttribut(Node_Bitfield, 'values') <> '' then begin
                    Inc(ofs, 10);

                    l := Length(StaticText);
                    SetLength(StaticText, l + 1);
                    StaticText[l] := TStaticText.Create(Self);
                    with StaticText[l] do begin
                      Parent := TabSheet;
                      Caption := GetAttribut(Node_Bitfield, 'caption') + ' (' + GetAttribut(Node_Bitfield, 'name') + '):';
                      Top := ofs;
                      Width := TabSheet.Width;
                      Inc(ofs, Height + 5);
                    end;

                    l := Length(ComboBox);
                    SetLength(ComboBox, l + 1);
                    ComboBox[l] := TFuseComboBox.Create(Self);
                    with ComboBox[l] do begin
                      Parent := TabSheet;
                      Style := csOwnerDrawFixed;
                      Mask := StrToInt(GetAttribut(Node_Bitfield, 'mask'));
                      Read_Value_Group(GetAttribut(Node_Bitfield, 'values'), Node_Module, ComboBox[l]);
                      Top := ofs;
                      Width := TabSheet.Width;
                      Anchors := [akLeft, akRight, akTop];
                      OnChange := @FuseTabCheckBoxChange;
                      Inc(ofs, Height + 10);
                    end;
                  end else begin
                    l := Length(CheckBox);
                    SetLength(CheckBox, l + 1);
                    CheckBox[l] := TFuseCheckBox.Create(Self);
                    with CheckBox[l] do begin
                      Parent := TabSheet;
                      Caption := GetAttribut(Node_Bitfield, 'caption') + ' (' + GetAttribut(Node_Bitfield, 'name') + ')';
                      Mask := StrToInt(GetAttribut(Node_Bitfield, 'mask'));
                      Top := ofs;
                      OnChange := @FuseTabCheckBoxChange;
                      Inc(ofs, Height);
                    end;
                  end;
                end;

                Node_Bitfield := Node_Bitfield.NextSibling;
              end;
              Node_Register := Node_Register.NextSibling;
            end;
          end;
        end;
      end;
      Node_Module := Node_Module.NextSibling;
    end;
  end;
  if PageControl1.PageCount > 0 then begin
    PageControl1.TabIndex := 0;
  end;

  doc.Free;
end;

procedure TForm1.ComboBox1Change(Sender: TObject);
begin
  //  path := ComboBox1.Items[ComboBox1.ItemIndex];
  path := ComboBox1.Text;
  Caption := path;
  if FileExists(path) then begin
    ClearTabs;
    CreateTab(Sender);
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  fl: TStringList;
  i: integer;
begin
  for i := 0 to Length(FuseTab) - 1 do begin
    with FuseTab[i] do begin
      TabSheet := TTabSheet.Create(Self);
      TabSheet.TabVisible := False;
      TabSheet.PageControl := PageControl1;
      FuseText := TStaticText.Create(Self);
      with FuseText do begin
        Parent := Self;
        Enabled := False;
        Left := PageControl1.Left + i * 120;
        Top := PageControl1.Top + PageControl1.Height + 10;
        Anchors := [akBottom, akLeft];
      end;
      FuseEdit := TEdit.Create(Self);
      with FuseEdit do begin
        Parent := Self;
        Enabled := False;
        Left := PageControl1.Left + i * 120 + 70;
        Top := PageControl1.Top + PageControl1.Height + 10 + 4;
        Width := 40;
        Text := 'FF';
        Anchors := [akBottom, akLeft];
      end;
    end;
  end;
  FuseTab[0].TabSheet.Caption := 'Low Fuse';
  FuseTab[1].TabSheet.Caption := 'High Fuse';
  FuseTab[2].TabSheet.Caption := 'Ext Fuse';
  FuseTab[3].TabSheet.Caption := 'Lock Bit';
  for i := 0 to 3 do begin
    FuseTab[i].FuseText.Caption := FuseTab[i].TabSheet.Caption + ':';
  end;

  ComboBox1.Sorted := True;
  ComboBox1.Style := csOwnerDrawFixed;

  fl := FindAllFiles('../AVR_Fuse/XML', '*.XML', False);
  for i := 0 to fl.Count - 1 do begin
    ComboBox1.Items.Add(fl[i]);
  end;
  fl.Free;

  LoadFormPos_from_XML(self);
end;

procedure TForm1.FormDestroy(Sender: TObject);
var
  i: integer;
begin
  SaveFormPos_to_XML(self);
  for i := 0 to Length(FuseTab) - 1 do begin
    with FuseTab[i] do begin
      TabSheet.Free;
      FuseEdit.Free;
      FuseText.Free;
    end;
  end;
end;

procedure TForm1.FuseTabCheckBoxChange(Sender: TObject);
var
  i, j, m: integer;
begin
  Label1.Caption := '';
  for i := 0 to Length(FuseTab) - 1 do begin
    with FuseTab[i] do begin
      FuseByte := $FF;
      for j := 0 to Length(CheckBox) - 1 do begin
        FuseByte -= CheckBox[j].Mask;
      end;
      for j := 0 to Length(ComboBox) - 1 do begin
        FuseByte -= ComboBox[j].Mask;
      end;
      FuseEdit.Text := IntToHex(FuseByte, 3);
      Label1.Caption := Label1.Caption + '    ' +  (byte($FF-FuseByte)).ToBinString;
    end;
  end;
end;

end.
