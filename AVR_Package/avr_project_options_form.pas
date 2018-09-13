unit Avr_Project_Options_Form;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, StdCtrls, Dialogs,
  LazIDEIntf, ProjectIntf, CompOptsIntf, IDEOptionsIntf, IDEOptEditorIntf,
  IDEExternToolIntf,
  Laz2_XMLCfg, // Für direkte *.lpi Zugriff

  AVR_IDE_Options, AVR_Project_Options_Frame;

type

  { TProjectOptionsForm }

  TProjectOptionsForm = class(TForm)
    AVR_Project_Options_Frame1: TAVR_Project_Options_Frame;
    Button1: TButton;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private

  public

  end;

var
  ProjectOptionsForm: TProjectOptionsForm;

implementation

{$R *.lfm}

{ TProjectOptionsForm }

procedure TProjectOptionsForm.Button2Click(Sender: TObject);
begin
  Close;
end;

procedure TProjectOptionsForm.Button1Click(Sender: TObject);
begin
  //  Close;
end;

end.
