program Project1;

//
//{$L platform.c.obj}
//{$L claim.c.obj}
//{$L clocks.c.obj}
//{$L xosc.c.obj}
//{$L pll.c.obj}
//{$L watchdog.c.obj}
//{$L irq.c.obj}

//{$LinkLib gcc-armv6m,static}


//{$modeswitch advancedrecords}
//{$SCOPEDENUMS ON}
//uses
//  pico_c;

//{$L gpio.c.obj}

{$mode objfpc}
{$H+}
{$O-}
{$modeswitch advancedrecords}
{$SCOPEDENUMS ON}

{$L platform.c.obj}
{$L claim.c.obj}
{$L clocks.c.obj}
{$L xosc.c.obj}
{$L pll.c.obj}
{$L watchdog.c.obj}
{$L irq.c.obj}

{$L boot2_pico.obj}

{$LinkLib gcc-armv6m,static}

{$L gpio.c.obj}

{$MEMORY 10000,10000}

uses
  pico_gpio_c;

procedure gpio_init(gpio:Byte);cdecl; external;


procedure Delay;
var
  i,j:Integer;
begin
//  for i:=0 to 600 do for j:=0 to 6000 do;
  for i:=0 to 600000 do;
end;

begin
  gpio_init(25);
  sio.gpio_oe_set := 1 shl 25;
  repeat
    sio.gpio_togl := 1 shl 25;
    Delay;
  until 1=0;
end.

