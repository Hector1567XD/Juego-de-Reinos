unit GameController;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, StdCtrls, ExtCtrls, Math, Crt, MessagesHelper, Forms, Controls, Graphics;

const
  MaxW = 10;
  MaxH = 10;

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
Procedure MovePlayer(var GPlayer:TGPlayer; Moves: Byte);
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

var
  PlayerTurn:       Byte;
  DadosLastResult:  Byte;
  Pos_IX,Pos_IY,Pos_LX,Pos_LY: Byte;
  GPlayers: TGPlayers;
  Castle:   TCastle;


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
     LogList.ItemIndex := LogList.Items.Count;

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
  PosToCoor(ActualGame.Size*ActualGame.Size,not ActualGame.Clock,ActualGame.Size,CastleX,CastleY);
  Castle.X := CastleX;
  Castle.Y := CastleY;
  //Poner imagen
  Castle.Image.Picture.LoadFromFile(aPPPath + '/images/map/castle.png');
  //Pocisionar imagen
  Castle.Image.Left := Sections[Pos_IX + Castle.X - 1, Pos_IY + Castle.Y - 1].Image.Left;
  Castle.Image.Top  := Sections[Pos_IX + Castle.X - 1, Pos_IY + Castle.Y - 1].Image.Top;
End;

Procedure PlaceLabels();
Var X,Y,I: Byte;
Begin
  For I := 1 To ActualGame.Size*ActualGame.Size Do Begin
    PosToCoor(I,not ActualGame.Clock,ActualGame.Size,X,Y);
    Sections[Pos_IX + X - 1, Pos_IY + Y - 1].LLabel.Visible := True;
    Sections[Pos_IX + X - 1, Pos_IY + Y - 1].LLabel.Caption := IntToStr(I);
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

Procedure MovePlayer(var GPlayer:TGPlayer; Moves: Byte);
Var I:    Byte;
    Next: Boolean;
Begin

  Next := True;

  For I := 1 To Moves Do Begin

    Delay(20);{}

    If (GPlayer.Pos >= ActualGame.Size*ActualGame.Size) Then Next := False;

    If (Next = True) Then Begin
      GPlayer.Pos := MoveEspiralToPos(GPlayer.X, GPlayer.Y, ActualGame.Clock, ActualGame.Size, 1);
    End Else Begin
      GPlayer.Pos := GPlayer.Pos - 1;
      PosToCoor(GPlayer.Pos, ActualGame.Clock, ActualGame.Size, GPlayer.X, GPlayer.Y);
    End;

    RenderPlayers();
    If (Assigned(FmGame)) Then FmGame.Refresh();

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
Var OtherPlayer:Byte;
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
    If (ActualGame.Winner = 0) Then Begin
      If (ActualGame.PTurn = 1) Then DarTurno(2) Else DarTurno(1);
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

  //Si no se pone esta opcion, hay otra manera de determinar el primer turno, podriamos hacer luego un condicional con esto
  //Un checkbox que diga "Elegir turno 1 por maquina"
  FirstTurnLogic();

End;

{procedure GenerarTrampas(TamTablero:integer);
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

end;}

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

    XF := Sections[Pos_IX + GPlayers[I].Y - 1,Pos_IX + GPlayers[I].X - 1].Image.Left;
    YF := Sections[Pos_IY + GPlayers[I].Y - 1,Pos_IY + GPlayers[I].X - 1].Image.Top;

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
