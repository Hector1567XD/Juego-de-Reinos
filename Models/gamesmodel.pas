unit GamesModel;

{$mode objfpc}{$H+}
{$static on}

interface

uses
  Classes, SysUtils, StdCtrls, InitFile, ModelParent;

const
  MAXITEMS_LOG    = 255; //65535 (Word)
  MAXITEMS_GAMES  = 200;//19724
type

  TLog = Record
    Move:   String[128];
    Player: Byte;
  End;

  TLogs = Array[1..MAXITEMS_LOG] of TLog;

  TGame = Record

    Code:           String[10];//JUEGOIDX

    Id:             Word;

    Player:         Record
      Id:           Word;
      House:        Word;
    End;

    Player2:        Record
      Id:           Word;
      House:        Word;
    End;

    Logs:           TLogs;

    Winner:         Byte;
    Trash:          Boolean;

    Size:           Byte;
    SizeLog:        Word;

  End;
  TGames = array[1..MAXITEMS_GAMES] of TGame;
  TDataFile = file of TGame;

  CGame = class(TModelParent)
    Private
      fileModel: TDataFile;
    Public

      //Other Meta
      class procedure PushLog(Move: String;Player: Byte);
      class procedure PushLogTo(var Game: TGame;Move: String;Player: Byte);

      //Meta - Fundamental
      class procedure Delete(Id: Word); static;
      class function  FindLast(): TGame; static;

      //Meta
      class procedure List(var ListGame: TListBox);
      class procedure Combo(var ComboGame: TComboBox);
      class procedure SeedTest();
      class procedure NewGame(P1,P2,H1,H2,Size: Byte); static;
      class function FindCode(Code : String): TGame; static;

      //Adicionales
      class function Count(): Word; static;
      class function Find(Id: Word): TGame; static;

      //Fundamentales
      class function Get(): TGames; static;
      class procedure Store(Data: TGame); static;
      class procedure Put(Data: TGame; Id: Word); static;

      //No se como catalogarla...
      class function New(): TGame; static;

      //SubPrimas
      procedure StoreItem(Data: TGame);
      procedure EditItem(Data: TGame; Id: Word);

      //Fundamentales Primas
      function  GetItems(): TGames;
      procedure StoreItems(Items: TGames;Size: Word);

      Constructor Create;
  end;


implementation
uses Dialogs;

Class procedure CGame.PushLog(Move: String;Player: Byte);
Var Game: TGame;
Begin

  Game := CGame.FindLast();
  CGame.PushLogTo(Game, Move, Player);

End;

Class procedure CGame.PushLogTo(var Game: TGame;Move: String;Player: Byte);
Var
   Log:   TLog;
Begin

   Log.Move   := Move;
   Log.Player := Player;

   //ShowMessage(Game.Code + ' - ' + IntToStr(Game.SizeLog) + ' +1 = ' + IntToStr(Game.SizeLog+1));

   Game.Logs[Game.SizeLog + 1]  := Log;
   Inc(Game.SizeLog);
   //ShowMessage('--N' + IntToStr(Game.SizeLog));
   CGame.Put(Game, Game.Id);

End;

class function CGame.FindLast(): TGame;
var Items : TGames;
    LastID,I: Word;
begin

  I := 1;
  Items := CGame.Get();

  Repeat
    //ShowMessage(Items[I].Code + ' - ' + IntToStr(Items[I].Id));
    LastID := Items[I].Id;
    Inc(I);
  Until ((LastID <= 0) or (LastID > MAXITEMS_GAMES));

  If (I = 2) Then I := 3;

  //ShowMessage(Items[I - 2].Code + ' - I: ' + IntToStr(I));
  Exit(Items[I - 2]);

end;

class procedure CGame.Delete(Id: Word);
var Game: TGame;
begin
  If (Id = 0) Then Exit();

  Game := CGame.Find(Id);
  Game.Trash := True;
  //Game.Code  := 'JUEGO ELIMINADO';

  If (Game.Id = 0) Then Exit();

  //ShowMessage('ID OF Game ENCOUNTER ' + IntToSTr(Game.Id));
  CGame.Put(Game, Game.Id);
end;

class procedure CGame.List(var ListGame: TListBox);
var I: Word;
    Games: TGames;
Begin
   Games := CGame.Get();
   ListGame.Clear;
   //Solo la agregara al TListBox si la casa no se encuentra eliminada (trash = true)
   For I := 1 To CGame.Count() Do Begin
    If (Games[I].Trash <> True) Then
      ListGame.Items.Add(Games[I].Code);
   End;
end;

class function CGame.FindCode(Code : String): TGame;
var
   I: Word;
   Games: TGames;
   Game:  TGame;
Begin
   Games := CGame.Get();
   for I := 1 to CGame.Count() do
   begin
        Game := Games[i];
        if (Game.Code = Code) then
          Exit(Game); //Retorno el usuario
   end;
   Game := CGame.New();
   Exit(Game);
end;

class procedure CGame.Combo(var ComboGame: TComboBox);
var I: Word;
    Games: TGames;
Begin
   Games := CGame.Get();
   ComboGame.Clear;
   //Solo la agregara al ComboBox si la casa no se encuentra eliminada (trash = true)
   For I := 1 To CGame.Count() Do Begin
    If (Games[I].Trash <> True) Then
      ComboGame.Items.Add(Games[I].Code);
   End;
end;

