unit GamesModel;

{$mode objfpc}{$H+}
{$static on}

interface

uses
  Classes, SysUtils, StdCtrls, InitFile, ModelParent;

type

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

    Logs:           Record
      Start:        QWord;
      Fin:          QWord;
    End;

    Winner:         Byte;
    Trash:          Boolean;

    Size:           Byte;
    Lifes:          Byte;
    Soliders:       Word;
    Difficulty:     Byte;
    Clock:          Boolean;

    Writed:         Boolean;

  End;
  TGames = array[1..MAXITEMS_MODEL] of TGame;
  TDataFile = file of TGame;

  CGame = class(TModelParent)
    Private
      fileModel: TDataFile;
    Public

      //Other Meta
      class procedure PushLog(Move: String);
      class procedure ListLog(var OListLog: TListBox; GameCode: String);

      //Meta - Fundamental
      class procedure Delete(Id: Word); static;
      class function  FindLast(): TGame; static;

      //Meta
      class procedure List(var ListGame: TListBox);
      class procedure Combo(var ComboGame: TComboBox);
      class procedure SeedTest();
      class procedure NewGame(P1,P2,H1,H2,Size,Lifes,Difficulty: Byte;Soliders:Word;Clock:Boolean); static;
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
uses Dialogs, LogModel, UserModel, HousesModel;

class procedure CGame.ListLog(var OListLog: TListBox; GameCode: String);
var I: Word;
    Game: TGame;
    Logs: TLogs;
Begin
   Game := CGame.FindCode(GameCode);
   OListLog.Clear;
   Logs := CLog.Get(Game.Logs.Start,Game.Logs.Fin);
   For I := 1 To Length(Logs)-1 Do OListLog.Items.Add(Logs[I]);
End;

Class procedure CGame.PushLog(Move: String);
Var Game: TGame;
    TStr: String;
Begin
  //ShowMessage('Begin Push Log');
  Game            := CGame.FindLast();
  //ShowMessage('Game ' + IntToStr(Game.Id));
  CLog.Store(Move);

  //Lo siguiente no sirve para nada pero si lo quitas LITERAL se bugea.
  TStr := Move + ' -> '+ IntToStr(Game.Id) + ' ' +  IntToStr(Game.Logs.Start) + ' ' + IntToStr(Game.Logs.Fin);
  //ShowMessage(TStr);

  Game.Logs.Fin   := Game.Logs.Fin + 1;
  //ShowMessage('New End ' + IntToStr(Game.Logs.Fin));
  CGame.Put(Game, Game.Id);
  //ShowMessage('End Push Log');
End;

class function CGame.FindLast(): TGame;
var Items : TGames;
    LastID,I,CountGame: Word;
    LastCode: String[10];
    LastWrited:   Boolean;
begin

  I := 1;
  Items := CGame.Get();
  CountGame := CGame.Count();

  Repeat
    LastID := Items[I].Id;
    LastCode := Items[I].Code;
    LastWrited  := Items[I].Writed;
    Inc(I);
  Until ((LastID <= 0) or (LastID > MAXITEMS_MODEL) or (LastWrited = False) or (LastCode = '') or (LastCode = 'JUEGO') or (I >= CountGame));

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
    If ((Games[I].Trash <> True) and (Games[I].Writed = True)) Then
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

