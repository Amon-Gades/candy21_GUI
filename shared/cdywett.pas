{
    climate data management for the process simulation simulation
    defining
    the datarecord @link(simwet) to transport the data , the datarecord @link(wetrec)
    that stores the data within the climate data object
    as well as the class definitions for different types of climate data with the parent class
    @link(Twetterobj) with the child classes: @link(Trndwetter) , @link(Tdbwetter), @link(Textwetter)
}
{$INCLUDE cdy_definitions.pas}
unit cdywett;
interface
uses

{$IFDEF CDY_GUI}
cdy_glob,
{$ENDIF}
{$IFDEF CDY_SRV}
cdy_config,
{$ENDIF}

cnd_util,math, cnd_vars,


  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys,
  {$IFDEF MSWINDOWS}
   FireDAC.Phys.MSAcc, FireDAC.Phys.MSAccDef, FireDAC.VCLUI.Wait,
  {$ENDIF}
  FireDAC.Comp.Client,

data.db,  variants;
type
  str12=string[12];
  dim1=array[1..12] of integer;
  dim2=array[1..12] of real;
  {glnbmax=array[1..14] of real;}

const tagzahl: dim1=(31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);
      Globmin: dim2=( 116.0,  116.0,  116.0,  116.0,  116.0,  116.0,
                      116.0,  116.0,  116.0,  116.0,  116.0,  116.0);
      Globmax: dim2=( 706.0, 1133.0, 1792.0, 2521.0, 3079.0, 3318.0,
                     3176.0, 2686.0, 1992.0, 1289.0,  780.0,  579.0);

     TYPE
       felda = ARRAY[1..32] OF INTEGER;
       feldb = ARRAY[1..4,1..32] OF INTEGER;
       feldc = ARRAY[1..4] OF REAL;

     CONST
       breit:  feldc = (48.5,50.5,52.5,54.5);   {Stuetzstellen geogr. Breite}
       tag :   felda = (1,10,20,30,45,55,80,95,105,115,125,135,145,155,165,173,
                       185,195,205,215,225,235,250,270,290,300,315,325,335,345,356,367);
       {Stuetzstellen Tage im Kalenderjahr}

       sstern: feldb  = (
       (835,856,891,936,1014,1072,1220,1308,1366,1421,1473,1520,
       1559,1588,1605,1609,1598,1574,1539,1496,1447,1394,1309,1193,1076,1019,940,
       895,859,835,826,837),

       (805,828,866,915,1000,1062,1221,1316,1378,1438,1494,1544,
       1587,1619,1638,1642,1630,1603,1565,1519,1465,1408,1317,1192,1066,1005,920,
       871,832,806,796,807),

       (772,797,839,892,984,1051,1222,1324,1391,1455,1516,1572,
       1619,1654,1675,1679,1665,1636,1595,1543,1485,1423,1325,1190,1056,990,898,
       844,801,772,761,774),

       (735,762,808,866,967,1039,1223,1333,1405,1475,1541,
       1602,1654,1693,1716,1721,1706,1674,1627,1571,1508,1440,1334,1189,1044,973,
       873,814,767,735,723,737));
       {Stuetzstellen astron. moegliche Sonnenscheind. fuer die 4 Breiten}

       gstern: feldb = (
       (757,819,935,1092,1401,1646,2331,2743,3000,3234,3441,3614,
       3750,3844,3894,3902,3860,3777,3653,3492,3299,3079,2708,2171,1643,1404,1100,
       943,828,757,732,762),

       (650,711,822,977,1285,1533,2233,2662,2931,3179,3398,3583,
       3729,3831,3886,3895,3850,3760,3627,3456,3251,3018,2628,2071,1531,1290,986,
       831,718,649,624,655),

       (545,604,712,864,1170,1418,2133,2577,2859,3120,3353,
       3550,3706,3816,3876,3886,3837,3741,3599,3417,3199,2953,2545,1968,1418,1176,
       873,721,611,544,520,549),

       (444,500,604,752,1054,1303,2030,2489,2784,3058,
       3304,3514,3682,3800,3864,3875,3823,3721,3569,3375,3144,2885,2459,1863,1305,
       1061,762,614,507,443,421,448));
       {Stuetzstellen ideale Globalstrahlung fuer die 4 Breiten}

