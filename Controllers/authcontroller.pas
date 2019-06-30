unit AuthController;
{* AuthController (CONTROLADOR):
 * Unidad dedicada al control del logueo y registro del usuario.
 *}

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, InitFile, DateHelper, CryptHelper, UserModel, NationModel;

function getUserbyUsername(userName : string): TUser;
function checkLogin(userName, password: String): UserLogg;
function loginUser(userName : string; password : string): UserLogg;
function loginUser2(userName : string; password : string): UserLogg;
function registerUser(
  var resText: String;
  name, lastname, username, password, email,
  day, month, year, country: string
): Boolean;
procedure logOutUser();

implementation
uses dialogs;

{* procedimiento para obtener un usuario por su username *}
function getUserbyUsername(userName : string): TUser;
var
   I: Word;
   Users: TUsers;
   User:  TUser;
Begin
   Users := CUser.Get();
   {* Recorro el arreglo de usuarios *}
   for I := 1 to CUser.Count() do
   begin
        User := Users[i];
        if (User.username = userName) then
          Exit(User); //Retorno el usuario
   end;
   //Si no encuentra un usuario, retorno un usuario nuevo (ID:0)
   User := CUser.New();
   Exit(User);
end;

function checkLogin(userName, password: String): UserLogg;
var
   UserRecord: UserLogg; //Logueo del usuario puede ser tanto fallido como exitoso
   User:       TUser;
Begin

  //Inicializo la respuesta como que fue fallido
  UserRecord.username := '';
  UserRecord.fullname := '';
  UserRecord.id := 0; //<---- 0 papa, nada de -1
  UserRecord.loginIn := false;
  UserRecord.resText := 'Error indefinido';

  //Verifico que los campos no esten vacios
  if ((userName = '') or (password = '')) then begin
    UserRecord.resText := 'Rellene los campos para continuar';
    Exit(UserRecord);
  end;

  //Encuentra el usuario en cuestion segun el username que se indique
  User := getUserbyUsername(userName);
  if (User.Id = 0) then begin
    UserRecord.resText := 'Usuario no encontrado';
    Exit(UserRecord);
  end;

  //La contraseña del archivo es igual a la contraseña introducida encrypdata?
  If (User.password <> Encrypt(password, 0)) then begin
    UserRecord.resText := 'Contraseña invalida';
    Exit(UserRecord);
  end;


  //Ahora establezco que el logueo de usuario fue exitoso pues no salio con ninguna de las validaciones anteriores
  UserRecord.loginIn   := true;
  UserRecord.username  := User.username;
  UserRecord.fullname  := User.name + ' ' + User.lastname;
  UserRecord.id        := User.Id;

  Inc(User.logueos);
  CUser.Put(User, User.Id);

  Exit(UserRecord);

End;

{* procedimiento para la autenticacion del usuario 2 *}
function loginUser2(userName : string; password : string): UserLogg;
var
   UserRecord: UserLogg; //Logueo del usuario puede ser tanto fallido como exitoso
Begin

  //Verificamos si el nombre de usuario introducido es igual al del usuario ya logueado (Jugador1)
  If (AppUser.username = userName) then begin
    //Forzamos una respuesta rapida
    UserRecord.resText := 'Ya este usuario se encuentra logueado.';
    UserRecord.loginIn := false;
    Exit(UserRecord);
  end;

  //"Creamos" un logueo de usuario
  UserRecord := checkLogin(userName, password);

  //Verificamos si el logueo de usuario fue exitoso
  if (UserRecord.loginIn = true) then begin
    UserRecord.resText   := 'Bienvenido ' + UserRecord.fullname;
  end;

  Exit(UserRecord);

end;

{* procedimiento para la autenticacion del usuario *}
function loginUser(userName : string; password : string): UserLogg;
var
   UserRecord: UserLogg; //Logueo del usuario puede ser tanto fallido como exitoso
Begin

  //"Creamos" un logueo de usuario
  UserRecord := checkLogin(userName, password);

  //Verificamos si el logueo de usuario fue exitoso
  if (UserRecord.loginIn = true) then begin
    //Introducimos el logueo de usuario exitoso en la variable global que almacena al usuario de esta sesion
    AppUser := UserRecord;
    UserRecord.resText   := 'Bienvenido ' + UserRecord.fullname;
  end;

  Exit(UserRecord);

end;

{* procedimiento para el registro del usuario *}
function registerUser(
  var resText: String;
  name, lastname, username, password, email,
  day, month, year, country: string
): Boolean;
var
   User, UserAux:       TUser;
   Nation:              TNation;
   dayN,monthN,yearN:   Longint;
Begin

  resText := 'Error indefinido.';

  User   := CUser.New();
  //TryStrToInt
  //Verifico que los campos no esten vacios
  if (
    (name = '') or
    (lastname = '') or
    (username = '') or
    (password = '') or
    (email = '') or
    (day = '') or
    (month = '') or
    (year = '') or
    (country = '')
  ) then begin
    resText := 'Rellene los campos para continuar';Exit(False);
  end;

  if (
    (TryStrToInt(day,dayN)   = false) or
    (TryStrToInt(month,monthN) = false) or
    (TryStrToInt(year,yearN)  = false)
  )
  Then Begin
    resText := 'Fecha invalida.';
    Exit(False);
  End;

  if (vTFecha(newFecha(dayN, monthN, yearN)) = False)
  Then Begin
    resText := 'Fecha invalida.';
    Exit(False);
  End;

  password := Encrypt(password, 0);

  If (Length(name) > 20) then Begin
    resText := 'El Nombre debe tener menos de 20 caracteres';Exit(False);
  End;

  If (Length(lastname) > 20) then Begin
    resText := 'El Apellido debe tener menos de 20 caracteres';Exit(False);
  End;

  If (Length(username) > 12) then Begin
    resText := 'El Nombre de usuario debe tener menos de 12 caracteres';Exit(False);
  End;

  If (Length(password) > 24) then Begin
    resText := 'La contraseña debe tener menos de 24 caracteres';Exit(False);
  End;

  If (Length(email) > 180) then Begin
    resText := 'El email debe tener menos de 180 caracteres';Exit(False);
  End;

  Nation := CNation.FindName(country);

  If (Nation.Id <= 0) Then Begin
      resText := 'Pais no encontrado.';Exit(False);
  End;

  UserAux := getUserbyUsername(username);
  if (UserAux.Id <> 0) then begin
    resText := 'El nombre de usuario ya existe';Exit(False);
  end;

  User.name := name;
  User.lastname := lastname;
  User.username := username;
  User.password := password;
  User.email := email;
  User.birthdate := newFecha(dayN, monthN, yearN);
  User.countryID := Nation.Id;

  CUser.Store(User);

  Exit(True);
end;

{* Procedimiento que limpia (o inicializa) la sesion de un usuario de 'AppUser' *}
procedure logOutUser();
begin
  AppUser.username  := '';
  AppUser.fullname  := '';
  AppUser.id        := 0;
  AppUser.loginIn   := false;
  AppUser.resText   := '';
end;

end.
