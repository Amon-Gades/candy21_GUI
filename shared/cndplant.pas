{
 class definition of the ancestor of most other plant objects
}
{$INCLUDE cdy_definitions.pas}
unit cndplant;
interface
uses
{$IFDEF CDY_GUI}
cdy_glob,
{$ENDIF}
{$IFDEF CDY_SRV}
cdy_config,
{$ENDIF}

     cnd_vars,cnd_util,scenario,soilprf3,ok_dlg1,
     cdy_bil,math,sysutils,cndmulch;
type pcndpflan = ^cndpflan;
     cndpflan  = class(Tobject)
               kp_abfuhr,
               aufgang,
               selbsternten :boolean;
               erntebereit :byte;
               nert,
               ewr_name,
               pfl_name       : string;
               art,
               tempanf,
               atag,             {aktueller Tag}
               stag,             {Tage seit dem letzten Schnitt}
               schnitt_anz,
               matanf: integer;
               k_ewr,
               f_ewr,
               n_ewr_soll,
               nnat,
               xsi,
               lai,
               czep,
               iz_cap,
               a_tm_tot,
               a_tm_hp,
               a_tm_np,
               n_uptake,
               bgmax,
               wtinc,
               bhinc,
               bginc,
               bgdec,
               vegdau,
               steil,
               nbok,
               n_luft,
               p_n_release,       lmnr,
               s_n_release,
               a_n_release,
               lnub,
               ziel,
               ng_crop,
               kop_ops,        {Index der OPS des Koppelproduktes}
               HI,             {Harvestindex auf FM-Basis)}
               ontogenese,
               vwutief,        // virtuelle Wurzeltiefe ohne "Bodenbremse"
               daily_N_dem  : real;
               akt_vd_sum,     {Summe der Vegetationstage}
               akt_veg_day,    {Aktiver Vegetationstag (zwischen zwei Schnitten)}
               pot_veg_days,   {max Anzahl der Vegetationstage}
               pf_mod,
               dbgmax,
               tbgmax,
               tbhmax,
               bhmax,
               wtmax,
               grnd_id,         {OPS-index wenn bei Umbruch die oberirdische BM eingearbeitet wird}
               ewr_id        : integer;
               n_crop,          {Stickstoff im Bestand}
               n_shoot,         {       ... im oberird. Pfl.teil }
               c_shoot,
               n_root,          {       ... in unterird. Pfl.teil ausser EWR z.B. Rbenk”rper }
               c_root,
               n_ewr,           {Stickstoff in EWR}
               n_conc,
               cf_n2dm,         {Umrechnung Stickstoff oberirdisch -> TM}
               nit_yld,        {Stickstoff-Ertrag}
               heat_units             :real;
               fanf         : array[1..20] of byte;
               eyr,
               soildepth    :integer;
               fkp,
               pwp          :profil;
               ftabbew      :array[1..210] of real;
               ed: ertragsdaten;
               constructor create(var s:sysstat;mnd:pmmtent);
               procedure calc_n_dem(var s:sysstat);                   virtual;       //
               procedure n_2_crop(var s:sysstat; var n_bedarf:real);  virtual;
               procedure daystep(var s:sysstat;mnd:pmmtent);          virtual;  abstract;
               procedure ernte  (var s:sysstat);                      virtual;  abstract;
               procedure old_done(var s:sysstat);                    virtual;   abstract;
               procedure schnitt(var s:sysstat; schroepf:boolean);    virtual;

               procedure kill_crop(var s:sysstat);                    virtual;
               procedure interzeption(var s:sysstat);                 virtual;
               procedure _old_done(var s:sysstat);                    virtual;
               procedure _daystep(var s:sysstat;mnd:pmmtent);
               procedure _ernte  (var s:sysstat);
               procedure root_depth_pr;
               procedure entzugsanteile(VAR entnahme:REAL; pot,psi_,xsi_:REAL;tief:BYTE; bed:BOOLEAN;var s:sysstat);
               procedure transpiration(var s:sysstat;reduction:real);
               procedure calc_ftab(zetb:real);
               procedure get_koppel_ops(var c_ops,n_ops:real; var ops_id:integer);
               destructor done;
           //    procedure pfl_diagram(s:sysstat);
(*
               function  n_offtake:real;
               function  dm_yield_hp:real;
               function  dm_yield_np:real;
               function  C_pool_np:real;
*)


               end;
         pecc=^tecc;
         tecc=class(cndpflan)
               connexdaten:TEssCdyConnex;
               constructor create(var s:sysstat);
               destructor  done;
               procedure daystep(var s:sysstat;mnd:pmmtent);virtual;
               procedure interception(var s:sysstat);virtual;
               procedure n_2_crop(var s:sysstat; var n_bedarf:real);virtual;
               end;

implementation
       uses cdyspsys ;
//    uses cdyswat {, link2grami};

procedure tecc.daystep(var s:sysstat;mnd:pmmtent);
begin

end;

procedure tecc.interception(var s:sysstat);
begin

end;


procedure tecc.n_2_crop(var s:sysstat; var n_bedarf:real);
begin

end;


constructor tecc.create(var s:sysstat);
begin

end;

destructor tecc.done;
begin

end;


destructor cndpflan.done;
begin

end;




procedure cndpflan.get_koppel_ops(var c_ops,n_ops:real; var ops_id:integer);
var ts,cg,cn:real;
    ok:boolean;
    opsname:string;
begin
 c_ops :=0;
 ops_id:=0;

 ops_id:=round(kop_ops);
 opsparm.select(ops_id,opsname,ok);
 if ok then begin
              cg:=opsparm.parm('C_GEH_TS');
              cn:=opsparm.parm('CNR_ALT');
              ts:=opsparm.parm('TS_GEHALT');
              c_ops:=100*nnat*cg*ts*hi/ng_crop;  // 100: umrechnung von ng_crop [%..zahl]
              n_ops:=c_ops/cn;
            end
       else  c_ops:=-99;

end;



(*
procedure cndpflan.pfl_diagram(s:sysstat);
begin

try
if prmdlgf.cdy_prs.checked then
begin
{
 heat_units:=heat_units+s.wett.lt;
 cdymain.xygraph1.plotting:=false;
 cdymain.xygraph1[1][s.ks.tag]:=s.ks.kumpflent;
 cdymain.xygraph1[2][s.ks.tag]:= a_tm_tot/100;//tmakt;
 cdymain.xygraph1[4][s.ks.tag]:= heat_units; //ts_akt/10;
if n_conc<>-99 then cdymain.xygraph1[3][s.ks.tag]:= n_conc; //cakt;
 cdymain.xygraph1[5][s.ks.tag]:=s.wett.trans;
 cdymain.xygraph1[6][s.ks.tag]:=s.ks.bedgrd;
 cdymain.xygraph1.plotting:=true;
 }
end;
except;

end;

end;
 *)
