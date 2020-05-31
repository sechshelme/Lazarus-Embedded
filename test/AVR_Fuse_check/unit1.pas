unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ComCtrls,
  FileUtil, SynEdit, SynHighlighterXML, XMLConf, XMLRead, XMLWrite, DOM;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button3: TButton;
    ListBox1: TListBox;
    SynEdit1: TSynEdit;
    SynXMLSyn1: TSynXMLSyn;
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ListBox1DblClick(Sender: TObject);
  private
    function Check(path: string): boolean;
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

procedure TForm1.Button1Click(Sender: TObject);
var
  fl: TStringList;
  i: integer;
begin
  SynEdit1.Clear;
  fl := FindAllFiles('../AVR_Fuse/XML');
  Caption:=fl.Count.ToString;
  for i := 0 to fl.Count - 1 do begin
    if Check(fl[i]) then begin
      SynEdit1.Lines.Add(fl[i]);
    end else begin
      SynEdit1.Lines.Add('       ' + fl[i]);
    end;
  end;
  fl.Free;
end;

procedure TForm1.Button3Click(Sender: TObject);
var
  fl: TStringList;
  i: Integer;
begin
  fl := FindAllFiles('../AVR_Fuse/XML', '*.XML', False);
  for i := 0 to fl.Count - 1 do begin
    if Check(fl[i]) then begin
      ListBox1.Items.Add(fl[i]);
    end else begin
      ListBox1.Items.Add(fl[i] +'      ******');
    end;

  end;
  fl.Free;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  LoadFormPos_from_XML(self);
  SynEdit1.ScrollBars:=ssAutoBoth;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  SaveFormPos_to_XML(self);
end;

procedure TForm1.ListBox1DblClick(Sender: TObject);
var path:String;
begin
  path:=ListBox1.Items[ListBox1.ItemIndex];
  Caption:=path;
  path:=StringReplace(path, '*', '', [rfIgnoreCase, rfReplaceAll]);
  path:=StringReplace(path, ' ', '', [rfIgnoreCase, rfReplaceAll]);
  if FileExists(path) then
  SynEdit1.Lines.LoadFromFile(path);
end;

function TForm1.Check(path: string): boolean;
var
  i, j, k: integer;
  doc: TXMLDocument;
  Node_Modules, Node_Module, Node_Register_group, Node_Register, Node_Bitfield: TDOMNode;
begin
  Result := False;


  ReadXMLFile(doc, path);

  Node_Modules := doc.DocumentElement.FindNode('modules');

  if Node_Modules <> nil then begin

    Node_Module := Node_Modules.FirstChild;
    while Node_Module <> nil do begin
      if Node_Module.NodeName = 'module' then begin
        if Node_Module.HasAttributes then begin
          for i := 0 to Node_Module.Attributes.Length - 1 do begin
            if Node_Module.Attributes.Item[i].NodeName = 'name' then begin
              if Node_Module.Attributes.Item[i].NodeValue = 'FUSE' then begin
                Node_Register_group := Node_Module.FirstChild;
                if Node_Register_group <> nil then begin
                  Node_Register := Node_Register_group.FirstChild;
                  while Node_Register <> nil do begin
                    if Node_Register.HasAttributes then begin
                      for j := 0 to Node_Register.Attributes.Length - 1 do begin
                        if Node_Register.Attributes.Item[j].NodeName = 'name' then begin
                        end;
                      end;
                    end;
                    Node_Bitfield := Node_Register.FirstChild;
                    while Node_Bitfield <> nil do begin
                      if Node_Bitfield.HasAttributes then begin
                        for k := 0 to Node_Bitfield.Attributes.Length - 1 do begin
                          if Node_Bitfield.Attributes.Item[k].NodeName = 'caption' then
                          begin
                            Result := True;
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
          end;

        end;
      end;

      Node_Module := Node_Module.NextSibling;

    end;

  end;

end;

end.