class procedure CGame.SeedTest();//
Begin
   If ((CGame.Count() <= 0) and True) Then Begin
      CGame.NewGame(1, 2, 1 , 2, 5, 3, 2, 1000, False);
      CGame.PushLog('Movimiento 1');
      CGame.PushLog('Movimiento X');
      CGame.PushLog('Movimiento X');
      CGame.PushLog('Movimiento X');
      CGame.PushLog('Movimiento X');
      CGame.PushLog('Movimiento X');
      CGame.PushLog('Movimiento X');
      CGame.PushLog('Movimiento X');
      CGame.PushLog('Movimiento X');
      CGame.PushLog('Movimiento X');
      CGame.PushLog('Movimiento X');
      CGame.PushLog('Movimiento X');
      CGame.PushLog('Movimiento X');
      CGame.PushLog('Movimiento X');
      CGame.PushLog('Movimiento X');
      CGame.PushLog('Movimiento X');
      CGame.PushLog('Movimiento X');
      CGame.PushLog('Movimiento X');
      CGame.PushLog('Movimiento X');
      CGame.PushLog('Movimiento X');
      CGame.PushLog('Movimiento X');
      CGame.PushLog('Movimiento X');
      CGame.PushLog('Movimiento X');
      CGame.PushLog('Movimiento X');
      CGame.PushLog('Movimiento X');
      CGame.PushLog('Movimiento X');
      CGame.PushLog('Movimiento X');
      CGame.PushLog('Movimiento X');
      CGame.PushLog('Movimiento X');
      CGame.PushLog('Movimiento X');
      CGame.PushLog('Movimiento X');
      CGame.PushLog('Movimiento X');
      CGame.PushLog('Movimiento X');
      CGame.PushLog('Movimiento X');
      CGame.PushLog('Movimiento X');
      CGame.PushLog('Movimiento X');
      CGame.PushLog('Movimiento X');
      CGame.PushLog('Movimiento X');
      CGame.PushLog('Movimiento X');
      CGame.PushLog('Movimiento X');
      CGame.PushLog('Movimiento X');
      CGame.PushLog('Movimiento X');
      CGame.PushLog('Movimiento X');
      CGame.PushLog('Movimiento X');
      CGame.PushLog('Movimiento X');
      CGame.PushLog('Movimiento X');
      CGame.PushLog('Movimiento X');
      CGame.PushLog('Movimiento X');
      CGame.PushLog('Movimiento X');
      CGame.PushLog('Movimiento X');
      CGame.PushLog('Movimiento X');
      CGame.PushLog('Movimiento R');
      CGame.PushLog('Movimiento FINAL');
      CGame.NewGame(2, 1, 2 , 1, 7, 3, 2, 1000, False);
      CGame.PushLog('Movimiento J2 1');
      CGame.PushLog('Movimiento X');
      CGame.PushLog('Movimiento X');
      CGame.PushLog('Movimiento X');
      CGame.PushLog('Movimiento X');
      CGame.PushLog('Movimiento X');
      CGame.PushLog('Movimiento X');
      CGame.PushLog('Movimiento X');
      CGame.PushLog('Movimiento X');
      CGame.PushLog('Movimiento X');
      CGame.PushLog('Movimiento X');
      CGame.PushLog('Movimiento X');
      CGame.PushLog('Movimiento X');
      CGame.PushLog('Movimiento X');
      CGame.PushLog('Movimiento X');
      CGame.PushLog('Movimiento X');
      CGame.PushLog('Movimiento X');
      CGame.PushLog('Movimiento X');
      CGame.PushLog('Movimiento X');
      CGame.PushLog('Movimiento X');
      CGame.PushLog('Movimiento X');
      CGame.PushLog('Movimiento X');
      CGame.PushLog('Movimiento X');
      CGame.PushLog('Movimiento X');
      CGame.PushLog('Movimiento X');
      CGame.PushLog('Movimiento X');
      CGame.PushLog('Movimiento X');
      CGame.PushLog('Movimiento X');
      CGame.PushLog('Movimiento X');
      CGame.PushLog('Movimiento X');
      CGame.PushLog('Movimiento X');
      CGame.PushLog('Movimiento X');
      CGame.PushLog('Movimiento X');
      CGame.PushLog('Movimiento X');
      CGame.PushLog('Movimiento X');
      CGame.PushLog('Movimiento X');
      CGame.PushLog('Movimiento X');
      CGame.PushLog('Movimiento X');
      CGame.PushLog('Movimiento X');
      CGame.PushLog('Movimiento X');
      CGame.PushLog('Movimiento X');
      CGame.PushLog('Movimiento X');
      CGame.PushLog('Movimiento X');
      CGame.PushLog('Movimiento X');
      CGame.PushLog('Movimiento X');
      CGame.PushLog('Movimiento X');
      CGame.PushLog('Movimiento X');
      CGame.PushLog('Movimiento X');
      CGame.PushLog('Movimiento X');
      CGame.PushLog('Movimiento X');
      CGame.PushLog('Movimiento X');
      CGame.PushLog('Movimiento X');
      CGame.PushLog('Movimiento X');
      CGame.PushLog('Movimiento X');
      CGame.PushLog('Movimiento X');
      CGame.PushLog('Movimiento X');
      CGame.PushLog('Movimiento J2 FINAL');
      CGame.NewGame(2, 1, 3 , 4, 7, 3, 2, 1000, False);
      CGame.PushLog('Movimiento J3 1');
      CGame.PushLog('Movimiento X');
      CGame.PushLog('Movimiento X');
      CGame.PushLog('Movimiento X');
      CGame.PushLog('Movimiento X');
      CGame.PushLog('Movimiento X');
      CGame.PushLog('Movimiento X');
      CGame.PushLog('Movimiento X');
      CGame.PushLog('Movimiento X');
      CGame.PushLog('Movimiento X');
      CGame.PushLog('Movimiento X');
      CGame.PushLog('Movimiento X');
      CGame.PushLog('Movimiento X');
      CGame.PushLog('Movimiento X');
      CGame.PushLog('Movimiento X');
      CGame.PushLog('Movimiento X');
      CGame.PushLog('Movimiento X');
      CGame.PushLog('Movimiento X');
      CGame.PushLog('Movimiento X');
      CGame.PushLog('Movimiento J3 FINAL');
      CGame.NewGame(2, 1, 4 , 5, 7, 3, 2, 1000, False);
      CGame.PushLog('Movimiento J4 1');
      CGame.PushLog('Movimiento X');
      CGame.PushLog('Movimiento X');
      CGame.PushLog('Movimiento X');
      CGame.PushLog('Movimiento X');
      CGame.PushLog('Movimiento X');
      CGame.PushLog('Movimiento X');
      CGame.PushLog('Movimiento J4 2');
      CGame.PushLog('Movimiento J4 FINAL');
      CGame.NewGame(2, 1, 4 , 5, 7, 3, 2, 1000, False);
      CGame.PushLog('Movimiento J5 1');
      CGame.PushLog('Movimiento X');
      CGame.PushLog('Movimiento X');
      CGame.PushLog('Movimiento X');
      CGame.PushLog('Movimiento X');
      CGame.PushLog('Movimiento X');
      CGame.PushLog('Movimiento X');
      CGame.PushLog('Movimiento J5 2');
      CGame.PushLog('Movimiento J5 FINAL');
      CGame.NewGame(2, 1, 4 , 5, 7, 3, 2, 1000, False);
      CGame.PushLog('Movimiento J6 1');
      CGame.PushLog('Movimiento X');
      CGame.PushLog('Movimiento X');
      CGame.PushLog('Movimiento X');
      CGame.PushLog('Movimiento X');
      CGame.PushLog('Movimiento X');
      CGame.PushLog('Movimiento X');
      CGame.PushLog('Movimiento J6 2');
      CGame.PushLog('Movimiento J6 FINAL');
      CGame.NewGame(2, 1, 4 , 5, 7, 3, 2, 1000, False);
      CGame.PushLog('Movimiento J7 1');
      CGame.PushLog('Movimiento X');
      CGame.PushLog('Movimiento X');
      CGame.PushLog('Movimiento X');
      CGame.PushLog('Movimiento X');
      CGame.PushLog('Movimiento X');
      CGame.PushLog('Movimiento X');
      CGame.PushLog('Movimiento J7 2');
      CGame.PushLog('Movimiento J7 FINAL');
   End;
