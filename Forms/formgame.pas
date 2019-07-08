unit FormGame;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls, FormHelper, AuthController, MessagesHelper, GameController;

type
  { TFmGame }

  TFmGame = class(TForm)
    Board: TImage;
    BtnDice1: TImage;
    BtnDice2: TImage;
    Dice1: TImage;
    Dice2: TImage;
    Heart2_5: TImage;
    Heart1_2: TImage;
    Heart1_3: TImage;
    Heart1_4: TImage;
    Heart1_5: TImage;
    Heart2_1: TImage;
    Heart2_2: TImage;
    Heart2_3: TImage;
    Heart2_4: TImage;
    Image1: TImage;
    Heart1_1: TImage;
    Image2: TImage;
    ImCastle: TImage;
    ImPlayer1: TImage;
    ImPlayer2: TImage;
    LbS100: TLabel;
    LbS61: TLabel;
    LbS1: TLabel;
    LbS10: TLabel;
    LbS11: TLabel;
    LbS12: TLabel;
    LbS13: TLabel;
    LbS14: TLabel;
    LbS15: TLabel;
    LbS16: TLabel;
    LbS17: TLabel;
    LbS18: TLabel;
    LbS19: TLabel;
    LbS2: TLabel;
    LbS20: TLabel;
    LbS21: TLabel;
    LbS22: TLabel;
    LbS23: TLabel;
    LbS24: TLabel;
    LbS25: TLabel;
    LbS26: TLabel;
    LbS27: TLabel;
    LbS28: TLabel;
    LbS29: TLabel;
    LbS3: TLabel;
    LbS30: TLabel;
    LbS31: TLabel;
    LbS32: TLabel;
    LbS33: TLabel;
    LbS34: TLabel;
    LbS35: TLabel;
    LbS36: TLabel;
    LbS37: TLabel;
    LbS38: TLabel;
    LbS39: TLabel;
    LbS4: TLabel;
    LbS40: TLabel;
    LbS41: TLabel;
    LbS42: TLabel;
    LbS43: TLabel;
    LbS44: TLabel;
    LbS45: TLabel;
    LbS46: TLabel;
    LbS47: TLabel;
    LbS48: TLabel;
    LbS49: TLabel;
    LbS5: TLabel;
    LbS50: TLabel;
    LbS51: TLabel;
    LbS52: TLabel;
    LbS53: TLabel;
    LbS54: TLabel;
    LbS55: TLabel;
    LbS56: TLabel;
    LbS57: TLabel;
    LbS58: TLabel;
    LbS59: TLabel;
    LbS6: TLabel;
    LbS60: TLabel;
    LbS62: TLabel;
    LbS63: TLabel;
    LbS64: TLabel;
    LbS65: TLabel;
    LbS66: TLabel;
    LbS67: TLabel;
    LbS68: TLabel;
    LbS69: TLabel;
    LbS7: TLabel;
    LbS70: TLabel;
    LbS71: TLabel;
    LbS72: TLabel;
    LbS73: TLabel;
    LbS74: TLabel;
    LbS75: TLabel;
    LbS76: TLabel;
    LbS77: TLabel;
    LbS78: TLabel;
    LbS79: TLabel;
    LbS8: TLabel;
    LbS80: TLabel;
    LbS81: TLabel;
    LbS82: TLabel;
    LbS83: TLabel;
    LbS84: TLabel;
    LbS85: TLabel;
    LbS86: TLabel;
    LbS87: TLabel;
    LbS88: TLabel;
    LbS89: TLabel;
    LbS9: TLabel;
    LbS90: TLabel;
    LbS91: TLabel;
    LbS92: TLabel;
    LbS93: TLabel;
    LbS94: TLabel;
    LbS95: TLabel;
    LbS96: TLabel;
    LbS97: TLabel;
    LbS98: TLabel;
    LbS99: TLabel;
    LbSoliders2: TLabel;
    LbHouse2: TLabel;
    LbName1: TLabel;
    LbHouse1: TLabel;
    LbName2: TLabel;
    LbText: TLabel;
    LbSoliders1: TLabel;
    LbText1: TLabel;
    PnLife1: TPanel;
    PnLife2: TPanel;
    Section_10_10: TImage;
    Section_10_2: TImage;
    Section_10_3: TImage;
    Section_10_4: TImage;
    Section_10_5: TImage;
    Section_10_6: TImage;
    Section_10_7: TImage;
    Section_10_8: TImage;
    Section_10_9: TImage;
    Section_1_1: TImage;
    Panel1: TPanel;
    Section_1_10: TImage;
    Section_2_1: TImage;
    Section_1_2: TImage;
    Section_1_3: TImage;
    Section_1_4: TImage;
    Section_1_5: TImage;
    Section_1_6: TImage;
    Section_1_7: TImage;
    Section_1_8: TImage;
    Section_1_9: TImage;
    Section_2_10: TImage;
    Section_3_1: TImage;
    Section_2_2: TImage;
    Section_2_3: TImage;
    Section_2_4: TImage;
    Section_2_5: TImage;
    Section_2_6: TImage;
    Section_2_7: TImage;
    Section_2_8: TImage;
    Section_2_9: TImage;
    Section_3_10: TImage;
    Section_4_1: TImage;
    Section_3_2: TImage;
    Section_3_3: TImage;
    Section_3_4: TImage;
    Section_3_5: TImage;
    Section_3_6: TImage;
    Section_3_7: TImage;
    Section_3_8: TImage;
    Section_3_9: TImage;
    Section_4_10: TImage;
    Section_5_1: TImage;
    Section_4_2: TImage;
    Section_4_3: TImage;
    Section_4_4: TImage;
    Section_4_5: TImage;
    Section_4_6: TImage;
    Section_4_7: TImage;
    Section_4_8: TImage;
    Section_4_9: TImage;
    Section_5_10: TImage;
    Section_6_1: TImage;
    Section_5_2: TImage;
    Section_5_3: TImage;
    Section_5_4: TImage;
    Section_5_5: TImage;
    Section_5_6: TImage;
    Section_5_7: TImage;
    Section_5_8: TImage;
    Section_5_9: TImage;
    Section_6_10: TImage;
    Section_7_1: TImage;
    Section_6_2: TImage;
    Section_6_3: TImage;
    Section_6_4: TImage;
    Section_6_5: TImage;
    Section_6_6: TImage;
    Section_6_7: TImage;
    Section_6_8: TImage;
    Section_6_9: TImage;
    Section_7_10: TImage;
    Section_8_1: TImage;
    Section_7_2: TImage;
    Section_7_3: TImage;
    Section_7_4: TImage;
    Section_7_5: TImage;
    Section_7_6: TImage;
    Section_7_7: TImage;
    Section_7_8: TImage;
    Section_7_9: TImage;
    Section_8_10: TImage;
    Section_9_1: TImage;
    Section_8_2: TImage;
    Section_8_3: TImage;
    Section_8_4: TImage;
    Section_8_5: TImage;
    Section_8_6: TImage;
    Section_8_7: TImage;
    Section_8_8: TImage;
    Section_8_9: TImage;
    Section_9_10: TImage;
    Section_10_1: TImage;
    Section_9_2: TImage;
    Section_9_3: TImage;
    Section_9_4: TImage;
    Section_9_5: TImage;
    Section_9_6: TImage;
    Section_9_7: TImage;
    Section_9_8: TImage;
    Section_9_9: TImage;
    procedure BtnDice1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure btnDiceMouseEnter(Sender: TObject);
    procedure btnDiceMouseLeave(Sender: TObject);
  private

  public
        backgroundImage : TBitmap;
  end;

