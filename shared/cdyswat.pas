{  this unit implements a class definition Tswat for a model of soil water dynamics
 in a soil profile regarding evapotranspiration controlled by PET and plant cover
 driven by precipitation that is considered as solid or liquid depending on air temperature.
 The amount of water entering the soil is provided by s.infilt that contains
 the amount of the corrected precipitation reduced by interzeption within the plant cover.
 The infiltrating amount of water is further controlled by the snow cover that may store liquid precipitation
 and is undergone melting thus providing water for infiltration.
 The model considers only perkolation and optional drainage; no redistribution from matrix potential gradients and thus no capillary rise

 state variables are communicated via the system state s
 s.ks.bofeu : the amount of water (in mm or VOL%) in each calculation layer of 10 cm height
 s.perko    : the amount of water in mm that leaves a calculation layer downwards
 s.entz     : crop water demand / uptake
 s.botem    : soil temperatur (used to determine a frozen layer that stops percolation)

 the processes within one daystep are:
 schneedecke  :  snow cover
 schmelzen    :  snow melting
 entugsanteile:  water uptake by evaporation (@link(unbed_entn)) and transpiration (@link(__bed_entn))
 versickerung :  percolation
 plantuptake  :  actual reduction of soil water

}

{$INCLUDE cdy_definitions.pas}
unit cdyswat;

interface
uses


{$IFDEF CDY_GUI}
cdy_glob,
{$ENDIF}
{$IFDEF CDY_SRV}
cdy_config,
{$ENDIF}

sysutils,math,                                           //DELPHI
     cnd_vars,cnd_util,ok_dlg1,soilprf3,bestand ;    //CANDY

type
     Tswat   = class (Tobject)  //< Basisklasse , weitgehend identisch mit dem Algorithmus von Koitzsch
                 df:text;       //< optionale ausgabe von drainage daten
                 wdmode:string; //< ist hier immer KoGL :: wassermodell nach koitzsch/Glugla
                 tiefu,         //< tiefe der unbedeckten Entnahme
                 tief_,         //<  Wurzeltief (bedeckte Entnahme)
                 bodentiefe : integer; //< Profilunterkante
                 drainflow,           //<Tageswert des Drainageabfluß}
                 drain_sum,           //<Summe des Drainageflusses   }
                 seepage,             //<Summe der Grundwasserneubildung }
                 zufuhr,               //< interne Größe der Wasserzufuhr
                 zept,                 //< interne Größe der Wassermenge im Interzeptionsspeicher
                 ube,                 //<unbedeckte Entnahme
                 anspruch,             //<verdunstungsanspruch aus PET}
                 ae,                  //< aktuelle Evaporation
                 at,                  //< aktuelle Transpiration
                 k_pet,               //< Korrigierte PET bei Pflanzenbestand
                 tr_stress,           //<fehlende Transp. des Tages in mm
                 aet   : real;        //<aktuelle Evapotranspiration in mm
                 anteil,              //< interne Hilfsgröße
           //      _a_,                 //< Hilfsgröße zur Potentialberechnung (veraltet)
           //      _b_,                 //< Hilfsgröße zur Potentialberechnung (veraltet)
                 ubent  :profil;        //< Größe der unbedeckten Entnahme
                 _xsi    : real;        //< Parameter  zur Verteilung der Entnahmedichte
                 alam   : profil;       //< aktuller Wert des Versickerngsparameters
                 nunb   : byte;         //< maximale Tiefe (dm) der unbedeckten Entnahme
                 fanf   : array [1..20] of byte;    //< Hilfstabellen
                 ftabbew: array [1..210] of real;
                 ftabunb: array [1..15] of real;
                 sickergr,               //< meint: Feldkapazität
                 entgr,                  //< meint: permanenter Welckepunkt
                 pvol   : profil;        //< Porenvolumen
                 write_drainage,         //< drainageergebnisse ausgebn ?
                 surface_retention,      //< true: limited surface runoff ('puddle' water))  ; standard:false
                 lysimeter : boolean;    //< wenn lysimeter dann kein Oberflächenabfluß
                 stau,                   //< aktuelle Tiefe der Stauschicht: wo  BOFEU>FKAP
                 gw_level  :integer;     //< Tiefe der Wassergesättigten Schicht bei hydromorphen Böden
                 k_gwb_sat,              //< entspr gesättigtem Abfluß
                 cap_rise,               //< zusätzlicher Wasserentzug bei hydromorphen Böden
                 w_sat     : real;       //< die über sickergr hinaus gespeicherte Wassermenge
                 pflentz   :profil;

                 constructor create(var status:statrec;lsm,srf_ret:boolean; wdm:string; asprfl:T_soil_profile);

                 procedure  moist_init(alpha:real;  wdm:string; prfl:T_soil_profile; var s:sysstat);  //< initialization of soil moisture profile

                 PROCEDURE   schneedecke(var s:sysstat);   //< accumulates 'solid' precipitation at low temperatures and has a certain water storage capacity for 'normal' rainfall
                 PROCEDURE   schmelzen(var s:sysstat);     //< reducing ov snow cover (if any)
                 procedure   tagschritt1(var s:sysstat);   //< first step: dynamics of snow cover and interzeption
                 procedure   get_pwp(var x:extended;i:byte);
                 procedure   get_fkp(var x:extended;i:byte);
                 procedure   unbed_entn(var s:sysstat);  //< evaporation flux
                 procedure   __bed_entn(var s:sysstat);  //< transpiration flux
                 PROCEDURE   versickerung(var s:sysstat); //< water percolation through the soil profile
                 PROCEDURE   entzugsanteile(VAR ENTNAHME:REAL; pot,psi_,xsi_:REAL; tief:BYTE; bed:BOOLEAN;var s:sysstat);
                 procedure   tag_anfangen(var s:sysstat); //< calls tagschritt1 and calculates evaporation (unbed_entn)
                 procedure   tag_beenden(var s:sysstat);  //< update of water storage and percolation transport
                 procedure   plantuptake(var s:sysstat);  //< water uptake by crop
                 procedure   prm_adapt;                   //< fetching the physical parameters from soil profile
               end;

