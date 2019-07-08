unit Unit8;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  ActnList, Grids, ComCtrls, PopupNotifier, LazHelpHTML, crt, Types, globales, Unit7;

type

  { TJuego }

  TJuego = class(TForm)
    DadoPrincipal: TButton;
    DadoRetador: TButton;
    Button3: TButton;
    FichaJugadorRetador: TImage;
    Image1: TImage;
    Image10: TImage;
    Image100: TImage;
    FichaJugadorPrincipal: TImage;
    FondoPantalla: TImage;
    J1V1: TImage;
    J1: TLabel;
    J2V3: TImage;
    J2V4: TImage;
    J2V5: TImage;
    J2V6: TImage;
    J2V7: TImage;
    J1V2: TImage;
    J1V3: TImage;
    J1V4: TImage;
    J1V5: TImage;
    J1V6: TImage;
    J1V7: TImage;
    J2V1: TImage;
    J2V2: TImage;
    J2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    LCasaPrincipal: TLabel;
    LCasaRetador: TLabel;
    Log: TMemo;
    LogoCasaPrincipal: TImage;
    LogoCasaRetador: TImage;
    LS1: TLabel;
    LS2: TLabel;
    MensajeDialogo: TPopupNotifier;
    BS1: TProgressBar;
    BS2: TProgressBar;
    TiempoMensaje: TTimer;
    Trampa1: TImage;
    Image11: TImage;
    Image12: TImage;
    Image13: TImage;
    Image14: TImage;
    Image15: TImage;
    Image16: TImage;
    Image17: TImage;
    Image18: TImage;
    Image19: TImage;
    Image2: TImage;
    Image20: TImage;
    Image21: TImage;
    Image22: TImage;
    Image23: TImage;
    Image24: TImage;
    Image25: TImage;
    Image26: TImage;
    Image27: TImage;
    Image28: TImage;
    Image29: TImage;
    Image3: TImage;
    Image30: TImage;
    Image31: TImage;
    Image32: TImage;
    Image33: TImage;
    Image34: TImage;
    Image35: TImage;
    Image36: TImage;
    Image37: TImage;
    Image38: TImage;
    Image39: TImage;
    Image4: TImage;
    Image40: TImage;
    Image41: TImage;
    Image42: TImage;
    Image43: TImage;
    Image44: TImage;
    Image45: TImage;
    Image46: TImage;
    Image47: TImage;
    Image48: TImage;
    Image49: TImage;
    Image5: TImage;
    Image50: TImage;
    Image51: TImage;
    Image52: TImage;
    Image53: TImage;
    Image54: TImage;
    Image55: TImage;
    Image56: TImage;
    Image57: TImage;
    Image58: TImage;
    Image59: TImage;
    Image6: TImage;
    Image60: TImage;
    Image61: TImage;
    Image62: TImage;
    Image63: TImage;
    Image64: TImage;
    Image65: TImage;
    Image66: TImage;
    Image67: TImage;
    Image68: TImage;
    Image69: TImage;
    Image7: TImage;
    Image70: TImage;
    Image71: TImage;
    Image72: TImage;
    Image73: TImage;
    Image74: TImage;
    Image75: TImage;
    Image76: TImage;
    Image77: TImage;
    Image78: TImage;
    Image79: TImage;
    Image8: TImage;
    Image80: TImage;
    Image81: TImage;
    Image82: TImage;
    Image83: TImage;
    Image84: TImage;
    Image85: TImage;
    Image86: TImage;
    Image87: TImage;
    Image88: TImage;
    Image89: TImage;
    Image9: TImage;
    Image90: TImage;
    Image91: TImage;
    Image92: TImage;
    Image93: TImage;
    Image94: TImage;
    Image95: TImage;
    Image96: TImage;
    Image97: TImage;
    Image98: TImage;
    Image99: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Ruta1: TLabel;
    Ruta10: TLabel;
    Ruta100: TLabel;
    Ruta11: TLabel;
    Ruta12: TLabel;
    Ruta13: TLabel;
    Ruta14: TLabel;
    Ruta15: TLabel;
    Ruta16: TLabel;
    Ruta17: TLabel;
    Ruta18: TLabel;
    Ruta19: TLabel;
    Ruta2: TLabel;
    Ruta20: TLabel;
    Ruta21: TLabel;
    Ruta22: TLabel;
    Ruta23: TLabel;
    Ruta24: TLabel;
    Ruta25: TLabel;
    Ruta26: TLabel;
    Ruta27: TLabel;
    Ruta28: TLabel;
    Ruta29: TLabel;
    Ruta3: TLabel;
    Ruta30: TLabel;
    Ruta31: TLabel;
    Ruta32: TLabel;
    Ruta33: TLabel;
    Ruta34: TLabel;
    Ruta35: TLabel;
    Ruta36: TLabel;
    Ruta37: TLabel;
    Ruta38: TLabel;
    Ruta39: TLabel;
    Ruta4: TLabel;
    Ruta40: TLabel;
    Ruta41: TLabel;
    Ruta42: TLabel;
    Ruta43: TLabel;
    Ruta44: TLabel;
    Ruta45: TLabel;
    Ruta46: TLabel;
    Ruta47: TLabel;
    Ruta48: TLabel;
    Ruta49: TLabel;
    Ruta5: TLabel;
    Ruta50: TLabel;
    Ruta51: TLabel;
    Ruta52: TLabel;
    Ruta53: TLabel;
    Ruta54: TLabel;
    Ruta55: TLabel;
    Ruta56: TLabel;
    Ruta57: TLabel;
    Ruta58: TLabel;
    Ruta59: TLabel;
    Ruta6: TLabel;
    Ruta60: TLabel;
    Ruta61: TLabel;
    Ruta62: TLabel;
    Ruta63: TLabel;
    Ruta64: TLabel;
    Ruta65: TLabel;
    Ruta66: TLabel;
    Ruta67: TLabel;
    Ruta68: TLabel;
    Ruta69: TLabel;
    Ruta7: TLabel;
    Ruta70: TLabel;
    Ruta71: TLabel;
    Ruta72: TLabel;
    Ruta73: TLabel;
    Ruta74: TLabel;
    Ruta75: TLabel;
    Ruta76: TLabel;
    Ruta77: TLabel;
    Ruta78: TLabel;
    Ruta79: TLabel;
    Ruta8: TLabel;
    Ruta80: TLabel;
    Ruta81: TLabel;
    Ruta82: TLabel;
    Ruta83: TLabel;
    Ruta84: TLabel;
    Ruta85: TLabel;
    Ruta86: TLabel;
    Ruta87: TLabel;
    Ruta88: TLabel;
    Ruta89: TLabel;
    Ruta9: TLabel;
    Ruta90: TLabel;
    Ruta91: TLabel;
    Ruta92: TLabel;
    Ruta93: TLabel;
    Ruta94: TLabel;
    Ruta95: TLabel;
    Ruta96: TLabel;
    Ruta97: TLabel;
    Ruta98: TLabel;
    Ruta99: TLabel;
    Timer1: TTimer;
    Timer2: TTimer;
    Trampa10: TImage;
    Trampa11: TImage;
    Trampa12: TImage;
    Trampa13: TImage;
    Trampa14: TImage;
    Trampa15: TImage;
    Trampa16: TImage;
    Trampa17: TImage;
    Trampa18: TImage;
    Trampa19: TImage;
    Trampa2: TImage;
    Trampa20: TImage;
    Trampa21: TImage;
    Trampa22: TImage;
    Trampa23: TImage;
    Trampa24: TImage;
    Trampa25: TImage;
    Trampa26: TImage;
    Trampa27: TImage;
    Trampa28: TImage;
    Trampa29: TImage;
    Trampa3: TImage;
    Trampa30: TImage;
    Trampa4: TImage;
    Trampa5: TImage;
    Trampa6: TImage;
    Trampa7: TImage;
    Trampa8: TImage;
    Trampa9: TImage;
    procedure HorarioChange(Sender: TObject);
    procedure DadoPrincipalClick(Sender: TObject);
    procedure DadoRetadorClick(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure FichaJugadorPrincipalClick(Sender: TObject);
    procedure FichaJugadorRetadorClick(Sender: TObject);
    procedure FondoPantallaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure J1V1Click(Sender: TObject);
    procedure Label1Click(Sender: TObject);
    procedure LogChange(Sender: TObject);
    procedure LogClick(Sender: TObject);
    procedure LogDblClick(Sender: TObject);
    procedure MensajeDialogoClose(Sender: TObject; var CloseAction: TCloseAction
      );
    procedure ProgressBar1ContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
    procedure RadioGroup1Click(Sender: TObject);
    procedure Ruta1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure TiempoMensajeTimer(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
    procedure Trampa7Click(Sender: TObject);

  private

  public
     var
        VistaNumero: integer;
  end;

type
       TipoVectorTablero= record
                 Fila: Integer;
                 Columna: Integer;
                 Trampa: boolean;
       end;
var
  Juego: TJuego;
  CasillaTablero: array [1..10,1..10] of TImage;
  VectorTrampa: array [1..30] of TImage;
  RutaTablero: array [1..10,1..10] of TLabel;
  TurnoHabilitadoPrincipal, TurnoHabilitadoRetador: boolean;
  PosicionPrincipal, PosicionRetador, TurnoPrincipal, TurnoRetador: integer;
  SoldadosPrincipal, SoldadosRetador: 1..10000;
  VectorTablero: array[1..100] of TipoVectorTablero;
  VVidaPrincipal, VVidaRetador: array[1..7] of TImage;
  Ruta: string[255];
procedure DibujarTableroCorrespondiente(DimensionTablero: integer; SentidoHorario: boolean; TopCasilla: integer; LeftCasilla: integer);
implementation

{$R *.lfm}

{ TJuego }

procedure MostrarDialogo(Texto: string; Imagen: boolean; Sonido: boolean; x,y,tiempo: integer);
begin
        MensajeChance:= Texto;
	if Sonido then
                beep;

        Form7.ShowModal();
end;
function SelectorDePos(PosActual: integer; Maximo, Principal: boolean; uno, dos, tres, cuatro: integer):integer;
begin
SelectorDePos:= PosActual;
if Maximo then
   begin
     if Principal then
        begin
         if uno > SelectorDePos then
            SelectorDePos:= uno;
         if cuatro > SelectorDePos then
            SelectorDePos:= cuatro
        end
     else
         begin
          if dos > SelectorDePos then
             SelectorDePos:= dos;
          if tres > SelectorDePos then
            SelectorDePos:= tres;
         end
   end
else
    begin
     if Principal then
        begin
         if uno < SelectorDePos then
            SelectorDePos:= uno;
         if cuatro< SelectorDePos then
            SelectorDePos:= cuatro
        end
     else
         begin
          if dos < SelectorDePos then
             SelectorDePos:= dos;
          if tres < SelectorDePos then
            SelectorDePos:= tres;
         end
    end;

end;
function MoverEnDiagonal(N: integer; P:integer; TrampaBuena: boolean; Principal: boolean): integer;
type
     Txy = Record
               fila: integer;
               columna: integer;
               posicion: integer;
           end;
var
      ArrIzq, ArrDer, AbjIzq, AbjDer: Txy;
      NuevaPos: Integer;
begin
    ArrIzq.fila:= VectorTablero[P].fila - 1;
    ArrIzq.columna:= VectorTablero[P].columna - 1;
    if  TrampaBuena then
        ArrIzq.posicion:= 0
    else
        ArrIzq.posicion:=  101;
    If (not ((ArrIzq.fila < 1) or (ArrIzq.fila > N))) and (not ((ArrIzq.columna < 1) or (ArrIzq.columna > N))) then
       ArrIzq.posicion:=StrToInt(RutaTablero[ArrIzq.fila,ArrIzq.columna].caption);

    ArrDer.fila:= VectorTablero[P].fila - 1;
    ArrDer.columna:= VectorTablero[P].columna + 1;
    if  TrampaBuena then
        ArrDer.posicion:= 0
    else
        ArrDer.posicion:=  101;
    If (not ((ArrDer.fila < 1) or (ArrDer.fila > N))) and (not ((ArrDer.columna < 1) or (ArrDer.columna > N))) then
       ArrDer.posicion:=StrToInt(RutaTablero[ArrDer.fila,ArrDer.columna].caption);

    AbjIzq.fila:= VectorTablero[P].fila + 1;
    AbjIzq.columna:= VectorTablero[P].columna - 1;
    if  TrampaBuena then
        AbjIzq.posicion:= 0
    else
        AbjIzq.posicion:=  101;
    If (not ((AbjIzq.fila < 1) or (AbjIzq.fila > N))) and (not ((AbjIzq.columna < 1) or (AbjIzq.columna > N))) then
       AbjIzq.posicion:=StrToInt(RutaTablero[AbjIzq.fila,AbjIzq.columna].caption);

    AbjDer.fila:= VectorTablero[P].fila + 1;
    AbjDer.columna:= VectorTablero[P].columna + 1;
    if  TrampaBuena then
        AbjDer.posicion:= 0
    else
        AbjDer.posicion:=  101;
    If (not ((AbjDer.fila < 1) or (AbjDer.fila > N))) and (not ((AbjDer.columna < 1) or (AbjDer.columna > N))) then
       AbjDer.posicion:=StrToInt(RutaTablero[AbjDer.fila,AbjDer.columna].caption);


    NuevaPos:= SelectorDePos(P, TrampaBuena, Principal, ArrIzq.posicion, ArrDer.posicion,AbjIzq.posicion, AbjDer.posicion);

    MoverEnDiagonal:=  NuevaPos;
end;

function NumeroAleatorio(min: integer; max: integer): integer;
begin
     if min > max then
       NumeroAleatorio:= -1
     else
       NumeroAleatorio:= Random(max-min+1) + min;
end;

procedure GenerarTrampas(TamTablero:integer);
var
  i, TotalTrampas: integer;
begin

   TotalTrampas:= 0;
   While  TotalTrampas < (trunc(TamTablero * TamTablero * PorcentajeChance)) do
   begin
          i:= NumeroAleatorio(2,TamTablero * TamTablero -1);
          if  not(VectorTablero[i].Trampa) then
            begin
               VectorTablero[i].Trampa:= true;
               inc(TotalTrampas);
            end;

   end;

end;

procedure Derecha(var f, c, lugar, mov: integer);
var
 i: Integer;
begin
 for i:= 1 to mov do
  begin
  VectorTablero[lugar].fila:= f;
  c:= c + 1;
  VectorTablero[lugar].columna:= c;
  inc(lugar);
  end;
end;

procedure Abajo(var f, c, lugar, mov: integer);
var
 i: Integer;
begin
 for i:= 1 to mov do
  begin
  f:= f + 1;
  VectorTablero[lugar].fila:= f;
  VectorTablero[lugar].columna:= c;
  inc(lugar);
  end;
end;

procedure Izquierda(var f, c, lugar, mov: integer);
var
 i: Integer;
begin
 for i:= 1 to mov do
  begin
  VectorTablero[lugar].fila:= F;
  c:= c - 1;
  VectorTablero[lugar].columna:= c;
  inc(lugar);
  end;
end;

procedure Arriba(var f, c, lugar, mov: integer);
var
 i: Integer;
begin
 for i:= 1 to mov do
  begin
  f:= f - 1;
  VectorTablero[lugar].fila:= f;
  VectorTablero[lugar].columna:= c;
  inc(lugar);
  end;
end;

procedure CargaVectorTablero(DimensionTablero: integer; SentidoHorario: boolean);
var
i, f, c, lugar, mov, repeticion: integer;
begin
 if (DimensionTablero mod 2) = 0 then
  repeticion:= DimensionTablero div 2
 else
  repeticion:= (DimensionTablero + 1) div 2;

 mov:= DimensionTablero - 1;

 lugar:= 1;

 if SentidoHorario then
 For i:= 1 to repeticion do
 begin
 f:= i;
 c:= i;

 VectorTablero[lugar].fila:= f;
 VectorTablero[lugar].columna:= c;
 inc(lugar);

 if (i <> repeticion) or not((mov mod 2) = 0) then
 begin
 Derecha(f, c, lugar, mov);
 Abajo(f, c, lugar, mov);
 Izquierda(f, c, lugar, mov);
 mov:= mov - 1;
 Arriba(f, c, lugar, mov);
 end;

 mov:= mov -1
 end

 else

 For i:= 1 to repeticion do
 begin
 f:= i;
 c:= i;
 VectorTablero[lugar].fila:= f;
 VectorTablero[lugar].columna:= c;
 inc(lugar);

 if (i <> repeticion) or not((mov mod 2) = 0) then
 begin
 Abajo(f, c, lugar, mov);
 Derecha(f, c, lugar, mov);
 Arriba(f, c, lugar, mov);
 mov:= mov - 1;
 Izquierda(f, c, lugar, mov);
 end;

 mov:= mov -1;
 end;
end;

procedure DibujarVida();
var
  i: integer;
begin
  for i:= 1 to 7 do
   begin
    VVidaPrincipal[i].visible:= False;
    VVidaRetador[i].visible:= False;
   end;

  for i:= 1 to VidaPrincipal do
    VVidaPrincipal[i].visible:= True;
  for i:= 1 to VidaRetador do
   VVidaRetador[i].visible:= True;
end;

procedure DibujarSoldados();
var
  i: integer;
begin
 with Juego do
  begin
   LS1.caption:= (inttostr(SoldadosPrincipal));
   LS2.caption:= (inttostr(SoldadosRetador));
   BS1.Position:= SoldadosPrincipal;
   BS2.Position:= SoldadosRetador;
  end;
end;

Procedure EscribirLog(Turno: integer; Jugador: boolean; Mensaje: string);
begin
 with Juego do
  if Jugador then
   Log.Lines.Add('Turno ' + inttostr(Turno) + ' de ' + MainUser.username + ': ' + Mensaje)
  else
   Log.Lines.Add('Turno ' + inttostr(Turno) + ' de ' + SecondUser.username + ': ' + Mensaje);

end;

Procedure LogFin();
var
 LogFinJuego: TextFile;
 i: integer;
 RutaLog: string;
begin
 i:= 0;
 getdir(0, RutaLog);

 while FileExists(rutaLog + '\Files\Data\' + Mainuser.UserName + SecondUser.username + inttostr(i) + '.txt') do
  inc(i);

 RutaLog:= RutaLog + '\Files\Data\' + Mainuser.UserName + SecondUser.username + inttostr(i) + '.txt';

 i:=0;

 Assignfile(LogFinJuego, RutaLog);
 Rewrite(LogFinJuego);

 Writeln(LogFinJuego, 'Log de Juego numero ' + inttostr(i) + ' de ' + Mainuser.UserName + ' ' + SecondUser.username);

 while Juego.Log.Lines[i] <> '' do
  begin
   Writeln(LogFinJuego, Juego.Log.Lines[i]);
   inc(i);
  end;

 closefile(LogFinJuego);
end;

procedure DibujarTableroCorrespondiente(DimensionTablero: integer; SentidoHorario: boolean; TopCasilla: integer; LeftCasilla: integer);
var
  i,j, TrampaActual: integer;
  offSetTop, offSetLeft: integer;
  rutaImageneCasa: string;
begin
  OffsetResolLeft:= 75;
  OffsetResolTop:= 75;
  if Screen.Height < 850  then
        begin
             OffsetResolLeft:= 60;
             OffsetResolTop:= 60;
        end;
  if Screen.Height < 750 then
        begin
             OffsetResolLeft:= 40;
             OffsetResolTop:= 40;
        end;

  offSetLeft:= trunc((10 - DimensionTablero) * OffsetResolLeft / 2);
  offSetTop:= trunc((10 - DimensionTablero) * OffsetResolTop / 2);


  PosicionPrincipal:= 1;
  PosicionRetador:= 1;

  for i:=1 to 10 do
      for j:=1 to 10 do
          begin
            CasillaTablero[i,j].visible:= false;
            RutaTablero[i,j].visible:= false;
          end;

  for i:=1 to 30 do
    VectorTrampa[i].Visible:=false;

     TopCasilla:= TopCasilla + offSetTop;
     LeftCasilla:= LeftCasilla + offSetLeft;

     for i:=1 to DimensionTablero do
      for j:=1 to DimensionTablero do
          begin
            CasillaTablero[i,j].visible:= true;
            CasillaTablero[i,j].Top:= TopCasilla + OffsetResolTop * (i-1);
            CasillaTablero[i,j].Left:= LeftCasilla+ OffsetResolLeft * (j-1);
            CasillaTablero[i,j].Picture.LoadFromFile(Ruta + '/Files/Assets/Casillas/CasillaGenerica.jpg');
          end;

CargaVectorTablero(DimensionTablero, SentidoHorario);


// Pinta Ruta

for i:=1 to DimensionTablero * DimensionTablero do
     begin
       VectorTablero[i].Trampa:= false;
       RutaTablero[VectorTablero[i].Fila,VectorTablero[i].Columna].visible:= true;
       RutaTablero[VectorTablero[i].Fila,VectorTablero[i].Columna].caption:= inttostr(i);
       RutaTablero[VectorTablero[i].Fila,VectorTablero[i].Columna].top:= CasillaTablero[VectorTablero[i].Fila,VectorTablero[i].Columna].top + trunc(OffsetResolTop / 75 * 5);
       RutaTablero[VectorTablero[i].Fila,VectorTablero[i].Columna].left:= CasillaTablero[VectorTablero[i].Fila,VectorTablero[i].Columna].left + trunc(OffsetResolLeft / 75 * 11);
     end;

CasillaTablero[VectorTablero[DimensionTablero * DimensionTablero].Fila,VectorTablero[DimensionTablero * DimensionTablero].Columna].Picture.LoadFromFile(RUTA + '\Files\Assets\Casillas/CasillaFinal.jpg');
RutaTablero[VectorTablero[DimensionTablero * DimensionTablero].Fila,VectorTablero[DimensionTablero * DimensionTablero].Columna].visible:= false;
if SentidoHorario then
   CasillaTablero[VectorTablero[1].Fila,VectorTablero[1].Columna].Picture.LoadFromFile(RUTA + '/Files/Assets/Casillas/CasillaInicioHorario.jpg')
else
    CasillaTablero[VectorTablero[1].Fila,VectorTablero[1].Columna].Picture.LoadFromFile(RUTA + '/Files/Assets/Casillas/CasillaInicioAntiHorario.jpg');
RutaTablero[VectorTablero[1].Fila,VectorTablero[1].Columna].visible:= false;

// Fin pinta Ruta

// Pinta trampas

for i:=1 to trunc(DimensionTablero * DimensionTablero * porcentajechance) do
 begin
  VectorTrampa[i].Picture.LoadFromFile(Ruta + '/Files/Assets/Casillas/Trampa.png');
  VectorTrampa[i].width:= 55;
  VectorTrampa[i].Height:= 45;
  VectorTrampa[i].Proportional:= true;
 end;

GenerarTrampas(DimensionTablero);
TrampaActual:= 1;

for i:=1 to DimensionTablero * DimensionTablero do
    begin
      if VectorTablero[i].Trampa then
        begin
           VectorTrampa[TrampaActual].Visible:= true;
           VectorTrampa[TrampaActual].Top:= CasillaTablero[VectorTablero[i].Fila,VectorTablero[i].Columna].top + trunc(OffsetResolTop / 75 * 4);
           VectorTrampa[TrampaActual].left:= CasillaTablero[VectorTablero[i].Fila,VectorTablero[i].Columna].left + trunc(OffsetResolTop / 75 * 47);
           inc(TrampaActual);
        end;
    end;

// Fin pinta trampas

// ---------------------

with Juego do
begin
FichaJugadorPrincipal.visible:= true;
FichaJugadorRetador.visible:= true;
FichaJugadorPrincipal.top:= CasillaTablero[1,1].top + Trunc(OffsetResolTop - OffsetResolTop / 3);
FichaJugadorPrincipal.left:= CasillaTablero[1,1].left + Trunc(OffsetResolLeft - OffsetResolLeft / 3);
FichaJugadorRetador.top:= CasillaTablero[1,1].top + Trunc(OffsetResolTop - OffsetResolTop / 3);
FichaJugadorRetador.left:= CasillaTablero[1,1].left + 5;
// Depende de quien le toca jugar colocar Dado en true
DadoPrincipal.Enabled:= true;
DadoRetador.Enabled:= false;
end;

//----------------------

with juego do
 if ((TamanoTableroa + TamanoTablerob) mod 2) = 0 then
  if MainUser.username > SecondUser.username then
   begin
    DadoPrincipal.Enabled:= true;
    DadoRetador.Enabled:= false;
   end
  else
   begin
    DadoPrincipal.Enabled:= false;
    DadoRetador.Enabled:= true;
   end
 else
  if MainUser.username < SecondUser.username then
   begin
    DadoPrincipal.Enabled:= true;
    DadoRetador.Enabled:= false;
    DadoPrincipal.SetFocus;
   end
  else
   begin
    DadoPrincipal.Enabled:= false;
    DadoRetador.Enabled:= true;
    DadoRetador.SetFocus;
   end;

SoldadosPrincipal:= 10000;
SoldadosRetador:= 10000;

TurnoPrincipal:= 1;
TurnoRetador:= 1;

with Juego do
 begin
  Log.Lines.Clear;
 end;

TurnoHabilitadoPrincipal:= true;
TurnoHabilitadoRetador:= true;

DibujarSoldados();
DibujarVida();

//Importa casas
  with Juego do
   begin
    i:=1;

    rutaImageneCasa:= ruta + '\Files\Assets\Casas/' + MainUser.casa + '.png';
    LogoCasaPrincipal.Visible:= true;
    if not(FileExists(rutaImageneCasa)) then
      begin
       inc(i);
       rutaImageneCasa:= ruta + '\Files\Assets\Casas\Extra1.png';
      end;
    LogoCasaPrincipal.Picture.LoadFromFile(rutaImageneCasa);

    rutaImageneCasa:= ruta + '\Files\Assets\Casas\' + SecondUser.casa + '.png';
    LogoCasaRetador.Visible:= true;
    if not(FileExists(rutaImageneCasa)) then
      begin
       rutaImageneCasa:= ruta + '\Files\Assets\Casas\Extra' + inttostr(i) + '.png';
      end;
    LogoCasaRetador.Picture.LoadFromFile(rutaImageneCasa);

    LCasaPrincipal.Caption:= MainUser.casa;
    LCasaRetador.Caption:= SecondUser.casa;

    end;
//Fin carga casa
end;

procedure TJuego.DadoPrincipalClick(Sender: TObject);
begin
     DadoPrincipal.Enabled:=False;
     Timer1.Enabled:=True;
end;

procedure TJuego.DadoRetadorClick(Sender: TObject);
begin
  Timer2.Enabled:=True;
  DadoRetador.Enabled:=False;
end;

procedure TJuego.Button3Click(Sender: TObject);
begin
  Halt();
end;

procedure TJuego.Edit1Change(Sender: TObject);
begin

end;

procedure TJuego.FichaJugadorPrincipalClick(Sender: TObject);
begin

end;

procedure TJuego.FichaJugadorRetadorClick(Sender: TObject);
begin

end;

procedure TJuego.FondoPantallaClick(Sender: TObject);
begin

end;

procedure TJuego.FormCreate(Sender: TObject);
var
  i,j: integer;
begin
     getdir(0, RUTA);

     VistaNumero:=1;

     PosicionPrincipal:= 1;
     PosicionRetador:= 1;

     DadoPrincipal.Enabled:= false;
     DadoRetador.Enabled:= false;

  // Carga vector de imagenes de vida

    VVidaPrincipal[1]:= J1V1;
    VVidaPrincipal[2]:= J1V2;
    VVidaPrincipal[3]:= J1V3;
    VVidaPrincipal[4]:= J1V4;
    VVidaPrincipal[5]:= J1V5;
    VVidaPrincipal[6]:= J1V6;
    VVidaPrincipal[7]:= J1V7;

    VVidaRetador[1]:= J2V1;
    VVidaRetador[2]:= J2V2;
    VVidaRetador[3]:= J2V3;
    VVidaRetador[4]:= J2V4;
    VVidaRetador[5]:= J2V5;
    VVidaRetador[6]:= J2V6;
    VVidaRetador[7]:= J2V7;

  // Fin de carga de vector de vida

  // Carga matriz de imagenes de trablero

     CasillaTablero[1,1]:= Image1;
     CasillaTablero[1,2]:= Image2;
     CasillaTablero[1,3]:= Image3;
     CasillaTablero[1,4]:= Image4;
     CasillaTablero[1,5]:= Image5;
     CasillaTablero[1,6]:= Image6;
     CasillaTablero[1,7]:= Image7;
     CasillaTablero[1,8]:= Image8;
     CasillaTablero[1,9]:= Image9;
     CasillaTablero[1,10]:= Image10;
     CasillaTablero[2,1]:= Image11;
     CasillaTablero[2,2]:= Image12;
     CasillaTablero[2,3]:= Image13;
     CasillaTablero[2,4]:= Image14;
     CasillaTablero[2,5]:= Image15;
     CasillaTablero[2,6]:= Image16;
     CasillaTablero[2,7]:= Image17;
     CasillaTablero[2,8]:= Image18;
     CasillaTablero[2,9]:= Image19;
     CasillaTablero[2,10]:= Image20;
     CasillaTablero[3,1]:= Image21;
     CasillaTablero[3,2]:= Image22;
     CasillaTablero[3,3]:= Image23;
     CasillaTablero[3,4]:= Image24;
     CasillaTablero[3,5]:= Image25;
     CasillaTablero[3,6]:= Image26;
     CasillaTablero[3,7]:= Image27;
     CasillaTablero[3,8]:= Image28;
     CasillaTablero[3,9]:= Image29;
     CasillaTablero[3,10]:= Image30;
     CasillaTablero[4,1]:= Image31;
     CasillaTablero[4,2]:= Image32;
     CasillaTablero[4,3]:= Image33;
     CasillaTablero[4,4]:= Image34;
     CasillaTablero[4,5]:= Image35;
     CasillaTablero[4,6]:= Image36;
     CasillaTablero[4,7]:= Image37;
     CasillaTablero[4,8]:= Image38;
     CasillaTablero[4,9]:= Image39;
     CasillaTablero[4,10]:= Image40;
     CasillaTablero[5,1]:= Image41;
     CasillaTablero[5,2]:= Image42;
     CasillaTablero[5,3]:= Image43;
     CasillaTablero[5,4]:= Image44;
     CasillaTablero[5,5]:= Image45;
     CasillaTablero[5,6]:= Image46;
     CasillaTablero[5,7]:= Image47;
     CasillaTablero[5,8]:= Image48;
     CasillaTablero[5,9]:= Image49;
     CasillaTablero[5,10]:= Image50;
     CasillaTablero[6,1]:= Image51;
     CasillaTablero[6,2]:= Image52;
     CasillaTablero[6,3]:= Image53;
     CasillaTablero[6,4]:= Image54;
     CasillaTablero[6,5]:= Image55;
     CasillaTablero[6,6]:= Image56;
     CasillaTablero[6,7]:= Image57;
     CasillaTablero[6,8]:= Image58;
     CasillaTablero[6,9]:= Image59;
     CasillaTablero[6,10]:= Image60;
     CasillaTablero[7,1]:= Image61;
     CasillaTablero[7,2]:= Image62;
     CasillaTablero[7,3]:= Image63;
     CasillaTablero[7,4]:= Image64;
     CasillaTablero[7,5]:= Image65;
     CasillaTablero[7,6]:= Image66;
     CasillaTablero[7,7]:= Image67;
     CasillaTablero[7,8]:= Image68;
     CasillaTablero[7,9]:= Image69;
     CasillaTablero[7,10]:= Image70;
     CasillaTablero[8,1]:= Image71;
     CasillaTablero[8,2]:= Image72;
     CasillaTablero[8,3]:= Image73;
     CasillaTablero[8,4]:= Image74;
     CasillaTablero[8,5]:= Image75;
     CasillaTablero[8,6]:= Image76;
     CasillaTablero[8,7]:= Image77;
     CasillaTablero[8,8]:= Image78;
     CasillaTablero[8,9]:= Image79;
     CasillaTablero[8,10]:= Image80;
     CasillaTablero[9,1]:= Image81;
     CasillaTablero[9,2]:= Image82;
     CasillaTablero[9,3]:= Image83;
     CasillaTablero[9,4]:= Image84;
     CasillaTablero[9,5]:= Image85;
     CasillaTablero[9,6]:= Image86;
     CasillaTablero[9,7]:= Image87;
     CasillaTablero[9,8]:= Image88;
     CasillaTablero[9,9]:= Image89;
     CasillaTablero[9,10]:= Image90;
     CasillaTablero[10,1]:= Image91;
     CasillaTablero[10,2]:= Image92;
     CasillaTablero[10,3]:= Image93;
     CasillaTablero[10,4]:= Image94;
     CasillaTablero[10,5]:= Image95;
     CasillaTablero[10,6]:= Image96;
     CasillaTablero[10,7]:= Image97;
     CasillaTablero[10,8]:= Image98;
     CasillaTablero[10,9]:= Image99;
     CasillaTablero[10,10]:= Image100;

  // Fin de carga de matriz de imagenes

  // Carga matriz de Ruta

      RutaTablero[1,1]:= Ruta1;
      RutaTablero[1,2]:= Ruta2;
      RutaTablero[1,3]:= Ruta3;
      RutaTablero[1,4]:= Ruta4;
      RutaTablero[1,5]:= Ruta5;
      RutaTablero[1,6]:= Ruta6;
      RutaTablero[1,7]:= Ruta7;
      RutaTablero[1,8]:= Ruta8;
      RutaTablero[1,9]:= Ruta9;
      RutaTablero[1,10]:= Ruta10;
      RutaTablero[2,1]:= Ruta11;
      RutaTablero[2,2]:= Ruta12;
      RutaTablero[2,3]:= Ruta13;
      RutaTablero[2,4]:= Ruta14;
      RutaTablero[2,5]:= Ruta15;
      RutaTablero[2,6]:= Ruta16;
      RutaTablero[2,7]:= Ruta17;
      RutaTablero[2,8]:= Ruta18;
      RutaTablero[2,9]:= Ruta19;
      RutaTablero[2,10]:= Ruta20;
      RutaTablero[3,1]:= Ruta21;
      RutaTablero[3,2]:= Ruta22;
      RutaTablero[3,3]:= Ruta23;
      RutaTablero[3,4]:= Ruta24;
      RutaTablero[3,5]:= Ruta25;
      RutaTablero[3,6]:= Ruta26;
      RutaTablero[3,7]:= Ruta27;
      RutaTablero[3,8]:= Ruta28;
      RutaTablero[3,9]:= Ruta29;
      RutaTablero[3,10]:= Ruta30;
      RutaTablero[4,1]:= Ruta31;
      RutaTablero[4,2]:= Ruta32;
      RutaTablero[4,3]:= Ruta33;
      RutaTablero[4,4]:= Ruta34;
      RutaTablero[4,5]:= Ruta35;
      RutaTablero[4,6]:= Ruta36;
      RutaTablero[4,7]:= Ruta37;
      RutaTablero[4,8]:= Ruta38;
      RutaTablero[4,9]:= Ruta39;
      RutaTablero[4,10]:= Ruta40;
      RutaTablero[5,1]:= Ruta41;
      RutaTablero[5,2]:= Ruta42;
      RutaTablero[5,3]:= Ruta43;
      RutaTablero[5,4]:= Ruta44;
      RutaTablero[5,5]:= Ruta45;
      RutaTablero[5,6]:= Ruta46;
      RutaTablero[5,7]:= Ruta47;
      RutaTablero[5,8]:= Ruta48;
      RutaTablero[5,9]:= Ruta49;
      RutaTablero[5,10]:= Ruta50;
      RutaTablero[6,1]:= Ruta51;
      RutaTablero[6,2]:= Ruta52;
      RutaTablero[6,3]:= Ruta53;
      RutaTablero[6,4]:= Ruta54;
      RutaTablero[6,5]:= Ruta55;
      RutaTablero[6,6]:= Ruta56;
      RutaTablero[6,7]:= Ruta57;
      RutaTablero[6,8]:= Ruta58;
      RutaTablero[6,9]:= Ruta59;
      RutaTablero[6,10]:= Ruta60;
      RutaTablero[7,1]:= Ruta61;
      RutaTablero[7,2]:= Ruta62;
      RutaTablero[7,3]:= Ruta63;
      RutaTablero[7,4]:= Ruta64;
      RutaTablero[7,5]:= Ruta65;
      RutaTablero[7,6]:= Ruta66;
      RutaTablero[7,7]:= Ruta67;
      RutaTablero[7,8]:= Ruta68;
      RutaTablero[7,9]:= Ruta69;
      RutaTablero[7,10]:= Ruta70;
      RutaTablero[8,1]:= Ruta71;
      RutaTablero[8,2]:= Ruta72;
      RutaTablero[8,3]:= Ruta73;
      RutaTablero[8,4]:= Ruta74;
      RutaTablero[8,5]:= Ruta75;
      RutaTablero[8,6]:= Ruta76;
      RutaTablero[8,7]:= Ruta77;
      RutaTablero[8,8]:= Ruta78;
      RutaTablero[8,9]:= Ruta79;
      RutaTablero[8,10]:= Ruta80;
      RutaTablero[9,1]:= Ruta81;
      RutaTablero[9,2]:= Ruta82;
      RutaTablero[9,3]:= Ruta83;
      RutaTablero[9,4]:= Ruta84;
      RutaTablero[9,5]:= Ruta85;
      RutaTablero[9,6]:= Ruta86;
      RutaTablero[9,7]:= Ruta87;
      RutaTablero[9,8]:= Ruta88;
      RutaTablero[9,9]:= Ruta89;
      RutaTablero[9,10]:= Ruta90;
      RutaTablero[10,1]:= Ruta91;
      RutaTablero[10,2]:= Ruta92;
      RutaTablero[10,3]:= Ruta93;
      RutaTablero[10,4]:= Ruta94;
      RutaTablero[10,5]:= Ruta95;
      RutaTablero[10,6]:= Ruta96;
      RutaTablero[10,7]:= Ruta97;
      RutaTablero[10,8]:= Ruta98;
      RutaTablero[10,9]:= Ruta99;
      RutaTablero[10,10]:= Ruta100;

   // Fin de carga de matriz de ruta

   // Carga Vector trampa
        VectorTrampa[1]:=  Trampa1;
        VectorTrampa[2]:=  Trampa2;
        VectorTrampa[3]:=  Trampa3;
        VectorTrampa[4]:=  Trampa4;
        VectorTrampa[5]:=  Trampa5;
        VectorTrampa[6]:=  Trampa6;
        VectorTrampa[7]:=  Trampa7;
        VectorTrampa[8]:=  Trampa8;
        VectorTrampa[9]:=  Trampa9;
        VectorTrampa[10]:=  Trampa10;
        VectorTrampa[11]:=  Trampa11;
        VectorTrampa[12]:=  Trampa12;
        VectorTrampa[13]:=  Trampa13;
        VectorTrampa[14]:=  Trampa14;
        VectorTrampa[15]:=  Trampa15;
        VectorTrampa[16]:=  Trampa16;
        VectorTrampa[17]:=  Trampa17;
        VectorTrampa[18]:=  Trampa18;
        VectorTrampa[19]:=  Trampa19;
        VectorTrampa[20]:=  Trampa20;
        VectorTrampa[21]:=  Trampa21;
        VectorTrampa[22]:=  Trampa22;
        VectorTrampa[23]:=  Trampa23;
        VectorTrampa[24]:=  Trampa24;
        VectorTrampa[25]:=  Trampa25;
        VectorTrampa[26]:=  Trampa26;
        VectorTrampa[27]:=  Trampa27;
        VectorTrampa[28]:=  Trampa28;
        VectorTrampa[29]:=  Trampa29;
        VectorTrampa[30]:=  Trampa30;
   // Fin carga vector trampa

 for i:=1 to 10 do
  for j:=1 to 10 do
   begin
    RutaTablero[i,j].visible:= false;
    CasillaTablero[i,j].proportional:= True;
   end;

  FichaJugadorPrincipal.visible:= false;
  FichaJugadorRetador.visible:= false;
  Randomize;

end;

procedure TJuego.J1V1Click(Sender: TObject);
begin

end;

procedure TJuego.HorarioChange(Sender: TObject);
begin

end;

procedure TJuego.Label1Click(Sender: TObject);
begin

end;

procedure TJuego.LogChange(Sender: TObject);
begin

end;

procedure TJuego.LogClick(Sender: TObject);
begin

end;

procedure TJuego.LogDblClick(Sender: TObject);
begin
If Log.Height = 80 then
 begin
  Log.Height:= 500;
  log.Top:= 300;
 end
else
 begin
  Log.Height:= 80;
  log.Top:= 710
 end;
end;

procedure TJuego.MensajeDialogoClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  Juego.enabled:= True;
end;

procedure TJuego.ProgressBar1ContextPopup(Sender: TObject; MousePos: TPoint;
  var Handled: Boolean);
begin

end;

procedure TJuego.RadioGroup1Click(Sender: TObject);
begin

end;

procedure TJuego.Ruta1Click(Sender: TObject);
begin

end;


procedure TJuego.Timer1Timer(Sender: TObject);
var
  chance: boolean;
  casualidad: 1..16;
begin
  if VistaNumero < 10 then
    begin
       Label1.Caption:=IntToStr(NumeroAleatorio(1,6));
       inc(VistaNumero);
    end
  else
    begin
      beep;
      VistaNumero:= 1;
      Timer1.Enabled:=false;

      DadoRetador.Enabled:=true;
      DadoRetador.SetFocus;

      PosicionPrincipal:= PosicionPrincipal + StrToInt(label1.caption);

      EscribirLog(TurnoPrincipal, True, 'Obtuvo ' + Juego.label1.caption + ' en el dado.');

      repeat
      chance:= false;

      if PosicionPrincipal = (DimensionTablero * DimensionTablero) then
           begin
              EscribirLog(TurnoPrincipal, True, 'Gano el juego.');
              showmessage('Principal Ganaste....');
              LogFin();
           end;

      if PosicionPrincipal > (DimensionTablero * DimensionTablero) then
           begin
              EscribirLog(TurnoPrincipal, True, 'Se exedio del maximo y tuvo que regresar ' + inttostr(DimensionTablero * DimensionTablero -  PosicionPrincipal) + ' pasos.');
              showmessage('Principal pa tras....');
              PosicionPrincipal:= 2 * DimensionTablero * DimensionTablero -  PosicionPrincipal;
           end;

      FichaJugadorPrincipal.top:= CasillaTablero[VectorTablero[PosicionPrincipal].fila,VectorTablero[PosicionPrincipal].columna].top + Trunc(OffsetResolTop - OffsetResolTop / 3);
      FichaJugadorPrincipal.left:= CasillaTablero[VectorTablero[PosicionPrincipal].fila,VectorTablero[PosicionPrincipal].columna].left + Trunc(OffsetResolLeft - OffsetResolLeft / 3);

      if (PosicionPrincipal = PosicionRetador) and (PosicionPrincipal <> 1) then
        begin
         if (VidaRetador - 1) = 0 then
          begin
           EscribirLog(TurnoPrincipal, True, 'Ataco al juagador ' + SecondUser.username + ' y redujo su vida a cero. Gano el juego.');
           showmessage('Vidas del jugador Retador agotadas, automaticamente pierde');
           LogFin();
          end
         else
          VidaRetador:= VidaRetador - 1;

         DibujarVida();
         SoldadosRetador:= 10000;

         PosicionRetador :=1;

         FichaJugadorRetador.top:= CasillaTablero[1,1].top + Trunc(OffsetResolTop - OffsetResolTop / 3);
         FichaJugadorRetador.left:= CasillaTablero[1,1].left + 5;
         beep;
         beep;
         beep;
         beep;

        EscribirLog(TurnoPrincipal, True, 'Ataco al juagador ' + SecondUser.username + ' y redujo su vida.');
        showmessage('Te bocharon.... Retador');

        end;

      if VectorTablero[PosicionPrincipal].Trampa then
      begin
        chance:= true;

        if PorcentajeBuenas <= NumeroAleatorio(1,100) then
         casualidad:= Ventajas[NumeroAleatorio(1,MaxVentajas)]
        else
         casualidad:= DesVentajas[NumeroAleatorio(1,MaxDesVentajas)] + 7;

        case casualidad of
          1: begin
               MostrarDialogo('Buena avanza dos espacios',true,true,400,400,5000);
               PosicionPrincipal:= PosicionPrincipal + 2;
               EscribirLog(TurnoPrincipal, True, 'Cayó en una casilla de chance que le permitio avanzar dos espacios mas.');
             end;
          2: begin
               MostrarDialogo('Buena avanza ' + label1.caption + ' espacios',true,true,400,400,5000);
               PosicionPrincipal:= PosicionPrincipal + StrToInt(label1.caption);
               EscribirLog(TurnoPrincipal, True, 'Cayó en una casilla de chance que le permitio doblar sus dados y avanzo ' + label1.caption + ' espacios mas.');
             end;
          3: begin
               MostrarDialogo('Buena colocate una posicion adelante del retador',true,true,400,400,5000);
               PosicionPrincipal:= PosicionRetador + 1;
               EscribirLog(TurnoPrincipal, True, 'Cayó en una casilla de chance que le permitio colocarse al frente del jugador ' + SecondUser.username + '.');
             end;
          4: begin
               MostrarDialogo('Buena diagonal principal',true,true,400,400,5000);

               if PosicionPrincipal = MoverEnDiagonal(DimensionTablero, PosicionPrincipal, True, True) then
                  chance:= False
               else
                  PosicionPrincipal:= MoverEnDiagonal(DimensionTablero, PosicionPrincipal, True, True);

               if chance then
                EscribirLog(TurnoPrincipal, True, 'Cayó en una casilla de chance que le permitio colocarse al frente un paso al frente por la diagonal principal.')
               else
                EscribirLog(TurnoPrincipal, True, 'Cayó en una casilla de chance que le permitio colocarse al frente un paso al frente por la diagonal principal pero como el movimiento en esta direccion seria negativo se quedo en el mismo sitio.');
             end;
          5: begin
               MostrarDialogo('Buena diagonal secundaria',true,true,400,400,5000);
               if PosicionPrincipal = MoverEnDiagonal(DimensionTablero, PosicionPrincipal, True, False) then
                    chance:= False
               else
                    PosicionPrincipal:= MoverEnDiagonal(DimensionTablero, PosicionPrincipal, True, False);

               if chance then
                EscribirLog(TurnoPrincipal, True, 'Cayó en una casilla de chance que le permitio colocarse al frente un paso al frente por la diagonal secundaria.')
               else
                EscribirLog(TurnoPrincipal, True, 'Cayó en una casilla de chance que le permitio colocarse al frente un paso al frente por la diagonal secundaria pero como el movimiento en esta direccion seria negativo se quedo en el mismo sitio.');

             end;
          6: begin
               MostrarDialogo('Buena repite turno',true,true,400,400,5000);
               EscribirLog(TurnoPrincipal, True, 'Cayó en una casilla de chance que le permitio volver a jugar.');
               DadoRetador.Enabled:=False;
               DadoPrincipal.Enabled:=True;
               DadoPrincipal.SetFocus;
               chance:= False;
             end;
          7: begin
             if (SoldadosPrincipal >= 5000) then
              begin
               SoldadosPrincipal:= 10000;
               if (VidaPrincipal < 7) then
                 begin
                  VidaPrincipal:= VidaPrincipal + 1;
                  EscribirLog(TurnoPrincipal, True, 'Cayó en una casilla que restauro al maximo sus soldados y le añadio una vida.')
                 end
                else
                 EscribirLog(TurnoPrincipal, True, 'Cayó en una casilla que restauro al maximo sus soldados.')
               end
             else
              begin
              EscribirLog(TurnoPrincipal, True, 'Cayó en una casilla que añadio 5000 soldados a sus tropas.');
              SoldadosPrincipal:= SoldadosPrincipal + 5000;
              end;

              chance:= False;
             end;
          8: begin
               MostrarDialogo('Mala retrocede un espacio',true,true,400,400,5000);
               if (SoldadosPrincipal - 1000) < 0 then
                if (VidaPrincipal - 1) = 0 then
                 begin
                  EscribirLog(TurnoPrincipal, True, 'Cayó en una casilla que le hizo retroder un espacio y redujo los soldados y vidas a cero por lo que perdio.');
                  showmessage('Vidas del jugador principal agotadas, automaticamente pierde');
                  LogFin();
                 end
                else
                 begin
                  VidaPrincipal:= VidaPrincipal - 1;
                  EscribirLog(TurnoPrincipal, True, 'Cayó en una casilla de chance en donde retrocedio un espacio y los soldados del jugador llegaron a cero por lo que perdio una vida');
                  DibujarVida();
                  SoldadosPrincipal:= 10000;
                  if PosicionPrincipal > 1 then
                  PosicionPrincipal:= PosicionPrincipal - 1;
                 end
              else
               begin
                if PosicionPrincipal > 1 then
                 PosicionPrincipal:= PosicionPrincipal - 1;
                EscribirLog(TurnoPrincipal, True, 'Cayó en una casilla de chance en donde retrocedio un espacio y los soldados del jugador se redujeron de ' + Inttostr(SoldadosPrincipal) + ' a ' + Inttostr(SoldadosPrincipal - 1000));
                SoldadosPrincipal:= SoldadosPrincipal - 1000;
               end;
               DibujarSoldados();
             end;
          9: begin
               MostrarDialogo('Mala volver al punto de partida',true,true,400,400,5000);

               if (SoldadosPrincipal - 3000) < 0 then
                if (VidaPrincipal - 1) = 0 then
                 begin
                  EscribirLog(TurnoPrincipal, True, 'Cayó en una casilla que le hizo retroder al punto de partida y redujo los soldados y vidas a cero por lo que perdio.');
                  showmessage('Vidas del jugador principal agotadas, automaticamente pierde');
                  LogFin();
                 end
                else
                 begin
                  VidaPrincipal:= VidaPrincipal - 1;
                  EscribirLog(TurnoPrincipal, True, 'Cayó en una casilla de chance en donde retrocedio al punto de partida y los soldados del jugador llegaron a cero por lo que perdio una vida');
                  DibujarVida();
                  SoldadosPrincipal:= 10000;
                  PosicionPrincipal:= 1;
                 end
              else
               begin
                PosicionPrincipal:= 1;
                EscribirLog(TurnoPrincipal, True, 'Cayó en una casilla de chance en donde retrocedio al punto de partida y los soldados del jugador se redujeron de ' + Inttostr(SoldadosPrincipal) + ' a ' + Inttostr(SoldadosPrincipal - 3000));
                SoldadosPrincipal:= SoldadosPrincipal - 3000;
               end;

               DibujarSoldados();

             end;
          10: begin
               MostrarDialogo('Mala colocate una posicion atras del retador',true,true,400,400,5000);

              if (SoldadosPrincipal - 2000) < 0 then
                if (VidaPrincipal - 1) = 0 then
                 begin
                  EscribirLog(TurnoPrincipal, True, 'Cayó en una casilla que le hizo colocarse en la posicion detras del otro jugador y redujo los soldados y vidas a cero por lo que perdio.');
                  showmessage('Vidas del jugador principal agotadas, automaticamente pierde');
                  LogFin();
                 end
                else
                 begin
                  EscribirLog(TurnoPrincipal, True, 'Cayó en una casilla de chance en donde se coloco en la posicion detras del otro jugador y los soldados del jugador llegaron a cero por lo que perdio una vida');
                  VidaPrincipal:= VidaPrincipal - 1;
                  DibujarVida();
                  SoldadosPrincipal:= 10000;

                  if PosicionRetador = 1 then
                   PosicionPrincipal:= 1
                  else
                   PosicionPrincipal:= PosicionRetador - 1;
                 end
              else

               begin
                if PosicionRetador = 1 then
                 PosicionPrincipal:= 1
                else
                 PosicionPrincipal:= PosicionRetador - 1;
                 EscribirLog(TurnoPrincipal, True, 'Cayó en una casilla de chance en donde se coloco en la posicion detras del otro jugador y los soldados del jugador se redujeron de ' + Inttostr(SoldadosPrincipal) + ' a ' + Inttostr(SoldadosPrincipal - 2000));
                 SoldadosPrincipal:= SoldadosPrincipal - 2000;
                end;
               DibujarSoldados();
               end;

          11: begin
               MostrarDialogo('Mala diagonal principal',false,true,400,400,5000);

               if (SoldadosPrincipal - 1500) < 0 then
                if (VidaPrincipal - 1) = 0 then
                 begin
                  EscribirLog(TurnoPrincipal, True, 'Cayó en una casilla que le hizo retroceder por la diagonal principal y redujo los soldados y vidas a cero por lo que perdio.');
                  showmessage('Vidas del jugador principal agotadas, automaticamente pierde');
                  LogFin();
                 end
                else
                 begin
                  EscribirLog(TurnoPrincipal, True, 'Cayó en una casilla de chance en donde retrocedio por la diagonal principal y los soldados del jugador llegaron a cero por lo que perdio una vida');
                  VidaPrincipal:= VidaPrincipal - 1;
                  DibujarVida();
                  SoldadosPrincipal:= 10000;
                  if PosicionPrincipal = MoverEnDiagonal(DimensionTablero, PosicionPrincipal, False, True) then
                   chance:= False
                  else
                   PosicionPrincipal:= MoverEnDiagonal(DimensionTablero, PosicionPrincipal, False, True);
                 end
              else
               begin
                if PosicionPrincipal = MoverEnDiagonal(DimensionTablero, PosicionPrincipal, False, True) then
                   chance:= False
                  else
                   PosicionPrincipal:= MoverEnDiagonal(DimensionTablero, PosicionPrincipal, False, True);
                   EscribirLog(TurnoPrincipal, True, 'Cayó en una casilla de chance en donde retrocedio por la diagonal principal y los soldados del jugador se redujeron de ' + Inttostr(SoldadosPrincipal) + ' a ' + Inttostr(SoldadosPrincipal - 1500));
                   SoldadosPrincipal:= SoldadosPrincipal - 1500;
                end;
               DibujarSoldados();

              end;
          12: begin
               MostrarDialogo('Mala diagonal secundaria',false,true,400,400,5000);

               if (SoldadosPrincipal - 1500) < 0 then
                if (VidaPrincipal - 1) = 0 then
                 begin
                  EscribirLog(TurnoPrincipal, True, 'Cayó en una casilla que le hizo retroceder por la diagonal secundaria y redujo los soldados y vidas a cero por lo que perdio.');
                  showmessage('Vidas del jugador principal agotadas, automaticamente pierde');
                  LogFin();
                 end
                else
                 begin
                  EscribirLog(TurnoPrincipal, True, 'Cayó en una casilla de chance en donde retrocedio por la diagonal secundaria y los soldados del jugador llegaron a cero por lo que perdio una vida');
                  VidaPrincipal:= VidaPrincipal - 1;
                  DibujarVida();
                  SoldadosPrincipal:= 10000;
                  if PosicionPrincipal = MoverEnDiagonal(DimensionTablero, PosicionPrincipal, False, False) then
                  chance:= False
                  else
                    PosicionPrincipal:= MoverEnDiagonal(DimensionTablero, PosicionPrincipal, False, False);
                 end
              else
               begin
              EscribirLog(TurnoPrincipal, True, 'Cayó en una casilla de chance en donde retrocedio por la diagonal secundaria y los soldados del jugador se redujeron de ' + Inttostr(SoldadosPrincipal) + ' a ' + Inttostr(SoldadosPrincipal - 1500));
               if PosicionPrincipal = MoverEnDiagonal(DimensionTablero, PosicionPrincipal, False, False) then
                  chance:= False
                  else
                    PosicionPrincipal:= MoverEnDiagonal(DimensionTablero, PosicionPrincipal, False, False);
               SoldadosPrincipal:= SoldadosPrincipal - 1500;
                end;
               DibujarSoldados();

              end;
          13: begin
               TurnoHabilitadoPrincipal:= false;
               EscribirLog(TurnoPrincipal, True, 'Cayó en una casilla que le hizo perder un turno.');
               MostrarDialogo('Perdiste turno',false,true,400,400,5000);
               chance:= False
              end;
          14: begin
               if (SoldadosPrincipal <= 3500) then
                if ((VidaPrincipal - 1) = 0) then
                 begin
                  EscribirLog(TurnoPrincipal, True, 'Cayó en una casilla que le hizo que se redujeran los soldados y vidas a cero por lo que perdio.');
                  showmessage('Vidas del jugador principal agotadas, automaticamente pierde');
                  LogFin();
                 end
                else
                begin
                 VidaPrincipal:= VidaPrincipal - 1;
                 SoldadosPrincipal:= 10000;
                 EscribirLog(TurnoPrincipal, True, 'Cayó en una casilla de chance que redujo los soldados del a cero por lo que perdio una vida')
                end
               else
                begin
                 EscribirLog(TurnoPrincipal, True, 'Cayó en una casilla de chance que redujo los soldados de ' + Inttostr(SoldadosPrincipal) + ' a ' + Inttostr(SoldadosPrincipal - 3500));
                 SoldadosPrincipal:= SoldadosPrincipal - 2000;
                end;
              chance:= False;
              end;
        end;
    end;
      DibujarSoldados();
      DibujarVida();
    until(not(chance));
    inc(TurnoPrincipal);
    if not(TurnoHabilitadoRetador) and TurnoHabilitadoPrincipal then
     begin
      DadoPrincipal.Enabled:=True;
      DadoRetador.Enabled:=False;
      DadoPrincipal.SetFocus;
      TurnoHabilitadoRetador:= True;
     end;
    end;
end;

procedure TJuego.Timer2Timer(Sender: TObject);
var
  chance: boolean;
  casualidad: 1..16;
begin
   if VistaNumero < 10 then
    begin
       Label2.Caption:=IntToStr(NumeroAleatorio(1,6));
       inc(VistaNumero);
    end
  else
    begin
      beep;
      VistaNumero:= 1;
      Timer2.Enabled:=false;

      DadoPrincipal.Enabled:=true;
      DadoPrincipal.SetFocus;

      PosicionRetador:= PosicionRetador + StrToInt(label2.caption);

      EscribirLog(TurnoRetador, false, 'Obtuvo ' + Juego.label2.caption + ' en el dado.');

      repeat
      chance:= false;

      if PosicionRetador = (DimensionTablero * DimensionTablero) then
           begin
              EscribirLog(TurnoRetador, False, 'Gano el juego.');
              showmessage('Retador Ganaste....');
              LogFin();
           end;

      if PosicionRetador > (DimensionTablero * DimensionTablero) then
           begin
              EscribirLog(TurnoRetador, False, 'Se exedio del maximo y tuvo que regresar ' + inttostr(DimensionTablero * DimensionTablero -  PosicionRetador) + ' pasos.');
              showmessage('Retador pa tras....');
              PosicionRetador:= 2 * DimensionTablero * DimensionTablero -  PosicionRetador;
           end;

      FichaJugadorRetador.top:= CasillaTablero[VectorTablero[PosicionRetador].fila,VectorTablero[PosicionRetador].columna].top + Trunc(OffsetResolTop - OffsetResolTop / 3);
      FichaJugadorRetador.left:= CasillaTablero[VectorTablero[PosicionRetador].fila,VectorTablero[PosicionRetador].columna].left + Trunc(OffsetResolLeft - OffsetResolLeft / 3);

      if (PosicionRetador = PosicionPrincipal) and (PosicionRetador <> 1) then
        begin
         if (VidaPrincipal - 1) = 0 then
          begin
           EscribirLog(TurnoRetador, False, 'Ataco al juagador ' + SecondUser.username + ' y redujo su vida a cero. Gano el juego.');
           showmessage('Vidas del jugador Principal agotadas, automaticamente pierde');
           LogFin();
          end
         else
          VidaPrincipal:= VidaPrincipal - 1;

         DibujarVida();
         SoldadosPrincipal:= 10000;
         DibujarSoldados();
         PosicionPrincipal:=1;

         FichaJugadorPrincipal.top:= CasillaTablero[1,1].top + Trunc(OffsetResolTop - OffsetResolTop / 3);
         FichaJugadorPrincipal.left:= CasillaTablero[1,1].left + 5;
         beep;
         beep;
         beep;
         beep;

        EscribirLog(TurnoRetador, False, 'Ataco al juagador ' + SecondUser.username + ' y redujo su vida.');
        showmessage('Te bocharon.... Principal');

        end;

      if VectorTablero[PosicionRetador].Trampa then
      begin
        chance:= true;

        if PorcentajeBuenas <= NumeroAleatorio(1,100) then
         casualidad:= Ventajas[NumeroAleatorio(1,MaxVentajas)]
        else
         casualidad:= DesVentajas[NumeroAleatorio(1,MaxDesVentajas)] + 7;

        case casualidad of
          1: begin
               MostrarDialogo('Buena avanza dos espacios',true,true,400,400,5000);
               PosicionRetador:= PosicionRetador + 2;
               EscribirLog(TurnoRetador, False, 'Cayó en una casilla de chance que le permitio avanzar dos espacios mas.');
             end;
          2: begin
               MostrarDialogo('Buena avanza ' + label1.caption + ' espacios',true,true,400,400,5000);
               PosicionRetador:= PosicionRetador + StrToInt(label2.caption);
               EscribirLog(TurnoRetador, False, 'Cayó en una casilla de chance que le permitio doblar sus dados y avanzo ' + label1.caption + ' espacios mas.');
             end;
          3: begin
               MostrarDialogo('Buena colocate una posicion adelante del Principal',true,true,400,400,5000);
               PosicionRetador:= PosicionPrincipal + 1;
               EscribirLog(TurnoRetador, False, 'Cayó en una casilla de chance que le permitio colocarse al frente del jugador ' + SecondUser.username + '.');
             end;
          4: begin
               MostrarDialogo('Buena diagonal principal Retador',true,true,400,400,5000);

               if PosicionRetador = MoverEnDiagonal(DimensionTablero, PosicionRetador, True, True) then
                  chance:= False
               else
                  PosicionRetador:= MoverEnDiagonal(DimensionTablero, PosicionRetador, True, True);

               if chance then
                EscribirLog(TurnoRetador, False, 'Cayó en una casilla de chance que le permitio colocarse al frente un paso al frente por la diagonal Retador.')
               else
                EscribirLog(TurnoRetador, False, 'Cayó en una casilla de chance que le permitio colocarse al frente un paso al frente por la diagonal Retador pero como el movimiento en esta direccion seria negativo se quedo en el mismo sitio.');
             end;
          5: begin
               MostrarDialogo('Buena diagonal secundaria',true,true,400,400,5000);
               if PosicionRetador = MoverEnDiagonal(DimensionTablero, PosicionRetador, True, False) then
                    chance:= False
               else
                    PosicionRetador:= MoverEnDiagonal(DimensionTablero, PosicionRetador, True, False);

               if chance then
                EscribirLog(TurnoRetador, False, 'Cayó en una casilla de chance que le permitio colocarse al frente un paso al frente por la diagonal secundaria.')
               else
                EscribirLog(TurnoRetador, False, 'Cayó en una casilla de chance que le permitio colocarse al frente un paso al frente por la diagonal secundaria pero como el movimiento en esta direccion seria negativo se quedo en el mismo sitio.');

             end;
          6: begin
               MostrarDialogo('Buena repite turno',true,true,400,400,5000);
               EscribirLog(TurnoRetador, False, 'Cayó en una casilla de chance que le permitio volver a jugar.');
               DadoPrincipal.Enabled:=False;
               DadoRetador.Enabled:=True;
               DadoRetador.SetFocus;
               chance:= False;
             end;
          7: begin
             if (SoldadosRetador >= 5000) then
              begin
               SoldadosRetador:= 10000;
               if (VidaRetador < 7) then
                 begin
                  VidaRetador:= VidaRetador + 1;
                  EscribirLog(TurnoRetador, False, 'Cayó en una casilla que restauro al maximo sus soldados y le añadio una vida.')
                 end
                else
                 EscribirLog(TurnoRetador, False, 'Cayó en una casilla que restauro al maximo sus soldados.')
               end
             else
              begin
              EscribirLog(TurnoRetador, False, 'Cayó en una casilla que añadio 5000 soldados a sus tropas.');
              SoldadosRetador:= SoldadosRetador + 5000;
              end;

              chance:= False;
             end;
          8: begin
               MostrarDialogo('Mala retrocede un espacio',true,true,400,400,5000);
               if (SoldadosRetador - 1000) < 0 then
                if (VidaRetador - 1) = 0 then
                 begin
                  EscribirLog(TurnoRetador, False, 'Cayó en una casilla que le hizo retroder un espacio y redujo los soldados y vidas a cero por lo que perdio.');
                  showmessage('Vidas del jugador Retador agotadas, automaticamente pierde');
                  LogFin();
                 end
                else
                 begin
                  VidaRetador:= VidaRetador - 1;
                  EscribirLog(TurnoRetador, False, 'Cayó en una casilla de chance en donde retrocedio un espacio y los soldados del jugador llegaron a cero por lo que perdio una vida');
                  DibujarVida();
                  SoldadosRetador:= 10000;
                  if PosicionRetador > 1 then
                  PosicionRetador:= PosicionRetador - 1;
                 end
              else
               begin
                if PosicionRetador > 1 then
                 PosicionRetador:= PosicionRetador - 1;
                EscribirLog(TurnoRetador, False, 'Cayó en una casilla de chance en donde retrocedio un espacio y los soldados del jugador se redujeron de ' + Inttostr(SoldadosRetador) + ' a ' + Inttostr(SoldadosRetador - 1000));
                SoldadosRetador:= SoldadosRetador - 1000;
               end;
               DibujarSoldados();
             end;
          9: begin
               MostrarDialogo('Mala volver al punto de partida',true,true,400,400,5000);

               if (SoldadosRetador - 3000) < 0 then
                if (VidaRetador - 1) = 0 then
                 begin
                  EscribirLog(TurnoRetador, False, 'Cayó en una casilla que le hizo retroder al punto de partida y redujo los soldados y vidas a cero por lo que perdio.');
                  showmessage('Vidas del jugador Retador agotadas, automaticamente pierde');
                  LogFin();
                 end
                else
                 begin
                  VidaRetador:= VidaRetador - 1;
                  EscribirLog(TurnoRetador, False, 'Cayó en una casilla de chance en donde retrocedio al punto de partida y los soldados del jugador llegaron a cero por lo que perdio una vida');
                  DibujarVida();
                  SoldadosRetador:= 10000;
                  PosicionRetador:= 1;
                 end
              else
               begin
                PosicionRetador:= 1;
                EscribirLog(TurnoRetador, False, 'Cayó en una casilla de chance en donde retrocedio al punto de partida y los soldados del jugador se redujeron de ' + Inttostr(SoldadosRetador) + ' a ' + Inttostr(SoldadosRetador - 3000));
                SoldadosRetador:= SoldadosRetador - 3000;
               end;

               DibujarSoldados();

             end;
          10: begin
               MostrarDialogo('Mala colocate una posicion atras del Principal',true,true,400,400,5000);

              if (SoldadosRetador - 2000) < 0 then
                if (VidaRetador - 1) = 0 then
                 begin
                  EscribirLog(TurnoRetador, False, 'Cayó en una casilla que le hizo colocarse en la posicion detras del otro jugador y redujo los soldados y vidas a cero por lo que perdio.');
                  showmessage('Vidas del jugador Retador agotadas, automaticamente pierde');
                  LogFin();
                 end
                else
                 begin
                  EscribirLog(TurnoRetador, False, 'Cayó en una casilla de chance en donde se coloco en la posicion detras del otro jugador y los soldados del jugador llegaron a cero por lo que perdio una vida');
                  VidaRetador:= VidaRetador - 1;
                  DibujarVida();
                  SoldadosRetador:= 10000;

                  if PosicionPrincipal = 1 then
                   PosicionRetador:= 1
                  else
                   PosicionRetador:= PosicionPrincipal - 1;
                 end
              else

               begin
                if PosicionPrincipal = 1 then
                 PosicionRetador:= 1
                else
                 PosicionRetador:= PosicionPrincipal - 1;
                 EscribirLog(TurnoRetador, False, 'Cayó en una casilla de chance en donde se coloco en la posicion detras del otro jugador y los soldados del jugador se redujeron de ' + Inttostr(SoldadosRetador) + ' a ' + Inttostr(SoldadosRetador - 2000));
                 SoldadosRetador:= SoldadosRetador - 2000;
                end;
               DibujarSoldados();
               end;

          11: begin
               MostrarDialogo('Mala diagonal Retador',false,true,400,400,5000);

               if (SoldadosRetador - 1500) < 0 then
                if (VidaRetador - 1) = 0 then
                 begin
                  EscribirLog(TurnoRetador, False, 'Cayó en una casilla que le hizo retroceder por la diagonal Retador y redujo los soldados y vidas a cero por lo que perdio.');
                  showmessage('Vidas del jugador Retador agotadas, automaticamente pierde');
                  LogFin();
                 end
                else
                 begin
                  EscribirLog(TurnoRetador, False, 'Cayó en una casilla de chance en donde retrocedio por la diagonal Retador y los soldados del jugador llegaron a cero por lo que perdio una vida');
                  VidaRetador:= VidaRetador - 1;
                  DibujarVida();
                  SoldadosRetador:= 10000;
                  if PosicionRetador = MoverEnDiagonal(DimensionTablero, PosicionRetador, False, True) then
                   chance:= False
                  else
                   PosicionRetador:= MoverEnDiagonal(DimensionTablero, PosicionRetador, False, True);
                 end
              else
               begin
                if PosicionRetador = MoverEnDiagonal(DimensionTablero, PosicionRetador, False, True) then
                   chance:= False
                  else
                   PosicionRetador:= MoverEnDiagonal(DimensionTablero, PosicionRetador, False, True);
                   EscribirLog(TurnoRetador, False, 'Cayó en una casilla de chance en donde retrocedio por la diagonal Retador y los soldados del jugador se redujeron de ' + Inttostr(SoldadosRetador) + ' a ' + Inttostr(SoldadosRetador - 1500));
                   SoldadosRetador:= SoldadosRetador - 1500;
                end;
               DibujarSoldados();

              end;
          12: begin
               MostrarDialogo('Mala diagonal secundaria',false,true,400,400,5000);

               if (SoldadosRetador - 1500) < 0 then
                if (VidaRetador - 1) = 0 then
                 begin
                  EscribirLog(TurnoRetador, False, 'Cayó en una casilla que le hizo retroceder por la diagonal secundaria y redujo los soldados y vidas a cero por lo que perdio.');
                  showmessage('Vidas del jugador Retador agotadas, automaticamente pierde');
                  LogFin();
                 end
                else
                 begin
                  EscribirLog(TurnoRetador, False, 'Cayó en una casilla de chance en donde retrocedio por la diagonal secundaria y los soldados del jugador llegaron a cero por lo que perdio una vida');
                  VidaRetador:= VidaRetador - 1;
                  DibujarVida();
                  SoldadosRetador:= 10000;
                  if PosicionRetador = MoverEnDiagonal(DimensionTablero, PosicionRetador, False, False) then
                  chance:= False
                  else
                    PosicionRetador:= MoverEnDiagonal(DimensionTablero, PosicionRetador, False, False);
                 end
              else
               begin
              EscribirLog(TurnoRetador, False, 'Cayó en una casilla de chance en donde retrocedio por la diagonal secundaria y los soldados del jugador se redujeron de ' + Inttostr(SoldadosRetador) + ' a ' + Inttostr(SoldadosRetador - 1500));
               if PosicionRetador = MoverEnDiagonal(DimensionTablero, PosicionRetador, False, False) then
                  chance:= False
                  else
                    PosicionRetador:= MoverEnDiagonal(DimensionTablero, PosicionRetador, False, False);
               SoldadosRetador:= SoldadosRetador - 1500;
                end;
               DibujarSoldados();

              end;
          13: begin
               TurnoHabilitadoRetador:= false;
               EscribirLog(TurnoRetador, False, 'Cayó en una casilla que le hizo perder un turno.');
               MostrarDialogo('Perdiste turno',false,true,400,400,5000);
               chance:= False
              end;
          14: begin
               if (SoldadosRetador <= 3500) then
                if ((VidaRetador - 1) = 0) then
                 begin
                  EscribirLog(TurnoRetador, False, 'Cayó en una casilla que le hizo que se redujeran los soldados y vidas a cero por lo que perdio.');
                  showmessage('Vidas del jugador Retador agotadas, automaticamente pierde');
                  LogFin();
                 end
                else
                begin
                 VidaRetador:= VidaRetador - 1;
                 SoldadosRetador:= 10000;
                 EscribirLog(TurnoRetador, False, 'Cayó en una casilla de chance que redujo los soldados del a cero por lo que perdio una vida')
                end
               else
                begin
                 EscribirLog(TurnoRetador, False, 'Cayó en una casilla de chance que redujo los soldados de ' + Inttostr(SoldadosRetador) + ' a ' + Inttostr(SoldadosRetador - 3500));
                 SoldadosRetador:= SoldadosRetador - 2000;
                end;
              chance:= False;
              end;
        end;
    end;
      DibujarSoldados();
      DibujarVida();
    until(not(chance));
    inc(TurnoRetador);

    if not(TurnoHabilitadoPrincipal) and TurnoHabilitadoRetador then
     begin
      DadoRetador.Enabled:=True;
      DadoPrincipal.Enabled:=False;
      DadoRetador.SetFocus;
      TurnoHabilitadoPrincipal:= True;
     end;
    end;
end;

procedure TJuego.TiempoMensajeTimer(Sender: TObject);
begin
  TiempoMensaje.Enabled:=false;
  MensajeDialogo.Hide;
  Juego.enabled:=true;
  if SecondUser.username <> '' then
     Juego.SetFocus;
end;

procedure TJuego.TrackBar1Change(Sender: TObject);
begin
end;

procedure TJuego.Trampa7Click(Sender: TObject);
begin

end;


end.

