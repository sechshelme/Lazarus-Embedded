unit Test_Register;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils,
  Forms, Controls, StdCtrls, Dialogs, ExtCtrls,
  ProjectIntf, CompOptsIntf, LazIDEIntf, IDEOptionsIntf, IDEOptEditorIntf, MenuIntf,

  Test_Frame;

procedure Register;

implementation

var
  Embbed_IDE_OptionsFrameID: integer = 1000;

procedure Register;
begin
  Embbed_IDE_OptionsFrameID := RegisterIDEOptionsEditor(GroupEnvironment, TFrame1, Embbed_IDE_OptionsFrameID)^.Index;
end;


end.