procedure cndpflan.calc_ftab(zetb:real);
var    mz,nz : byte;

FUNCTION f(m,n:BYTE; zeta:REAL) : REAL;
{Berechnung der potentiellen Entzugsanteile}
VAR  c1, c2, c3: REAL;
BEGIN
  f:=0;
  IF(m <= n) THEN BEGIN
    IF(n = 1) THEN f:=1
    ELSE IF (ABS(zeta) <= 1E-03) THEN f:=2/n - 1/(n * n) * (2 * m - 1)
      ELSE BEGIN
        c1:=1 + zeta;
        c2:=(n + zeta * m)/(n +zeta * (m - 1));
        c2:=LN(c2);
        c3:=zeta/(n * c1);
        c2:=c2 - c3;
        c3:=LN(c1) - zeta/c1;
        f:=c2/c3;
      END;
  END;
END;


begin
{---potentielle Entnahmeanteile------------------------------------------}
      fanf[1]:=1;
      FOR mz:=2 TO 20 DO fanf[mz]:=fanf[mz-1] + (mz -1);
      FOR nz:=1 TO 20 DO BEGIN          {bewachsen}
        FOR mz:=1 TO nz DO ftabbew[fanf[nz]+mz-1]:=f(mz,nz,zetb);
      END;
end;

PROCEDURE cndpflan.entzugsanteile(VAR entnahme:REAL; pot,psi_,xsi_:REAL;tief:BYTE; bed:BOOLEAN;var s:sysstat);
{Berechnung der Entzugsateile fuer die 20 Rechenschichten und des Gesamt-
entzuges a}
VAR g, rtag: ARRAY[1..20] OF REAL;     {Hilfsfelder}
    rmax,             { R_Faktor fuer max. Entzug}
    ri,               { R_Faktor, Zwischenwert}
    xsa,              {rel. krit. pfl.-nutzb. Wasservorrat}
    vorrat,           {nutzb. Wasservorrat in der Rechenschicht}
    kapaz:   REAL;    {(sickergr[i] - entgr[i])/10}
    m, n:    BYTE;
    ok:      BOOLEAN;
    zufuhr,
    Feu_min : Real;  { minimaler Wassergehalt}
    ntag    : byte;  { aktuelle Entnahmetiefe}
    psi: real;


FUNCTION r(pot, vorrat, kapaz, xsa:REAL; bed:BOOLEAN) : REAL;
{Reduktionsfaktor fuer 1 Rechenschicht}
VAR
   petm,       {max. taegl. pot. Evapotranspirationshoehe}
   petq,       {mittl. taegl. pot. Evapotranspirationshoehe}
   wkri:REAL;  {krit. nutzb. Wasservorrat f. beginnende Reduktion}
BEGIN
  wkri:=kapaz;
  IF bed THEN BEGIN
    petm:=20;
    petq:=2.5;
    IF(pot > petq) AND (pot < petm) THEN wkri:=kapaz * (xsa + (1 - xsa)/
                                               (petm - petq) * (pot - petq));
    IF(pot <= petq) THEN wkri:=kapaz * xsa/petq * pot;
  END;
  r:=1;
   IF(vorrat < wkri) THEN
                      if wkri>0 then r:=vorrat/wkri
                                else r:=0;
END;

BEGIN
   (*
  {neu: einfluß des Wurzelwiderstandes}
  srrr:=0;
   FOR m:=1 TO tief DO srrr:=srrr+(1-sprfl.rrr[m]);
   FOR m:=1 TO tief DO rwr[m]:=(1-sprfl.rrr[m])/srrr;
   // ideal wäre srrr=tief; wurzel effekt aggregiert:= srrr/tief
 if tief >0 then   rooting_impact:=srrr/tief
            else   rooting_impact:=0;

   // Hypothese neues psi:= psi_*rooting_impact;
    *)
   psi:=psi_ ;
  {ende neu}

  zufuhr:=s.infilt;
  FOR m:=1 TO 20{wtmax} DO s.entz[m]:=0;
  ntag:=0;
  IF(tief > 0) AND (psi >= 1E-03) THEN BEGIN
    FOR m:=1 TO 20 DO g[m]:=0;
    IF(zufuhr >= pot) THEN BEGIN   {Entzug nur aus 1. Schicht ohne Reduktion}
      entnahme:=pot * psi;
      s.entz[1]:=entnahme;
      ntag:=1;
    END ELSE BEGIN
      entnahme:=zufuhr * psi;
      pot:=pot - zufuhr;
      FOR m:=1 TO tief DO BEGIN
        if bed and (m<5) then feu_min:=candy.sprfl.pwp[m]*0.75 else feu_min:=candy.sprfl.pwp[m]{k_pwp[m]};
        vorrat:=s.ks.bofeu[m] - feu_min;
        IF(m = 1) THEN vorrat:=vorrat - zufuhr;
        IF(vorrat < 0) THEN vorrat:=0;
        kapaz:=candy.sprfl.fkap[m] - feu_min;
        xsa:=(xsi_ * candy.sprfl.fkap[m] - feu_min)/kapaz;
        IF(xsa < 0) THEN xsa:=0;
        // Steingehalt
        vorrat:=vorrat*(1-candy.sprfl.stone_cont[m]/100);
        kapaz:= kapaz*(1-candy.sprfl.stone_cont[m]/100);
        rtag[m]:=r(pot,vorrat,kapaz,xsa,bed);
      END;
      IF(tief = 1) THEN BEGIN   {Entzug aus 1.Schicht mit u. ohne Reduktion}
        s.entz[1]:= rtag[1] * pot * psi;
        entnahme:= entnahme + s.entz[1];
        s.entz[1]:=s.entz[1] + zufuhr * psi;
      END ELSE BEGIN       {Entzg aus mindestens 2 Schichten}
        n:=0;
        REPEAT
          n:=succ(n);
          ok:=FALSE;
          IF(rtag[n] > 0.99) THEN ok:=TRUE;
          IF(n=tief) THEN ok:=FALSE;
        UNTIL NOT ok;
        ntag:=n - 1;
        IF(n = tief) THEN ntag:=tief;
        IF(ntag > 0) THEN BEGIN   {Entzug aus den obersten ntag Schichten ohne
                                                                    Reduktion}
          FOR m:=1 TO ntag DO BEGIN
            IF bed THEN s.entz[m]:=ftabbew[fanf[ntag]+m-1]*pot*psi  {bewachsen}
            ELSE       {s.entz[m]:=ftabunb[fanf[ntag]+m-1]*pot*psi};{unbewachsen- entfällt hier - oder?}
            entnahme:=entnahme + s.entz[m];
          END;
          s.entz[1]:=s.entz[1] + zufuhr * psi;
        END ELSE BEGIN            {Entzug bis <= tief mit min. Reduktion}
          rmax:=0;
          n:=0;
          REPEAT
            n:=succ(n);
            ri:=0;
            {Jetzt vorlaeufige Entnahmeanteile}
            FOR m:=1 TO n DO BEGIN
              IF bed THEN g[m]:=rtag[m]*ftabbew[fanf[n]+m-1]*pot*psi  {bew.}
              ELSE{ g[m]:=rtag[m]*ftabunb[fanf[n]+m-1]*pot*psi};      {unbew.}
              IF(g[m] < 1E-07) THEN g[m]:=0;
              ri:=ri + g[m];
            END;
            ri:=ri/pot/psi;                            {0 <= ri <= 1}
            IF(ri - rmax >= -5E-04) THEN BEGIN
              ok:=TRUE;
              rmax:=ri;
              ntag:=n;
            END ELSE ok:=FALSE;
            IF(ntag=tief) THEN ok:=FALSE;
          UNTIL NOT ok;
          {Endgueltige Entnahmeanteile mit r = rmax}
          FOR m:=1 TO ntag DO BEGIN
            s.entz[m]:=g[m];
            entnahme:=entnahme + s.entz[m];
          END;
          s.entz[1]:=s.entz[1] + zufuhr * psi;
        END;
      END;
    END;
  END;
