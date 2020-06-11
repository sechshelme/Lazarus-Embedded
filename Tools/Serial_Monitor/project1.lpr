program project1;

{$mode objfpc}{$H+}

uses {$IFDEF UNIX} {$IFDEF UseCThreads}
  cthreads, {$ENDIF} {$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Embedded_GUI_Serial_Monitor_Form,
  Forms,
  Input;

{$R *.res}

begin
  RequireDerivedFormResource := True;
  Application.Initialize;
  Application.CreateForm(TSerial_Monitor_Form, Serial_Monitor_Form);
  Application.Run;
end.

