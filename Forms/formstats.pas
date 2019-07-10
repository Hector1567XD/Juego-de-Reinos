unit FormStats;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls, FormHelper, MessagesHelper;

type

  { TFmStats }

  TFmStats = class(TForm)
    btnNewGame: TPanel;
    Edit1: TEdit;
    Edit2: TEdit;
    UserBox: TComboBox;
    lbDate: TLabel;
    lbDate1: TLabel;
    lbDate2: TLabel;
    LbTitle: TLabel;
    ListBox2: TListBox;
    procedure btnNewGameClick(Sender: TObject);
    procedure btnNewGameMouseEnter(Sender: TObject);
    procedure btnNewGameMouseLeave(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormPaint(Sender: TObject);
  private

  public
    backgroundImage : TBitmap;
  end;

var
  FmStats: TFmStats;

implementation
uses UserModel, GamesModel, DateUtils, Math;
{$R *.lfm}

{ TFmStats }

procedure TFmStats.btnNewGameMouseEnter(Sender: TObject);
begin
   TPanel(Sender).color:=$00555555;
end;

procedure TFmStats.btnNewGameClick(Sender: TObject);
Var Games: TGames;
    StatName: String;
    User: TUser;
    I: Word;
    TmpString: String;
    dStart, dEnd, d2Test: TDate;
begin
   Games := CGame.Get();
   if UserBox.ItemIndex = -1 then begin
     MessageWarning('Debe seleccionar una persona.');
     Exit();
   end;

   StatName := UserBox.Items[UserBox.ItemIndex];
   User := CUser.FindName(StatName);

   ListBox2.Clear;

   dStart := StrToDate(Edit1.Text);
   dEnd   := StrToDate(Edit2.Text);

   For I := 1 To CGame.Count() Do Begin
    TmpString := '';
    d2Test := StrToDate(IntToStr(Games[I].Fecha.Day)+'/'+IntToStr(Games[I].Fecha.Month)+'/'+IntToStr(Games[I].Fecha.Year));
    If (InRange(d2Test, dStart, dEnd)) Then Begin
      If (Games[I].Player.Id = User.Id) or (Games[I].Player2.Id = User.Id) Then Begin
        TmpString := Games[I].Code;
        If (Games[I].Winner = 1) And (Games[I].Player.Id = User.Id) Then
          TmpString := TmpString + ' Ganador'
        Else If (Games[I].Winner = 2) And (Games[I].Player2.Id = User.Id) Then
          TmpString := TmpString + ' Ganador'
        Else If (Games[I].Winner <> 0) Then
          TmpString := TmpString + ' Perdedor'
        Else
          TmpString := TmpString + ' Indefinido';

        TmpString := TmpString + ' - Soldados: ' + IntToStr(Games[I].Soliders) + ' - ';

        If (Games[I].Difficulty = 1) Then
          TmpString := TmpString + ' Facil'
        Else If (Games[I].Difficulty = 3) Then
          TmpString := TmpString + ' Dificil'
        Else
          TmpString := TmpString + ' Normal';

        ListBox2.Items.Add(TmpString);
      End;
    End;
   End;

end;

procedure TFmStats.btnNewGameMouseLeave(Sender: TObject);
begin
   TPanel(Sender).color:=$00404040;
end;

procedure TFmStats.FormCreate(Sender: TObject);
begin
     backgroundImage := FmLoadBackgroundSpecify('back_wood.bmp');
     FmSetSize(Constraints, 400, 300);
     CUser.Combo(UserBox);
end;

procedure TFmStats.FormDestroy(Sender: TObject); begin backgroundImage.Free; end;

procedure TFmStats.FormPaint(Sender: TObject); begin Canvas.Draw( 0, 0, backgroundImage ); end;

end.
