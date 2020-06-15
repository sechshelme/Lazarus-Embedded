unit Embedded_GUI_AVR_Fuse_Form;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ComCtrls,
  ExtCtrls, FileUtil, Laz2_XMLCfg, laz2_XMLRead, laz2_XMLWrite, laz2_DOM,
  //  XMLConf, XMLRead, XMLWrite, DOM,
  Embedded_GUI_Common,
  Embedded_GUI_AVR_Fuse_Common,
  Embedded_GUI_AVR_Fuse_Burn_Form;

type

  { TForm_AVR_Fuse }

  TForm_AVR_Fuse = class(TForm)
    ComboBox1: TComboBox;
    Label1: TLabel;
    PageControl1: TPageControl;
    procedure ComboBox1Change(Sender: TObject);
    procedure CreateTab(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    procedure FuseTabBurnButtonClick(Sender: TObject);
    procedure FuseTabCheckBoxChange(Sender: TObject);
    function IsAttribut(Node: TDOMNode; const NodeName, NodeValue: string): boolean;
    function GetAttribut(Node: TDOMNode; const NodeName: string): string;
    procedure Read_Value_Group(const Attr_name: string; Node: TDOMNode; ComboBox: TFuseComboBox);
    procedure ClearTabs;
  private
    path: string;
    FuseTab: array of record
      FuseByte: byte;
      TabSheet: TTabSheet;
      ofs: integer;
      CheckBox: array of TFuseCheckBox;
      ComboBox: array of TFuseComboBox;
      StaticText: array of TStaticText;
      Panel: TPanel;
      FuseLabel: TLabel;
      FuseEdit: TEdit;
      BurnButton: TButton;
    end;
  public
  end;

var
  Form_AVR_Fuse: TForm_AVR_Fuse;

implementation

{$R *.lfm}

{ TForm_AVR_Fuse }

/// --- private

function TForm_AVR_Fuse.IsAttribut(Node: TDOMNode; const NodeName, NodeValue: string): boolean;
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

function TForm_AVR_Fuse.GetAttribut(Node: TDOMNode; const NodeName: string): string;
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

procedure TForm_AVR_Fuse.ClearTabs;
var
  i, j: integer;
begin
  for i := 0 to Length(FuseTab) - 1 do begin
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

      FuseLabel.Free;
      FuseEdit.Free;
      TabSheet.Free;
    end;

  end;
  SetLength(FuseTab, 0);
end;

procedure TForm_AVR_Fuse.Read_Value_Group(const Attr_name: string; Node: TDOMNode; ComboBox: TFuseComboBox);
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
        ComboBox.Add(s, GetAttribut(Node_Value, 'value').ToInteger);
        Node_Value := Node_Value.NextSibling;
      end;
    end;
    Node_Value_Group := Node_Value_Group.NextSibling;
  end;

end;

/// --- public

procedure TForm_AVR_Fuse.FormCreate(Sender: TObject);
var
  fl: TStringList;
  i: integer;
begin
  Caption := Title + 'AVR Fuse';
  ComboBox1.Sorted := True;
  ComboBox1.Style := csOwnerDrawFixed;

  fl := FindAllFiles('../AVR_Fuse/XML', '*.XML', False);
  for i := 0 to fl.Count - 1 do begin
    ComboBox1.Items.Add(fl[i]);
  end;
  fl.Free;

  LoadFormPos_from_XML(self);
end;

procedure TForm_AVR_Fuse.ComboBox1Change(Sender: TObject);
begin
  //  path := ComboBox1.Items[ComboBox1.ItemIndex];
  path := ComboBox1.Text;
  Caption := path;
  if FileExists(path) then begin
    ClearTabs;
    CreateTab(Sender);
  end;
end;

procedure TForm_AVR_Fuse.CreateTab(Sender: TObject);
var
  l: integer;
  doc: TXMLDocument;
  Node_Modules, Node_Module, Node_Register_group, Node_Register, Node_Bitfield: TDOMNode;

  procedure AddFuse(Node_Register: TDOMNode);
  var
    i: integer;
  begin
    i := Length(FuseTab);
    SetLength(FuseTab, i + 1);
    with FuseTab[i] do begin
      ofs := 5;
      TabSheet := TTabSheet.Create(Self);
      with TabSheet do begin
        Tag := i;
        PageControl := PageControl1;
        Caption := GetAttribut(Node_Register, 'name');
      end;

      //      PageControl1.Pages[i].Hint:=GetAttribut(Node_Register, 'caption');
      //      PageControl1.Pages[i].ShowHint:=True;

      Panel := TPanel.Create(Self);
      with Panel do begin
        Parent := TabSheet;
        Top := PageControl1.Height - 90;
        Height := 2;
        Left := 0;
        Width := TabSheet.Width;
        Anchors := [akBottom, akLeft, akRight];
      end;

      FuseLabel := TLabel.Create(Self);
      with FuseLabel do begin
        Tag := i;
        Caption := TabSheet.Caption + ':';
        Parent := TabSheet;
        Left := 10;
        Top := PageControl1.Height - 80;
        Anchors := [akBottom, akLeft];
      end;

      FuseEdit := TEdit.Create(Self);
      with FuseEdit do begin
        Tag := i;
        Parent := TabSheet;
        Enabled := False;
        Left := 230;
        Top := PageControl1.Height - 80;
        Width := 50;
        Text := '';
        Anchors := [akBottom, akLeft];
      end;

      BurnButton := TButton.Create(Self);
      with BurnButton do begin
        Tag := i;
        Parent := TabSheet;
        Left := 330;
        Top := PageControl1.Height - 80;
        Width := 50;
        Text := 'Burn';
        Anchors := [akBottom, akLeft];
        OnClick := @FuseTabBurnButtonClick;
      end;
    end;

  end;

begin
  ReadXMLFile(doc, path);

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

              AddFuse(Node_Register);

              Node_Bitfield := Node_Register.FirstChild;
              while Node_Bitfield <> nil do begin

                with FuseTab[Length(FuseTab) - 1] do begin
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

procedure TForm_AVR_Fuse.FormDestroy(Sender: TObject);
var
  i: integer;
begin
  SaveFormPos_to_XML(self);
  for i := 0 to Length(FuseTab) - 1 do begin
    with FuseTab[i] do begin
      TabSheet.Free;
      Panel.Free;
      FuseEdit.Free;
      FuseLabel.Free;
      BurnButton.Free;
    end;
  end;
  SetLength(FuseTab, 0);
end;

procedure TForm_AVR_Fuse.FuseTabBurnButtonClick(Sender: TObject);
var
  f:TForm_AVR_Fuse_Burn;

begin
  if Sender is TButton then begin
    f:=TForm_AVR_Fuse_Burn.Create(Self);

    f.ShowModal;
    f.Free;
//    ShowMessage('Button ' + TButton(Sender).Tag.ToString + ' gedrückt');
  end;
end;

procedure TForm_AVR_Fuse.FuseTabCheckBoxChange(Sender: TObject);
var
  i, j, m: integer;
begin
  if Sender is TCheckBox then begin
    Label1.Caption := '';
    for i := 0 to Length(FuseTab) - 1 do begin
      with FuseTab[i] do begin
        FuseByte := 0;
        for j := 0 to Length(CheckBox) - 1 do begin
          FuseByte += CheckBox[j].Mask;
        end;
        for j := 0 to Length(ComboBox) - 1 do begin
          FuseByte += ComboBox[j].Mask;
        end;
        FuseEdit.Enabled := True;
        FuseEdit.Text := '0x' + IntToHex(not FuseByte, 2);
        Label1.Caption := Label1.Caption + '    ' + FuseByte.ToBinString;
      end;
    end;
  end;
end;

end.
