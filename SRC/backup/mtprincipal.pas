unit MTprincipal;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  EditBtn, Menus, Spin, DateTimePicker, FormSobre, DateUtils;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    ComboBox1: TComboBox;
    DateTimePicker1: TDateTimePicker;
    DateTimePicker2: TDateTimePicker;
    DateTimePicker3: TDateTimePicker;
    Edit1: TEdit;
    FloatSpinEdit1: TFloatSpinEdit;
    FloatSpinEdit2: TFloatSpinEdit;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label2: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    Panel1: TPanel;
    Panel10: TPanel;
    Panel11: TPanel;
    Panel12: TPanel;
    Panel13: TPanel;
    Panel14: TPanel;
    Panel15: TPanel;
    Panel16: TPanel;
    Panel17: TPanel;
    Panel18: TPanel;
    Panel19: TPanel;
    Panel20: TPanel;
    Panel3: TPanel;
    Panel2: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    Panel8: TPanel;
    Panel9: TPanel;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure DateTimePicker3Change(Sender: TObject);
    procedure FloatSpinEdit2Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure RadioButton1Change(Sender: TObject);
    procedure RadioButton2Change(Sender: TObject);


  private

  public
  procedure CalculoJanelaTempo();
  procedure LimparDados();
  end;

var
  Form1: TForm1;


implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.Button2Click(Sender: TObject);
var
  D1, D2: TDateTime;
  D4 : Integer;
  D5: Longint;
  ValorPorDia, ValorRescisao, ValorDevencimento : Real;


begin
  LimparDados();
  D4 := 0;
  D5 := 0;
  ValorPorDia := 0;
  ValorRescisao := 0;
  ValorDevencimento := 0;

  if(ComboBox1.ItemIndex = 0) then
  begin
  D1 := DateTimePicker1.Date;
  D2 := DateTimePicker2.Date;
  end;
   if(ComboBox1.ItemIndex = 1) then
  begin
  D1 := DateTimePicker1.Date;
  D2 := StrToDate(Label17.Caption);
  end;

  D5 := 1 + (DaysBetween(D1, D2));//conta o dia de admisao como trabalhado

 //D3 := MonthsBetween(D1, D2);//calcula o numero de meses
  D4 := (D5) div 30;

  //Calcula o valor de meses
  if(D4 >= trunc(FloatSpinEdit2.Value)) then
   Label6.Caption := FloatToStr(FloatSpinEdit2.Value)
  else
    Label6.Caption := IntToStr(D4);






  Label11.Caption :=  IntToStr(D5); //resultado de dia total
  Label18.Caption :=  IntToStr(StrToInt(Label11.Caption) - (30 * (trunc(D5 / 30)))); //resto de dia para um novo mes

  ValorPorDia       :=   ((FloatSpinEdit1.Value) / 30);   // valor por dia
  ValorRescisao     :=   ValorPorDia * (StrToFloat(Label18.Caption));
  Label22.Caption   :=   FloatToStrf(ValorRescisao, ffCurrency, 8, 2); // valor da rescisao
  ValorDevencimento :=  FloatSpinEdit1.Value * (StrToInt(Label6.Caption));
  Label20.Caption   :=   FloatToStrf(ValorDevencimento, ffCurrency, 8, 2); //valor mes trabalhdo
  Label24.Caption   :=   FloatToStrf(ValorDevencimento + ValorRescisao, ffCurrency, 8, 2); //valor total

end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  ComboBox1.Text := 'Escolha entre fechado ou aberto';
  DateTimePicker1.Enabled := False;
  DateTimePicker2.Enabled := False;
  Label6.Caption := '';
  Label9.Caption := '';
  Label11.Caption := '';
  Label18.Caption := '';
  Label20.Caption := '';
  Label22.Caption := '';
  Label24.Caption := '';
  FloatSpinEdit1.Value := 0;
   if ((ComboBox1.ItemIndex <> 0) And (ComboBox1.ItemIndex <> 1)) then
  begin
   Button2.Enabled:= False;
  end;
end;

procedure TForm1.ComboBox1Change(Sender: TObject);
begin
  if (ComboBox1.ItemIndex = 0) then
  begin

    DateTimePicker1.ReadOnly := False;
    DateTimePicker2.ReadOnly := False;
    DateTimePicker1.Enabled := True;
    DateTimePicker2.Enabled := True;
    DateTimePicker2.Visible := True;
    Button2.Enabled:= True;
  end;
  if (ComboBox1.ItemIndex = 1) then
  begin
    DateTimePicker1.ReadOnly := False;
    DateTimePicker2.ReadOnly := False;
    DateTimePicker1.Enabled := True;
    DateTimePicker2.Enabled := False;
    DateTimePicker2.Visible := False;
    Button2.Enabled:= True;
  end;

