unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, process,
  Embedded_GUI_Run_Command;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    avr: TButton;
    Memo1: TMemo;
    procedure avrClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    RunCommandForm: TRun_Command_Form;
  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.Button1Click(Sender: TObject);
var
  s: string;
begin
  //  RunCommand('avrdude', ['-patmega328p', '-cusbasp', '-v'], s,[poWaitOnExit, poUsePipes]);
  //  if RunCommand('/bin/bash',['-c','echo $PATH'],s) then begin
  if RunCommand('avrdude', ['-patmega328p', '-cusbasp', '-v'], s) then begin
    // if RunCommand('avrdude', ['-patmega328p', '-cusbasp', '-v'], s, [poWaitOnExit]) then begin
    Memo1.Lines.Add('geklappt');
    Memo1.Lines.Add(s);
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
end;

procedure TForm1.avrClick(Sender: TObject);
begin
  if not Assigned(RunCommandForm) then begin
    RunCommandForm := TRun_Command_Form.Create(nil);
  end;

//    RunCommandForm.RunCommand('ls /home/tux/fpcupdeluxe_avr25 -R    ');

//RunCommandForm.RunCommand('avrdude -cusbasp -pattiny2313');
RunCommandForm.RunCommand('avrdude -cusbasp -pattiny2313 -Uhfuse:r:-:h -Ulfuse:r:-:h -Uefuse:r:-:h');
  Caption:=RunCommandForm.ExitCode.ToString;
end;





end.