END;

{int_beg }
procedure cndpflan.interzeption(var s:sysstat);

{Berechnung der Interzeption und der Zufuhr zum Boden}
{die Bedeutung der Variablen ist im Vgl. zum Koitzschen Originaltext ver„ndert}
{bei Koitzsch wird unter stellt, daá die H„lfte des Interzeptionsspeichers am }
{gleichen tag verdunstet. Dies wird hier explizit ermittelt, deshalb sind die}
{Kapazitäten doppelt so hoch wie bei Koitzsch}

VAR iz_verd,z_max,azep: REAL;

BEGIN
  {nur wenn Lufttemperatur über 0.5 °C}
 iz_verd:=0;
 if s.wett.lt>0.5 then
 begin

  IF(s.ks.bedgrd=0) THEN
   BEGIN
    azep:=-s.ks.szep;  {Beim Umbruch gesp. Interzeption in 1. Rechenschicht}
    s.ks.szep:=0;      {negativer wert wird bei der abschließenden Bilanzgleichung positiv}
   END
   ELSE
   BEGIN {wenn Bedeckungsgrad >0}

    IF(s.wett.niedk < 0.01) THEN
      BEGIN   {Nur gesp. Interzeption verbrauchen}
       azep:=0;
       {
       if s.wett.pei>s.ks.szep then iz_Verd:=s.ks.szep
                               else iz_verd:=s.wett.pei;
       }
       iz_verd:=0;
      END
    ELSE
    BEGIN     {Erneut Interzeption auffüllen     }
     z_max:=iz_cap;
     azep := z_max - s.ks.szep;                {maximal mögl. Aufnahme in den}
                                               {IZ-Speicher ermitteln        }


     IF(azep > s.wett.niedk * s.ks.bedgrd)     {geringe Niederschläge total  }
      THEN azep:=s.wett.niedk * s.ks.bedgrd;   {dem IZ-Speicher zufügen      }
                                               {größere Niederschlagsmengen  }
                                               {füllen azep auf              }

     s.ks.szep:=s.ks.szep + azep;              {Interzeptionsspeicher füllen }

     iz_verd  :=s.ks.szep/2;                   {die Häflte verdunstet sofort  }
    END;
   END;

 s.ks.szep:=s.ks.szep-iz_verd;                 {aktuelle Menge im IZ-Speicher}
 s.infilt:=s.wett.niedk - azep;                {Niederschlag auf Bodenoberfl.}
 END;
end;
{int_end }


{tra_beg }
procedure cndpflan.transpiration(var s:sysstat;reduction:real);
var at,
    anspruch,
    k_pet: real;
    _tief:integer;
begin
  {bedeckte Entnahme nach Koitzsch }
  {Korrektur der potentiellen Entnahme durch Bestandeshöhe}
  k_pet:=1+min(s.ks.bestho,100)*0.004;
  {maximale Korrektur=1.4}
  anspruch:=s.trnsp_soll*k_pet*reduction;
  at:=0;
  _tief:=round(-max(-s.ks.wutief,-20));
  if (s.wett.lt<2.0) then _tief:=0;
  entzugsanteile(at,anspruch,s.ks.bedgrd, xsi ,_tief,TRUE,s);
  s.wett.trans:=at;
  if anspruch*s.ks.bedgrd>0 then  s.wett.trstr:=at/(anspruch*s.ks.bedgrd)
                            else  s.wett.trstr:=1;
  {  s.wett.wbil:=zufuhr-ube-at; }
end;
{tra_end }




(*
function cndpflan.dm_yield_hp:real;
var x:real;
begin
  x:=ed.dm_hp/10;
  dm_yield_hp:=x;
end;

function cndpflan.dm_yield_np:real;
var x:real;
begin
 x:=ed.dm_np/10 ;
 dm_yield_np:=x;
end;


function cndpflan.c_pool_np:real;
var x:real;
begin
 if pf_mod=3 then   x:=c_pool_np  else   x:=-99;
 c_pool_np:=x;
end;


  *)

constructor cndpflan.create(var s:sysstat;mnd:pmmtent);
var ok : boolean;
    jahr0,
    jahr1,
    tag     :integer;
  //  ftyp:feldatr;
    zetb,zetb_,czep_,fewr:real;
    modell:string;

begin

stag:=0;
hi:=0;
(*
try
if prmdlgf.cdy_prs.checked then
begin
{Grafik initialisieren}
//abhier vorläufig ausblenden
 heat_units:=0;
// trkplgr.show;

 cdymain.xygraph1.clearall;
 cdymain.xygraph1[3].whichYaxis:= cdymain.xygraph1.YAxis_second;
 cdymain.xygraph1[5].whichYaxis:= cdymain.xygraph1.YAxis_second;
 cdymain.xygraph1[6].whichYaxis:= cdymain.xygraph1.YAxis_second;
 for i:=1 to 6 do
 begin
 cdymain.xygraph1[i].legendstatus:=lsall;
 cdymain.xyGraph1[i].linestyle:=psDot;
 cdymain.xyGraph1[i].fillpoints:=true;
 cdymain.xygraph1.legend.visible:=true;
 end;
 {
  cdymain.xygraph1[1][s.ks.tag]:=s.ks.kumpflent;
 cdymain.xygraph1[2][s.ks.tag]:= a_tm_tot/100;//tmakt;
 cdymain.xygraph1[3][s.ks.tag]:= n_conc; //cakt;
 cdymain.xygraph1[4][s.ks.tag]:= heat_units; //ts_akt/10;
 cdymain.xygraph1[5][s.ks.tag]:=s.wett.trans;
 cdymain.xygraph1[6][s.ks.tag]:=s.ks.bedgrd;
 }
 cdymain.xyGraph1.Series[1].seriesname:='N in crop+root';
 cdymain.xyGraph1.Series[2].seriesname:='dry matter';
 cdymain.xyGraph1.Series[3].seriesname:='N conc';
 cdymain.xyGraph1.Series[4].seriesname:='heat units';
 cdymain.xyGraph1.Series[5].seriesname:='transpiration';
 cdymain.xyGraph1.Series[6].seriesname:='soil cover';
//bishier ausblenden
 end;
 except;end;
 *)
 {Transpirationsmodell initialisieren}


