unit FormCartas;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  InitFile, FormHelper;

type

  { TFmCartas }

  TFmCartas = class(TForm)
    CbBoxDesventaja2: TCheckBox;
    CbBoxDesventaja3: TCheckBox;
    CbBoxDesventaja4: TCheckBox;
    CbBoxDesventaja5: TCheckBox;
    CbBoxDesventaja6: TCheckBox;
    CbBoxDesventaja7: TCheckBox;
    CbBoxVentaja1: TCheckBox;
    CbBoxVentaja2: TCheckBox;
    CbBoxVentaja3: TCheckBox;
    CbBoxVentaja4: TCheckBox;
    CbBoxVentaja5: TCheckBox;
    CbBoxVentaja6: TCheckBox;
    CbBoxVentaja7: TCheckBox;
    CbBoxDesventaja1: TCheckBox;
    LbBoxDesventaja2: TLabel;
    LbBoxDesventaja3: TLabel;
    LbBoxDesventaja4: TLabel;
    LbBoxDesventaja5: TLabel;
    LbBoxDesventaja6: TLabel;
    LbBoxDesventaja7: TLabel;
    LbBoxVentaja1: TLabel;
    LbBoxVentaja2: TLabel;
    LbBoxVentaja3: TLabel;
    LbBoxVentaja4: TLabel;
    LbBoxVentaja5: TLabel;
    LbBoxVentaja6: TLabel;
    LbBoxVentaja7: TLabel;
    LbBoxDesventaja1: TLabel;
    LbTitle: TLabel;
    procedure CbBoxDesventaja1Change(Sender: TObject);
    procedure CbBoxDesventaja2Change(Sender: TObject);
    procedure CbBoxDesventaja3Change(Sender: TObject);
    procedure CbBoxDesventaja4Change(Sender: TObject);
    procedure CbBoxDesventaja5Change(Sender: TObject);
    procedure CbBoxDesventaja6Change(Sender: TObject);
    procedure CbBoxDesventaja7Change(Sender: TObject);
    procedure CbBoxVentaja1Change(Sender: TObject);
    procedure CbBoxVentaja2Change(Sender: TObject);
    procedure CbBoxVentaja3Change(Sender: TObject);
    procedure CbBoxVentaja4Change(Sender: TObject);
    procedure CbBoxVentaja5Change(Sender: TObject);
    procedure CbBoxVentaja6Change(Sender: TObject);
    procedure CbBoxVentaja7Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormPaint(Sender: TObject);
  private

  public
    backgroundImage: TBitmap;
  end;

var
  FmCartas: TFmCartas;

implementation
   uses FormNGC1vs1;

{$R *.lfm}

{ TFmCartas }

procedure TFmCartas.FormCreate(Sender: TObject);
Var I: Byte;
begin

  If (not Assigned(FmNGC1vs1)) Then Begin FmCartas.Hide; Exit; End;

  backgroundImage := FmLoadBackgroundSpecify('back_wood3.bmp');
  FmSetSize(Constraints, 760, 400);

  For I := 1 To 7 Do
      If (GVentajas[I] > 0) Then TCheckbox(FindComponent('CbBoxVentaja' + IntToStr(I))).Checked := True;

  For I := 1 To 7 Do
      If (GDesventajas[I] > 0) Then TCheckbox(FindComponent('CbBoxDesventaja' + IntToStr(I))).Checked := True;
      
end;

procedure TFmCartas.CbBoxVentaja1Change(Sender: TObject);
begin
  If TCheckbox(Sender).Checked = True Then GVentajas[1] := 1 Else GVentajas[1] := 0;
end;

procedure TFmCartas.CbBoxDesventaja1Change(Sender: TObject);
begin
  If TCheckbox(Sender).Checked = True Then GDesventajas[1] := 1 Else GDesventajas[1] := 0;
end;

procedure TFmCartas.CbBoxDesventaja2Change(Sender: TObject);
begin
  If TCheckbox(Sender).Checked = True Then GDesventajas[2] := 2 Else GDesventajas[2] := 0;
end;

procedure TFmCartas.CbBoxDesventaja3Change(Sender: TObject);
begin
  If TCheckbox(Sender).Checked = True Then GDesventajas[3] := 3 Else GDesventajas[3] := 0;
end;

procedure TFmCartas.CbBoxDesventaja4Change(Sender: TObject);
begin
  If TCheckbox(Sender).Checked = True Then GDesventajas[4] := 4 Else GDesventajas[4] := 0;
end;

procedure TFmCartas.CbBoxDesventaja5Change(Sender: TObject);
begin
  If TCheckbox(Sender).Checked = True Then GDesventajas[5] := 5 Else GDesventajas[5] := 0;
end;

procedure TFmCartas.CbBoxDesventaja6Change(Sender: TObject);
begin
  If TCheckbox(Sender).Checked = True Then GDesventajas[6] := 6 Else GDesventajas[6] := 0;
end;

procedure TFmCartas.CbBoxDesventaja7Change(Sender: TObject);
begin
  If TCheckbox(Sender).Checked = True Then GDesventajas[7] := 7 Else GDesventajas[7] := 0;
end;

procedure TFmCartas.CbBoxVentaja2Change(Sender: TObject);
begin
   If TCheckbox(Sender).Checked = True Then GVentajas[2] := 2 Else GVentajas[2] := 0;
end;

procedure TFmCartas.CbBoxVentaja3Change(Sender: TObject);
begin
  If TCheckbox(Sender).Checked = True Then GVentajas[3] := 3 Else GVentajas[3] := 0;
end;

procedure TFmCartas.CbBoxVentaja4Change(Sender: TObject);
begin
  If TCheckbox(Sender).Checked = True Then GVentajas[4] := 4 Else GVentajas[4] := 0;
end;

procedure TFmCartas.CbBoxVentaja5Change(Sender: TObject);
begin
  If TCheckbox(Sender).Checked = True Then GVentajas[5] := 5 Else GVentajas[5] := 0;
end;

procedure TFmCartas.CbBoxVentaja6Change(Sender: TObject);
begin
  If TCheckbox(Sender).Checked = True Then GVentajas[6] := 6 Else GVentajas[6] := 0;
end;

procedure TFmCartas.CbBoxVentaja7Change(Sender: TObject);
begin
  If TCheckbox(Sender).Checked = True Then GVentajas[7] := 7 Else GVentajas[7] := 0;
end;

procedure TFmCartas.FormDestroy(Sender: TObject); begin backgroundImage.Free; end;

procedure TFmCartas.FormPaint(Sender: TObject); begin Canvas.Draw( 0, 0, backgroundImage ); end;

end.
