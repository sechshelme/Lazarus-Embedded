unit Test_Frame;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils,
  Forms, Controls, StdCtrls, Dialogs, ExtCtrls,
  ProjectIntf, CompOptsIntf, LazIDEIntf, IDEOptionsIntf, IDEOptEditorIntf, MenuIntf;

type
  TFrame1 = class(TAbstractIDEOptionsEditor)
  private
  public
    function GetTitle: string; override;
    procedure Setup({%H-}ADialog: TAbstractOptionsEditorDialog); override;
    procedure ReadSettings({%H-}AOptions: TAbstractIDEOptions); override;
    procedure WriteSettings({%H-}AOptions: TAbstractIDEOptions); override;
    class function SupportedOptionsClass: TAbstractIDEOptionsClass; override;
  end;

implementation

{$R *.lfm}

{ TTest_Frame }

function TFrame1.GetTitle: string;
begin
  Result := 'Mein Setup';
end;

procedure TFrame1.Setup(ADialog: TAbstractOptionsEditorDialog);
begin
  ShowMessage('Setup');
end;

procedure TFrame1.ReadSettings(AOptions: TAbstractIDEOptions);
begin
  ShowMessage('Read');
end;

procedure TFrame1.WriteSettings(AOptions: TAbstractIDEOptions);
begin
  ShowMessage('Write');
end;

class function TFrame1.SupportedOptionsClass: TAbstractIDEOptionsClass;
begin
  Result := IDEEditorGroups.GetByIndex(GroupEnvironment)^.GroupClass;
end;

end.