implementation
 uses cdyspsys ;

 procedure Tswat.prm_adapt;
begin
    candy.sprfl.put_fkap(20,sickergr);
    candy.sprfl.put_pwp(20,entgr);
    candy.sprfl.put_pvol(20,pvol);
    candy.sprfl.put_lambda(20,alam);
end;

constructor Tswat.create(var status:statrec; lsm,srf_ret:boolean; wdm:string; asprfl:T_soil_profile);
var zetb,zetu,xfa   :real;
    m,n,i,k,j   :byte;
    tiefe       : integer;
    schicht     :string;


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

 for i:= 1 to  20  do pflentz[i]:=0;
  write_drainage:=false;
  surface_retention:=srf_ret;
  lysimeter:=lsm;
  if lsm then add_message('lysimeter recognised');
  wdmode:=wdm;
//  add_message('water dynamics following: ' +wdm);
  _xsi :=cdyaparm.parm('XSI');
  NUNB:=round(cdyaparm.parm('NUNB'));
  nunb:=min(asprfl.btief,nunb);
  tiefu:=nunb;
  for m:=1 to 20 do anteil[m]:=0;
  zetu:=cdyaparm.parm('ZETU');
  zetb:=cdyaparm.parm('ZETB');
  {---potentielle Entnahmeanteile------------------------------------------}
  fanf[1]:=1;
  FOR m:=2 TO 20 DO fanf[m]:=fanf[m-1] + (m -1);
  FOR n:=1 TO 20 DO BEGIN          {bewachsen}
    FOR m:=1 TO n DO ftabbew[fanf[n]+m-1]:=f(m,n,zetb);
  END;
  FOR n:=1 TO 5 DO BEGIN           {unbewachsen}
    FOR m:=1 TO n DO ftabunb[fanf[n]+m-1]:=f(m,n,zetu);
  END;
  { Parameter für jede Schicht }
  asprfl.put_fkap(20,sickergr);
  asprfl.put_pwp(20,entgr);
  asprfl.put_pvol(20,pvol);
  asprfl.put_lambda(20,alam);
  asprfl.put_maxdepth(tiefe);
  bodentiefe:=tiefe;
  for j:=1 to tiefe do
  begin
    asprfl.put_fat(j,xfa);
  //  _b_[j]     :=(3.5+2.8*exp(-0.09*xfa))/ln(entgr[j]/sickergr[j]);
  //  _a_[j]     :=9.67-_b_[j]*ln(entgr[j]);
  end;
  aet:=0;
  drain_sum:=0;
  seepage  :=0;
  if  not asprfl.free_drain then
  begin
   gw_level:=bodentiefe;
   asprfl.put_ksat(k_gwb_sat);
   alam[gw_level]:=0;  // grundwasserführende Schicht erhält Sonderbehandlung
   alam[gw_level-1]:=0;
   status.bofeu[gw_level]:=pvol[gw_level];
  end;
  if write_drainage then
  begin
   assign(df,'DRAINAGE.TXT');
   rewrite(df);
   close(df);
  end;
