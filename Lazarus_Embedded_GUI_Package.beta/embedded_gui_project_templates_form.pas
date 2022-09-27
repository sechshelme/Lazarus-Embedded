unit Embedded_GUI_Project_Templates_Form;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Buttons, LCLType,
  Laz2_XMLCfg,
  Embedded_GUI_IDE_Options_Frame,
  Embedded_GUI_Common, Embedded_GUI_Embedded_List_Const, Types;

type
  TTemplatesPara = record
    Caption:String;
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
      Chip_Erase,
      Override_Signature_Check: boolean;
    end;
    stlink: record
      FlashBase: string;
    end;
    Bossac: record
      COM_Port: string;
      Erase_Flash,
      Verify_File,
      Boot_from_Flash,
      Brownout_Detection,
      Brownout_Reset,
      Lock_Flash_Region,
      Unlock_Flash_Region,
      Flash_Security_Flag,
      Display_Device_Info,
      Print_Debug,
      Override_USB_Port_Autodetection,
      Reset_CPU,
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
    Label_Board: TLabel;
    Label_Examples: TLabel;
    ListBox_Board: TListBox;
    ListBox_Example: TListBox;
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ListBox_BoardClick(Sender: TObject);
    procedure ListBoxDblClick(Sender: TObject);
  private
    FIsNewProject: Boolean;
  public
    property IsNewProject: Boolean write FIsNewProject;
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
  Template_XMLCfg: TXMLConfig;
  pfad, BoardKey, PKey: string;

