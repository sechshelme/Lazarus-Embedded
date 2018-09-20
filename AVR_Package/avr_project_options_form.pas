unit AVR_Project_Options_Form;

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
    OkButton: TButton;
    CancelButton: TButton;
    procedure FormCreate(Sender: TObject);
    procedure OkButtonClick(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
  private

  public
    AVR_Project_Options_Frame: TAVR_Project_Options_Frame;

  end;

var
  ProjectOptionsForm: TProjectOptionsForm;

implementation

{$R *.lfm}

{ TProjectOptionsForm }

procedure TProjectOptionsForm.CancelButtonClick(Sender: TObject);
begin
  Close;
end;

procedure TProjectOptionsForm.OkButtonClick(Sender: TObject);
begin
  //  Close;
end;

procedure TProjectOptionsForm.FormCreate(Sender: TObject);
begin
  AVR_Project_Options_Frame := TAVR_Project_Options_Frame.Create(Self);
  with AVR_Project_Options_Frame do begin
    Parent := Self;
    Align := alTop;
    Self.ClientHeight := Height + 50;
    Self.ClientWidth := Width;
  end;
end;

end.
