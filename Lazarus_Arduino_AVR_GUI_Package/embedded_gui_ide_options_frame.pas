unit Embedded_GUI_IDE_Options_Frame;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, StdCtrls, Dialogs, ComCtrls, EditBtn,
  Spin, ExtCtrls, IDEUtils, LazConfigStorage, BaseIDEIntf, LazIDEIntf,
  ProjectIntf, CompOptsIntf, IDEOptionsIntf, IDEOptEditorIntf,
  Embedded_GUI_Find_Comports,
  Embedded_GUI_Common,
  Embedded_GUI_AVR_Common,
  Embedded_GUI_Serial_Monitor_Options_Form,
  Embedded_GUI_Serial_Monitor_Interface_Options_Frame,
  Embedded_GUI_Serial_Monitor_Output_Options_Frame;

var
  Embedded_IDE_Options: TEmbedded_IDE_Options;

type
  (* Frames ist sichtbar in der Lazarus-IDE unter: "Werkzeuge/Einstellungen.../Umgebung/AVR-Options" *)

  { TEmbedded_IDE_Options_Frame }

  TEmbedded_IDE_Options_Frame = class(TAbstractIDEOptionsEditor)
    Button_AVRDude_Path: TButton;
    Button_AVRDude_Config: TButton;
    ComboBox_STFlashPfad: TComboBox;
    Button_ST_Flash: TButton;
    ComboBox_AVRdudePath: TComboBox;
    ComboBox_AVRdudeConf: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    OpenDialog: TOpenDialog;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    procedure Button_AVRDude_ConfigClick(Sender: TObject);
    procedure Button_AVRDude_PathClick(Sender: TObject);
    procedure Button_ST_FlashClick(Sender: TObject);
  private
    SM_Interface_Frame: TSM_Interface_Frame;
    SM_Output_Frame: TSM_Output_Frame;
  public
    function GetTitle: string; override;
    procedure Setup({%H-}ADialog: TAbstractOptionsEditorDialog); override;
    procedure ReadSettings({%H-}AOptions: TAbstractIDEOptions); override;
    procedure WriteSettings({%H-}AOptions: TAbstractIDEOptions); override;
    class function SupportedOptionsClass: TAbstractIDEOptionsClass; override;
  end;

implementation

{$R *.lfm}

{ TEmbedded_IDE_Options_Frame }

procedure TEmbedded_IDE_Options_Frame.Button_AVRDude_PathClick(Sender: TObject);
begin
  OpenDialog.FileName := ComboBox_AVRdudePath.Text;
  if OpenDialog.Execute then begin
    ComboBox_AVRdudePath.Text := OpenDialog.FileName;
    ComboBox_Insert_Text(ComboBox_AVRdudePath);
  end;
end;

procedure TEmbedded_IDE_Options_Frame.Button_AVRDude_ConfigClick(Sender: TObject);
begin
  OpenDialog.FileName := ComboBox_AVRdudeConf.Text;
  if OpenDialog.Execute then begin
    ComboBox_AVRdudeConf.Text := OpenDialog.FileName;
    ComboBox_Insert_Text(ComboBox_AVRdudeConf);
  end;
end;

procedure TEmbedded_IDE_Options_Frame.Button_ST_FlashClick(Sender: TObject);
begin
  OpenDialog.FileName := ComboBox_STFlashPfad.Text;
  if OpenDialog.Execute then begin
    ComboBox_STFlashPfad.Text := OpenDialog.FileName;
    ComboBox_Insert_Text(ComboBox_STFlashPfad);
  end;
end;

function TEmbedded_IDE_Options_Frame.GetTitle: string;
begin
  Result := Title + 'Embedded GUI Optionen';
end;

