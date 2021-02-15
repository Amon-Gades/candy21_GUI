{
 collection of routines that are used at several occasions
}
{$INCLUDE cdy_definitions.pas}



unit cnd_util;

interface
uses
{$IFDEF CDY_GUI}
cdy_glob, forms,windows,
{$ENDIF}
{$IFDEF CDY_SRV}
cdy_config,
{$ENDIF}

cnd_vars,sysutils,classes, strutils;

type dt =string[10];
     zeike=string;
     str4= string[4];
     bild = array [1..1920] of word;

var waitstate,step_run: boolean;
    wait_count        :integer;

      function acos(x:real):real;
//      function tan(x:real):real;
{      function min(x,y:real):real;}
//      function max(x,y:real):real;
{      function exp(e:real):real;}
  {    function ln(q:real):real;}
//function pot(b,e:real):real;
Function ist_schaltjahr(j:integer):boolean;

function  w_m_z(_fat,nied,ltem:real):real;
//function  sockel(x,s:real):real;
FUNCTION  datum(t,J: INTEGER):dt;
FUNCTION  essdatum(t,J: INTEGER):string;
function  makedbfdat(d:string):string;
function  daynr(datum:string):integer;
function  dbfdaynr(datum:dt):integer;
function  CAPITAL (X:ZEIKE):zeike;
function  yearstring(j:integer):str4;
//function  jahrzahl(datum:string):integer;
function  longjahrzahl(datum:string):integer;
function  dbfyear(datum:dt):integer;
//function  trimm(wort:zeike):zeike;
procedure suche(name:zeike; var gefunden:boolean);
//procedure datei_fehlt(var name:zeike);
//procedure open(Var dat:text ; name:zeike);
//procedure backup(name:zeike);
function  tanhyp(x:real):real;
function  N_upt(t,t0:integer;v,s:real):real;
//function  Minimum(x,y:real):real;
procedure kill_ops_fra(var x:sysstat);
function  ops_n(s:sysstat):real;
function  ops_c(s:sysstat):real;
function  obs_n(s:sysstat):real;
function  obs_c(s:sysstat):real;
function  aos_c(s:sysstat):real;
function  os_n(s:sysstat):real;
function  os_c(s:sysstat):real;
function  numstring(x:real;n:integer):string;
procedure msg_init;
procedure add_message(info:string);
//procedure ask_keyboard(var bruch:boolean);
function  aussaatjahr(mnd:mndptr):boolean;
procedure next_day(var s:sysstat);
function  real2string(x:real;n,k:integer):string;
function  os_equal(os1,os2:integer):boolean;
function  get_item(var f:text):string;
function  dbdatum(tag,jahr:integer):longint;
//function  qtime2dt(qt:integer):dt;
function  jul_day(d,m,a:integer):longint;
//procedure DateToDMY(Julian: longint;var Day,Month,Year: Word);
function julday(datum:string):integer;
function  day_diff(d1,d2:string):longint;
function  monat(dnr,jahr:integer):integer;
function  tagdat(dnr,jahr:integer):integer;
function nvt(mue,sigma:real): real;{Erzeugung einer Normalvert. ZGR }
function n_min_soil(s:sysstat;d:integer):real;
//function gis_mode_fn(sp:Tsimparm; rp:string):string;
function gis_mode_fn(sp:TESScdyconnex; rp:string):string;
//FUNCTION interp(w1,w2,t1,t2,t3: INTEGER) : REAL;
//FUNCTION inter(w1,w2: INTEGER; db: REAL) : INTEGER;
//function jahrzahl4(s:string):integer;
function a2p(s:string):string;
implementation
  //K  uses twcn1d_7;

function a2p(s:string):string;
var h:string;
begin
 h:=replaceStr (s, '[', ' '  );
 h:=replaceStr (h, ']', ' '  );
 a2p:=h;
end;

function jahrzahl4(s:string):integer;
var j,h:integer;
begin
 j:=-1;
 if length(s)=10 then
    begin
     val(copy(s,7,4),j,h);
     if h<>0 then j:=-1;
    end;
 jahrzahl4:=j;
end;
FUNCTION inter(w1,w2: INTEGER; db: REAL) : INTEGER;
     {Interpolieren in sstern u. gstern fuer smax u. gmax f. geogr. Breite Station}
     VAR a: REAL;
     BEGIN
       a:= w1 + (w2 - w1) / 2 * db;
       inter:= ROUND(a);
     END;

