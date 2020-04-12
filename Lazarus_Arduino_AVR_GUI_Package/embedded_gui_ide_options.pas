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
    avrdudePath,
    avrdudeConfigPath,
    STFlashPath: string;
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
    ComboBoxSTFlashPfad: TComboBox;
    ComboBoxAVRdudeConf: TComboBox;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
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
  Cfg.SetDeleteValue(Key_Avrdude_Path, avrdudePath, Default_Avrdude_Path);
  Cfg.SetDeleteValue(Key_Avrdude_Conf_Path, avrdudeConfigPath, Default_Avrdude_Conf_Path);
  Cfg.SetDeleteValue(Key_STFlash_Path, STFlashPath, Default_STFlash_Path);
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


