{ This file was automatically created by Lazarus. Do not edit!
  This source is only used to compile and install the package.
 }

unit AVR_Package;

{$warn 5023 off : no warning about unused units}
interface

uses
  AVR_Register, AVR_IDE_Options, avr_project_options_Form, 
  AVR_Project_Options_Frame, LazarusPackageIntf;

implementation

procedure Register;
begin
  RegisterUnit('AVR_Register', @AVR_Register.Register);
end;

initialization
  RegisterPackage('AVR_Package', @Register);
end.
