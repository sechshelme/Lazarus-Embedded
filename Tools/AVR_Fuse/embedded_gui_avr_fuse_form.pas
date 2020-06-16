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
    Button_Close: TButton;
    ComboBox1: TComboBox;
    Label1: TLabel;
    PageControl1: TPageControl;
    procedure Button_CloseClick(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure CreateTab(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    function IsAttribut(Node: TDOMNode; const NodeName, NodeValue: string): boolean;
    function GetAttribut(Node: TDOMNode; const NodeName: string): string;
    procedure Read_Value_Group(const Attr_name: string; Node: TDOMNode; TabSheet: TFuseTabSheet);
    procedure ClearTabs;
  private
    path: string;
      FuseTabSheet: array of TFuseTabSheet;
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
  for i := 0 to Length(FuseTabSheet) - 1 do begin
    FuseTabSheet[i].Free;
  end;
  SetLength(FuseTabSheet, 0);
end;

procedure TForm_AVR_Fuse.Read_Value_Group(const Attr_name: string; Node: TDOMNode; TabSheet: TFuseTabSheet);
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
        TabSheet.AddComboxItem(s, GetAttribut(Node_Value, 'value').ToInteger);
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

procedure TForm_AVR_Fuse.Button_CloseClick(Sender: TObject);
begin
  Close;
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
    i := Length(FuseTabSheet);
    SetLength(FuseTabSheet, i + 1);
      FuseTabSheet[i] := TFuseTabSheet.Create(Self);
      with FuseTabSheet[i] do begin
        Tag := i;
        PageControl := PageControl1;
        Caption := GetAttribut(Node_Register, 'name');
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

                l:=Length(FuseTabSheet) - 1;
                if GetAttribut(Node_Bitfield, 'values') <> '' then begin
                  FuseTabSheet[l].NewComboBox(GetAttribut(Node_Bitfield, 'caption') + ' (' + GetAttribut(Node_Bitfield, 'name') + '):',
                    StrToInt(GetAttribut(Node_Bitfield, 'mask')));
                  Read_Value_Group(GetAttribut(Node_Bitfield, 'values'), Node_Module, FuseTabSheet[l]);
                end else begin
                  FuseTabSheet[l].AddCheckBox(GetAttribut(Node_Bitfield, 'caption') + ' (' + GetAttribut(Node_Bitfield, 'name') + ')',
                    StrToInt(GetAttribut(Node_Bitfield, 'mask')));
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
  for i := 0 to Length(FuseTabSheet) - 1 do begin
    FuseTabSheet[i].Free;
  end;
  SetLength(FuseTabSheet, 0);
end;

end.
