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
    Button3: TButton;
    TreeView1: TTreeView;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
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

  procedure Node(ADOMNodeList: TDOMNodeList; ATreeNode: TTreeNode; schachtel: integer);
  var
    i, j: integer;
  begin
    for i := 0 to ADOMNodeList.Count - 1 do begin
      if ADOMNodeList.Item[i].NodeName = '#text' then begin
        TreeView1.Items.AddChild(ATreeNode, ADOMNodeList.Item[i].NodeValue);
      end else begin
        TreeView1.Items.AddChild(ATreeNode, ADOMNodeList.Item[i].NodeName);
      end;

      if ADOMNodeList.Item[i].HasAttributes then begin
        for j := 0 to ADOMNodeList.Item[i].Attributes.Length - 1 do begin
          TreeView1.Items.AddChild(ATreeNode.Items[i],
            ADOMNodeList.Item[i].Attributes.Item[j].NodeName + '= "' +
            ADOMNodeList.Item[i].Attributes.Item[j].NodeValue + '"');
        end;
      end;

      if ADOMNodeList.Item[i].HasChildNodes then begin
        Node(ADOMNodeList.Item[i].ChildNodes, ATreeNode.Items[i], schachtel + 1);
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
  TreeView1.Items.Add(nil, doc.DocumentElement.NodeName);
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

  procedure Node(ADOMNode: TDOMNode; ATreeNode: TTreeNode);
  var
    j: integer;
    child: TDOMNode;
    tree: TTreeNode;
  begin
    if ADOMNode.NodeName = '#text' then begin
      TreeView1.Items.AddChild(ATreeNode, ADOMNode.NodeValue);
    end else begin
      TreeView1.Items.AddChild(ATreeNode, ADOMNode.NodeName);
    end;

    if ADOMNode.HasAttributes then begin
      for j := 0 to ADOMNode.Attributes.Length - 1 do begin
        TreeView1.Items.AddChild(ATreeNode.GetLastChild,
          ADOMNode.Attributes.Item[j].NodeName + '= "' +
          ADOMNode.Attributes.Item[j].NodeValue + '"');
      end;
    end;

    child := ADOMNode.FirstChild;
    tree := ATreeNode.GetLastChild;
    while child <> nil do begin
      Node(child, tree);
      child := child.NextSibling;
    end;

  end;

begin
  TreeView1.Items.Clear;
  ReadXMLFile(doc, path);
  TreeView1.Items.Add(nil, path);
  Node(doc.DocumentElement, TreeView1.BottomItem);
  doc.Free;
  TreeView1.FullExpand;
end;

procedure TForm1.Button3Click(Sender: TObject);
var
  doc: TXMLDocument;
  Node, ChildNode, FNode: TDOMNode;
begin
  TreeView1.Items.Clear;
  ReadXMLFile(doc, path);

  Node := doc.DocumentElement.FindNode('MyForm');

  if Node <> nil then begin
    ChildNode := Node.FindNode('sl');

    if ChildNode <> nil then begin

      FNode := ChildNode.FirstChild;

      if ChildNode.FindNode('item') <> nil then begin
        TreeView1.Items.Add(nil, 'item');
      end;

      while FNode <> nil do begin
        //        if (FNode <> nil) and (FNode.FindNode('item') <> nil) then begin
        if (FNode <> nil) then begin
          if FNode.NodeName = 'item' then begin
            TreeView1.Items.Add(nil, 'item gefunden');
          end;
        end;
        FNode := FNode.NextSibling;
      end;


      //      ChildNode := ChildNode.FindNode('item');
      //      if ChildNode <> nil then begin
      //      end;
    end;
  end;

  doc.Free;


  //TreeView1.Items.Clear;
  //TreeView1.Items.AddChild(nil, 'bla bla 1');
  //TreeView1.Items.AddChild(TreeView1.TopItem, 'bla bla 2');
  //TreeView1.Items.AddChild(nil, 'bla bla 3');
  //TreeView1.Items.AddChild(TreeView1.TopItem, 'bla bla 4');
  //TreeView1.FullExpand;
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
