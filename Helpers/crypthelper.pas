unit CryptHelper;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

Function Encrypt(Cadena: string; Up: Byte): String;

implementation

Function Encrypt(Cadena: string; Up: Byte): String;
var I: Word;
begin

 If (Up = 0) then
  For I:= 1 to (length(Cadena)) do
   Exit(chr(ord(Cadena[I]) - 3))
 Else
  For I:= 1 to (length(Cadena)) do
   Exit(chr(ord(Upcase(Cadena[I])) - 3));

end;

end.

