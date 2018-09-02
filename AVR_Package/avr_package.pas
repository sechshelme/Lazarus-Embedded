{ This file was automatically created by Lazarus. Do not edit!
  This source is only used to compile and install the package.
 }

unit AVR_Package;

{$warn 5023 off : no warning about unused units}
interface

uses
  PJSDsgnRegister, PJSDsgnOptsFrame, frmpas2jsbrowserprojectoptions, 
  PJSDsgnOptions, frmpas2jsnodejsprojectoptions, pjscontroller, 
  frmpas2jswebservers, strpas2jsdesign, pjsprojectoptions, AVR_IDE_Options, 
  AVR_Project_Options, LazarusPackageIntf;

implementation

procedure Register;
begin
  RegisterUnit('PJSDsgnRegister', @PJSDsgnRegister.Register);
end;

initialization
  RegisterPackage('AVR_Package', @Register);
end.
