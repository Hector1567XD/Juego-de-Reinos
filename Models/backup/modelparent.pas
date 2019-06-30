unit ModelParent;

{$mode objfpc}{$H+}
interface

{*
  Realmente con esto queria lograr MUCHO mas pero mi limitado conocimiento
  acerca de la POO en Pascal no me permitio hacer "tipos de datos dinamicos"
*}

uses
  Classes, SysUtils, InitFile;

const MAXITEMS_MODEL = 255;

type

  Objects = Array[1..MAXITEMS_MODEL] of TObject;

  TModelParent = class
  protected
    fileName:   String;
    fullRoute:  String;
    itemsCount: Word;
    procedure   Init(var fileModel: file;fileNameParam: String);
    function    GetItems(): Objects;
  end;

implementation

procedure TModelParent.Init(var fileModel: file;fileNameParam: String);
begin

  Self.itemsCount := 0;
  Self.fileName := fileNameParam;
  Self.fullRoute := aPPPath + Self.fileName;

  Assign(fileModel, Self.fullRoute);

  if not(FileExists(Self.fullRoute)) then
  begin
    Rewrite(fileModel);
    Close(fileModel);
  end;

end;

end.
