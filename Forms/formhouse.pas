unit FormHouse;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls, FormHelper, messageshelper;

procedure ReloadListOfHouses();

type

  { TFmHouses }

  TFmHouses = class(TForm)
    btnCreate: TPanel;
    btnDelete: TPanel;
    LbHomeName: TLabel;
    LbHomeLema: TLabel;
    LbHomeLemaNoOficial: TLabel;
    LbTitle: TLabel;
    ListHouses: TListBox;
    txtLemaOficial: TMemo;
    txtLemaNoOficial: TMemo;
    procedure btnCreateClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure ListHousesClick(Sender: TObject);
    procedure btnMouseEnter(Sender: TObject);
    procedure btnMouseLeave(Sender: TObject);
  private

  public
    backgroundImage : TBitmap;
  end;

var
  FmHouses: TFmHouses;

implementation
{$R *.lfm}
  uses HousesModel;

{ TFmHouses }

procedure TFmHouses.ListHousesClick(Sender: TObject);
var HouseName: String;
    House:     THouse;
begin

  if ListHouses.ItemIndex = -1 then Exit();

  HouseName := ListHouses.Items[ListHouses.ItemIndex];
  House := CHouse.FindName(HouseName);

  if (House.id = 0) then Exit();

  LbHomeName.Caption            := House.name;
  txtLemaOficial.Text           := House.lema;
  txtLemaNoOficial.Text         := House.lemano;

end;

procedure ReloadListOfHouses();
begin

  CHouse.List(FmHouses.ListHouses);
  FmHouses.LbHomeName.Caption      := '';
  FmHouses.txtLemaOficial.Text     := '';
  FmHouses.txtLemaNoOficial.Text   := '';

end;

procedure TFmHouses.FormCreate(Sender: TObject);
begin
  backgroundImage := FmLoadBackgroundSpecify('back_wood.bmp');
  FmSetSize(Constraints, 400, 300);

  ReloadListOfHouses();
end;

procedure TFmHouses.btnDeleteClick(Sender: TObject);
var
    HouseName: String;
    House:     THouse;
begin

  if ListHouses.ItemIndex = -1 then begin
    MessageWarning('Debe seleccionar una casa.');
    Exit();
  end;

  HouseName := ListHouses.Items[ListHouses.ItemIndex];
  House := CHouse.FindName(HouseName);
  if (House.id = 0) then Exit();

  if (House.system = True) then Begin
    MessageWarning('No puedes borrar casas del sistema.');
    Exit();
  End;

  CHouse.Delete(House.Id);

  ReloadListOfHouses();

end;

procedure TFmHouses.btnCreateClick(Sender: TObject);
begin
  FormOpen('HouseNew');
end;

procedure TFmHouses.FormDestroy(Sender: TObject); begin backgroundImage.Free; end;
procedure TFmHouses.FormPaint(Sender: TObject); begin Canvas.Draw( 0, 0, backgroundImage ); end;

{=[Btns]=====================================================================}
{btn - MouseEnter}
procedure TFmHouses.btnMouseEnter(Sender: TObject);
begin
   TPanel(Sender).color:=$00555555;
end;
{btn - MouseLeave}
procedure TFmHouses.btnMouseLeave(Sender: TObject);
begin
   TPanel(Sender).color:=$00404040;
end;

end.
