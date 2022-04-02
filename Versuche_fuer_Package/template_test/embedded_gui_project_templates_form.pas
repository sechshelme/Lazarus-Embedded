unit Embedded_GUI_Project_Templates_Form;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Buttons,
  Laz2_XMLCfg,  // Bei normalen Anwendungen
  Embedded_GUI_Common, Embedded_GUI_Embedded_List_Const;
//, Embedded_GUI_Templates;

type
  TTemplatesPara = record
    Name,
    Arch,
    SubArch,
    Controller: string;
    Examples: array of record
      Caption, SorceFile: String;
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
  BoardKey, PKey: string;
begin
  LoadFormPos_from_XML(Self);
  Caption := Title + 'Vorlagen';

  //Cfg := TXMLConfig.Create(nil);
  //Cfg.Filename := 'test.xml';
  //Cfg.SetValue('Boards/Count', Length(TemplatesPara));
  //
  //for i := 0 to Length(TemplatesPara) - 1 do begin
  //  Cfg.SetValue('Boards/Board' + i.ToString + '/Caption', TemplatesPara[i].Name);
  //  Cfg.SetValue('Boards/Board' + i.ToString + '/Arch', TemplatesPara[i].Arch);
  //  Cfg.SetValue('Boards/Board' + i.ToString + '/SubArch', TemplatesPara[i].SubArch);
  //  Cfg.SetValue('Boards/Board' + i.ToString + '/Controller', TemplatesPara[i].Controller);
  //
  //  Cfg.SetValue('Boards/Board' + i.ToString + '/Programmer', TemplatesPara[i].Programmer);
  //  Cfg.SetValue('Boards/Board' + i.ToString + '/avrdude/Controller', TemplatesPara[i].avrdude.Controller);
  //  Cfg.SetValue('Boards/Board' + i.ToString + '/avrdude/Programmer', TemplatesPara[i].avrdude.Programmer);
  //  Cfg.SetValue('Boards/Board' + i.ToString + '/avrdude/COM_Port', TemplatesPara[i].avrdude.COM_Port);
  //  Cfg.SetValue('Boards/Board' + i.ToString + '/avrdude/Baud', TemplatesPara[i].avrdude.Baud);
  //  Cfg.SetValue('Boards/Board' + i.ToString + '/avrdude/Disable_Auto_Erase', TemplatesPara[i].avrdude.Disable_Auto_Erase);
  //  Cfg.SetValue('Boards/Board' + i.ToString + '/avrdude/Chip_Erase', TemplatesPara[i].avrdude.Chip_Erase);
  //
  //  Cfg.SetValue('Boards/Board' + i.ToString + '/stlink/FlashBase', TemplatesPara[i].stlink.FlashBase);
  //
  //  Cfg.SetValue('Boards/Board' + i.ToString + '/Examples/Count', Length(TemplatesPara[i].Examples));
  //  for j := 0 to Length(TemplatesPara[i].Examples) - 1 do begin
  //    p := Pos(LineEnding, TemplatesPara[i].Examples[j]);
  //    s := Copy(TemplatesPara[i].Examples[j], 3, p - 3);
  //    Cfg.SetValue('Boards/Board' + i.ToString + '/Examples/Example' + j.ToString + '/Caption', s);
  //    Cfg.SetValue('Boards/Board' + i.ToString + '/Examples/Example' + j.ToString + '/SourceFile', s);
  //  end;
  //end;
  //Cfg.Free;

  Cfg := TXMLConfig.Create(nil);
  Cfg.Filename := '/n4800/DATEN/Programmierung/Lazarus/Tutorials/Embedded/Lazarus_AVR_ARM_Embedded_GUI_Package/Templates/embedded_gui_template.xml';

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

  Cfg.Free;


  for index := 0 to Length(TemplatesPara) - 1 do begin
    ListBox_Template.Items.AddStrings(TemplatesPara[index].Name);
  end;
  if ListBox_Template.Count >= 1 then begin
    ListBox_Template.ItemIndex := 0;
  end;
  ListBox_TemplateClick(Sender);
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
begin
  SL := TStringList.Create;
  SL.LoadFromFile(TemplatesPara[ListBox_Template.ItemIndex].Examples[ListBox_Example.ItemIndex].SorceFile);
  Result := SL.Text;
  SL.Free;
end;

end.