czep:=cdyaparm.parm('CZEP');
plantparm.is_field('CZEP',ok);
if ok then
begin
  czep_:=plantparm.parm('CZEP');  {eingefügt Puhl}
  if czep_<>czep then
  begin
     add_message('CZEP aus CDYPFLAN');
     czep:=czep_;
  end;
end;


xsi :=cdyaparm.parm('XSI');
candy.sprfl.put_maxdepth(soildepth);
candy.sprfl.put_fkap(20,fkp);
candy.sprfl.put_pwp(20,pwp);
zetb:=cdyaparm.parm('ZETB');
plantparm.is_field('ZETB',ok{,ftyp});
if ok then
begin
  zetb_:=plantparm.parm('ZETB');  {eingefügt Puhl}
  if zetb_<>zetb then
  begin
      add_message('crop specific ZETB value ');
      zetb:=zetb_
  end;
end;



calc_ftab(zetb);

selbsternten := false;

ERNTEBEREIT  := 0;
with last_yld do
begin
   valid       :=false;
   dm_hp       :=-99;
   dm_np       :=-99;
   fm_hp       :=-99;
   fm_np       :=-99;
   c_yld_hp    :=-99;
   c_yld_np    :=-99;
   n_yld_hp    :=-99;
   n_yld_np    :=-99;
   nat_yld_np  :=-99;
   nat_yld_hp  :=-99;
end;
lai:=-99;
a_tm_hp:=-99;
a_tm_np:=-99;
n_conc:=-99;
ontogenese:=-99;
schnitt_anz:=0;
//tag:=s.ks.tag;
tag:=day_diff(datum(s.ks.tag,s.ks.jahr),s.simanf);
if s.ks.pnr<>0
then       { Parameter aus Status übernehmen }
 begin
  plantparm.select(s.ks.pnr,pfl_name,ok);
  if not ok then
              begin
              //writeln('Fehler beim Lesen der Pflanzenparameter !');
              _halt(5);
              end;
//modell:= plantparm.ptab.FieldByName('modell').AsString;
  modell:=string(plantparm.get_pval(s.ks.pnr,'modell'));
  k_ewr  :=plantparm.parm('CEWR');
  f_ewr  :=plantparm.parm('FEWR');
  art        :=round(plantparm.parm('ART'));
  steil      :=plantparm.parm('STEIL');
  vegdau     :=plantparm.parm('VEGDAU');
  nbok       :=plantparm.parm('NBOK');
  lnub       :=plantparm.parm('LNUB');
  wtmax  :=round(plantparm.parm('WTMAX'));
  root_depth_pr;
  wtinc  :=1/plantparm.parm('WWG');
  tbhmax :=round(0.8*plantparm.parm('DBHMAX'));
  bhmax  :=round(plantparm.parm('BHMAX'));
  bhinc  := bhmax*0.8/tbhmax;   {   <= bhmax/dbhmax  }
  matanf :=round(plantparm.parm('MATANF'));
  tempanf:=round(plantparm.parm('TEMPANF'));
  bgmax  :=plantparm.parm('BGMAX');
  dbgmax :=round(plantparm.parm('DBGMAX'));
  cf_n2dm:=1/plantparm.parm('N_GEHALT');
  tbgmax :=round(0.8*DBGMAX);
  bginc  :=bgmax/tbgmax;
  s.fvirt:=1;
  n_uptake:=s.ks.kumpflent;
  if tag=0 then s.ks.besruh:=true;
  if  (s.ks.pnr=1)
  or ((s.ks.pnr=2) and (s.ks.forts=1) and not s.ks.besruh)
  then s.fvirt:=n_upt(s.ks.vegend,s.ks.veganf,vegdau,steil);
  if matanf>0 then bgdec:=bgmax/matanf else bgdec:=bgmax;
  iz_cap:=s.ks.bestho*s.ks.bedgrd*czep;
 end
else       { Aufgang }
 begin
  jahr0:=s.ks.jahr;
  n_uptake:=0;
  while not( mnd^.mmt.code in [1,12]) do mnd:=mnd^.next;  {auf richtigen Eintrag zeigen, falls mehrere Massnahmen}
  s.ks.pnr:=mnd^.mmt.qual;
  plantparm.select(s.ks.pnr,pfl_name,ok);
 // modell:= plantparm.ptab.FieldByName('modell').AsString;
  modell:=string( plantparm.get_pval(s.ks.pnr,'modell'));
   //modell:=x;

 // if pfl_name='paddy_rice' then _bw.lysimeter:=true else _bw.lysimeter:=ist_lysimeter;
  if not ok then
              begin
              add_message('Fehler beim Lesen der Pflanzenparameter !');
              _halt(5);
              end;

  s.ks.veganf:=tag;
  s.ks.forts :=0;
  s.ks.wutief:=0;
  s.ks.bestho:=0;
  s.ks.apool :=0;
  s.ks.szep  :=0;
  s.ks.kumpflent:=0;
  s.ks.bedgrd:=0;
  s.ks.besruh     :=false;


  plantparm.is_field('CZEP',ok{,ftyp});
  if ok then
    czep:=plantparm.parm('CZEP')  {eingefügt Puhl}
  else
    czep:=cdyaparm.parm('CZEP');
  plantparm.is_field('ZETB',ok{,ftyp});
  if ok then
    zetb:=plantparm.parm('ZETB')  {eingefügt Puhl}
  else
  zetb:=cdyaparm.parm('ZETB');
  art        :=round(plantparm.parm('ART'));
  if art in [3,4] then s.ks.legans:=true else s.ks.legans:=false;
  steil  :=plantparm.parm('STEIL');
  vegdau :=plantparm.parm('VEGDAU');
  k_ewr  :=plantparm.parm('CEWR');
  f_ewr  :=plantparm.parm('FEWR');
  nbok   :=plantparm.parm('NBOK');
  lnub   :=plantparm.parm('LNUB');
  plantparm.is_field('LMNR',ok);
  if ok  then   lmnr   :=plantparm.parm('LMNR') else  lmnr:=0.25;
  p_n_release:=0;
  s_n_release:=0;
  a_n_release:=0;
  wtmax  :=round(plantparm.parm('WTMAX'));
  root_depth_pr;
  if modell='CANDY_S' then
  begin
  wtinc  :=1/plantparm.parm('WWG');
  tbhmax :=round(0.8*plantparm.parm('DBHMAX'));
  bhmax  :=round(plantparm.parm('BHMAX'));
  bhinc  := bhmax*0.8/tbhmax;   {   <= bhmax/dbhmax  }
  matanf :=round(plantparm.parm('MATANF'));
  tempanf:=round(plantparm.parm('TEMPANF'));
  bgmax  :=plantparm.parm('BGMAX');
  dbgmax :=round(plantparm.parm('DBGMAX'));
  tbgmax :=round(0.8*DBGMAX);
  end
  else
  begin
    matanf:=1;
    tbgmax:=1;
  end;
  cf_n2dm:=1/plantparm.parm('N_GEHALT');

  n_ewr_soll:= mnd^.mmt.quan*f_ewr+k_ewr;    // Futterpflanzen

