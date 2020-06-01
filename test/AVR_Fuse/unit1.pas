unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ComCtrls,
  FileUtil,
  XMLConf,
  XMLRead, XMLWrite, DOM;

type

  { TForm1 }

  TForm1 = class(TForm)
    ListBox1: TListBox;
    PageControl1: TPageControl;
    procedure CreateTab(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ListBox1DblClick(Sender: TObject);
  private
    function IsAttribut(Node: TDOMNode; const NodeName, NodeValue: string): boolean;
    function GetAttribut(Node: TDOMNode; const NodeName: string): string;
    procedure ClearTabs;
  public
    TabSheet: array[0..3] of record
      Tab: TTabSheet;
      ofs: integer;
      CheckBox: array of TCheckBox;
      ComboBox: array of TComboBox;
      StaticText: array of TStaticText;
    end;
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}


const
  path: string = 'XML/atmega328p.xml';

  Options_File = 'config.xml';
  FormPos = '/';

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

procedure TForm1.ClearTabs;
var
  i, j: integer;
begin
  for i := 0 to Length(TabSheet) - 1 do begin
    TabSheet[i].Tab.TabVisible := False;
    with TabSheet[i] do begin
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
      ofs := 5;
    end;
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

  for i := 0 to Length(TabSheet) - 1 do begin
    TabSheet[i].ofs := 5;
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
              TabSheet[aktFuse].Tab.TabVisible := True;

              Node_Bitfield := Node_Register.FirstChild;
              while Node_Bitfield <> nil do begin

                with TabSheet[aktFuse] do begin
                  if GetAttribut(Node_Bitfield, 'values') <> '' then begin
                    l := Length(StaticText);
                    SetLength(StaticText, l + 1);
                    Inc(ofs, 10);

                    StaticText[l] := TStaticText.Create(Self);
                    StaticText[l].Parent := Tab;
                    StaticText[l].Caption :=
                      GetAttribut(Node_Bitfield, 'caption') + ' (' + GetAttribut(Node_Bitfield, 'name') + '):';
                    StaticText[l].Top := ofs;
                    StaticText[l].Width := Tab.Width;
                    Inc(ofs, StaticText[l].Height);

                    l := Length(ComboBox);
                    SetLength(ComboBox, l + 1);

                    ComboBox[l] := TComboBox.Create(Self);
                    ComboBox[l].Parent := Tab;
                    ComboBox[l].Items.Add(GetAttribut(Node_Bitfield, 'caption'));
                    ComboBox[l].Top := ofs;
                    Inc(ofs, ComboBox[l].Height + 10);
                  end else begin
                    l := Length(CheckBox);
                    SetLength(CheckBox, l + 1);

                    CheckBox[l] := TCheckBox.Create(Self);
                    CheckBox[l].Parent := Tab;
                    CheckBox[l].Caption :=
                      GetAttribut(Node_Bitfield, 'caption') + ' (' + GetAttribut(Node_Bitfield, 'name') + ')';
                    CheckBox[l].Top := ofs;
                    Inc(ofs, CheckBox[l].Height);
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

  doc.Free;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  fl: TStringList;
  i: integer;
begin
  for i := 0 to Length(TabSheet) - 1 do begin
    with TabSheet[i] do begin
      Tab := TTabSheet.Create(Self);
      Tab.TabVisible := False;
      Tab.PageControl := PageControl1;
    end;
  end;
  TabSheet[0].Tab.Caption := 'Low Fuse';
  TabSheet[1].Tab.Caption := 'High Fuse';
  TabSheet[2].Tab.Caption := 'Ext Fuse';
  TabSheet[3].Tab.Caption := 'Lock Bit';

  fl := FindAllFiles('../AVR_Fuse/XML', '*.XML', False);
  for i := 0 to fl.Count - 1 do begin
    //    if Check(fl[i]) then begin
    ListBox1.Items.Add(fl[i]);
    //    end else begin
    //      ListBox1.Items.Add(fl[i] +'      ******');
    //    end;
  end;
  fl.Free;

  LoadFormPos_from_XML(self);
end;

procedure TForm1.FormDestroy(Sender: TObject);
var
  i: integer;
begin
  SaveFormPos_to_XML(self);
  for i := 0 to Length(TabSheet) - 1 do begin
    TabSheet[i].Tab.Free;
  end;
end;

procedure TForm1.ListBox1DblClick(Sender: TObject);
begin
  path := ListBox1.Items[ListBox1.ItemIndex];
  Caption := path;
  if FileExists(path) then begin
    ClearTabs;
    CreateTab(Sender);
  end;
end;

end.