end;
{
PROCEDURE Tbowa.con2pot(con:extended; var pot:extended; I:integer);
begin
 if i<= bodentiefe then pot:=exp(_a_[i]+_b_[i]*ln(con))
                   else begin
                         send_msg('BWTVSS.con2pot: unbelegtes Bodensegment',2);

                        end;
end;
 }


{sw_f_beg}

{
 Die Bodenfeuchte wird linear über das Bodenprofil verteilt
  an der untersten Schicht wird die Füllung auf FKAP erzwungen
  die Verteilung erfolgt so, daß die kumulative Wassermenge
  alpha*nFK beträgt , falls dies nicht gelingt (zu trocken) werden die oberen Schichten auf pwp gesetzt
 }

procedure Tswat.moist_init(alpha:real;  wdm:string; prfl:T_soil_profile; var s:sysstat);
                              {alpha gibt die Füllung der nFK an}
   var i,                    // Laufvariable
    bt,                      // Bodentiefe
   d,a    :INTEGER;         // Ofst am oberen rand (schichten auf NULL)
   sm,                      // summe der gewichte
   alpha0,                   // Vorgabewert merken
    b,                       // parameter der lin. Gleichung zur Verteilung der NFC
    nfc,                     // mittlere nfc im profil
    ps,                       // Prüfsumme für nfc
    diff   :real;             // hilfsgroesse
    gew,                      // wichtung
    FKAP,PWP,moist,pvol :profil;

begin
     {!!! physikalische Parameter wurden evtl. an OS angepasst ??!! }
      prfl.put_fkap(20,fkap);
      prfl.put_pwp(20,pwp);
      prfl.put_pvol(20,pvol);
      alpha:=alpha/100;  // Prozent in Zahl
       alpha0:=alpha;
    //    sm jetzt summe der gewichte
     d:=0;  // zunächst keine schicht ausblenden
     bt:= prfl.btief;
     // 1. summe der NFK über das profil berechnen
     nfc:=0;
     for i:=(d+1) to bt do nfc:=nfc+ (fkap[i]-pwp[i]);
  // standard für eine schicht:
     if d=0 then  s.ks.bofeu[1]:=   alpha*fkap[1]+pwp[1]*(1-alpha);
  repeat
     a:=0;  // hilfsgröße die innerhalb der for schleife benutz wird um d zu ermitteln
            // wenn die oberen schichten ausgeblendet werden als d>0
            // alte nfc für nächste runde merken
     b:= nfc;
  // 2. gewichte berechnen
     sm:=0;
     for i:=(d+1) to bt do
      begin
       gew[i]:=(bt-i)*(fkap[i]-pwp[i]);
       sm    := sm+gew[i];
     end;
  // 3. wassergehalt verteilen
      for i:=(d+1) to bt do
      if sm>0 then begin
         moist[i]:=(fkap[i]-pwp[i]) -  nfc*(1-alpha)*gew[i]/sm;
         if moist[i]<0 then begin a:=i;
                                  moist[i]:=0;
                            end;
         s.ks.bofeu[i]:=pwp[i]+moist[i];
      end;
  // evtl weitermachen ?
     d:=d+1;
     if a>0 then
     begin
       // neue runde
       diff:=0;
       for i:=1 to d do diff:=diff+fkap[i]-pwp[i];
       nfc:=0;
       for i:=(d+1) to bt do nfc:=nfc+fkap[i]-pwp[i];
       alpha:= alpha*b/nfc;
     end;

  until ( a=0 ) or (d>=(bt-1));


  if d>=(bt-1) then // letzte notlösung
  begin
  nfc:=0;
   for i:=1 to bt-1 do
   begin
   nfc:=nfc+fkap[i]-pwp[i];
   s.ks.bofeu[i]:=pwp[i];
   end;
   nfc:=nfc+fkap[bt]-pwp[bt];
   moist[bt]:=alpha0*nfc;
   s.ks.bofeu[bt]:=moist[bt]+pwp[bt];
  end;

  // Kontrolle
  nfc:=0;
  sm:=0;
  for i:=1 to bt do
  begin
   nfc:=nfc+(fkap[i]-pwp[i]);
   sm:= sm+s.ks.bofeu[i]-pwp[i];
  end;
  alpha:=sm/nfc;
  {
  if wdm='DARCY' then
  begin
  for i:=2 to bt do

    s.ks.bofeu[i]:=h2the(p_drc_hrz(darcy.sprof[1]).mp,the2h( p_drc_hrz(darcy.sprof[1]).mp,s.ks.bofeu[1]));
  end;
   }

