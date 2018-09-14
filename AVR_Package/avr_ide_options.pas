unit AVR_IDE_Options;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, StdCtrls, Dialogs,
  IDEUtils, LazConfigStorage, BaseIDEIntf, LazIDEIntf, ProjectIntf, CompOptsIntf, IDEOptionsIntf, IDEOptEditorIntf;

const
  AVR_Options_File = 'avroptions.xml';


type

  { TAVR_Options }

  TAVR_Options = class
  public
    avrdudePfad,
    avrdudeConfPfad: string;
    procedure Save;
    procedure Load;
  end;

var
  AVR_Options: TAVR_Options;

type


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
  Default_Avrdude_Pfad = '/usr/bin/avrdude';

  Key_Avrdude_Conf_Pfad = 'averdude_conf_pfad/value';
  Default_Avrdude_Conf_Pfad = '/etc/averdude.conf';

procedure TAVR_Options.Load;
var
  Cfg: TConfigStorage;
begin
  Cfg := GetIDEConfigStorage(AVR_Options_File, True);
  avrdudePfad := Cfg.GetValue(Key_Avrdude_Pfad, Default_Avrdude_Pfad);
  avrdudeConfPfad := Cfg.GetValue(Key_Avrdude_Conf_Pfad, Default_Avrdude_Conf_Pfad);
  Cfg.Free;
end;

procedure TAVR_Options.Save;
var
  Cfg: TConfigStorage;
begin
  Cfg := GetIDEConfigStorage(AVR_Options_File, False);
  Cfg.SetDeleteValue(Key_Avrdude_Pfad, avrdudePfad, Default_Avrdude_Pfad);
  Cfg.SetDeleteValue(Key_Avrdude_Conf_Pfad, avrdudeConfPfad, Default_Avrdude_Conf_Pfad);
  Cfg.Free;
end;

{ TAVR_IDE_Options_Frame }

function TAVR_IDE_Options_Frame.GetTitle: string;
begin
  Result := 'AVR Optionen';
end;

procedure TAVR_IDE_Options_Frame.Setup(ADialog: TAbstractOptionsEditorDialog);
begin
  ComboBoxAVRdude.Text := Default_Avrdude_Pfad;
  ComboBoxAVRdudeConf.Text := Default_Avrdude_Conf_Pfad;
end;

procedure TAVR_IDE_Options_Frame.ReadSettings(AOptions: TAbstractIDEOptions);
begin
  SetComboBoxText(ComboBoxAVRdude, AVR_Options.avrdudePfad, cstFilename, 30);
  SetComboBoxText(ComboBoxAVRdudeConf, AVR_Options.avrdudeConfPfad, cstFilename, 30);
end;

procedure TAVR_IDE_Options_Frame.WriteSettings(AOptions: TAbstractIDEOptions);
begin
  AVR_Options.avrdudePfad := ComboBoxAVRdude.Text;
  AVR_Options.avrdudeConfPfad := ComboBoxAVRdudeConf.Text;
  AVR_Options.Save;
end;

class function TAVR_IDE_Options_Frame.SupportedOptionsClass: TAbstractIDEOptionsClass;
begin
  Result := IDEEditorGroups.GetByIndex(GroupEnvironment)^.GroupClass;
end;

end.


