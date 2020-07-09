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
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
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

procedure TForm1.avrClick(Sender: TObject);
begin
  if not Assigned(RunCommandForm) then begin
    RunCommandForm := TRun_Command_Form.Create(nil);
  end;

  //  RunCommandForm.RunCommand('ls /home/tux/fpcupdeluxe_avr25 -R    ');

  RunCommandForm.RunCommand('avrdude -cusbasp -pattiny2313', False);
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  AProcess: TProcess;
begin
  AProcess := TProcess.Create(nil);

  AProcess.CommandLine := 'avrdude -patmega328p -cusbasp -v';
  //  AProcess.CommandLine := 'ls';

  AProcess.Options := AProcess.Options + [poWaitOnExit, poUsePipes];
  AProcess.Execute;

  Memo1.Lines.LoadFromStream(AProcess.Output);

  AProcess.Free;
end;

procedure TForm1.Button3Click(Sender: TObject);
const
  READ_BYTES = 2048;

var
  sl: TStringList;
  ms: TMemoryStream;
  AProcess: TProcess;
  n, BytesRead: integer;

begin
  ms := TMemoryStream.Create;
  BytesRead := 0;

  AProcess := TProcess.Create(nil);
  AProcess.CommandLine := 'ls /home/tux/fpcupdeluxe_avr25 -R    ';
  //  AProcess.CommandLine := 'avrdude';
  AProcess.Options := [poUsePipes];
  WriteLn('-- executing --');
  AProcess.Execute;
  while AProcess.Running do begin
    // stellt sicher, dass wir Platz haben
    ms.SetSize(BytesRead + READ_BYTES);

    // versuche, es zu lesen
    //    n := AProcess.Output.Read((ms.Memory + BytesRead)^, READ_BYTES);
    n := AProcess.Stderr.Read((ms.Memory + BytesRead)^, READ_BYTES);
    if n > 0 then begin
      Inc(BytesRead, n);
      Write('.');
    end else begin
      // keine Daten, warte 100 ms
      Sleep(100);
    end;
  end;
  // lese den letzten Teil
  repeat
    // stellt sicher, dass wir Platz haben
    ms.SetSize(BytesRead + READ_BYTES);
    // versuche es zu lesen
    //    n := AProcess.Output.Read((ms.Memory + BytesRead)^, READ_BYTES);
    n := AProcess.Stderr.Read((ms.Memory + BytesRead)^, READ_BYTES);
    if n > 0 then begin
      Inc(BytesRead, n);
      Write('.');
    end;
  until n <= 0;
  if BytesRead > 0 then begin
    WriteLn;
  end;
  ms.SetSize(BytesRead);
  WriteLn('-- executed --');

  sl := TStringList.Create;
  sl.LoadFromStream(ms);
  WriteLn('-- linecount = ', sl.Count, ' --');
  for n := 0 to sl.Count - 1 do begin
    WriteLn('| ', sl[n]);
  end;
  WriteLn('-- end --');
  sl.Free;
  AProcess.Free;
  ms.Free;
end;


end.
