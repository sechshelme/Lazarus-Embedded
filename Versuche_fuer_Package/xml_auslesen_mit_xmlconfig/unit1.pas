unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls,
  Laz2_DOM, laz2_XMLRead;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
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
  i, c: integer;
  s: string;
begin
  ReadXMLFile(xml, 'ATmega328.xml');
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
      Memo1.Lines.Add('module: ' + moduleDOMNode.Attributes.Item[0].NodeValue);
    end;

    instanceDOMNode := moduleDOMNode.FindNode('instance');

    while instanceDOMNode <> nil do begin
      c := instanceDOMNode.ChildNodes.Count;
      Memo1.Lines.Add('  instance: ' + c.ToString);

      signalDOMNode := instanceDOMNode.FindNode('signals');
      if signalDOMNode <> nil then begin
        signalDOMNode := signalDOMNode.FindNode('signal');
        while signalDOMNode <> nil do begin
          c := signalDOMNode.ChildNodes.Count;
          Memo1.Lines.Add('    signal: ' + c.ToString);

          if signalDOMNode.HasAttributes then begin
            s := '';
            Attribut := signalDOMNode.Attributes;
            for i := 0 to Attribut.Length - 1 do begin
              n := Attribut.Item[i];
              s := s + '     ' + n.NodeName + ': ' + n.NodeValue;

            end;
            Memo1.Lines.Add(s);

          end;

          signalDOMNode := signalDOMNode.NextSibling;
        end;
      end;

      instanceDOMNode := instanceDOMNode.NextSibling;
    end;

    moduleDOMNode := moduleDOMNode.NextSibling;
  end;

  xml.Free;
end;

end.
