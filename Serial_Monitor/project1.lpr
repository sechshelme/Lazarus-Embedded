program project1;

{$mode objfpc}{$H+}

uses {$IFDEF UNIX} {$IFDEF UseCThreads}
  cthreads, {$ENDIF} {$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms,
  Input,
  Embedded_GUI_Find_Comports,
  Embedded_GUI_Serial_Monitor_Form,
Embedded_GUI_Serial_Monitor_Interface_Options_Frame { you can add units after this };

{$R *.res}

begin
  RequireDerivedFormResource := True;
  Application.Initialize;
  Application.CreateForm(TSerial_Monitor_Form, Serial_Monitor_Form);
  Application.Run;
end.