type
   { data record to provide daily climate data to the process simulation}
   simwet = record
     datum: string[10];
     { Minimumlufttemperatur /fakultativ }            ltmin,
     { Maximumlufttemperatur /fakultativ }            ltmax,
     { heutige Lufttemperatur , alle ltem in °C }     ltem_h,
     { gestrige Lufttemperatur }                      ltem_g,
     { vorgestrige Lufttemperatur }                   ltem_v,
     { heutige rel. Luftfeuchte in % }                lfeu,
     { Sonnenscheindauer in h }                       sonn,
     { Tagessumme Globalstrahlung in MJ/m²
     (anders als die Werte in der DB, dort J/cm² }    glob,
     { Tageswert des intern korrigierten Niederschlages in mm } nied_k,
     { Tageswert des gemessenen Niederschlages in mm }nied,
     { Niederschlag von heute und den kommenden 2 Tage} nied3d,
     { Windgeschwindigkeit /fakultativ }              wspeed,
     { Grundwasser -Flur -Abstand in cm }             gwd,
     { N-conc im Grundwasser in ppm }                 ncgw,
     { relativer Niederschlagsfaktor (r_faktor) }     rf,
     { Potentielle Evapotranspiration in mm }         pet,
     { Potentielle Evaporation in mm }                pe,
     { Potentielle Evaporation des Interzeptionswassers in mm } pei: real;
     { Bodentemperatur bei Inkubationsversuchen }     btem,
     { Bodenfeuchte bei Inkubationsversuchen }        theta: real;
     { meldet Inkubationsversuch }                    inkub,
     { Bodenfeuchte im Optimum }                      theta_opt,
     { record is valid }                              ok: boolean;
   end;


    wetpoint=^wetrec;              { Zeiger auf Wetterdaten             }
    wetrec  = record
                datum : string[10];   { Tagesdatum                         }
                ltmin,
                ltmax,
                pet,                 { potential Evapotranspiration from external sources}
                ltem  : real;        { Lufttemperatur in 2 m Hoehe in øC  }
                nied  : real;        { taegliche Niederschlagssumme in mm }
                glob  : real;        { taegliche Globalstrahlung in J/cm² }
                sonn,                { Sonnenscheindauer in d }
                lfeu,
                gwd,           {Grundwasser -Flur -Abstand in cm}
                ncgw,          {N-conc im Grundwasser in ppm}
                wspeed  : real;
                btem,                   // Bodentemperatur bei Inkubationsversuchen
                theta   :real;          // Bodenfeuchte bei Inkubationsversuchen
                next  : wetpoint     { Zeiger auf Datensatz für Folgetag  }
                end;



    pwetterobj   =   ^Twetterobj;
 {allgemeines Wetterobjekt}
    Twetterobj    =   class(Tobject)
                        _first:boolean;
                        wett_anf,
                        heute,
                        gestern,
                        vorgestern   : wetpoint;
                        geobreit,
                        r_faktor,
                        nied_sum,
                        glob_sum,
                        ltem_sum,
                        tbed,
                        tunb         : real;
                        inkub,                   {modelliert wird ein Inkubationsexperiment}
                        ok_sonn,
                        ok_btem,
                        ok_bfeu,
                        ok_glob,
                        ext_src,                 {externe Datenquelle}
                        ok_w,                    {Windgeschwindigkeit in DB}
                        ok_gwd,                  {Grundwasserlevel in DB}
                        ok_ncgw ,                {Nconc in GW}
                        ok_l,                    {Luftfeuchte in DB vorhanden}
                        ok_p,                    {PET in DB vorhanden}
                        ok_x,                    {LT-Maximum in Datenbank}
                        ok_m         : boolean;  {LT-Minimum in Datenbank}
                        swet         : simwet;
                        apply_nied_korr:boolean;
                        destructor  DONE;
                        procedure   set_prms(tb,tu,rf,gbr:real);
                        procedure   build_dataspace;
                        procedure   wetter(var _swet:simwet;apply_rf,n_korr:boolean) ;
                        procedure   YR_dummy;
                        procedure   YR_init(jahr:integer); virtual;    abstract;
                        procedure   putsrec(var s:sysstat);
                        procedure   irrg2wett(x:real);
                        function    period(it:integer;nt:integer):real; {Länge der photoperiode in h}
                        function    petd_PENWEN( ltem,glob,vw,u,sr:double):double;
                                    // ltem [°C]; Glob J/cm²; Vw [m/s]; U= rlfeu/100; sr=sonnstund/12
                     end;



   prndwetter  =     ^trndwetter;
   {spezielles Objekt : Zufallswetter}
   Trndwetter   =     class(Twetterobj)
                      initialisiert:boolean;
                      nextnied: boolean;
                      jahrnr, jahrzahl : integer;
                      res1, res2, pStart: real;
                      ltemmeanw,
                      ltemmeand,
                      ltemstdw,
                      ltemstdd,
                      strahlmeanw,
                      strahlmeand,
                      strahlstdw,
                      strahlstdd,
                      p01, p10, alpha, beta,
                      Lag0_12, Lag1_11, Lag1_12, Lag1_21, Lag1_22: dim2;
                      daten1: text;
                      constructor create(tb,tu,rf,gbr:real;name:string; rnds:integer);
                      destructor  done;
                      procedure   YR_init(jahr:integer);override;
                    end;


 {spezielles Objekt : Wetter aus database connection}
  Tdbwetter  =      class(Twetterobj)
                      wetstat : string;
                      adofile :tFDquery;
                      smax,
                      gmax    :felda;
                      yr_len  :integer;
                      constructor CREATE (cnd:pointer); // (tb,tu,rf,gbr:real;name:string);
                      destructor  done;
                      procedure   YR_init(jahr:integer);override;
                      function    load_dbf(wstat,jahr_:string):boolean;
                    end;


  pextwetter  =      ^textwetter;
   {spezielles Objekt : Daten werden extern bereitgestellt}
  TExtwetter   =      CLASS(Twetterobj)

                       constructor CREATE(tb,tu,rf,gbr:real);
                       destructor  done;
                   //    procedure   get_data(_swet:simwet);
                       procedure locate_at(t,j:integer);
                       procedure nied2wett(x:real);
                       procedure temp2wett(x:real);
                       procedure glob2wett(x:real);
//                       procedure irrg2wett(x:real);
                       end;


 var swetter  :simwet;
     std_gwd  :integer;
     ewo : TExtWetter;
     dwo : Tdbwetter;
     awo : Twetterobj;
     rwo : TRndWetter;


 implementation

 uses ok_dlg1,sysutils,cdyparm,cdyspsys ;

  {Tageslänge in Stunden}
      function Twetterobj.PERIOD(IT:integer;nt:integer):real;
      var gbr,u,g,d,ws,sa,cws:real;
      begin
      gbr:=geobreit;
      {PI:=3.14159}
      U:=PI/180;
      IF(GBR=12)then begin sa:=6;period:=12 end
                else
      begin
      G:=2*PI*(IT-1)/NT;
{C     DEKLINATION DER SONNE IN GRAD}
      D:=(0.006918-0.399912*COS(G)+0.070257*SIN(G)-0.006758*COS(2*G)
        +0.000907*SIN(2*G)-0.002697*COS(3*G)+0.00148*SIN(3*G))*(180/PI);
      CWS:=-(TAN(D*U)*TAN(GBR*U));
{C     STUNDENWINKEL (0...2PI)}
      WS:=ACOS(CWS)*180/PI;
      SA:=12-(WS/15);
      period:=2*(12-SA);
      end;
      END;

procedure blind_rec(var h:wetpoint);
begin
 h^.datum:='*';
 h^.ltem :=-99.9;
 h^.nied :=-99.9;
 h^.glob :=-99.9;
end;

function Twetterobj.petd_PENWEN( ltem,glob,vw,u,sr:double):double;
var l,pet:double;
begin
  l:=(2.498-0.00242*ltem)*100;
  pet:=2.3*(ltem+22)*(  (0.6*glob/l) + 0.66*(1+1.08*vw)*(1-u)*sr  )/(ltem+123);
  petd_penwen:=pet;
end;




procedure Twetterobj.build_dataspace;
var i:integer;
begin
  new(wett_anf);
 heute     :=wett_anf;
 gestern   :=heute;
 vorgestern:=heute;
 blind_rec(heute);
 for I:=2 to 366 do
 begin
     new(heute^.next);
     blind_rec(heute);
     heute:=heute^.next;
     heute^.next:=nil;
 end;
 heute:=wett_anf;
end;

 procedure   Twetterobj.set_prms(tb,tu,rf,gbr:real);
 begin
    {
    apply_nied_korr:=true;
    geobreit:=gbr;
    r_faktor:=rf;
    }
    ext_src:=false;


    apply_nied_korr:=candy.cdy_switch.nied_korr;
    geobreit:=candy.cdyconnex.fda_latitude;
    r_faktor:=candy.cdy_switch.rain_coeff;
    ext_src:=false;
    tbed:=cdyaparm.parm('TBED');          // tbed:=tb;     //aus cdyaparm
    tunb:=cdyaparm.parm('TUNB');


 end;

(*
constructor Twetterobj.create(tb,tu,rf,gbr:real);
var i:integer;
    cdy_ini:tregistry;

begin

 cdy_ini:=Tregistry.Create;
 try
  cdy_ini.RootKey := HKEY_CURRENT_USER;
  if cdy_ini.OpenKey('\Software\candy\switches', false)
  then
  begin
  if cdy_ini.ValueExists('GWD')        //ground water depth
    then  std_gwd:=cdy_ini.ReadInteger('GWD')
    else  std_gwd:=6000;
  end;
 finally
 cdy_ini.closekey;
 cdy_ini.free;
 inherited CREATE;
 end;

 apply_nied_korr:=true;
 geobreit:=gbr;
 r_faktor:=rf;
 ext_src:=false;
 tbed:=tb;
 tunb:=tu;
  build_dataspace;
end;
  *)

destructor Twetterobj.done;
begin
    heute:=wett_anf;
    while heute<>NIL do
    begin
      wett_anf:=heute^.next;
      dispose(heute);
      heute:=wett_anf;
    end;
end;


(*
procedure Twetterobj.list(jahrzahl:integer);
var tag:integer;
    yr,datu:string;
    awet:simwet;
    f:text;
begin
  yr:=numstring(jahrzahl,4);
  assign(f,'wet'+yr+'.txt');
  rewrite(f);
  writeln(f,'Datum':10,'NIED':7,'LTEM':7,'GLOB':7,'NIED_K':7,'PET':7,'PE':7,'PEI':7);
  yr_init(jahrzahl);
  tag:=0;
  repeat
    inc(tag);
    datu:=essdatum(tag,jahrzahl);
    awet.datum:=datu;
    wetter(awet,false,true);
    with awet do writeln(f,datum:10,nied:7:1,ltem_h:7:1,glob:7:1,nied_k:7:1,pet:7:1,pe:6:1,pei:7:1);
  until copy(datu,1,5)='31.12';
  close(f);
end;
   *)

procedure Twetterobj.yr_dummy;

var i:integer;
begin
  nied_sum:=0;
  glob_sum:=0;
  ltem_sum:=0;
  heute:=wett_anf;
  gestern:=wett_anf;
  vorgestern:=wett_anf;
 for i:=1 to 366 do
 begin
   blind_rec(heute);
   heute:=heute^.next;
 end;
 heute:=wett_anf
end;


function jahrzahl(s:string):integer;
var j,h:integer;
begin
 j:=-1;
 if length(s)=10 then
    begin
     val(copy(s,7,4),j,h);
     if h<>0 then j:=-1;
    end;
 jahrzahl:=j;
end;




function julday(datum:string):integer;
TYPE
  feld = ARRAY[1..12] OF INTEGER;
CONST
  mol: feld = (31,28,31,30,31,30,31,31,30,31,30,31);
VAR

  d,j,h,m  : integer;
  mo       : real;
  schaltjahr : boolean;
begin
 h:=0;m:=0;
 if length(datum)=10 then
 begin
  val(copy(datum,1,pos('.',datum)-1),d,h);
  val(copy(datum,pos('.',datum)+1,2),mo,h);
  m:=round(mo);
  val(copy(datum,length(datum)-1,2),j,h);
  schaltjahr:=( (j mod 4)=0 ) and (not((j mod 100)=0) ) ;
  if j mod 1000=0 then schaltjahr:=true;
  if schaltjahr then mol[2]:=29 else mol[2]:=28;
  h:=0;
  for j:=1 to m-1 do h:=h+mol[j];
 end;
 julday:=h+d;
end;



FUNCTION rkor(nied,temp:double): double;
{Korrektion taegliche Niederschlagshoehe wegen system. Messfehler}
TYPE felda = ARRAY[1..6]   OF double;
     feldb = ARRAY[1..12]  OF double;
CONST wisn : felda = (5.0, 10.0, 300.0,  1.7,  1.35,  1.00);
      wire : feldb = (1.6,  4.7,  10.1, 22.1, 40.10, 70.10, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6);
      bene : felda = (0.6,  2.1, 300.0,  0.1,  0.20,  0.30);
VAR m:BYTE; rk, a,fakt:double;
BEGIN
  IF(temp<=0.5) THEN BEGIN    {Schnee; Korr.: RACHNER u. MATTHAEUS (1981)}
    rk:=0.6;
    IF(nied>0.3) THEN BEGIN
      m:=0;
      REPEAT
        m:=succ(m);
      UNTIL (nied < wisn[m]) OR (m = 3);
      rk:=nied * wisn[m + 3];
    END;
  END;
  IF(temp>0.5) THEN BEGIN     {Regen; Korr.: RICHTER(1985)}
    fakt:=1.00;
    m:=0;
    REPEAT
      m:=succ(m);
    UNTIL (nied < bene[m]) OR (m = 3);
    a:=nied + bene[m + 3];
     {Das war Benetzungskorr., jetzt Windkorr.}
    IF(a > 70.0) THEN rk:=(1 + 0.01 * fakt) * a
    ELSE BEGIN
      m:=0;
      REPEAT
        m:=succ(m);
      UNTIL (a < wire[m]) OR (m = 6);
      rk:=a + wire[m+6] * fakt;
    END;
   END;
 rkor:=rk;
END;



procedure Twetterobj.irrg2wett(x:real);
begin
 swet.nied_k:=swet.nied_k+x;
end;

procedure   Twetterobj.wetter(var _swet : simwet; apply_rf,n_korr:boolean);
var jahr,jday :integer;
    glom,
    glor,
    turc      :real;

begin
if not ext_src then
begin
 swet:=_swet;
 swet.ok:=false;
 jahr:=jahrzahl(_swet.datum);
 if  (heute=NIL) or (jahrzahl(heute^.datum)<> jahr) then
 begin
   yr_init(jahr);
 end;
 jday:=julday(_swet.datum);

 if julday(heute^.datum)>jday
 then begin
          heute:=wett_anf;
          gestern:=wett_anf;
          vorgestern:=wett_anf;
      end;

 while (heute<>NIL) and (heute^.datum <> _swet.datum)  do
 begin
  vorgestern:=gestern;
  gestern   :=heute;
  heute     :=heute^.next;
 end;
 if heute<>NIL then
 begin
  swet.ltem_h:=heute^.ltem;
  swet.ltmax :=heute^.ltmax;
  swet.ltmin :=heute^.ltmin;
  swet.ltem_g:=gestern^.ltem;
  swet.ltem_v:=vorgestern^.ltem;
  swet.glob  :=heute^.glob;
  swet.sonn  :=heute^.sonn;
  swet.nied  :=heute^.nied;
  // calculate the rain of today and the next two days
  try
         swet.nied3d := heute^.nied + heute.next.nied + heute.next.next.nied;
  except
         swet.nied3d := 0;
  end;

  swet.gwd   :=heute^.gwd;         // Standard: Grundwasserabstand=20 m
  swet.ncgw  :=heute^.ncgw;        // Standard: 12 ppm N im GW
  swet.btem  :=heute.btem;
  swet.theta :=heute.theta;
  swet.inkub :=inkub;
  swet.theta_opt:=(swet.theta<0);
 end;
  {Korrektur des Niederschlagsrasters (bei bedarf)}
  // (bugfix)
  // 14.05.2007: Anwendung der Raster-Korrektur jetzt nicht mehr auf den inneren Datensatz, sondern auf den Übergabe-Record
  if apply_rf then  swet.nied:=swet.nied*r_faktor;
end {not ext_src}
else swet:=_swet; {extern: übernahme der Info}

  {Korrektur der Meßfehler (bei bedarf)}
  if (swet.nied>0.01) and n_korr
    then swet.nied_k:=rkor(swet.nied, swet.ltem_h)    // bis 14.05.2007 rkor(heute^.nied,heute^.ltem{,r_faktor})
    else swet.nied_k:=swet.nied;

  {eine Variante für pe _berechnung}
  turc:=0.0041 * (swet.ltem_h + 22.7)* (swet.glob/100 + 2.09);  {V-TURC}

  (*
  {Wendling Variante}
   turc := (heute^.glob+93)*(heute^.ltem+22)/(150*(heute^.ltem+123));

   *)

 IF(turc < 0.05) THEN turc:=0.05;
  swet.pe :=tunb*turc;

  if (swet.ltem_h<=0.5) then swet.pet:=swet.pe else swet.pet:=tbed*turc;

  {*************Einschub für gelesene PET Werte******************************

  if not ext_src then                                          // erweitert 12.05.2011 Fr.
   if heute^.pet>-99.9 then
                        begin
                        swet.pet:=heute^.pet;
                        swet.pe:=swet.pet;
                        end;

  *********************************************************ENDE 03/12/08 Fr.}

  swet.pei:=1.3*swet.pet;
  glom:=16.838 + 12.758 * SIN(0.0172024 * (jday - 80)) ;
  glor:=(swet.glob*0.01)/glom;
  IF(glor>1) THEN glor:=1;
  swet.rf:=94 - 24 * glor;
  swet.ok    := true;
  if inkub then
  begin
    swet.inkub:=true;
    swet.btem:=heute^.btem;
    swet.theta:=heute^.theta;
    swet.theta_opt:=(swet.theta<0);
  end;
 _swet:=swet;
end;


procedure Twetterobj.putsrec(var s:sysstat);
begin
  s.wett.niedk:=swet.nied_k;
  s.wett.nied3d:=swet.nied3d;
  s.wett.pe   :=swet.pe;
  s.wett.pet  :=swet.pet;
  s.wett.pei  :=swet.pei;
  s.wett.rf   :=swet.rf;
  s.wett.glob :=swet.glob/100;
  s.wett.lt   :=swet.ltem_h;
  s.wett.ltg  :=swet.ltem_g;
  s.wett.ltvg :=swet.ltem_v;
  s.wett.ltmin:=swet.ltmin;
  s.wett.ltmax:=swet.ltmax;
  s.wett.lfeu :=swet.lfeu;
  s.wett.wspeed:=swet.wspeed;
  s.wett.gwd:=swet.gwd;
  s.wett.ncgw:=swet.ncgw;
  s.wett.btem:=swet.btem;
  s.wett.theta:=swet.theta;
  s.wett.theta_opt:=swet.theta_opt;
  s.wett.inkub:=swet.inkub;
  s.wett.trans:=0;                        // added 21.11.2020 UF
end;



function rndgauss(mw, st: real): real;
const zweiPi=6.2831853072;
var a: real;
begin
  repeat a:=random until a<>0;
  a:=sqrt(-2.0*ln(a));
  rndgauss:=a*cos(zweiPi*random)*st+mw;
 {konstantes Wetter:rndgauss:=mw;}
end;

procedure zerlegen(u11, u12, u22: real; var b11, b21, b22: real);
begin
  b11:=sqrt(u11);
  b21:=u12/b11;
  b22:=u22-b21*b21;
  if b22 <= 1.0e-20 then begin
    writeln(' Datenfehler bei den Korrelationsgroessen. Programmabbruch !');
    halt;
  end else b22:=sqrt(b22);
end;{zerlegen}




constructor Trndwetter.create(tb,tu,rf,gbr:real; name:string; rnds:integer);
const eps=1.0e-10;
var m,i               : integer;
    b11, b21, b22,
    h0,h1,h2        : real;
    h               : wetpoint;
    fname:string;



procedure daten_check1(name: str12; feld: dim2; eps: real);
var m: integer;
begin
  for m:=1 to 12 do if (feld[m] <= eps) then begin
    writeln(' Datenfehler in Feld ',name,'. Programmabbruch!');
    halt;
  end;
end;{daten_check1}

procedure daten_check2(name: str12; feld: dim2; eps: real);
var m: integer;
begin
 for m:=1 to 12 do begin
  if abs(1-Lag0_12[m]*Lag0_12[m]) <= eps then begin
	writeln(' Datenfehler in der Korrelationsgroessen ',name,'. Programmabbruch!');
  halt;
  end;
 end;
end;{daten_check2}

begin
 // Twetterobj.create(tb,tu,rf,gbr);
  build_dataspace;
  set_prms(tb,tu,rf,gbr);
  initialisiert:=false; {sorgt für die Generierung des Vor- und Vorvortages}
  r_faktor:=rf;
  fname:= candy.cdyconnex.CDY_Data_Path; {wenn leer, dann current dir} //extractfilepath(candy.cdyconnex.datenbank);
 fname:=fname+name+'.per';       //besser bezug auf deen pfad der db-connection
  {$I-}
  assign(daten1,fname);
  reset(daten1);
  {$I+}
  if Ioresult<>0 then
  begin
{$IFDEF CDY_GUI}
     ok_dlg.abbruch:=true;
     ok_dlg.label1.caption:=' Datei '+fname+' konnte nicht gefunden werden. Programmabbruch!';
     ok_dlg.showmodal;
{$ENDIF}
{$IFDEF CDY_SRV}
     _halt(0);
{$ENDIF}
     exit;

  end

  else
  begin
  {Daten gefunden}
  for i:=1 to 12 do read(daten1, ltemmeanw[i]); readln(daten1);
  for i:=1 to 12 do read(daten1, ltemmeand[i]); readln(daten1);
  for i:=1 to 12 do read(daten1, ltemstdw[i]); readln(daten1);
  for i:=1 to 12 do read(daten1, ltemstdd[i]); readln(daten1);
  daten_check1('ltemstdw', ltemstdw, eps);
  daten_check1('ltemstdd', ltemstdd, eps);
  for i:=1 to 12 do read(daten1, strahlmeanw[i]); readln(daten1);
  for i:=1 to 12 do read(daten1, strahlmeand[i]); readln(daten1);
  for i:=1 to 12 do read(daten1, strahlstdw[i]); readln(daten1);
  for i:=1 to 12 do read(daten1, strahlstdd[i]); readln(daten1);
  daten_check1('strahlstdw', strahlstdw, eps);
  daten_check1('strahlstdd', strahlstdd, eps);
  for i:=1 to 12 do read(daten1, p01[i]); readln(daten1);
  for i:=1 to 12 do read(daten1, p10[i]); readln(daten1);
  for i:=1 to 12 do read(daten1, alpha[i]); readln(daten1);
  daten_check1('alpha', alpha, eps);
  for i:=1 to 12 do read(daten1, beta[i]); readln(daten1);
  daten_check1('beta', beta, eps);
  for i:=1 to 12 do read(daten1, Lag0_12[i]); readln(daten1);
  for i:=1 to 12 do read(daten1, Lag1_11[i]); readln(daten1);
  for i:=1 to 12 do read(daten1, Lag1_12[i]); readln(daten1);
  for i:=1 to 12 do read(daten1, Lag1_21[i]); readln(daten1);
  for i:=1 to 12 do read(daten1, Lag1_22[i]); readln(daten1);
  daten_check2('Lag0_12', Lag0_12, eps);
  readln(daten1, pStart);
  close(daten1);
    if pStart<=0 then
    begin
      writeln(' Datenfehler in der Wettergeneratordaten-Datei.');
      writeln(' Programmabbruch!'); halt;
    end;


  jahrzahl:=0;
  if rnds=0 then Randomize
            else randseed:= rnds;


  { Annahme: Simulationsstart stets am 1.1. eines Jahres }
  zerlegen(1, Lag0_12[12], 1, b11, b21, b22);
  h1:=rndgauss(0, 1); h2:=rndgauss(0, 1);
  res1:=b11*h1; res2:=b21*h1+b22*h2;
  h0:=random; h1:=random;
  if h0<=pStart then begin
    if h1 <= p10[12] then nextnied:=false
                     else nextnied:=true;
  end else begin
    if h1 <= p01[12] then nextnied:=true
                     else nextnied:=false;
  end;

end;  //else
end;

destructor Trndwetter.done;
begin
 INHERITED done;
end;


procedure Trndwetter.yr_init(jahr:integer);
type strilang= string[8];
var motag,m, z: integer;
    tag, monat: string[2];
    _jahr:string[4];
    datum: string;
    d_n,h0, h1, h2, h3,
    sum3, ak1, bk1, g12, k11, k12, k21, k22, a11, a12, a21, a22,
    b11, b21, b22, u11, u12, u22, sum1, sum2: real;

  procedure niederschlagsmenge(var nied:real);
  var h1: real;
  begin
    h1:=random;
    nied:=exp(bk1*ln(ak1*ln(h1)));
  end;{niederschlagsmenge}


  procedure lutemp_und_strahl(a11, a12, a21, a22, b11, b21, b22,
                              ltm, lts, stm, sts: real;
                              var res1, res2, temp, strahl: real);
  var h1, h2: real;
  begin
    h1:=rndgauss(0,1);
    h2:=rndgauss(0,1);
    res1:=a11*res1+a12*res2+b11*h1;
    res2:=a21*res1+a22*res2+b21*h1+b22*h2;
    temp:=ltm+lts*res1;
    strahl:=stm+sts*res2;
    if strahl <= Globmin[m] then strahl:=Globmin[m];
    if strahl >= Globmax[m] then strahl:=Globmax[m];
  end;{lutemp_und_strahl}

begin

  //Twetterobj.
  yr_dummy;
  d_n:=0;
  str(jahr:4,_jahr);
  for m:=1 to 4 do if _jahr[m]=' ' then _jahr[m]:='0';
  for m:=1 to 12 do begin
    if m<10 then begin str(m:1,monat); monat:='0'+monat; end
            else       str(m:2,monat);
    g12:=Lag0_12[m];
    k11:=Lag1_11[m]; k12:=Lag1_12[m];
    k21:=Lag1_21[m]; k22:=Lag1_22[m];
    sum3:=1-g12*g12;
    a11:=(k11-k12*g12)/sum3;
    a12:=(-k11*g12+k12)/sum3;
    a21:=(k21-k22*g12)/sum3;
    a22:=(-k21*g12+k22)/sum3;
    u11:=1.0-(a11*k11+a12*k12);
    u12:=g12-(a11*k21+a12*k22);
    u22:=1.0-(a21*k21+a22*k22);
    zerlegen(u11, u12, u22, b11, b21, b22);
    sum1:=p10[m]; sum2:=p01[m];
    ak1:=-1/alpha[m]; bk1:=1/beta[m];
    z:=tagzahl[m];
    if((m=2) and (jahrzahl mod 4 =0)) then inc(z);
    for motag:=1 to z do begin
      if motag<10 then begin str(motag:1,tag);tag:='0'+tag; end
                  else       str(motag:2,tag);

        {Niederschlagsgenerierung}
        h0:=random;
        if nextnied then begin
          {Niederschlag}
       	  niederschlagsmenge(h1);      // h1 ist der generierte Niederschlag in Abhängigkeit von ak und bk
          {LTEM- und GLOB-Werte}
          lutemp_und_strahl(a11, a12, a21, a22, b11, b21, b22, ltemmeanw[m], ltemstdw[m], strahlmeanw[m], strahlstdw[m], res1, res2, h2, h3);
          if h0 <= sum1 then nextnied:=false;
        end else begin
          {kein Niederschlag}
	            h1:=0;
          {LTEM- und GLOB-Werte}
          lutemp_und_strahl(a11, a12, a21, a22, b11, b21, b22, ltemmeand[m], ltemstdd[m], strahlmeand[m], strahlstdd[m], res1, res2, h2, h3);
          if h0 <= sum2 then nextnied:=true;
        end;

      {Wetterdaten auf den Heap schreiben}
      datum:=tag+'.'+monat+'.'+_jahr;
      heute^.datum:=datum;
      heute^.glob :=h3;
      heute^.nied :=h1;
      heute^.ltem :=h2;
      nied_sum    :=nied_sum+h1;
      ltem_sum    :=ltem_sum+h2;
      glob_sum    :=glob_sum+h3/100; {MJ/m^2}
      d_n:=d_n+1;
      heute:=heute^.next;
    end;
  end;
  heute:=wett_anf;

  ltem_sum:=ltem_sum/d_n;  {Jahresmittelwert}

  add_message(_jahr+real2string(nied_sum,8,1)+'mm'+real2string(Glob_sum,8,1)+'MJ/m^2'+real2string(ltem_sum,8,1)+'øC');

end;

function number(c:char):boolean;
var i,h:integer;
begin
 val(c,i,h);
 number:=(h=0);
end;
     {------------------------------------------------------------------------}

     FUNCTION inter(w1,w2: INTEGER; db: REAL) : INTEGER;
     {Interpolieren in sstern u. gstern fuer smax u. gmax f. geogr. Breite Station}
     VAR a: REAL;
     BEGIN
       a:= w1 + (w2 - w1) / 2 * db;
       inter:= ROUND(a);
     END;

     {------------------------------------------------------------------------}

     FUNCTION interp(w1,w2,t1,t2,t3: INTEGER) : REAL;
     {Interpolieren zwischen den Stuetzstellen in smax und gmax}
     BEGIN
       interp:= w1 + (w2 - w1) / (t2 - t1) * t3;
     END;

     {------------------------------------------------------------------------}

constructor Tdbwetter.create(cnd:pointer); //tb,tu,rf,gbr:real;name:string);
var i,j,l,m:integer;
     wst,name:string;
     ocnd:Tcndcycl;


begin
 ocnd:=Tcndcycl(cnd);
 inkub:= (name='INKUB') ;
 name:=ocnd.cdyconnex.climate;
 set_prms(1,1,   ocnd.cdy_switch.rain_coeff  ,   ocnd.cdyconnex.fda_latitude   );
 // rf,gbr);           //Twetterobj.
 // inherited CREATE(tb,tu,rf,gbr);

 build_dataspace;
{ geobreit:=geobr; }
 {Ausfuellen von smax und gmax}
 IF(geobreit <= breit[1]) THEN BEGIN
   FOR m:= 1 TO 32 DO smax[m]:= sstern[1,m];
   FOR m:= 1 TO 32 DO gmax[m]:= gstern[1,m];
 END;
 IF(geobreit > breit[1]) AND (geobreit <= breit[2]) THEN BEGIN
   FOR m:= 1 TO 32 DO smax[m]:= inter(sstern[1,m],sstern[2,m],geobreit-breit[1]);
   FOR m:= 1 TO 32 DO gmax[m]:= inter(gstern[1,m],gstern[2,m],geobreit-breit[1]);
 END;
 IF(geobreit > breit[2]) AND (geobreit <= breit[3]) THEN BEGIN
   FOR m:= 1 TO 32 DO smax[m]:= inter(sstern[2,m],sstern[3,m],geobreit-breit[2]);
   FOR m:= 1 TO 32 DO gmax[m]:= inter(gstern[2,m],gstern[3,m],geobreit-breit[2]);
 END;

  IF(geobreit > breit[3]) AND (geobreit <= breit[4]) THEN BEGIN
   FOR m:= 1 TO 32 DO smax[m]:= inter(sstern[3,m],sstern[4,m],geobreit-breit[3]);
   FOR m:= 1 TO 32 DO gmax[m]:= inter(gstern[3,m],gstern[4,m],geobreit-breit[3]);
 END;

 IF(geobreit > breit[4]) THEN BEGIN
   FOR m:= 1 TO 32 DO smax[m]:= sstern[4,m];
   FOR m:= 1 TO 32 DO gmax[m]:= gstern[4,m];
 END;

 l:=length(name);
 i:=pos('\wet',name);

 if i>0 then
 begin
 i:=i+4;

 wst:=copy(name,i,l-i+1);
 j:=1;
  while not( pos(wst[j],'0123456789')>0 )
  and   ( j<length(wst)              ) do inc(j); //l zeigt auf die erste ziffer

 wetstat:=copy(name,1,i+j-2);
 yr_len :=length(wst)-j+1;
 end else
 begin
   wetstat:=name;
   yr_len :=0;
   adofile:=tfdquery.Create(nil);
   if cdyaparm<>nil then adofile.Connection:=dbc; //allg_parm.Connection;
 end;
end;

destructor  Tdbwetter.done;
begin
 adofile.Close;
// adofile.Free;
// Twetterobj.
 inherited done;
end;


procedure   Tdbwetter.yr_init(jahr:integer);
var _jahr    :string;
    ok:boolean;


begin
 str(jahr:4,_jahr);
 ok:=load_dbf(wetstat,_jahr);
 // ok:=false;
 if not ok then
 begin
  // Umschalten auf Zufallswetter
  if rwo=nil then
  begin
  rwo:=Trndwetter.create(1,1,1,1,wetstat,1);         //randseed=1
  rwo.YR_init(jahr);
  awo:=rwo;
  end;
  end
 else
 begin
  nied_sum:=0;
  glob_sum:=0;
  ltem_sum:=0;
  heute:=wett_anf;
  gestern:=wett_anf;
  vorgestern:=wett_anf;
 end;
end;

function Tdbwetter.load_dbf(wstat,jahr_:string):boolean; //bde_version(dbname:string);
var  dat, _datum,   dbdat   :string;
    d_step,              // Schrittweite: 1,5,10,30 tag,pen-,dekade,monat
     month ,dnr       :integer;
    r_days,  nied_s,   nied_a,   sonn    :real;
    ok      :boolean;

function regentag( tag,jahr:integer; regentage:real):boolean;
CONST
  mol: array[1..12] of integer = (31,28,31,30,31,30,31,31,30,31,30,31);
var m_tag, m,i  :integer;
    no_r_tag:real;

begin
  m_tag:=tagdat(tag,jahr);
  m:=monat(tag,jahr);
  no_r_tag:=mol[m]-regentage;
 if (regentage<15) and (regentage>0) then
 begin
  i:= floor( mol[m]/regentage);
  regentag:=  (m_tag mod i = 0 ) and (floor(m_tag/i) <regentage);
//  if i>0 then  regentage:= floor(mol[m]/i);
 end
 else
  begin
    if no_r_tag>0 then
    begin
      i:= floor( mol[m]/no_r_tag);
     //  no_r_tag:= floor(mol[m]/i);
     //  regentage:=mol[m]-no_r_tag;
    regentag:= not ( (m_tag mod i = 0 )  and (floor(m_tag/i) <no_r_tag)     );
    end else regentag:=true;
  end;

end;

function sonn2glob(sd,gbr:real;dnr:integer):real;
var m:integer;
    a,b,c,g:real;
begin
      {Sonnenscheindauer umrechnen}
       m:= 0;
       REPEAT
         m:= succ(m);
       UNTIL ( tag[m+1]>=dnr); {zum 1. Mal zwischen m u. m+1 interpolieren}
       {if dnr>tag[m+1] then m:=succ(m);}
       a:= interp(smax[m],smax[m+1],tag[m],tag[m+1],dnr-tag[m]);  {1/100 Std.}
       b:= interp(gmax[m],gmax[m+1],tag[m],tag[m+1],dnr-tag[m]);  {0.01 MJ/m**2}
       c:= 100 * sd;                                  {1/100 Std.}
       g:= (b * (0.2 + 0.6 * c/a));
       sonn2glob:=g;
end;

begin //load_db
 jahr:=jahrzahl(swet.datum);
 if jahr<0 then jahr:=strtoint(jahr_);    // in swet stand kein gültiges Datum
 if adofile=nil then
 begin
   adofile:=tfdquery.Create(nil);
   dbc.Open;
   adofile.Connection:=dbc;
 end;
 adofile.close;
 adofile.SQL.Clear;
 heute:=wett_anf;
 yr_dummy;
 if dbc.Params.DriverID='PG'
 then  adofile.SQL.Add('select * from cdy_cldat where wstat='+''''+wstat+''''+' and extract (year from datum)='+inttostr(jahr)+' order by datum')
 else
 adofile.SQL.Add('select * from cdy_cldat where wstat='+''''+wstat+''''+' and year(datum)='+inttostr(jahr)+' order by datum');
 adofile.Open;
 adofile.fetchall;
 adofile.First;
 if adofile.RecordCount>=365 then
  begin
   load_dbf:=true;
   ok_x:= (adofile.FindField('LTMAX')<>nil);
   ok_m:= (adofile.FindField('LTMIN')<>nil);
   ok_w:= (adofile.FindField('WINDSPEED')<>nil);
   ok_l:= (adofile.FindField('LFEU')<>nil);
   ok_sonn:= (adofile.FindField('SONN')<>nil);
   ok_p:= (adofile.FindField('PET')<>nil);
   ok_gwd:= (adofile.FindField('GWD')<>nil);
   ok_ncgw:= (adofile.FindField('GWN')<>nil);
   ok_btem:= (adofile.FindField('soil_temp')<>nil);
   ok_bfeu:= (adofile.FindField('soil_theta')<>nil);

   dnr:=0;
{$IFDEF CDY_SRV}
   dbdat:= datetostr(adofile.FieldByName('DATUM').AsDateTime,cdy_frmtSettings);
{$ENDIF}
{$IFDEF CDY_GUI}
   dbdat:= adofile.FieldByName('DATUM').AsString;
{$ENDIF}

   d_step:=1;   // Normalfall
   if ok_p then         add_message('PET from dbf') else add_message('calculated PET');

   case  dbdat[1] of
   'M': begin
            d_step:=30;
            add_message('Wetter in Monatswerten');
            nied_s:=adofile.FieldByName('NIED').AsFloat;
            r_days:=adofile.FieldByName('N').AsFloat;
            nied_a:=0;
        end;
   'P':  d_step:=5;
   'D':  d_step:=10;
   end;
   repeat
  //  DateFullYear := True;

{$IFDEF CDY_SRV}
   dbdat:= datetostr(adofile.FieldByName('DATUM').AsDateTime,cdy_frmtSettings);
{$ENDIF}
{$IFDEF CDY_GUI}
   dbdat:= adofile.FieldByName('DATUM').AsString;
{$ENDIF}



     inc(dnr);
     dat:=dbdat;
     _datum:=datum(dnr,jahr);
     if d_step<>1 then dat:=_datum;
     month:=monat(dnr,jahr);
     heute^.datum:=dat;
     if ok_x then heute^.ltmax:= adofile.fieldbyname('LTMAX').asfloat else heute^.ltmax:=-99.9;
     if ok_m then heute^.ltmin:=adofile.fieldbyname('LTMIN').asfloat else heute^.ltmin:=-99.9;
     if ok_l then heute^.lfeu:=adofile.fieldbyname('LFEU' ).asfloat else heute^.lfeu:=-99.9;
     if ok_w then heute^.wspeed:=adofile.fieldbyname('WINDSPEED').asfloat else heute^.wspeed:=-99.9;
     if ok_p then heute^.pet:=adofile.fieldbyname('PET').asfloat else heute^.pet:=-99.9;
     if ok_gwd then heute^.gwd:=adofile.fieldbyname('GWD').asfloat else heute^.gwd:=std_gwd;
     if ok_ncgw then heute^.ncgw:=adofile.fieldbyname('NCGW').asfloat else heute^.ncgw:=0;
     if ok_sonn then heute^.sonn:=adofile.fieldbyname('SONN').asfloat else heute^.sonn:=-99.9;
     if ok_btem then heute^.btem:=adofile.fieldbyname('soil_temp').asfloat else heute^.btem:=-99.9;
     if ok_bfeu then heute^.theta:=adofile.fieldbyname('soil_theta').asfloat else heute^.theta:=-99.9;
     heute^.ltem:=adofile.fieldbyname('LTEM').asfloat;
     if (d_step=30) and (nied_a<=nied_s) and (monat(dnr+1,jahr)>month) then
     begin
       heute^.nied:= nied_s-nied_a;
     end
     else
     if d_step=1 then  heute^.nied:=adofile.fieldbyname('NIED').asfloat //# dbfile^.get_real('NIED',heute^.nied)
                 else begin
                       if regentag(dnr,jahr,r_days) then
                                                     begin
                                                       heute^.nied:=nied_s/r_days;
                                                       nied_a:=nied_a+heute^.nied;
                                                       if nied_a>nied_s then
                                                       begin
                                                        heute^.nied:=nied_s-nied_a;
                                                        nied_a := nied_s;
                                                        end;
                                                     end
                                                    else heute^.nied:=0;
                      end;

     ok_glob:= (adofile.FindField('GLOB')<>nil);
     if ok_glob then heute^.glob:=adofile.fieldbyname('GLOB').asfloat //#dbfile^.get_real('GLOB',heute^.glob)
           else
            begin
              sonn:=adofile.fieldbyname('SONN').asfloat;
            end;
     if heute^.glob<0 then
     begin
      sonn:=adofile.fieldbyname('SONN').asfloat;
      heute^.glob:=sonn2glob(sonn,geobreit,julday(dat));
      end;

     if (d_step=1 )
     or ( (d_step=30) and (monat(dnr+1,jahr)>month))
     then begin
            adofile.Next;
            ok:=not(adofile.eof);
            if d_step>1 then
            begin    //Korrektur der r_days
             nied_s:=adofile.fieldbyname('NIED').asfloat;
             r_days:=adofile.fieldbyname('N').asfloat;
             nied_a:=0;
            end;
          end;
     heute:=heute^.next;
   until (not ok) or ( copy(_datum,1,6)='31.12.');
   heute:=wett_anf;
   adofile.Close;

  end
  else
  begin
  load_dbf:=false;
  end ;
     adofile.Free;
     adofile:=nil;
  end;


constructor Textwetter.create(tb: Real; tu: Real; rf: Real; gbr: Real);
begin
 _first:=true;

    ext_src:=true;
    tbed:=cdyaparm.parm('TBED');
    tunb:=cdyaparm.parm('TUNB');

end;

destructor Textwetter.done;
begin
  ewo.free;
end;

procedure Textwetter.nied2wett(x: Real);
begin
  heute.nied:=x;
end;

procedure Textwetter.temp2wett(x: Real);
begin
  heute.ltem:=x
end;


procedure Textwetter.glob2wett(x: Real);
begin
  heute.glob:=x
end;


procedure Textwetter.locate_at(t,j:integer);
var
    tag:dt;
begin

   tag:= yearstring(j)
        +copy(datum(t,j),4,2)
        +copy(datum(t,j),1,2);
if (_first)  or (j<>dbfyear(heute.datum)) then
 {neues Jahr vorbereiten}
 begin
  yr_init(j);
 end;{neues Jahr vorbereiten}

 if _first then
 begin
 // ?
 end;
 //positionieren
 //heute:=wett_anf;
 repeat
   heute:=heute.next;
 until (heute.datum=datum(t,j)) or (heute=nil) ;

end;

begin
end.
