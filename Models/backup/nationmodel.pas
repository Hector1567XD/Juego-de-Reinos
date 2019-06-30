unit NationModel;
{$mode objfpc}{$H+}
{$static on}

interface

uses
  Classes, SysUtils, StdCtrls, InitFile, ModelParent;
type
  TNation = record
    id:             word;
    code:           string[3];
    name:           string[20];
    trash:          boolean;
  end;
  TNations = array[1..MAXITEMS_MODEL] of TNation;
  TDataFile = file of TNation;

  CNation = class(TModelParent)
    Private
      fileModel: TDataFile;
    Public
      //Meta - Fundamental
      class procedure Delete(Id: Word); static;

      //Meta
      class procedure List(var ListNation: TListBox);
      class procedure Combo(var ComboNation: TComboBox);
      class procedure SeedNation();
      class procedure NewNation(Code: String;Name: String);
      class function FindName(Name: String): TNation; static;
      class function FindCode(Code: String): TNation; static;

      //Adicionales
      class function Count(): Word; static;
      class function Find(Id: Word): TNation; static;

      //Fundamentales
      class function Get(): TNations; static;
      class procedure Store(Data: TNation); static;
      class procedure Put(Data: TNation; Id: Word); static;

      //No se como catalogarla...
      class function New(): TNation; static;

      //SubPrimas
      procedure StoreItem(Data: TNation);
      procedure EditItem(Data: TNation; Id: Word);

      //Fundamentales Primas
      function  GetItems(): TNations;
      procedure StoreItems(Items: TNations;Size: Word);

      Constructor Create;
  end;


implementation

class procedure CNation.Delete(Id: Word);
var Nation: TNation;
begin
  If (Id = 0) Then Exit();

  Nation := CNation.Find(Id);
  Nation.Trash := True;
  Nation.Name  := 'PAIS ELIMINADO';

  If (Nation.Id = 0) Then Exit();

  CNation.Put(Nation, Nation.Id);
end;

class procedure CNation.List(var ListNation: TListBox);
var I: Byte;
    Nations: TNations;
Begin
   Nations := CNation.Get();
   ListNation.Clear;
   //Solo la agregara al TListBox si el pais no se encuentra eliminada (trash = true)
   For I := 1 To CNation.Count() Do Begin
    If (Nations[I].Trash <> True) Then
      ListNation.Items.Add(Nations[I].Name);
   End;
end;

class function CNation.FindName(Name : String): TNation;
var
   I: Word;
   Nations: TNations;
   Nation:  TNation;
Begin
   Nations := CNation.Get();
   for I := 1 to CNation.Count() do
   begin
        Nation := Nations[i];
        if (Nation.Name = Name) then
          Exit(Nation); //Retorno el usuario
   end;
   Nation := CNation.New();
   Exit(Nation);
end;

class procedure CNation.Combo(var ComboNation: TComboBox);
var I: Byte;
    Nations: TNations;
Begin
   Nations := CNation.Get();
   ComboNation.Clear;
   For I := 1 To CNation.Count() Do Begin
    If (Nations[I].Trash <> True) Then
      ComboNation.Items.Add(Nations[I].Name);
   End;
end;

class procedure CNation.SeedNation();
Begin
   If (CNation.Count() <= 0) Then Begin
      CNation.NewNation('VEN','Venezuela');
      CNation.NewNation('BRS','Brasil');
      CNation.NewNation('ARG','Argentina');
      CNation.NewNation('COL','Colombia');
   End;
end;

class procedure CNation.NewNation(Code: String;Name: String);
var
   Nation:  TNation;
Begin
   Nation := CNation.New();
   Nation.name := Name;
   Nation.code := UpCase(Code);
   CNation.Store(Nation);
end;

class function CNation.FindCode(Code : String): TNation;
var
   I: Word;
   Nations: TNations;
   Nation:  TNation;
Begin
   Nations := CNation.Get();
   for I := 1 to CNation.Count() do
   begin
        Nation := Nations[i];
        if (Nation.code = Code) then
          Exit(Nation); //Retorno el usuario
   end;
   Nation := CNation.New();
   Exit(Nation);
end;

class function CNation.Find(Id: Word): TNation;
var Items : TNations;
var LastID,I: Word;
begin
  I := 1;
  Items := CNation.Get();
  Repeat
    LastID := Items[I].Id;
    If (LastID = Id) Then
      Exit(Items[I]);

    Inc(I);
  Until(LastID = 0);
  Exit(Items[I]);
end;

class function CNation.Count(): Word;
var Ins:   CNation;
    Items: TNations;
begin
  Ins   := CNation.Create();
  Items := Ins.GetItems();
  Exit(Ins.itemsCount);
end;

class function CNation.Get(): TNations;
var Ins: CNation;
begin
  Ins := CNation.Create();Exit(Ins.GetItems());
end;

class procedure CNation.Put(Data: TNation; Id: Word);
var Ins: CNation;
begin
  Ins := CNation.Create();Ins.EditItem(Data, Id);
end;

class procedure CNation.Store(Data: TNation);
var Ins: CNation;
begin
  Ins := CNation.Create();Ins.StoreItem(Data);
end;

class function CNation.New(): TNation;
var Nation: TNation;
begin
    with Nation do
    begin
      id        := 0;
      name      := '';
      code      := '';
      trash     := false;
    end;
    Exit(Nation);
end;

function CNation.GetItems(): TNations;
var Item:   TNation;
    Items:  TNations;
    I:      Word;
begin
  Self.itemsCount := 0;
  I := 1;
  Reset(Self.fileModel);
    while not EOF(Self.fileModel) do begin
      Item := CNation.New();
      Read(Self.fileModel, Item);
      Items[I] := Item;
      Inc(I);
      Inc(Self.itemsCount); //K
    end;
  Close(Self.fileModel);
  Exit(Items);
end;

procedure CNation.StoreItems(Items: TNations; Size: Word);
var I:      Word;
begin
  Rewrite(Self.fileModel);
    For I := 1 To Size Do Begin
      Write(Self.fileModel, Items[I]);
    End;
  Close(Self.fileModel);
end;

procedure CNation.StoreItem(Data: TNation);
var Items:  TNations;
begin
  Items := Self.GetItems();
  //Establece el ID
  Data.Id := Self.ItemsCount + 1;
  Items[Self.itemsCount + 1]  := Data;
  Self.StoreItems(Items, Self.itemsCount + 1);
end;

procedure CNation.EditItem(Data: TNation; Id: Word);
var Items:  TNations;
    I:      Word;
begin

  Items := Self.GetItems();

  For I := 1 To Self.itemsCount Do Begin
    If (Items[I].Id = Id) Then Items[I] := Data;
  End;

  Self.StoreItems(Items, Self.itemsCount);
end;

constructor CNation.Create();
begin
    Self.Init(Self.fileModel,'Nation.data');
end;

end.
