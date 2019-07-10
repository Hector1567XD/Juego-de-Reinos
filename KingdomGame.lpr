program KingdomGame;

{$mode objfpc}{$H+}

uses

  {<Importacion de unidades>}

  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms,      //Padre de formularios
  InitFile,   //Archivo de inicializacion propio
  //Formularios
  FormAuth, FormNewHouse, FormNation, FormHouse, FormMenu,
  //FormMain,
  //Controladores
  AuthController,

  //Helpers
  FormHelper, FormMovetor, MessagesHelper, ModelParent, KeyModel, FormRegister,
  HousesModel, FormGameModes, FormNGC1vs1, FormAuth2, FormConfigs, GamesModel,
  LogModel, FormGame, GameController, EspiralMove, FormCartas, FormStats
  {</Importacion de unidades>};

{$R *.res}

begin

  //Inicializacion de aplicacion
  IniciarAplicacion();
             //
  RequireDerivedFormResource:=True;
  Application.Initialize;
  //Se crea el primer FORM que se mostrara, el de LOGUEO.
  Application.CreateForm(TFmAuth, FmAuth);
  Application.CreateForm(TFmGame, FmGame);
  Application.CreateForm(TFmCartas, FmCartas);
  Application.CreateForm(TFmStats, FmStats);
  //Application.CreateForm(TFmHouses, FmHouses);
  //Application.CreateForm(TFmNewHouse, FmNewHouse);
  //Application.CreateForm(TFmNation, FmNation);
  //Application.CreateForm(TFmGameModes, FmGameModes);
  //Application.CreateForm(TFmNGC1vs1, FmNGC1vs1);
  //Application.CreateForm(TFmAuth2, FmAuth2);
  //Application.CreateForm(TFmConfigs, FmConfigs);
  //Application.CreateForm(TFmGames, FmGames);
  //Application.CreateForm(TFmFormRegister, FmFormRegister);
  //Application.CreateForm(TFormMenu, FmMenu);
  Application.Run;

end.
