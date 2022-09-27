{ This file was automatically created by Lazarus. Do not edit!
  This source is only used to compile and install the package.
 }

unit Embedded_GUI_Package;

{$warn 5023 off : no warning about unused units}
interface

uses
  Embedded_GUI_Project_Options_Form, Embedded_GUI_Project_Templates_Form, 
  Embedded_GUI_Option_Dialog_Register, Embedded_GUI_CPU_Info_Form, 
  Embedded_GUI_Find_Comports, Embedded_GUI_IDE_Options_Frame, 
  Embedded_GUI_Register, Embedded_GUI_Serial_Monitor_Form, 
  Embedded_GUI_Serial_Monitor_Interface_Options_Frame, 
  Embedded_GUI_Serial_Monitor_Options_Form, 
  Embedded_GUI_Serial_Monitor_Output_Options_Frame, 
  Embedded_GUI_Serial_Monitor_Send_File_Form, 
  Embedded_GUI_Common_FileComboBox, Embedded_GUI_Common, 
  Embedded_GUI_Embedded_List_Const, Embedded_GUI_Frame_ESPTool, 
  Embedded_GUI_Frame_AVRDude, LazarusPackageIntf;

implementation

procedure Register;
begin
  RegisterUnit('Embedded_GUI_Register', @Embedded_GUI_Register.Register);
end;

initialization
  RegisterPackage('Embedded_GUI_Package', @Register);
end.
