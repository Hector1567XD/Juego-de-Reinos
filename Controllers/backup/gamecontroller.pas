unit GameController;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, StdCtrls, ExtCtrls, Math, Crt, MessagesHelper, Forms, Controls, Graphics;

const
  MaxW = 10;
  MaxH = 10;
  MaxVentajas     = 7;
  MaxDesventajas  = 7;

type

  TSpecial  = Record
    Image:    TImage;
    X,Y,Pos:  Byte;
  End;

  TSpecials = Array[1..30] of TSpecial;

  TSection = Record
    Image: TImage;
    Block: Byte;
    LLabel: TLabel;
    Special:   Word;
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

Procedure GenerarSpecials(TamTablero: Word;PorcentajeChance: Real{0.30});
Procedure RenderSpecial(var Special:TSpecial);
Procedure RenderSpecials();
Procedure EspecialLogicTo(Player: Byte;PorcentajeBuenas: Byte);

var
  PlayerTurn:       Byte;
  DadosLastResult:  Byte;
  Pos_IX,Pos_IY,Pos_LX,Pos_LY: Byte;
  GPlayers: TGPlayers;
  Castle:   TCastle;
  NextTurnLose: Byte; //Siguiente Turno perdido para... (0: Nadie, 1: Jugador 1, 2: Jugador 2)

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
  MessageSuccess('Enahorabuena! ' + ActualGame.Players[ActualGame.PTurn].Username + ' ha ganado.');
  Game        := CGame.Find(ActualGame.Id);
  Game.Winner := ActualGame.PTurn;
  CGame.Put(Game, Game.Id);
  EntradaLog('Ha ganado ' + ActualGame.Players[ActualGame.PTurn].Username + '.');
  ActualGame.Winner := ActualGame.PTurn;
  If (Assigned(FmGame)) Then FmGame.Hide;
End;

Procedure TurnEvents();
Var OtherPlayer, I, PorBuenas:Byte;
Begin

  OtherPlayer := 2;
  If (ActualGame.PTurn = 2) Then OtherPlayer := 1;

  If (GPlayers[ActualGame.PTurn].Pos = GPlayers[OtherPlayer].Pos) Then Begin
    EntradaLog(ActualGame.Players[ActualGame.PTurn].Username + ' ha tomado por sorpresa a ' + ActualGame.Players[OtherPlayer].Username + '!');
    KillPlayer(OtherPlayer);
  End;

  If (GPlayers[ActualGame.PTurn].Pos = ActualGame.Size*ActualGame.Size) Then Begin
    WinPlayer(ActualGame.PTurn);
  End;

  //Sacar con "Difficulty"
  PorBuenas := 50;

  For I := 1 To 30 Do If (Specials[I].Pos = GPlayers[ActualGame.PTurn].Pos) Then EspecialLogicTo(ActualGame.PTurn, PorBuenas)

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

    If ((Dices[ActualGame.PTurn].Active = False) And (NextTurnLose = 0)) Then
      If (ActualGame.Winner = 0) Then Begin
        If (ActualGame.PTurn = 1) Then DarTurno(2) Else DarTurno(1);
          NuevoTurno();
      End;

    If (NextTurnLose <> 0) Then Begin
      DarTurno(NextTurnLose);
      NextTurnLose := 0;
      NuevoTurno();
    End;

  End Else Begin

    //Si ya ambos dados han sido tirados...
    If ((Dices[1].Number <> 0) and (Dices[2].Number <> 0)) Then Begin
      If (Dices[1].Number > Dices[2].Number) Then
        DarTurno(1)
      Else If (Dices[1].Number < Dices[2].Number) Then
        DarTurno(2)
      Else Begin
        //Aun no esta programado el empate
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

  GenerarSpecials(ActualGame.Size,0.30);
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

Procedure EspecialLogicTo(Player: Byte;PorcentajeBuenas: Byte);
Var
  Chance: boolean;
  Casualidad: 0..16;
  //Temporal:
  Ventajas, Desventajas: Array [1..7] Of Byte;
  I: Byte;
  OtherPlayer: Byte;
  Aux: Integer;
