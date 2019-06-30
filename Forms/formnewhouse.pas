unit FormNewHouse;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls, FormHelper;

type

  { TFmNewHouse }

  TFmNewHouse = class(TForm)
    btnCreate: TPanel;
    lbError: TLabel;
    LbTitle: TLabel;
    lbNameHouse: TLabel;
    lbLemaOficial: TLabel;
    lbLemaNoOficial: TLabel;
    txtLema: TMemo;
    txtLemaNo: TMemo;
    txtName: TEdit;
    procedure btnCreateClick(Sender: TObject);
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
  FmNewHouse: TFmNewHouse;

implementation
  uses FormHouse, HousesModel;

{$R *.lfm}

{ TFmNewHouse }

{* procedimiento para el registro de una casa *}
function registerHouse(
  var resText: String;
  name, lema, lemano: String
): Boolean;
var
   House, HouseAux: THouse;
Begin

  resText := 'Error indefinido.';
  House   := CHouse.New();

  if ((name = '') or (lema = '') or (lemano = '')) then begin
    resText := 'Rellene los campos para continuar';
    Exit(False);
  end;

  If (Length(name) > 24) then Begin
    resText := 'El Nombre debe tener menos de 24 caracteres';Exit(False);
  End;

  If (Length(name) < 3) then Begin
    resText := 'El Nombre debe tener al menos 3 caracteres';Exit(False);
  End;

  If (Length(lema)  > 64) then Begin
    resText := 'El Lema debe tener menos de 64 caracteres';Exit(False);
  End;

  If (Length(lemano) > 64) then Begin
    resText := 'El Lema no oficial debe tener menos de 64 caracteres';Exit(False);
  End;

  HouseAux := CHouse.FindName(name);
  if (HouseAux.Id <> 0) then begin
    resText := 'El nombre de casa ya existe';Exit(False);
  end;

  House.name       := name;
  House.lema       := lema;
  House.lemano     := lemano;

  CHouse.Store(House);

  Exit(True);
end;

procedure TFmNewHouse.FormCreate(Sender: TObject);
begin
  backgroundImage := FmLoadBackgroundSpecify('back_wood.bmp');
  FmSetSize(Constraints, 400, 300);

  lbError.Caption := '';
  txtName.text := '';
  txtLema.text := '';
  txtLemaNo.text := '';
end;

procedure TFmNewHouse.btnCreateClick(Sender: TObject);
var resText: String;
    response: Boolean;
begin
  lbError.Caption := '';
  response := registerHouse(resText,txtName.text,txtLema.text,txtLemaNo.text);
  If (response = true) then begin
     if Assigned(FmHouses) then ReloadListOfHouses();
     if Assigned(FmNewHouse) then FmNewHouse.Hide;
  end else lbError.Caption := resText;
end;

procedure TFmNewHouse.FormDestroy(Sender: TObject); begin backgroundImage.Free; end;

procedure TFmNewHouse.FormPaint(Sender: TObject); begin Canvas.Draw( 0, 0, backgroundImage ); end;

{=[Btns]=====================================================================}
{btn - MouseEnter}
procedure TFmNewHouse.btnMouseEnter(Sender: TObject);
begin
   TPanel(Sender).color:=$00555555;
end;
{btn - MouseLeave}
procedure TFmNewHouse.btnMouseLeave(Sender: TObject);
begin
   TPanel(Sender).color:=$00404040;
end;

end.
