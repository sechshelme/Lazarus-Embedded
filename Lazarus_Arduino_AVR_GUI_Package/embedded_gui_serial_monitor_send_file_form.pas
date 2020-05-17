unit Embedded_GUI_Serial_Monitor_Send_File_Form;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, FileUtil,
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


procedure TSerialMonitor_SendFile_Form.Button_SendClick(Sender: TObject);
var
  path, s: string;
  SrcHandle: THandle;
begin
  path := ComboBox_Send_File.Text;
  if FileExists(path) then begin
    ComboBox_Insert_Text(ComboBox_Send_File);
    SaveComboBox_to_XML(ComboBox_Send_File);

    SetLength(s, FileSize(path));
    SrcHandle := FileOpen(path, fmOpenRead or fmShareDenyWrite);
    FileRead(SrcHandle, s[1], Length(s));
    FileClose(SrcHandle);

    if Length(s) > 0 then begin
      SerWrite(Serial_Monitor_Form.SerialHandle, s[1], Length(s));
    end;

  end else begin
    ShowMessage('Datei nicht gefunden !');
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
