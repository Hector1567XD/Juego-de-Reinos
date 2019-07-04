unit ModelParent;

{$mode objfpc}{$H+}
{$static on}

interface

uses
  Classes, SysUtils, InitFile;

const MAXITEMS_MODEL = 255;

type

  GenObjects = Array[1..MAXITEMS_MODEL] of TObject;

  TModelParent = class
  protected
    fileName:   String;
    fullRoute:  String;
    itemsCount: QWord;
    procedure   Init(var fileModel: file;fileNameParam: String);
    //function    GetItems(): GenObjects; virtual; abstract;//
  end;

implementation

procedure TModelParent.Init(var fileModel: file;fileNameParam: String);
begin

  //IDEA: Esto podria hacerse solo al principio del archivo pero... noc aqui queda mejor ubicado
  If (Not DirectoryExists('data')) then CreateDir('data');

  Self.itemsCount := 0;
  Self.fileName := fileNameParam;
  Self.fullRoute := aPPPath + '/data/' + Self.fileName;

  Assign(fileModel, Self.fullRoute);

  if not(FileExists(Self.fullRoute)) then
  begin
    Rewrite(fileModel);
    Close(fileModel);
  end;

end;

end.