var
  FmGame: TFmGame;
  Sections: TSections;
  Dices:    TDices;

implementation
uses InitFile;
{$R *.lfm}

{ TFmGame }

procedure TFmGame.FormDestroy(Sender: TObject); begin backgroundImage.Free; end;

procedure TFmGame.FormPaint(Sender: TObject);  begin Canvas.Draw( 0, 0, backgroundImage ); end;

procedure TFmGame.FormCreate(Sender: TObject);
Var I,J,ValLabel: Byte;
begin
     backgroundImage := FmLoadBackgroundSpecify('back_game.bmp');
     FmSetSize(Constraints, 1000, 675);

     Panel1.ControlStyle    := Panel1.ControlStyle - [csOpaque] + [csParentBackground];
     PnLife1.ControlStyle   := PnLife1.ControlStyle - [csOpaque] + [csParentBackground];
     PnLife2.ControlStyle   := PnLife2.ControlStyle - [csOpaque] + [csParentBackground];

     For I := 1 To 10 Do
         For J := 1 To 10 Do Begin
             Sections[I,J].Image := TImage(FindComponent('Section_' + IntToStr(I) + '_' + IntToStr(J)));
             ValLabel := ((I-1)*10)+J;
             Sections[I,J].LLabel := TLabel(FindComponent('LbS' + IntToStr(ValLabel)));
             Sections[I,J].LLabel.Visible := False;
             Sections[I,J].LLabel.Top   := Sections[I,J].LLabel.Top + 4;
             Sections[I,J].LLabel.Left  := Sections[I,J].LLabel.Left + 4;
             //Sections[I,J].LLabel.Font.Color := clWhite;
         End;

     Dices[1].Image   := Dice1;
     Dices[1].Button  := BtnDice1;

     Dices[2].Image   := Dice2;
     Dices[2].Button  := BtnDice2;

     GPlayers[1].Image := ImPlayer1;
     GPlayers[1].X := 1;
     GPlayers[1].Y := 1;
     GPlayers[1].Pos := 1;
     GPlayers[1].LbName     := LbName1;
     GPlayers[1].LbHouse    := LbHouse1;
     GPlayers[1].LbSoliders := LbSoliders1;

     For I := 1 To 5 Do
      GPlayers[1].Hearts[I].Image := TImage(FindComponent('Heart1_' + IntToStr(I)));

     GPlayers[2].Image := ImPlayer2;
     GPlayers[2].X := 1;
     GPlayers[2].Y := 1;
     GPlayers[2].Pos := 1;
     GPlayers[2].LbName     := LbName2;
     GPlayers[2].LbHouse    := LbHouse2;
     GPlayers[2].LbSoliders := LbSoliders2;

     For I := 1 To 5 Do
      GPlayers[2].Hearts[I].Image := TImage(FindComponent('Heart2_' + IntToStr(I)));

     Castle.Image := ImCastle;
     newGame();
