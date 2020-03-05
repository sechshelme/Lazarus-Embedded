{ This file was automatically created by Lazarus. Do not edit!
  This source is only used to compile and install the package.
 }

unit Embedded_GUI_Package;

{$warn 5023 off : no warning about unused units}
interface

uses
  Embedded_GUI_Register, Embedded_GUI_IDE_Options, 
  Embedded_GUI_AVR_Project_Options_Form, Embedded_GUI_AVR_Common, 
  Embedded_GUI_Serial_Monitor, Embedded_GUI_AVR_Project_Templates_Form, 
  Embedded_GUI_SubArch_List, Embedded_GUI_Find_Comports, LazarusPackageIntf;

implementation

procedure Register;
begin
  RegisterUnit('Embedded_GUI_Register', @Embedded_GUI_Register.Register);
end;

initialization
  RegisterPackage('Embedded_GUI_Package', @Register);
end.