end;
       {
// Endkontrolle auf Einhaltung des PVOL
 for i:=bt downto 2 do
 begin
   if s.ks.bofeu[i]>pvol[i] then
   begin
     diff:=s.ks.bofeu[i]-pvol[i];
     s.ks.bofeu[i]:=pvol[i];
     s.ks.bofeu[i-1]:=s.ks.bofeu[i-1]+diff;
   end;
 end;
 s.ks.bofeu[1]:=min(s.ks.bofeu[1],pvol[1]);
end;
         }
{sw_f_end}

procedure Tswat.get_pwp(var x:extended;i:byte);
begin
 if i<=bodentiefe then x:=entgr[i]
                  else send_msg('BWTVSS.get_pwp: unbelegtes Bodensegment',2);
end;

procedure Tswat.get_fkp(var x:extended;i:byte);
begin
 if i<=bodentiefe then x:=sickergr[i]
                  else send_msg('BWTVSS.get_pwp: unbelegtes Bodensegment',2);

end;


PROCEDURE Tswat.versickerung(var s:sysstat);
   {Versickerung und neuer Wasservorrat in den 20 Rechenschichten}
   VAR {a,} ab, ala, fakt,
       diff,no_flow, flow,
       new_feu,sat_flow      :REAL;
       m,i                   :integer;
       bowa:profil; { Zur Rechnung Konvertieren wir am Anfang alle Konzentrationen (Theta) in wassermenge (l/m²)}
 Begin
  for i:=1 to bodentiefe do   bowa[i]:=s.ks.bofeu[i]*(1-candy.sprfl.stone_cont[i]/100);
  s.drain_flow:=0;
  fakt:=1+0.77*sin(0.0172024*(s.ks.tag-105));
  stau:=0;
  ab:=0;
  cap_rise:=0;
  for m:= 1 to 20 do
  begin
     s.perko[m]:=0;
    {Test einfügen, ob Bodenschicht vorhanden ist}
    if m<=bodentiefe
    {Falls ja:}
     then
     begin
     // für die grundwasserführende und die darüberliegende Schicht muß ala=0 sein
      ala :=alam[m]*fakt;
      bowa[m]:=bowa[m]+ab-s.entz[m];
      { Altersberechnung: }
      if m> 1 then  anteil[m]:=((bowa[m]-ab)*anteil[m]+ab*anteil[m-1])/bowa[m] ;
       {Abflussberechnung}           // Steingehalt: sickergr:=fcap*(1-steingehalt)
      diff:=(s.ks.bofeu[m]-sickergr[m]);      { Umrechnung in mm bei 10cm Schicht }
      if (diff<=0.0001)                       { Berechnung des Transportanteils}
      or (s.ks.botem[m]<0)
      or ((m<=19) and(s.ks.bofeu[m+1]>=pvol[m+1]))
                           then ab:=0
                           else ab:=ala*diff*diff/(1+ala*diff);
     {Drainageabfluß berechnen}
     drainflow:=0;
     if (m=candy.sprfl.dr_depth) and (ab>0)
     then
     begin
       drainflow:=ab*candy.sprfl.dr_effct;
       drain_sum:=drain_sum+drainflow;
       ab:=ab-drainflow;
       s.drain_flow:=drainflow;
     end;
     bowa[m]:=bowa[m]-ab-drainflow;
     s.perko[m]:=ab;
     if bowa[m]/(1-candy.sprfl.stone_cont[m]/100)>=pvol[m]  then
      begin
        stau:=m;                              // so wird nur die oberstestauschicht erfasst:   if stau=0 then stau:=m;
      end;
     end
     {Falls nein:}
     else  if m<>gw_level then s.perko[m]:=ab;
    end; //for

