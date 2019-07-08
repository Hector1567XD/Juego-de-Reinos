unit Unit4;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  Buttons, ComCtrls, Globales;

type

  { TConfiguraciones }

  TConfiguraciones = class(TForm)
    Edit1: TEdit;
    Edit10: TEdit;
    Edit11: TEdit;
    Edit12: TEdit;
    Edit13: TEdit;
    Edit14: TEdit;
    Edit15: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    Edit7: TEdit;
    Edit8: TEdit;
    Edit9: TEdit;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RadioGroup1: TRadioGroup;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    TrackBar1: TTrackBar;
    procedure Edit16Change(Sender: TObject);
    procedure Edit17Change(Sender: TObject);
    procedure Edit17EditingDone(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ScrollBox1Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
  private

  public

  end;

var
  Configuraciones: TConfiguraciones;

implementation

{$R *.lfm}

{ TConfiguraciones }

Function solonumeros(datos:string): boolean;
 var
  i:integer;
 begin
 solonumeros:= true;
  for i:= 1 to length(datos) do
    if not((datos[i] >= '0') and (datos[i] <= '9')) then
     solonumeros:= false;
 end;

procedure TConfiguraciones.FormCreate(Sender: TObject);
begin

end;

procedure TConfiguraciones.ScrollBox1Click(Sender: TObject);
begin

end;

procedure TConfiguraciones.SpeedButton1Click(Sender: TObject);
Var
  pos,i: integer;
  ruta, rutaHouse, rutaImageneCasa: string;

 begin
 getdir(0, ruta);
 rutaHouse:= ruta + '/Files/Data/Houses.dat';

  pos:=8;

  if (Edit1.Caption <>'') then
      begin
           VectorCasa[pos].Nombre:= Edit1.Caption;
           VectorCasa[pos].LemaOficial:= Edit6.Caption;
           VectorCasa[pos].LemaNoOficial:= Edit11.Caption;
           inc(pos);
      end;

    if (Edit2.Caption <>'') then
      begin
           VectorCasa[pos].Nombre:= Edit2.Caption;
           VectorCasa[pos].LemaOficial:= Edit7.Caption;
           VectorCasa[pos].LemaNoOficial:= Edit12.Caption;
           inc(pos);
      end;
    if (Edit3.Caption <>'') then
      begin
           VectorCasa[pos].Nombre:= Edit3.Caption;
           VectorCasa[pos].LemaOficial:= Edit8.Caption;
           VectorCasa[pos].LemaNoOficial:= Edit13.Caption;
           inc(pos);
      end;
      if (Edit4.Caption <> '') then
      begin
           VectorCasa[pos].Nombre:= Edit4.Caption;
           VectorCasa[pos].LemaOficial:= Edit9.Caption;
           VectorCasa[pos].LemaNoOficial:= Edit14.Caption;
           inc(pos);
      end;

    if (Edit5.Caption <>'') then
      begin
           VectorCasa[pos].Nombre:= Edit5.Caption;
           VectorCasa[pos].LemaOficial:= Edit10.Caption;
           VectorCasa[pos].LemaNoOficial:= Edit15.Caption;
           inc(pos);
      end;

    Assignfile(House, rutaHouse);
    rewrite(House);

    for i:=1 to (pos-1) do
     write(House,VectorCasa[i]);

    closefile(House);

    PorcentajeChance:= TrackBar1.Position/100;

    Configuraciones.Close;
end;

procedure TConfiguraciones.SpeedButton2Click(Sender: TObject);
begin
  Configuraciones.Close;
end;

procedure TConfiguraciones.Edit1Change(Sender: TObject);
begin

end;

procedure TConfiguraciones.FormActivate(Sender: TObject);
var
  i: integer;
begin
  LeerCasas();

  Edit1.caption:= '';
  Edit2.caption:= '';
  Edit3.caption:= '';
  Edit4.caption:= '';
  Edit5.caption:= '';
  Edit6.caption:= '';
  Edit7.caption:= '';
  Edit8.caption:= '';
  Edit9.caption:= '';
  Edit10.caption:= '';
  Edit11.caption:= '';
  Edit12.caption:= '';
  Edit13.caption:= '';
  Edit14.caption:= '';
  Edit15.caption:= '';

  if TotalCasas > 7 then
    begin
         Edit1.Caption:= VectorCasa[8].Nombre;
         Edit6.Caption:= VectorCasa[8].LemaOficial;
         Edit11.Caption:= VectorCasa[8].LemaNoOficial;
    end;

  if TotalCasas > 8 then
    begin
         Edit2.Caption:= VectorCasa[9].Nombre;
         Edit7.Caption:= VectorCasa[9].LemaOficial;
         Edit12.Caption:= VectorCasa[9].LemaNoOficial;
    end;

  if TotalCasas > 9 then
    begin
         Edit3.Caption:= VectorCasa[10].Nombre;
         Edit8.Caption:= VectorCasa[10].LemaOficial;
         Edit13.Caption:= VectorCasa[10].LemaNoOficial;
    end;

  if TotalCasas > 10 then
    begin
         Edit4.Caption:= VectorCasa[11].Nombre;
         Edit9.Caption:= VectorCasa[11].LemaOficial;
         Edit14.Caption:= VectorCasa[11].LemaNoOficial;
    end;

  if TotalCasas > 11 then
    begin
         Edit5.Caption:= VectorCasa[12].Nombre;
         Edit10.Caption:= VectorCasa[12].LemaOficial;
         Edit15.Caption:= VectorCasa[12].LemaNoOficial;
    end;

end;

procedure TConfiguraciones.Edit16Change(Sender: TObject);
begin
end;

procedure TConfiguraciones.Edit17Change(Sender: TObject);
begin

end;

procedure TConfiguraciones.Edit17EditingDone(Sender: TObject);
begin
end;

end.