if (candy.scene.mnmt.actual.mmt.spez<>'*') and ((candy.scene.mnmt.actual.mmt.spez<>''))
  then   fewr:= f_ewr * 0.001 * strtofloat( candy.scene.mnmt.actual.mmt.spez)/cf_n2DM
  else  fewr:=f_ewr;
  ziel   :=mnd^.mmt.quan*(1+fewr)+k_ewr;

  bginc  :=bgmax/tbgmax;
  if matanf>0 then bgdec:=bgmax/matanf else bgdec:=dbgmax;
  s.ks.dbgmax:=tag+dbgmax;
  s.ks.tempanf:=tag+tempanf;

  while (mnd^.mmt.datum<>'ENDE') and not (mnd^.mmt.code in [0,2,9]) do mnd:=mnd^.next;
  if (mnd^.mmt.datum='ENDE') or (mnd^.mmt.code=0) then
              begin
               s.ks.vegend:=s.ks.veganf+round(vegdau);
               jahr1      :=0;
              end
             else
              begin
               s.ks.vegend:=  day_diff(mnd^.mmt.datum,s.simanf);              //dbfdaynr(mnd^.mmt.datum);
               jahr1      :=dbfyear(mnd^.mmt.datum);
               kp_abfuhr  :=(mnd^.mmt.qual=0);
              end;
  eyr:=jahr1;
  s.ks.matanf:=s.ks.vegend-matanf;
  s.fvirt:=1;
  s.nupt  :=0;
  s.symb_n:=0;
{Sonderfall: der WW wird im Erntejahr gesäät}
 if (s.ks.pnr=12) and (jahr1=jahr0) then
 begin
  s.ks.forts:=1;
  s.ks.besruh:=true;
 end;
 end;

 ewr_id := round(plantparm.parm('EWR_IX'));
 grnd_id:= round(plantparm.parm('GRD_IX'));

 {add_message(name+'ab '+datum(s.ks.tag,s.ks.jahr));}
 case art of
 1,3:  pot_veg_days:=s.ks.vegend-s.ks.veganf; {einj.Pflanzen}
   2:  pot_veg_days:=-99;                     {WW im Ansaatjahr}
 4,5:  pot_veg_days:=265;                     {ausdauernde Pflanzen}

 end;
 akt_veg_day:=0;
 akt_vd_sum:=0;

 {spezielle Parameter}
 plantparm.is_field('HI',ok{,ftyp});
 if ok then
 begin
  hi   :=plantparm.parm('HI');  //Harvestindex auf FM-Basis
  kop_ops:=plantparm.parm('KOP_IX');
  ng_crop:=plantparm.parm('N_GEHALT');
 end;
end;




procedure cndpflan._old_done(var s:sysstat);
begin
 s.ks.pnr:=0;
 s.ks.bedgrd:=0;
 s.ks.bestho:=0;
 s.ks.wutief:=0;
 s.ks.kumpflent:=0;
end;


procedure cndpflan.calc_n_dem(var s:sysstat);
begin
end;


procedure cndpflan.n_2_crop(var s:sysstat; var n_bedarf:real);
var n_supply,
    n_rest,
    n_schicht,
    amnu,
    ninu,
    max_nupt,
    x,
    sg         :real;
    tief       :integer;

    g          :profil;
    i          :integer;
begin
N_supply:=0;
max_nupt:=0;

sg:=0;
tief:=round(s.ks.wutief);
tief:=round(max(tief,1));
tief:=round(-max(-tief,-20));
for i:=1 to tief do
    if s.entz[i]>0 then
       begin
        n_schicht:=-min(0,-s.ks.nin[i]-s.ks.amn[i]+1);
        n_supply:=n_supply + n_schicht;
        max_nupt:=max_nupt + n_schicht*s.entz[i]/s.ks.bofeu[i];
        g[i]:=s.entz[i]*(n_schicht);
        sg:=sg+g[i];
       end
       else g[i]:=0;

 { in jeder Schicht bis "tief" soll }
 {  mindestens 1kg verbleiben       }

N_Bedarf:=Min(N_bedarf,N_supply);

n_rest:=0;
if n_bedarf>0 then
for i:=1 to tief do
begin
  s.n2crop[i]:=0;
//  amnu:=0;
//  ninu:=0;
  s.n2crop[i]:=s.ks.amn[i]+s.ks.nin[i];
  if s.entz[i]>0 then
    begin
     N_Schicht:=N_Bedarf*g[i]/SG+N_rest;
     AMNU     :=Min(n_schicht*s.ks.amn[i]/(2*s.ks.nin[i]+s.ks.amn[i]+0.1),s.ks.amn[i]-1);
     AMNU     :=max(amnu,0);
     s.ks.amn[i]:=s.ks.amn[i]-amnu;
     ninu     :=min(s.ks.nin[i]-0.1,N_schicht-amnu);
     if ninu<0.001 then ninu:=0;
     if (s.ks.nin[i]-ninu)>0 then s.ks.nin[i]:=s.ks.nin[i]-ninu
                             else ninu:=0;
     N_rest:=n_schicht-amnu-ninu;
     if n_rest>0 then
      begin
       amnu:=min(N_rest,s.ks.amn[i]);
       s.ks.amn[i]:=s.ks.amn[i]-amnu;
       n_rest:=n_rest-amnu;
      end;
    end;
  s.n2crop[i]:=s.n2crop[i]-s.ks.amn[i]-s.ks.nin[i];
 end; //for
{Fehlerkontrolle:}
for i:=1 to tief do
 begin
 if (s.ks.nin[i]<0) or (s.ks.amn[i]<0) then
          begin
          add_message('Fehler gefunden(Pflanze): Nan < 0 am '+datum(s.ks.tag,s.ks.jahr));
          _halt(17);
          end;
 end;
 s.nupt:=n_bedarf-n_rest;
 x:=s.n2crop[1];
 for i:=2 to tief do x:=x+s.n2crop[i];
 if abs(s.nupt-x)>0.000001 then
 begin
   s.n2crop[1]:=s.nupt;
 end;
 n_bedarf:=max_nupt;
