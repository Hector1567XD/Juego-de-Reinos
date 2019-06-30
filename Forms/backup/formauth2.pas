unit FormAuth2;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls, FormHelper, AuthController, MessagesHelper;

type

  { TFmAuth2 }

  TFmAuth2 = class(TForm)
    btnLogin: TPanel;
    lbError: TLabel;
    lbPassword: TLabel;
    LbTitle: TLabel;
    lbUsername: TLabel;
    pnAuth: TPanel;
    txtPassword: TEdit;
    txtUserName: TEdit;
    procedure btnLoginClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure btnMouseEnter(Sender: TObject);
    procedure btnMouseLeave(Sender: TObject);
  private

  public
    backgroundImage : TBitmap;
  end;

var
  FmAuth2: TFmAuth2;

implementation
 uses InitFile, FormNGC1vs1;

{$R *.lfm}

{ TFmAuth2 }

procedure TFmAuth2.FormCreate(Sender: TObject);
begin
  backgroundImage := FmLoadBackgroundSpecify('back_wood.bmp');
  FmSetSize(Constraints, 400, 300);

  lbError.Caption := '';
end;

procedure TFmAuth2.btnLoginClick(Sender: TObject);
var UserLogin: UserLogg;
begin
  UserLogin := loginUser2(txtUserName.text, txtPassword.text);
  If (UserLogin.loginIn = False) then
    lbError.Caption := UserLogin.resText;
  else begin
    //Verifico si la sala de nuevo juego para una ronda clasica 1 vs 1 esta activa.
    if Assigned(FmNGC1vs1) then begin
      //Si es asi, entonces uso un procedimineto de dicho formulario para introducir al logueo del jugador 2 dentro del mismo
      FNGC1v1_setPlayer2(UserLogin);
    end;
    MessageSuccess(UserLogin.resText);
    FmAuth2.Hide;
  end;
end;

procedure TFmAuth2.FormDestroy(Sender: TObject); begin backgroundImage.Free; end;

procedure TFmAuth2.FormPaint(Sender: TObject);  begin Canvas.Draw( 0, 0, backgroundImage ); end;

{=[Btns]=====================================================================}
{btn - MouseEnter}
procedure TFmAuth2.btnMouseEnter(Sender: TObject);
begin
   TPanel(Sender).color:=$00555555;
end;
{btn - MouseLeave}
procedure TFmAuth2.btnMouseLeave(Sender: TObject);
begin
   TPanel(Sender).color:=$00404040;
end;


end.
