unit FormRegister;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, FormHelper, MessagesHelper, AuthController;

type

  { TFmFormRegister }

  TFmFormRegister = class(TForm)
    btnLogin: TPanel;
    btnRegister: TPanel;
    SelectNation: TComboBox;
    imgLogo: TImage;
    lbError: TLabel;
    lbPassword: TLabel;
    lbUsername: TLabel;
    lbEmail: TLabel;
    lbName: TLabel;
    lbLastName: TLabel;
    lbDate: TLabel;
    lbNation: TLabel;
    pnAuth: TPanel;
    txtPassword: TEdit;
    txtUserName: TEdit;
    txtEmail: TEdit;
    txtName: TEdit;
    txtLastName: TEdit;
    txtDay: TEdit;
    txtMonth: TEdit;
    txtYear: TEdit;
    procedure btnLoginClick(Sender: TObject);
    procedure btnRegisterClick(Sender: TObject);
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
  FmFormRegister: TFmFormRegister;

implementation
uses KeyModel, UserModel, NationModel;

{$R *.lfm}

{=[TFmFormRegister]=====================================================================}

{FmFormRegister - EVENTO DE CREACION}
procedure TFmFormRegister.FormCreate(Sender: TObject);
var
  User: TUser;
begin

  backgroundImage := FmLoadBackground();
  FmAutoSize(Constraints);

  {Inicializacion formulario especifico}
  lbError.Caption := '';

  CNation.Combo(SelectNation);

End;

procedure TFmFormRegister.btnLoginClick(Sender: TObject);
begin
  FormGoto('RegisterToAuth');//
end;

procedure TFmFormRegister.btnRegisterClick(Sender: TObject);
var Reg: Boolean;
    resText: String;
begin

  lbError.Caption := '';

  Reg := registerUser(
    resText,
    txtName.Text,
    txtLastName.Text,
    txtUserName.Text,
    txtPassword.Text,
    txtEmail.Text,
    txtDay.Text,
    txtMonth.Text,
    txtYear.Text,
    SelectNation.Text
  );

  If (Reg = True) Then
    FormGoto('RegisterToAuth');

  lbError.Caption := resText;

end;


{FORM 1 - EVENTO DE DIBUJO}
procedure TFmFormRegister.FormPaint(Sender: TObject);
begin
   Canvas.Draw( 0, 0, backgroundImage );
end;

{FORM 1 - EVENTO DE DESTRUCCION}
procedure TFmFormRegister.FormDestroy(Sender: TObject); begin backgroundImage.Free; end;

{=[Btns]=====================================================================}
{btn - MouseEnter}
procedure TFmFormRegister.btnMouseEnter(Sender: TObject);
begin
   TPanel(Sender).color:=$00555555;
end;
{btn - MouseLeave}
procedure TFmFormRegister.btnMouseLeave(Sender: TObject);
begin
   TPanel(Sender).color:=$00404040;
end;

end.
