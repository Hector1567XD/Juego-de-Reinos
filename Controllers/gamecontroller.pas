unit GameController;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, StdCtrls, ExtCtrls, Math, Crt, MessagesHelper, Forms, Controls, Graphics;

const
  MaxW = 10;
  MaxH = 10;
  MaxVentajas     = 7;
  MaxDesventajas  = 7;

type

  TDialog = Record
    Image: TImage;
    Name: TLabel;
    Text: TLabel;
    Btn: TImage;
    //BtnText: TLabel;
    //PanelText: TPanel;
  End;

  TSpecial  = Record
    Image:    TImage;
    X,Y,Pos:  Byte;
  End;

  TSpecials = Array[1..60] of TSpecial;

  TSection = Record
    Image: TImage;
    Block: Byte;
    LLabel: TLabel;
    Special:   Word;
    Pos:    Byte;
  End;
  TDice = Record
    Image:  TImage;
    Number: Byte;
    Active: Boolean;
    Button: TImage;
  End;
  TSections = Array[1..10,1..10] of TSection;
  TDices    = Array[1..2] of TDice;

  THeart = Record
    Image: TImage;
  End;

  THearts = Array[1..5] of THeart;

  TGPlayer = Record
   Image:   TImage;
   X:       Byte;
   Y:       Byte;
   Pos:     Byte;
   Hearts:  THearts;
   LbName,LbHouse,LbSoliders: TLabel;
  End;

  TGPlayers = Array[1..2] of TGPlayer;

  TCastle = Record
    X,Y: Byte;
    Image: TImage;
  End;

Procedure TurnProcess();
Procedure MovePlayer(var GPlayer:TGPlayer; Moves: Smallint);
Function DadoValue(): Byte;
Function DadoGatch(Player: Byte): Byte;
Procedure DesactiveDice(Player: Byte);
Procedure ActiveDice(Player: Byte);

Procedure setBlock(X,Y,Block: Byte);
Procedure newGame();
Procedure PlaceTerrain();
Procedure Render();

Procedure RenderPlayers();
Procedure RenderUI();
Procedure TurnEvents();
Procedure KillPlayer(OtherPlayer: Byte);
Procedure FirstTurnLogic();
Procedure TestDead();
Procedure WinPlayer(Player:Byte);
Procedure EntradaLog(Texto:String);

Procedure GenerarSpecials(TamTablero: Word;PorcentajeChance: Real{0.10 - 0.50});
Procedure RenderSpecial(var Special:TSpecial);
Procedure RenderSpecials();
Procedure EspecialLogicTo(Player: Byte;PorcentajeBuenas: Byte);
Procedure ProcessEffect(Casualidad: Byte); //PendingEffect

Procedure HideDialog();
Procedure OpenDialog(Name, Text: String;Image: String);
Procedure Anuncio(Tipo: Byte;Text: String);
Procedure EffectDialog(Casualidad: Byte);
Function NumeroAleatorio(min: integer; max: integer): integer;

var
  PlayerTurn:       Byte;
  DadosLastResult:  Byte;
  Pos_IX,Pos_IY,Pos_LX,Pos_LY: Byte;
  GPlayers: TGPlayers;
  Castle:   TCastle;
  NextTurnLose: Byte; //Siguiente Turno perdido para... (0: Nadie, 1: Jugador 1, 2: Jugador 2)
  PendingEffect: Byte;
  PausedController: Boolean;
  AuxBackPos:       Byte;

implementation

uses FormGame, InitFile, LogModel, GamesModel, Dialogs, EspiralMove;

Procedure setBlock(X,Y,Block: Byte); Begin
  Sections[Pos_IY+Y-1,Pos_IX+X-1].Block := Block;
End;

Procedure PlaceTerrain();
Var X, Y, CX, CY, BackX, BackY, InitX, InitY, LastX, LastY: Byte;
Begin

  CX := Ceil( MaxW / 2 );
  CY := Ceil( MaxH / 2 );

  BackX := Ceil( ActualGame.Size / 2 );
  BackY := Ceil( ActualGame.Size / 2 );

  InitX := CX - BackX + 1;
  InitY := CY - BackY + 1;

  LastY := InitY+ActualGame.Size - 1;
  LastX := InitX+ActualGame.Size - 1;

  //Altamente redundante de hecho podria haberlas establecido directamente xD
  Pos_IX := InitX;
  Pos_IY := InitY;
  Pos_LX := LastX;
  Pos_LY := LastY;

  FOR Y := InitY TO LastY DO BEGIN
    FOR X := InitX TO LastX DO BEGIN
      Sections[Y,X].Block := 1;
    END;
  END;

  //FOR Y := 1 TO ActualGame.Size DO BEGIN
  //  FOR X := 1 TO ActualGame.Size DO BEGIN
  //    setBlock(X,Y,2);
  //  END;
  //END;

End;

Procedure EntradaLog(Texto:String);
Begin
  LogList.Items.Add(Texto);
  //LogList.perform( TScrollingWinControl.WM_VSCROLL, SB_BOTTOM, 0 );
  //LogList.perform( TScrollingWinControl.WM_VSCROLL, SB_ENDSCROLL, 0 );
  If (LogList.Items.Count > 1) Then
     LogList.ItemIndex := LogList.Items.Count - 1;

  CGame.PushLog(Texto);
End;

