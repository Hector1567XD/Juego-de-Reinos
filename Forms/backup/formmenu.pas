unit FormMenu;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, FormHelper, MessagesHelper, AuthController;

type

  { TFmMenu }

  TFmMenu = class(TForm)
    btnLogout: TPanel;
    btnNewGame: TPanel;
    btnHouses: TPanel;
    btnNations: TPanel;
    btnGames: TPanel;
    btnConfigs: TPanel;
    btnStats: TPanel;
    btnExit: TPanel;
    imgLogo: TImage;
    lbUsername: TLabel;
    pnUser: TPanel;
    pnMenu: TPanel;
    procedure btnExitClick(Sender: TObject);
    procedure btnHousesClick(Sender: TObject);
    procedure btnLogoutClick(Sender: TObject);
    procedure btnNationsClick(Sender: TObject);
    procedure btnNewGameClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnMouseEnter(Sender: TObject);
    procedure btnMouseLeave(Sender: TObject);
  private

  public
        backgroundImage : TBitmap;
  end;

var
  FmMenu: TFmMenu;

implementation
  uses InitFile;
{$R *.lfm}

{=[TFormMenu]=====================================================================}

{FmFormRegister - EVENTO DE CREACION}
Procedure TFmMenu.FormCreate(Sender: TObject);
Begin

  backgroundImage := FmLoadBackgroundSpecify('back_castle.bmp');
  FmAutoSize(Constraints);

  lbUsername.caption := AppUser.username;

End;

procedure TFmMenu.btnHousesClick(Sender: TObject);
begin
  FormOpen('House');
end;

procedure TFmMenu.btnLogoutClick(Sender: TObject);
begin
  logOutUser();
  FormGoto('MenuToAuth');
end;

procedure TFmMenu.btnExitClick(Sender: TObject);
begin
  logOutUser();
  Application.terminate;
end;

procedure TFmMenu.btnNationsClick(Sender: TObject);
begin
  FormOpen('Nation');
end;

procedure TFmMenu.btnNewGameClick(Sender: TObject);
begin
  FormOpen('GameModes');
end;

{FORM 1 - EVENTO DE DIBUJO}
procedure TFmMenu.FormPaint(Sender: TObject);
begin
   Canvas.Draw( 0, 0, backgroundImage );
end;

{FORM 1 - EVENTO DE DESTRUCCION}
procedure TFmMenu.FormDestroy(Sender: TObject); begin backgroundImage.Free; end;

{=[Btns]=====================================================================}
{btn - MouseEnter}
procedure TFmMenu.btnMouseEnter(Sender: TObject);
begin
   TPanel(Sender).color:=$00555555;
end;
{btn - MouseLeave}
procedure TFmMenu.btnMouseLeave(Sender: TObject);
begin
   TPanel(Sender).color:=$00404040;
end;

end.
