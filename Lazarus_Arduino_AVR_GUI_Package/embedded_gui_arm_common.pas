unit Embedded_GUI_ARM_Common;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Dialogs, LCLType, Controls,
  ProjectIntf,
  Embedded_GUI_SubArch_List; // Unit wird von "./Tools/Ebedded_List_to_const" generiert.

type

  { TARM_ProjectOptions }

  TARM_ProjectOptions = class
    stlink_Command: record
      FlashBase: string;
    end;
    ARM_SubArch, ARM_FPC_Typ: string;
    AsmFile: boolean;
    procedure Save(AProject: TLazProject);
    procedure Load(AProject: TLazProject);
  end;

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

  //s := AvrdudeCommand.Path + ' ';
  //if AvrdudeCommand.ConfigPath <> '' then begin
  //  s += '-C' + AvrdudeCommand.ConfigPath + ' ';
  //end;
  //
  //s += '-v ' +
  //  '-p' + AvrdudeCommand.AVR_AVRDude_Typ + ' ' +
  //  '-c' + AvrdudeCommand.Programmer + ' ';
  //pr := upCase(AvrdudeCommand.Programmer);
  //if (pr = 'ARDUINO') or (pr = 'STK500V1') or (pr = 'WIRING') then begin
  //  s += '-P' + AvrdudeCommand.COM_Port + ' ' +
  //    '-b' + AvrdudeCommand.Baud + ' ';
  //end;
  //
  //if AvrdudeCommand.Disable_Auto_Erase then begin
  //  s +='-D ';
  //end;
  //s += '-Uflash:w:' + AProject.LazCompilerOptions.TargetFilename + '.hex:i';
  //
  //AProject.LazCompilerOptions.ExecuteAfter.Command := s;

  AProject.LazCompilerOptions.ExecuteAfter.Command :=
    'st-flash write ' + AProject.LazCompilerOptions.TargetFilename +
    '.hex ' + stlink_Command.FlashBase;

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



