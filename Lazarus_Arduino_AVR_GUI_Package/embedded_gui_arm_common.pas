unit Embedded_GUI_ARM_Common;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Dialogs, LCLType, Controls,
  ProjectIntf,
  Embedded_GUI_Common,
  Embedded_GUI_SubArch_List; // Unit wird von "./Tools/Ebedded_List_to_const" generiert.

type

  { TARM_ProjectOptions }

  TARM_ProjectOptions = class
    stlink_Command: record
      Path,
      FlashBase: string;
    end;
    ARM_SubArch, ARM_FPC_Typ: string;
    AsmFile: boolean;
    procedure Save(AProject: TLazProject);
    procedure Load(AProject: TLazProject);
  end;

type
  TARM_TemplatesPara = record
    Name,
    ARM_SubArch,
    ARM_FPC_Typ,
    FlashBase: string;
  end;

const
  ARM_TemplatesPara: array of TARM_TemplatesPara = ((
    Name: 'STM32F103X8';
    ARM_SubArch: 'ARMV7M';
    ARM_FPC_Typ: 'STM32F103X8';
    FlashBase: '0x08000000';),(

    Name: 'Arduino DUE';
    ARM_SubArch: 'ARMV7M';
    ARM_FPC_Typ: 'ATSAM3X8E';
    FlashBase: '0x080000'));

var
  ARM_ProjectOptions: TARM_ProjectOptions;

implementation

{ TARM_ProjectOptions }

procedure TARM_ProjectOptions.Save(AProject: TLazProject);
begin
  with AProject.LazCompilerOptions do begin
    TargetCPU := 'arm';
    TargetOS := 'embedded';
    TargetProcessor := ARM_SubArch;

    CustomOptions := '-Wp' + ARM_FPC_Typ;
    if AsmFile then begin
      CustomOptions := CustomOptions + LineEnding + '-al';
    end;
  end;

  AProject.LazCompilerOptions.ExecuteAfter.Command :=
    'st-flash write ' + AProject.LazCompilerOptions.TargetFilename +
    '.bin ' + stlink_Command.FlashBase;

end;

procedure TARM_ProjectOptions.Load(AProject: TLazProject);
var
  s: string;

  function Find(const Source, v: string): string;
  var
    p, Index: integer;
  begin
    p := pos(v, Source);
    Result := '';
    if p > 0 then begin
      p += Length(v);
      Index := p;
      while (Index <= Length(Source)) and (s[Index] > #32) do begin
        Result += Source[Index];
        Inc(Index);
      end;
    end;
  end;

begin
  ARM_SubArch := AProject.LazCompilerOptions.TargetProcessor;

  s := AProject.LazCompilerOptions.CustomOptions;
  AsmFile := Pos('-al', s) > 0;
  ARM_FPC_Typ := Find(s, '-Wp');

  s := AProject.LazCompilerOptions.ExecuteAfter.Command;
  //AvrdudeCommand.Path := Copy(s, 0, pos(' ', s) - 1);
  //AvrdudeCommand.ConfigPath := Find(s, '-C');
  //AvrdudeCommand.AVR_AVRDude_Typ := Find(s, '-p');
  //AvrdudeCommand.Programmer := Find(s, '-c');
  //AvrdudeCommand.COM_Port := Find(s, '-P');
  //AvrdudeCommand.Baud := Find(s, '-b');
  //AvrdudeCommand.Disable_Auto_Erase := pos('-D', s) > 0;

  stlink_Command.FlashBase := '0x' + Find(s, '0x');
end;

end.



