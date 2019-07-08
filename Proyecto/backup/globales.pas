unit Globales;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Dialogs;
type
  houses = record
  Nombre: string[15];
  LemaOficial: string[25];
  LemaNoOficial: string[25];
 end;
  player = record
  name: string[12];
  surname: string[15];
  username: string[12];
  pass: string[12];
  email: string[25];
  birthdate: string[8];
  country: string[10];
 end;
  playingplayer = record
  Username: string[12];
  Casa: string[15];
  end;
  var
   House: file of houses;
   VectorCasa: array[1..12] of houses;
   TotalCasas, MaxVentajas, MaxDesVentajas, PorcentajeBuenas, OffsetResolLeft, OffsetResolTop: integer;
   MainUser, SecondUser: playingplayer;
   Guy: player;
   MensajeChance: string[255];
   Data: File of player;
   Ventajas, Desventajas: array[1..8] of integer;
   DimensionTablero, TamanoTableroa, TamanoTablerob: 5..10;
   VidaPrincipal, VidaRetador: 1..7;
   PorcentajeChance: real;
   Sentido: boolean;
procedure LeerCasas();
Function login(logger: player): boolean;
Function Asegurar(datos: string; up: integer): string;
implementation

Function Asegurar(datos: string; up: integer): string;
var
 i: integer;
begin

Asegurar:= '';

if up = 0 then
 for i:= 1 to (length(datos)) do
  Asegurar:= Asegurar + (chr(ord(datos[i]) - 3))
else
 for i:= 1 to (length(datos)) do
  Asegurar:= Asegurar + (chr(ord(Upcase(datos[i])) - 3));

end;
Function login(logger: player): boolean;
 var
 i,k: integer;
 guy: player;
 Casa: houses;
 tplayer: array[1..100] of player;
 ruta,rutadata: string;
begin
 getdir(0, ruta);
 ruta:= ruta + '/Files';
 rutaData:= ruta + '/Users.dat';

 Assign(data,rutadata);
 Reset(data);
 i:= 1;
 k:= 0;
 while not EOF(data) do
  begin

   with guy do
    begin
     name:= '';
     surname:= '';
     username:= '';
     pass:= '';
     email:= '';
     birthdate:= '';
     country:= '';
    end;

   Read(data, guy);
   tplayer[i]:= guy;
   Inc(i);
   Inc(k);
  end;
 Close(data);

 with logger do
  begin
   username:= Asegurar(username,1);
   pass:= Asegurar(pass,0);
  end;

 login:= false;

 For i:= 1 to k do
  If (tplayer[i].username = logger.username) and (tplayer[i].pass = logger.pass) then
   login:= true;

end;
procedure LeerCasas();

  var
   i: integer;
   Casa: houses;
   ruta, rutaHouse, rutaImageneCasa: string;
  begin

  getdir(0, ruta);
  rutaHouse:= ruta + '/Files/Houses.dat';

  Assignfile(House, rutaHouse);

  Reset(House);
   i:= 1;
   TotalCasas:= 0;
   while not EOF(House) do
    begin

     with Casa do
      begin
       Nombre:= '';
       LemaOficial:= '';
       LemaNoOficial:= '';
      end;

     Read(House, Casa);
     VectorCasa[i]:= Casa;

     Inc(i);
     Inc(TotalCasas);
    end;
   Closefile(House);


end;

end.