begin
  LoadFormPos_from_XML(Self);

  Template_XMLCfg := TXMLConfig.Create(nil);
  pfad := Embedded_IDE_Options.Templates_Path[0] + '/embedded_gui_template.xml';
  if not FileExists(pfad) then begin
    ShowMessage('Templates-Pfad nicht gefunden:' + LineEnding + pfad);
  end else begin
    Template_XMLCfg.Filename := pfad;
    l := Template_XMLCfg.GetChildCount('Boards');
    SetLength(TemplatesPara, l);
    for i := 1 to l do begin
      BoardKey := 'Boards/Board[' + i.ToString + ']/';

      with TemplatesPara[i - 1] do begin
        Caption := Template_XMLCfg.GetValue(BoardKey + 'Caption', '');
        Arch := Template_XMLCfg.GetValue(BoardKey + 'Arch', '');
        SubArch := Template_XMLCfg.GetValue(BoardKey + 'SubArch', '');
        Controller := Template_XMLCfg.GetValue(BoardKey + 'Controller', '');
        Programmer := Template_XMLCfg.GetValue(BoardKey + 'Programmer', '');
        with avrdude do begin
          PKey := BoardKey + 'avrdude/';
          Controller := Template_XMLCfg.GetValue(PKey + 'Controller', '');
          Programmer := Template_XMLCfg.GetValue(PKey + 'Programmer', '');
          COM_Port := Template_XMLCfg.GetValue(PKey + 'COM_Port', '');
          Baud := Template_XMLCfg.GetValue(PKey + 'Baud', '');
          Disable_Auto_Erase := Template_XMLCfg.GetValue(PKey + 'Disable_Auto_Erase', False);
          Chip_Erase := Template_XMLCfg.GetValue(PKey + 'Chip_Erase', False);
          Override_Signature_Check := Template_XMLCfg.GetValue(PKey + 'Override_Signature_Check', False);
        end;
        with stlink do begin
          PKey := BoardKey + 'stlink/';
          FlashBase := Template_XMLCfg.GetValue(PKey + 'FlashBase', '');
        end;
        with Bossac do begin
          PKey := BoardKey + 'bossac/';
          COM_Port := Template_XMLCfg.GetValue(PKey + 'COM_Port', '');
          Erase_Flash := Template_XMLCfg.GetValue(PKey + 'Erase_Flash', False);
          Verify_File := Template_XMLCfg.GetValue(PKey + 'Verify_File', False);
          Boot_from_Flash := Template_XMLCfg.GetValue(PKey + 'Boot_from_FLASH', False);
          Brownout_Detection := Template_XMLCfg.GetValue(PKey + 'Brownout_Detection', False);
          Brownout_Reset := Template_XMLCfg.GetValue(PKey + 'Brownout_Reset', False);
          Lock_Flash_Region := Template_XMLCfg.GetValue(PKey + 'Lock_Flash_Region', False);
          Unlock_Flash_Region := Template_XMLCfg.GetValue(PKey + 'Unlock_Flash_Region', False);
          Flash_Security_Flag := Template_XMLCfg.GetValue(PKey + 'Flash_Security_Flag', False);
          Display_Device_Info := Template_XMLCfg.GetValue(PKey + 'Display_Device_Info', False);
          Print_Debug := Template_XMLCfg.GetValue(PKey + 'Print_Debug', False);
          Override_USB_Port_Autodetection := Template_XMLCfg.GetValue(PKey + 'Override_USB_Port_Autodetection', False);
          Reset_CPU := Template_XMLCfg.GetValue(PKey + 'Reset_CPU', False);
          Arduino_Erase := Template_XMLCfg.GetValue(PKey + 'Arduino_Erase', False);
        end;
        with ESPTool do begin
          PKey := BoardKey + 'ESPTool/';
          Controller := Template_XMLCfg.GetValue(PKey + 'Chip', '');
          COM_Port := Template_XMLCfg.GetValue(PKey + 'COM_Port', '');
          Baud := Template_XMLCfg.GetValue(PKey + 'Baud', '');
        end;

        l := Template_XMLCfg.GetChildCount(BoardKey + 'Examples');
        SetLength(Examples, l);
        for j := 1 to l do begin
          Examples[j - 1].Caption := Template_XMLCfg.GetValue(BoardKey + 'Examples/Example[' + j.ToString + ']/Caption', '');
          Examples[j - 1].SorceFile := Template_XMLCfg.GetValue(BoardKey + 'Examples/Example[' + j.ToString + ']/SourceFile', '');
        end;
      end;
    end;

    // --- Schreibe für Testzwecke
    pfad := Embedded_IDE_Options.Templates_Path[0] + '/test.xml';
    Template_XMLCfg.Filename := pfad;
    Template_XMLCfg.Clear;

    for i := 1 to Length(TemplatesPara) do begin
      BoardKey := 'Boards/Board[' + i.ToString + ']/';

      with TemplatesPara[i - 1] do begin
        Template_XMLCfg.SetValue(BoardKey + 'Caption', Caption);
        Template_XMLCfg.SetValue(BoardKey + 'Arch', Arch);
        Template_XMLCfg.SetValue(BoardKey + 'SubArch', SubArch);
        Template_XMLCfg.SetValue(BoardKey + 'Controller', Controller);
        Template_XMLCfg.SetValue(BoardKey + 'Programmer', Programmer);
        with avrdude do begin
          PKey := BoardKey + 'avrdude/';
          Template_XMLCfg.SetValue(PKey + 'Controller', Controller);
          Template_XMLCfg.SetValue(PKey + 'Programmer', Programmer);
          Template_XMLCfg.SetValue(PKey + 'COM_Port', COM_Port);
          Template_XMLCfg.SetValue(PKey + 'Baud', Baud);
          Template_XMLCfg.SetValue(PKey + 'Disable_Auto_Erase', Disable_Auto_Erase);
          Template_XMLCfg.SetValue(PKey + 'Chip_Erase', Chip_Erase);
          Template_XMLCfg.SetValue(PKey + 'Override_Signature_Check', Override_Signature_Check);
        end;
        with stlink do begin
          PKey := BoardKey + 'stlink/';
          Template_XMLCfg.SetValue(PKey + 'FlashBase', FlashBase);
        end;
        with Bossac do begin
          PKey := BoardKey + 'bossac/';
          Template_XMLCfg.SetValue(PKey + 'COM_Port', COM_Port);
          Template_XMLCfg.SetValue(PKey + 'Erase_Flash', Erase_Flash);
          Template_XMLCfg.SetValue(PKey + 'Verify_File', Verify_File);
          Template_XMLCfg.SetValue(PKey + 'Boot_from_FLASH', Boot_from_Flash);
          Template_XMLCfg.SetValue(PKey + 'Brownout_Reset', Brownout_Reset);
          Template_XMLCfg.SetValue(PKey + 'Brownout_Detection', Brownout_Detection);
          Template_XMLCfg.SetValue(PKey + 'Lock_Flash_Region', Lock_Flash_Region);
          Template_XMLCfg.SetValue(PKey + 'Unlock_Flash_Region', Unlock_Flash_Region);
          Template_XMLCfg.SetValue(PKey + 'Flash_Security_Flag', Flash_Security_Flag);
          Template_XMLCfg.SetValue(PKey + 'Display_Device_Info', Display_Device_Info);
          Template_XMLCfg.SetValue(PKey + 'Print_Debug', Print_Debug);
          Template_XMLCfg.SetValue(PKey + 'Override_USB_Port_Autodetection', Override_USB_Port_Autodetection);
          Template_XMLCfg.SetValue(PKey + 'Reset_CPU', Reset_CPU);
          Template_XMLCfg.SetValue(PKey + 'Arduino_Erase', Arduino_Erase);
        end;
        with ESPTool do begin
          PKey := BoardKey + 'ESPTool/';
          Template_XMLCfg.SetValue(PKey + 'Chip', Controller);
          Template_XMLCfg.SetValue(PKey + 'COM_Port', COM_Port);
          Template_XMLCfg.SetValue(PKey + 'Baud', Baud);
        end;

        for j := 1 to Length(Examples) do begin
          Template_XMLCfg.SetValue(BoardKey + 'Examples/Example[' + j.ToString + ']/Caption', Examples[j - 1].Caption);
          Template_XMLCfg.SetValue(BoardKey + 'Examples/Example[' + j.ToString + ']/SourceFile', Examples[j - 1].SorceFile);
        end;
      end;
    end;


    for index := 0 to Length(TemplatesPara) - 1 do begin
      ListBox_Board.Items.AddStrings(TemplatesPara[index].Caption);
    end;
    if ListBox_Board.Count >= 1 then begin
      ListBox_Board.ItemIndex := 0;
    end;
    ListBox_BoardClick(Sender);
  end;

  Template_XMLCfg.Free;