end;
{pf_b_end}

{pf_a_beg}
procedure cndpflan._daystep(var s:sysstat; mnd:pmmtent);
var  n_bedarf :real;
    tief:integer;

      FUNCTION aktuell(anfang,ende,i:integer;pa,pe:real):real;
      VAR x,y :real;
      BEGIN
       IF i<=anfang THEN aktuell:=pa
                    ELSE IF i>=ende THEN aktuell:=pe
                                    ELSE
                                    BEGIN
                                    y:=i-anfang;
                                    x:=ende-anfang;
                                    aktuell:=pa+(pe-pa)*y/x;
                                    END;
      END;


      procedure reife_termine(mnd:pmmtent);
      var tagnr:integer;
      begin
      while  ( mnd <> nil )and ( mnd^.mmt.code<>2 )   do mnd:=mnd^.next;
      if mnd = nil
       then
        begin
        s.ks.vegend := s.ks.veganf + round(vegdau);
        s.ks.matanf := s.ks.veganf + round(vegdau) - matanf;
        end
       else
        begin
      //  tagnr:= {day_diff(cdy.simanf,}dbfdaynr(mnd^.mmt.datum);
        tagnr:=day_diff(mnd^.mmt.datum,s.simanf);
        s.ks.vegend := tagnr;
        s.ks.matanf := tagnr   - matanf;
        end;
      end;


begin

  {Transpiration - an dieser Stelle aus Kompatibilitätsgründen}
 transpiration(s,1);
 if not s.ks.besruh then inc(akt_veg_day);
 atag:= s.daycount;//s.ks.tag;
 tief:=round(s.ks.wutief);
 if tief>20 then tief:=20;
 { Prüfung ob Vegetationsruhe eintritt }
 // neu für intas
 if not s.ks.besruh
    and (art=2)
    and (s.ks.forts=0)
    then
    begin
     s.ks.besruh:=  ((s.wett.lt<5) and (s.wett.ltg<5) and (s.wett.ltvg<5)) or (s.ks.tag={365}veg_brk);       //#turning point
    end;
 { Prüfung ob weiter Vegetationsruhe erforderlich }
 // 4 intas:
 if s.ks.besruh then s.nupt:=0;
 if (s.ks.besruh) and (s.ks.forts=1) then
          begin
           s.ks.besruh:=not((s.wett.lt>=5) and (s.wett.ltg>=5) and (s.wett.ltvg>=5));
           if not s.ks.besruh then
                         begin
                          s.ks.veganf:= s.daycount;//s.ks.tag;
                          if art=2 then
                            begin
                             s.ks.apool  :=s.ks.kumpflent;
                             s.ks.tempanf:=tempanf+s.daycount;//s.ks.tag;
                             s.ks.dbgmax :=dbgmax+s.daycount;//s.ks.tag;
                             reife_termine(mnd);
                             pot_veg_days:=s.ks.vegend-s.ks.veganf;
                             s.fvirt:=n_upt(s.ks.vegend,s.ks.veganf,vegdau,steil);
                             s.ks.nvirt:=s.ks.nvirt/s.fvirt;
                            end;
                         end;
          end;


{ Dämpfungsparameter für das Temperaturmodell }

       if (s.ks.pnr<>0) and not( (art=2)and(s.ks.forts=0) )
       then
       begin
         s.plantparm1:=aktuell(s.ks.tempanf,s.ks.dbgmax,atag,0,0.9);
         s.plantparm2:=aktuell(s.ks.tempanf,s.ks.dbgmax,atag,1,0);
       end else
       begin
         s.plantparm1:=0;
         s.plantparm2:=1;
       end;
if s.ks.besruh then
    begin
    { add_message('Ruhe sanft');}
     exit;
    end;



{ Pflanzenparameter für das Wassermodell }
 if ( not s.ks.besruh) then if (s.wett.lt>4.9)
 then
 begin
   if (art=2) and (s.ks.forts=0)
   then
    begin
    { Wintergetreide im Ansaatjahr }
    { Bedeckungsgrad }
    if s.ks.bedgrd< 0.2 then s.ks.bedgrd:= aktuell(s.ks.veganf,s.ks.veganf+30,atag,0,0.2);
    { Bestandeshöhe }
    if s.ks.bestho<10 then s.ks.bestho:=aktuell(s.ks.veganf,s.ks.veganf+30,atag,0,10);
    end
   else
    begin
    { Pflanzen im Hauptvegetationsjahr }
    { Bedeckungsgrad }

    if (s.daycount{ks.tag}<s.ks.matanf) then s.ks.bedgrd:= min(s.ks.bedgrd+bginc,bgmax);
    if (s.daycount{ks.tag}>=s.ks.matanf) and (matanf>0) then s.ks.bedgrd:=-min(-s.ks.bedgrd+bgdec,0);



    { Bestandeshöhe }
    if s.ks.bestho < bhmax then s.ks.bestho:=min(s.ks.bestho+bhinc,bhmax);
    end;
    {Interzeptionskapazität}
    if s.ks.bestho<100 then iz_cap:= s.ks.bestho*czep*S.KS.BEDGRD
                       else iz_cap:= 100*czep*S.KS.BEDGRD;

  { Wurzeltiefe }
//alt:  if round(s.ks.wutief) < wtmax then s.ks.wutief :=min(s.ks.wutief + wtinc, wtmax);
//neu: (17.02.2005) Wurzelwachstum ist Bodenspezifisch
if round(vwutief) < wtmax then
begin
 vwutief :=min(s.ks.wutief + wtinc, wtmax);       // virtuelle Wurzeltiefe im ungestörten Profil
 i:=ceil(min(s.ks.wutief + wtinc*(1-candy.sprfl.rrr[round(s.ks.wutief)]), wtmax));
 s.ks.wutief :=min(s.ks.wutief + wtinc*(1-candy.sprfl.rrr[i]), wtmax);
end;
  { Grenzwertkontrolle }
  IF(s.ks.bedgrd< 1E-03) THEN s.ks.bedgrd:=0;
  end;


