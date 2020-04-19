unit Embedded_GUI_IDE_Options;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, StdCtrls, Dialogs, ComCtrls,
  IDEUtils, LazConfigStorage, BaseIDEIntf, LazIDEIntf, ProjectIntf, CompOptsIntf, IDEOptionsIntf, IDEOptEditorIntf,
  Embedded_GUI_Find_Comports,
  Embedded_GUI_Common,
  Embedded_GUI_AVR_Common;

type

  { TEmbedded_IDE_Options }

  TEmbedded_IDE_Options = class
  public
    avrdudePath, avrdudeConfigPath, STFlashPath: string;
    procedure Save;
    procedure Load;
  end;

var
  Embedded_IDE_Options: TEmbedded_IDE_Options;

type
  (* Frames befindet sich in der Lazarus-IDE unter: "Werkzeuge/Einstellungen.../Umgebung/AVR-Options" *)

  { TEmbedded_IDE_Options_Frame }

  TEmbedded_IDE_Options_Frame = class(TAbstractIDEOptionsEditor)
    Baud_ComboBox: TComboBox;
    ComboBoxAVRdude: TComboBox;
    ComboBoxAVRdudeConf: TComboBox;
    ComboBoxSTFlashPfad: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    PageControl1: TPageControl;
    Port_ComboBox: TComboBox;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
  private

  public
    function GetTitle: string; override;
    procedure Setup({%H-}ADialog: TAbstractOptionsEditorDialog); override;
    procedure ReadSettings({%H-}AOptions: TAbstractIDEOptions); override;
    procedure WriteSettings({%H-}AOptions: TAbstractIDEOptions); override;
    class function SupportedOptionsClass: TAbstractIDEOptionsClass; override;
  end;

implementation

{$R *.lfm}

{ TEmbedded_IDE_Options }

procedure TEmbedded_IDE_Options.Load;
var
  Cfg: TConfigStorage;
begin
  Cfg := GetIDEConfigStorage(Embedded_Options_File, True);
  avrdudePath := Cfg.GetValue(Key_Avrdude_Path, Default_Avrdude_Path);
  avrdudeConfigPath := Cfg.GetValue(Key_Avrdude_Conf_Path, Default_Avrdude_Conf_Path);
  STFlashPath := Cfg.GetValue(Key_STFlash_Path, Default_STFlash_Path);
  Cfg.Free;
end;

procedure TEmbedded_IDE_Options.Save;
var
  Cfg: TConfigStorage;
begin
  Cfg := GetIDEConfigStorage(Embedded_Options_File, True);
  Cfg.SetValue(Key_Avrdude_Path, avrdudePath);
  Cfg.SetValue(Key_Avrdude_Conf_Path, avrdudeConfigPath);
  Cfg.SetValue(Key_STFlash_Path, STFlashPath);
  Cfg.Free;
end;

{ TEmbedded_IDE_Options_Frame }

function TEmbedded_IDE_Options_Frame.GetTitle: string;
begin
  Result := Title + 'Embedded GUI Optionen';
end;

procedure TEmbedded_IDE_Options_Frame.Setup(ADialog: TAbstractOptionsEditorDialog);
begin
  ComboBoxAVRdude.Text := Default_Avrdude_Path;
  ComboBoxAVRdudeConf.Text := Default_Avrdude_Conf_Path;

  ComboBoxSTFlashPfad.Text := Default_STFlash_Path;

  Port_ComboBox.Items.CommaText := GetSerialPortNames;
  Baud_ComboBox.Items.CommaText := UARTBaudRates;

//  PageControl1.ActivePageIndex:=0;
end;

procedure TEmbedded_IDE_Options_Frame.ReadSettings(AOptions: TAbstractIDEOptions);
begin
  SetComboBoxText(ComboBoxAVRdude, Embedded_IDE_Options.avrdudePath, cstFilename);
  SetComboBoxText(ComboBoxAVRdudeConf, Embedded_IDE_Options.avrdudeConfigPath, cstFilename);

  SetComboBoxText(ComboBoxSTFlashPfad, Embedded_IDE_Options.STFlashPath, cstFilename);
end;

procedure TEmbedded_IDE_Options_Frame.WriteSettings(AOptions: TAbstractIDEOptions);
begin
  Embedded_IDE_Options.avrdudePath := ComboBoxAVRdude.Text;
  Embedded_IDE_Options.avrdudeConfigPath := ComboBoxAVRdudeConf.Text;
  Embedded_IDE_Options.STFlashPath := ComboBoxSTFlashPfad.Text;
  Embedded_IDE_Options.Save;
end;

class function TEmbedded_IDE_Options_Frame.SupportedOptionsClass: TAbstractIDEOptionsClass;
begin
  Result := IDEEditorGroups.GetByIndex(GroupEnvironment)^.GroupClass;
end;

end.





