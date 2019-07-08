unit Unit2;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  Buttons, Unit4, Unit5, Globales;

type

  { TMenuJuego }

  TMenuJuego = class(TForm)
    Estadisticas: TSpeedButton;
    NuevaPartida: TSpeedButton;
    Configurar: TSpeedButton;
    procedure ConfiguracionesClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure LogoCasaClick(Sender: TObject);
    procedure ComboCasasChange(Sender: TObject);
    procedure NuevaPartidaClick(Sender: TObject);
    procedure ConfigurarClick(Sender: TObject);
  private

  public

  end;

var
  MenuJuego: TMenuJuego;
  House: File of houses;
  tCasa: array[1..12] of houses;


implementation

{$R *.lfm}

{ TMenuJuego }

procedure TMenuJuego.FormCreate(Sender: TObject);
begin
end;

procedure TMenuJuego.ConfiguracionesClick(Sender: TObject);
begin

end;

procedure TMenuJuego.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  Halt();
end;

procedure TMenuJuego.LogoCasaClick(Sender: TObject);
begin

end;

procedure TMenuJuego.NuevaPartidaClick(Sender: TObject);
begin
  SecondUser.casa:= '';
  DimensionTablero:= 5;
  MenuJuego.Visible:=False;
  ParametrosPartida.Visible:=True;
end;

procedure TMenuJuego.ConfigurarClick(Sender: TObject);
begin
 Configuraciones.ShowModal;
end;

end.