n_bedarf:=daily_n_dem;

// Für einfährigr Leguminosen: ab MATANF Stickstoff in den Mineralpool freisetzen
a_n_release:=0;

(*** funktioniert nicht
if (s.ks.tag >= s.ks.matanf)  and (s.ks.jahr=eyr) and (art=3)  then
begin

    // aktuelle N-Menge in EWR
//    if (s.ks.tag=s.ks.matanf) and (s.ks.jahr=eyr) then  p_n_release:=lmnr*3* (s.ks.kumpflent*f_ewr+k_ewr)/(1+f_ewr);
    // zeit bis matende
    if (s.ks.tag=s.ks.matanf) and (s.ks.jahr=eyr) then  p_n_release:=0;

    a_n_release:=p_n_release*(1-exp(-0.3*(s.ks.tag-s.ks.matanf)))- s_n_release;
//    a_n_release:=(s.ks.tag-s.ks.matanf)* p_n_release/exp(-0.3*(s.ks.tag-s.ks.matanf)) - s_n_release;
    s_n_release:= s_n_release+a_n_release;
    for ii:= 1 to 3 do
      begin
        s.ks.amn[ii]:=s.ks.amn[ii]+5 ;//a_n_release/3;
      end;


end;

  ***)

{ 2. N-Entzug aus den Bodenschichten }
n_2_crop(s,n_bedarf);
{ 3. N in Pflanze aufnehmen }
s.nupt        :=N_Luft+s.nupt;
s.ks.kumpflent:=s.ks.kumpflent+s.nupt;
n_uptake      :=n_uptake+s.nupt;
inc(stag);
end;
{pf_a_end}

procedure cndpflan.root_depth_pr;
var i :integer;
begin
  {wtmax auf Bodentiefe begrenzen}
  candy.sprfl.put_maxrooting(i);
  if i<wtmax then
             begin wtmax:=i;
                   add_message('restricted rooting depth='+numstring(wtmax,3)+' dm');
             end;

