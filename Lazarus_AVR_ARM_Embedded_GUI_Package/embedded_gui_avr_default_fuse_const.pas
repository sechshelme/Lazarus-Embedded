unit Embedded_GUI_AVR_Default_Fuse_Const;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

type
  TDefault_Fuse = array of record
    Name: string;
    Data: array of byte;
  end;

const
  Default_Fuse: TDefault_Fuse = (
    (Name: 'Test0'; Data: ($00, $00, $00, $00)),
    (Name: 'Test1'; Data: ($00)));

implementation

end.
blabla2