{Berechnungen für grundwassernahe Standorte}
// die grundwasserführende Schicht ist m=gw_level
//  die über FKAP gespeicherte Wassermenge ist w_sat;
//  grundwasserstand ist stau
    if stau>1 then
    begin
      w_sat:= bowa[stau-1]-sickergr[stau-1];
      for i:= stau to (gw_level-1)
      do  w_sat:= w_sat + bowa[i]-sickergr[i];
      { pot. Abflußsumme berechnen}
      ab:= k_gwb_sat *  w_sat;
      { Versickerung im gesättigten Bereich kalkulieren}
      { flow : Abfluß aus der aktuellen Schicht        }
      sat_flow:=0;
      if stau<gw_level then
      for i:= stau to (gw_level-1) do
      begin
           flow:=min(ab,bowa[i]-sickergr[i]);
           bowa[i]:=bowa[i]-flow;
           ab:= ab-flow;
           s.perko[i]:=flow+sat_flow;
           sat_flow  :=s.perko[i];
      end;
     end;
     //    die letzte Schicht behält die Bodenfeuchte auf voller Sättigung
     if gw_level>0 then
     begin
      bowa[gw_level]:=pvol[gw_level];
      cap_rise:=s.entz[gw_level];
      s.perko[gw_level]:=s.perko[gw_level-1]-cap_rise;
     end;

     {Drainageabfluß berechnen}
     drainflow:=0;
     if (m=candy.sprfl.dr_depth) and (ab>0)
     then
     begin
       drainflow:=ab*candy.sprfl.dr_effct;
       drain_sum:=drain_sum+drainflow;
       s.drain_flow:=drainflow;
       ab:=ab-drainflow;
       s.perko[m]:=ab;
     end;

    i:=stau;
    if i<>0 then {falls Bodenfeuchte einer Schicht größer als PV}
    begin
      no_flow:=0;
      while i>1 do
       begin
          bowa[i]:=bowa[i]+no_flow;
          if bowa[i] > pvol[i] * (1-candy.sprfl.stone_cont[i]/100) then
          begin
             no_flow:=bowa[i] - pvol[i]*(1-candy.sprfl.stone_cont[i]/100);
             bowa[i]:=  pvol[i]*(1-candy.sprfl.stone_cont[i]/100);
          end
          else no_flow:=0;
          dec(i);
       end;

      if no_flow>0 then
           begin
            new_feu:=bowa[1]+no_flow;
            if surface_retention     //'puddle' water ?
            then  no_flow := new_feu - ( 40.667 + 0.592*sickergr[1] )  {no_flow ist überschüssige Wassermenge, wird vom System abgegeben}
            else  no_flow := new_feu -pvol[1];
            if no_flow<0 then no_flow:=0; {Wasser konnte an der Oberfläche gehalten werden}
            bowa[1]:=new_feu-no_flow;
            s.obflflux:=s.obflflux+no_flow;
            if lysimeter then
            begin
             bowa[i]:=bowa[i]+s.obflflux;
             s.obflflux   :=0;
            end;
           end;
    end; {if stau<>0}

   seepage:=seepage+s.perko[bodentiefe];
   if write_drainage then
   begin
    append(df);
    writeln(df,datum(s.ks.tag,s.ks.jahr):10,s.wett.niedk:10:2,s.perko[20]:10:2,seepage:10:2,stau:10,w_sat:10:2);
    close (df);
   end;

   // Rücktransformation auf THETA (Vol%)
    for i:=1 to bodentiefe do
      begin
        s.ks.bofeu[i]:=bowa[i]/(1-candy.sprfl.stone_cont[i]/100);
      end;

   end; {Versickerung}

