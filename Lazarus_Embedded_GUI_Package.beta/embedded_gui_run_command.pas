unit Embedded_GUI_Run_Command;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, process,
  Embedded_GUI_Common;

type

  { TRun_Command_Form }

  TRun_Command_Form = class(TForm)
    Button_Close: TButton;
    Memo1: TMemo;
    procedure Button_CloseClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    Process: TProcess;
    function getExitCode: Integer;
  public
    procedure RunCommand(command: string);
    property ExitCode:Integer read getExitCode;
  end;

var
  Run_Command_Form: TRun_Command_Form;

implementation

{$R *.lfm}

{ TRun_Command_Form }

procedure TRun_Command_Form.Button_CloseClick(Sender: TObject);
begin
  Close;
end;

procedure TRun_Command_Form.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  SaveFormPos_to_XML(Self);
end;

procedure TRun_Command_Form.FormCreate(Sender: TObject);
begin
  Caption := Title + 'ARM Vorlagen';
  LoadFormPos_from_XML(Self);
  Memo1.Clear;
  Memo1.ReadOnly:=True;
  Memo1.WordWrap := False;
  Memo1.ScrollBars := ssAutoBoth;
  Memo1.Font.Name := 'Ubuntu Mono';
  Process := TProcess.Create(Self);
end;

procedure TRun_Command_Form.FormDestroy(Sender: TObject);
begin
  Process.Free;
end;

function TRun_Command_Form.getExitCode: Integer;
begin
  Result:=Process.ExitCode;
end;

procedure TRun_Command_Form.RunCommand(command: string);
const
  READ_BYTES = 2048;
var
  sl: TStringList;
  ms: TMemoryStream;
  n, BytesRead: integer;

begin
  Show;
  ms := TMemoryStream.Create;
  BytesRead := 0;

  Process.CommandLine := command;
  Process.Options := [poUsePipes, poStderrToOutPut];
  Process.Execute;
  while Process.Running do begin
    ms.SetSize(BytesRead + READ_BYTES);
    n := Process.Output.Read((ms.Memory + BytesRead)^, READ_BYTES);
    if n > 0 then begin
      Inc(BytesRead, n);
    end else begin
      Sleep(100);
    end;
  end;
  repeat
    ms.SetSize(BytesRead + READ_BYTES);
    n := Process.Output.Read((ms.Memory + BytesRead)^, READ_BYTES);
    Inc(BytesRead, n);
  until n <= 0;
  if BytesRead > 0 then begin
//    WriteLn;
  end;
  ms.SetSize(BytesRead);

  sl := TStringList.Create;
  sl.LoadFromStream(ms);
  Memo1.Lines.Add(command);
  Memo1.Lines.AddStrings(sl);
  sl.Free;
  ms.Free;
end;

end.
