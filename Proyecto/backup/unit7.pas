unit Unit7;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, PopupNotifier,
  StdCtrls, Globales;

type

  { TForm7 }

  TForm7 = class(TForm)
    Label1: TLabel;
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  Form7: TForm7;

implementation

{$R *.lfm}

{ TForm7 }

procedure TForm7.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
end;

procedure TForm7.FormActivate(Sender: TObject);
begin
  Label1.caption:= MensajeChance;
end;

procedure TForm7.FormCreate(Sender: TObject);
begin

end;

end.

