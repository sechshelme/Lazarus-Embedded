unit twi;

{$H-}
{$O-}

interface

procedure TWIInit;
procedure TWIStart(addr: byte);
procedure TWIStop;
procedure TWIWrite(u8data: byte);
function TWIReadACK: byte;
function TWIReadNACK: byte;

procedure TWIwriteByte(addr : Byte; b: Byte);

implementation

const
    CPU_Clock = 16000000; // Taktfrequenz Arduino, default 16MHz.
    TWI_Write = 0;
    TWI_Read = 1;

procedure TWIInit;
const
  F_SCL = 400000;                                // SCL Frequenz (400KHz)
  TWBR_val = byte((CPU_Clock div F_SCL) - 16) div 2;
begin
  TWSR := 0;
  TWBR := byte(TWBR_val);
end;

procedure TWIStart(addr: byte);
begin
  // Senden einleiten
  TWCR := 0;
  TWCR := (1 shl TWINT) or (1 shl TWSTA) or (1 shl TWEN);
  while ((TWCR and (1 shl TWINT)) = 0) do begin
  end;

  // Adresse des Endgerätes senden
  TWDR := addr;
  TWCR := (1 shl TWINT) or (1 shl TWEN);
  while ((TWCR and (1 shl TWINT)) = 0) do begin
  end;
end;

procedure TWIStop;
begin
  TWCR := (1 shl TWINT) or (1 shl TWSTO) or (1 shl TWEN);
end;

procedure TWIWrite(u8data: byte);
begin
  TWDR := u8data;
  TWCR := (1 shl TWINT) or (1 shl TWEN);
  while ((TWCR and (1 shl TWINT)) = 0) do begin
  end;
end;

function TWIReadACK: byte;
begin
  TWCR := (1 shl TWINT) or (1 shl TWEN) or (1 shl TWEA);
  while (TWCR and (1 shl TWINT)) = 0 do begin
  end;
  Result := TWDR;
end;

function TWIReadNACK: byte;
begin
  TWCR := (1 shl TWINT) or (1 shl TWEN);
  while (TWCR and (1 shl TWINT)) = 0 do begin
  end;
  Result := TWDR;
end;

procedure TWIwriteByte(addr : Byte; b: Byte);
begin
  TWIStart((addr shl 1) or TWI_Write);
  TWIWrite(b);
  TWIStop;
end;

end.

