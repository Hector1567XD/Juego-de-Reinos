unit unit6;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  Buttons, Unit3, Globales;

type

  { TInicioRetador }

  TInicioRetador = class(TForm)
    CheckGroup3: TCheckGroup;
    Clave: TEdit;
    ComboCasas: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;
    RadioButton4: TRadioButton;
    RadioButton5: TRadioButton;
    RadioButton6: TRadioButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    Usuario: TEdit;
    procedure CheckGroup3ChangeBounds(Sender: TObject);
    procedure CheckGroup3Click(Sender: TObject);
    procedure ClaveChange(Sender: TObject);
    procedure ComboCasasChange(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Label3Click(Sender: TObject);
    procedure Label4Click(Sender: TObject);
    procedure Label6Click(Sender: TObject);
    procedure RadioButton1Change(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure UsuarioChange(Sender: TObject);
  private

  public

  end;

var
  InicioRetador: TInicioRetador;

implementation

{$R *.lfm}

{ TInicioRetador }

procedure TInicioRetador.FormCreate(Sender: TObject);
begin

end;

procedure TInicioRetador.FormActivate(Sender: TObject);
var
  i: integer;
begin
  LeerCasas();
  ComboCasas.Items.Clear;
  for i:= 1 to TotalCasas do
   if VectorCasa[i].Nombre <> MainUser.casa then
    ComboCasas.Items.Add(VectorCasa[i].Nombre);

  if SecondUser.casa <> '' then
   ComboCasas.text:= SecondUser.casa
  else
   ComboCasas.itemindex:= 0;

end;

procedure TInicioRetador.ComboCasasChange(Sender: TObject);
begin
end;

procedure TInicioRetador.CheckGroup3ChangeBounds(Sender: TObject);
begin
end;

procedure TInicioRetador.CheckGroup3Click(Sender: TObject);
begin

end;

procedure TInicioRetador.ClaveChange(Sender: TObject);
begin

end;

procedure TInicioRetador.Label3Click(Sender: TObject);
begin
  Registro.ShowModal;
end;

procedure TInicioRetador.Label4Click(Sender: TObject);
begin

end;

procedure TInicioRetador.Label6Click(Sender: TObject);
begin

end;

procedure TInicioRetador.RadioButton1Change(Sender: TObject);
begin
end;

procedure TInicioRetador.SpeedButton2Click(Sender: TObject);
var
  guy:player;
begin

  label4.Visible:= false;

  guy.username:= Usuario.Caption;
  guy.pass:= Clave.Caption;

  if not(login(guy) and (guy.username <> MainUser.username)) then
   label4.Visible:= true;

  if not(label4.Visible) Then
     begin
       SecondUser.username:= guy;
       SecondUser.casa:= ComboCasas.text;

       InicioRetador.Close;
     end;
end;

procedure TInicioRetador.SpeedButton3Click(Sender: TObject);
begin
  InicioRetador.Close;
end;

procedure TInicioRetador.UsuarioChange(Sender: TObject);
begin
  label4.Visible:= false;
end;

end.

