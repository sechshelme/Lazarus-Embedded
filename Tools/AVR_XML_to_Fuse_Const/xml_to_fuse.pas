unit XML_To_Fuse;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ComCtrls,
  ExtCtrls, FileUtil, LazFileUtils, laz2_XMLRead, laz2_DOM, SynEdit,
  SynHighlighterPas,
  Insert_Default_Fuse,
  Embedded_GUI_AVR_Fuse_Const,
  Embedded_GUI_Common;

type

  { TForm_AVR_Fuse }

  TForm_AVR_Fuse = class(TForm)
    Button_CreateConst: TButton;
    Button_Close: TButton;
    Label1: TLabel;
    SynEdit1: TSynEdit;
    SynPasSyn1: TSynPasSyn;
    procedure Button_CloseClick(Sender: TObject);
    procedure Button_CreateConstClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    function IsAttribut(Node: TDOMNode; const NodeName, NodeValue: string): boolean;
    function GetAttribut(Node: TDOMNode; const NodeName: string): string;
  private
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

/// --- public

procedure TForm_AVR_Fuse.FormCreate(Sender: TObject);
begin
  SynEdit1.Clear;
  Caption := Title + 'Create AVR Fuse Const';
  LoadFormPos_from_XML(self);
end;

procedure TForm_AVR_Fuse.Button_CloseClick(Sender: TObject);
begin
  Close;
end;

procedure TForm_AVR_Fuse.Button_CreateConstClick(Sender: TObject);
var
  fl, sl: TStringList;
  ii: integer;
  s: string;
  doc: TXMLDocument;
  Node_Modules, Node_Module, Node_Register_group, Node_Register, Node_Bitfield: TDOMNode;
  DefaultFuse:TInsertDefaultFuse;

  procedure AddFuse(Node_Register: TDOMNode);
  var
    n, FuseName: string;
    ofs: byte;
  begin
    ofs := StrToInt(GetAttribut(Node_Register, 'offset'));
    n := GetAttribut(Node_Register, 'name');
    case n of
      'EXTENDED': begin
        FuseName := 'efuse';
      end;
      'HIGH': begin
        FuseName := 'hfuse';
      end;
      'LOW': begin
        FuseName := 'lfuse';
      end;
      'LOCKBIT': begin
        FuseName := 'lock';
      end;
      'BYTE0': begin
        FuseName := 'BYTE0';
      end else begin
        FuseName := 'fuse' + IntToStr(ofs);
      end;
    end;
    sl.Add('      (Caption: '#39 +n + ' (' + FuseName + ')' + #39'; Name: '#39 + FuseName + #39'; ofs: $' + IntToHex(ofs, 2) + '; BitField:(');
  end;

  procedure Read_Value_Group(const Attr_name: string; Node: TDOMNode);
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
          sl.Add('           (Caption: '#39 + GetAttribut(Node_Value, 'caption') + #39'; Name: '#39 + GetAttribut(Node_Value, 'name') + #39'; Value: $' + IntToHex(StrToInt(GetAttribut(Node_Value, 'value')), 2) + '),');

          Node_Value := Node_Value.NextSibling;
        end;
        sl[sl.Count - 1] := StringReplace(sl[sl.Count - 1], '),', '))),', []);
      end;
      Node_Value_Group := Node_Value_Group.NextSibling;
    end;
  end;

const
  UName = 'Embedded_GUI_AVR_Fuse_Const';
begin
  sl := TStringList.Create;
  DefaultFuse:=TInsertDefaultFuse.Create;
  sl.Add('// Diese Unit wird durch das Tool "Tools/AVR_XML_to_Fuse_Const" generiert !');
  sl.Add('');
  sl.Add('unit ' + UName + ';');
  sl.Add('');
  sl.Add('interface');
  sl.Add('');
  sl.Add('type');
  sl.Add('  TAVR_Fuse_Data = array of record');
  sl.Add('    Name: String;');
  sl.Add('    Fuses: array of record');
  sl.Add('      Caption, Name: String;');
  sl.Add('      ofs: Byte;');
  sl.Add('      BitField: array of record');
  sl.Add('        Caption, Name: String;');
  sl.Add('        Mask: Byte;');
  sl.Add('        Values: array of record');
  sl.Add('          Caption, Name: String;');
  sl.Add('          Value: Byte;');
  sl.Add('        end;');
  sl.Add('      end;');
  sl.Add('    end;');
  sl.Add('  end;');
  sl.Add('');
  sl.Add('const');
  sl.Add('  AVR_Fuse_Data: TAVR_Fuse_Data = (');

  fl := FindAllFiles('XML', '*.XML', False);
  fl.Sorted := True;
  for ii := 0 to fl.Count - 1 do begin
    ReadXMLFile(doc, fl[ii]);
    s := ExtractFileName(fl[ii]);
    s := ExtractFileNameWithoutExt(s);

    sl.Add('');
    sl.Add('// ---------- ' + s + '-----------');
    sl.Add('    (Name: '#39 + s + #39'; Fuses:(');

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

                  if GetAttribut(Node_Bitfield, 'values') <> '' then begin
                    sl.Add('         (Caption: '#39 + GetAttribut(Node_Bitfield, 'caption') + #39'; ' + 'Name: '#39 + GetAttribut(Node_Bitfield, 'name') + #39'; ' + 'Mask: $' + IntToHex(StrToInt(GetAttribut(Node_Bitfield, 'mask')), 2) + ';' + ' Values: (');
                    Read_Value_Group(GetAttribut(Node_Bitfield, 'values'), Node_Module);
                  end else begin
                    sl.Add('         (Caption: '#39 + GetAttribut(Node_Bitfield, 'caption') + #39'; ' + 'Name: '#39 + GetAttribut(Node_Bitfield, 'name') + #39'; ' + 'Mask: $' + IntToHex(StrToInt(GetAttribut(Node_Bitfield, 'mask')), 2) + ';' + ' Values: ()),');
                  end;

                  Node_Bitfield := Node_Bitfield.NextSibling;
                end;

                if Pos('),', sl[sl.Count - 1]) > 0 then begin
                  sl[sl.Count - 1] := StringReplace(sl[sl.Count - 1], '),', '))),', []);
                end else begin
                  sl[sl.Count - 1] := sl[sl.Count - 1] + ')),';
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
    sl[sl.Count - 1] := StringReplace(sl[sl.Count - 1], '),', '))),', []);
  end;

  s := sl[sl.Count - 1];
  Delete(s, Length(s), 1);
  sl[sl.Count - 1] := s + ');';
  fl.Free;
  sl.Add('');
  sl.Add('implementation');
  sl.Add('');
  sl.Add('begin');
  sl.Add('end.');

  sl.SaveToFile('../../Lazarus_AVR_ARM_Embedded_GUI_Package/' + LowerCase(UName) + '.pas');
  SynEdit1.Lines.Text := sl.Text;

  sl.Free;
  DefaultFuse.Insert;
  DefaultFuse.Free;
end;

procedure TForm_AVR_Fuse.FormDestroy(Sender: TObject);
begin
  SaveFormPos_to_XML(self);
end;

end.
