unit Embedded_GUI_Frame_AVRDude;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, LResources, Forms, Controls, StdCtrls, Buttons,
  Embedded_GUI_Common,
  Embedded_GUI_Find_Comports,
  Embedded_GUI_Common_FileComboBox,
  Embedded_GUI_IDE_Options_Frame;

type

  { TFrame_AVRDude }

  TFrame_AVRDude = class(TFrame)
    BitBtn1_Auto_avrdude_Controller: TBitBtn;
    CheckBox_avrdude_Chip_Erase: TCheckBox;
    CheckBox_avrdude_Disable_Auto_Erase: TCheckBox;
    CheckBox_avrdude_Override_signature_check: TCheckBox;
    ComboBox_avrdude_COMPort: TComboBox;
    ComboBox_avrdude_COMPortBaud: TComboBox;
    ComboBox_avrdude_Programmer: TComboBox;
    ComboBox_avrdude_Verbose: TComboBox;
    ComboBox_avrrdude_BitClock: TComboBox;
    Edit_avrdude_Controller: TEdit;
    GroupBox_AVRDude: TGroupBox;
    Label10: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label9: TLabel;
    ScrollBox1: TScrollBox;
    procedure BitBtn_Auto_avrdude_ControllerClick(Sender: TObject);
    procedure FrameEnter(Sender: TObject);
  private
    FController: String;
  public
    ComboBox_AvrdudePath, ComboBox_AvrdudeConfigPath: TFileNameComboBox;
    property Controller: String write FController;
    constructor Create(TheOwner: TComponent); override;
    procedure DefaultMask;
  end;

implementation

{$R *.lfm}


{ TFrame_AVRDude }

procedure TFrame_AVRDude.FrameEnter(Sender: TObject);
begin
  ComboBox_avrdude_COMPort.Items.CommaText := GetSerialPortNames;
end;

procedure TFrame_AVRDude.BitBtn_Auto_avrdude_ControllerClick(Sender: TObject);
begin
//  Edit_avrdude_Controller.Text := ComboBox_Controller.Text;
  Edit_avrdude_Controller.Text := FController;
end;

constructor TFrame_AVRDude.Create(TheOwner: TComponent);
begin
  inherited Create(TheOwner);


  ComboBox_AvrdudePath := TFileNameComboBox.Create(ScrollBox1, 'AVRDudePath');
  with ComboBox_AvrdudePath do
  begin
    Caption := 'AVRdude Path';
    Anchors := [akTop, akLeft, akRight];
    Left := 5;
    Width := GroupBox_AVRDude.Width - 10;
    Top := 10;
  end;

  ComboBox_AvrdudeConfigPath := TFileNameComboBox.Create(ScrollBox1, 'AVRDudeConfig');
  with ComboBox_AvrdudeConfigPath do
  begin
    Caption := 'AVRdude Config-Path ( empty = default Config. )';
    Anchors := [akTop, akLeft, akRight];
    Left := 5;
    Width := GroupBox_AVRDude.Width - 10;
    Top := 80;
  end;

  Edit_avrdude_Controller.Text := 'ATMEGA328P';

  with ComboBox_avrdude_Programmer do
  begin
    Items.AddStrings(['arduino', 'usbasp', 'stk500v1', 'wiring',
      'avr109', 'usbtiny', 'jtag2updi', 'jtag1'], True);
  end;

  with ComboBox_avrrdude_BitClock do
  begin
    Style := csOwnerDrawFixed;
    Items.AddStrings(['1', '2', '4', '8', '16', '32', '64', '128',
      '256', '512', '1024'], True);
  end;

  with ComboBox_avrdude_COMPortBaud do
  begin
    Items.AddStrings(['19200', '57600', '115200'], True);
  end;

  with ComboBox_avrdude_Verbose do
  begin
    Style := csOwnerDrawFixed;
    Items.AddStrings(['0 kein', '1 einfach', '2 mittel', '3 genau',
      '4 sehr genau', '5 Ultra genau'], True);
  end;
end;

procedure TFrame_AVRDude.DefaultMask;
begin
  if Embedded_IDE_Options.AVR.avrdudePath.Count > 0 then begin
    ComboBox_AvrdudePath.Text := Embedded_IDE_Options.AVR.avrdudePath[0];
  end else begin
    ComboBox_AvrdudePath.Text := '';
  end;

  if Embedded_IDE_Options.AVR.avrdudeConfigPath.Count > 0 then begin
    ComboBox_AvrdudeConfigPath.Text := Embedded_IDE_Options.AVR.avrdudeConfigPath[0];
  end else begin
    ComboBox_AvrdudeConfigPath.Text := '';
  end;

  Edit_avrdude_Controller.Text := 'ATMEGA328P';

  with ComboBox_avrdude_Programmer do begin
    Text := 'arduino';
  end;

  with ComboBox_avrdude_COMPort do begin
    Items.CommaText := GetSerialPortNames;
    if Items.Count > 0 then begin
      Text := Items[0];
    end;
  end;

  with ComboBox_avrdude_COMPortBaud do begin
    Text := '57600';
  end;

  with ComboBox_avrrdude_BitClock do begin
    Text := Items[0];  // Default = 1
  end;

  with ComboBox_avrdude_Verbose do begin
    Text := Items[1];  // Default = einfache Genauigkeit
  end;

  CheckBox_avrdude_Disable_Auto_Erase.Checked := False;
  CheckBox_avrdude_Chip_Erase.Checked := False;
  CheckBox_avrdude_Override_signature_check.Checked := False;
end;

initialization

end.
