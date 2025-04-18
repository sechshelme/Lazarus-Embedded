unit Embedded_GUI_Frame_IDE_Options;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, StdCtrls, Dialogs, ComCtrls, EditBtn,
  Spin, ExtCtrls, Graphics,

  IDEUtils, LazConfigStorage, BaseIDEIntf, LazIDEIntf,
  ProjectIntf, CompOptsIntf, IDEOptionsIntf, IDEOptEditorIntf,

  Embedded_GUI_Find_Comports,
  Embedded_GUI_Common,
  Embedded_GUI_Common_FileComboBox,
  Embedded_GUI_Serial_Monitor_Options_Form,
  Embedded_GUI_Frame_Serial_Monitor_Interface_Options,
  Embedded_GUI_Frame_Serial_Monitor_Output_Options;

var
  Embedded_IDE_Options: TEmbedded_IDE_Options;

type
  (* Frames ist sichtbar in der Lazarus-IDE unter: "Werkzeuge/Einstellungen.../Umgebung/Embedded-GUI-Options" *)

  { TEmbedded_IDE_Options_Frame }

  TEmbedded_IDE_Options_Frame = class(TAbstractIDEOptionsEditor)
    Button_Color_OS_Default: TButton;
    Button_Color_GUI_Default: TButton;
    Button_Color_Custom: TButton;
    ColorDialog1: TColorDialog;
    GroupBox1: TGroupBox;
    OpenDialog: TOpenDialog;
    PageControl_IDE_Options: TPageControl;
    Panel_Preview: TPanel;
    TabSheetCustomPrg: TTabSheet;
    TabSheetXtensa: TTabSheet;
    TabSheetTemplates: TTabSheet;
    TabSheetAVR: TTabSheet;
    TabSheetARM: TTabSheet;
    TabSheet_SM_Interface: TTabSheet;
    TabSheet_SM_Output: TTabSheet;
    TabSheetGUI: TTabSheet;
    procedure Button_Color_OS_DefaultClick(Sender: TObject);
    procedure Button_Color_GUI_DefaultClick(Sender: TObject);
    procedure Button_Color_CustomClick(Sender: TObject);
  private
    ComboBox_AVRdudePath, ComboBox_AVRdudeConf, ComboBox_STFlashPath, ComboBox_BossacPath, ComboBox_Raspi_Pico_UnitPath,
    ComboBox_Raspi_Pico_cp_Path, ComboBox_Raspi_Pico_mount_Path, ComboBox_ESP_Tool_Path, ComboBox_ESP_Bootloader_Path,
    ComboBox_Custom_Programmer_Path,ComboBox_Custom_Programmer_Command, ComboBox_TemplatesPath: TFileNameComboBox;

    Frame_SerialMonitor_Interface: TFrame_SerialMonitor_Interface;
    Frame_SerialMonitor_Output: TFrame_SerialMonitor_Output;
  public
    function GetTitle: string; override;
    procedure Setup(ADialog: TAbstractOptionsEditorDialog); override;
    procedure ReadSettings(AOptions: TAbstractIDEOptions); override;
    procedure WriteSettings(AOptions: TAbstractIDEOptions); override;
    class function SupportedOptionsClass: TAbstractIDEOptionsClass; override;
  end;

implementation

{$R *.lfm}

{ TEmbedded_IDE_Options_Frame }

procedure TEmbedded_IDE_Options_Frame.Button_Color_OS_DefaultClick(Sender: TObject);
begin
  Panel_Preview.Color := clDefault;
end;

procedure TEmbedded_IDE_Options_Frame.Button_Color_GUI_DefaultClick(Sender: TObject);
begin
  Panel_Preview.Color := $E0F0E0;
end;

procedure TEmbedded_IDE_Options_Frame.Button_Color_CustomClick(Sender: TObject);
begin
  ColorDialog1.Color := Panel_Preview.Color;
  if ColorDialog1.Execute then begin
    Panel_Preview.Color := ColorDialog1.Color;
  end;