PROCEDURE Tswat.entzugsanteile(VAR entnahme:REAL; pot,psi_,xsi_:REAL;tief:BYTE; bed:BOOLEAN;var s:sysstat);
{Berechnung der Entzugsateile fuer die 20 Rechenschichten und des Gesamtentzuges a}
VAR g, rtag: ARRAY[1..20] OF REAL;     {Hilfsfelder}
    rmax,             {R-Faktor fuer max. Entzug}
    ri,               {R-Faktor, Zwischenwert}
    xsa,              {rel. krit. pfl.-nutzb. Wasservorrat}
    vorrat,           {nutzb. Wasservorrat in der Rechenschicht}
    kapaz:   REAL;    {(sickergr[i] - entgr[i])/10}
    m, n:    BYTE;
    ok:      BOOLEAN;
    Feu_min : Real;  { minimaler Wassergehalt}
    ntag    : byte;  { aktuelle Entnahmetiefe}
    srrr, rooting_impact, psi: real;
    rwr: array[1..20] of real;



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
  zufuhr:=s.infilt;
  psi:=psi_ ;
  FOR m:=1 TO bodentiefe DO s.entz[m]:=0;
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
        if bed and (m<5) then feu_min:=entgr[m]*0.75 else feu_min:=entgr[m]{k_pwp[m]};
        vorrat:=s.ks.bofeu[m] - feu_min;                 // Steingehalt
        IF(m = 1) THEN vorrat:=vorrat - zufuhr;
        IF(vorrat < 0) THEN vorrat:=0;
        kapaz:=sickergr[m] - feu_min;
        xsa:=(xsi_ * sickergr[m] - feu_min)/kapaz;
        IF(xsa < 0) THEN xsa:=0;
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
          FOR m:=1 TO ntag DO
          BEGIN
            s.entz[m]:=ftabunb[fanf[ntag]+m-1]*pot*psi;      {unbewachsen}
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
              g[m]:=rtag[m]*ftabunb[fanf[n]+m-1]*pot*psi;      {unbew.}
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


(*

PROCEDURE Tbowa.interzeption(var s:sysstat);
{Berechnung der Interzeption und der Zufuhr zum Boden}
VAR hoch,z_max,azep: REAL;

BEGIN
  IF(s.ks.bedgrd=0) THEN BEGIN
    azep:=-s.ks.szep;  {Beim Umbruch gesp. Interzeption in 1. Rechenschicht}
    s.ks.szep:=0;
  END ELSE BEGIN
    IF(s.wett.niedk < 0.01) THEN BEGIN   {Nur gesp. Interzeption verbrauchen}
      azep:=0;
      zept:=s.ks.szep;
      s.ks.szep:=0;
    END ELSE BEGIN               {Erneut Interzeption}
      hoch:=s.ks.bestho;
      if candy.cndpfl <>NIL then azep:= candy.cndpfl.iz_cap
                            else azep:= 0;
      z_max:=azep;
      IF(azep > s.wett.niedk * s.ks.bedgrd) THEN azep:=s.wett.niedk * s.ks.bedgrd;
      IF(azep > z_max) THEN azep:=z_max;
      IF(s.ks.szep + azep <= z_max) THEN BEGIN
        zept:=s.ks.szep + azep;
        zept:=zept/2;
        s.ks.szep:=zept;
      END ELSE BEGIN
        azep:=z_max - s.ks.szep;
        zept:=z_max/2;
        s.ks.szep:=zept;
      END;
    END;
  END;
  zufuhr:=s.wett.niedk - azep;
END;

*)

PROCEDURE Tswat.schmelzen(var s:sysstat);
{Schmelzen der Schneedecke; alle Wärmemengen in MJ/(m*m)}
VAR
  albe,        {Albedo Schneedecke}
  alfa,        {Waermeuebergangskennzahl bei 10 W/(m*m)/K}
  verd,        {Verdampfungswaerme des Wassers}
  schm,        {Schmelzwaerme des Eises}
  c,           {spez. Waerme des Wassers}
  gama,        {Psychrometerkonstante}
  strb,        {Strahlungsbilanz}
  sk,          {kurzw. Komponente strb}
  sl,          {langw. Komponente strb}
  qkon,        {konvektiv zugefuehrte Waermemenge}
  e,           {Dampfdruck}
  de,          {Dampfdruckdifferenz Luft - Schnee}
  csno,        {Speicherkapazitaet Scheed. f. fluess. Wasser}
  y, b: REAL;

