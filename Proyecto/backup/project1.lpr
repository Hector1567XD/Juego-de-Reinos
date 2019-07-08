program project1;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, Unit1, datetimectrls, Unit2, Unit3, Unit4, unit5, unit6, Unit7, Unit8;

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Scaled:=True;
  Application.Initialize;
  Application.CreateForm(TInicio, Inicio);
  Application.CreateForm(TMenu, Menu);
  Application.CreateForm(TRegistro, Registro);
  Application.CreateForm(TConfiguraciones, Configuraciones);
  Application.CreateForm(TParametrosPartida, ParametrosPartida);
  Application.CreateForm(TInicioRetador, InicioRetador);
  Application.CreateForm(TForm7, Form7);
  Application.CreateForm(TJuego, Juego);
  Application.Run;
end.

