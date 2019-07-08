unit Unit3;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ActnList,
  Menus, Buttons, ExtCtrls, DateTimePicker, Globales;

type


  { TRegistro }

  TRegistro = class(TForm)
    Label17: TLabel;
    pais: TComboBox;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Repetirclave: TEdit;
    Fecha: TDateTimePicker;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    Usuario: TEdit;
    Clave: TEdit;
    Correo: TEdit;
    Nombre: TEdit;
    Apellido: TEdit;
    procedure ApellidoChange(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure ClaveChange(Sender: TObject);
    procedure CorreoChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Label1Click(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure Memo1Change(Sender: TObject);
    procedure NombreChange(Sender: TObject);
    procedure RepetirclaveChange(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure UsuarioChange(Sender: TObject);
    procedure UsuarioChangeBounds(Sender: TObject);
  private

  public

  end;

var
  Registro: TRegistro;
  data: File of player;

implementation

{$R *.lfm}

{ TRegistro }


Function noletras(datos:string): boolean;
 var
  i:integer;
 begin
 noletras:= false;
  for i:= 1 to length(datos) do
    if not((datos[i] >= 'A') and (datos[i] <= 'Z')) then
     noletras:= true;
 end;

Function addplayer(posible:player):boolean;
  var
   i,k: integer;
   guy: player;
   tplayer: array[1..100] of player;
   ruta, rutadata: string;
begin
  getdir(0, ruta);
  ruta:= ruta + '/Files';
  rutaData:= ruta + '/Users.dat';

  Assign(data,rutadata);
  Reset(data);
  i:= 1;
  k:= 0;
  while not EOF(data) do
   begin

    with guy do
     begin
      name:= '';
      surname:= '';
      username:= '';
      pass:= '';
      email:= '';
      birthdate:= '';
      country:= '';
     end;

    Read(data, guy);
    tplayer[i]:= guy;
    Inc(i);
    Inc(k);
   end;
  Close(data);

  with posible do
   begin
    username:= Asegurar(username,1);
    pass:= Asegurar(pass,0);
    surname:= Asegurar(surname,1);
    name:= Asegurar(name,1);
    email:= Asegurar(email,1);
   end;

  addplayer:= false;
  for i:= 1 to k  do
   If tplayer[i].username = posible.username then
    addplayer:= true;

 if not(addplayer) then
  begin
   tplayer[k+1]:= posible;
   Assign(data, rutadata);
   rewrite(data);
   for i:= 1 to (k + 1) do
    write(data, tplayer[i]);
   close(data);
  end;

  addplayer:= not(addplayer);
 end;


procedure TRegistro.Button1Click(Sender: TObject);
begin


end;

procedure TRegistro.ApellidoChange(Sender: TObject);
begin
  label14.visible:= false;
end;

procedure TRegistro.ClaveChange(Sender: TObject);
begin
  label11.visible:= false;
  label17.visible:= false;
end;

procedure TRegistro.CorreoChange(Sender: TObject);
begin
  label15.visible:= false;
end;

procedure TRegistro.FormCreate(Sender: TObject);
begin

end;

procedure TRegistro.Label1Click(Sender: TObject);
begin

end;

procedure TRegistro.ListBox1Click(Sender: TObject);
begin

end;

procedure TRegistro.Memo1Change(Sender: TObject);
begin

end;

procedure TRegistro.NombreChange(Sender: TObject);
begin
  label13.visible:= false;
end;

procedure TRegistro.RepetirclaveChange(Sender: TObject);
begin
  label12.visible:= false;
  label17.visible:= false;
end;

procedure TRegistro.SpeedButton1Click(Sender: TObject);
begin
  label10.visible:= false;
  label11.visible:= false;
  label12.visible:= false;
  label13.visible:= false;
  label14.visible:= false;
  label15.visible:= false;
  label16.visible:= false;
  label17.visible:= false;

  if (usuario.Caption = '') or (length(usuario.Caption) < 2) then
   label10.visible:= true;
  if (Clave.Caption = '') or (length(Clave.Caption) < 5) then
   label11.visible:= true;
  if (Repetirclave.Caption = '') or (length(Repetirclave.Caption) < 5) then
   label12.visible:= true;
  if (nombre.Caption = '') or (length(nombre.Caption) < 2) or noletras(nombre.Caption) then
   label13.visible:= true;
  if (apellido.Caption = '') or (length(apellido.Caption) < 2) or noletras(apellido.Caption) then
   label14.visible:= true;
  if (correo.Caption = '') then
   label15.visible:= true;

  if (not(label11.visible or label12.visible)) and not(Clave.Caption = Repetirclave.Caption) then
    label17.visible:= true
  else
   if not(label10.visible or label11.visible or label12.visible or label13.visible or label14.visible or label15.visible) then
    if (Clave.Caption = Repetirclave.Caption) then
     Begin
      guy.username:= usuario.Caption;
      guy.pass:= Clave.Caption;
      guy.name:= nombre.Caption;
      guy.surname:= apellido.Caption;
      guy.email:= correo.Caption;
      guy.birthdate:= DateTimeToStr(fecha.Date);
      guy.country:= pais.Text;

      if addplayer(guy) then
       begin
        Registro.Close;
        ShowMessage('Usuario agregado: ' + guy.username);
       end
      else
       label16.visible:= true;

     end;

end;

procedure TRegistro.SpeedButton2Click(Sender: TObject);
begin
  Registro.Close;
end;

procedure TRegistro.UsuarioChange(Sender: TObject);
begin
  label10.visible:= false;
  label16.visible:= false;
end;



procedure TRegistro.UsuarioChangeBounds(Sender: TObject);
begin

end;

end.

