unit Embedded_GUI_Project_Templates_Form;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Buttons,
  Laz2_XMLCfg,  // Bei normalen Anwendungen
  Embedded_GUI_IDE_Options_Frame,
  Embedded_GUI_Common, Embedded_GUI_Embedded_List_Const;
//, Embedded_GUI_Templates;

type
  TTemplatesPara = record
    Name,
    Arch,
    SubArch,
    Controller: string;
    Examples: array of record
      Caption, SorceFile: string;
      end;
    Programmer: string;
    avrdude: record
      Controller,
      Programmer,
      COM_Port,
      Baud: string;
      Disable_Auto_Erase,
      Chip_Erase: boolean;
      end;
    stlink: record
      FlashBase: string;
      end;
  end;

  { TProjectTemplatesForm }

  TProjectTemplatesForm = class(TForm)
    BitBtn_Ok: TBitBtn;
    BitBtn_Cancel: TBitBtn;
    Label1: TLabel;
    Label2: TLabel;
    ListBox_Template: TListBox;
    ListBox_Example: TListBox;
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure ListBox_TemplateClick(Sender: TObject);
    procedure ListBoxDblClick(Sender: TObject);
  private
  public
    function getSource: string;
  end;

var
  ProjectTemplatesForm: TProjectTemplatesForm;
  TemplatesPara: array of TTemplatesPara;

implementation

{$R *.lfm}

{ TProjectTemplatesForm }

procedure TProjectTemplatesForm.FormCreate(Sender: TObject);
var
  i, j, l, index: integer;
  Cfg: TXMLConfig;
  pfad, BoardKey, PKey: string;

begin
  LoadFormPos_from_XML(Self);
  Caption := Title + 'Templates';

  Cfg := TXMLConfig.Create(nil);
  pfad := Embedded_IDE_Options.Templates_Path[0] + '/embedded_gui_template.xml';
  //  Cfg.Filename := '/n4800/DATEN/Programmierung/Lazarus/Tutorials/Embedded/Lazarus_AVR_ARM_Embedded_GUI_Package/Templates/embedded_gui_template.xml';
  if not FileExists(pfad) then begin
    ShowMessage('Templates-Pfad nicht gefunden:' + LineEnding + pfad);
  end else begin
    Cfg.Filename := pfad;
    l := cfg.GetChildCount('Boards');
    SetLength(TemplatesPara, l);
    for i := 1 to l do begin
      BoardKey := 'Boards/Board[' + i.ToString + ']/';

      with TemplatesPara[i - 1] do begin
        Name := Cfg.GetValue(BoardKey + 'Caption', 'x');
        Arch := Cfg.GetValue(BoardKey + 'Arch', 'x');
        SubArch := Cfg.GetValue(BoardKey + 'SubArch', 'x');
        Controller := Cfg.GetValue(BoardKey + 'Controller', 'x');
        Programmer := Cfg.GetValue(BoardKey + 'Programmer', 'x');
        with avrdude do begin
          PKey := BoardKey + 'avrdude/';
          Controller := Cfg.GetValue(PKey + 'Controller', 'x');
          Programmer := Cfg.GetValue(PKey + 'Programmer', 'x');
          COM_Port := Cfg.GetValue(PKey + 'COM_Port', 'x');
          Baud := Cfg.GetValue(PKey + 'Baud', 'x');
          Disable_Auto_Erase := Cfg.GetValue(PKey + 'Disable_Auto_Erase', False);
          Chip_Erase := Cfg.GetValue(PKey + 'Chip_Erase', False);
        end;
        with stlink do begin
          FlashBase := Cfg.GetValue(PKey + 'FlashBase', 'x');
        end;
        l := Cfg.GetChildCount(BoardKey + 'Examples');
        SetLength(Examples, l);
        for j := 1 to l do begin
          Examples[j - 1].Caption := Cfg.GetValue(BoardKey + 'Examples/Example[' + j.ToString + ']/Caption', '[error]');
          Examples[j - 1].SorceFile := Cfg.GetValue(BoardKey + 'Examples/Example[' + j.ToString + ']/SourceFile', '[error]');
        end;
      end;
    end;

    for index := 0 to Length(TemplatesPara) - 1 do begin
      ListBox_Template.Items.AddStrings(TemplatesPara[index].Name);
    end;
    if ListBox_Template.Count >= 1 then begin
      ListBox_Template.ItemIndex := 0;
    end;
    ListBox_TemplateClick(Sender);
  end;

  Cfg.Free;
end;

procedure TProjectTemplatesForm.ListBox_TemplateClick(Sender: TObject);
var
  i, index: integer;
begin
  index := ListBox_Template.ItemIndex;
  ListBox_Example.Clear;
  for i := 0 to Length(TemplatesPara[index].Examples) - 1 do begin
    ListBox_Example.Items.Add(TemplatesPara[index].Examples[i].Caption);
  end;
  if ListBox_Example.Count >= 2 then begin
    ListBox_Example.ItemIndex := 1;
  end;
end;

procedure TProjectTemplatesForm.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  SaveFormPos_to_XML(Self);
end;

procedure TProjectTemplatesForm.ListBoxDblClick(Sender: TObject);
begin
  BitBtn_Ok.Click;
end;

function TProjectTemplatesForm.getSource: string;
var
  SL: TStringList;
  pfad: string;
begin
  SL := TStringList.Create;
  if Embedded_IDE_Options.Templates_Path.Count < 1 then begin
    ShowMessage('Keine Pfad zu den Templates gefunden !' + LineEnding + 'Einstellbar unter Werkzeuge->Einstellungen...->[Embedded] Optionen->Templates');
  end else begin
    pfad := Embedded_IDE_Options.Templates_Path[0] + '/' + TemplatesPara[ListBox_Template.ItemIndex].Examples[ListBox_Example.ItemIndex].SorceFile;
    if FileExists(pfad) then begin
      SL.LoadFromFile(Embedded_IDE_Options.Templates_Path[0] + '/' + TemplatesPara[ListBox_Template.ItemIndex].Examples[ListBox_Example.ItemIndex].SorceFile);
    end else begin
      ShowMessage('Source-Datei nicht gefunden !' + LineEnding + pfad);
    end;
  end;
  Result := SL.Text;
  SL.Free;
end;

end.
