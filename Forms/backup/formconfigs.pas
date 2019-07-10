unit FormConfigs;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls, FormHelper;

type

  { TFmConfigs }

  TFmConfigs = class(TForm)
    CbSound: TCheckBox;
    LbSound: TLabel;
    LbTitle: TLabel;
    procedure CbSoundChange(Sender: TObject);
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
  FmConfigs: TFmConfigs;

implementation
uses UserModel;

uses KeyModel, UserModel;

{$R *.lfm}

{ TFmConfigs }

procedure TFmConfigs.FormCreate(Sender: TObject);
begin
  backgroundImage := FmLoadBackgroundSpecify('back_wood.bmp');
  FmSetSize(Constraints, 400, 300);

  If (CKey.Get('Sound') > 0) Then CbSound.Checked := True Else CbSound.Checked := False;
end;

procedure TFmConfigs.CbSoundChange(Sender: TObject);
begin
  If (CbSound.Checked = True) Then
     CKey.SetKey('Sound',1)
  Else
     CKey.SetKey('Sound',0);
end;

procedure TFmConfigs.FormDestroy(Sender: TObject); begin backgroundImage.Free; end;
procedure TFmConfigs.FormPaint(Sender: TObject); begin Canvas.Draw( 0, 0, backgroundImage ); end;

{=[Btns]=====================================================================}
{btn - MouseEnter}
procedure TFmConfigs.btnMouseEnter(Sender: TObject);
begin
   TPanel(Sender).color:=$00555555;
end;
{btn - MouseLeave}
procedure TFmConfigs.btnMouseLeave(Sender: TObject);
begin
   TPanel(Sender).color:=$00404040;
end;

end.