end;
{
function  cndpflan.n_offtake:real;
var offtake:real;
begin
 offtake:=(n_crop-k_ewr)/(1+f_ewr);
 n_offtake:=offtake;
end;{
function  cndpflan.n_upt_net:real;
begin
  n_upt_net:=nit_yld;
end;

function  cndpflan.n_upt_tot:real;
begin
 n_upt_tot:=n_crop;
end;

function  cndpflan.nat_yield:real;
begin
 nat_yield:=nat_yld;
end;

}

procedure cndpflan._ernte(var s:sysstat);

var ok:boolean;
    cnr,
    eta,
    cewr,
    fewr,

    n_saldo,
    k_faktor,
    newr:real;
    opsnr,i:integer;
    ewr,
    saldo:string;
begin
 send_msg(datum(s.ks.tag,s.ks.jahr)+' harvest ',0);
 for i:=1 to 20 do s.n2crop[i]:=0;  // initialisierung n_fluss
if  art>=4 then
begin

    schnitt(s,false);
    candy.bilanz.reset;     {saldo auf null stellen}
    n_crop:=s.ks.kumpflent;
    nit_yld:=nnat;
    ed.nat_yld_hp:=nit_yld*cf_n2dm;
    ed.n_crop:=nit_yld;
    s.ks.pnr:=0;
    s.ks.bedgrd:=0;
    s.ks.bestho:=0;
    s.ks.wutief:=0;
    s.ks.kumpflent:=0;
    s.plantparm1:=0;
    s.plantparm2:=1;
    ed.valid:=true;
    last_yld:=ed;
    n_uptake:=0;
  exit;
end; {if not art<4}

cewr   :=k_ewr {plantparm^.parm('CEWR')};
fewr   :=f_ewr;

if (candy.scene.mnmt.actual.mmt.spez<>'*') and ((candy.scene.mnmt.actual.mmt.spez<>'')) then
begin
 // Anpassung Fewr an aktuellen N-Gehalt

 fewr:= fewr * 0.001 * strtofloat( candy.scene.mnmt.actual.mmt.spez)/cf_n2DM;

end;

opsnr  :=s.ks.pnr;  { Zugriff nicht über den Pflanzennamen sondern die ID}
   plantparm.select(opsnr,pfl_name,ok);
   opsnr:=round(plantparm.parm('EWR_IX'));
   opsparm.select(opsnr,ewr_name,ok); // positionieren auf record in ops-Tabelle
   if not ok then
               begin
               //writeln('OPS-Parameter nicht gefunden!');
               _halt(6);
               end;
   cnr:=opsparm.parm('CNR');
   eta:=opsparm.parm('ETA');

{OPS- Nummer und CNR gelesen !}
{evtl durchgeführte Zwischenernten berücksichtigen}
if schnitt_anz>0 then k_faktor:={(pot_veg_days-akt_vd_sum)/pot_veg_days}1/schnitt_anz
                 else k_faktor:=1;
(*** alt newr:=(1-schnitt_anz*0.10)*newr; *****)



newr:=(s.ks.kumpflent*fewr+cewr)/(1+fewr);
if art= 3  then newr:= newr-s_n_release;

newr:=min(newr,s.ks.kumpflent);
s.Odng_n:=s.Odng_n+newr;

(* //K
// cips interface

  if cips.active then
  begin
   add_message(' ops_cdy: '+' D='+essdatum(s.ks.tag,s.ks.jahr)+'   X='+floattostr(newr*cnr)+'  ID='+inttostr(opsnr)+' is_od= nein');
   cips.add_ops(newr*cnr,opsnr);
  end;
      *)

nnat:=s.ks.kumpflent-newr;
str(nnat:5:1,nert);
str(newr:5:1,ewr);
candy.bilanz.calc_n_saldo(s.ks.kumpflent,newr,n_saldo);
str(n_saldo:5:1,saldo);
candy.bilanz.reset;     {saldo auf null stellen}
n_crop:=s.ks.kumpflent;
n_ewr:=newr;
nit_yld:=nnat;
ed.nat_yld_hp:=nit_yld*cf_n2dm;
ed.n_crop:=nit_yld;

if (art=3) or (art=4) then
 begin
  for i:= 4 to soildepth do  s.ks.nin[i]:=s.ks.nin[i]+n_ewr*lnub/(soildepth+1-4);
  {for i:= 4 to 10 do s.ks.nin[i]:=s.ks.nin[i]+newr*lnub/7;}
  newr:=newr*(1-lnub);
 end;

 i:=1;
 { Suchen ob schon die gleiche OPS-Art existiert }
 while (i<s.opsfra) and not os_equal(s.ks.ops[i].nr,opsnr) do inc(i);
 if os_equal(s.ks.ops[i].nr,opsnr)
 then
  begin                    { es existiert schon die gleiche Fraktion }
   s.ks.ops[i].c[1]:=s.ks.ops[i].c[1]+newr*cnr*0.50;
   s.ks.ops[i].c[2]:=s.ks.ops[i].c[2]+newr*cnr*0.25;
   s.ks.ops[i].c[3]:=s.ks.ops[i].c[3]+newr*cnr*0.25;
  end
 else
  begin
  s.new_ops:=true;  {das Objekt "Boden" soll die OPS neu einordnen}
  if s.opsfra<maxfraz then inc(s.opsfra)
                      else { Fraktionszahl reduzieren }
                       begin
                        kill_ops_fra(s);
                        inc(s.opsfra);
                       end;
  i:=s.opsfra;
  if s.opsfra>maxfraz then begin   // sollte nie erreicht werden !
                            add_message('zu viele OPS-Fraktionen ! - Abbruch');
                            _halt(7);
                            end;
  s.ks.ops[i].c[1]:=newr*cnr*0.50;
  s.ks.ops[i].c[2]:=newr*cnr*0.25;
  s.ks.ops[i].c[3]:=newr*cnr*0.25;
  s.ks.ops[i].nr  :=opsnr;
  end;
  s.ks.pnr:=0;
  s.ks.bedgrd:=0;
  s.ks.bestho:=0;
  s.ks.wutief:=0;
  s.ks.kumpflent:=0;
  s.plantparm1:=0;
  s.plantparm2:=1;
  ed.valid:=true;
  last_yld:=ed;
  n_uptake:=0;
  send_msg(datum(s.ks.tag,s.ks.jahr)+' '+inttostr(akt_veg_day)+' days active  '+pfl_name,0);
  send_msg(datum(s.ks.tag,s.ks.jahr)+' '+nert+' kg N/ha uptake by crop (above ground) '+pfl_name,0);
  send_msg(datum(s.ks.tag,s.ks.jahr)+' '+saldo+' kg N/ha balance(input-uptake)',0);
  send_msg(datum(s.ks.tag,s.ks.jahr)+' '+ewr+' kg N/ha Residue-Input of '+ewr_name,0);
  send_msg(datum(s.ks.tag,s.ks.jahr)+' '+floattostr(newr*cnr*eta)+' kg Crep/ha of '+ewr_name,0);
end;


procedure cndpflan.schnitt(var s:sysstat; schroepf:boolean);       // Schroepfschnitt wird hier ignoriert

var ok:boolean;
    cnr:real;

    {newr:real; Variable newr ist in der Prozdur cndpflan.ernte bereits verwendet}
    opsnr,i:integer;
begin
{test: ww zum wassermodell}
if art< 4 then exit;  {keine mehrschnittigen Pflanzen}
s.ks.bedgrd:=0.2;
s.ks.bestho:=0;
s.plantparm1:=0;
s.plantparm2:=1;
{add_message('Schnitt am '+datum(s.ks.tag,s.ks.jahr));}

 n_ewr:=n_ewr_soll*stag/vegdau{nicht mehr 365, sondern VEGDAU aus parameterfile};
 n_ewr:=min(n_ewr,s.ks.kumpflent);
 s.Odng_n:=s.Odng_n+n_ewr; {der komplette EWR-Sticktoff wird als org. Input in der Kontrollbilanz gerechnet}

 if (art=4) then
     begin
      {for i:= 4 to 10 do  s.ks.nin[i]:=s.ks.nin[i]+n_ewr*lnub/7;}
      for i:= 4 to soildepth do  s.ks.nin[i]:=s.ks.nin[i]+n_ewr*lnub/(soildepth+1-4);
      n_ewr:=n_ewr*(1-lnub);
     end;

 s.ks.kumpflent:=s.ks.kumpflent-n_ewr;
 nnat:=s.ks.kumpflent;
 s.ks.kumpflent:=s.ks.kumpflent-nnat;
 str(nnat:5:1,nert);

   //opsnr  :=0;  { alt:Zugriff über den Pflanzennamen  besser über EWR_IX}
   opsnr:=ewr_id;
   opsparm.select(opsnr,ewr_name,ok);
   if not ok then
               begin
               writeln('ewr_id:'+inttostr(ewr_id)+' not found');
               _halt(6);
               end;
   cnr:=opsparm.parm('CNR');


stag:=0; {am Ende Zähler zurücksetzen}
{test ende}


{exit;}

(**********************************************************)
{ Suchen ob schon die gleiche OPS-Art existiert }
 i:=1;
 while (i<s.opsfra) and not os_equal(s.ks.ops[i].nr,opsnr) do inc(i);
 if os_equal(s.ks.ops[i].nr,opsnr)
 then
  begin                    { es existiert schon die gleiche Fraktion }
   s.ks.ops[i].c[1]:=s.ks.ops[i].c[1]+n_ewr*cnr*0.50;
   s.ks.ops[i].c[2]:=s.ks.ops[i].c[2]+n_ewr*cnr*0.25;
   s.ks.ops[i].c[3]:=s.ks.ops[i].c[3]+n_ewr*cnr*0.25;
  end
 else
  begin
  s.new_ops:=true;  {das Objekt "Boden" soll die OPS neu einordnen}
  if s.opsfra<maxfraz then inc(s.opsfra)
                      else { Fraktionszahl reduzieren }
                       begin
                        kill_ops_fra(s);
                        inc(s.opsfra);
                       end;
  i:=s.opsfra;
  if s.opsfra>maxfraz then
                               begin
                                add_message('too man  FOM-Pools ! - EXIT');
                                _halt(7);
                               end;
  s.ks.ops[i].c[1]:=n_ewr*cnr*0.50;
  s.ks.ops[i].c[2]:=n_ewr*cnr*0.25;
  s.ks.ops[i].c[3]:=n_ewr*cnr*0.25;
  s.ks.ops[i].nr  :=opsnr;
  end;

add_message('cutting at '+datum(s.ks.tag,s.ks.jahr)+': '+nert+'kg N/ha  Newr='+numstring(n_ewr,3));
end;

procedure cndpflan.kill_crop(var s:sysstat);
var ctot:single;
    _name:string;
    ok:boolean;
begin

(*    Grünland wird an anderer stelle behandelt !!!     *)

 ernte(s);
//  grnd_id is idx of above ground biomass if used as FOM
   opsparm.select(grnd_id,_name,ok);
//  get cnr of FOM   //  calc C-amount
   ctot:=nnat* opsparm.parm('CNR_ALT');

//  add to mulch layer;
   candy.mulch.add_om(ctot,grnd_id);
   send_msg('    biomass input : '+real2string(ctot,3,0)+'kg/ha',0);

end;


begin

end.
