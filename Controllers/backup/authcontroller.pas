unit AuthController;
{* AuthController (CONTROLADOR):
 * Unidad dedicada al control del logueo y registro del usuario.
 *}

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, InitFile, DateHelper, CryptHelper, UserModel, NationModel;

function getUserbyUsername(userName : string): TUser;
function loginUser(userName : string; password : string): UserLogg;
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

{* procedimiento para la autenticacion del usuario *}
function loginUser(userName : string; password : string): UserLogg;
var
   UserRecord: UserLogg; //Record del usuario
   User:       TUser;
Begin

  //Inicializo la respuesta
  UserRecord.username := '';
  UserRecord.fullname := '';
  UserRecord.id := -1;
  UserRecord.loginIn := false;
  UserRecord.resText := 'Error indefinido';

  //Verifico que los campos no esten vacios
  if ((userName = '') or (password = '')) then begin
    UserRecord.resText := 'Rellene los campos para continuar';Exit(UserRecord);
  end;

  //Encuentra el usuario en cuestion segun el username que se indique
  User := getUserbyUsername(userName);
  if (User.Id = 0) then begin
    UserRecord.resText := 'Usuario no encontrado';Exit(UserRecord);
  end;

  //La contraseña del archivo es igual a la contraseña introducida encrypdata?
  If (User.password <> Encrypt(password, 0)) then begin
    UserRecord.resText := 'Contraseña invalida';Exit(UserRecord);
  end;

  UserRecord.loginIn   := true;
  UserRecord.username  := User.username;
  UserRecord.fullname  := User.name + ' ' + User.lastname;
  UserRecord.id        := User.Id;

  AppUser := UserRecord;

  UserRecord.resText   := 'Bienvenido ' + UserRecord.fullname;

  Inc(User.logueos);
  CUser.Put(User, User.Id);

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
   Fecha:               TFecha;
Begin

  resText := 'Error indefinido.';

  User   := CUser.New();
  if (
    (TryStrToInt(day,dayN)   = false) or
    (TryStrToInt(month,monthN) = false) or
    (TryStrToInt(year,yearN)  = false)
  )
  Then Begin
    resText := 'Fecha invalida.';
    Exit(False);
  End;
  TFecha := newFecha(dayN, monthN, yearN);
  if (vTFecha(Fecha) = False)
  Then Begin
    ShowMessage(IntToStr(dayN));
    ShowMessage(IntToStr(monthN));
    ShowMessage(IntToStr(yearN));
    resText := 'Fecha invalida.';
    Exit(False);
  End;
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

  If (Length(name) <= 20) then Begin
    resText := 'El Nombre debe tener menos de 20 caracteres';Exit(False);
  End;

  If (Length(lastname) <= 20) then Begin
    resText := 'El Apellido debe tener menos de 20 caracteres';Exit(False);
  End;

  If (Length(username) <= 12) then Begin
    resText := 'El Nombre de usuario debe tener menos de 12 caracteres';Exit(False);
  End;

  If (Length(password) <= 24) then Begin
    resText := 'La contraseña debe tener menos de 24 caracteres';Exit(False);
  End;

  If (Length(email) <= 180) then Begin
    resText := 'El email debe tener menos de 180 caracteres';Exit(False);
  End;

  Nation := CNation.FindName(country);

  If (Nation.Id <= 0) Then Begin
      resText := 'Pais no encontrado.';Exit(False);
  End;

  UserAux := getUserbyUsername(username);
  if (User.Id <> 0) then begin
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
