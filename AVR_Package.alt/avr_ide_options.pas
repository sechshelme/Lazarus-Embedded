unit AVR_IDE_Options;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, StdCtrls, Dialogs,
  IDEUtils, LazConfigStorage, BaseIDEIntf, LazIDEIntf, ProjectIntf,
  CompOptsIntf, IDEOptionsIntf, IDEOptEditorIntf;


type

  { TAVR_Options }

  TAVR_Options = record
    avrdudePfad: string;
//    procedure Save;
//    procedure Load;
  end;

var
  AVR_Options: TAVR_Options;

type


  { TAVR_IDE_Options_Frame }

  TAVR_IDE_Options_Frame = class(TAbstractIDEOptionsEditor)
    ComboBox1: TComboBox;
    Label1: TLabel;
  private

  public
    function GetTitle: string; override;
    procedure Setup({%H-}ADialog: TAbstractOptionsEditorDialog); override;
    procedure ReadSettings({%H-}AOptions: TAbstractIDEOptions); override;
    procedure WriteSettings({%H-}AOptions: TAbstractIDEOptions); override;
    class function SupportedOptionsClass: TAbstractIDEOptionsClass; override;

  end;

procedure Load;


implementation

{$R *.lfm}

{ TAVR_Options }

const
  AVR_Options_File = 'avroptions.xml';

  Key_Avrdude_Pfad = 'averdude_pfad/value';
  Default_Avrdude_Pfad = '/usr/bin/averdude';

//procedure TAVR_Options.Load;
//var
//  Cfg: TConfigStorage;
//begin
//  Cfg := GetIDEConfigStorage(AVR_Options_File, True);
//
//  avrdudePfad := Cfg.GetValue(Key_Avrdude_Pfad, Default_Avrdude_Pfad);
//
//  Cfg.Free;
//end;
//
//procedure TAVR_Options.Save;
//var
//  Cfg: TConfigStorage;
//begin
//  Cfg := GetIDEConfigStorage(AVR_Options_File, False);
//
//  Cfg.SetDeleteValue(Key_Avrdude_Pfad, avrdudePfad, Default_Avrdude_Pfad);
//
//  Cfg.Free;
//end;

{ TAVR_IDE_Options_Frame }

function TAVR_IDE_Options_Frame.GetTitle: string;
begin
  Result := 'AVR Optionen';
end;

procedure TAVR_IDE_Options_Frame.Setup(ADialog: TAbstractOptionsEditorDialog);
begin
  ComboBox1.Text := '/usr/bin/avrdude';
end;

procedure TAVR_IDE_Options_Frame.ReadSettings(AOptions: TAbstractIDEOptions);
begin
  SetComboBoxText(ComboBox1, AVR_Options.avrdudePfad, cstFilename, 30);
end;

procedure TAVR_IDE_Options_Frame.WriteSettings(AOptions: TAbstractIDEOptions);
var
  Cfg: TConfigStorage;
begin
  AVR_Options.avrdudePfad := ComboBox1.Text;

  Cfg := GetIDEConfigStorage(AVR_Options_File, False);

  Cfg.SetDeleteValue(Key_Avrdude_Pfad, AVR_Options.avrdudePfad, Default_Avrdude_Pfad);

  Cfg.Free;

//  AVR_Options.Save;
end;

class function TAVR_IDE_Options_Frame.SupportedOptionsClass: TAbstractIDEOptionsClass;
begin
  Result := IDEEditorGroups.GetByIndex(GroupEnvironment)^.GroupClass;
end;

procedure Load;
var
  Cfg: TConfigStorage;
begin
  Cfg := GetIDEConfigStorage(AVR_Options_File, True);

  Cfg.SetDeleteValue(Key_Avrdude_Pfad,AVR_Options.avrdudePfad, Default_Avrdude_Pfad);

  Cfg.Free;
end;

end.


