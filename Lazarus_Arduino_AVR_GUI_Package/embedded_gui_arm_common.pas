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
    procedure Save_to_Project(AProject: TLazProject);
    procedure Load_from_Project(AProject: TLazProject);
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

procedure TARM_ProjectOptions.Save_to_Project(AProject: TLazProject);
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

procedure TARM_ProjectOptions.Load_from_Project(AProject: TLazProject);
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
  stlink_Command.FlashBase := '0x' + Find(s, '0x');
end;

end.



