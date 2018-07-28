unit I2C;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Dialogs, BaseUnix;

type

  { TI2C }

  TI2C = class(TObject)
  private
    fI2C_Device: cint;
  public
    property I2C_Device: cint read fI2C_Device;
    constructor Create(Adevice: string);
    destructor Destroy; override;

    procedure SetDevice(addr:cint);
    procedure writeBuf(buf: array of byte);
    procedure readBuf(var buf: array of byte);
  end;

implementation

{ TI2C }

const
  I2C_SLAVE = $0703;

constructor TI2C.Create(Adevice: string);
begin
  inherited Create;

  fI2C_Device := FpOpen(Adevice, O_RDWR);
  if fI2C_Device = -1 then begin
    ShowMessage('Kann I²C nicht öffnen, Error:' + IntToStr(fI2C_Device));
  end;
end;

destructor TI2C.Destroy;
begin
  FpClose(fI2C_Device);

  inherited Destroy;
end;

procedure TI2C.SetDevice(addr: cint);
begin
  fpIOCtl(fI2C_Device, I2C_SLAVE, pointer(addr));
end;

procedure TI2C.writeBuf(buf: array of byte);
begin
  FpWrite(fI2C_Device, buf, Length(buf));
end;

procedure TI2C.readBuf(var buf: array of byte);
begin
    FpRead(fI2C_Device, buf, Length(buf));
end;

end.