FUNCTION interp(w1,w2,t1,t2,t3: INTEGER) : REAL;
     {Interpolieren zwischen den Stuetzstellen in smax und gmax}
     BEGIN
       interp:= w1 + (w2 - w1) / (t2 - t1) * t3;
     END;
function gis_mode_fn(sp:TEsscdyconnex; rp:string):string;
var h,f:string;
begin
 f:=extractfilename(rp);
 h :=extractfilepath(rp)+leftstr(f,pos('.',f)-1)+'GIS'+sp.datenbank+sp.simobject {object_id};
  gis_mode_fn:=h;
end;

function n_min_soil(s:sysstat;d:integer):real;
var x:real;
    I:integer;
begin
 x:=s.ks.nobfl;
 for i:=1 to d do x:=x+s.ks.nin[i]+s.ks.amn[i];
 n_min_soil:=x;
end;

function nvt(mue,sigma:real): real;{Erzeugung einer Normalvert. ZGR }
var r,x:real;

begin
  randomize;
  r:=random;
  x:=1/(sqrt(8/pi))*ln((1+r)/(1-r));{positiv abgeschnittene NV}
  r:=random;
  if r<0.5 then
    x:=-x;
  if  (mue=1) and (sigma=0) then
    nvt:=x
  else
    nvt:=sqrt(sigma)*x+mue; {Verschiebung falls keine normierte Normalvert. vorliegt}
end;


      function acos(x:real):real;
      var y,a:real;
      begin
       y:=sqrt(1-x*x)/x;
       if x>0 then a:=arctan(y) else a:=pi+arctan(y);
       acos:=a;
      end;
      function tan(x:real):real;
      begin
       tan:=sin(x)/cos(x);
      end;


{      function min(x,y:real):real;
      var m:real;
      begin
        m:=x;
        if y<x then m:=y;
        min:=m;
      end;                          }
      function max(x,y:real):real;
      var m:real;
      begin
        m:=x;
        if y>x then m:=y;
        max:=m;
      end;

{     function ln(q:real):real;
     begin
       if q<3e-39 then
         begin
           writeln('Fehler: Der an ln bergebene Wert ist zu klein');
           Halt(2);
         end
       else ln:=system.ln(q);
     end;                       }
        {
     function exp(e:real):real;
     begin
       if e<ln(6e-35) then exp:=0 else  exp:=system.exp(e);
     end;
       }
     function pot(b,e:real):real;
     var p:real;
     begin
      p:=0;
      if b>0 then p:=exp(e*ln(b)) else
      if b=0 then p:=1 else
      begin
        writeln('Fehler beim Potenzieren: Basis war ',b);
        Halt(5);
      end;
      pot:=p;
     end;




function dbdatum(tag,jahr:integer):longint;
var z:longint;
begin
 z:=10000*round(tag*1.0);
 z:=z+round(jahr*1.0);
 dbdatum:=z;
end;
function  monat(dnr,jahr:integer):integer;
var dat:string;
    t,h:integer;
begin
 dat:=datum(dnr,jahr);
 dat:=copy(dat,pos('.',dat)+1,2);
 if dat[2]='.' then dat:=dat[1];
 val(dat,t,h);
 monat:=t;
end;

function  tagdat(dnr,jahr:integer):integer;
var dat:string;
    t,h:integer;
begin
 dat:=datum(dnr,jahr);
 dat:=copy(dat,1,pos('.',dat)-1);
 val(dat,t,h);
 tagdat:=t;
end;
 {
  This is from a really old HP book which I used for writing programs back in
the seventies. Note that it's Y2K compliant, but not Y2.1K compliant.

March 1 1700 is day 1. But do not use for days previous to February 18,
1900 or for days after February 28, 2100.

N(M,D,Y) = int(365.25 g(y,m)) + int(30.6 f(m)) + D - 621049

where g(y,m) = y-1 if m=1 or 2, or y if m>2
f(m) = m+13 if m= 1 or 2, or m+1 if m>2

You'll have to do a subtract for the reference date
 }