BEGIN
  albe:=0.5;
  alfa:=0.864;
  verd:=2.51;
  schm:=0.33;
  c:=4.2E-03;
  gama:=0.67;

  {Strahlungsbilanz Schneeoberflaeche}
  strb:=0;    b:=s.wett.rf/100;

  {Verdunstung und Kondensation}
  e:=(6.114 + 0.42852 * s.wett.lt + 0.18885E-01 * sqr(s.wett.lt)) * b;
  de:=(e - 6.114) * alfa/gama;
  aet:=0;
  s.wett.pet:=0;

  zufuhr:=s.infilt; {Niederschlag - Interzeption}

  {Verdunstung}
  IF(de < 0) THEN BEGIN
    ae:=-de/(verd + schm);
    IF(ae>=s.ks.snow) THEN begin ae:=s.ks.snow;s.ks.snow:=0; end
                   ELSE s.ks.snow:=s.ks.snow- ae;
  END;

  {Kondensation}
  IF(de > 0) THEN BEGIN
    zufuhr:=zufuhr + de/verd;
    ae:=-de/verd;
  END;

  {Konvektiver Waermeuebergang}
  qkon:=alfa * s.wett.lt +de;

  {Schmelzen}
  b:=(strb + qkon + c * s.wett.niedk * s.wett.lt)/schm;
  IF(b > 0) THEN BEGIN
    IF(b < s.ks.snow) THEN BEGIN
      zufuhr:=zufuhr + b;
      s.ks.snow:=s.ks.snow- b;
    END ELSE BEGIN
      zufuhr:=zufuhr + s.ks.snow;
      s.ks.snow:=0;
    END;
  END;

{Fluessiges Wasser in Schneedecke speichern}
  csno:=0.00 * s.ks.snow;   {Kapazitaet Null gesetzt; ev. aendern!!}
  b:=s.ks.speisch + zufuhr;
  IF(b <= csno) THEN BEGIN
    s.ks.speisch:=b;
    zufuhr:=0;
  END ELSE BEGIN
    s.ks.speisch:=csno;
    zufuhr:=b - csno;
  END;
  s.wett.pet:=0;
  IF(ae > 0) THEN s.wett.pet:=ae;
  tief_:=0;
  tiefu:=0;
  s.ks.szep:=0;
  s.infilt:=zufuhr;
END;

PROCEDURE Tswat.schneedecke(var s:sysstat);
   {Evaporation Schneedecke bei temp <= 0.5 Grad C}
   BEGIN
     s.infilt:=0;
     s.ks.snow:=s.ks.snow+ s.wett.niedk + s.ks.szep + s.ks.speisch;
     s.ks.szep:=0;
     s.ks.speisch:=0;
     tiefu:=nunb;
     IF(s.ks.snow>0) THEN BEGIN
       IF(s.ks.snow>=s.wett.pe) THEN BEGIN
         ae:=s.wett.pe;
         s.ks.snow:=s.ks.snow-s.wett.pe;
         tiefu:=0;
       END ELSE BEGIN
         ae:=s.ks.snow;
         s.ks.snow:=0;
         tiefu:=0;
       END;
     END;
   END;


procedure Tswat.tagschritt1(var s:sysstat);
var h1,h2,h3,h4,h5:string;
begin
  {Tagesgrößen initialisieren}
  aet:=0;ae:=0;zufuhr:=0;zept:=0;

  { aktuelle Entnahmetiefe der Pflanzen}
  tief_:=round(s.ks.wutief);
  if tief_>20 then tief_:=20;
  tiefu:=nunb;
  IF(s.wett.lt <= 0.5) THEN schneedecke(s)
  ELSE
   BEGIN
    {Zufuhr in Boden ist möglich}
    IF(s.ks.snow > 0) THEN schmelzen(s) ELSE zufuhr:=s.infilt;
   END;

  h1:=real2string(s.ks.bofeu[1],4,1);
  anteil[1]:=anteil[1]*s.ks.bofeu[1]/(s.ks.bofeu[1]+zufuhr);
  if lysimeter then   s.ks.bofeu[1]:=s.ks.bofeu[1] + zufuhr
               else
               begin
                 if s.ks.botem[1]>(-0.5)       // für Sibirien >0.5
                       then  s.ks.bofeu[1]:=s.ks.bofeu[1] + zufuhr
                       else  begin
                               s.obflflux:=zufuhr;
                               zufuhr:=0;
                             end;
               end;
  h2:=real2string(s.ks.bofeu[1],4,1);
  h5:=real2string(s.ks.botem[1],4,1);
  h3:=real2string(zufuhr,4,1);
  h4:=datum(s.ks.tag,s.ks.jahr);
  {bei niedrigen Lufttemperaturen keine Entnahme durch Pflanze}
  IF(s.wett.lt < 2.0) THEN tief_:=0;
  anspruch:=s.wett.pet;
  {Interzeption verdunsten}
  zept:=s.ks.szep;
  if s.wett.niedk<0.01 then s.ks.szep:=0;
  IF(zept > 0)
    THEN
     BEGIN
      IF(zept >= s.wett.pei)
       THEN
        BEGIN
          ae:=s.wett.pei;
         // s.ks.szep:=s.ks.szep + zept - s.wett.pei;
           s.ae_srf:=s.ae_srf+s.wett.pei;
           s.ks.szep:= max(0,   s.ks.szep-s.wett.pei );
           tief_:=0;
        END
       ELSE
        BEGIN
          ae:=zept;
          anspruch:=(1 - zept/s.wett.pei) * s.wett.pet;
        END;
     END;
