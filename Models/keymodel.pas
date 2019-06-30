unit KeyModel;
{$mode objfpc}{$H+}
{$static on}

interface

uses
  Classes, SysUtils, DateHelper, InitFile, ModelParent;

type
  TKey = record
    id:             word;
    key:            string[32];
    val:            word;
  end;
  TKeys = array[1..MAXITEMS_MODEL] of TKey;
  TDataFile = file of TKey;

  CKey = class(TModelParent)
    Private
      fileModel: TDataFile;
    Public

      //Meta
      class procedure SetKey(KeyN : String; Val: Variant); static;
      class function FindID(KeyN : String): Word; static;
      class function Get(KeyN : String): Variant; static;

      class function Count(): Word; static;
      class function Find(Id: Word): TKey; static;
      class function GetAll(): TKeys; static; //Get --> GetAll
      class procedure Store(Data: TKey); static;
      class procedure Put(Data: TKey; Id: Word); static;
      class function New(): TKey; static;
      procedure StoreItem(Data: TKey);
      procedure EditItem(Data: TKey; Id: Word);
      function  GetItems(): TKeys;
      procedure StoreItems(Items: TKeys;Size: Word);
      Constructor Create;
  end;


implementation

class procedure CKey.SetKey(KeyN : String; Val: Variant);
var
   Key:  TKey;
Begin
   If (CKey.Get(KeyN) = -1) then begin
      Key     := CKey.New();
      Key.Key := KeyN;
      Key.Val := Val;
      CKey.Store(Key);
   end
   else begin
     Key     := CKey.New();
     Key.Key := KeyN;
     Key.Val := Val;
     Key.Id  := CKey.FindID(KeyN);
     CKey.Put(Key, Key.Id);
   end;
end;

class function CKey.FindID(KeyN : String): Word;
var Items   : TKeys;
    LastID,I: Word;
begin
  I := 1;
  Items := CKey.GetAll();
  Repeat
    LastID := Items[I].Id;
    If (Items[I].key = KeyN) Then
      Exit(LastID);

    Inc(I);
  Until(LastID = 0);
  Exit(LastID);
end;

class function CKey.Get(KeyN : String): Variant;
var
   I: Word;
   Keys: TKeys;
   Key:  TKey;
Begin
   Keys := CKey.GetAll();
   for I := 1 to CKey.Count() do
   begin
        Key := Keys[i];
        if (Key.key = KeyN) then
          Exit(Key.Val); //Retorno el usuario
   end;
   Key := CKey.New();
   Exit(-1);
end;

class function CKey.Find(Id: Word): TKey;
var Items : TKeys;
var LastID,I: Word;
begin
  I := 1;
  Items := CKey.GetAll();
  Repeat
    LastID := Items[I].Id;
    If (LastID = Id) Then
      Exit(Items[I]);

    Inc(I);
  Until(LastID = 0);
  Exit(Items[I]);
end;

class function CKey.Count(): Word;
var Ins:   CKey;
    Items: TKeys;
begin
  Ins   := CKey.Create();
  Items := Ins.GetItems();
  Exit(Ins.itemsCount);
end;

class function CKey.GetAll(): TKeys; //Get --> GetAll
var Ins: CKey;
begin
  Ins := CKey.Create();Exit(Ins.GetItems());
end;

class procedure CKey.Put(Data: TKey; Id: Word);
var Ins: CKey;
begin
  Ins := CKey.Create();Ins.EditItem(Data, Id);
end;

class procedure CKey.Store(Data: TKey);
var Ins: CKey;
begin
  Ins := CKey.Create();Ins.StoreItem(Data);
end;

class function CKey.New(): TKey;
var Key: TKey;
begin
    with Key do
    begin
      ID  := 0;
      Key := '';
      Val := 0;
    end;
    Exit(Key);
end;

function CKey.GetItems(): TKeys;
var Item:   TKey;
    Items:  TKeys;
    I:      Word;
begin
  Self.itemsCount := 0;
  I := 1;
  Reset(Self.fileModel);
    while not EOF(Self.fileModel) do begin
      Item := CKey.New();
      Read(Self.fileModel, Item);
      Items[I] := Item;
      Inc(I);
      Inc(Self.itemsCount);
    end;
  Close(Self.fileModel);
  Exit(Items);
end;

procedure CKey.StoreItems(Items: TKeys; Size: Word);
var I:      Word;
begin
  Rewrite(Self.fileModel);
    For I := 1 To Size Do Begin
      Write(Self.fileModel, Items[I]);
    End;
  Close(Self.fileModel);
end;

procedure CKey.StoreItem(Data: TKey);
var Items:  TKeys;
begin
  Items := Self.GetItems();
  Data.Id := Self.ItemsCount + 1;
  Items[Self.itemsCount + 1]  := Data;
  Self.StoreItems(Items, Self.itemsCount + 1);
end;

procedure CKey.EditItem(Data: TKey; Id: Word);
var Items:  TKeys;
    I:      Word;
begin
  Items := Self.GetItems();
  For I := 1 To Self.itemsCount Do Begin
    If (Items[I].Id = Id) then
      Items[I] := Data;
  End;
  Self.StoreItems(Items, Self.itemsCount);
end;

constructor CKey.Create();
begin
    Self.Init(Self.fileModel,'Key.data');
end;

end.
unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

implementation

end.