function jul_day(d,m,a:integer):longint;
var jd:longint;
begin
if m<3 then jd:=trunc(365.25*(a-1)) + trunc(30.6*(m+13)) + d - 621049
       else jd:=trunc(365.25* a   ) + trunc(30.6*(m+1 )) + d - 621049;
jul_day:=jd;
end;

procedure DateToDMY(Julian: longint;var Day,Month,Year: Word);
  { Convert from a date to day,month,year }
var
  LongTemp: longint;
      Temp: Word;
begin
  if Julian <= 58 then
    begin
      Year := 1900;
      if Julian <= 30 then
        begin
          Month := 1;
          Day := succ(Julian)
        end
      else
        begin
          Month := 2;
          Day := Julian - 30
        end
    end
  else
    begin
      LongTemp := 4*longint(Julian) - 233;

      Year := LongTemp div 1461;
      Temp := LongTemp mod 1461 div 4 * 5 + 2;
      Month := Temp div 153;
      Day := Temp mod 153 div 5 + 1;
      inc(Year,1900);
      if Month < 10 then
        inc(Month,3)
      else
        begin
          dec(Month,9);
          inc(Year)
        end
    end
end;

function  qtime2dt(qt:integer):dt;
const _yd:array [1974..1997] of integer
         =(   0,  365,  731, 1096,
           1461, 1826, 2192, 2557,
           2922, 3287, 3653, 4018,
           4383, 4748, 5114, 5479,
           5844, 6209, 6575, 6940,
           7305, 7670, 8036, 8401);
var
jahr:integer;
d:dt;
begin
 qt:=qt+1;
 jahr:=1975;
 while qt>_yd[jahr] do
 begin
 inc(jahr);
 end;
 d:=datum(qt-_yd[jahr-1],jahr);
 qtime2dt:=d;
end;

function  day_diff(d1,d2:string):longint;
{Berechnung der Tagesdifferenz d1-d2}
{erwartetes Datumsformat: dd.mm.jjjj}
var d,m,j,h:integer;
    t1,t2,x:longint;
begin
  m:=0; j:=0;
  val(copy(d1,1,2),d,h);
  if h=0 then
  begin
    val(copy(d1,4,2),m,h);
    if h=0 then  val(copy(d1,7,4),j,h);
  end;
  if h<>0 then
  begin
   writeln('Datumfehler (d1)');
   halt;
  end;
  t1:=jul_day(d,m,j);
  val(copy(d2,1,2),d,h);
  if h=0 then
  begin
    val(copy(d2,4,2),m,h);
    if h=0 then  val(copy(d2,7,4),j,h);
  end;
  if h<>0 then
  begin
   writeln('Datumfehler (d2)');
   halt;
  end;
  t2:=jul_day(d,m,j);
  x:=t1-t2;
  day_diff:=x;
end;



function  get_item(var f:text):string;
var zeichen:char;
    wort   :string;
begin
{Aus einer geöffneten Datei soll der nächstfolgende Eintrag gelesen werden}
{1. evtl. anführende Leerzeichen überlesen}
read(f,zeichen);
while zeichen=' ' do read(f,zeichen);
{2. wort auslesen bis n„chstes Leerzeichen erscheint oder eof}
wort:=zeichen;
while (zeichen<>' ')   and (zeichen<>chr(10))
                       and (zeichen<>CHR(13))
                       and not (eof(f))
do begin
 read(f,zeichen);
 if   (zeichen<>' ')
  and (zeichen<>chr(13))
  and (zeichen<>chr(10))
 then wort:=wort+zeichen;
end;
if wort=chr(10) then wort:='';
get_item:=wort;
end;

function  makedbfdat(d:string):string;
var hdat:string;
begin
 hdat:=copy(d,7,4)+copy(d,4,2)+copy(d,1,2);
 makedbfdat:=hdat;
end;




function os_equal(os1,os2:integer):boolean;
var eta1,eta2,k1,k2,cn1,cn2:real;
    ok:boolean;
    name:string;
begin
 if os1=0 then
 begin
  os_equal:=false;
 end
 else
 begin
 opsparm.select(os1,name,ok);
 eta1:=opsparm.parm('ETA');
 k1  :=opsparm.parm('K');
 cn1 :=opsparm.parm('CNR');
 opsparm.select(os2,name,ok);
 eta2:=opsparm.parm('ETA');
 k2  :=opsparm.parm('K');
 cn2 :=opsparm.parm('CNR');
 os_equal:=(k1=k2) and (eta1=eta2) and (cn1=cn2);
 end;
