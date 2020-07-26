unit Embedded_GUI_Help_Const;

interface

const
  HelpText =
    '=== AVR ===' + LineEnding +
    'Erstellt ein AVR-Project' + LineEnding +
    '' + LineEnding +
    '=== ARM ===' + LineEnding +
    'Erstellt ein AVR-Project' + LineEnding +
    '' + LineEnding +
    '=== Fuse ===' + LineEnding +
    'Brennt Fuse' + LineEnding +
    '' + LineEnding +
    '' + LineEnding +
    '  unit Unit1;' + LineEnding +
    '' + LineEnding +
    '{$mode objfpc}{$H+}' + LineEnding +
    '' + LineEnding +
    'interface' + LineEnding +
    '' + LineEnding +
    'uses' + LineEnding +
    '  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, SynEdit,' + LineEnding +
    '  Embedded_GUI_Common,' + LineEnding +
    '  Embedded_GUI_Help_Form;' + LineEnding +
    '' + LineEnding +
    'type' + LineEnding +
    '' + LineEnding +
    '  { TForm1 }' + LineEnding +
    '' + LineEnding +
    '  TForm1 = class(TForm)' + LineEnding +
    '    Button_AVR_Project: TButton;' + LineEnding +
    '    Button_ARM_Project1: TButton;' + LineEnding +
    '    Button_AVR_Project1: TButton;' + LineEnding +
    '    Button_Create: TButton;' + LineEnding +
    '    SynEdit1: TSynEdit;' + LineEnding +
    '    procedure Button_ARM_Project1Click(Sender: TObject);' + LineEnding +
    '    procedure Button_AVR_ProjectClick(Sender: TObject);' + LineEnding +
    '    procedure Button_CreateClick(Sender: TObject);' + LineEnding +
    '    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);' + LineEnding +
    '    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);' + LineEnding +
    '    procedure FormCreate(Sender: TObject);' + LineEnding +
    '  private' + LineEnding +
    '' + LineEnding +
    '  public' + LineEnding +
    '' + LineEnding +
    '  end;' + LineEnding +
    '' + LineEnding +
    'var' + LineEnding +
    '  Form1: TForm1;' + LineEnding +
    '' + LineEnding +
    'implementation' + LineEnding +
    '' + LineEnding +
    '{$R *.lfm}' + LineEnding +
    '' + LineEnding +
    '{ TForm1 }' + LineEnding +
    '' + LineEnding +
    'const' + LineEnding +
    '' + LineEnding +
    'procedure TForm1.Button_CreateClick(Sender: TObject);' + LineEnding +
    'var' + LineEnding +
    '  sl: TStringList;' + LineEnding +
    '  s: string;' + LineEnding +
    '  i: integer;' + LineEnding +
    'begin' + LineEnding +
    '  sl := TStringList.Create;' + LineEnding +
    '  sl.Add('');' + LineEnding +
    '  sl.Add('');' + LineEnding +
    '  for i := 0 to SynEdit1.Lines.Count - 1 do begin' + LineEnding +
    '  end;' + LineEnding +
    '  s := sl[sl.Count - 1];' + LineEnding +
    '  Delete(s, Length(s) - 14, 15);' + LineEnding +
    '  sl.Add('');' + LineEnding +
    '  sl.Add('');' + LineEnding +
    '  sl.SaveToFile(path);' + LineEnding +
    '' + LineEnding +
    '  sl.Free;' + LineEnding +
    '//  HelpForm.Show;' + LineEnding +
    'end;' + LineEnding +
    '' + LineEnding +
    'procedure TForm1.FormClose(Sender: TObject; var CloseAction: TCloseAction);' + LineEnding +
    'begin' + LineEnding +
    '  SaveFormPos_to_XML(Self);' + LineEnding +
    'end;' + LineEnding +
    '' + LineEnding +
    'procedure TForm1.Button_AVR_ProjectClick(Sender: TObject);' + LineEnding +
    'begin' + LineEnding +
    '  HelpForm.Show;' + LineEnding +
    'end;' + LineEnding +
    '' + LineEnding +
    'procedure TForm1.Button_ARM_Project1Click(Sender: TObject);' + LineEnding +
    'begin' + LineEnding +
    '  HelpForm.Show;' + LineEnding +
    'end;' + LineEnding +
    '' + LineEnding +
    'procedure TForm1.FormCloseQuery(Sender: TObject; var CanClose: boolean);' + LineEnding +
    'begin' + LineEnding +
    'end;' + LineEnding +
    '' + LineEnding +
    'procedure TForm1.FormCreate(Sender: TObject);' + LineEnding +
    'begin' + LineEnding +
    '  LoadFormPos_from_XML(Self);' + LineEnding +
    'end;' + LineEnding +
    '' + LineEnding +
    'end.';

implementation

begin
end.