class procedure CGame.SeedTest();
Begin
   If (CGame.Count() <= 0) Then Begin
      CGame.NewGame(1, 2, 1 , 2, 5);
      CGame.PushLog('Movimiento 1',   1);
      CGame.PushLog('Movimiento 2',   2);
      CGame.PushLog('Movimiento 3',   1);
      CGame.PushLog('Movimiento 4',   2);
      CGame.PushLog('Movimiento 5',   1);
      CGame.PushLog('Movimiento 6',   2);
      CGame.PushLog('Movimiento 7',   1);
      CGame.PushLog('Movimiento 8',   2);
      CGame.PushLog('Movimiento 9',   1);
      CGame.PushLog('Movimiento 10',  2);
      CGame.PushLog('Movimiento 11',  1);
      CGame.NewGame(2, 1, 4 , 5, 7);
      CGame.PushLog('Movimiento J2 1',   1);
      CGame.PushLog('Movimiento J2 2',   2);
      CGame.PushLog('Movimiento J2 3',   1);
      CGame.PushLog('Movimiento J2 4',   2);
      CGame.PushLog('Movimiento J2 5',   1);
      CGame.PushLog('Movimiento J2 6',   2);
      CGame.PushLog('Movimiento J2 7',   1);
      CGame.PushLog('Movimiento J2 8',   2);
      CGame.PushLog('Movimiento J2 9',   1);
      CGame.PushLog('Movimiento J2 10',  2);
      CGame.PushLog('Movimiento J2 11',  1);
   End;
end;

class procedure CGame.NewGame(P1,P2,H1,H2,Size: Byte);
var
   Game:  TGame;
   Logs:  TLogs;
Begin
   Game                 := CGame.New();
   Game.Id              := 0;
   Game.Player.Id       := P1;
   Game.Player.House    := H1;
   Game.Player2.Id      := P2;
   Game.Player2.House   := H2;
   Game.Logs            := Logs;
   Game.Trash           := False;
   Game.Size            := Size;
   Game.SizeLog         := 0;
   CGame.Store(Game);
end;

class function CGame.Find(Id: Word): TGame;
var Items : TGames;
    LastID,I: Word;
begin
  I := 1;
  Items := CGame.Get();
  Repeat
    LastID := Items[I].Id;
    If (LastID = Id) Then
      Exit(Items[I]);

    Inc(I);
  Until(LastID = 0);
  Exit(Items[I]);
end;

class function CGame.Count(): Word;
var Ins:   CGame;
    Items: TGames;
Begin
  Ins   := CGame.Create();
  Items := Ins.GetItems();
  Exit(Ins.itemsCount);
End;

class function CGame.Get(): TGames;
var Ins: CGame;
begin
  Ins := CGame.Create();Exit(Ins.GetItems());
end;

class procedure CGame.Put(Data: TGame; Id: Word);
var Ins: CGame;
begin
  Ins := CGame.Create();
  Ins.EditItem(Data, Id);
end;

class procedure CGame.Store(Data: TGame);
var Ins: CGame;
begin
  Ins := CGame.Create();Ins.StoreItem(Data);
end;

class function CGame.New(): TGame;
var Game: TGame;
    Logs:  TLogs;
begin
    Game.Logs            := Logs;
    with Game do
    begin
      Id              := 0;
      Player.Id       := 0;
      Player.House    := 0;
      Player2.Id      := 0;
      Player2.House   := 0;
      Winner          := 0;
      Trash           := False;
      Size            := 0;
      SizeLog         := 0;
      Code            := 'JUEGO';
    end;
    Exit(Game);
end;

function CGame.GetItems(): TGames;
var Item:   TGame;
    Items:  TGames;
    I:      Word;
begin
  Self.itemsCount := 0;
  I := 1;
  Reset(Self.fileModel);
    while not EOF(Self.fileModel) do begin
      Item := CGame.New();
      Read(Self.fileModel, Item);
      Items[I] := Item;
      //ShowMessage('V ' + IntToSTr(I) + ' - ' + IntToSTr(Item.ID) + ' - ' + Item.Name);
      Inc(I);
      Inc(Self.itemsCount); //K
    end;
  Close(Self.fileModel);
  //ShowMessage(IntToStr(Self.itemsCount));
  Exit(Items);
end;

procedure CGame.StoreItems(Items: TGames; Size: Word);
var I:      Word;
begin
  Rewrite(Self.fileModel);
    For I := 1 To Size Do Begin
      Write(Self.fileModel, Items[I]);
    End;
  Close(Self.fileModel);
end;

procedure CGame.StoreItem(Data: TGame);
var Items:  TGames;
begin
  Items := Self.GetItems();
  //Establece el ID
  Data.Id   := Self.ItemsCount + 1;
  Data.Code := 'JUEGO'+IntToStr(Data.Id);
  Items[Self.itemsCount + 1]  := Data;
  Self.StoreItems(Items, Self.itemsCount + 1);
end;

procedure CGame.EditItem(Data: TGame; Id: Word);
var Items:  TGames;
    I:      Word;
begin

  Items := Self.GetItems();
  For I := 1 To Self.itemsCount Do Begin
    If (Items[I].Id = Id) Then Items[I] := Data;
  End;

  Self.StoreItems(Items, Self.itemsCount);

end;

constructor CGame.Create();
begin
    Self.Init(Self.fileModel,'Games.data');
end;

end.
