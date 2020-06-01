unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ComCtrls,
  XMLConf,
  XMLRead, XMLWrite, DOM;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button3: TButton;
    PageControl1: TPageControl;
    TabSheet_Low_Fuse: TTabSheet;
    TabSheet_High_Fuse: TTabSheet;
    TabSheet_Ext_Fuse: TTabSheet;
    TabSheet_Lok_Bit: TTabSheet;
    TreeView1: TTreeView;
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    function IsAttribut(Node: TDOMNode; const NodeName, NodeValue: string): boolean;
    function GetAttribut(Node: TDOMNode; const NodeName: string): string;
  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}


const
  //  path = 'test.xml';
  //  path = 'XML/attiny13a.xml';
  path = 'XML/atmega328p.xml';
//  path = 'XML/attiny4.xml';

const
  Options_File = 'config.xml';
  FormPos = '/FormPos/';

procedure LoadFormPos_from_XML(Form: TControl);
var
  Cfg: TXMLConfig;     // Auf Package anpassen !!!!!!!!!!
begin
  Cfg := TXMLConfig.Create(nil);
  Cfg.Filename := Options_File;
  Form.Left := Cfg.GetValue(Form.Name + FormPos + 'Left', Form.Left);
  Form.Top := Cfg.GetValue(Form.Name + FormPos + 'Top', Form.Top);
  Form.Width := Cfg.GetValue(Form.Name + FormPos + 'Width', Form.Width);
  Form.Height := Cfg.GetValue(Form.Name + FormPos + 'Height', Form.Height);
  Cfg.Free;
end;

procedure SaveFormPos_to_XML(Form: TControl);
var
  Cfg: TXMLConfig;          // Auf Package anpassen !!!!!!!!!!
begin
  Cfg := TXMLConfig.Create(nil);
  Cfg.Filename := Options_File;
  Cfg.SetValue(Form.Name + FormPos + 'Left', Form.Left);
  Cfg.SetValue(Form.Name + FormPos + 'Top', Form.Top);
  Cfg.SetValue(Form.Name + FormPos + 'Width', Form.Width);
  Cfg.SetValue(Form.Name + FormPos + 'Height', Form.Height);
  Cfg.Free;
end;

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

/// --- public

procedure TForm1.Button3Click(Sender: TObject);
var
  FuseName, s: string;
  ofs,
  i, j, k: integer;
  doc: TXMLDocument;
  Node_Modules, Node_Module, Node_Register_group, Node_Register, Node_Bitfield: TDOMNode;

  CheckBox: TCheckBox;
  ComboBox: TComboBox;
begin
  TreeView1.Items.Clear;
  ReadXMLFile(doc, path);
  ofs:=5;

  Node_Modules := doc.DocumentElement.FindNode('modules');
  if Node_Modules <> nil then begin

    Node_Module := Node_Modules.FirstChild;
    while Node_Module <> nil do begin
      if Node_Module.NodeName = 'module' then begin
        if IsAttribut(Node_Module, 'name', 'FUSE') then begin

          Node_Register_group := Node_Module.FirstChild;
          if Node_Register_group <> nil then begin
            Node_Register := Node_Register_group.FirstChild;
            while Node_Register <> nil do begin
              TreeView1.Items.Add(nil, 'register');

              FuseName := GetAttribut(Node_Register, 'name');
              TreeView1.Items.Add(nil, FuseName);

              Node_Bitfield := Node_Register.FirstChild;
              while Node_Bitfield <> nil do begin

                if GetAttribut(Node_Bitfield, 'values') <> '' then begin
                  ComboBox := TComboBox.Create(Self);
                  ComboBox.Parent:=TabSheet_Low_Fuse;
                  ComboBox.Top:=ofs;
                  ComboBox.Items.Add(GetAttribut(Node_Bitfield, 'caption'));
                  Inc(ofs, ComboBox.Height);
                end else begin
                  CheckBox := TCheckBox.Create(Self);
                  CheckBox.Parent:=TabSheet_Low_Fuse;
                  CheckBox.Top:=ofs;
                  CheckBox.Caption:=GetAttribut(Node_Bitfield, 'caption');
                  Inc(ofs, CheckBox.Height);
                end;
                TreeView1.Items.Add(nil, GetAttribut(Node_Bitfield, 'caption'));

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

  doc.Free;

end;

procedure TForm1.Button1Click(Sender: TObject);
begin
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  LoadFormPos_from_XML(self);
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  SaveFormPos_to_XML(self);
end;

end.