end;

procedure Tswat.unbed_entn(var s:sysstat);
var m  :byte;
begin
  {unbedeckte Entnahme}
  ube:=0;
  entzugsanteile(ube,s.wett.pe,1-s.ks.bedgrd,1.0,tiefu,FALSE,s);
  ae:=ae + ube;
  {unbedeckte Entnahme zwischenspeichern}
  FOR m:=1 TO bodentiefe DO ubent[m]:=s.entz[m];
end;

procedure Tswat.__bed_entn(var s:sysstat);
begin
  {bedeckte Entnahme }
  {Korrektur der potentiellen Entnahme durch Bestandeshöhe}
  k_pet:=1+min(s.ks.bestho,100)*0.004;
  {maximale Korrektur=1.4}
  anspruch:=anspruch*k_pet;
  at:=0;
  entzugsanteile(at,anspruch,s.ks.bedgrd,_xsi,tief_,TRUE,s);
  aet:=ae + at;
  s.wett.trans:=at;
  s.wett.trstr:=s.wett.trans/(anspruch*s.ks.bedgrd);
  s.wett.wbil:=zufuhr-ube-at;
end;

                  {
constructor Tswat.init(var s:statrec; lsm:boolean; wdm:string; asprfl:T_soil_profile);
var i:byte;
begin
 for i:= 1 to  20  do pflentz[i]:=0;
 Tswat.create(s,lsm,wdm,asprfl);
end;
                   }

procedure Tswat.tag_anfangen(var s:sysstat);
var i:integer;
begin
  tiefu:=nunb;
  for i:= 1 to  20  do pflentz[i]:=0;
  //Tbowa.
  tagschritt1(s);
  unbed_entn(s);
  s.trnsp_soll:=anspruch;
end;

procedure Tswat.tag_beenden(var s:sysstat);
var i,m:integer;
     x1,x2:real;
    h1,h2,h3,h4,h5:string;
begin

  if not s.wett.inkub then
  begin
      at:=0;
      s.aet:=0;
      x1:=0;x2:=0;
      for I:=1 to bodentiefe do
      begin
       at:=at+pflentz[i];
       s.entz[i]:=pflentz[i]+ubent[i];
       s.aet:=s.aet+s.entz[i]/(1-candy.sprfl.stone_cont[i]/100);
       x1:=x1+s.ks.bofeu[i];
      end;
      if wdmode='KoGl' then
      begin
       versickerung(s);
      end;

      for I:=1 to bodentiefe do
      begin
       x2:=x2+s.ks.bofeu[i];
      end;
      s.w_marked     :=anteil [bodentiefe];
      s.grndwssrbldng:=s.perko[bodentiefe];

      aet:=ae + at;
      s.wett.wbil:=zufuhr-ube-at;

    {Entnahme aktualisieren}
      s.aet:=aet;  {enthält auch noch die Interzeptionsverdunstung}
      tr_stress:=s.trnsp_soll-s.aet;

  end
else
  begin // Inkubation
       for I:=1 to bodentiefe do
      begin
       if s.wett.theta_opt
       then      s.ks.bofeu[i]:= pvol[1]/2
       else      s.ks.bofeu[i]:= s.wett.theta;
      end;
  end;
end;

procedure Tswat.plantuptake(var s:sysstat);
var i:integer;
begin
    for I:=1 to bodentiefe do
    if s.ks.bofeu[i]>entgr[i]*0.6     // 0.6 ist eine Sicherheitsgrenze
      then pflentz[i]:=s.entz[i]
      else
      begin
       add_message(datum(s.ks.tag,s.ks.jahr)+' Lyr'+inttostr(i)+': impossible plant water request ');
       pflentz[i]:=0;
      end;
end;


begin
end.
