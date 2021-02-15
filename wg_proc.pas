{
routines to produce a 'climate data generator' as base for the @link(Trndwetter) class to provide randomly generated records according to the general climate properties of a given site
}
unit wg_proc;

{
 * der neue Wettergenerator: Herstellen der Parameterdatei *.per;
 * direktes Lesen aus dBASE-Files
 * passend für Einbau in CANDY
}

Interface
//uses adodb;
const kmax=20;            {max. Iterationszahl Newtonverfahren}
      niedschwelle: double =  0.01;  //1.e-2; {untere Grenze fuer beobachtbare Tagesnieder-}
                          {schlagsmenge>0 mm Wasser}
type
  str12=string[12];
  dim1=array[1..12] of integer;
  dim2=array[1..12] of real;
  PWetter=^Wetter;
  Wetter=record
           ltem: real;
           nied: real;
           glob: real;
           next: PWetter;
         end;
  MPWetter=array[1..12] of PWetter;
  PDateiliste=^Dateiliste;
  Dateiliste=record
               datname: string;
               next: PDateiliste;
             end;

   procedure make_wg(wetverz,datverz,name:string);

   function sdr2grd( stnlat:real;        {geographische Breite (Latitude) }
                 _dnr   :integer;     {Tagesnummer (julian day)        }
                 _sunhr_:real         {Sonnenscheindauer in h          }

                 ):real;
var
  ok: boolean;
  anz1, m, k, i, code: integer;
  z, zz, merk: LongInt;
  histri: string[2];
  datum, name: string;
  wettdatei: string;
  wetverz, datverz: string;
  h0, h1, h2, h3, h4, sum1, sum2, sum3, sum4, sum5,
  pStart, ak1, bk, bk1, fbk, fstrichbk, rel: real;
  MWanzahl: dim1;
  ltemmeanw, ltemmeand, ltemstdw, ltemstdd,
  strahlmeanw, strahlmeand, strahlstdw, strahlstdd,
  p01, p10, alpha, beta,
  Lag0_12, Lag1_11, Lag1_12, Lag1_21, Lag1_22: dim2;
  Basis, Element: PWetter;
  Wurzel, Ende: MPWetter;
  Ursprung, Glied: PDateiliste;

  ergebnisse1: text;
implementation
uses sysutils,wetgen1, fdc_modul;

procedure anhaengen1(var Erster, Letzter: PDateiliste; datname:string);
begin
  if( Erster=nil) then begin
    New(Erster); Letzter:=Erster;
  end
  else begin
    New(Letzter^.next); Letzter:=Letzter^.next;
  end;
  Letzter^.datname:=datname;
  Letzter^.next:=nil;
end;{anhaengen1}

procedure anhaengen2(var Erster, Letzter: Pwetter; lt, ni, glob: real);

begin
  if( Erster=nil) then begin
    New(Erster); Letzter:=Erster;
  end
  else begin
    New(Letzter^.next);
    Letzter:=Letzter^.next;
  end;
  Letzter^.ltem:=lt; Letzter^.nied:=ni; Letzter^.glob:=glob;
  Letzter^.next:=nil;
end;{anhaengen2}

procedure ausdruck(feld: dim2; dec: integer);
var i: integer;
begin
  for i:=1 to 12 do write(ergebnisse1,feld[i]:7:dec,' ');
  writeln(ergebnisse1);
end;{ausdruck}


function sdr2grd( stnlat:real;        {geographische Breite (Latitude) }
                 _dnr   :integer;     {Tagesnummer (julian day)        }
                 _sunhr_:real         {Sonnenscheindauer in h          }

                 ):real;
const
 {PI = 3.1416}
 PC = 0.66;
 C1 = 4.062e-7;
 C2 = 3.7212e7;

var ndays:integer;
    twopi, xlat, angnd, csd, snd,
    cs2d, sn2d, sndecl,csdecl, csl, snl,
    cshass, snhass,dum1,z,hass,hrday,sunfr,
    invrsq,ra,rad2                   :real;
