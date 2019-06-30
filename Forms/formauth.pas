unit FormAuth;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, AuthController, ColorBox, Menus
  , InitFile, FormHelper, MessagesHelper;

type
  { TFmAuth }

  TFmAuth = class(TForm)
    btnRegister: TPanel;
    lbError: TLabel;
    txtUserName: TEdit;
    txtPassword: TEdit;
    imgLogo: TImage;
    lbUsername: TLabel;
    lbPassword: TLabel;
    pnAuth: TPanel;
    btnLogin: TPanel;  //Sip... uso un panel como boton por que... por que puedo
    procedure btnMouseEnter(Sender: TObject);
    procedure btnMouseLeave(Sender: TObject);
    procedure btnRegisterClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnLoginClick(Sender: TObject);
    procedure txtKeyPress(Sender: TObject; var Key: char);

  private
    { Declaraciones privadas }

  public
    { Declaraciones publicas }
    backgroundImage : TBitmap;

  end;

var
  FmAuth: TFmAuth;

implementation
uses KeyModel, UserModel;

{$R *.lfm}

{=[TFmAuth]=====================================================================}

{FmAuth - EVENTO DE CREACION}
procedure TFmAuth.FormCreate(Sender: TObject);
var
  User: TUser;
begin

  {Inicializacion formulario generico}
  //Se carga una imagen background
  backgroundImage := FmLoadBackground();
  //Se bloquen los limites de la ventana de modo que no se pueda modificar
  FmAutoSize(Constraints);

  {Inicializacion formulario especifico}
  lbError.Caption := '';
  //Hago que la contraseña tenga este caracter que no es * si no el Chr(149)
  txtPassword.PasswordChar := Chr(149);
  txtPassword.Font.Style := txtPassword.Font.Style + [fsBold];

  {* Detecta si hubo un ultimo usuario logueado, si fue asi deja sus creeds.
   * IDEA: 1. hacer que esto solo sea con el boton de 'recordar usuario'
   *       2. pasar toda esta funcionalidad al AuthController
   *       //lastLogin_rmn serviria para lo primero
   *}

   If (CKey.Get('LastLogin') > 0) Then Begin
      User := CUser.Find(CKey.Get('LastLogin'));
      If (User.Id > 0) Then txtUserName.Text := User.username
      Else MessageError('El id del usuario del "lastLogin" no existe.');
   End;

End;
{FORM 1 - EVENTO DE DIBUJO}
procedure TFmAuth.FormPaint(Sender: TObject);
begin
   Canvas.Draw( 0, 0, backgroundImage );
end;

{FORM 1 - EVENTO DE DESTRUCCION}
procedure TFmAuth.FormDestroy(Sender: TObject); begin backgroundImage.Free; end;

{=[btnLogin]=====================================================================}
{btnLogin - CLICK}
procedure TFmAuth.btnLoginClick(Sender: TObject);
var
  Auth: UserLogg;
begin

   lbError.Caption := '';
   Auth := loginUser(txtUserName.Text,txtPassword.Text);

   if (not Auth.loginIn) then begin
     MessageError(Auth.resText);
     lbError.Caption := Auth.resText;
   end
   else begin
     MessageSuccess(Auth.resText);
     txtUserName.Text := '';
     txtPassword.Text := '';
     CKey.SetKey('LastLogin',Auth.Id);
     FormGoto('AuthToMenu');
   end;

end;
{=[btnRegister]=====================================================================}
{btnRegister - CLICK}
procedure TFmAuth.btnRegisterClick(Sender: TObject);
begin
   FormGoto('AuthToRegister');
end;
{=[Btns]=====================================================================}
{btn - MouseEnter}
procedure TFmAuth.btnMouseEnter(Sender: TObject);
begin
   TPanel(Sender).color:=$00555555;
end;
{btn - MouseLeave}
procedure TFmAuth.btnMouseLeave(Sender: TObject);
begin
   TPanel(Sender).color:=$00404040;
end;

{=[txtAuth]=====================================================================}
{txtAuth - OnKeyPress}
procedure TFmAuth.txtKeyPress(Sender: TObject; var Key: char);
begin
   //Detecta si se pulso ENTER
   if Key = #13 then
      btnLoginClick(Sender);
end;



end.
