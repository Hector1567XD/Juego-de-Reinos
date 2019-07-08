unit GameController;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, StdCtrls, ExtCtrls, Math, Crt;

const
  MaxW = 10;
  MaxH = 10;

type
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
  CGame.PushLog('[Turno ' + Turn + '] ' + 'El turno de ' + ActualGame.Players[ActualGame.PTurn].Username + ' acaba de empezar.');
End;

Procedure MovePlayer(var GPlayer:TGPlayer; Moves: Byte);
Var I: Byte;
Begin
  For I := 1 To Moves Do Begin
    Delay(20);{}
    GPlayer.Pos := MoveEspiralToPos(GPlayer.X, GPlayer.Y, not ActualGame.Clock, ActualGame.Size, 2);
    //ShowMessage(IntToStr(MoveEspiralToPos(GPlayer.X, GPlayer.Y, not ActualGame.Clock, ActualGame.Size, 2)));
    RenderPlayers();
    If (Assigned(FmGame)) Then FmGame.Refresh();
  End;
End;

Procedure TurnProcess();
Var I: Byte;
Begin
  If (ActualGame.Turn <> 0) Then Begin

    MovePlayer(GPlayers[ActualGame.PTurn], Dices[ActualGame.PTurn].Number);
    RenderUI();
    ShowMessage(IntToStr(GPlayers[ActualGame.PTurn].X));
    RenderPlayers();
    If (ActualGame.PTurn = 1) Then DarTurno(2) Else DarTurno(1);

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

Function DadoValue(): Byte;
Begin
 Delay(80);
 Exit(Random(5) + 1);
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

  CGame.PushLog(ActualGame.Players[Player].Username + ' saco un ' + IntToStr(Dices[Player].Number));
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


Procedure RenderPlayers();
Var I: Byte;
Begin

  For I := 1 To 2 Do Begin
    GPlayers[I].Image.Left := Sections[Pos_IX + GPlayers[I].Y - 1,Pos_IX + GPlayers[I].X - 1].Image.Left;
    GPlayers[I].Image.Top  := Sections[Pos_IY + GPlayers[I].Y - 1,Pos_IY + GPlayers[I].X - 1].Image.Top;
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