begin
   ndays:=_dnr;
   TWOPI:= 2*PI;
   XLAT:=STNLAT*PI/180;
   ANGND:=TWOPI*(NDAYS-172)/(365);
   CSD:=COS(ANGND);
   SND:=SIN(ANGND);
   CS2D:=CSD*CSD-SND*SND;
   SN2D:=2*CSD*SND;
   SNDECL:=0.00678+CSD*0.39762+SND*0.00613-CS2D*0.00661-SN2D*0.00159;
   CSDECL:=SQRT(1-SNDECL*SNDECL);
   CSL:=COS(XLAT);
   SNL:=SIN(XLAT);
   CSHASS:=(-0.014544-SNL*SNDECL)/(CSL*CSDECL);
   SNHASS:=SQRT(1-CSHASS*CSHASS);
   DUM1  := SNHASS/CSHASS;
   Z:=0;
   if dum1<0 then  z:=-1;
   if dum1>0 then  z:=1;
   HASS := Arctan(dum1)  {ACOS(1 / (SQRT(1+DUM1*DUM1)))};
   HASS := HASS * Z;
   if HASS<=0 then  HASS:=HASS+(PI);
   HRDAY:=24.0*HASS/PI;
   sunfr    := _sunhr_/hrday;
   INVRSQ   := 1.00011 - 0.03258*CSD - 0.00755*SND+0.00064*CS2D + 0.00034*SN2D;
   RA       := C2*INVRSQ*(CSL*CSDECL*SNHASS+SNL*SNDECL*HASS);
   RAD2     := (0.16 + 0.62*SUNFR) * RA;
   RAD2     := RAD2 / 10000;
sdr2grd:= rad2;
end;



procedure make_wg(wetverz,datverz,name:string );
var glob_ok:boolean;//hfa:feldatr;
    x:real;

begin

  Ursprung:=nil;
  glied:=nil;

  anz1:= cli_tool.wstat_clb.Items.Count;
    for i:=1 to anz1 do
    begin
      if cli_tool.wstat_clb.Checked[i-1] then
         anhaengen1(Ursprung, Glied, cli_tool.wstat_clb.Items[i-1]);
    end;
  {Einlesen der Wetterdaten auf den Heap}
  merk:=366*(SizeOf(Wetter)+2);
  for m:=1 to 12 do begin
    Wurzel[m]:=nil;
    MWanzahl[m]:=0;
  end;