end;

procedure next_day(var s:sysstat);
var schaltjahr:boolean;
   procedure new_year;
   begin
    s.ks.tag:=1;
    inc(s.ks.jahr);
   end;

begin
inc(s.daycount);
inc(s.ks.tag);
if s.ks.tag>365 then
  begin
    schaltjahr:= ((s.ks.jahr mod 4)=0);
    if ((s.ks.jahr mod 100)=0) then schaltjahr:=false;
    if ((s.ks.jahr mod 1000)=0) then schaltjahr:=true;
    if schaltjahr then   {im Schaltjahr}
                   begin
                      if  (s.ks.tag=367)  then new_year;
                   end
                  else   {kein Schaltjahr}
                   begin
                       if (s.ks.tag=366)  then new_year;
                   end;
  end;
end;
 (*
procedure backup(name:zeike);

var f    :file;
    ok   :boolean;
    cn,bn:string;
begin
  i:=pos('.',name);
  if i>0 then cn:=copy(name,1,i-1);   { Dateierweiterung entfernen }
  bn:=cn+'.bak';
  suche(bn,ok);
  if ok then
   begin
     assign(f,bn);
     erase(f);
   end;
  assign(f,name);
  rename(f,bn);
end;
     *)
function aussaatjahr(mnd:mndptr):boolean;
var aufgang,ernte : boolean;
begin
aufgang:=false;
ernte  :=false;
while (mnd<>NIL) and (mnd^.art<>2) do
 begin
  ernte:=(mnd^.art=2);
  if (mnd^.art=1) and not ernte then aufgang:=true;
  mnd:=mnd^.next;
 end;
aussaatjahr:=aufgang;
end;


 (*
function sockel(x,s:real):real;
var f:real;
begin
 if x<=s then f:=0 else f:=x-s;
 sockel:=s;
end;


procedure the_end;
var k:char;
begin
k:='.';
end;


procedure ask_keyboard(var bruch:boolean);
begin
 if step_run then dec(wait_count);
 waitstate:=waitstate or (step_run and (wait_count=0));
 repeat
  application.processmessages;
 until (not waitstate) or abbruch;
 bruch:=abbruch;
end;
        *)
procedure msg_init;
begin
 msg_count:=0;
 first_msg:=Tstringlist.create;
 first_msg.clear;
 first_msg.add('Meldungen:');
end;


procedure add_message(info:string);
begin
send_msg(info,0);
end;





procedure bottom_line(bottline:string);
begin

end;

procedure message_bg(bottline:string;y:byte);
begin

end;



function Minimum(x,y:real):real;
begin
 if y<x then x:=y;
 minimum:=x;
end;

function tanhyp(x:real):real;
 begin
  tanhyp:= (exp(x)-exp(-x))/(exp(x)+exp(-x));
 end;

function N_upt(t,t0:integer;v,s:real):real;
var x:real;
 begin
    if t<t0 then t:=t+365 ;
  x     := (1+tanhyp((2*(t-t0)/v-1)*s)/tanhyp(s))/2;
  n_upt := x;
 end;





Function ist_schaltjahr(j:integer):boolean;
var schaltjahr:boolean;
begin
      schaltjahr:=(j mod 4 = 0);
  if (j mod 100 =0) then schaltjahr:=false;
  if (j mod 1000 =0) then schaltjahr:=true;
  ist_schaltjahr:=schaltjahr;
end;

FUNCTION datum(t,J: INTEGER):dt;
{Berechnung der Tages- und Monatszahl aus der Nummer t des Tages im Jahr }
TYPE
  feld = ARRAY[1..12] OF INTEGER;
CONST
  mol: feld = (31,28,31,30,31,30,31,31,30,31,30,31);
VAR
  monend: feld;
  m     : BYTE;
  ta,mo :integer;
  schaltjahr:boolean;
  h,h1      :dt;

