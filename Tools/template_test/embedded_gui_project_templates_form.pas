unit Embedded_GUI_Project_Templates_Form;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Buttons,
  Laz2_XMLCfg,  // Bei normalen Anwendungen

  Laz2_DOM, Laz2_XMLRead, Laz2_XMLWrite,
  Embedded_GUI_Common, Embedded_GUI_Embedded_List_Const, Embedded_GUI_Templates;

type

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

implementation

{$R *.lfm}

{ TProjectTemplatesForm }

procedure TProjectTemplatesForm.FormCreate(Sender: TObject);
var
  i, j, p, index: integer;
  Cfg: TXMLConfig;
  s: string;
begin
  LoadFormPos_from_XML(Self);
  Caption := Title + 'Vorlagen';

  Cfg := TXMLConfig.Create(nil);
  Cfg.Filename := 'test.xml';
  Cfg.SetValue('Boards/Count', Length(TemplatesPara));

  for i := 5 to 10 do begin
    Cfg.SetValue('tests/test[' + i.ToString + ']/value', i);
  end;

  for i := 0 to Length(TemplatesPara) - 1 do begin
    Cfg.SetValue('Boards/Board' + i.ToString + '/Caption', TemplatesPara[i].Name);
    Cfg.SetValue('Boards/Board' + i.ToString + '/Arch', TemplatesPara[i].Arch);
    Cfg.SetValue('Boards/Board' + i.ToString + '/SubArch', TemplatesPara[i].SubArch);
    Cfg.SetValue('Boards/Board' + i.ToString + '/Controller', TemplatesPara[i].Controller);

    Cfg.SetValue('Boards/Board' + i.ToString + '/Programmer', TemplatesPara[i].Programmer);
    Cfg.SetValue('Boards/Board' + i.ToString + '/avrdude/Controller', TemplatesPara[i].avrdude.Controller);
    Cfg.SetValue('Boards/Board' + i.ToString + '/avrdude/Programmer', TemplatesPara[i].avrdude.Programmer);
    Cfg.SetValue('Boards/Board' + i.ToString + '/avrdude/COM_Port', TemplatesPara[i].avrdude.COM_Port);
    Cfg.SetValue('Boards/Board' + i.ToString + '/avrdude/Baud', TemplatesPara[i].avrdude.Baud);
    Cfg.SetValue('Boards/Board' + i.ToString + '/avrdude/Disable_Auto_Erase', TemplatesPara[i].avrdude.Disable_Auto_Erase);
    Cfg.SetValue('Boards/Board' + i.ToString + '/avrdude/Chip_Erase', TemplatesPara[i].avrdude.Chip_Erase);

    Cfg.SetValue('Boards/Board' + i.ToString + '/stlink/FlashBase', TemplatesPara[i].stlink.FlashBase);

    Cfg.SetValue('Boards/Board' + i.ToString + '/Examples/Count', Length(TemplatesPara[i].Examples));
    for j := 0 to Length(TemplatesPara[i].Examples) - 1 do begin
      p := Pos(LineEnding, TemplatesPara[i].Examples[j]);
      s := Copy(TemplatesPara[i].Examples[j], 3, p - 3);
      Cfg.SetValue('Boards/Board' + i.ToString + '/Examples/Example' + j.ToString + '/Caption', s);
      Cfg.SetValue('Boards/Board' + i.ToString + '/Examples/Example' + j.ToString + '/SourceFile', s);
    end;
  end;
  Cfg.Free;

  Cfg := TXMLConfig.Create(nil);
  Cfg.Filename := 'embedded_gui_template.xml';

  for i := 1 to cfg.GetChildCount('Boards') do begin
    WriteLn(Cfg.GetValue('Boards/Board[' + i.ToString + ']/Caption', 'x'));
    WriteLn(Cfg.GetValue('Boards/Board[' + i.ToString + ']/Arch', 'x'));
    WriteLn(Cfg.GetValue('Boards/Board[' + i.ToString + ']/SubArch', 'x'));
    WriteLn(Cfg.GetValue('Boards/Board[' + i.ToString + ']/Controller', 'x'));

    for j := 1 to Cfg.GetChildCount('Boards/Board[' + i.ToString + ']/Examples') do begin

      s := 'Boards/Board[' + i.ToString + ']/Examples/Example[' + j.ToString + ']/SourceFile';
      WriteLn(s);
      WriteLn(' ' + Cfg.GetValue(s, 'abc'));
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
  p, i, index: integer;
  s: string;
begin
  index := ListBox_Template.ItemIndex;
  ListBox_Example.Clear;
  for i := 0 to Length(TemplatesPara[index].Examples) - 1 do begin
    p := Pos(LineEnding, TemplatesPara[index].Examples[i]);
    s := Copy(TemplatesPara[index].Examples[i], 3, p - 3);
    ListBox_Example.Items.Add(s);
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
begin
  Result := TemplatesPara[ListBox_Template.ItemIndex].Examples[ListBox_Example.ItemIndex];
end;

end.
