unit Embedded_GUI_IDE_Options;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, StdCtrls, Dialogs,
  IDEUtils, LazConfigStorage, BaseIDEIntf, LazIDEIntf, ProjectIntf, CompOptsIntf, IDEOptionsIntf, IDEOptEditorIntf,

  Embedded_GUI_AVR_Common;

type

  { TAVR_Options }

  TAVR_Options = class
  public
    avrdudePfad,
    avrdudeConfigPath: string;
    procedure Save;
    procedure Load;
  end;

var
  AVR_Options: TAVR_Options;

type
  (* Frames befindet sich in der Lazarus-IDE unter: "Werkzeuge/Einstellungen.../Umgebung/AVR-Options" *)

  { TAVR_IDE_Options_Frame }

  TAVR_IDE_Options_Frame = class(TAbstractIDEOptionsEditor)
    ComboBoxAVRdude: TComboBox;
    ComboBoxAVRdudeConf: TComboBox;
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

{ TAVR_Options }

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


procedure TAVR_Options.Load;
var
  Cfg: TConfigStorage;
begin
  Cfg := GetIDEConfigStorage(AVR_Options_File, True);
  avrdudePfad := Cfg.GetValue(Key_Avrdude_Pfad, Default_Avrdude_Pfad);
  avrdudeConfigPath := Cfg.GetValue(Key_Avrdude_Conf_Pfad, Default_Avrdude_Conf_Pfad);
  Cfg.Free;
end;

procedure TAVR_Options.Save;
var
  Cfg: TConfigStorage;
begin
  Cfg := GetIDEConfigStorage(AVR_Options_File, False);
  Cfg.SetDeleteValue(Key_Avrdude_Pfad, avrdudePfad, Default_Avrdude_Pfad);
  Cfg.SetDeleteValue(Key_Avrdude_Conf_Pfad, avrdudeConfigPath, Default_Avrdude_Conf_Pfad);
  Cfg.Free;
end;

{ TAVR_IDE_Options_Frame }

function TAVR_IDE_Options_Frame.GetTitle: string;
begin
  Result := 'AVR-Optionen (Arduino)';
end;

procedure TAVR_IDE_Options_Frame.Setup(ADialog: TAbstractOptionsEditorDialog);
begin
  ComboBoxAVRdude.Text := Default_Avrdude_Pfad;
  ComboBoxAVRdudeConf.Text := Default_Avrdude_Conf_Pfad;
end;

procedure TAVR_IDE_Options_Frame.ReadSettings(AOptions: TAbstractIDEOptions);
begin
  SetComboBoxText(ComboBoxAVRdude, AVR_Options.avrdudePfad, cstFilename, 30);
  SetComboBoxText(ComboBoxAVRdudeConf, AVR_Options.avrdudeConfigPath, cstFilename, 30);
end;

procedure TAVR_IDE_Options_Frame.WriteSettings(AOptions: TAbstractIDEOptions);
begin
  AVR_Options.avrdudePfad := ComboBoxAVRdude.Text;
  AVR_Options.avrdudeConfigPath := ComboBoxAVRdudeConf.Text;
  AVR_Options.Save;
end;

class function TAVR_IDE_Options_Frame.SupportedOptionsClass: TAbstractIDEOptionsClass;
begin
  Result := IDEEditorGroups.GetByIndex(GroupEnvironment)^.GroupClass;
end;

end.


