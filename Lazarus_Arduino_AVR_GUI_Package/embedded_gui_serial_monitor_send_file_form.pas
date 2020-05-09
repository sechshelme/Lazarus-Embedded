unit Embedded_GUI_Serial_Monitor_Send_File_Form;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls,
  Serial,
  Embedded_GUI_Common;

type

  { TSerialMonitor_SendFile_Form }

  TSerialMonitor_SendFile_Form = class(TForm)
    Button_File_Open: TButton;
    Button_Close: TButton;
    Button_Send: TButton;
    ComboBox_Send_File: TComboBox;
    OpenDialog: TOpenDialog;
    procedure Button_File_OpenClick(Sender: TObject);
    procedure Button_CloseClick(Sender: TObject);
    procedure Button_SendClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormHide(Sender: TObject);
  private
  public

  end;

var
  SerialMonitor_SendFile_Form: TSerialMonitor_SendFile_Form;

implementation

uses
  Embedded_GUI_Serial_Monitor_Form;

{$R *.lfm}

{ TSerialMonitor_SendFile_Form }

procedure TSerialMonitor_SendFile_Form.FormCreate(Sender: TObject);
begin
  Caption := Title + 'Serial-Monitor send File';
  LoadFormPos_from_XML(Self);
  LoadComboBox_from_XML(ComboBox_Send_File);
end;

procedure TSerialMonitor_SendFile_Form.Button_CloseClick(Sender: TObject);
begin
  Close;
end;

procedure TSerialMonitor_SendFile_Form.Button_SendClick(Sender: TObject);
var
  sl: TStringList;
  s: string;
begin
  sl := TStringList.Create;
  try
    if FileExists(ComboBox_Send_File.Text) then begin
      sl.LoadFromFile(ComboBox_Send_File.Text);
      s := sl.Text;

      if Length(s) > 0 then begin
        SerWrite(Serial_Monitor_Form.SerialHandle, s[1], Length(s));
      end;
      ComboBox_Insert_Text(ComboBox_Send_File);
      SaveComboBox_to_XML(ComboBox_Send_File);
    end else ShowMessage('Datei nicht gefunden !');
  finally
    sl.Free;
  end;
end;

procedure TSerialMonitor_SendFile_Form.Button_File_OpenClick(Sender: TObject);
begin
  OpenDialog.FileName := ComboBox_Send_File.Text;
  if OpenDialog.Execute then begin
    ComboBox_Send_File.Text := OpenDialog.FileName;
    ComboBox_Insert_Text(ComboBox_Send_File);
    SaveComboBox_to_XML(ComboBox_Send_File);
  end;
end;

procedure TSerialMonitor_SendFile_Form.FormHide(Sender: TObject);
begin
  SaveFormPos_to_XML(Self);
end;

end.