BEGIN
  if t=0 then
  begin
   str((j-1):4,h);
   h1:=copy(h,3,2);
   datum:='31.12.'+h1;
   exit;
  end;
  schaltjahr:=(j mod 4 = 0);
  if (j mod 100 =0) then schaltjahr:=false;
  if (j mod 1000 =0) then schaltjahr:=true;
  mol[2]:= 28;
  IF SCHALTJAHR THEN mol[2]:= 29;
  monend[1]:= 31;
  FOR m:= 2 TO 12 DO monend[m]:= monend[m - 1] + mol[m];
  m:= 0;
  REPEAT
    if m=12 then
    begin
      m:=0;
      inc(j);
      t:=t-365;
      if schaltjahr then dec(t);
      schaltjahr:=(j mod 4 = 0);
    end;
    m:= succ(m);
  UNTIL (t <= monend[m]);
  mo:= m;
  IF(m = 1) THEN ta:= t ELSE ta:= t - monend[m - 1];
  str(ta:2,h);if h[1]=' ' then h[1]:='0'; h1:=   h+'.';
  str(mo:2,h);if h[1]=' ' then h[1]:='0';h1:=h1+h+'.';
  str( j:4,h);h1:=h1+h;// copy(h,3,2);
  datum:=h1;
end;

FUNCTION essdatum(t,J: INTEGER):string;
{Berechnung der Tages- und Monatszahl aus der Nummer t des Tages im Jahr }
TYPE
  feld = ARRAY[1..12] OF INTEGER;
CONST
  mol: feld = (31,28,31,30,31,30,31,31,30,31,30,31);
VAR
  monend: feld;
  m     : BYTE;
  ta,mo :integer;
  schaltjahr:boolean;
  h,h1      :string;

BEGIN
  if t=0 then
  begin
   str((j-1):4,h);
   h1:=copy(h,3,2);
   essdatum:='31.12.'+h;
   exit;
  end;
  schaltjahr:=(j mod 4 = 0);
  if (j mod 100 =0) then schaltjahr:=false;
    if (j mod 1000 =0) then schaltjahr:=true;
  if not schaltjahr and (t=366) then t:=365; {fr ringrechnungen}
  {diese funktion darf nur mit gltigen jahreszahlen aufgerufen werden}
  mol[2]:= 28;
  IF SCHALTJAHR THEN mol[2]:= 29;
  monend[1]:= 31;
  FOR m:= 2 TO 12 DO monend[m]:= monend[m - 1] + mol[m];
  m:= 0;
  REPEAT
    if m=12 then
    begin
      m:=0;
      inc(j);
      t:=t-365;
      if schaltjahr then dec(t);
      schaltjahr:=(j mod 4 = 0);
    end;
    m:= succ(m);
  UNTIL (t <= monend[m]);
  mo:= m;
  IF(m = 1) THEN ta:= t ELSE ta:= t - monend[m - 1];
  str(ta:2,h);if h[1]=' ' then h[1]:='0'; h1:=   h+'.';
  str(mo:2,h);if h[1]=' ' then h[1]:='0';h1:=h1+h+'.';
  str( j:4,h);h1:=h1+h;
  essdatum:=h1;
end;


function daynr(datum:string):integer;
TYPE
  feld = ARRAY[1..12] OF INTEGER;
CONST
  mol: feld = (31,28,31,30,31,30,31,31,30,31,30,31);
VAR

  d,j,h,m  : integer;
  mo       : real;
  schaltjahr : boolean;
begin
val(copy(datum,1,pos('.',datum)-1),d,h);
val(copy(datum,pos('.',datum)+1,2),mo,h);
m:=round(mo);
val(copy(datum,length(datum)-1,2),j,h);
schaltjahr:= (j mod 4)=0;
if (j mod 100 =0) then schaltjahr:=false;
if (j mod 1000 =0) then schaltjahr:=true;
if schaltjahr then mol[2]:=29 else mol[2]:=28;
h:=0;
for j:=1 to m-1 do h:=h+mol[j];
daynr:=h+d;
end;

function jahrzahl(datum:string):integer;
VAR
  j,h  : integer;
begin
val(copy(datum,length(datum)-1,2),j,h);
jahrzahl:=j;
end;