Begin

  For I := 1 To 7 Do
    Ventajas[I] := I;

  For I := 1 To 7 Do
    Desventajas[I] := I;

  Chance:= true;
  Casualidad := 0;

  While (Casualidad = 0) Do Begin
    If (PorcentajeBuenas <= NumeroAleatorio(1,100)) Then
     Casualidad:= Ventajas[NumeroAleatorio(1,MaxVentajas)]
    Else
     Casualidad:= DesVentajas[NumeroAleatorio(1,MaxDesVentajas)] + 7;
  End;

  OtherPlayer := 1;
  If (ActualGame.PTurn = 1) Then OtherPlayer := 2;

  case Casualidad of
    1: begin
         //MostrarDialogo('Buena avanza dos espacios',true,true,400,400,5000);
         MovePlayer(GPlayers[ActualGame.PTurn] , 2);
         EntradaLog(ActualGame.Players[ActualGame.PTurn].Username + ' cayó en una casilla de chance que le permitio avanzar dos espacios mas.');
       end;
    2: begin
         //MostrarDialogo('Buena avanza ' + label1.caption + ' espacios',true,true,400,400,5000);
         MovePlayer(GPlayers[ActualGame.PTurn] , Dices[ActualGame.PTurn].Number);
         EntradaLog(ActualGame.Players[ActualGame.PTurn].Username + ' Cayó en una casilla de chance que le permitio doblar sus dados y avanzo ' + IntToStr(Dices[ActualGame.PTurn].Number) + ' espacios mas.');
       end;
    3: begin
         //MostrarDialogo('Buena colocate una posicion adelante del retador',true,true,400,400,5000);
         Aux := (GPlayers[OtherPlayer].Pos - GPlayers[ActualGame.PTurn].Pos) + 1;

         If (Aux > 0) Then
          MovePlayer(GPlayers[ActualGame.PTurn] , Aux);

         EntradaLog(ActualGame.Players[ActualGame.PTurn].Username + ' Cayó en una casilla de chance que le permitio colocarse al frente de ' + ActualGame.Players[OtherPlayer].Username + '.');
         If (Aux < 0) Then
          EntradaLog('Pero como ' + ActualGame.Players[OtherPlayer].Username + ' esta detras de ' + ActualGame.Players[ActualGame.PTurn].Username + ' este se queda en el mismo sitio.');

       end;
    4: Begin
         //MostrarDialogo('Buena diagonal principal',true,true,400,400,5000);

         //if PosicionPrincipal = MoverEnDiagonal(DimensionTablero, PosicionPrincipal, True, True) then
        //    chance:= False
         //else
        //    PosicionPrincipal:= MoverEnDiagonal(DimensionTablero, PosicionPrincipal, True, True);

        // if chance then
        //  EscribirLog(TurnoPrincipal, True, 'Cayó en una casilla de chance que le permitio colocarse al frente un paso al frente por la diagonal principal.')
        // else
        //  EscribirLog(TurnoPrincipal, True, 'Cayó en una casilla de chance que le permitio colocarse al frente un paso al frente por la diagonal principal pero como el movimiento en esta direccion seria negativo se quedo en el mismo sitio.');
        ShowMessage('Diagonal Principal');
       End;
    5: begin
         //MostrarDialogo('Buena diagonal secundaria',true,true,400,400,5000);
        // if PosicionPrincipal = MoverEnDiagonal(DimensionTablero, PosicionPrincipal, True, False) then
        //      chance:= False
         //else
        //      PosicionPrincipal:= MoverEnDiagonal(DimensionTablero, PosicionPrincipal, True, False);

         //if chance then
          //EscribirLog(TurnoPrincipal, True, 'Cayó en una casilla de chance que le permitio colocarse al frente un paso al frente por la diagonal secundaria.')
         //else
        //  EscribirLog(TurnoPrincipal, True, 'Cayó en una casilla de chance que le permitio colocarse al frente un paso al frente por la diagonal secundaria pero como el movimiento en esta direccion seria negativo se quedo en el mismo sitio.');

          ShowMessage('Alguna otra diagonal');
       end;
    6: Begin

         //MostrarDialogo('Buena repite turno',true,true,400,400,5000);
         ActiveDice(ActualGame.PTurn);
         EntradaLog(ActualGame.Players[ActualGame.PTurn].Username + ' Cayó en una casilla de chance que le permitio volver a jugar.');

       End;
    7: begin

         Aux := Trunc(ActualGame.Soliders * 0.25);
         If (ActualGame.Players[ActualGame.PTurn].Soliders >= Aux) Then Begin

           ActualGame.Players[ActualGame.PTurn].Soliders := ActualGame.Soliders;
           If (ActualGame.Players[ActualGame.PTurn].Lifes < 5) Then
            EntradaLog(ActualGame.Players[ActualGame.PTurn].Username + ' Cayó en una casilla que restauro al maximo sus soldados y le añadio una vida.')
           Else
            EntradaLog(ActualGame.Players[ActualGame.PTurn].Username + ' Cayó en una casilla que restauro al maximo sus soldados.');

         End Else Begin

          EntradaLog(ActualGame.Players[ActualGame.PTurn].Username + ' Cayó en una casilla que añadio ' + IntToStr(Aux) + ' soldados a sus tropas.');
          ActualGame.Players[ActualGame.PTurn].Soliders := ActualGame.Players[ActualGame.PTurn].Soliders + Aux;

         End;

       End;
    8: Begin

         //MostrarDialogo('Mala retrocede un espacio',true,true,400,400,5000);

         MovePlayer(GPlayers[ActualGame.PTurn] , -1);
         EntradaLog(ActualGame.Players[ActualGame.PTurn].Username + ' Cayó en una casilla de chance en donde retrocedio un espacio.');
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

        EntradaLog(ActualGame.Players[ActualGame.PTurn].Username + ' Cayó en una casilla de chance que le penitensio a colocarse detras de ' + ActualGame.Players[OtherPlayer].Username + '.');
        If (Aux > 0) Then
         EntradaLog('Pero como ' + ActualGame.Players[OtherPlayer].Username + ' esta delante de ' + ActualGame.Players[ActualGame.PTurn].Username + ' este se queda en el mismo sitio.');

        PerderTropasPorcentual(ActualGame.PTurn, 20);

        end;
    11: begin
         //MostrarDialogo('Mala diagonal principal',false,true,400,400,5000);
          PerderTropasPorcentual(ActualGame.PTurn, 15);
          ShowMessage('Diagonal Principal mala');
        end;
    12: begin
         //MostrarDialogo('Mala diagonal secundaria',false,true,400,400,5000);

          PerderTropasPorcentual(ActualGame.PTurn, 15);
          ShowMessage('Diagonal secundaria mala');
        end;
    13: begin
         NextTurnLose := ActualGame.PTurn;
         EntradaLog(ActualGame.Players[ActualGame.PTurn].Username + ' Cayó en una casilla que le hizo perder un turno.');
         //MostrarDialogo('Perdiste turno',false,true,400,400,5000);
        end;
    14: begin

        Aux := Trunc(ActualGame.Soliders * 0.25);
        ActualGame.Players[ActualGame.PTurn].Soliders := ActualGame.Players[ActualGame.PTurn].Soliders - Aux;
        EntradaLog(ActualGame.Players[ActualGame.PTurn].Username + ' Cayó en una casilla que resto ' + IntToStr(Aux) + ' soldados a sus tropas.');

      end;
    End;

End;

Procedure GenerarSpecials(TamTablero: Word;PorcentajeChance: Real{0.30});
Var
  I, J, TotalSpecials: Word;
Begin

   TotalSpecials:= 0;
   While  TotalSpecials < (trunc(TamTablero * TamTablero * PorcentajeChance)) Do
   Begin

          //El ultimo 1 que se le suma es para que no haya especial en la casilla 1,1
          I := Random(TamTablero - 1) + 1 + 1;
          J := Random(TamTablero - 1) + 1 + 1;

          //Se valida que
          //-La casilla especial este libre
          //-La casilla candidata no sea la casilla donde se encuentra el trono de hierro

          If  ((Sections[Pos_IY + J - 1, Pos_IX + I - 1].Special = 0) And (CoorToPos(I,J,ActualGame.Clock,TamTablero) <> TamTablero*TamTablero)) Then
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

  If ((Special.Y = 0) Or (Special.X = 0) Or (Special.X = 0)) Then Exit;

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

  For I := 1 To 30 Do RenderSpecial(Specials[I]);

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
Var I,J: Byte;
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

  End;

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

End.
