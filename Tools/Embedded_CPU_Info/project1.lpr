program project1;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, Embedded_GUI_Embedded_List_Const, Embedded_GUI_CPU_Info_Form;



{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Scaled:=True;
  Application.Initialize;
  Application.CreateForm(TCPU_InfoForm, CPU_InfoForm);
  Application.Run;
end.