function w_m_z(_fat,nied,ltem:real):real;
var t:real;

    procedure wmz_pas(ltem, nied, fat: reaL; var wmz: real);
    { Berechnet mittleren Wert der wirksamen Mineralisierungszeit wmz
      fr Standort mit Jahresmittel der Lufttemperatur ltem
                   mit Jahresniederschlagssumme nied
                   mit Feinanteilgehalt fat}

    type feld1=array[1..7] of real;
    const
      {Abstufungen FAT-Werte der CROCANDY-Simulationsl„ufe}
      fattab: feld1=(6.0, 8.0, 11.5, 15.0, 22.0, 32.0, 44.0);
      {Regressionkoeffizienten des Modells
         WMZ = A*LTEM+B*NIED+C
       mit
         A,B,C: Funktionen von FAT.
       Funktionen sind fr FAT-Werte aus Feld fattab vorgegeben;
       dazwischen wird linear interpoliert}
       a: feld1=(3.3541, 3.1825, 3.0629, 2.1824, 2.1698, 2.0054, 1.8676);
       b: feld1=(0.015698, 0.01325, 0.003204, -0.009797, -0.02726,
                -0.03232, -0.03178);
       c: feld1=(9.0870, 10.2234, 14.5547, 23.0218, 23.6263, 22.9473, 22.9300);

    var
      i, i1: integer;
      p, h1, h2: real;

    begin
      {lineare Interpolation des FAT-Wertes, p: Gewicht auf fat-Strahl}
      i:=0;
      repeat
        inc(i)
      until (i=8) or (fat <= fattab[i]);

      case i of
        {alle Werte als fat=6 angenommen}
        1:      wmz:=a[1]*ltem+b[1]*nied+c[1];
        {lineare Interpolation notwendig}
        2,3,4,5,6,7: begin
                  i1:=i-1;
                  h1:=a[i1]*ltem+b[i1]*nied+c[i1];
                  h2:=a[i]*ltem+b[i]*nied+c[i];
                  p:=(fat-fattab[i1])/(fattab[i]-fattab[i1]);
                  wmz:=(1-p)*h1+p*h2;
                end;
        {alle Werte als fat=44 angenommen}
        8:      wmz:=a[7]*ltem+b[7]*nied+c[7];
      end;
    end;{wmz_pas}

begin
 nied:=minimum(nied,700);
 nied:=-minimum(-nied,-450);
  wmz_pas(ltem,nied,_fat,t);
 {w_m_z:=46.8-0.0861*_fat-0.00148*_fat*nied+0.0126*nied;}
 w_m_z:=t;
end;

function longjahrzahl(datum:string):integer;
VAR
  j,h  : integer;
begin
val(copy(datum,length(datum)-3,4),j,h);
longjahrzahl:=j;
end;

function dbfyear(datum:dt):integer;
var y,h:integer;
begin
 val(copy(datum,7,4),y,h);
 dbfyear:=y;
end;

function dbfdaynr(datum:dt):integer;
VAR
 t1,t0:Tdatetime;
 t0dt:string;
 dnr:integer;
begin
 dnr:=-99;
 if length(datum)=10 then
 begin
 t0dt:='01.01.'+copy(datum,7,4);
 t0:=strtodatetime(t0dt);
 t1:=strtodatetime(datum);
 dnr:=round(t1-t0)+1;
 end;
 dbfdaynr:=dnr;
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
 h:=0;m:=0;d:=0;
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


function CAPITAL (X:ZEIKE):zeike;
var i:byte;
begin
for I:=1 to length(x) do x[i]:=upcase(x[i]);
capital:=x;
end;

function yearstring(j:integer):str4;
var s:str4;
begin
str(j:4,s);
yearstring:=s;
end;
function numstring(x:real;n:integer):string;
var s:string;
begin
str(x:n:0,s);
numstring:=s;
end;

function trimm(wort:zeike):zeike;
var puf:zeike;
    i: integer;
 begin
 puf:='';
 for i:=1 to length(wort) do if wort[i]<>' ' then puf:=puf+wort[i];
 trimm:=puf;
end;

procedure suche(name:zeike; var gefunden:boolean);
var dat    :text;
    ec,cnt :byte;
begin
gefunden:=false;
cnt:=0;
while (cnt<20) and (not gefunden) do
begin

// if cnt>0 then delay(1000);
 inc(cnt);
 {$I-}
 assign(dat,name);
 reset(dat);
 {$I+}
 ec:=ioresult;
 if ec<15 then cnt:=28;
 gefunden:=(ec=0);

 end;
if gefunden then close(dat);
end;



