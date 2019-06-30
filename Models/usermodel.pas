unit UserModel;
{$mode objfpc}{$H+}
{$static on}

interface

uses
  Classes, SysUtils, DateHelper, InitFile, ModelParent;

type
  TUser = record
    id:             word;       //no, no habra ID = -1 >-<
    name, lastname: string[20];
    username:       string[12];
    password:       string[24];
    email:          string[180];
    birthdate:      TFecha;
    countryID:      word;
    logueos:        word;
  end;
  TUsers = array[1..MAXITEMS_MODEL] of TUser;
  TDataFile = file of TUser;

  CUser = class(TModelParent)
    Private
      fileModel: TDataFile;
    Public

      //Meta
          //Aqui recien estarian las funciones que pueden diferir segun el Modelo.

      //Adicionales
      class function Count(): Word; static;
      class function Find(Id: Word): TUser; static;

      //Fundamentales
      class function Get(): TUsers; static;
      class procedure Store(Data: TUser); static;
      class procedure Put(Data: TUser; Id: Word); static;

      //No se como catalogarla...
      class function New(): TUser; static;

      //SubPrimas
      procedure StoreItem(Data: TUser);
      procedure EditItem(Data: TUser; Id: Word);

      //Fundamentales Primas
      function  GetItems(): TUsers;
      procedure StoreItems(Items: TUsers;Size: Word);

      Constructor Create;
  end;


implementation

class function CUser.Find(Id: Word): TUser;
var Items : TUsers;
var LastID,I: Word;
begin
  I := 1;
  Items := CUser.Get();
  Repeat
    LastID := Items[I].Id;
    If (LastID = Id) Then
      Exit(Items[I]);

    Inc(I);
  Until(LastID = 0);
  Exit(Items[I]);
end;

class function CUser.Count(): Word;
var Ins:   CUser;
    Items: TUsers;
begin
  Ins   := CUser.Create();
  Items := Ins.GetItems();
  Exit(Ins.itemsCount);
end;

class function CUser.Get(): TUsers;
var Ins: CUser;
begin
  Ins := CUser.Create();Exit(Ins.GetItems());
end;

class procedure CUser.Put(Data: TUser; Id: Word);
var Ins: CUser;
begin
  Ins := CUser.Create();Ins.EditItem(Data, Id);
end;

class procedure CUser.Store(Data: TUser);
var Ins: CUser;
begin
  Ins := CUser.Create();Ins.StoreItem(Data);
end;

class function CUser.New(): TUser;
var User: TUser;
begin
    with User do
    begin
      id        := 0; //no, no habra ID = -1 >-<
      name      := '';
      lastname  := '';
      username  := '';
      password  := '';
      email     := '';
      birthdate := newFecha(1,1,1870);
      countryID := 0;
      logueos   := 0;
    end;
    Exit(User);
end;

function CUser.GetItems(): TUsers;
var Item:   TUser;
    Items:  TUsers;
    I:      Word;
begin
  Self.itemsCount := 0;
  I := 1;
  Reset(Self.fileModel);
    while not EOF(Self.fileModel) do begin
      Item := CUser.New();
      Read(Self.fileModel, Item);
      Items[I] := Item;
      Inc(I);
      Inc(Self.itemsCount); //K
    end;
  Close(Self.fileModel);
  Exit(Items);
end;

procedure CUser.StoreItems(Items: TUsers; Size: Word);
var I:      Word;
begin
  Rewrite(Self.fileModel);
    For I := 1 To Size Do Begin
      Write(Self.fileModel, Items[I]);
    End;
  Close(Self.fileModel);
end;

procedure CUser.StoreItem(Data: TUser);
var Items:  TUsers;
begin
  Items := Self.GetItems();
  //Establece el ID
  Data.Id := Self.ItemsCount + 1;
  Items[Self.itemsCount + 1]  := Data;
  Self.StoreItems(Items, Self.itemsCount + 1);
end;

procedure CUser.EditItem(Data: TUser; Id: Word);
var Items:  TUsers;
    I:      Word;
begin

  Items := Self.GetItems();

  For I := 1 To Self.itemsCount Do Begin
    If (Items[I].Id = Id) Then Items[I] := Data;
  End;

  Self.StoreItems(Items, Self.itemsCount);
end;

constructor CUser.Create();
begin
    Self.Init(Self.fileModel,'user.data');
end;

end.