end;

procedure TForm1.DateTimePicker3Change(Sender: TObject);
begin
  CalculoJanelaTempo();
end;

procedure TForm1.FloatSpinEdit2Change(Sender: TObject);
begin
  CalculoJanelaTempo();
end;


procedure TForm1.FormCreate(Sender: TObject);
begin
  if (RadioButton1.Checked = True) then
  begin
    DateTimePicker1.ReadOnly := True;
    DateTimePicker3.Enabled := False;
    end;

  DateTimePicker1.Enabled := False;
  DateTimePicker2.Enabled := False;
  DateTimePicker3.Date    := Now;
  CalculoJanelaTempo();

  if ((ComboBox1.ItemIndex <> 0) And (ComboBox1.ItemIndex <> 1)) then
  begin
   Button2.Enabled:= False;
  end;
end;

procedure TForm1.MenuItem1Click(Sender: TObject);
begin
  Form2.ShowModal;
end;


procedure TForm1.RadioButton1Change(Sender: TObject);
begin
  if (RadioButton1.Checked = True) then
  begin
    DateTimePicker3.Date    := Now;
    DateTimePicker3.ReadOnly := True;
    DateTimePicker3.Enabled := False;
  end;
  CalculoJanelaTempo();
end;

procedure TForm1.RadioButton2Change(Sender: TObject);
begin
  if (RadioButton2.Checked = True) then
  begin
    DateTimePicker3.ReadOnly := False;
    DateTimePicker3.Enabled := True;
  end;

end;


procedure TForm1.CalculoJanelaTempo();

type
    MatrizParaCalculoAno = array [0 .. 12] of Integer;

var
   DiaInicial, MesInicial, AnoInicial, janela, i  : Integer;
   DiaFinal, MesFinal, AnoFinal : Integer;
   PonteiroCalendario : Integer;
   MatrizDoAno : MatrizParaCalculoAno;
   DataInicial, DataFinal : String;
   UltimoDiaMesFinal : Integer;


   begin

   MatrizDoAno[0] := 0;
   MatrizDoAno[1] := 1;
   MatrizDoAno[2] := 2;
   MatrizDoAno[3] := 3;
   MatrizDoAno[4] := 4;
   MatrizDoAno[5] := 5;
   MatrizDoAno[6] := 6;
   MatrizDoAno[7] := 7;
   MatrizDoAno[8] := 8;
   MatrizDoAno[9] := 9;
   MatrizDoAno[10]:= 10;
   MatrizDoAno[11]:= 11;
   MatrizDoAno[12]:= 12;
   janela := trunc(FloatSpinEdit2.Value);
   DiaInicial := DayOf(DateTimePicker3.Date);   //pega o valor do dia
   MesInicial := MonthOf(DateTimePicker3.Date); //pega o valor do mes
   AnoInicial := YearOf(DateTimePicker3.Date);  //pega o valor do ano

   DiaInicial := 01;
   PonteiroCalendario := MesInicial;

   //calculo da data inicial
   for i:= 1 to janela do
    begin
       if (MatrizDoAno[PonteiroCalendario] =  0) then
        begin
            PonteiroCalendario := 12;
            AnoInicial := AnoInicial - 1;
        end;
        if (MatrizDoAno[PonteiroCalendario] >  0) then
        begin
            PonteiroCalendario := PonteiroCalendario - 1;
        end;
    end;

    DataInicial :=  (IntToStr(DiaInicial)) + '/' + (IntToStr(PonteiroCalendario)) + '/' + (IntToStr(AnoInicial));
    Label13.Caption := DataInicial;

   //calculo da data final

   DiaFinal := DayOf(DateTimePicker3.Date);   //pega o valor do dia
   MesFinal := MesInicial - 1;
   AnoFinal := YearOf(DateTimePicker3.Date);
   if (MesFinal = 0 ) then
   begin
      MesFinal := 12;
      AnoFinal := AnoFinal - 1;  //pega o valor do ano
   end;

   DataFinal :=  (IntToStr(DiaFinal)) + '/' + (IntToStr(MesFinal)) + '/' + (IntToStr(AnoFinal));
   UltimoDiaMesFinal := DaysInMonth(StrToDate(DataFinal));
   DataFinal :=  (IntToStr(UltimoDiaMesFinal)) + '/' + (IntToStr(MesFinal)) + '/' + (IntToStr(AnoFinal));
   Label17.Caption := DataFinal;

  end;

procedure TForm1.LimparDados();
begin
  Label6.Caption  := '';
  Label9.Caption  := '';
  Label11.Caption := '';
  Label18.Caption := '';
  Label20.Caption := '';
  Label22.Caption := '';
  Label24.Caption := '';
end;


end.