procedure open(Var dat:text ; name:zeike);
begin
{$I-}
assignfile(dat,name);
reset(dat);
{$I+}
if ioresult<>0 then
               begin
               {
               writeln('Datei ',name,' kann nicht ge”ffnet werden!');
               writeln('    .... weiter mit jeder Taste');
               a:=readkey;
               halt;
               }
               end;
end;

procedure kill_ops_fra(var x:sysstat);

var   i,j,
      k,m   :    byte;
      kr    :    real;
      mini  :    real;
      ok    :    boolean;
      on    :    string;
begin
m:=0;
mini:=999999;
for  i:=1 to x.opsfra do
begin
 kr:=0;
 opsparm.select(x.ks.ops[i].nr,on,ok);
 for j:=1 to 3 do kr:=kr+x.ks.ops[i].c[j]*opsparm.parm('K');

{alte Version, es wird beim unterschreiten einer Schwelle gestrichen
 if kr<1 then
   begin
    for j:=1 to 3 do x.ks.amn[j]:=x.ks.amn[j]+x.ks.ops[i].c[j]/opsparm^.parm('CNR');
    dec(x.opsfra);
    for k:=i to x.opsfra do x.ks.ops[k]:=x.ks.ops[k+1];
    dec(i);
   end;
   inc(i);
}

{neue Version; es wird die kleinste C-Fluá-Menge eliminiert}
 if kr<mini then begin mini:=kr; m:=i; end;
{neue Version Ende}
end;{FOR i}

{neue Version: m-te Fraktion streichen}
    {N-Menge erhalten}
    opsparm.select(x.ks.ops[m].nr,on,ok);
    add_message(datum(x.ks.tag,x.ks.jahr)+' CANCEL '+on+' at '+real2string(mini,6,4));
    for j:=1 to 3 do
      x.ks.amn[j]:=x.ks.amn[j]+x.ks.ops[m].c[j]/opsparm.parm('CNR');
    {Fraktionszahl reduzieren}
    dec(x.opsfra);
    {Fraktionen neuordnen}
    for k:=m to x.opsfra do x.ks.ops[k]:=x.ks.ops[k+1];

    {C-Gehalte der neuen OPS-Fraktionen auf Null setzten}
    x.ks.ops[x.opsfra+1].c[1]:=0;
    x.ks.ops[x.opsfra+1].c[2]:=0;
    x.ks.ops[x.opsfra+1].c[3]:=0;

{neue Version Ende}

end;{kill_ops_fra}



function ops_n(s:sysstat):real;
var i,j: integer;
    su,
    cnr: real;
    n  : string;
    b  : boolean;
begin
 su:=0;
 for i:=1 to s.opsfra do   { Summe ber alle Fraktionen }
 begin
 opsparm.select(s.ks.ops[i].nr,n,b);
 cnr:=opsparm.parm('CNR');
 for j:=1 to s_max do      { Summe ber alle Schichten  }
     su:=su+s.ks.ops[i].c[j]/cnr;
 end;
 ops_n:=su;
end;


function ops_c(s:sysstat):real;
var i,j: integer;
    su : real;
begin
 su:=0;
 for j:=1 to s_max do      { Summe über alle Schichten  }
 for i:=1 to s.opsfra do   { Summe über alle Fraktionen }
     su:=su+s.ks.ops[i].c[j];
 ops_c:=su;
end;



function obs_c(s:sysstat):real;
var i :integer;
    su:real;
begin
su:=0;
for i:=1 to s_max do su:=su+s.ks.aos[i]+s.ks.sos[i];
obs_c:=su;
end;

function aos_c(s:sysstat):real;
var i :integer;
    su:real;
begin
su:=0;
for i:=1 to s_max do su:=su+s.ks.aos[i];
aos_c:=su;
end;

function obs_n(s:sysstat):real;
var amount:real;
begin
amount:=  obs_c(s)/cdyaparm.parm('CNR_OBS');                //fieldbyname('CNR_OBS').asfloat;
obs_n:=   amount;
end;

function os_n(s:sysstat):real;
begin
os_n:=obs_n(s)+ops_n(s);
end;

function os_c(s:sysstat):real;
begin
os_c:=obs_c(s)+ops_c(s);
end;

function real2string(x:real;n,k:integer):string;
var s:string;
begin
str(x:n:k,s);
real2string:=s;
end;

begin
msg_count:=-1;
waitstate:={true;//}false;
abbruch:=false;
end.