Procedure TestDead();
Var I: Byte;
Begin

  For I := 1 To 2 Do Begin

    If (ActualGame.Players[I].Soliders <= 0) Then Begin
      EntradaLog(ActualGame.Players[I].Username + ' se ha quedado sin soldados.');
      KillPlayer(I);
    End;

    If (ActualGame.Players[I].Lifes <= 0) Then Begin
      EntradaLog(ActualGame.Players[I].Username + ' se ha quedado sin vidas!.');
      If (I = 2) Then WinPlayer(1) Else WinPlayer(2);
    End;

  End;

End;

Procedure PlaceCastle();
Var CastleX,CastleY: Byte;
Begin
  //Castle
  PosToCoor(ActualGame.Size*ActualGame.Size,ActualGame.Clock,ActualGame.Size,CastleX,CastleY);
  Castle.X := CastleX;
  Castle.Y := CastleY;
  //Poner imagen
  Castle.Image.Picture.LoadFromFile(aPPPath + '/images/map/castle.png');
  //Pocisionar imagen
  Castle.Image.Left := Sections[Pos_IY + Castle.Y - 1, Pos_IX + Castle.X - 1].Image.Left;
  Castle.Image.Top  := Sections[Pos_IY + Castle.Y - 1, Pos_IX + Castle.X - 1].Image.Top;
End;

Procedure PlaceLabels();
Var X,Y,I: Byte;
Begin
  For I := 1 To ActualGame.Size*ActualGame.Size Do Begin
    PosToCoor(I,ActualGame.Clock,ActualGame.Size,X,Y);
    Sections[Pos_IY + Y - 1, Pos_IX + X - 1].LLabel.Visible := True;
    Sections[Pos_IY + Y - 1, Pos_IX + X - 1].LLabel.Caption := IntToStr(I);
  End;
End;

//Le da el turno al jugador...
Procedure DarTurno(Player: Byte);
Begin
  //Pone en sistema de quien es el turno
  ActualGame.PTurn := Player;
  //Activa el dado del jugador X
  ActiveDice(Player);
End;

//Nuevo Turno
Procedure NuevoTurno();
Var Turn: String;
Begin
  AuxBackPos := 0;
  Inc(ActualGame.Turn);
  Turn := IntToStr(ActualGame.Turn);
  EntradaLog('Es el turno de ' + ActualGame.Players[ActualGame.PTurn].Username + ', Turno ' + Turn);
End;

Procedure MovePlayer(var GPlayer:TGPlayer; Moves: SmallInt);
Var I:    Byte;
    Next: Boolean;
Begin

  Next := True;
  If (Moves > 0) Then
    For I := 1 To Moves Do Begin

      If (Moves <= 6) Then Delay(20) Else Delay(4);

      If (GPlayer.Pos >= ActualGame.Size*ActualGame.Size) Then Next := False;

      If (Next = True) Then Begin
        GPlayer.Pos := MoveEspiralToPos(GPlayer.X, GPlayer.Y, ActualGame.Clock, ActualGame.Size, 1);
      End Else Begin
        GPlayer.Pos := GPlayer.Pos - 1;
        PosToCoor(GPlayer.Pos, ActualGame.Clock, ActualGame.Size, GPlayer.X, GPlayer.Y);
      End;

      RenderPlayers();
      If (Assigned(FmGame)) Then FmGame.Refresh();

    End
  Else Begin
    For I := 1 To Abs(Moves) Do Begin

      If (Abs(Moves) <= 6) Then Delay(20) Else Delay(4);

      If (GPlayer.Pos > 1) Then Begin
        GPlayer.Pos := GPlayer.Pos - 1;
        PosToCoor(GPlayer.Pos, ActualGame.Clock, ActualGame.Size, GPlayer.X, GPlayer.Y);
      End;

      RenderPlayers();
      If (Assigned(FmGame)) Then FmGame.Refresh();

    End
      //Logica de movimientos para atras
  End;

End;

Procedure KillPlayer(OtherPlayer: Byte);
Begin
  GPlayers[OtherPlayer].Pos                 := 1;
  GPlayers[OtherPlayer].X                   := 1;
  GPlayers[OtherPlayer].Y                   := 1;
  ActualGame.Players[OtherPlayer].Lifes     := ActualGame.Players[OtherPlayer].Lifes - 1;
  ActualGame.Players[OtherPlayer].Soliders  := ActualGame.Soliders;
  RenderPlayers();
  RenderUI();
  EntradaLog(ActualGame.Players[OtherPlayer].Username + ' ha muerto.');
  If (Assigned(FmGame)) Then FmGame.Refresh();
End;

Procedure WinPlayer(Player:Byte);
Var Game: TGame;
Begin
  MessageSuccess('Enahorabuena! ' + ActualGame.Players[Player].Username + ' ha ganado.');
  Game        := CGame.Find(ActualGame.Id);
  Game.Winner := Player;
  CGame.Put(Game, Game.Id);
  EntradaLog('Ha ganado ' + ActualGame.Players[Player].Username + '.');
  ActualGame.Winner := Player;
  If (Assigned(FmGame)) Then FmGame.Hide;
End;