end;

procedure TFmGame.BtnDice1Click(Sender: TObject);
Var DiceIndex, ValDado: Byte;
begin

   DiceIndex := 1;
   If (TImage(Sender).Name = 'BtnDice2') Then DiceIndex := 2;

   If (Dices[DiceIndex].Active) Then Begin
    ValDado := DadoGatch(DiceIndex);//No hago nada con 'ValDado' pero como es una funcion a algun lugar tuvo que parar
    TurnProcess();
   End;

end;

{=[Btns]=====================================================================}
{btnDice - MouseEnter}
procedure TFmGame.btnDiceMouseEnter(Sender: TObject);
Var DiceIndex: Byte;
begin

   DiceIndex := 1;
   If (TImage(Sender).Name = 'BtnDice2') Then DiceIndex := 2;

   If (Dices[DiceIndex].Active) Then
    TImage(Sender).Picture.LoadFromFile(aPPPath + '/images/buttons/dice_'+IntToStr(DiceIndex)+'_hover.png');

end;
{btnDice - MouseLeave}
procedure TFmGame.btnDiceMouseLeave(Sender: TObject);
Var DiceIndex: Byte;
begin

   DiceIndex := 1;
   If (TImage(Sender).Name = 'BtnDice2') Then DiceIndex := 2;

   If (Dices[DiceIndex].Active) Then
    TImage(Sender).Picture.LoadFromFile(aPPPath + '/images/buttons/dice_'+IntToStr(DiceIndex)+'.png');

end;

end.
