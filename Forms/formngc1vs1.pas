unit FormNGC1vs1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, FormHelper, MessagesHelper, AuthController, InitFile;

procedure FNGC1v1_setPlayer2(Player: UserLogg);

type

  { TFmNGC1vs1 }

  TFmNGC1vs1 = class(TForm)
    btnNewGame: TPanel;
    btnPlayer2: TPanel;
    btnCards: TPanel;
    ImgTablePlayer: TImage;
    ImgTablePlayer1: TImage;
    LbPlayerName2: TLabel;
    LbSubTitle1: TLabel;
    LbSubTitle2: TLabel;
    LbPlayerName1: TLabel;
    LbSubTitle3: TLabel;
    LbSubTitle4: TLabel;
    LbSubTitle5: TLabel;
    LbSubTitle6: TLabel;
    LbTitle: TLabel;
    LbSubTitle: TLabel;
    LbTitle1: TLabel;
    SelectHouse2: TComboBox;
    SelectSentido: TComboBox;
    SelectLifes: TComboBox;
    SelectSize2: TComboBox;
    SelectSoliders: TComboBox;
    SelectHouse1: TComboBox;
    SelectSize1: TComboBox;
    SelectDificulty: TComboBox;
    procedure btnNewGameClick(Sender: TObject);
    procedure btnPlayer2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure btnMouseEnter(Sender: TObject);
    procedure btnMouseLeave(Sender: TObject);
    procedure ComboOnlySelect(Sender: TObject);
  private

  public
      backgroundImage : TBitmap;
  end;

var
  FmNGC1vs1: TFmNGC1vs1;

implementation
uses HousesModel, GamesModel;

var Player2: UserLogg;
{$R *.lfm}

{ TFmNGC1vs1 }

procedure FNGC1v1_setPlayer2(Player: UserLogg);
begin
  Player2 := Player;

  FmNGC1vs1.btnNewGame.visible      := True;
  FmNGC1vs1.SelectHouse2.visible    := True;
  FmNGC1vs1.ImgTablePlayer1.visible := True;
  FmNGC1vs1.LbPlayerName2.Visible   := True;
  FmNGC1vs1.SelectSize2.Visible     := True;
  FmNGC1vs1.LbPlayerName2.Caption   := Player2.username;

  FmNGC1vs1.btnPlayer2.Caption      := 'Cambiar Jugador 2';
end;

procedure TFmNGC1vs1.FormCreate(Sender: TObject);
begin
  backgroundImage := FmLoadBackgroundSpecify('back_wood3.bmp');
  FmSetSize(Constraints, 760, 400);

  LbPlayerName1.Caption := AppUser.username;

  LbPlayerName2.Caption := '';

  CHouse.Combo(SelectHouse1);
  CHouse.Combo(SelectHouse2);

  btnNewGame.visible := false;
  SelectHouse2.visible := false;
  ImgTablePlayer1.visible := False;
  LbPlayerName2.Visible   := False;
  SelectSize2.Visible     := False;
end;

procedure TFmNGC1vs1.btnPlayer2Click(Sender: TObject);
begin
  FormOpen('Auth2');
end;

Procedure TFmNGC1vs1.btnNewGameClick(Sender: TObject);
Var Soldados: Word;
    Lifes, Size1, Size2, Size, House1, House2, Hard:    Byte;
    HouseName1, HouseName2, Difficulty, Sentido, SizeStr: String;
    Clock: Boolean;
Begin

  Soldados := StrToInt(SelectSoliders.Items[SelectSoliders.ItemIndex]);

  If ((SelectHouse1.ItemIndex = -1) Or (SelectHouse2.ItemIndex = -1))
  Then Begin
    MessageWarning('No puede dejar casas en blanco!'); Exit;
  End;

  HouseName1 := SelectHouse1.Items[SelectHouse1.ItemIndex];
  HouseName2 := SelectHouse2.Items[SelectHouse2.ItemIndex];

  House1 := CHouse.FindName(HouseName1).Id;
  House2 := CHouse.FindName(HouseName2).Id;

  SizeStr := SelectSize1.Items[SelectSize1.ItemIndex];
  Case (SizeStr) Of
    '5x5':   Size1 := 5;
    '6x6':   Size1 := 6;
    '7x7':   Size1 := 7;
    '8x8':   Size1 := 8;
    '9x9':   Size1 := 9;
    '10x10': Size1 := 10;
  End;

  SizeStr := SelectSize2.Items[SelectSize2.ItemIndex];
  Case (SizeStr) Of
    '5x5':   Size2 := 5;
    '6x6':   Size2 := 6;
    '7x7':   Size2 := 7;
    '8x8':   Size2 := 8;
    '9x9':   Size2 := 9;
    '10x10': Size2 := 10;
  End;

  {}
  //Escoje al mayor
  Size := Size1;
  If (Size1 < Size2) Then Size := Size2;
  {}

  Lifes := StrToInt(SelectLifes.Items[SelectLifes.ItemIndex]);

  Hard := 2;
  Difficulty := SelectDificulty.Items[SelectDificulty.ItemIndex];
  Case (Difficulty) Of
    'Facil':        Hard := 1;
    'Normal':       Hard := 2;
    'Dificil':      Hard := 3;
  End;

  Clock := True;
  Sentido := SelectSentido.Items[SelectSentido.ItemIndex];
  Case (Sentido) Of
    'Horario':        Clock := True;
    'Antihorario':    Clock := False;//
  End;

  CGame.NewGame(AppUser.Id,Player2.Id,House1,House2, Size, Lifes, Hard, Soldados, Clock);
  FormOpen('Game');

End;

procedure TFmNGC1vs1.FormDestroy(Sender: TObject); begin backgroundImage.Free; end;

procedure TFmNGC1vs1.FormPaint(Sender: TObject); begin Canvas.Draw( 0, 0, backgroundImage ); end;

{=[Btns]=====================================================================}
{btn - MouseEnter}
procedure TFmNGC1vs1.btnMouseEnter(Sender: TObject);
begin
   TPanel(Sender).color:=$00555555;
end;
{btn - MouseLeave}
procedure TFmNGC1vs1.btnMouseLeave(Sender: TObject);
begin
   TPanel(Sender).color:=$00404040;
end;

procedure TFmNGC1vs1.ComboOnlySelect(Sender: TObject);
begin
  if TComboBox(Sender).ItemIndex = -1 then begin
     TComboBox(Sender).ItemIndex := 0;
  end;
end;

end.
