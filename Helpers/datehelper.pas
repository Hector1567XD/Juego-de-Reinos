unit DateHelper;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

type
  TFecha = record
    day:    byte;
    month:  byte;
    year:   word;
  end;

function vTFecha(Fecha: TFecha): Boolean;
function newFecha(Day: byte; Month: byte; Year: word): TFecha;

implementation

function vTFecha(Fecha: TFecha): Boolean;
begin
  if ((Fecha.day <= 0)     or (Fecha.day > 31))     then Exit(false);
  if ((Fecha.month <= 0)   or (Fecha.month > 12))   then Exit(false);
  if ((Fecha.year < 1870)  or (Fecha.year > 3000))  then Exit(false);
  Exit(true);
end;

function newFecha(Day: byte; Month: byte; Year: word): TFecha;
var Fecha: TFecha;
begin
  Fecha.day := Day;
  Fecha.month := Month;
  Fecha.year := Year;
  Exit(Fecha);
end;

end.
