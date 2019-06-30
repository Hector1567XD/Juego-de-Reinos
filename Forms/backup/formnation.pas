unit FormNation;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls, FormHelper, messageshelper;

type

  { TFmNation }

  TFmNation = class(TForm)
    btnCreate: TPanel;
    btnDelete: TPanel;
    lbError: TLabel;
    LbNationCode: TLabel;
    LbNationNameInput: TLabel;
    LbNationName: TLabel;
    LbNationCodeInput: TLabel;
    LbTitle2: TLabel;
    LbTitle: TLabel;
    ListNations: TListBox;
    txtName: TEdit;
    txtCode: TEdit;
    procedure btnCreateClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure btnMouseEnter(Sender: TObject);
    procedure btnMouseLeave(Sender: TObject);
    procedure ListNationsClick(Sender: TObject);
  private

  public
    backgroundImage : TBitmap;
  end;

var
  FmNation: TFmNation;

implementation

{$R *.lfm}
  uses NationModel;

  { TFmNation }

procedure ReloadListOfNations();
begin

  CNation.List(FmNation.ListNations);
  FmNation.LbNationName.Caption       := '';
  FmNation.LbNationCode.Caption       := '';
  FmNation.txtName.Text               := '';
  FmNation.txtCode.Text               := '';

end;

procedure TFmNation.FormCreate(Sender: TObject);
begin
  backgroundImage := FmLoadBackgroundSpecify('back_wood.bmp');
  FmSetSize(Constraints, 400, 300);

  LbError.Caption       := '';

  ReloadListOfNations();
end;

procedure TFmNation.btnDeleteClick(Sender: TObject);
var
    NationName: String;
    Nation:     TNation;
begin

  if ListNations.ItemIndex = -1 then begin
    MessageWarning('Debe seleccionar un pais.');
    Exit();
  end;

  NationName := ListNations.Items[ListNations.ItemIndex];
  Nation := CNation.FindName(NationName);
  if (Nation.id = 0) then Exit();

  CNation.Delete(Nation.Id);

  ReloadListOfNations();

end;

{* procedimiento para el registro de un pais *}
function registerNation(
  var resText: String;
  name, code: String
): Boolean;
var
   Nation, NationAux: TNation;
Begin

  resText := 'Error indefinido.';
  Nation   := CNation.New();

  if ((name = '') or (code = '')) then begin
    resText := 'Rellene los campos para continuar';Exit(False);
  end;

  If (Length(name) > 16) then Begin
    resText := 'El Nombre debe tener menos de 16 caracteres';Exit(False);
  End;

  If (Length(code) <> 3) then Begin
    resText := 'El Codigo debe tener exactamente 3 caracteres';Exit(False);
  End;

  NationAux := CNation.FindName(name);
  if (NationAux.Id <> 0) then begin
    resText := 'El nombre del pais ya existe';Exit(False);
  end;

  NationAux := CNation.FindCode(code);
  if (NationAux.Id <> 0) then begin
    resText := 'El codigo del pais ya existe';Exit(False);
  end;

  Nation.name       := name;
  Nation.code       := code;

  CNation.Store(Nation);

  Exit(True);
end;

procedure TFmNation.btnCreateClick(Sender: TObject);
var resText: String;
    response: Boolean;
begin
  lbError.Caption := '';
  response := registerNation(resText,txtName.text,txtCode.text);
  If (response = true) then ReloadListOfNations()
  else lbError.Caption := resText;
end;

procedure TFmNation.FormDestroy(Sender: TObject); begin backgroundImage.Free; end;

procedure TFmNation.FormPaint(Sender: TObject); begin Canvas.Draw( 0, 0, backgroundImage ); end;

{=[Btns]=====================================================================}
{btn - MouseEnter}
procedure TFmNation.btnMouseEnter(Sender: TObject);
begin
   TPanel(Sender).color:=$00555555;
end;
{btn - MouseLeave}
procedure TFmNation.btnMouseLeave(Sender: TObject);
begin
   TPanel(Sender).color:=$00404040;
end;

procedure TFmNation.ListNationsClick(Sender: TObject);
var NationName: String;
    Nation:     TNation;
begin

  if ListNations.ItemIndex = -1 then Exit();

  NationName := ListNations.Items[ListNations.ItemIndex];
  Nation := CNation.FindName(NationName);

  if (Nation.id = 0) then Exit();

  LbNationName.Caption            := Nation.name;
  LbNationCode.Caption            := '(' + Nation.code + ')';

end;

end.