end;

class procedure CGame.NewGame(P1,P2,H1,H2,Size,Lifes,Difficulty: Byte;Soliders:Word;Clock:Boolean);
var
   Game:  TGame;
Begin

   Game                 := CGame.New();
   Game.Id              := 0;
   Game.Player.Id       := P1;
   Game.Player.House    := H1;
   Game.Player2.Id      := P2;
   Game.Player2.House   := H2;
   Game.Logs.Start      := CLog.Count() + 1;
   Game.Logs.Fin        := CLog.Count() + 1;
   Game.Trash           := False;

   Game.Size            := Size;
   Game.Lifes           := Lifes;
   Game.Difficulty      := Difficulty;
   Game.Soliders        := Soliders;
   Game.Clock           := Clock;
   Game.Writed          := True;

   CGame.Store(Game);
   CGame.PushLog('Ha comenzado una nueva partida!');

   ActualGame.Size  := Size;
   ActualGame.Turn  := 0;
   ActualGame.PTurn := 0;

   ActualGame.Clock := Clock;
   ActualGame.Lifes := Lifes;
   ActualGame.Soliders := Soliders;
   ActualGame.Difficulty := Difficulty;

   ActualGame.Id        := CGame.FindLast().Id;
   ActualGame.Winner    := 0;

   ActualGame.Players[1].Id := P1;
   ActualGame.Players[1].Username   := CUser.Find(P1).Username;
   ActualGame.Players[1].House      := H1;
   ActualGame.Players[1].HouseName  := CHouse.Find(H1).Name;
   ActualGame.Players[1].Soliders   := Soliders;
   ActualGame.Players[1].Lifes      := Lifes;

   ActualGame.Players[2].Id := P2;
   ActualGame.Players[2].Username   := CUser.Find(P2).Username;
   ActualGame.Players[2].House      := H2;
   ActualGame.Players[2].HouseName  := CHouse.Find(H2).Name;
   ActualGame.Players[2].Soliders   := Soliders;
   ActualGame.Players[2].Lifes      := Lifes;

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
begin
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
      Lifes           := 0;
      Soliders        := 0;
      Difficulty      := 0;
      Clock           := False;

      Writed          := False;

      Logs.Start      := 0;
      Logs.Fin        := 0;

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

  //If (Self.itemsCount > 1) Then Self.itemsCount := Self.itemsCount - 1;
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
  //Items[Self.itemsCount + 2]  := CGame.New();
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
