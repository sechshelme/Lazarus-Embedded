unit Embedded_GUI_Serial_Monitor_Send_File_Form;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, FileUtil,
  Serial,
  Embedded_GUI_Common,
  Embedded_GUI_Common_FileComboBox;

type

  { TSerialMonitor_SendFile_Form }

  TSerialMonitor_SendFile_Form = class(TForm)
    Button_Close: TButton;
    Button_Send: TButton;
    procedure Button_CloseClick(Sender: TObject);
    procedure Button_SendClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormHide(Sender: TObject);
  private
    ComboBox_Send_File: TFileNameComboBox;
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
  ComboBox_Send_File:=TFileNameComboBox.Create(Self,'SendFile');
  with ComboBox_Send_File do begin
      Caption:='Send File';
    Anchors := [akTop, akLeft, akRight];
    Left := 5;
    Width := Self.Width - 10;
    Top := 5;
  end;
end;

procedure TSerialMonitor_SendFile_Form.FormDestroy(Sender: TObject);
begin
  ComboBox_Send_File.Free;
end;


procedure TSerialMonitor_SendFile_Form.Button_SendClick(Sender: TObject);
var
  path, s: string;
  SrcHandle: THandle;
begin
  path := ComboBox_Send_File.Text;
  if FileExists(path) then begin
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

procedure TSerialMonitor_SendFile_Form.Button_CloseClick(Sender: TObject);
begin
  Close;
end;

procedure TSerialMonitor_SendFile_Form.FormHide(Sender: TObject);
begin
  SaveFormPos_to_XML(Self);
end;

end.
