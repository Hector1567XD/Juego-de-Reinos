unit FormMovetor;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils,
  Forms, FormAuth, FormRegister, FormMenu, FormHouse,
  FormNewHouse, FormNation, FormGameModes, FormNGC1vs1,
  FormAuth2, FormConfigs, FormGames,
  InitFile;

procedure MRegisterToAuth();
procedure MAuthToRegister();
procedure MAuthToMenu();
procedure MMenuToAuth();
procedure MOpenHouse();
procedure MOpenHouseNew();
procedure MOpenNation();
procedure MOpenGameModes();
procedure MGameModesToNGC1v1();
procedure MOpenAuth2();
procedure MOpenConfigs();
procedure MOpenGames();

implementation

procedure MRegisterToAuth();
begin
  if Assigned(FmAuth) then
     FmAuth.Destroy;

   Application.CreateForm(TFmAuth, FmAuth);
   FmFormRegister.Hide;
   FmAuth.Show;
end;

procedure MAuthToRegister();
begin
   if Assigned(FmFormRegister) then
      FmFormRegister.Destroy;

   Application.CreateForm(TFmFormRegister, FmFormRegister);
   FmAuth.Hide;
   FmFormRegister.Show;
end;

procedure MAuthToMenu();
begin
   if Assigned(FmMenu) then
      FmMenu.Destroy;

   Application.CreateForm(TFmMenu, FmMenu);
   FmAuth.Hide;
   FmMenu.Show;
end;

procedure MMenuToAuth();
begin
   if Assigned(FmAuth) then
      FmAuth.Destroy;

   Application.CreateForm(TFmAuth, FmAuth);
   FmMenu.Hide;
   FmAuth.Show;
end;

procedure MOpenHouse();
begin
   if Assigned(FmHouses) then
      FmHouses.Destroy;

   Application.CreateForm(TFmHouses, FmHouses);
   FmHouses.Show;
end;

procedure MOpenHouseNew();
begin
   if Assigned(FmNewHouse) then
      FmNewHouse.Destroy;

   Application.CreateForm(TFmNewHouse, FmNewHouse);
   FmNewHouse.Show;
end;

procedure MOpenNation();
begin
   if Assigned(FmNation) then
      FmNation.Destroy;

   Application.CreateForm(TFmNation, FmNation);
   FmNation.Show;
end;

procedure MOpenGameModes();
begin
   if Assigned(FmGameModes) then
      FmGameModes.Destroy;

   Application.CreateForm(TFmGameModes, FmGameModes);
   FmGameModes.Show;
end;

procedure MGameModesToNGC1v1();
begin
   if Assigned(FmNGC1vs1) then
      FmNGC1vs1.Destroy;

   Application.CreateForm(TFmNGC1vs1, FmNGC1vs1);
   FmGameModes.Hide;
   FmNGC1vs1.Show;
end;

procedure MOpenAuth2();
begin
   if Assigned(FmAuth2) then
      FmAuth2.Destroy;

   Application.CreateForm(TFmAuth2, FmAuth2);
   FmAuth2.Show;
end;

procedure MOpenConfigs();
begin
   if Assigned(FmConfigs) then
      FmConfigs.Destroy;

   Application.CreateForm(TFmConfigs, FmConfigs);
   FmConfigs.Show;
end;

procedure MOpenGames();
begin
   if Assigned(FmGames) then
      FmGames.Destroy;

   Application.CreateForm(TFmGames, FmGames);
   FmGames.Show;
end;


end.