procedure TEmbedded_IDE_Options_Frame.Setup(ADialog: TAbstractOptionsEditorDialog);
begin
  SM_Interface_Frame := TSM_Interface_Frame.Create(Self);
  SM_Interface_Frame.Parent := Self.TabSheet3;
  SM_Output_Frame := TSM_Output_Frame.Create(Self);
  SM_Output_Frame.Parent := Self.TabSheet4;

  ////  ComboBox_AVRdudePath.Items.Add(Default_Avrdude_Path);
  //LoadComboBox_from_XML(ComboBox_AVRdudePath, Default_Avrdude_Path);
  //
  ////  ShowMessage(ComboBox_AVRdudePath.Items.CommaText);
  ////  ComboBox_AVRdudePath.Text := Default_Avrdude_Path;
  //
  //  Embedded_IDE_Options.AVR.avrdudePath.AddStrings(ComboBox_AVRdudePath.Items, True);
  //
  ////  ComboBox_AVRdudeConf.Items.Add(Default_Avrdude_Conf_Path);
  //  LoadComboBox_from_XML(ComboBox_AVRdudeConf, Default_Avrdude_Conf_Path);
  ////  ComboBox_AVRdudeConf.Text := Default_Avrdude_Conf_Path;
  //  Embedded_IDE_Options.AVR.avrdudeConfigPath.AddStrings(ComboBox_AVRdudeConf.Items, True);
  //
  ////  ComboBox_STFlashPfad.Items.Add(Default_STFlash_Path);
  //  LoadComboBox_from_XML(ComboBox_STFlashPfad, Default_STFlash_Path);
  ////  ComboBox_STFlashPfad.Text := Default_STFlash_Path;
  //  Embedded_IDE_Options.ARM.STFlashPath.AddStrings(ComboBox_STFlashPfad.Items, True);
  //
  //  //    SetComboBoxText(ComboBox_AVRdudePath, AVR.avrdudePath, cstFilename);
  //
  //  //    SetComboBoxText(ComboBox_AVRdudeConf, AVR.avrdudeConfigPath, cstFilename);
  //
  //  //    SetComboBoxText(ComboBox_STFlashPfad, ARM.STFlashPath, cstFilename);



  SM_Interface_Frame.ComboBox_Port.Items.CommaText := GetSerialPortNames;
  SM_Interface_Frame.ComboBox_Baud.Items.CommaText := UARTBaudRates;
  SM_Interface_Frame.ComboBox_Parity.Items.CommaText := UARTParitys;
  SM_Interface_Frame.ComboBox_Bits.Items.CommaText := UARTBitss;
  SM_Interface_Frame.ComboBox_StopBits.Items.CommaText := UARTStopBitss;
  SM_Interface_Frame.ComboBox_FlowControl.Items.CommaText := UARTFlowControls;

  SM_Output_Frame.RadioGroup_LineBreak.Items.AddStrings(OutputLineBreaks, True);
end;

procedure TEmbedded_IDE_Options_Frame.ReadSettings(AOptions: TAbstractIDEOptions);
begin
  with Embedded_IDE_Options do begin

    ComboBox_AVRdudePath.Items.AddStrings(AVR.avrdudePath, True);
    if ComboBox_AVRdudePath.Items.Count > 0 then begin
      ComboBox_AVRdudePath.Text := ComboBox_AVRdudePath.Items[0];
    end;

    ComboBox_AVRdudeConf.Items.AddStrings(AVR.avrdudeConfigPath, True);
    if ComboBox_AVRdudeConf.Items.Count > 0 then begin
      ComboBox_AVRdudeConf.Text := ComboBox_AVRdudeConf.Items[0];
    end;

    ComboBox_STFlashPfad.Items.AddStrings(ARM.STFlashPath, True);
    if ComboBox_STFlashPfad.Items.Count > 0 then begin
      ComboBox_STFlashPfad.Text := ComboBox_STFlashPfad.Items[0];
    end;

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
      end;
    end;
  end;
end;

procedure TEmbedded_IDE_Options_Frame.WriteSettings(AOptions: TAbstractIDEOptions);
begin
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
      end;
    end;

    ComboBox_Insert_Text(ComboBox_AVRdudePath);
    //    SaveComboBox_to_XML(ComboBox_AVRdudePath);

    ComboBox_Insert_Text(ComboBox_AVRdudeConf);
    //    SaveComboBox_to_XML(ComboBox_AVRdudeConf);

    ComboBox_Insert_Text(ComboBox_STFlashPfad);
    //    SaveComboBox_to_XML(ComboBox_STFlashPfad);

    AVR.avrdudePath.AddStrings(ComboBox_AVRdudePath.Items, True);
    AVR.avrdudeConfigPath.AddStrings(ComboBox_AVRdudeConf.Items, True);
    ARM.STFlashPath.AddStrings(ComboBox_STFlashPfad.Items, True);

    Embedded_IDE_Options.Save_to_XML;
  end;
end;

class function TEmbedded_IDE_Options_Frame.SupportedOptionsClass: TAbstractIDEOptionsClass;
begin
  Result := IDEEditorGroups.GetByIndex(GroupEnvironment)^.GroupClass;
end;

end.




