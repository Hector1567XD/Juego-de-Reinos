unit HousesModel;
{$mode objfpc}{$H+}
{$static on}

interface

uses
  Classes, SysUtils, StdCtrls, InitFile, ModelParent;
type
  THouse = record
    id:             word;
    name:           string[24];//3 - 24
    lema:           string[64];
    lemano:         string[64];
    trash:          boolean;
    system:         boolean;
  end;
  THouses = array[1..MAXITEMS_MODEL] of THouse;
  TDataFile = file of THouse;

  CHouse = class(TModelParent)
    Private
      fileModel: TDataFile;
    Public

      //Meta - Fundamental
      class procedure Delete(Id: Word); static;

      //Meta
      class procedure List(var ListHouse: TListBox);
      class procedure Combo(var ComboHouse: TComboBox);
      class procedure SeedHouse();
      class procedure NewHouse(Name, Lema, NoLema: String; system: boolean); static;
      class function FindName(Name: String): THouse; static;

      //Adicionales
      class function Count(): Word; static;
      class function Find(Id: Word): THouse; static;

      //Fundamentales
      class function Get(): THouses; static;
      class procedure Store(Data: THouse); static;
      class procedure Put(Data: THouse; Id: Word); static;

      //No se como catalogarla...
      class function New(): THouse; static;

      //SubPrimas
      procedure StoreItem(Data: THouse);
      procedure EditItem(Data: THouse; Id: Word);

      //Fundamentales Primas
      function  GetItems(): THouses;
      procedure StoreItems(Items: THouses;Size: Word);

      Constructor Create;
  end;


implementation
uses Dialogs;

class procedure CHouse.Delete(Id: Word);
var House: THouse;
begin
  If (Id = 0) Then Exit();

  House := CHouse.Find(Id);
  House.Trash := True;
  House.Name  := 'CASA ELIMINADA';

  If (House.Id = 0) Then Exit();

  //ShowMessage('ID OF HOUSE ENCOUNTER ' + IntToSTr(House.Id));
  CHouse.Put(House, House.Id);
end;

class procedure CHouse.List(var ListHouse: TListBox);
var I: Byte;
    Houses: THouses;
Begin
   Houses := CHouse.Get();
   ListHouse.Clear;
   //Solo la agregara al TListBox si la casa no se encuentra eliminada (trash = true)
   For I := 1 To CHouse.Count() Do Begin
    //ShowMessage('>H ' + IntToStr(I) + ' ' + IntToStr(Houses[I].Id) + ' ' + Houses[I].Name + ' ' + BoolToStr(Houses[I].Trash));
    If (Houses[I].Trash <> True) Then
      ListHouse.Items.Add(Houses[I].Name);
   End;
end;

class function CHouse.FindName(Name : String): THouse;
var
   I: Word;
   Houses: THouses;
   House:  THouse;
Begin
   Houses := CHouse.Get();
   for I := 1 to CHouse.Count() do
   begin
        House := Houses[i];
        if (House.Name = Name) then
          Exit(House); //Retorno el usuario
   end;
   House := CHouse.New();
   Exit(House);
end;

class procedure CHouse.Combo(var ComboHouse: TComboBox);
var I: Byte;
    Houses: THouses;
Begin
   Houses := CHouse.Get();
   ComboHouse.Clear;
   //Solo la agregara al ComboBox si la casa no se encuentra eliminada (trash = true)
   For I := 1 To CHouse.Count() Do Begin
    If (Houses[I].Trash <> True) Then
      ComboHouse.Items.Add(Houses[I].Name);
   End;
end;

class procedure CHouse.SeedHouse();
Begin
   If (CHouse.Count() <= 0) Then Begin
      CHouse.NewHouse('Stark',      'Lema Oficial Por definir', 'Lema No Oficial Por definir Lema No Oficial Por definir', true);
      CHouse.NewHouse('Lannister',  'Lema Oficial Por definir', 'Lema No Oficial Por definir', true);
      CHouse.NewHouse('Baratheon',  'Lema Oficial Por definir', 'Lema No Oficial Por definir', true);
      CHouse.NewHouse('Targaryen',  'Lema Oficial Por definir', 'Lema No Oficial Por definir', true);
      CHouse.NewHouse('Greyjoy',    'Lema Oficial Por definir', 'Lema No Oficial Por definir', true);
      CHouse.NewHouse('Tully',      'Lema Oficial Por definir', 'Lema No Oficial Por definir', true);
      CHouse.NewHouse('Tyrell',     'Lema Oficial Por definir', 'Lema No Oficial Por definir', true);
   End;
end;

class procedure CHouse.NewHouse(Name, Lema, NoLema: String; system: boolean);
var
   House:  THouse;
Begin
   House := CHouse.New();
   House.name   := Name;
   House.lema   := Lema;
   House.lemano := NoLema;
   House.system := system;
   CHouse.Store(House);
end;

class function CHouse.Find(Id: Word): THouse;
var Items : THouses;
var LastID,I: Word;
begin
  I := 1;
  Items := CHouse.Get();
  Repeat
    LastID := Items[I].Id;
    If (LastID = Id) Then
      Exit(Items[I]);

    Inc(I);
  Until(LastID = 0);
  Exit(Items[I]);
end;

class function CHouse.Count(): Word;
var Ins:   CHouse;
    Items: THouses;
begin
  Ins   := CHouse.Create();
  Items := Ins.GetItems();
  Exit(Ins.itemsCount);
end;

class function CHouse.Get(): THouses;
var Ins: CHouse;
begin
  Ins := CHouse.Create();Exit(Ins.GetItems());
end;

class procedure CHouse.Put(Data: THouse; Id: Word);
var Ins: CHouse;
begin
  Ins := CHouse.Create();
  Ins.EditItem(Data, Id);
end;

class procedure CHouse.Store(Data: THouse);
var Ins: CHouse;
begin
  Ins := CHouse.Create();Ins.StoreItem(Data);
end;

class function CHouse.New(): THouse;
var House: THouse;
begin
    with House do
    begin
      id        := 0;
      name      := '';
      lema      := '';
      lemano    := '';
      trash     := false;
      system    := false;
    end;
    Exit(House);
end;

function CHouse.GetItems(): THouses;
var Item:   THouse;
    Items:  THouses;
    I:      Word;
begin
  Self.itemsCount := 0;
  I := 1;
  Reset(Self.fileModel);
    while not EOF(Self.fileModel) do begin
      Item := CHouse.New();
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

procedure CHouse.StoreItems(Items: THouses; Size: Word);
var I:      Word;
begin
  Rewrite(Self.fileModel);
    For I := 1 To Size Do Begin
      Write(Self.fileModel, Items[I]);
    End;
  Close(Self.fileModel);
end;

procedure CHouse.StoreItem(Data: THouse);
var Items:  THouses;
begin
  Items := Self.GetItems();
  //Establece el ID
  Data.Id := Self.ItemsCount + 1;
  Items[Self.itemsCount + 1]  := Data;
  Self.StoreItems(Items, Self.itemsCount + 1);
end;

procedure CHouse.EditItem(Data: THouse; Id: Word);
var Items:  THouses;
    I:      Word;
begin

  Items := Self.GetItems();
  For I := 1 To Self.itemsCount Do Begin
    If (Items[I].Id = Id) Then Items[I] := Data;
  End;

  Self.StoreItems(Items, Self.itemsCount);

end;

constructor CHouse.Create();
begin
    Self.Init(Self.fileModel,'House.data');
end;

end.
