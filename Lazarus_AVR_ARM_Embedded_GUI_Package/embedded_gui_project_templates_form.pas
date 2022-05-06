unit Embedded_GUI_Project_Templates_Form;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Buttons,
  Laz2_XMLCfg,
  Embedded_GUI_IDE_Options_Frame,
  Embedded_GUI_Common, Embedded_GUI_Embedded_List_Const;

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
    Bossac: record
      COM_Port: string;
      Erase_Flash,
      Boot_from_Flash,
      Brownout_Detection,
      Lock_Flash_Region,
      Flash_Security_Flag,
      Print_Debug,
      Reset_CPU,
      Verify_File,
      Brownout_Reset,
      Unlock_Flash_Region,
      Display_Device_Info,
      Override_USB_Port_Autodetection,
      Arduino_Erase: boolean;
    end;
    ESPTool: record
      Controller,
      COM_Port,
      Baud: string
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
  if not FileExists(pfad) then begin
    ShowMessage('Templates-Pfad nicht gefunden:' + LineEnding + pfad);
  end else begin
    Cfg.Filename := pfad;
    l := cfg.GetChildCount('Boards');
    SetLength(TemplatesPara, l);
    for i := 1 to l do begin
      BoardKey := 'Boards/Board[' + i.ToString + ']/';

      with TemplatesPara[i - 1] do begin
        Name := Cfg.GetValue(BoardKey + 'Caption', '');
        Arch := Cfg.GetValue(BoardKey + 'Arch', '');
        SubArch := Cfg.GetValue(BoardKey + 'SubArch', '');
        Controller := Cfg.GetValue(BoardKey + 'Controller', '');
        Programmer := Cfg.GetValue(BoardKey + 'Programmer', '');
        with avrdude do begin
          PKey := BoardKey + 'avrdude/';
          Controller := Cfg.GetValue(PKey + 'Controller', '');
          Programmer := Cfg.GetValue(PKey + 'Programmer', '');
          COM_Port := Cfg.GetValue(PKey + 'COM_Port', '');
          Baud := Cfg.GetValue(PKey + 'Baud', '');
          Disable_Auto_Erase := Cfg.GetValue(PKey + 'Disable_Auto_Erase', False);
          Chip_Erase := Cfg.GetValue(PKey + 'Chip_Erase', False);
        end;
        with stlink do begin
          PKey := BoardKey + 'stlink/';
          FlashBase := Cfg.GetValue(PKey + 'FlashBase', '');
        end;
        with Bossac do begin
          PKey := BoardKey + 'bossac/';
          COM_Port := Cfg.GetValue(PKey + 'COM_Port', '');
          Erase_Flash := Cfg.GetValue(PKey + 'Erase_Flash', False);
          Boot_from_Flash := Cfg.GetValue(PKey + 'Boot_from_FLASH', False);
          Brownout_Detection := Cfg.GetValue(PKey + 'Brownout_Detection', False);
          Lock_Flash_Region := Cfg.GetValue(PKey + 'Lock_Flash_Region', False);
          Flash_Security_Flag := Cfg.GetValue(PKey + 'Flash_Security_Flag', False);
          Print_Debug := Cfg.GetValue(PKey + 'Print_Debug', False);
          Reset_CPU := Cfg.GetValue(PKey + 'Reset_CPU', False);
          Verify_File := Cfg.GetValue(PKey + 'Verify_File', False);
          Brownout_Reset := Cfg.GetValue(PKey + 'Brownout_Reset', False);
          Unlock_Flash_Region := Cfg.GetValue(PKey + 'Unlock_Flash_Region', False);
          Display_Device_Info := Cfg.GetValue(PKey + 'Display_Device_Info', False);
          Override_USB_Port_Autodetection := Cfg.GetValue(PKey + 'Override_USB_Port_Autodetection', False);
          Arduino_Erase := Cfg.GetValue(PKey + 'Arduino_Erase', False);
        end;
        with ESPTool do begin
          PKey := BoardKey + 'ESPTool/';
          Controller := Cfg.GetValue(PKey + 'Chip', '');
          COM_Port := Cfg.GetValue(PKey + 'COM_Port', '');
          Baud := Cfg.GetValue(PKey + 'Baud', '');
        end;

        l := Cfg.GetChildCount(BoardKey + 'Examples');
        SetLength(Examples, l);
        for j := 1 to l do begin
          Examples[j - 1].Caption := Cfg.GetValue(BoardKey + 'Examples/Example[' + j.ToString + ']/Caption', '');
          Examples[j - 1].SorceFile := Cfg.GetValue(BoardKey + 'Examples/Example[' + j.ToString + ']/SourceFile', '');
        end;
      end;
    end;

    // --- Schreibe für Testzwecke
    pfad := Embedded_IDE_Options.Templates_Path[0] + '/test.xml';
    Cfg.Filename := pfad;
    Cfg.Clear;

    for i := 1 to Length(TemplatesPara) do begin
      BoardKey := 'Boards/Board[' + i.ToString + ']/';

      with TemplatesPara[i - 1] do begin
        Cfg.SetValue(BoardKey + 'Caption', Name);
        Cfg.SetValue(BoardKey + 'Arch', Arch);
        Cfg.SetValue(BoardKey + 'SubArch', SubArch);
        Cfg.SetValue(BoardKey + 'Controller', Controller);
        Cfg.SetValue(BoardKey + 'Programmer', Programmer);
        with avrdude do begin
          PKey := BoardKey + 'avrdude/';
          Cfg.SetValue(PKey + 'Controller', Controller);
          Cfg.SetValue(PKey + 'Programmer', Programmer);
          Cfg.SetValue(PKey + 'COM_Port', COM_Port);
          Cfg.SetValue(PKey + 'Baud', Baud);
          Cfg.SetValue(PKey + 'Disable_Auto_Erase', Disable_Auto_Erase);
          Cfg.SetValue(PKey + 'Chip_Erase', Chip_Erase);
        end;
        with stlink do begin
          PKey := BoardKey + 'stlink/';
          Cfg.SetValue(PKey + 'FlashBase', FlashBase);
        end;
        with Bossac do begin
          PKey := BoardKey + 'bossac/';
          Cfg.SetValue(PKey + 'COM_Port', COM_Port);
          Cfg.SetValue(PKey + 'Erase_Flash', Erase_Flash);
          Cfg.SetValue(PKey + 'Boot_from_FLASH', Boot_from_Flash);
          Cfg.SetValue(PKey + 'Brownout_Detection', Brownout_Detection);
          Cfg.SetValue(PKey + 'Lock_Flash_Region', Lock_Flash_Region);
          Cfg.SetValue(PKey + 'Flash_Security_Flag', Flash_Security_Flag);
          Cfg.SetValue(PKey + 'Print_Debug', Print_Debug);
          Cfg.SetValue(PKey + 'Reset_CPU', Reset_CPU);
          Cfg.SetValue(PKey + 'Verify_File', Verify_File);
          Cfg.SetValue(PKey + 'Brownout_Reset', Brownout_Reset);
          Cfg.SetValue(PKey + 'Unlock_Flash_Region', Unlock_Flash_Region);
          Cfg.SetValue(PKey + 'Display_Device_Info', Display_Device_Info);
          Cfg.SetValue(PKey + 'Override_USB_Port_Autodetection', Override_USB_Port_Autodetection);
          Cfg.SetValue(PKey + 'Arduino_Erase', Arduino_Erase);
        end;
        with ESPTool do begin
          PKey := BoardKey + 'ESPTool/';
          Cfg.SetValue(PKey + 'Chip', Controller);
          Cfg.SetValue(PKey + 'COM_Port', COM_Port);
          Cfg.SetValue(PKey + 'Baud', Baud);
        end;

        for j := 1 to Length(Examples) do begin
          Cfg.SetValue(BoardKey + 'Examples/Example[' + j.ToString + ']/Caption', Examples[j - 1].Caption);
          Cfg.SetValue(BoardKey + 'Examples/Example[' + j.ToString + ']/SourceFile', Examples[j - 1].SorceFile);
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