//  Clrscr;
  cli_tool.lb.items.add(' Input of weather data:');
  cli_tool.lb.items.add(' The following files will be used:         ');
  zz:=0;
  Glied:=Ursprung;
  for k:=1 to anz1 do
     if cli_tool.wstat_clb.Checked[k-1] then

    begin
      inc(zz);
      {$I-}
    //#  New(fdc.hqry, Init(Glied^.datname));
      cli_tool.lb.items.add('                  '+Glied^.datname+'                     ');
      fdc.hqry.Close;
      fdc.hqry.SQL.Clear;
      fdc.hqry.SQL.Add('select datum,ltem,nied,glob from cdy_cldat where widx='''+glied^.datname+'''');
      fdc.hqry.Open;
      fdc.hqry.First;
      code:=0;
      for i:=1 to fdc.hqry.recordcount do begin

       datum:= fdc.hqry.fieldbyname('DATUM').Asstring;
        h1:=fdc.hqry.fieldbyname('LTEM').asfloat;
        h2:=fdc.hqry.fieldbyname('NIED').asfloat;
        h3:=  fdc.hqry.fieldbyname('GLOB').asfloat;
        fdc.hqry.next;

        val(copy(datum,4,2), z, code); //lfd. Monat
      	if code=0 then
        begin
            inc(MWanzahl[z]);
    		    anhaengen2(Wurzel[z], Ende[z], h1, h2, h3);
        end else
        begin
            cli_tool.lb.items.add(' Error during file input. Execution terminated!');
            halt;
        end;
      end;
      fdc.hqry.Close;
      Glied:=Glied^.next;
    end;
  cli_tool.lb.items.add(' Successfull input of '+inttostr(zz)+' weather data files. Start of the calculations.');
  for m:=1 to 12 do if MWanzahl[m]<2 then begin
    cli_tool.lb.items.add(' Halt: Not enough weather data available.'); halt;
  end;

  { Lufttemperatur/ Strahlungswerte }
  cli_tool.lb.items.add('');;
   cli_tool.lb.items.add(' Calculation of temperature and radiation means.');
  for m:=1 to 12 do begin
    Element:=Wurzel[m];
    z:=0; zz:=0;
    sum1:=0; sum2:=0; sum3:=0; sum4:=0;
    for k:=1 to MWanzahl[m] do begin
      if Element^.nied>niedschwelle then begin
        inc(z);
        sum1:=sum1+Element^.ltem;
        sum2:=sum2+Element^.glob;
      end else begin
        inc(zz);
        sum3:=sum3+Element^.ltem;
        sum4:=sum4+Element^.glob;
      end;
      Element:=Element^.next;
    end;{k}
    if((z>1) and (zz>1)) then begin
      ltemmeanw[m]:=sum1/z;   ltemmeand[m]:=sum3/zz;
      strahlmeanw[m]:=sum2/z; strahlmeand[m]:=sum4/zz;
    end else begin
       cli_tool.lb.items.add(' Halt: Problems in calculation of the first and second');
       cli_tool.lb.items.add(' moments for temperature and radiation (not enough data).');
      halt;
    end;{if}
  end;{m}

   cli_tool.lb.items.add(' Calculation of the dispersion of temperature and radiation.');
  {Zentrieren der Werte von LTEM und GLOB}
  for m:=1 to 12 do begin
    Element:=Wurzel[m];
    z:=0; zz:=0;
    sum1:=0; sum2:=0; sum3:=0; sum4:=0;
    for k:=1 to MWanzahl[m] do begin
      if Element^.nied>niedschwelle then begin
        inc(z);
        h1:=Element^.ltem-ltemmeanw[m];
        Element^.ltem:=h1;
        sum1:=sum1+h1*h1;
        h2:=Element^.glob-strahlmeanw[m];
        Element^.glob:=h2;
        sum2:=sum2+h2*h2;
      end else begin
        inc(zz);
        h1:=Element^.ltem-ltemmeand[m];
        Element^.ltem:=h1;
        sum3:=sum3+h1*h1;
        h2:=Element^.glob-strahlmeand[m];
        Element^.glob:=h2;
        sum4:=sum4+h2*h2;
      end;
      Element:=Element^.next;
    end;{k}
    dec(z,1); dec(zz,1);
    ltemstdw[m]:=sqrt(sum1/z); ltemstdd[m]:=sqrt(sum3/zz);
    strahlstdw[m]:=sqrt(sum2/z); strahlstdd[m]:=sqrt(sum4/zz);
  end;{m}

  {Berechnung der Auto- und Kreuzkorrelationswerte fuer Lag0  und 1}
   cli_tool.lb.items.add('');
   cli_tool.lb.items.add(' Calculation of the auto- and cross-correlation functions');
   cli_tool.lb.items.add(' for temperature and radiation.');
  for m:=1 to 12 do begin
    Element:=Wurzel[m];
    sum1:=0; sum2:=0; sum3:=0; sum4:=0; sum5:=0;
    for k:=1 to MWanzahl[m]-1 do begin
      if Element^.nied>niedschwelle then begin
        h1:=Element^.ltem/ltemstdw[m];
        h2:=Element^.next^.ltem/ltemstdw[m];
        h3:=Element^.glob/strahlstdw[m];
        h4:=Element^.next^.glob/strahlstdw[m];
      end else begin
        h1:=Element^.ltem/ltemstdd[m];
        h2:=Element^.next^.ltem/ltemstdd[m];
        h3:=Element^.glob/strahlstdd[m];
        h4:=Element^.next^.glob/strahlstdd[m];
      end;
      sum1:=sum1+h1*h2;
      sum2:=sum2+h3*h4;
      sum3:=sum3+h1*h3;
      sum4:=sum4+h1*h4;
      sum5:=sum5+h2*h3;
      Element:=Element^.next;
    end;
    Lag1_11[m]:=sum1/(MWAnzahl[m]-1);
    Lag1_22[m]:=sum2/(MWanzahl[m]-1);
    Lag0_12[m]:=sum3/(MWanzahl[m]-1);
    Lag1_12[m]:=sum4/(MWanzahl[m]-1);
    Lag1_21[m]:=sum5/(MWanzahl[m]-1);
  end;

  {Niederschlagsbehandlung}
   cli_tool.lb.items.add('');
   cli_tool.lb.items.add(' Calculation of the characteristics of the precipitation process.');
  { Niederschlag }
  for m:=1 to 12 do begin
    Element:=Wurzel[m];
    z:=0; h0:=0;
    zz:=0; h1:=0;
    for k:=1 to MWanzahl[m]-1 do begin
      if Element^.nied<=niedschwelle then begin
        h0:=h0+1;
        if Element^.next^.nied>niedschwelle then inc(z)
      end
      else begin
        h1:=h1+1;
        if Element^.next^.nied<=niedschwelle then inc(zz)
      end;
      Element:=Element^.next;
    end;
    p01[m]:=z/h0;
    p10[m]:=zz/h1;
  end;
   cli_tool.lb.items.add('');
   cli_tool.lb.items.add(' Calculation of the probability for wet day at the simulation start.');
  Element:=Wurzel[12];
  z:=0;
  for k:=1 to MWanzahl[12] do begin
    if Element^.nied>niedschwelle then inc(z);
    Element:=Element^.next;
  end;{k}
  pStart:=z/MWanzahl[12];

  {Anpassung der WEIBULL-Verteilung an die Niederschlagsmengen>0}
  for m:=1 to 12 do begin
    {Clrscr;}  cli_tool.lb.items.add('');
     cli_tool.lb.items.add(' Calculation of the parameters of the Weibull distribution');
     cli_tool.lb.items.add(' for amount of precipitation.');
     cli_tool.lb.items.add('');
     cli_tool.lb.items.add('   NEWTON-procedure for the WEIBULL parameters for month '+inttostr(m)+' :');
     cli_tool.lb.items.add('');
    Element:=Wurzel[m];
    z:=0;
    sum4:=0;
    for k:=1 to MWanzahl[m] do begin
      if Element^.nied>niedschwelle then begin
        inc(z);
        Element^.nied:=0.1*Element^.nied;
        sum4:=sum4+ln(Element^.nied);
      end;
      Element:=Element^.next;
    end;
    sum4:=sum4/z;

    k:=0;
    bk1:=0.8;
    repeat
      inc(k);
      bk:=bk1;
        sum1:=0; sum2:=0; sum3:=0;
        Element:=Wurzel[m];
        for i:=1 to MWanzahl[m] do begin
          if Element^.nied>niedschwelle then begin
            h0:=ln(Element^.nied);
            h1:=exp(bk*h0);
            sum1:=sum1+h1;
            h2:=h1*h0;
            sum2:=sum2+h2;
            sum3:=sum3+h2*h0;
          end;
          Element:=Element^.next;
        end;
        h1:=sum2/sum1;
      fbk:=h1-1.0/bk-sum4;
      fstrichbk:=(sum3/sum1)-h1*h1+1/(bk*bk);
      h1:=bk-fbk/fstrichbk;
      if(h1 <=1.0e-11) then bk1:=bk/2 else bk1:=h1;
      ak1:=z/sum1;
      rel:=abs((bk1-bk)/(bk+1.0e-3));
       cli_tool.lb.items.add('   '+inttostr(k)+' '+floattostr(bk)+' '+floattostr(ak1)+' '+floattostr(rel)+' '+
                    floattostr(fbk)+' '+floattostr(fstrichbk));
    until ((rel <= 1.0e-5) or (k>kmax));
    if k>kmax then begin
       cli_tool.lb.items.add('  Warning: Too much iterations in the Newton procedure for');
       cli_tool.lb.items.add('           m='+inttostr(m)+'. Results have to be taken with care! ');
    end;
    alpha[m]:=ak1*exp(bk1*ln(0.1));
    beta[m]:=bk1;
  end;
//  Clrscr;
   cli_tool.lb.items.add(' Output of the file '+ cli_tool.wgname.text+'.per, containing the generator ');
   cli_tool.lb.items.add(' parameters.');
  assign(ergebnisse1,wetverz+'\'+ cli_tool.wgname.text+'.per');
  rewrite(ergebnisse1);
  ausdruck(ltemmeanw, 4);
  ausdruck(ltemmeand, 4);
  ausdruck(ltemstdw, 4);
  ausdruck(ltemstdd, 4);
  ausdruck(strahlmeanw, 1);
  ausdruck(strahlmeand, 1);
  ausdruck(strahlstdw, 1);
  ausdruck(strahlstdd, 1);
  ausdruck(p01, 4);
  ausdruck(p10, 4);
  ausdruck(alpha, 4);
  ausdruck(beta, 4);
  ausdruck(Lag0_12, 4);
  ausdruck(Lag1_11, 4);
  ausdruck(Lag1_12, 4);
  ausdruck(Lag1_21, 4);
  ausdruck(Lag1_22, 4);
  writeln(ergebnisse1, pStart:7:4);
  close(ergebnisse1);
   cli_tool.lb.items.add(' End of Calculation.');
end;


  end.
