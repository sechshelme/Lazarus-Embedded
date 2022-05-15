unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Grids,
  Laz2_DOM, laz2_XMLRead, Types;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Memo1: TMemo;
    StringGrid1: TStringGrid;
    procedure Button1Click(Sender: TObject);
    procedure StringGrid1DrawCell(Sender: TObject; aCol, aRow: integer; aRect: TRect; aState: TGridDrawState);
    procedure StringGrid1PrepareCanvas(Sender: TObject; aCol, aRow: integer; aState: TGridDrawState);
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.Button1Click(Sender: TObject);
var
  xml: TXMLDocument;
  n, signalDOMNode, instanceDOMNode, moduleDOMNode, DOMNode: TDOMNode;
  Attribut: TDOMNamedNodeMap;
  index, i, c: integer;
  s: string;
  cellText: TStringList;
begin
  index := 1;
  cellText := TStringList.Create;
  ReadXMLFile(xml, '/n4800/DATEN/Programmierung/Lazarus/Tutorials/Embedded/Tools/AVR_XML_to_Fuse_Const/XML/ATmega328P.xml');
  ReadXMLFile(xml, '/n4800/DATEN/Programmierung/Lazarus/Tutorials/Embedded/Tools/AVR_XML_to_Fuse_Const/XML/ATmega2560.xml');
  DOMNode := xml.DocumentElement.FindNode('variants');
  DOMNode := DOMNode.FindNode('variant');

  if DOMNode = nil then begin
    ShowMessage('dsfs');
  end else begin
    s := DOMNode.ToString;
    Memo1.Lines.Add(s);

    s := DOMNode.ChildNodes.Count.ToString;
    Memo1.Lines.Add(s);

  end;

  DOMNode := xml.DocumentElement.FindNode('devices');
  DOMNode := DOMNode.FindNode('device');
  DOMNode := DOMNode.FindNode('peripherals');
  moduleDOMNode := DOMNode.FindNode('module');

  while moduleDOMNode <> nil do begin
    if moduleDOMNode.HasAttributes then begin
      cellText.Add(moduleDOMNode.Attributes.Item[0].NodeValue);
      Memo1.Lines.Add('module: ' + moduleDOMNode.Attributes.Item[0].NodeValue);
    end;

    instanceDOMNode := moduleDOMNode.FindNode('instance');

    while instanceDOMNode <> nil do begin

      if instanceDOMNode.HasAttributes then begin
        cellText.Add('  ' + instanceDOMNode.Attributes.Item[0].NodeValue);
        Memo1.Lines.Add('instance: ' + instanceDOMNode.Attributes.Item[0].NodeValue);
      end;



      c := instanceDOMNode.ChildNodes.Count;
      Memo1.Lines.Add('  instance: ' + c.ToString);

      signalDOMNode := instanceDOMNode.FindNode('signals');
      if signalDOMNode <> nil then begin
        signalDOMNode := signalDOMNode.FindNode('signal');
        while signalDOMNode <> nil do begin
          c := signalDOMNode.ChildNodes.Count;
          Memo1.Lines.Add('    signal: ' + c.ToString);

          if signalDOMNode.HasAttributes then begin
            s := '  ';
            Attribut := signalDOMNode.Attributes;
            for i := 0 to Attribut.Length - 1 do begin
              n := Attribut.Item[i];
              s := s + '     ' + n.NodeName + ': ' + n.NodeValue;

            end;
            cellText.Add(s);

            Memo1.Lines.Add(s);
          end;

          signalDOMNode := signalDOMNode.NextSibling;
        end;
      end;

      instanceDOMNode := instanceDOMNode.NextSibling;
    end;

    moduleDOMNode := moduleDOMNode.NextSibling;

    StringGrid1.ColWidths[0] := 500;
    StringGrid1.RowHeights[index] := cellText.Count * 16;
    StringGrid1.RowCount := StringGrid1.RowCount + 1;
    StringGrid1.Rows[index].Add(cellText.Text);
    cellText.Clear;
    Inc(index);
  end;
  Caption := StringGrid1.Canvas.Font.Height.ToString;

  cellText.Free;
  xml.Free;
end;

procedure TForm1.StringGrid1DrawCell(Sender: TObject; aCol, aRow: integer; aRect: TRect; aState: TGridDrawState);
begin
  //  StringGrid1.Rows[2].;
  //   StringGrid1.Canvas.Line(aRect.Left,aRect.Top,aRect.Right,aRect.Bottom);
end;

procedure TForm1.StringGrid1PrepareCanvas(Sender: TObject; aCol, aRow: integer; aState: TGridDrawState);
begin
  with StringGrid1.Canvas.TextStyle do begin
    SingleLine := False;
    Wordbreak := False;
  end;
end;

end.
