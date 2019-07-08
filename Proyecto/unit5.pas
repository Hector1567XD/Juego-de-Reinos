unit Unit5;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  Buttons, ComCtrls, Globales, Unit6, Unit8;

type

  { TParametrosPartida }

  TParametrosPartida = class(TForm)
    CheckBox1: TCheckBox;
    CheckBox10: TCheckBox;
    CheckBox11: TCheckBox;
    CheckBox12: TCheckBox;
    CheckBox13: TCheckBox;
    CheckBox14: TCheckBox;
    CheckBox15: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    CheckBox5: TCheckBox;
    CheckBox6: TCheckBox;
    CheckBox7: TCheckBox;
    CheckBox9: TCheckBox;
    CheckGroup1: TCheckGroup;
    CheckGroup2: TCheckGroup;
    CheckGroup3: TCheckGroup;
    ComboCasas: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    RadioButton1: TRadioButton;
    RadioButton10: TRadioButton;
    RadioButton11: TRadioButton;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;
    RadioButton4: TRadioButton;
    RadioButton5: TRadioButton;
    RadioButton6: TRadioButton;
    RadioButton7: TRadioButton;
    RadioButton8: TRadioButton;
    RadioButton9: TRadioButton;
    RadioGroup1: TRadioGroup;
    RadioGroup2: TRadioGroup;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    TrackBar1: TTrackBar;
    procedure CheckBox14Change(Sender: TObject);
    procedure CheckBox1Change(Sender: TObject);
    procedure CheckBox2Change(Sender: TObject);
    procedure CheckGroup1Click(Sender: TObject);
    procedure CheckGroup3Click(Sender: TObject);
    procedure ComboCasasChange(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure Label2Click(Sender: TObject);
    procedure Label4Click(Sender: TObject);
    procedure RadioButton1Change(Sender: TObject);
    procedure RadioButton6Change(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
  private

  public

  end;

var
  ParametrosPartida: TParametrosPartida;

implementation

{$R *.lfm}

{ TParametrosPartida }

procedure TParametrosPartida.CheckGroup1Click(Sender: TObject);
begin

end;

procedure TParametrosPartida.CheckGroup3Click(Sender: TObject);
begin

end;

procedure TParametrosPartida.ComboCasasChange(Sender: TObject);
begin

end;

procedure TParametrosPartida.FormActivate(Sender: TObject);
var
  i:integer;
begin
  LeerCasas();
  SecondUser.username:= '';
  ComboCasas.Items.Clear;
  for i:= 1 to TotalCasas do
   if VectorCasa[i].Nombre <> SecondUser.casa then
    ComboCasas.Items.Add(VectorCasa[i].Nombre);
   ComboCasas.itemindex:= 0;

end;

procedure TParametrosPartida.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  Halt(0);
end;

procedure TParametrosPartida.FormCreate(Sender: TObject);
begin

end;

procedure TParametrosPartida.Label2Click(Sender: TObject);
begin

end;

procedure TParametrosPartida.Label4Click(Sender: TObject);
begin

end;

procedure TParametrosPartida.RadioButton1Change(Sender: TObject);
begin
end;

procedure TParametrosPartida.RadioButton6Change(Sender: TObject);
begin
end;

procedure TParametrosPartida.SpeedButton1Click(Sender: TObject);
var
  i: integer;
begin
  MainUser.casa:= ComboCasas.text;

  InicioRetador.ShowModal;

  ComboCasas.Items.Clear;
  for i:= 1 to TotalCasas do
   if VectorCasa[i].Nombre <> SecondUser.casa then
    ComboCasas.Items.Add(VectorCasa[i].Nombre);
  if MainUser.casa <> '' then
   ComboCasas.text:= MainUser.casa;

  Label2.Caption:= 'Jugando con: ' + SecondUser.username;
  label6.Visible:= False;
  if (SecondUser.username = '') then
   label6.Visible:= True;
end;

procedure TParametrosPartida.SpeedButton2Click(Sender: TObject);
begin
  ParametrosPartida.Close;
end;

procedure TParametrosPartida.SpeedButton3Click(Sender: TObject);
var
  i: integer;
begin
  label6.Visible:= false;

  if (SecondUser.username = '') then
   label6.Visible:= true;

  if not(label6.Visible) then
   begin

    i:= 1;

    if CheckBox1.Checked then
       begin
        Ventajas[i]:= 1;
        inc(i);
       end;

    if CheckBox2.Checked then
       begin
        Ventajas[i]:= 2;
        inc(i);
       end;

    if CheckBox3.Checked then
       begin
        Ventajas[i]:= 3;
        inc(i);
       end;

    if CheckBox4.Checked then
       begin
        Ventajas[i]:= 4;
        inc(i);
       end;

    if CheckBox5.Checked then
       begin
        Ventajas[i]:= 5;
        inc(i);
       end;

    if CheckBox6.Checked then
       begin
        Ventajas[i]:= 6;
        inc(i);
       end;

    if CheckBox7.Checked then
       begin
        Ventajas[i]:= 7;
        inc(i);
       end;

    maxVentajas:= i-1;

    i:= 1;

    if CheckBox9.Checked then
       begin
        DesVentajas[i]:= 1;
        inc(i);
       end;

    if CheckBox10.Checked then
       begin
        DesVentajas[i]:= 2;
        inc(i);
       end;

    if CheckBox11.Checked then
       begin
        DesVentajas[i]:= 3;
        inc(i);
       end;

    if CheckBox12.Checked then
       begin
        DesVentajas[i]:= 4;
        inc(i);
       end;

    if CheckBox13.Checked then
       begin
        DesVentajas[i]:= 5;
        inc(i);
       end;

    if CheckBox14.Checked then
       begin
        DesVentajas[i]:= 6;
        inc(i);
       end;

    if CheckBox15.Checked then
       begin
        DesVentajas[i]:= 7;
        inc(i);
       end;

    maxDesVentajas:= i-1;

    
      with ParametrosPartida do
       begin
       if radioButton1.Checked then
        TamanoTableroa:= 5;
       if radioButton2.Checked then
        TamanoTableroa:= 6;
       if radioButton3.Checked then
        TamanoTableroa:= 7;
       if radioButton4.Checked then
        TamanoTableroa:= 8;
       if radioButton5.Checked then
        TamanoTableroa:= 9;
       if radioButton8.Checked then
        TamanoTableroa:= 10;
       end;

      with InicioRetador do
       begin
       if radioButton1.Checked then
       TamanoTablerob:= 5;
       if radioButton2.Checked then
       TamanoTablerob:= 6;
       if radioButton3.Checked then
       TamanoTablerob:= 7;
       if radioButton4.Checked then
       TamanoTablerob:= 8;
       if radioButton5.Checked then
       TamanoTablerob:= 9;
       if radioButton6.Checked then
       TamanoTablerob:= 10;
       end;

    if TamanoTableroa >= TamanoTablerob then
      DimensionTablero:= TamanoTableroa
    else
     DimensionTablero:= TamanoTablerob;

    Sentido:= radioButton6.Checked;


    Juego.visible:= True;

    VidaPrincipal:= TrackBar1.Position;
    VidaRetador:= TrackBar1.Position;

    DibujarTableroCorrespondiente(DimensionTablero,sentido,75,375);

    with Juego do
     begin
      J1.Caption:= MainUser.Username;
      J2.Caption:= SecondUser.Username;
     end;

    if radioButton9.Checked then
     PorcentajeBuenas:= 70
    else
     if radioButton10.Checked then
      PorcentajeBuenas:= 50
     else
      PorcentajeBuenas:= 30;

    ParametrosPartida.visible:= false;
   end;
end;

procedure TParametrosPartida.CheckBox1Change(Sender: TObject);
begin

end;

procedure TParametrosPartida.CheckBox14Change(Sender: TObject);
begin

end;

procedure TParametrosPartida.CheckBox2Change(Sender: TObject);
begin

end;

end.

