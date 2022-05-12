unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.Button1Click(Sender: TObject);
begin
  Memo1.Clear;
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p uc3a051-cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p c128   -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p c32    -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p c64    -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p pwm2   -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p pwm216 -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p pwm2b  -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p pwm3   -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p pwm316 -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p pwm3b  -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p 1200   -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p 2313   -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p 2333   -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p 2343   -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p 4414   -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p 4433   -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p 4434   -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p 8515   -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p 8535   -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p usb1286-cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p usb1287-cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p usb162 -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p usb646 -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p usb647 -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p usb82  -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p m103   -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p m128   -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p m1280  -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p m1281  -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p m1284  -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p m1284p -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p m1284rf-cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p m128rfa-cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p m128rfr-cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p m16    -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p m161   -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p m162   -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p m163   -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p m164p  -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p m168   -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p m168p  -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p m168pb -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p m169   -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p m16u2  -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p m2560  -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p m2561  -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p m2564rf-cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p m256rfr-cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p m32    -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p m3208  -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p m3209  -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p m324p  -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p m324pa -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p m325   -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p m3250  -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p m328   -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p m328p  -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p m328pb -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p m329   -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p m3290  -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p m3290p -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p m329p  -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p m32m1  -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p m32u2  -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p m32u4  -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p m406   -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p m48    -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p m4808  -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p m4809  -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p m48p   -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p m48pb  -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p m64    -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p m640   -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p m644   -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p m644p  -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p m644rfr-cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p m645   -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p m6450  -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p m649   -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p m6490  -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p m64m1  -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p m64rfr2-cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p m8     -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p m8515  -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p m8535  -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p m88    -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p m88p   -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p m88pb  -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p m8u2   -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p t10    -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p t11    -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p t12    -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p t13    -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p t15    -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p t1604  -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p t1606  -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p t1607  -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p t1614  -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p t1616  -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p t1617  -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p t1634  -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p t20    -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p t202   -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p t204   -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p t212   -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p t214   -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p t2313  -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p t24    -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p t25    -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p t26    -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p t261   -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p t28    -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p t3214  -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p t3216  -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p t3217  -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p t4     -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p t40    -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p t402   -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p t404   -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p t406   -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p t412   -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p t414   -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p t416   -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p t417   -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p t4313  -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p t43u   -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p t44    -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p t441   -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p t45    -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p t461   -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p t5     -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p t804   -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p t806   -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p t807   -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p t814   -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p t816   -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p t817   -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p t84    -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p t841   -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p t85    -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p t861   -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p t88    -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p t9     -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p x128a1 -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p x128a1d-cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p x128a1u-cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p x128a3 -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p x128a3u-cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p x128a4 -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p x128a4u-cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p x128b1 -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p x128b3 -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p x128c3 -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p x128d3 -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p x128d4 -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p x16a4  -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p x16a4u -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p x16c4  -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p x16d4  -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p x16e5  -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p x192a1 -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p x192a3 -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p x192a3u-cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p x192c3 -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p x192d3 -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p x256a1 -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p x256a3 -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p x256a3b-cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p x256a3b-cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p x256a3u-cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p x256c3 -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p x256d3 -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p x32a4  -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p x32a4u -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p x32c4  -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p x32d4  -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p x32e5  -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p x384c3 -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p x384d3 -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p x64a1  -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p x64a1u -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p x64a3  -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p x64a3u -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p x64a4  -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p x64a4u -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p x64b1  -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p x64b3  -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p x64c3  -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p x64d3  -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p x64d4  -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p x8e5   -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.Add('/home/tux/Schreibtisch/avrdude-7.0/avrdude -v -D -p ucr2   -cstk500v1 -P/dev/ttyUSB0 - b19200 -t');
  Memo1.Lines.SaveToFile('test.sh');                          end;

end.
