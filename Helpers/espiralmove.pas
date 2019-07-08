unit EspiralMove;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

  Procedure PosToCoor({entrada -> }Pos: Byte;Clock: Boolean; Size:Byte;{ --> salida}Var X: Byte;Var Y: Byte);
  Function  CoorToPos(X: Byte;Y: Byte; Clock: Boolean; Size:Byte): Byte;
  Function  MoveEspiralToPos(Var X: Byte;Var Y: Byte; Clock: Boolean; Size:Byte; Moves: Byte): Byte;

implementation

uses Dialogs;


Procedure MoveDir(Var X:Byte; Var Y:Byte; Clock: Boolean; Var FlagMove: Byte;Var RestaY: Byte;Var ProxRestaY: Byte;Var RestaX: Byte;Var ProxRestaX: Byte;Size: Byte);
Var K,J,LastPosX,InitPosX,LastPosY,InitPosY: Byte;
Begin

  K := X;
  J := Y;

  LastPosX := Size - RestaX;
  InitPosX := 0 + RestaX;

  LastPosY := Size - RestaY;
  InitPosY := 0 + RestaY;

  If (Clock = True) Then
    Case (FlagMove) Of
      1: K := K + 1;
      2: J := J + 1;
      3: K := K - 1;
      4: J := J - 1;
    End
  Else
    Case (FlagMove) Of
      1: J := J + 1;
      2: K := K + 1;
      3: J := J - 1;
      4: K := K - 1;
    End;

  If ((K > LastPosX) or (K <= InitPosX) or (J > LastPosY) or (J <= InitPosY)) Then Begin

    FlagMove  := FlagMove + 1;
    If (FlagMove > 4) Then FlagMove := 1;

    ProxRestaY := ProxRestaY + 1;
    If (ProxRestaY > 3) Then Begin
      ProxRestaY := 0;
      RestaY := RestaY + 1;
    End;

    ProxRestaX := ProxRestaX + 1;
    If (ProxRestaX > 3) Then Begin
      ProxRestaX := 0;
      RestaX := RestaX + 1;
    End;

    //Recursividad
    MoveDir(X,Y, Clock, FlagMove, RestaY, ProxRestaY, RestaX, ProxRestaX, Size);

  End Else Begin
    X := K;
    Y := J;
  End;

End;

Procedure PosToCoor({entrada -> }Pos: Byte;Clock: Boolean; Size:Byte;{ --> salida}Var X: Byte;Var Y: Byte);
Var I,FlagMove,RestaY,ProxRestaY,RestaX,ProxRestaX:Byte;
Begin

  X := 1;
  Y := 1;
  FlagMove := 1;

  RestaY := 0;
  RestaX := 0;

  ProxRestaY := 0;
  ProxRestaX := 0;

  If (Clock = True) Then
    ProxRestaY := 1
  Else
    ProxRestaX := 1;

  If (Pos <> 0) Then Pos := Pos - 1;
  //ShowMessage(IntToStr(Pos));
  FOR I := 1 TO Pos DO BEGIN
    MoveDir(X, Y, Clock, FlagMove, RestaY, ProxRestaY, RestaX, ProxRestaX, Size);
  END;

End;

Function CoorToPos(X: Byte;Y: Byte; Clock: Boolean; Size:Byte): Byte;
Var I,XI,YI,FlagMove,RestaY,ProxRestaY,RestaX,ProxRestaX:Byte;
    Encounter: Boolean;
Begin

  XI := 1;
  YI := 1;
  Encounter := False;

  FlagMove := 1;

  RestaY := 0;
  RestaX := 0;

  ProxRestaY := 0;
  ProxRestaX := 0;

  If (Clock = True) Then
    ProxRestaY := 1
  Else
    ProxRestaX := 1;

  If ((XI = X) and (YI = Y)) Then Encounter := True;

  While ((I <= Size*Size) and (Encounter = False)) Do Begin
    MoveDir(XI, YI, Clock, FlagMove, RestaY, ProxRestaY, RestaX, ProxRestaX, Size);
    Inc(I);
    If ((XI = X) and (YI = Y)) Then Encounter := True;
  End;

  Exit(I);

End;

Function MoveEspiralToPos(Var X: Byte;Var Y: Byte; Clock: Boolean; Size:Byte; Moves: Byte): Byte;
Var I,XI,YI,J,FlagMove,RestaY,ProxRestaY,RestaX,ProxRestaX:Byte;
    Encounter: Boolean;
Begin

  XI := 1;
  YI := 1;
  Encounter := False;

  FlagMove := 1;

  RestaY := 0;
  RestaX := 0;

  ProxRestaY := 0;
  ProxRestaX := 0;

  If (Clock = True) Then
    ProxRestaY := 1
  Else
    ProxRestaX := 1;

  I := 1;

  If ((XI = X) and (YI = Y)) Then Encounter := True;

  While ((I <= Size*Size) and (Encounter = False)) Do Begin
    MoveDir(XI, YI, Clock, FlagMove, RestaY, ProxRestaY, RestaX, ProxRestaX, Size);
    Inc(I);
    If ((XI = X) and (YI = Y)) Then Encounter := True;
  End;

  J := 0;

  While ((I <= Size*Size) and (J < Moves)) Do Begin
    MoveDir(XI, YI, Clock, FlagMove, RestaY, ProxRestaY, RestaX, ProxRestaX, Size);
    Inc(I);
    Inc(J);
  End;

  X := XI;
  Y := YI;

  Exit(I);

End;

End.
