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
    Button1: TButton;
    Button2: TButton;
    TreeView1: TTreeView;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}


const
    path = 'test.xml';
//  path = 'XML/attiny4.xml';

const
  Options_File = 'config.xml';
  FormPos = '/FormPos/';

procedure LoadFormPos_from_XML(Form: TControl);
var
  Cfg: TXMLConfig;
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
  Cfg: TXMLConfig;
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

procedure TForm1.Button1Click(Sender: TObject);
var
  doc: TXMLDocument;
  poly_Node: TDOMNode;

  nodeList: TDOMNodeList;

  procedure Node(n: TDOMNodeList; t: TTreeNode; schachtel: integer);
  var
    i, j: integer;
  begin
    for i := 0 to n.Count - 1 do begin
      if n.Item[i].NodeName = '#text' then begin
        TreeView1.Items.AddChild(t, n.Item[i].NodeValue);
      end else begin
        TreeView1.Items.AddChild(t, n.Item[i].NodeName);
      end;

      if n.Item[i].HasAttributes then begin
        for j := 0 to n.Item[i].Attributes.Length - 1 do begin
          TreeView1.Items.AddChild(t.Items[i], n.Item[i].Attributes.Item[j].NodeName +
            '= "' + n.Item[i].Attributes.Item[j].NodeValue+'"');
        end;
      end;

      if n.Item[i].HasChildNodes then begin
        Node(n.Item[i].ChildNodes, t.Items[i], schachtel + 1);
      end;

    end;
  end;

begin
  TreeView1.Items.Clear;
  ReadXMLFile(doc, path);

  //  poly_Node := doc.DocumentElement.FindNode('test');

  //  Memo1.Lines.Add(poly_Node.FirstChild.NodeValue);
  //  Memo1.Lines.Add(poly_Node.TextContent);

  //  nodeList := doc.DocumentElement.ChildNodes;


  nodeList := doc.DocumentElement.ChildNodes;
  TreeView1.Items.Add(nil, 'abc');
  Node(nodeList, TreeView1.Items[0], 0);

  //with nodeList do begin
  //  ct := Count;
  //  Memo1.Lines.Add(ct.ToString);
  //end;
  //
  doc.Free;

  //Doc := TXMLDocument.Create;
  //WriteXMLFile(doc, path);
  //doc.Free;
  TreeView1.FullExpand;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  doc: TXMLDocument;

  s, nodeName: string;

  procedure Node(ANode: TDOMNode; t: TTreeNode; schachtel: integer);
  var
    i, j: integer;
    child: TDOMNode;
  begin
    nodeName := ANode.NodeName;
    if ANode.NodeName = '#text' then begin
      TreeView1.Items.AddChild(t, ANode.NodeValue);
    end else begin

      TreeView1.Items.AddChild(t, ANode.NodeName);
    end;

    if ANode.HasAttributes then begin
      for j := 0 to ANode.Attributes.Length - 1 do begin
        TreeView1.Items.AddChild(t.Items[i], ANode.Attributes.Item[j].NodeName +          '= "' + ANode.Attributes.Item[j].NodeValue+'"');
      end;
    end;

    child := ANode.FirstChild;
    while child <> nil do begin
      Node(child, t.Items[i], schachtel + 1);
      child := child.NextSibling;
    end;

  end;

begin
  TreeView1.Items.Clear;
  ReadXMLFile(doc, path);
  TreeView1.Items.Add(nil, 'abc');
  Node(doc.DocumentElement, TreeView1.Items[0], 0);
  doc.Free;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  SaveFormPos_to_XML(self);
end;

end.
