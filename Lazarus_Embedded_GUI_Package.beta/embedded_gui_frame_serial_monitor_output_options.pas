unit Embedded_GUI_Frame_Serial_Monitor_Output_Options;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, ExtCtrls, StdCtrls, Dialogs,
  Embedded_GUI_Common;

type

  { TFrame_SerialMonitor_Output }

  TFrame_SerialMonitor_Output = class(TFrame)
    Button_Color: TButton;
    Button_BKColor: TButton;
    Button_Font: TButton;
    CheckBox_AutoScroll: TCheckBox;
    CheckBox_WordWarp: TCheckBox;
    ColorDialog1: TColorDialog;
    ComboBox_maxRows: TComboBox;
    FontDialog1: TFontDialog;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label_Color: TLabel;
    RadioGroup_LineBreak: TRadioGroup;
    procedure Button_BKColorClick(Sender: TObject);
    procedure Button_ColorClick(Sender: TObject);
    procedure Button_FontClick(Sender: TObject);
  private

  public
    constructor Create(TheOwner: TComponent); override;
  end;

implementation

{$R *.lfm}

{ TFrame_SerialMonitor_Output }

constructor TFrame_SerialMonitor_Output.Create(TheOwner: TComponent);
begin
  inherited Create(TheOwner);

  with RadioGroup_LineBreak do begin
    Items.AddStrings(OutputLineBreaks, True);
  end;

  with ComboBox_maxRows do begin
    Items.CommaText := OutputDefaultmaxRows;
    Style := csOwnerDrawFixed;
  end;

end;

procedure TFrame_SerialMonitor_Output.Button_FontClick(Sender: TObject);
begin
  FontDialog1.Font := Label_Color.Font;
  if FontDialog1.Execute then begin
    Label_Color.Font := FontDialog1.Font;
  end;
end;

procedure TFrame_SerialMonitor_Output.Button_BKColorClick(Sender: TObject);
begin
  ColorDialog1.Color := Label_Color.Color;
  if ColorDialog1.Execute then begin
    Label_Color.Color := ColorDialog1.Color;
  end;
end;

procedure TFrame_SerialMonitor_Output.Button_ColorClick(Sender: TObject);
begin
  ColorDialog1.Color := Label_Color.Font.Color;
  if ColorDialog1.Execute then begin
    Label_Color.Font.Color := ColorDialog1.Color;
  end;
end;

end.
