unit LogModel;
{$mode objfpc}{$H+}
{$static on}

interface

uses
  Classes, SysUtils, InitFile, ModelParent;

type

  TLogs = Array of String;

  CLog = class(TModelParent)
    Private
      fileModel: TextFile;
    Public

      //Meta
      class function Get(LStart, LEnd: QWord): TLogs;

      class function  Count(): Word; static;
      class function  GetAll(): TLogs; static; //Get --> GetAll
      class procedure Store(Data: TLog); static;
      function        GetItems(): TLogs;
      Function        GetItemsR(LStart, LEnd: QWord): TLogs;
      procedure       StoreItem(Data: TLog);
      Constructor     Create;

  end;


implementation

class function CLog.Get(LStart, LEnd: QWord): TLogs;
var Ins: CLog;
begin
  Ins := CLog.Create();Exit(Ins.GetItemsR(LStart, LEnd));
end;

class function CLog.Count(): Word;
var Ins:   CLog;
    Items: TLogs;
begin
  Ins   := CLog.Create();
  Items := Ins.GetItems();
  Exit(Ins.itemsCount);
end;

class function CLog.GetAll(): TLogs; //Get --> GetAll
var Ins: CLog;
begin
  Ins := CLog.Create();Exit(Ins.GetItems());
end;

class procedure CLog.Store(Data: TLog);
var Ins: CLog;
begin
  Ins := CLog.Create();Ins.StoreItem(Data);
end;

function CLog.GetItems(): TLogs;
var Item:   String;
    Items:  TLogs;
    I:      QWord;
begin
  Self.itemsCount := 0;
  I := 1;
  Reset(Self.fileModel);
    while not EOF(Self.fileModel) do begin
      Item := '';
      Read(Self.fileModel, Item);
      Items[I] := Item;
      Inc(I);
      Inc(Self.itemsCount);
    end;
  Close(Self.fileModel);
  Exit(Items);
end;

Function CLog.GetItemsR(LStart, LEnd: QWord): TLogs;
Var Item:   String;
    Items:  TLogs;
    I:      QWord;
Begin
  Self.itemsCount := 0;
  I := 1;
  Reset(Self.fileModel);
    while ((not EOF(Self.fileModel)) && (not (Self.itemsCount = LEnd))) do begin

      Item := '';
      Read(Self.fileModel, Item);

      Inc(Self.itemsCount);

      If (Self.itemsCount >= LStart) Then Begin
        Items[I] := Item;
        Inc(I);
      End;

    end;
  Close(Self.fileModel);
  Exit(Items);
END;


procedure CLog.StoreItem(Data: TLog);
var Items:  TLogs;
begin
  Items := Self.GetItems();
  Data.Id := Self.ItemsCount + 1;
  Items[Self.itemsCount + 1]  := Data;
  Self.StoreItems(Items, Self.itemsCount + 1);
end;

constructor CLog.Create();
begin
    Self.Init(Self.fileModel,'Log.txt');
end;

end.
