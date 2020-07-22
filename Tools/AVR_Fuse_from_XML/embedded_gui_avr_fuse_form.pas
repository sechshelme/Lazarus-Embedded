unit Embedded_GUI_AVR_Fuse_Form;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ComCtrls,
  ExtCtrls, FileUtil, LazFileUtils, Laz2_XMLCfg, laz2_XMLRead, laz2_XMLWrite, laz2_DOM,
  Embedded_GUI_Common,
  Embedded_GUI_Run_Command,
  Embedded_GUI_AVR_Fuse_Common,
  Embedded_GUI_AVR_Fuse_TabSheet;

type

  { TForm_AVR_Fuse }

  TForm_AVR_Fuse = class(TForm)
    Button_ReadFuse: TButton;
    Button_Close: TButton;
    ComboBox1: TComboBox;
    Label1: TLabel;
    PageControl1: TPageControl;
    procedure Button_CloseClick(Sender: TObject);
    procedure Button_ReadFuseClick(Sender: TObject);
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
  i: integer;
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

  fl := FindAllFiles('../AVR_Fuse_from_XML/XML', '*.XML', False);
  for i := 0 to fl.Count - 1 do begin
    ComboBox1.Items.Add(fl[i]);
  end;
  fl.Free;

  LoadFormPos_from_XML(self);
end;

procedure TForm_AVR_Fuse.ComboBox1Change(Sender: TObject);
begin
  //  AVR_XML_Path := ComboBox1.Items[ComboBox1.ItemIndex];
  AVR_XML_Path := ComboBox1.Text;
  Caption := AVR_XML_Path;
  if FileExists(AVR_XML_Path) then begin
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
    n: string;
    ofs: byte;
    i: integer;
  begin
    i := Length(FuseTabSheet);
    SetLength(FuseTabSheet, i + 1);
    FuseTabSheet[i] := TFuseTabSheet.Create(Self);
    with FuseTabSheet[i] do begin
      Tag := i;
      PageControl := PageControl1;
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
      Caption := n + ' (' + FuseName + ')';
    end;
  end;

begin
  ReadXMLFile(doc, AVR_XML_Path);

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

                l := Length(FuseTabSheet) - 1;
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

procedure TForm_AVR_Fuse.Button_ReadFuseClick(Sender: TObject);
var
  avr, fuse: string;
  i, l, j: integer;
begin
  if not Assigned(Run_Command_Form) then begin
    Run_Command_Form := TRun_Command_Form.Create(nil);
  end;
  Run_Command_Form.Memo1.Clear;

  avr := ExtractFileName(AVR_XML_Path);
  avr := ExtractFileNameWithoutExt(avr);
//  WriteLn(avr);

  l := Length(FuseTabSheet);
  for i := 0 to l - 1 do begin
    fuse := ' -U' + FuseTabSheet[i].FuseName + ':r:-:h';
    Run_Command_Form.RunCommand('avrdude -cusbasp -p' + avr + fuse);
    if Run_Command_Form.ExitCode = 0 then begin
      j := Run_Command_Form.Memo1.Lines.Count - 1;
      while j >= 0 do begin
        if Pos('0x', Run_Command_Form.Memo1.Lines[j]) = 1 then begin
          FuseTabSheet[i].FuseByte := not StrToInt(Run_Command_Form.Memo1.Lines[j]);
          j := 0;
        end;
        Dec(j);
      end;
    end;
  end;

  //RunCommandForm.RunCommand('avrdude -cusbasp -pattiny2313');
  //  Run_Command_Form.RunCommand('avrdude -cusbasp -p' + avr + ' -Uhfuse:r:-:h -Ulfuse:r:-:h -Uefuse:r:-:h -Ulock:r:-:h');
  //  Caption := Run_Command_Form.ExitCode.ToString;
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
