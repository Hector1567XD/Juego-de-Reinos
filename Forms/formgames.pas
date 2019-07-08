unit FormGames;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  Menus, FormHelper;

type

  { TFmGames }

  TFmGames = class(TForm)
    LbHouse1: TLabel;
    LbHouse2: TLabel;
    LbHost: TLabel;
    LbRetador: TLabel;
    LbPlayer1: TLabel;
    LbPlayer2: TLabel;
    LbSize: TLabel;
    LbWinner: TLabel;
    LbTitle: TLabel;
    LbTitle1: TLabel;
    LbTitle2: TLabel;
    ListGames: TListBox;
    ListLog: TListBox;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure ListGamesClick(Sender: TObject);
  private

  public
    backgroundImage : TBitmap;

  end;

var
  FmGames: TFmGames;

implementation

uses GamesModel, UserModel, HousesModel;

{$R *.lfm}

{ TFmGames }

procedure TFmGames.FormCreate(Sender: TObject);
begin
  backgroundImage := FmLoadBackgroundSpecify('back_wood4.bmp');
  FmSetSize(Constraints, 650, 404);
  CGame.List(ListGames);
  LbPlayer1.Caption := '';
  LbPlayer2.Caption := '';
  LbHouse1.Caption  := '';
  LbHouse2.Caption  := '';
  LbHouse1.Visible  := False;
  LbHouse2.Visible  := False;
  LbWinner.Caption  := '';
  LbSize.Caption    := '';
end;
procedure TFmGames.FormDestroy(Sender: TObject); begin backgroundImage.Free; end;
procedure TFmGames.FormPaint(Sender: TObject); begin Canvas.Draw( 0, 0, backgroundImage ); end;

procedure TFmGames.ListGamesClick(Sender: TObject);
Var GameCode: String;
    Game:     TGame;
    Players:  Array[1..2] of TUser;
    House:    THouse;
begin

  If (ListGames.ItemIndex = -1) Then Exit();

  GameCode := ListGames.Items[ListGames.ItemIndex];
  CGame.ListLog(ListLog, GameCode);
  Game := CGame.FindCode(GameCode);

  //Player1
  Players[1] := CUser.Find(Game.Player.Id);
  LbPlayer1.Caption := Players[1].Username;

  House := CHouse.Find(Game.Player.House);
  LbHouse1.Caption := House.Name;

  //Player2
  Players[2] := CUser.Find(Game.Player2.Id);
  LbPlayer2.Caption := Players[2].Username;

  House := CHouse.Find(Game.Player2.House);
  LbHouse2.Caption := House.Name;

  //
  LbHouse1.Visible  := True;
  LbHouse2.Visible  := True;

  LbWinner.Caption  := 'Ganador indefinido';
  If ((Game.Winner = 1) or (Game.Winner = 2)) Then Begin
      LbWinner.Caption := 'Ganador: ' + Players[Game.Winner].Username;
  End;

  LbSize.Caption    := IntToStr(Game.Size) + 'x' + IntToStr(Game.Size);

end;

end.
