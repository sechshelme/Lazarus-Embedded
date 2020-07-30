unit Embedded_GUI_AVR_Fuse_Form;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ComCtrls,
  ExtCtrls, FileUtil, LazFileUtils, laz2_XMLRead, laz2_DOM,
  Embedded_GUI_Common,
  Embedded_GUI_Run_Command,
  //  Embedded_GUI_AVR_Fuse_Common,
  Embedded_GUI_AVR_Fuse_Const,
  Embedded_GUI_AVR_Fuse_TabSheet;

type

  { TForm_AVR_Fuse }

  TForm_AVR_Fuse = class(TForm)
    Button_ReadFuse: TButton;
    Button_Close: TButton;
    ComboBox1: TComboBox;
    Label1: TLabel;
    PageControl1: TPageControl;
    procedure Button_CloseClick(Sender: TObject);
    procedure Button_ReadFuseClick(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure CreateTab(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    procedure ClearTabs;
  private
    FuseTabSheet: array of TFuseTabSheet;
  public
  end;

var
  Form_AVR_Fuse: TForm_AVR_Fuse;

implementation

{$R *.lfm}

{ TForm_AVR_Fuse }

/// --- private

procedure TForm_AVR_Fuse.ClearTabs;
var
  i: integer;
begin
  for i := 0 to Length(FuseTabSheet) - 1 do begin
    FuseTabSheet[i].Free;
  end;
  SetLength(FuseTabSheet, 0);
end;


/// --- public

procedure TForm_AVR_Fuse.FormCreate(Sender: TObject);
var
  i: integer;
begin
  Caption := Title + 'AVR Fuse';
  ComboBox1.Style := csOwnerDrawFixed;

  for i := 0 to Length(AVR_Fuse_Data) - 1 do begin
    ComboBox1.Items.Add(AVR_Fuse_Data[i].Name);
  end;
  ComboBox1.ItemIndex := 0;

  LoadFormPos_from_XML(self);
end;

procedure TForm_AVR_Fuse.ComboBox1Change(Sender: TObject);
begin
  //  AVR_XML_Path := ComboBox1.Items[ComboBox1.ItemIndex];
  AVR_XML_Path := ComboBox1.Text;
  Caption := AVR_XML_Path;
  ClearTabs;
  CreateTab(Sender);
end;

procedure TForm_AVR_Fuse.Button_CloseClick(Sender: TObject);
begin
  Close;
end;

procedure TForm_AVR_Fuse.CreateTab(Sender: TObject);

var
  i, j, k: integer;
  s: string;
begin
  with AVR_Fuse_Data[ComboBox1.ItemIndex] do begin
    SetLength(FuseTabSheet, Length(Fuses));
    for i := 0 to Length(Fuses) - 1 do begin

      FuseTabSheet[i] := TFuseTabSheet.Create(Self);
      FuseTabSheet[i].Tag := i;
      FuseTabSheet[i].PageControl := PageControl1;
      FuseTabSheet[i].FuseName := Fuses[i].Name;
      FuseTabSheet[i].Caption := Fuses[i].Caption;

      for j := 0 to Length(Fuses[i].BitField) - 1 do begin
        if Length(Fuses[i].BitField[j].Values) > 0 then begin
          FuseTabSheet[i].NewComboBox(Fuses[i].BitField[j].Caption + ' (' + Fuses[i].BitField[j].Name + '):',
            Fuses[i].BitField[j].Mask);
          for k := 0 to length(Fuses[i].BitField[j].Values) - 1 do begin
            s := Fuses[i].BitField[j].Values[k].Caption + ' (' + Fuses[i].BitField[j].Values[k].Name + ')';
            FuseTabSheet[i].AddComboxItem(s, Fuses[i].BitField[j].Values[k].Value);
          end;
        end else begin
          FuseTabSheet[i].AddCheckBox(Fuses[i].BitField[j].Caption + ' (' + Fuses[i].BitField[j].Name + '):',
            Fuses[i].BitField[j].Mask);
        end;
      end;
    end;
  end;
  if PageControl1.PageCount > 0 then begin
    PageControl1.TabIndex := 0;
  end;
end;

procedure TForm_AVR_Fuse.Button_ReadFuseClick(Sender: TObject);
var
  avr, fuse: string;
  i, l, j: integer;
begin
  if not Assigned(Run_Command_Form) then begin
    Run_Command_Form := TRun_Command_Form.Create(nil);
  end;
  Run_Command_Form.Memo1.Clear;

  avr := ExtractFileName(AVR_XML_Path);
  avr := ExtractFileNameWithoutExt(avr);

  l := Length(FuseTabSheet);
  for i := 0 to l - 1 do begin
    fuse := ' -U' + FuseTabSheet[i].FuseName + ':r:-:h';
    Run_Command_Form.RunCommand('avrdude -cusbasp -p' + avr + fuse);
    if Run_Command_Form.ExitCode = 0 then begin
      j := Run_Command_Form.Memo1.Lines.Count - 1;
      while j >= 0 do begin
        if Pos('0x', Run_Command_Form.Memo1.Lines[j]) = 1 then begin
          FuseTabSheet[i].FuseByte := not StrToInt(Run_Command_Form.Memo1.Lines[j]);
          j := 0;
        end;
        Dec(j);
      end;
    end;
  end;

  //RunCommandForm.RunCommand('avrdude -cusbasp -pattiny2313');
  //  Run_Command_Form.RunCommand('avrdude -cusbasp -p' + avr + ' -Uhfuse:r:-:h -Ulfuse:r:-:h -Uefuse:r:-:h -Ulock:r:-:h');
  //  Caption := Run_Command_Form.ExitCode.ToString;
end;

procedure TForm_AVR_Fuse.FormDestroy(Sender: TObject);
var
  i: integer;
begin
  SaveFormPos_to_XML(self);
  for i := 0 to Length(FuseTabSheet) - 1 do begin
    FuseTabSheet[i].Free;
  end;
  SetLength(FuseTabSheet, 0);
end;

end.
