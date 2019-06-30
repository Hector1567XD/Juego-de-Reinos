unit FormHelper;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Controls, Graphics, InitFile;

procedure FmAutoSize(Constraints : TSizeConstraints);
procedure FmSetSize(Constraints : TSizeConstraints; Width, Height: Integer);
function FmLoadBackground(): TBitmap;
function FmLoadBackgroundSpecify(routeImage: String): TBitmap;
procedure FormGoto(StAction : String);
procedure FormOpen(StAction : String);

implementation
uses
  FormMovetor;

{* #FmAutoSize
 * Establece el tamaño por defecto para los formularios
 * @param Constraints TSizeConstraints | Constraint REFERIDO de un formulario
 *}
procedure FmAutoSize(Constraints : TSizeConstraints);
begin
  //Estos 'defaults' son establecidos en el archivo "initfile.pas" (InitFile)
  FmSetSize(Constraints, AppForm_Width_Default, AppForm_Height_Default);
end;

procedure FmSetSize(Constraints : TSizeConstraints; Width, Height: Integer);
begin
  //Se bloquen los limites de la ventana de modo que no se pueda modificar
  Constraints.MinHeight:= Height;
  Constraints.MaxHeight:= Height;
  Constraints.MinWidth := Width;
  Constraints.MaxWidth := Width;
end;

function FmLoadBackground(): TBitmap;
begin
  FmLoadBackground := FmLoadBackgroundSpecify('back_form.bmp');
end;

function FmLoadBackgroundSpecify(routeImage: String): TBitmap;
var
  backgroundImage: TBitmap; //Imagen / Mapa de bits
begin
  //Se crea un MapaDeBits y lo asigno a una variable llamada "background image"
  backgroundImage := TBitmap.Create;
  //Se carga el MapaDeBits deseado (en este caso el fondo del campito)
  backgroundImage.LoadFromFile(aPPPath+'\images\'+routeImage);
  Exit(backgroundImage);
end;

procedure FormGoto(StAction : String);
begin
  case StAction of
     'AuthToRegister'         : MAuthToRegister();
     'RegisterToAuth'         : MRegisterToAuth();
     'AuthToMenu'             : MAuthToMenu();
     'MenuToAuth'             : MMenuToAuth();
     'GameModesToNGC1vs1'     : MGameModesToNGC1v1();
  end;
end;

procedure FormOpen(StAction : String);
begin
  case StAction of
     'House'    : MOpenHouse();
     'HouseNew' : MOpenHouseNew();
     'Nation'   : MOpenNation();
     'GameModes': MOpenGameModes();
     'Auth2'    : MOpenAuth2();
  end;
end;

end.
