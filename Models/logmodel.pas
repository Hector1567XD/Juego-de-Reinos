unit LogModel;
{$mode objfpc}{$H+}
{$static on}

interface

uses
  Classes, SysUtils, InitFile;

type

  TLogs = Array of String;

  CLog = class
    Private
      fileModel:  TextFile;
      fileName:   String;
      fullRoute:  String;
      itemsCount: QWord;

      procedure   Init(fileNameParam: String);

    Public

      //Meta
      class function Get(LStart, LEnd: QWord): TLogs;

      class function  Count(): Word; static;
      class function  GetAll(): TLogs; static; //Get --> GetAll
      class procedure Store(Data: String); static;
      function        GetItems(): TLogs;
      Function        GetItemsR(LStart, LEnd: QWord): TLogs;
      procedure       StoreItem(Data: String);
      Constructor     Create;

  end;


implementation

uses Dialogs;

class function CLog.Get(LStart, LEnd: QWord): TLogs;
var Ins: CLog;
begin
  Ins := CLog.Create();Exit(Ins.GetItemsR(LStart, LEnd));
end;

class function CLog.Count(): Word;
var Ins:   CLog;
    Items: TLogs;
begin
  //ShowMessage('Begin Count');
  Ins   := CLog.Create();
  Items := Ins.GetItems();
  //ShowMessage('END OF COUNT' + IntToStr(Ins.itemsCount));
  Exit(Ins.itemsCount);
end;

class function CLog.GetAll(): TLogs; //Get --> GetAll
var Ins: CLog;
begin
  Ins := CLog.Create();Exit(Ins.GetItems());
end;

class procedure CLog.Store(Data: String);
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
      ReadLn(Self.fileModel, Item);
      setLength(Items, I + 1);
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
    while ((not EOF(Self.fileModel)) and (not (Self.itemsCount >= LEnd - 1))) do begin
      ReadLn(Self.fileModel, Item);
      Inc(Self.itemsCount);
      If (Self.itemsCount >= LStart) Then Begin
        setLength(Items, I + 1);
        Items[I] := Item;
        Inc(I);
      End;
    end;
  Close(Self.fileModel);
  //ShowMessage('End Of Read TXT FIle R');
  Exit(Items);
END;


Procedure CLog.StoreItem(Data: String);
Begin
  Append(Self.fileModel);
    Writeln(Self.fileModel, Data);
  CloseFile(Self.fileModel);
End;

constructor CLog.Create();
begin
    Self.Init('Log.txt');
end;

procedure CLog.Init(fileNameParam: String);
begin

  If (Not DirectoryExists('data')) then CreateDir('data');

  Self.itemsCount := 0;
  Self.fileName := fileNameParam;
  Self.fullRoute := aPPPath + '/data/' + Self.fileName;

  Assign(Self.fileModel, Self.fullRoute);

  if not(FileExists(Self.fullRoute)) then
  begin
    Rewrite(Self.fileModel);
    Close(Self.fileModel);
  end;

end;

end.