end;

function TEmbedded_IDE_Options_Frame.GetTitle: string;
begin
  Result := Title + 'Optionen';
end;

procedure TEmbedded_IDE_Options_Frame.Setup(ADialog: TAbstractOptionsEditorDialog);
begin
  if not Assigned(Frame_SerialMonitor_Interface) then begin
    Frame_SerialMonitor_Interface := TFrame_SerialMonitor_Interface.Create(Self);
    Frame_SerialMonitor_Interface.Parent := Self.TabSheet_SM_Interface;
  end;
  if not Assigned(Frame_SerialMonitor_Output) then begin
    Frame_SerialMonitor_Output := TFrame_SerialMonitor_Output.Create(Self);
    Frame_SerialMonitor_Output.Parent := Self.TabSheet_SM_Output;
  end;
end;

procedure TEmbedded_IDE_Options_Frame.ReadSettings(AOptions: TAbstractIDEOptions);
var
  col: TColor;
begin
  LoadPageControl_from_XML(PageControl_IDE_Options);

  // --- Programmer
  // AVR
  ComboBox_AvrdudePath := TFileNameComboBox.Create(TabSheetAVR, 'AVRDudePath', False);
  with ComboBox_AvrdudePath do begin
    Caption := 'AVRdude Pfad';
    Anchors := [akTop, akLeft, akRight];
    Left := 5;
    Width := Self.Width - 20;
    Top := 24;
  end;

  ComboBox_AVRdudeConf := TFileNameComboBox.Create(TabSheetAVR, 'AVRDudeConfig', False);
  with ComboBox_AVRdudeConf do begin
    Caption := 'AVRdude Config-Path ( empty = default Config. )';
    Anchors := [akTop, akLeft, akRight];
    Left := 5;
    Width := Self.Width - 20;
    Top := 104;
  end;

  // ST-Link
  ComboBox_STFlashPath := TFileNameComboBox.Create(TabSheetARM, 'STFlashPath', False);
  with ComboBox_STFlashPath do begin
    Caption := 'ST Flash Path';
    Anchors := [akTop, akLeft, akRight];
    Left := 5;
    Width := Self.Width - 20;
    Top := 24;
  end;

  // Bossac ( Arduino Due )
  ComboBox_BossacPath := TFileNameComboBox.Create(TabSheetARM, 'BossacPath', False);
  with ComboBox_BossacPath do begin
    Caption := 'Bossac Path';
    Anchors := [akTop, akLeft, akRight];
    Left := 5;
    Width := Self.Width - 20;
    Top := 104;
  end;

  // Rasberry PI Pico
  ComboBox_Raspi_Pico_UnitPath := TFileNameComboBox.Create(TabSheetARM, 'RaspiPicoUnitPath', False);
  with ComboBox_Raspi_Pico_UnitPath do begin
    Caption := 'Rasberry Pico - Unit Path:';
    Directory := True;
    Anchors := [akTop, akLeft, akRight];
    Left := 5;
    Width := Self.Width - 20;
    Top := 184;
  end;

  ComboBox_Raspi_Pico_cp_Path := TFileNameComboBox.Create(TabSheetARM, 'cpPath', False);
  with ComboBox_Raspi_Pico_cp_Path do begin
    Caption := 'Rasberry Pico - cp Path:';
    Anchors := [akTop, akLeft, akRight];
    Left := 5;
    Width := Self.Width - 20;
    Top := 264;
  end;

  ComboBox_Raspi_Pico_mount_Path := TFileNameComboBox.Create(TabSheetARM, 'mountPath', False);
  with ComboBox_Raspi_Pico_mount_Path do begin
    Caption := 'Rasberry Pico - Mount Path:';
    Directory := True;
    Anchors := [akTop, akLeft, akRight];
    Left := 5;
    Width := Self.Width - 20;
    Top := 344;
  end;

  // ESP Tool

  ComboBox_ESP_Tool_Path := TFileNameComboBox.Create(TabSheetXtensa, 'ESPToolhPath', False);
  with ComboBox_ESP_Tool_Path do begin
    Caption := 'ESP Tools Path';
    Anchors := [akTop, akLeft, akRight];
    Left := 5;
    Width := Self.Width - 20;
    Top := 24;
  end;

  ComboBox_ESP_Bootloader_Path := TFileNameComboBox.Create(TabSheetXtensa, 'ESPBootloaderPath', False);
  with ComboBox_ESP_Bootloader_Path do begin
    Caption := 'Bootloader Path (boootloader.bin, partitions_singleapp.bin)';
    Anchors := [akTop, akLeft, akRight];
    Left := 5;
    Width := Self.Width - 20;
    Top := 104;
  end;

  // Custom Programmer

  ComboBox_Custom_Programmer_Path := TFileNameComboBox.Create(TabSheetCustomPrg, 'CustomPrgPath', False);
  with ComboBox_Custom_Programmer_Path do begin
    Caption := 'Custom Programmer Path';
    Anchors := [akTop, akLeft, akRight];
    Left := 5;
    Width := Self.Width - 20;
    Top := 24;
  end;

  ComboBox_Custom_Programmer_Command := TFileNameComboBox.Create(TabSheetCustomPrg, 'CustomPrgCmd', False);
  with ComboBox_Custom_Programmer_Command do begin
    Caption := 'Custom Programmer Command';
    Anchors := [akTop, akLeft, akRight];
    Left := 5;
    Width := Self.Width - 20;
    Top := 104;
  end;

  // Templates

  ComboBox_TemplatesPath := TFileNameComboBox.Create(TabSheetTemplates, 'examplespath', False);
  with ComboBox_TemplatesPath do begin
    Caption := 'Examples Path';
    Directory := True;
    Anchors := [akTop, akLeft, akRight];
    Left := 5;
    Width := Self.Width - 20;
    Top := 24;
  end;

  with Embedded_IDE_Options do begin

    ComboBox_AVRdudePath.Items := AVR.avrdudePath;
    ComboBox_AVRdudeConf.Items := AVR.avrdudeConfigPath;
    ComboBox_STFlashPath.Items := ARM.STFlashPath;
    ComboBox_BossacPath.Items := ARM.BossacPath;
    ComboBox_Raspi_Pico_UnitPath.Items := ARM.Raspi_Pico.Unit_Path;
    ComboBox_Raspi_Pico_cp_Path.Items := ARM.Raspi_Pico.cp_Path;
    ComboBox_Raspi_Pico_mount_Path.Items := ARM.Raspi_Pico.mount_Path;
    ComboBox_ESP_Tool_Path.Items := ESP.Tools_Path;
    ComboBox_ESP_Bootloader_Path.Items := ESP.Bootloader_Path;
    ComboBox_Custom_Programmer_Path.Items := CustomProgrammer.Path;
    ComboBox_Custom_Programmer_Command.Items := CustomProgrammer.Command;

    with SerialMonitor_Options do begin
      with Com_Interface do begin
        Frame_SerialMonitor_Interface.ComboBox_Port.Text := Port;
        Frame_SerialMonitor_Interface.ComboBox_Baud.Text := Baud;
        Frame_SerialMonitor_Interface.ComboBox_Parity.Text := Parity;
        Frame_SerialMonitor_Interface.ComboBox_Bits.Text := Bits;
        Frame_SerialMonitor_Interface.ComboBox_StopBits.Text := StopBits;
        Frame_SerialMonitor_Interface.ComboBox_FlowControl.Text := FlowControl;

        Frame_SerialMonitor_Interface.SpinEdit_TimeOut.Value := TimeOut;
        Frame_SerialMonitor_Interface.SpinEdit_TimerInterval.Value := TimerInterval;
      end;

      with Output do begin
        Frame_SerialMonitor_Output.RadioGroup_LineBreak.ItemIndex := LineBreak;
        Frame_SerialMonitor_Output.CheckBox_AutoScroll.Checked := AutoScroll;
        Frame_SerialMonitor_Output.CheckBox_WordWarp.Checked := WordWarp;
        Frame_SerialMonitor_Output.ComboBox_maxRows.Text := IntToStr(maxRows);

        Frame_SerialMonitor_Output.Label_Color.Color := BKColor;
        Frame_SerialMonitor_Output.Label_Color.Font.Assign(Font);
      end;
    end;

    ComboBox_TemplatesPath.Items := Templates_Path;
  end;
  Load_IDE_Color_from_XML(col);
  Panel_Preview.Color := col;
  Color := col;