Procedure TurnEvents();
Var OtherPlayer, I, PorBuenas:Byte;
Begin

  OtherPlayer := 2;
  If (ActualGame.PTurn = 2) Then OtherPlayer := 1;

  //Sacar con "Difficulty"
  PorBuenas := 50;
  If (ActualGame.Difficulty = 1) Then PorBuenas := 70;
  If (ActualGame.Difficulty = 3) Then PorBuenas := 30;
  //ShowMessage(IntToStr(PorBuenas));
  //OJO, en casillas con efectos cuales no impliquen moverte de tu lugar hara que se haga un efecto doble... correjir mas tarde (Creo que el AuxBackPos da solucion a esto)
  If (AuxBackPos <> GPlayers[ActualGame.PTurn].Pos) Then Begin
    For I := 1 To ActualGame.Specials Do If (Specials[I].Pos = GPlayers[ActualGame.PTurn].Pos) Then Begin

      AuxBackPos := GPlayers[ActualGame.PTurn].Pos;

      EspecialLogicTo(ActualGame.PTurn, PorBuenas);

      //OpenDialog('Explorador','Se??or fuentes me notifican que acabamos' + #13#10 + ' de caer en una casilla especial.');

      //Anuncio(1,'Se??or, fuentes me notifican que acabamos de caer' + #13#10 + 'en una casilla especial');

      EffectDialog(PendingEffect);
      PausedController := True; while PausedController do begin sleep(1); Application.ProcessMessages; end;

      ProcessEffect(PendingEffect);

      TurnEvents();
      Exit();
      Exit();

    End;
  End Else AuxBackPos := 0;

  If (GPlayers[ActualGame.PTurn].Pos = GPlayers[OtherPlayer].Pos) And (GPlayers[ActualGame.PTurn].Pos <> 1) Then Begin

    Anuncio(3,'Mi se??or, hemos tomado por sorpresa a un' + #13#10 + 'peloton del enemigo lo asesinaremos aqui' + #13#10 + 'y ahora!.');
    PausedController := True; while PausedController do begin sleep(1); Application.ProcessMessages; end;

    EntradaLog(ActualGame.Players[ActualGame.PTurn].Username + ' ha tomado por sorpresa a ' + ActualGame.Players[OtherPlayer].Username + '!');
    KillPlayer(OtherPlayer);
  End;

  If (GPlayers[ActualGame.PTurn].Pos = ActualGame.Size*ActualGame.Size) Then Begin

    Case (NumeroAleatorio(1,4)) Of
     1: Anuncio(1,'Se??or, hemos logrado llegar a nuestro destino.' + #13#10 + 'lo asesinaremos aqui y ahora!.' + #13#10 + 'debemos plantar arboles en el nuevo reino!.');
     2: Anuncio(2,'Se??or!, digo rey!, las tropas han tomado el castillo' + #13#10 + 'nosotros ganamos!.' + #13#10 + 'debemos plantar arboles en el nuevo reino!. ');
     3: Anuncio(3,'Mi Se??or, ya hemos tomado el castillo, salve al' + #13#10 + 'nuevo rey ' + ActualGame.Players[OtherPlayer].Username + '.' + #13#10 + 'debemos plantar arboles en el nuevo reino!.');
     4: Anuncio(4,'Bueno, aqui estamos, al parecer lo hemos logrado.' + #13#10 + 'debemos plantar arboles en el nuevo reino!.');
    End;
    PausedController := True; while PausedController do begin sleep(1); Application.ProcessMessages; end;

    WinPlayer(ActualGame.PTurn);
  End;

End;

Procedure TurnProcess();
Var I: Byte;
Begin
  If (ActualGame.Turn <> 0) Then Begin

    MovePlayer(GPlayers[ActualGame.PTurn], Dices[ActualGame.PTurn].Number);

    TurnEvents();
    RenderUI();
    //ShowMessage(IntToStr(GPlayers[ActualGame.PTurn].Pos));
    RenderPlayers();
    TestDead();

    //Los dados deben estar desactivados, si no, el turno aun no termina
    If (Dices[ActualGame.PTurn].Active = False) Then Begin

      //Si no hay turno que perder, o el turno que queda por perder fue del jugador del turno actual (el cual obviamente no puede perder un turno que ya tuvo)
      If ((NextTurnLose = 0) Or (NextTurnLose = ActualGame.PTurn)) Then Begin
       If (ActualGame.Winner = 0) Then Begin
         If (ActualGame.PTurn = 1) Then DarTurno(2) Else DarTurno(1);
           NuevoTurno();
       End;
      End Else Begin
       DarTurno(ActualGame.PTurn);
       NextTurnLose := 0;
       NuevoTurno();
      End;

    End;

  End Else Begin

    //Si ya ambos dados han sido tirados...
    If ((Dices[1].Number <> 0) and (Dices[2].Number <> 0)) Then Begin
      If (Dices[1].Number > Dices[2].Number) Then
        DarTurno(1)
      Else If (Dices[1].Number < Dices[2].Number) Then
        DarTurno(2)
      Else Begin
        //Empate (?)
        DarTurno(1);
      End;

      NuevoTurno();
    End;

  End;
End;

Procedure FirstTurnLogic();
Begin
    //Desactivo los dados a ambos jugadores
    DesactiveDice(1);
    DesactiveDice(2);

    If (((ActualGame.Size1 + ActualGame.Size2) mod 2) = 0) then Begin

      If (ActualGame.Players[2].Username > ActualGame.Players[1].Username) Then
      DarTurno(2) Else DarTurno(1);

    End Else Begin

      If (ActualGame.Players[2].Username < ActualGame.Players[1].Username) Then
      DarTurno(2) Else DarTurno(1);

    End;

    NuevoTurno();
End;

Function DadoValue(): Byte;
Begin
 Delay(80);
 Exit(Random(6) + 1);
End;

Function DadoGatch(Player: Byte): Byte;
Var I: Byte;
Begin

  DesactiveDice(Player);

  FOR I := 1 To 8 Do Begin
    Dices[Player].Number := DadoValue();
    //ShowMessage(IntToStr(Dices[Player].Number));
    Dices[Player].Image.Picture.LoadFromFile(aPPPath + '/images/game/dice_'+IntToStr(Dices[Player].Number)+'.png');
    If (Assigned(FmGame)) Then FmGame.Refresh();
  END;

  EntradaLog(ActualGame.Players[Player].Username + ' saco un ' + IntToStr(Dices[Player].Number));
  //Esto se hace cuando se da el turno.
  //If (Player <> 1) Then ActiveDice(1);
  //Else ActiveDice(2);

  Exit(Dices[Player].Number);

End;

Procedure DesactiveDice(Player: Byte);
Begin
  If (Player = 0) Then Exit;
  Dices[Player].Active  := False;
  Dices[Player].Button.Picture.LoadFromFile(aPPPath + '/images/buttons/dice.png');
End;

Procedure ActiveDice(Player: Byte);
Begin
  If (Player = 0) Then Exit;
  Dices[Player].Active  := True;
  Dices[Player].Button.Picture.LoadFromFile(aPPPath + '/images/buttons/dice_'+IntToStr(Player)+'.png');
End;

Procedure newGame();
Var I,J: Byte;
Begin

  PausedController := False;
  AuxBackPos := 0;

  PlayerTurn := 1;
  For I := 1 To 10 Do
      For J := 1 To 10 Do
          Sections[I,J].Block := 0;

  //Inicializaciones inutiles por que luego los activare a ambos.
  Dices[1].Number  := 0;
  Dices[1].Active  := False;
  Dices[2].Number  := 0;
  Dices[2].Active  := False;

  //Turno = 0 y Jugador turno = 0;
  ActualGame.Turn   := 0;
  ActualGame.PTurn  := 0;

  //Activando ambos dados
  ActiveDice(1);
  ActiveDice(2);

  PlaceTerrain();
  PlaceCastle();
  PlaceLabels();
  Render();
  RenderUI();
  RenderPlayers();
  Randomize();

  GenerarSpecials(ActualGame.Size, ActualGame.Specials / 100 );
  RenderSpecials();
  //Si no se pone esta opcion, hay otra manera de determinar el primer turno, podriamos hacer luego un condicional con esto
  //Un checkbox que diga "Elegir turno 1 por maquina"
  FirstTurnLogic();

End;

Function NumeroAleatorio(min: integer; max: integer): integer;
Begin
     if min > max then
       NumeroAleatorio:= -1
     else
       NumeroAleatorio:= Random(max-min+1) + min;
End;

Procedure PerderTropasPorcentual(Player: Byte; Porcentaje: Byte);
Var Perdida:Word;
    Result:Integer;
Begin

  Perdida := Trunc(ActualGame.Soliders * (Porcentaje/100));

  Result := ActualGame.Players[Player].Soliders - Perdida;
  If (Result < 0) Then Result := 0;

  ActualGame.Players[Player].Soliders := Result;

  EntradaLog('Los soldados de ' + ActualGame.Players[Player].Username + ' se redujeron a ' + IntToStr(ActualGame.Players[Player].Soliders));

End;

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
               fila: Byte;
               columna: Byte;
               posicion: Byte;
           end;
var
      ArrIzq, ArrDer, AbjIzq, AbjDer: Txy;
      NuevaPos: Integer;
begin

    PosToCoor(P,ActualGame.Clock,N,ArrIzq.columna,ArrIzq.fila);
    ArrIzq.fila     := ArrIzq.fila - 1;
    ArrIzq.columna  := ArrIzq.columna - 1;

    if  TrampaBuena then
        ArrIzq.posicion:= 0
    else
        ArrIzq.posicion:=  101;
    If (not ((ArrIzq.fila < 1) or (ArrIzq.fila > N))) and (not ((ArrIzq.columna < 1) or (ArrIzq.columna > N))) then
       ArrIzq.posicion:= CoorToPos(ArrIzq.columna, ArrIzq.fila, ActualGame.Clock, N);

    PosToCoor(P,ActualGame.Clock,N,ArrDer.columna,ArrDer.fila);
    ArrDer.fila     := ArrDer.fila - 1;
    ArrDer.columna  := ArrDer.columna + 1;

    if  TrampaBuena then
        ArrDer.posicion:= 0
    else
        ArrDer.posicion:=  101;
    If (not ((ArrDer.fila < 1) or (ArrDer.fila > N))) and (not ((ArrDer.columna < 1) or (ArrDer.columna > N))) then
       ArrDer.posicion:= CoorToPos(ArrDer.columna, ArrDer.fila, ActualGame.Clock, N);

    PosToCoor(P,ActualGame.Clock,N,AbjIzq.columna,AbjIzq.fila);
    AbjIzq.fila     := AbjIzq.fila + 1;
    AbjIzq.columna  := AbjIzq.columna - 1;

    if  TrampaBuena then
        AbjIzq.posicion:= 0
    else
        AbjIzq.posicion:=  101;
    If (not ((AbjIzq.fila < 1) or (AbjIzq.fila > N))) and (not ((AbjIzq.columna < 1) or (AbjIzq.columna > N))) then
       AbjIzq.posicion:= CoorToPos(AbjIzq.columna, AbjIzq.fila, ActualGame.Clock, N);

    PosToCoor(P,ActualGame.Clock,N,AbjDer.columna,AbjDer.fila);
    AbjDer.fila     := AbjDer.fila + 1;
    AbjDer.columna  := AbjDer.columna + 1;

    if  TrampaBuena then
        AbjDer.posicion:= 0
    else
        AbjDer.posicion:=  101;
    If (not ((AbjDer.fila < 1) or (AbjDer.fila > N))) and (not ((AbjDer.columna < 1) or (AbjDer.columna > N))) then
       AbjDer.posicion:= CoorToPos(AbjDer.columna, AbjDer.fila, ActualGame.Clock, N);


    NuevaPos:= SelectorDePos(P, TrampaBuena, Principal, ArrIzq.posicion, ArrDer.posicion,AbjIzq.posicion, AbjDer.posicion);

    MoverEnDiagonal:=  NuevaPos;
end;

Procedure EspecialLogicTo(Player: Byte;PorcentajeBuenas: Byte);
Var
  Chance: boolean;
  Casualidad: 0..16;
  I: Byte;
  OtherPlayer: Byte;
  Aux: Integer;
Begin

  {For I := 1 To 7 Do
    ActualGame.Ventajas[I] := I;

  For I := 1 To 7 Do
    ActualGame.Desventajas[I] := I;}

  //For I := 1 To 7 Do ShowMessage(IntToStr(ActualGame.Ventajas[I]));
  //For I := 1 To 7 Do ShowMessage(IntToStr(ActualGame.Desventajas[I]));

  Chance:= true;
  Casualidad := 0;

  While (Casualidad = 0) Do Begin
    If (PorcentajeBuenas <= NumeroAleatorio(1,100)) Then
     Casualidad:= ActualGame.Ventajas[NumeroAleatorio(1,MaxVentajas)]
    Else Begin
     Casualidad:= ActualGame.DesVentajas[NumeroAleatorio(1,MaxDesVentajas)];
     If (Casualidad <> 0) Then Casualidad := Casualidad + 7;
    End;
  End;

  {
    ??quieres probar las diagonales?
      Casualidad := NumeroAleatorio(4,6);
      If (Casualidad = 6) Then
        Casualidad := NumeroAleatorio(11,12);

  }

  PendingEffect := Casualidad;

End;

Procedure GenerarSpecials(TamTablero: Word;PorcentajeChance: Real{0.30});
Var
  I, J, TotalSpecials: Word;
Begin

   TotalSpecials:= 0;
   While  TotalSpecials < (trunc(TamTablero * TamTablero * PorcentajeChance)) Do
   Begin
          I := Random(TamTablero) + 1;
          J := Random(TamTablero) + 1;

          //Se valida que
          //-La casilla especial este libre
          //-La casilla candidata no sea la casilla donde se encuentra el trono de hierro
          //- Que no sea la casilla 1,1

          If  ((Sections[Pos_IY + J - 1, Pos_IX + I - 1].Special = 0) And (CoorToPos(I,J,ActualGame.Clock,TamTablero) <> TamTablero*TamTablero) And not ((I = 1) And (J = 1))) Then
          Begin
               Sections[Pos_IY + J - 1, Pos_IX + I - 1].Special := TotalSpecials + 1;
               Specials[TotalSpecials + 1].X := Pos_IX + I - 1;
               Specials[TotalSpecials + 1].Y := Pos_IY + J - 1;
               Specials[TotalSpecials + 1].Pos := CoorToPos(I,J,ActualGame.Clock,TamTablero);
               //ShowMessage('X '+ IntToSTr(I) + ' Y ' + IntToStr(J) + ' ' + IntToStr(Specials[TotalSpecials + 1].Pos));
               inc(TotalSpecials);
          End;

   End;
End;

Procedure RenderSpecial(var Special:TSpecial);
Begin

  If ((Special.Y = 0) Or (Special.X = 0) Or (Special.Pos = 0)) Then Exit;

  If (Sections[Special.Y, Special.X].Special <> 0) Then Begin
    Special.Image.Visible := True;
    Special.Image.Left    := Sections[Special.Y, Special.X].Image.Left;
    Special.Image.Top     := Sections[Special.Y, Special.X].Image.Top;
  End Else
    Special.Image.Visible := False;

  Special.Image.Picture.LoadFromFile(aPPPath + '/images/map/signal.png');

End;

Procedure RenderSpecials();
Var I: Byte;
Begin

  For I := 1 To ActualGame.Specials Do RenderSpecial(Specials[I]);

End;

Procedure RenderSection(var Section:TSection);
Begin

  If (Section.Block <> 0) Then
    Section.Image.Visible := True
  Else
    Section.Image.Visible := False;

  Case (Section.Block) Of
    1: Section.Image.Picture.LoadFromFile(aPPPath + '/images/map/terrain_1.png');
    2: Section.Image.Picture.LoadFromFile(aPPPath + '/images/map/terrain_2.png');
  End;

End;

Procedure RenderUI();
Var I,J,K: Byte;
    Aux: Real;
    WBar: Word;
Begin

  For I := 1 To 2 Do Begin

    For J := 1 To 5 Do GPlayers[I].Hearts[J].Image.Visible := False;

    For J := 1 To ActualGame.Players[I].Lifes Do GPlayers[I].Hearts[J].Image.Visible := True;

    If (Assigned(GPlayers[I].LbName)) Then
      GPlayers[I].LbName.Caption     := ActualGame.Players[I].Username;

    If (Assigned(GPlayers[I].LbHouse)) Then
      GPlayers[I].LbHouse.Caption    := ActualGame.Players[I].HouseName;

    If (Assigned(GPlayers[I].LbSoliders)) Then
      GPlayers[I].LbSoliders.Caption := 'Soldados: ' + IntToStr(ActualGame.Players[I].Soliders);

    If (Assigned(SoliderBar[I]) And (ActualGame.Soliders <> 0)) Then Begin

      Aux := ActualGame.Players[I].Soliders/ActualGame.Soliders;
      WBar := Trunc(Aux * 188.00);

      K := 0;

      While ((SoliderBar[I].Width > WBar+5) Or (SoliderBar[I].Width < WBar-5)) And (K < 188) Do Begin
        Delay(1);
        If (SoliderBar[I].Width > WBar) Then SoliderBar[I].Width := SoliderBar[I].Width - 4;
        If (SoliderBar[I].Width < WBar) Then SoliderBar[I].Width := SoliderBar[I].Width + 4;
        FmGame.Refresh();
        Inc(K);
      End;

      SoliderBar[I].Width := WBar;
    End;

  End;

  FmGame.Refresh();

End;

Procedure GoToXY(I:Byte;XF,YF:Word);
Var X,Y:Word;
    J: Byte;
Begin

  X := GPlayers[I].Image.Left;
  Y := GPlayers[I].Image.Top;

  While (((X < XF-3) or (Y < YF-3) or (X > XF+3) or (Y > YF+3)) and (J < 96)) Do Begin
    Delay(1);
    If (X < XF-2) Then X := X + 2;
    If (X > XF+2) Then X := X - 2;
    If (Y < YF-2) Then Y := Y + 2;
    If (Y > YF+2) Then Y := Y - 2;

    GPlayers[I].Image.Left  := X;
    GPlayers[I].Image.Top   := Y;

    If (Assigned(FmGame)) Then FmGame.Refresh();

    J := J + 1;
  End;
End;

Procedure RenderPlayers();
Var XF,YF: Word;
    I:Byte;
Begin

  For I := 1 To 2 Do Begin

    XF := Sections[Pos_IY + GPlayers[I].Y - 1,Pos_IX + GPlayers[I].X - 1].Image.Left;
    YF := Sections[Pos_IY + GPlayers[I].Y - 1,Pos_IX + GPlayers[I].X - 1].Image.Top;

    GoToXY(I,XF,YF);

    GPlayers[I].Image.Left  := XF;
    GPlayers[I].Image.Top   := YF;

    If (Assigned(FmGame)) Then FmGame.Refresh();

  End;

End;

Procedure Render();
Var I,J: Byte;
Begin
  For I := 1 To 10 Do
    For J := 1 To 10 Do
      RenderSection(Sections[I,J]);
End;

Procedure EffectDialog(Casualidad: Byte); //PendingEffect
Var Aux: Integer;
    OtherPlayer: Byte;
Begin

  OtherPlayer := 1;
  If (ActualGame.PTurn = 1) Then OtherPlayer := 2;

  case Casualidad of
    1: Anuncio(1,'Se??or, es terreno llano, vamos a movernos dos' + #13#10 + 'pasos mas.');//#13#10
    2: Anuncio(1,'Se??or, vamos a movernos el doble de lo planeado.');//#13#10
    3: Anuncio(1,'Se??or, tenemos la opcion de tomar un atajo' + #13#10 + 'secreto para llegar justo alfrente de nuestros' + #13#10 + 'enemigos!, lo haremos en caso de convenir.');//#13#10
    4: Anuncio(4,'He descubierto un atajo secreto que permitira' + #13#10 + 'movernos en direccion a la diagonal principal, vamos a tomarlo.');
    5: Anuncio(4,'He descubierto un atajo secreto que permitira' + #13#10 + 'movernos en direccion a la diagonal secundaria, vamos a tomarlo.');
    6: Anuncio(2,'Se??or, las condiciones son favorables para' + #13#10 + 'seguir nuestro camino, vuelva a tirar los'+ #13#10 + 'dados.');
    7: Anuncio(3,'Mi se??or, '+IntToStr(Trunc(ActualGame.Soliders * 0.25))+' soldados soldados quieren unirse a nuestra' + #13#10 + 'causa, vamos a permitirselo, sin embargo solo podemos' + #13#10 + 'llevar ' + IntToStr(ActualGame.Soliders) + ' en total.');
    8: Anuncio(3,'Mi se??or, barbaros de salvajes nos han emboscado' + #13#10 + 'tenemos que retroceder un paso.');
    9: Anuncio(4,'Tengo reportes sobre el asesinado de los guardias' + #13#10+ 'de vuestra familia!, tenemos que volver a casa rapido.');
    10: Begin
        Aux := (GPlayers[OtherPlayer].Pos - GPlayers[ActualGame.PTurn].Pos) - 1;
        If (Aux < 0) Then
          Anuncio(2,'Se??or, nos han amenazado!, tenemos que volver'+ #13#10 +'justo un paso atras de nuestros enemigos.')
        Else
          Anuncio(2,'Los enemigos nos han intentado amenzar para'+ #13#10 +'ir justo un paso atras de ellos, pero fuimos mas' + #13#10 + 'inteligentes y nos quedamos aqui.');
        End;
    11: Anuncio(3,'Mi se??or, nos han emboscado!, tenemos que' + #13#10 + 'regresar por el atajo de la diagonal principal!.');
    12: Anuncio(3,'Mi se??or, nos han emboscado!, tenemos que' + #13#10 + 'regresar por el atajo de la diagonal secundaria!.');
    13: Anuncio(2,'Se??or, han envenenado nuestra comida, los' + #13#10 + 'soldados se encuetran muy cansados y sin animos' + #13#10 + 'de continuar por el dia de hoy.');
    14: Anuncio(3,'Mi se??or, hemos perdido '+IntToStr(Trunc(ActualGame.Soliders * 0.25))+' soldados en una batalla' + #13#10 + 'con mercenarios contratados por el enemigo.');
  End;

End;


Procedure ProcessEffect(Casualidad: Byte); //PendingEffect
Var OtherPlayer: Byte;
    Aux: Integer;
Begin

OtherPlayer := 1;
If (ActualGame.PTurn = 1) Then OtherPlayer := 2;

case Casualidad of
  1: begin
       //MostrarDialogo('Buena avanza dos espacios',true,true,400,400,5000);
       MovePlayer(GPlayers[ActualGame.PTurn] , 2);
       EntradaLog(ActualGame.Players[ActualGame.PTurn].Username + ' cay?? en una casilla de chance que le permitio avanzar dos espacios mas.');
     end;
  2: begin
       //MostrarDialogo('Buena avanza ' + label1.caption + ' espacios',true,true,400,400,5000);
       MovePlayer(GPlayers[ActualGame.PTurn] , Dices[ActualGame.PTurn].Number);
       EntradaLog(ActualGame.Players[ActualGame.PTurn].Username + ' Cay?? en una casilla de chance que le permitio doblar sus dados y avanzo ' + IntToStr(Dices[ActualGame.PTurn].Number) + ' espacios mas.');
     end;
  3: begin
       //MostrarDialogo('Buena colocate una posicion adelante del retador',true,true,400,400,5000);
       Aux := (GPlayers[OtherPlayer].Pos - GPlayers[ActualGame.PTurn].Pos) + 1;

       If (Aux > 0) Then
        MovePlayer(GPlayers[ActualGame.PTurn] , Aux);

       EntradaLog(ActualGame.Players[ActualGame.PTurn].Username + ' Cay?? en una casilla de chance que le permitio colocarse al frente de ' + ActualGame.Players[OtherPlayer].Username + '.');
       If (Aux < 0) Then
        EntradaLog('Pero como ' + ActualGame.Players[OtherPlayer].Username + ' esta detras de ' + ActualGame.Players[ActualGame.PTurn].Username + ' este se queda en el mismo sitio.');

     end;
  4: Begin
      GPlayers[ActualGame.PTurn].Pos := MoverEnDiagonal(ActualGame.Size, GPlayers[ActualGame.PTurn].Pos, True, True);
      PosToCoor(GPlayers[ActualGame.PTurn].Pos,ActualGame.Clock,ActualGame.Size,GPlayers[ActualGame.PTurn].X,GPlayers[ActualGame.PTurn].Y);
      RenderPlayers();
      EntradaLog(ActualGame.Players[ActualGame.PTurn].Username + ' Tomo un atajo favorable en direccion a la diagional principal.');

     End;
  5: begin
        GPlayers[ActualGame.PTurn].Pos := MoverEnDiagonal(ActualGame.Size, GPlayers[ActualGame.PTurn].Pos, True, False);
        PosToCoor(GPlayers[ActualGame.PTurn].Pos,ActualGame.Clock,ActualGame.Size,GPlayers[ActualGame.PTurn].X,GPlayers[ActualGame.PTurn].Y);
        RenderPlayers();
        EntradaLog(ActualGame.Players[ActualGame.PTurn].Username + ' Tomo un atajo favorable en direccion a la diagional secundaria.');
     end;
  6: Begin
       //MostrarDialogo('Buena repite turno',true,true,400,400,5000);
       ActiveDice(ActualGame.PTurn);
       EntradaLog(ActualGame.Players[ActualGame.PTurn].Username + ' Cay?? en una casilla de chance que le permitio volver a jugar.');
     End;
  7: begin
       Aux := Trunc(ActualGame.Soliders * 0.25);
       If (ActualGame.Players[ActualGame.PTurn].Soliders >= Aux) Then Begin

         ActualGame.Players[ActualGame.PTurn].Soliders := ActualGame.Soliders;
         If (ActualGame.Players[ActualGame.PTurn].Lifes < 5) Then Begin
          EntradaLog(ActualGame.Players[ActualGame.PTurn].Username + ' Cay?? en una casilla que restauro al maximo sus soldados y le a??adio una vida.');
          ActualGame.Players[ActualGame.PTurn].Lifes := ActualGame.Players[ActualGame.PTurn].Lifes + 1;
         End Else
          EntradaLog(ActualGame.Players[ActualGame.PTurn].Username + ' Cay?? en una casilla que restauro al maximo sus soldados.');

       End Else Begin

        EntradaLog(ActualGame.Players[ActualGame.PTurn].Username + ' Cay?? en una casilla que a??adio ' + IntToStr(Aux) + ' soldados a sus tropas.');
        ActualGame.Players[ActualGame.PTurn].Soliders := ActualGame.Players[ActualGame.PTurn].Soliders + Aux;

       End;
     End;
  8: Begin
       //MostrarDialogo('Mala retrocede un espacio',true,true,400,400,5000);
       MovePlayer(GPlayers[ActualGame.PTurn] , -1);
       EntradaLog(ActualGame.Players[ActualGame.PTurn].Username + ' Cay?? en una casilla de chance en donde retrocedio un espacio.');
       PerderTropasPorcentual(ActualGame.PTurn, 10);
     End;
  9: begin
       //MostrarDialogo('Mala volver al punto de partida',true,true,400,400,5000);
       MovePlayer(GPlayers[ActualGame.PTurn] , 1 - GPlayers[ActualGame.PTurn].Pos );
       EntradaLog(ActualGame.Players[ActualGame.PTurn].Username + ' Cayo en una casilla de chance en donde tuvo que volver al punto de partida.');
       PerderTropasPorcentual(ActualGame.PTurn, 30);
     end;
  10: begin

       //MostrarDialogo('Mala colocate una posicion atras del retador',true,true,400,400,5000);
      Aux := (GPlayers[OtherPlayer].Pos - GPlayers[ActualGame.PTurn].Pos) - 1;

      If (Aux < 0) Then
       MovePlayer(GPlayers[ActualGame.PTurn] , Aux);

      EntradaLog(ActualGame.Players[ActualGame.PTurn].Username + ' Cay?? en una casilla de chance que le penitensio a colocarse detras de ' + ActualGame.Players[OtherPlayer].Username + '.');
      If (Aux > 0) Then
       EntradaLog('Pero como ' + ActualGame.Players[OtherPlayer].Username + ' esta delante de ' + ActualGame.Players[ActualGame.PTurn].Username + ' este se queda en el mismo sitio.');

      PerderTropasPorcentual(ActualGame.PTurn, 20);

      end;
  11: begin
       //MostrarDialogo('Mala diagonal principal',false,true,400,400,5000);
        PerderTropasPorcentual(ActualGame.PTurn, 15);

        GPlayers[ActualGame.PTurn].Pos := MoverEnDiagonal(ActualGame.Size, GPlayers[ActualGame.PTurn].Pos, False, True);
        PosToCoor(GPlayers[ActualGame.PTurn].Pos,ActualGame.Clock,ActualGame.Size,GPlayers[ActualGame.PTurn].X,GPlayers[ActualGame.PTurn].Y);
        RenderPlayers();

        EntradaLog(ActualGame.Players[ActualGame.PTurn].Username + ' Fue forzado a tomar un atajo desfavorable en direccion a la diagional principal.');
      end;
  12: begin
       //MostrarDialogo('Mala diagonal secundaria',false,true,400,400,5000);
        PerderTropasPorcentual(ActualGame.PTurn, 15);

        GPlayers[ActualGame.PTurn].Pos := MoverEnDiagonal(ActualGame.Size, GPlayers[ActualGame.PTurn].Pos, False, False);
        PosToCoor(GPlayers[ActualGame.PTurn].Pos,ActualGame.Clock,ActualGame.Size,GPlayers[ActualGame.PTurn].X,GPlayers[ActualGame.PTurn].Y);
        RenderPlayers();

        EntradaLog(ActualGame.Players[ActualGame.PTurn].Username + ' Fue forzado a tomar un atajo desfavorable en direccion a la diagional secundaria.');
      end;
  13: begin
       NextTurnLose := ActualGame.PTurn;
       EntradaLog(ActualGame.Players[ActualGame.PTurn].Username + ' Cay?? en una casilla que le hizo perder un turno.');
       //MostrarDialogo('Perdiste turno',false,true,400,400,5000);
      end;
  14: begin

      Aux := Trunc(ActualGame.Soliders * 0.25);
      ActualGame.Players[ActualGame.PTurn].Soliders := ActualGame.Players[ActualGame.PTurn].Soliders - Aux;
      EntradaLog(ActualGame.Players[ActualGame.PTurn].Username + ' Cay?? en una casilla que resto ' + IntToStr(Aux) + ' soldados a sus tropas.');

    end;
  End;

End;

Procedure Anuncio(Tipo: Byte;Text: String);
Var NameImage, NamePerson: String;
Begin
  NameImage := 'explorer';
  NamePerson := 'Explorador';
  Case (Tipo) Of
    2: Begin NameImage := 'advister';NamePerson := 'Consejero'; End;
    3: Begin NameImage := 'solider';NamePerson := 'Jefe de armas'; End;
    4: Begin NameImage := 'mercenary';NamePerson := 'Espia'; End;
  End;
  OpenDialog(NamePerson,Text,NameImage);
End;

Procedure HideDialog();
Begin
  PausedController := False;
  Dialog.Image  .Visible := False;
  Dialog.Name   .Visible := False;
  Dialog.Text   .Visible := False;
  Dialog.Btn    .Visible := False;
  //Dialog.BtnText.Visible := False;
  //Dialog.PanelText.Visible := False;
End;

Procedure OpenDialog(Name, Text: String;Image: String);
Begin
  Dialog.Image  .Visible := True;
  Dialog.Image.Picture.LoadFromFile(aPPPath + 'images/dialogs/'+Image+'.png');
  Dialog.Name   .Visible := True;
  Dialog.Text   .Visible := True;
  Dialog.Btn    .Visible := True;
  //Dialog.BtnText.Visible := True;
  //Dialog.PanelText.Visible := True;
  Dialog.Text.ControlStyle   := Dialog.Text.ControlStyle - [csOpaque] + [csParentBackground];
  //Dialog.PanelText.ControlStyle   := Dialog.PanelText.ControlStyle - [csOpaque] + [csParentBackground];
  Dialog.Name   .Caption := Name;
  Dialog.Text   .Caption := Text;
  PausedController := True;
  //Dialog.BtnText.Caption := True;
End;

End.
