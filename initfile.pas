unit InitFile;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms;

type
     {* #UserLogg
      * 'Registro', que estructura los datos de un usuario en runtime.
      *}
  	UserLogg = record
  	        username: string[12];
            fullname: string[41]; //name + lastname
            resText:  string[255];
            id:       word;       //no, no habra ID = -1 >-<
            loginIn:  boolean;
            {*
              No hace falta tener en runtime datos como:
              -password
              -email
              -birthdate
              -countryID
            *}
  	end;

procedure IniciarAplicacion();

var
  {* #aPPPath
   * Variable de tipo string, almacena la ruta relativa o fija donde se encuentra
   * la aplicacion o sus recursos
   *}
  aPPPath: string;
  {* #AppUser
   * Variable de global que almacena los datos del usuario actual
   *}
  AppUser: UserLogg;
const
  {* #AppInProduction
   * Constante booleana, diferencia cuando la app este en
   * modalidad de desarrollo o modalidad de produccion, es importante dejarla
   * en 'true' a la hora de compilar
   *}
  AppInProduction = true;
  {* #AppShowMessage
   * Constante booleana, habilita/deshabilita los "ShowMessage" dentro de la APP
   *}
  AppShowMessage = true;
  {* #AppShowMessage_S
   * Constante booleana, habilita/deshabilita los "ShowMessage" de tipo
   * 'Felicitaciones' en la App.
   *}
  AppShowMessage_S = true;
  {* #AppShowMessage_W
   * Constante booleana, habilita/deshabilita los "ShowMessage" de tipo
   * 'Warning' en la App.
   *}
  AppShowMessage_W = true;
  {* #AppShowMessage_E
   * Constante booleana, habilita/deshabilita los "ShowMessage" de tipo
   * 'Error' en la App.
   *}
  AppShowMessage_E = false;
  {* #AppForm_Height_Default
   * Constante entera, pixeles de la altura por defecto de los formularios
   *}
  AppForm_Height_Default = 591;
  {* #AppForm_Hfault
   * Constante entera, pixeles del ancho por defecto de los formularios
   *}
  AppForm_Width_Default = 1063;

implementation
  uses
    AuthController, NationModel, HousesModel;

{* #IniciarAplicacion
 * Procedimiento que inicializa la aplicacion
 * @dependencias: AppInProduction, aPPPath
 *}

procedure IniciarAplicacion();
Begin
  aPPPath := ExtractFilePath(Application.ExeName);
  //Inicializamos que el usuario no se encuentra logueado
  CNation.SeedNation();
  CHouse.SeedHouse();
  logOutUser();
end;


end.