end;

procedure TEmbedded_IDE_Options_Frame.WriteSettings(AOptions: TAbstractIDEOptions);
var
  col: TColor;
begin
  SavePageControl_to_XML(PageControl_IDE_Options);

  with Embedded_IDE_Options do begin

    with SerialMonitor_Options do begin
      with Com_Interface do begin
        Port := Frame_SerialMonitor_Interface.ComboBox_Port.Text;
        Baud := Frame_SerialMonitor_Interface.ComboBox_Baud.Text;
        Parity := Frame_SerialMonitor_Interface.ComboBox_Parity.Text;
        Bits := Frame_SerialMonitor_Interface.ComboBox_Bits.Text;
        StopBits := Frame_SerialMonitor_Interface.ComboBox_StopBits.Text;
        FlowControl := Frame_SerialMonitor_Interface.ComboBox_FlowControl.Text;

        TimeOut := Frame_SerialMonitor_Interface.SpinEdit_TimeOut.Value;
        TimerInterval := Frame_SerialMonitor_Interface.SpinEdit_TimerInterval.Value;
      end;

      with Output do begin
        LineBreak := Frame_SerialMonitor_Output.RadioGroup_LineBreak.ItemIndex;
        AutoScroll := Frame_SerialMonitor_Output.CheckBox_AutoScroll.Checked;
        WordWarp := Frame_SerialMonitor_Output.CheckBox_WordWarp.Checked;
        maxRows := StrToInt(Frame_SerialMonitor_Output.ComboBox_maxRows.Text);

        BKColor := Frame_SerialMonitor_Output.Label_Color.Color;
        Font.Assign(Frame_SerialMonitor_Output.Label_Color.Font);
      end;
    end;

    AVR.avrdudePath.AddStrings(ComboBox_AVRdudePath.Items, True);
    AVR.avrdudeConfigPath.AddStrings(ComboBox_AVRdudeConf.Items, True);
    ARM.STFlashPath.AddStrings(ComboBox_STFlashPath.Items, True);
    ARM.BossacPath.AddStrings(ComboBox_BossacPath.Items, True);
    ARM.Raspi_Pico.Unit_Path.AddStrings(ComboBox_Raspi_Pico_UnitPath.Items, True);
    ARM.Raspi_Pico.cp_Path.AddStrings(ComboBox_Raspi_Pico_cp_Path.Items, True);
    ARM.Raspi_Pico.mount_Path.AddStrings(ComboBox_Raspi_Pico_mount_Path.Items, True);
    ESP.Tools_Path.AddStrings(ComboBox_ESP_Tool_Path.Items, True);
    ESP.Bootloader_Path.AddStrings(ComboBox_ESP_Bootloader_Path.Items, True);
    CustomProgrammer.Path.AddStrings(ComboBox_Custom_Programmer_Path.Items, True);
    CustomProgrammer.Command.AddStrings(ComboBox_Custom_Programmer_Command.Items, True);

    Templates_Path.AddStrings(ComboBox_TemplatesPath.Items, True);

    Embedded_IDE_Options.Save_to_XML;
  end;

  col := Panel_Preview.Color;
  Save_IDE_Color_to_XML(col);
end;

class function TEmbedded_IDE_Options_Frame.SupportedOptionsClass: TAbstractIDEOptionsClass;
begin
  Result := IDEEditorGroups.GetByIndex(GroupEnvironment)^.GroupClass;
end;

end.
