unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  Buttons, Unit2, Unit3, Globales;

type

  { TInicio }

  TInicio = class(TForm)
    Edit4: TEdit;
    Edit5: TEdit;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    procedure Button2Click(Sender: TObject);
    procedure Edit4Change(Sender: TObject);
    procedure Edit5Change(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure Label1Click(Sender: TObject);
    procedure Label2Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure StaticText1Click(Sender: TObject);
  private

  public

  end;

var
  Inicio: TInicio;
implementation

{$R *.lfm}

{ TInicio }

procedure TInicio.Button2Click(Sender: TObject);
begin

end;

procedure TInicio.Edit4Change(Sender: TObject);
begin
  Label2.Visible := False;
end;

procedure TInicio.Edit5Change(Sender: TObject);
begin
  Label2.Visible := False;
end;

procedure TInicio.FormActivate(Sender: TObject);
var
   ruta, rutaHouse,rutaData: string;
   casa: houses;
begin
getdir(0, ruta);
ruta:= ruta + '/Files/Data';
rutaData:= ruta + '/Users.dat';
rutaHouse:= ruta + '/Houses.dat';

if not(FileExists(rutadata)) then
begin

 MkDir('Files/Data');
 Assignfile(data, rutaData);
 rewrite(data);
 closefile(data);

 Assignfile(House, rutaHouse);
 rewrite(House);

 casa.nombre:= 'Stark';
 casa.LemaOficial:= 'Of        1';
 casa.LemaNoOficial:= 'No      1';
 write(House, casa);

 casa.nombre:= 'Lannister';
 casa.LemaOficial:= 'Of        2';
 casa.LemaNoOficial:= 'No      2';
 write(House, casa);

 casa.nombre:= 'Baratheon';
 casa.LemaOficial:= 'Of        3';
 casa.LemaNoOficial:= 'No      3';
 write(House, casa);

 casa.nombre:= 'Targaryen';
 casa.LemaOficial:= 'Of        4';
 casa.LemaNoOficial:= 'No      4';
 write(House, casa);

 casa.nombre:= 'Greyjoy';
 casa.LemaOficial:= 'Of        5';
 casa.LemaNoOficial:= 'No      5';
 write(House, casa);

 casa.nombre:= 'Tully';
 casa.LemaOficial:= 'Of        6';
 casa.LemaNoOficial:= 'No      6';
 write(House, casa);

 casa.nombre:= 'Tyrell';
 casa.LemaOficial:= 'Of        7';
 casa.LemaNoOficial:= 'No      7';
 write(House, casa);

 closefile(House);
end;
end;



procedure TInicio.FormCreate(Sender: TObject);
begin

end;

procedure TInicio.Image1Click(Sender: TObject);
begin

end;

procedure TInicio.Label1Click(Sender: TObject);
begin
     Registro.ShowModal;
end;

procedure TInicio.Label2Click(Sender: TObject);
begin

end;

procedure TInicio.SpeedButton1Click(Sender: TObject);
begin
   Halt(0);
end;



procedure TInicio.StaticText1Click(Sender: TObject);
begin

end;

procedure TInicio.SpeedButton2Click(Sender: TObject);
begin
guy.username:= Edit4.Caption;
guy.pass:= Edit5.Caption;
if login(guy) Then
  begin
      MainUser.username:= guy.username;
      MenuJuego.Visible:=True;
      Inicio.Visible:=False;
      PorcentajeChance:= 1/10;
  end;
Label2.Visible := True;
end;



end.

