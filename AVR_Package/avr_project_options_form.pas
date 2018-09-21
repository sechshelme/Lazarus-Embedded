unit AVR_Project_Options_Form;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, StdCtrls, Dialogs,
  LazConfigStorage, BaseIDEIntf,
  LazIDEIntf, ProjectIntf, CompOptsIntf, IDEOptionsIntf, IDEOptEditorIntf,
  IDEExternToolIntf,
  Laz2_XMLCfg, // Für direkte *.lpi Zugriff

  AVR_IDE_Options, AVR_Project_Options_Frame,AVR_Common;

type

  { TProjectOptionsForm }

  TProjectOptionsForm = class(TForm)
    OkButton: TButton;
    CancelButton: TButton;
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
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

const
  Key_ProjectOptions_Left = 'project_options_form_left/value';
  Key_ProjectOptions_Top = 'project_options_form_top/value';

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

var
  Cfg: TConfigStorage;
begin
  Cfg := GetIDEConfigStorage(AVR_Options_File, True);
  Left:=StrToInt(Cfg.GetValue(Key_ProjectOptions_Left, '100'));
  Top:=StrToInt(Cfg.GetValue(Key_ProjectOptions_Top, '50'));
  Cfg.Free;


  AVR_Project_Options_Frame := TAVR_Project_Options_Frame.Create(Self);
  with AVR_Project_Options_Frame do begin
    Parent := Self;
    Align := alTop;
    Self.ClientHeight := Height + 50;
    Self.ClientWidth := Width;
  end;
end;

procedure TProjectOptionsForm.FormClose(Sender: TObject;  var CloseAction: TCloseAction);
var
  Cfg: TConfigStorage;
begin
  Cfg := GetIDEConfigStorage(AVR_Options_File, False);
  Cfg.SetDeleteValue(Key_ProjectOptions_Left, IntToStr(Left), '100');
  Cfg.SetDeleteValue(Key_ProjectOptions_Top, IntToStr(Top), '50');
  Cfg.Free;
end;

end.
