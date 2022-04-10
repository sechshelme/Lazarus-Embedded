unit Embedded_GUI_IDE_Options_Frame;

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
  Embedded_GUI_Serial_Monitor_Interface_Options_Frame,
  Embedded_GUI_Serial_Monitor_Output_Options_Frame;

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
      ComboBox_Raspi_Pico_cp_Path, ComboBox_Raspi_Pico_mount_Path, ComboBox_TemplatesPath: TFileNameComboBox;

    SM_Interface_Frame: TSM_Interface_Frame;
    SM_Output_Frame: TSM_Output_Frame;
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
  if not Assigned(SM_Interface_Frame) then begin
    SM_Interface_Frame := TSM_Interface_Frame.Create(Self);
    SM_Interface_Frame.Parent := Self.TabSheet_SM_Interface;
  end;
  if not Assigned(SM_Output_Frame) then begin
    SM_Output_Frame := TSM_Output_Frame.Create(Self);
    SM_Output_Frame.Parent := Self.TabSheet_SM_Output;
  end;
end;

procedure TEmbedded_IDE_Options_Frame.ReadSettings(AOptions: TAbstractIDEOptions);
var
  col: TColor;

//  ThisPackage: TPackageLink;
begin
  //ThisPackage:= PkgLinks.FindLinkWithPkgName('embedded_gui_package');
//  TabSheetTemplates.Caption:=ThisPackage.LPKFilename;
//  ShowMessage({$I %FILE%});


  LoadPageControl_from_XML(PageControl_IDE_Options);

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
    Caption := 'AVRdude Config-Pfad ( Leer = default Konfig. )';
    Anchors := [akTop, akLeft, akRight];
    Left := 5;
    Width := Self.Width - 20;
    Top := 104;
  end;

  // --- Programmer
  // ST-Link

  ComboBox_STFlashPath := TFileNameComboBox.Create(TabSheetARM, 'STFlashPath', False);
  with ComboBox_STFlashPath do begin
    Caption := 'ST Flash Pfad';
    Anchors := [akTop, akLeft, akRight];
    Left := 5;
    Width := Self.Width - 20;
    Top := 24;
  end;

  // Bossac ( Arduino Due )

  ComboBox_BossacPath := TFileNameComboBox.Create(TabSheetARM, 'BossacPath', False);
  with ComboBox_BossacPath do begin
    Caption := 'Bassac Pfad';
    Anchors := [akTop, akLeft, akRight];
    Left := 5;
    Width := Self.Width - 20;
    Top := 104;
  end;

  // Rasberry PI Pico

  ComboBox_Raspi_Pico_UnitPath := TFileNameComboBox.Create(TabSheetARM, 'RaspiPicoUnitPath', False);
  with ComboBox_Raspi_Pico_UnitPath do begin
    Caption := 'Rasberry Pico - Unit Pfad:';
    Directory := True;
    Anchors := [akTop, akLeft, akRight];
    Left := 5;
    Width := Self.Width - 20;
    Top := 184;
  end;

  ComboBox_Raspi_Pico_cp_Path := TFileNameComboBox.Create(TabSheetARM, 'cpPath', False);
  with ComboBox_Raspi_Pico_cp_Path do begin
    Caption := 'cp Pfad:';
    Anchors := [akTop, akLeft, akRight];
    Left := 5;
    Width := Self.Width - 20;
    Top := 264;
  end;

  ComboBox_Raspi_Pico_mount_Path := TFileNameComboBox.Create(TabSheetARM, 'mountPath', False);
  with ComboBox_Raspi_Pico_mount_Path do begin
    Caption := 'Mount Pfad:';
    Directory := True;
    Anchors := [akTop, akLeft, akRight];
    Left := 5;
    Width := Self.Width - 20;
    Top := 344;
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

    with SerialMonitor_Options do begin
      with Com_Interface do begin
        SM_Interface_Frame.ComboBox_Port.Text := Port;
        SM_Interface_Frame.ComboBox_Baud.Text := Baud;
        SM_Interface_Frame.ComboBox_Parity.Text := Parity;
        SM_Interface_Frame.ComboBox_Bits.Text := Bits;
        SM_Interface_Frame.ComboBox_StopBits.Text := StopBits;
        SM_Interface_Frame.ComboBox_FlowControl.Text := FlowControl;

        SM_Interface_Frame.SpinEdit_TimeOut.Value := TimeOut;
        SM_Interface_Frame.SpinEdit_TimerInterval.Value := TimerInterval;
      end;

      with Output do begin
        SM_Output_Frame.RadioGroup_LineBreak.ItemIndex := LineBreak;
        SM_Output_Frame.CheckBox_AutoScroll.Checked := AutoScroll;
        SM_Output_Frame.CheckBox_WordWarp.Checked := WordWarp;
        SM_Output_Frame.ComboBox_maxRows.Text := IntToStr(maxRows);

        SM_Output_Frame.Label_Color.Color := BKColor;
        SM_Output_Frame.Label_Color.Font.Assign(Font);
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
        Port := SM_Interface_Frame.ComboBox_Port.Text;
        Baud := SM_Interface_Frame.ComboBox_Baud.Text;
        Parity := SM_Interface_Frame.ComboBox_Parity.Text;
        Bits := SM_Interface_Frame.ComboBox_Bits.Text;
        StopBits := SM_Interface_Frame.ComboBox_StopBits.Text;
        FlowControl := SM_Interface_Frame.ComboBox_FlowControl.Text;

        TimeOut := SM_Interface_Frame.SpinEdit_TimeOut.Value;
        TimerInterval := SM_Interface_Frame.SpinEdit_TimerInterval.Value;
      end;

      with Output do begin
        LineBreak := SM_Output_Frame.RadioGroup_LineBreak.ItemIndex;
        AutoScroll := SM_Output_Frame.CheckBox_AutoScroll.Checked;
        WordWarp := SM_Output_Frame.CheckBox_WordWarp.Checked;
        maxRows := StrToInt(SM_Output_Frame.ComboBox_maxRows.Text);

        BKColor := SM_Output_Frame.Label_Color.Color;
        Font.Assign(SM_Output_Frame.Label_Color.Font);
      end;
    end;

    AVR.avrdudePath.AddStrings(ComboBox_AVRdudePath.Items, True);
    AVR.avrdudeConfigPath.AddStrings(ComboBox_AVRdudeConf.Items, True);
    ARM.STFlashPath.AddStrings(ComboBox_STFlashPath.Items, True);
    ARM.BossacPath.AddStrings(ComboBox_BossacPath.Items, True);
    ARM.Raspi_Pico.Unit_Path.AddStrings(ComboBox_Raspi_Pico_UnitPath.Items, True);
    ARM.Raspi_Pico.cp_Path.AddStrings(ComboBox_Raspi_Pico_cp_Path.Items, True);
    ARM.Raspi_Pico.mount_Path.AddStrings(ComboBox_Raspi_Pico_mount_Path.Items, True);

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
