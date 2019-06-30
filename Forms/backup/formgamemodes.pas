unit FormGameModes;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls, FormHelper, messageshelper;

type

  { TFmGameModes }

  TFmGameModes = class(TForm)
    btnNewGame: TPanel;
    LbTitle: TLabel;
    procedure btnNewGameClick(Sender: TObject);
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
  FmGameModes: TFmGameModes;

implementation

{$R *.lfm}

{ TFmGameModes }

procedure TFmGameModes.FormCreate(Sender: TObject);
begin
  backgroundImage := FmLoadBackgroundSpecify('back_wood2.bmp');
  FmSetSize(Constraints, 400, 225);
end;

procedure TFmGameModes.btnNewGameClick(Sender: TObject);
begin

end;

procedure TFmGameModes.FormDestroy(Sender: TObject); begin backgroundImage.Free; end;

procedure TFmGameModes.FormPaint(Sender: TObject); begin Canvas.Draw( 0, 0, backgroundImage ); end;

{=[Btns]=====================================================================}
{btn - MouseEnter}
procedure TFmGameModes.btnMouseEnter(Sender: TObject);
begin
   TPanel(Sender).color:=$00555555;
end;
{btn - MouseLeave}
procedure TFmGameModes.btnMouseLeave(Sender: TObject);
begin
   TPanel(Sender).color:=$00404040;
end;

end.
