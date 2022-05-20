unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  TAGraph, TASeries;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Chart1: TChart;
    Chart1LineSeries1: TLineSeries;
    Panel1: TPanel;
    Shape1: TShape;
    Timer1: TTimer;
    ToggleBox1: TToggleBox;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure ToggleBox1Click(Sender: TObject);
  private
    function GetVoltage: single;
  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }



procedure TForm1.Button1Click(Sender: TObject);
begin
  Close;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Shape1.Brush.Color := clGreen;
  Chart1.DoubleBuffered := True;
  Randomize;
  Chart1.DoubleBuffered := True;
  Chart1.BottomAxis.Intervals.MaxLength := 100;
  Chart1.BottomAxis.Intervals.MinLength := 20;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
var
  voltage: single;
  s: string;
begin
  voltage := GetVoltage;
  Chart1LineSeries1.AddY(voltage);
  if Chart1LineSeries1.Count > 100 then begin
    Chart1LineSeries1.Delete(0);
  end;
  if voltage > 14 then begin
    Shape1.Brush.Color := clRed;
  end else if voltage > 13 then begin
    Shape1.Brush.Color := clYellow;
  end else if voltage < 10 then  begin
    Shape1.Brush.Color := clRed;
  end else if voltage < 11 then  begin
    Shape1.Brush.Color := clYellow;
  end else begin
    Shape1.Brush.Color := clGreen;
  end;
  Str(voltage: 5: 2, s);
  Panel1.Caption := s + 'V';
end;

procedure TForm1.ToggleBox1Click(Sender: TObject);
begin
  Timer1.Enabled := ToggleBox1.Checked;
end;

function TForm1.GetVoltage: single; // Simuliert eine Spannungsmessung
const
  LastVoltage: single = 10.0;
begin
  LastVoltage := LastVoltage + (-0.5 + Random);
  if LastVoltage > 15 then begin
    LastVoltage := 15;
  end;
  if LastVoltage < 9 then begin
    LastVoltage := 9;
  end;
  Result := LastVoltage;
end;

end.
