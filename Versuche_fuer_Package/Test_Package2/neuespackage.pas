{ This file was automatically created by Lazarus. Do not edit!
  This source is only used to compile and install the package.
 }

unit NeuesPackage;

{$warn 5023 off : no warning about unused units}
interface

uses
  Test_Frame, Test_Register, LazarusPackageIntf;

implementation

procedure Register;
begin
  RegisterUnit('Test_Register', @Test_Register.Register);
end;

initialization
  RegisterPackage('NeuesPackage', @Register);
end.
