unit AVR_Project_Options_Form;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, StdCtrls, Dialogs,
  LazConfigStorage, BaseIDEIntf,
  LazIDEIntf, ProjectIntf, CompOptsIntf, IDEOptionsIntf, IDEOptEditorIntf,
  IDEExternToolIntf;

type
  { TProjectOptions }

  TProjectOptions = class
    AvrdudeCommand: record
      COM_Port: string;
    end;
    procedure Save(AProject: TLazProject);
    procedure Load(AProject: TLazProject);
  end;

var
  ProjectOptions: TProjectOptions;

type

  { TProjectOptionsForm }

  TProjectOptionsForm = class(TForm)
    COMPortComboBox: TComboBox;
    OkButton: TButton;
    CancelButton: TButton;
    procedure OkButtonClick(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
  private
  public
  end;

var
  ProjectOptionsForm: TProjectOptionsForm;

implementation

{$R *.lfm}

{ TProjectOptions }

procedure TProjectOptions.Save(AProject: TLazProject);
begin
  AProject.LazCompilerOptions.ExecuteAfter.Command := 'echo ' + AvrdudeCommand.COM_Port;
end;

procedure TProjectOptions.Load(AProject: TLazProject);
var
  s: string;
begin
  s := AProject.LazCompilerOptions.ExecuteAfter.Command;
  AvrdudeCommand.COM_Port := Copy(s, 6);
end;


{ TProjectOptionsForm }

procedure TProjectOptionsForm.CancelButtonClick(Sender: TObject);
begin
  Close;
end;

procedure TProjectOptionsForm.OkButtonClick(Sender: TObject);
begin
  //  Close;
end;

end.