end;

procedure TProjectTemplatesForm.FormShow(Sender: TObject);
begin
  if FIsNewProject then begin
    Caption := Title + 'New templates';
    Label_Examples.Visible:=True;
    ListBox_Example.Visible:=True;
    ListBox_Board.Width:=ClientWidth - ListBox_Example.Width - 64;
  end else begin
    Caption := Title + 'change templates';
    Label_Examples.Visible:=False;
    ListBox_Example.Visible:=False;
    ListBox_Board.Width:=ClientWidth - 32;
  end;
end;

procedure TProjectTemplatesForm.ListBox_BoardClick(Sender: TObject);
var
  i, index: integer;
begin
  index := ListBox_Board.ItemIndex;
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
    pfad := Embedded_IDE_Options.Templates_Path[0] + '/' + TemplatesPara[ListBox_Board.ItemIndex].Examples[ListBox_Example.ItemIndex].SorceFile;
    if FileExists(pfad) then begin
      SL.LoadFromFile(Embedded_IDE_Options.Templates_Path[0] + '/' + TemplatesPara[ListBox_Board.ItemIndex].Examples[ListBox_Example.ItemIndex].SorceFile);
    end else begin
      ShowMessage('Source-Datei nicht gefunden !' + LineEnding + pfad);
    end;
  end;
  Result := SL.Text;
  SL.Free;
end;

end.
