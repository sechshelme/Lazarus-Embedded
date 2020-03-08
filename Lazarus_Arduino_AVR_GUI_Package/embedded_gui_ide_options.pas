unit Embedded_GUI_IDE_Options;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, StdCtrls, Dialogs,
  IDEUtils, LazConfigStorage, BaseIDEIntf, LazIDEIntf, ProjectIntf, CompOptsIntf, IDEOptionsIntf, IDEOptEditorIntf,

  Embedded_GUI_Common,
  Embedded_GUI_AVR_Common;

type

  { TEmbedded_IDE_Options }

  TEmbedded_IDE_Options = class
  public
    avrdudePfad,
    avrdudeConfigPath: string;
    procedure Save;
    procedure Load;
  end;

var
  Embedded_IDE_Options: TEmbedded_IDE_Options;

type
  (* Frames befindet sich in der Lazarus-IDE unter: "Werkzeuge/Einstellungen.../Umgebung/AVR-Options" *)

  { TEmbedded_IDE_Options_Frame }

  TEmbedded_IDE_Options_Frame = class(TAbstractIDEOptionsEditor)
    ComboBoxAVRdude: TComboBox;
    ComboBoxAVRdudeConf: TComboBox;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
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

const
  Key_Avrdude_Pfad = 'averdude_pfad/value';
  Key_Avrdude_Conf_Pfad = 'averdude_conf_pfad/value';

  {$IFDEF MSWINDOWS}
  Default_Avrdude_Pfad = 'c:\averdude\averdude.exe';
  Default_Avrdude_Conf_Pfad = 'c:\averdude\avrdude.conf';
  {$ELSE}
  Default_Avrdude_Pfad = '/usr/bin/avrdude';
  Default_Avrdude_Conf_Pfad = '/etc/avrdude.conf';
  {$ENDIF}


procedure TEmbedded_IDE_Options.Load;
var
  Cfg: TConfigStorage;
begin
  Cfg := GetIDEConfigStorage(Embedded_Options_File, True);
  avrdudePfad := Cfg.GetValue(Key_Avrdude_Pfad, Default_Avrdude_Pfad);
  avrdudeConfigPath := Cfg.GetValue(Key_Avrdude_Conf_Pfad, Default_Avrdude_Conf_Pfad);
  Cfg.Free;
end;

procedure TEmbedded_IDE_Options.Save;
var
  Cfg: TConfigStorage;
begin
  Cfg := GetIDEConfigStorage(Embedded_Options_File, False);
  Cfg.SetDeleteValue(Key_Avrdude_Pfad, avrdudePfad, Default_Avrdude_Pfad);
  Cfg.SetDeleteValue(Key_Avrdude_Conf_Pfad, avrdudeConfigPath, Default_Avrdude_Conf_Pfad);
  Cfg.Free;
end;

{ TEmbedded_IDE_Options_Frame }

function TEmbedded_IDE_Options_Frame.GetTitle: string;
begin
  Result := 'AVR-Optionen (Arduino)';
end;

procedure TEmbedded_IDE_Options_Frame.Setup(ADialog: TAbstractOptionsEditorDialog);
begin
  ComboBoxAVRdude.Text := Default_Avrdude_Pfad;
  ComboBoxAVRdudeConf.Text := Default_Avrdude_Conf_Pfad;
end;

procedure TEmbedded_IDE_Options_Frame.ReadSettings(AOptions: TAbstractIDEOptions);
begin
  SetComboBoxText(ComboBoxAVRdude, Embedded_IDE_Options.avrdudePfad, cstFilename, 30);
  SetComboBoxText(ComboBoxAVRdudeConf, Embedded_IDE_Options.avrdudeConfigPath, cstFilename, 30);
end;

procedure TEmbedded_IDE_Options_Frame.WriteSettings(AOptions: TAbstractIDEOptions);
begin
  Embedded_IDE_Options.avrdudePfad := ComboBoxAVRdude.Text;
  Embedded_IDE_Options.avrdudeConfigPath := ComboBoxAVRdudeConf.Text;
  Embedded_IDE_Options.Save;
end;

class function TEmbedded_IDE_Options_Frame.SupportedOptionsClass: TAbstractIDEOptionsClass;
begin
  Result := IDEEditorGroups.GetByIndex(GroupEnvironment)^.GroupClass;
end;

end.


