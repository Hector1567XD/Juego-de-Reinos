unit FormGames;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls, FormHelper;

type

  { TFmGames }

  TFmGames = class(TForm)
    LbTitle: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormPaint(Sender: TObject);
  private

  public
    backgroundImage : TBitmap;

  end;

var
  FmGames: TFmGames;

implementation

{$R *.lfm}

{ TFmGames }

procedure TFmGames.FormCreate(Sender: TObject);
begin
  backgroundImage := FmLoadBackgroundSpecify('back_wood4.bmp');
  FmSetSize(Constraints, 600, 400);

end;
procedure TFmGames.FormDestroy(Sender: TObject); begin backgroundImage.Free; end;
procedure TFmGames.FormPaint(Sender: TObject); begin Canvas.Draw( 0, 0, backgroundImage ); end;

end.
