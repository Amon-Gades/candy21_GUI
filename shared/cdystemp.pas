{ calculates soil temperature for each layer in 0-20 dm profile with the @link(Tbotemp.daystep daystep) method
  using air temperature from climate data to calculate the upper bundary condition using one of two optionalm methods
  and a specific approach for the lower boundary condition without a distiction between summer and winter
  soil water storage is used to calculate heat capacity  soil temperature is calculated following the approach of
  Suckow, F. (1987): Ein Modell zur Berechnung der Bodentemperatur unter Brache und unter Pflanzenbestand.    }

{$INCLUDE cdy_definitions.pas}
unit cdystemp;
interface
uses

{$IFDEF CDY_GUI}
cdy_glob,
{$ENDIF}
{$IFDEF CDY_SRV}
cdy_config,
{$ENDIF}


//CANDY:
cnd_vars,cnd_util ,observations,soilprf3, ok_dlg1,
//DELPHI
FireDAC.Comp.Client, sysutils,db,math;

type {parameter record}
     tbtprm= record                                                               //< parameter record with factors of a(mostly) linear combination to calculate the soil surface temperature in lubotr2 or lubotr3
                    F_bt,                                                         //< in version2 (lubotr2) factor before soil temperature in version3 it will additionally be multiplied with heat capacity
                    F_lt,                                                         //< factor before air temperature
                    F_gs,                                                         //< factor before the term describing impact of global radiation
                    E_gs,                                                         //< exponential factor in the term describing impact of global radiation
                    F_bg,                                                         //< factor beforen soil coverage
                    F_et: real;                                                    //< factor before evapotranspiration
             end;

 { soil temperature dynamics as result of heat conduction that is calculated using an approach of NEUSYPINA
   calculates the upper and lower boundary condition and heat conductivity as function of soil moisture
   indicates a re-freezing of soil to be considered for soil structure dynamics       }
     Tbotemp  = class(Tobject)
                nt: integer;               //< number of internal time steps for each day
                tsd:profil;                //< soil particle density
                trd:profil;                //< soil bulk density
                k1:profil;                 //< numeric helper
                k2:profil;                 //< numeric helper
                dichtewsp:profil;          //< numeric helper
                sdepth   :integer;         //< depth of soil profile
                variante:integer;          //< mode to calculate surface temperature   (2:lubotr2 or 3:lubotr3) ; each using different parameter values
                re_freezing: array [1..20] of boolean;     // indicates re-freezing layer
                h_prm,                          //< parameter set @link(Tbtparm) for warm soil (surface temperature >=2°C
                l_prm  : tbtprm;                //< parameter set @link(Tbtparm) for cold soil (surface temperature <2°C
                amplitude : real;               //< of soil temp. dynamics (sinus) at lower boundary
                d_sh : real;                    //< phase shift fo soil temp. dynamics (sinus) at lower boundary
                TUR    : real;        //< average temperature at lower boundary
                _a_ :double;          //< heat conductivity as average in profile
                parmstr:string;       //< label of imported parameter set
                constructor create(amp,phi,ploc,LTEM:real;asprfl:T_soil_profile);    //< build up the object,read the parameters
       //         procedure   temp_init(t0,t1:real;datum:string;var s:sysstat);        //< old version to initialise
                procedure   daystep(var s:sysstat);  //< daily temperature dynamics in soil profile
               end;

implementation
uses cdyspsys ,cdyparm;

constructor Tbotemp.create(amp,phi,ploc,LTEM:real;asprfl:T_soil_profile);
var i,j,k,n,m  :byte;
    xtd,xhk,x,trd_,amp_0,d_sh_0  :real;
    hkap       :profil;
    version_,
    name,
    schicht,
    zeile ,hlp_str     :string;
    f          :text;
    hh         :integer;
    ok:boolean;
    tmptab     :tfdtable;
    soil_spec  :boolean;



    function get_amp(amp_obfl, z, lambda: double):real;
    var    d:double;
    begin
       // z: tiefe in m
       // lambda: temperaturleitfähigkeit in m²/d
       d:=-z*sqrt(pi/(365*lambda));  // hilfsgröße
       get_amp:=amp_obfl*exp(d);
    end;


    function get_phi (phi_obfl, z, lambda: double):real;
    var    d:double;
    begin
       // z: tiefe in m
       // lambda: temepraturleitfähigkeit in m²/d
        d:=-z*sqrt(pi/(365*lambda));  // hilfsgröße
        get_phi:=phi_obfl+365*d/(2*pi);
    end;

    procedure get_value(keep:boolean; pn:string; var pv:real);                      // get a parameter value (pv) indicated by pn from tmptab that wraps the table cdyptprm
    begin                                                                           // keep=false signals the prameter is mandatory, if no record is found pv is set to -999
      if tmptab.Locate('P_NAME',pn,[loCaseInsensitive])                             // keep=true  pv is not changed
       then pv:=tmptab.fieldbyname('VALUE').asfloat
       else
       begin
        if not keep then pv:=-999; // code for missing value
       end;
    end;


    procedure Parameter_lesen(keep_pv:boolean);
    begin                                                                          // extract all required parameters
       tmptab.Filter:=version_+' and MODEL='+''''+'high_1'+'''';                   // version_ contains part of the filter condition (i.e. profile name)
       tmptab.filtered:=true;
       get_value(keep_pv,'F_BT',h_prm.f_bt);
       get_value(keep_pv,'F_LT',h_prm.f_lt);
       get_value(keep_pv,'F_GS',h_prm.f_gs);
       get_value(keep_pv,'E_GS',h_prm.e_gs);
       get_value(keep_pv,'F_ET',h_prm.f_et);
       if variante=2 then       // this is the default
       begin
        tmptab.close;
        tmptab.Filtered:=false;
        tmptab.Open;
        hlp_str:=VERSION_+' and MODEL='+''''+'low_1'+'''';
        tmptab.Filter:=hlp_str;
        tmptab.filtered:=true;
        get_value(keep_pv,'F_BT',l_prm.f_bt);
        get_value(keep_pv,'F_LT',l_prm.f_lt);
        get_value(keep_pv,'F_GS',l_prm.f_gs);
        get_value(keep_pv,'E_GS',l_prm.e_gs);
        get_value(keep_pv,'F_ET',l_prm.f_et);
       end;

     // Parameter für Randbedingung
      tmptab.close;
      tmptab.Filtered:=false;
      tmptab.Open;
      hlp_str:=VERSION_;
      tmptab.Filter:=hlp_str;
      tmptab.filtered:=true;
      get_value(keep_pv,'AM_lo',amplitude);
      get_value(keep_pv,'PH_lo',d_sh);
      get_value(keep_pv,'AM_up',amp_0);
      get_value(keep_pv,'PH_up',d_sh_0);
      get_value(keep_pv,'MT_up',TUR);
    end;

begin     // constructor


 nt:=2;        {interne zeitschritte}
 asprfl.put_trd(20,trd);
 asprfl.put_tsd(20,tsd);
 asprfl.put_hkap(20,hkap);
 asprfl.put_maxdepth(sdepth);
 for j:= 1 to sdepth do
    begin
       // Einfügung zur Fehlervorbeugung: Die lambda berechnung nach Neusypina
       // lässt nur TRD-Werte>0.56 zu
       // deshalb wird hier der Wert 0.6 als Minimum angenommen
          trd[j]:=max(0.6,trd[j]);
          dichtewsp[j]:=trd[j]*hkap[j];
          k1[j]       :=259.2*trd[j]-146.88;
          k2[j]       :=11.5-5*trd[j];
    end;
 for j:=sdepth+1 to 20 do
    begin
          trd_:=1.475;  // empirisch gesetzt durch qualitativen Vergleich
                        // mit den Meßwerten vom Drömling in 2003
          dichtewsp[j]:=trd_*hkap[j];
          k1[j]       :=259.2*trd_-146.88;
          k2[j]       :=11.5-5*trd_;
    end;

//---- open the parameter table ----------------------------------------
  tmptab:=tfdtable.create(nil);
  tmptab.Connection:=dbc;
  tmptab.tablename   :='CDYBTPRM';
  tmptab.open;

//----prepare a check if there are data for a special soil profile
  soil_spec:=false;
  if  tmptab.Fields.FindField('profile')<>NIL then soil_spec:=true;

  variante:= round( cdyaparm.parm('BT_MODELL'));
  //variante:=2;


//////////////////////////////////////////////////////////////////////////////////////////
///                                    Parameter lesen                                 ///
//////////////////////////////////////////////////////////////////////////////////////////
// erster Schritt: allgemeingültig (für alle Böden)
   version_:='VERSION='+inttostr(variante);                                      // prepare message output
   if soil_spec then  version_:=version_+' and profile='+''''+ '*'+'''';         // the profilename (*) is here unspecific
   parameter_lesen(false);                                                       // get mandatory parameters


////////////////////////////////////////////////////////////////////////////
// zweiter Schritt: spezial (nur für aktuellen Boden)
   version_:='VERSION='+inttostr(variante);                                      // prepare message output
   if soil_spec then
   begin
   tmptab.Close;
   tmptab.Filtered:=false;
   tmptab.Open;
   version_:=version_+' and profile='+''''+    candy.sprfl.prfbez +'''';         // prepare filter conditions for parameter table (if soil_spec=true)
   parameter_lesen(true);                                                        // get additional parameters
   end;

// sicherstellen, das die notwendigen "Hausnummern" für den oberen Rand im Bedarfsfall definiert sind
// default assumptions for upper boundary
  if amp_0 =-999 then amp_0 :=11;
  if d_sh_0=-999 then d_sh_0:=170;

  // lower boundary: if nothing given then use ltem from cdy_fxdat
  if TUR < -90 then TUR:=LTEM ;  // wenn kein Parameter definert war; wert aus Festdaten übernehmen


  tmptab.Close;  tmptab.Filtered:=false;
  tmptab.Open;
  tmptab.First;

  //get heat conductivity from current soil profile and transform the unit
  _a_:=  asprfl._a_ * 86400;   //s==>d          //  0.1 wäre eine ganz grobe Standard-Annahme für _a_

  if amplitude=-999
   then amplitude:= get_amp(amp_0, sdepth/10, _a_);
  if d_sh=-999
   then d_sh:=get_phi(d_sh_0,sdepth/10,_a_);

  parmstr:='mv='+inttostr(variante)+                                             // build string for message output
          ', amp_u='+floattostr(roundto(amp_0,-2))+
          ', pha_u='+floattostr(roundto(d_sh_0,-2))+
          ', amp_l='+floattostr(roundto(amplitude,-2))+
          ', pha_l='+floattostr(roundto(d_sh,-2))+
          ', avr_T='+floattostr(roundto(TUR,-2));

 tmptab.Close;                                                                   // get rid of parameter table
 TMPTAB.FREE;
end;



(***sw_t_beg
procedure Tbotemp.temp_init(t0,t1:real;datum:string;var s:sysstat);
                              {t0 u.t1 sind die Bodentemperaturen am oberen}
var i,j :integer;             {und unteren Rand(=3m) des Bodenprofils }
    tofl:real;                {datum gibt das Startdatum an}
{Annahme: Minimum=0 øC am 15.2. und cosinusförmiger Jahresgang}
// dieser teil ist passiv !!!
begin
     i   := dbfdaynr(datum);
     tofl:=t1-(t1-t0)*cos(2*pi*(i-35)/365);  {Temperatur an der Oberfl„che}
     j:=20;
     for i:=1 to j do s.ks.botem[i]:=tofl+(t1-tofl)*(i-1)/29;
    // bt.TUR:= t1;
end;
sw_t_end ***)


procedure Tbotemp.daystep(var s:sysstat);
var h1,h2,h3,h4:string;
type dim1=array[1..20] of real;
var   bt0,wleit,rwcap:dim1;
      btofl,x      : real;
      i : byte;

        {Variante 2 (T-Oberfläche)}
        procedure lubotr2(var ss:sysstat);
        var rad:real;
            parm:tbtprm;
            bw_zufuhr,bw_aet :real;
        begin
         bw_zufuhr:=ss.Infilt;
         bw_aet   :=ss.aet;
         if ss.ks.botem[1]<2 then parm:=l_prm else parm:=h_prm;
         with parm do
          begin
           if ss.wett.glob>0 then rad:=ss.wett.glob else rad:=0.000001;
           if (ss.ks.snow=0)  or ((ss.ks.snow<=5) and (bw_zufuhr=0))
             then  {keine bzw. geringe aber trockene Schneedecke}
               btofl:=  f_bt*ss.ks.botem[1]
                      + f_lt*ss.wett.lt
                      + f_gs*exp(e_gs*ln(rad))*exp(f_bg*ss.ks.bedgrd)
                      + f_et*bw_aet     //            + f_et*_bw.aet
             else  {mit relevanter oder schmelzender Schneedecke}
                if  {_bw.zufuhr} bw_zufuhr>0
                   then btofl:=ss.ks.botem[1]*ss.ks.bofeu[1] /({_bw.zufuhr}bw_zufuhr+ss.ks.bofeu[1])
                   else btofl:=(ss.ks.botem[1]+ss.ks.botem[2])/2;
           end;{with parm}
         ss.ks.botem[1]:=btofl;
        end;

(* *********************************************************************** *)

      {Variante 3 (mit Wärmekapazität)}
      procedure lubotr3(var ss:sysstat);
      var rad:real;
          wkw,
          wkap:real; {Wärmekapazität}
          bw_zufuhr,bw_aet :real;
      begin
       bw_zufuhr:=ss.Infilt;
       bw_aet   :=ss.aet;
       if s.ks.botem[1]<0 then wkw:=1.9 else wkw:=4.2;
       wkap:=2.2*trd[1]/tsd[1]+wkw*(1-trd[1]/tsd[1])*s.ks.bofeu[1]/100+0.0013*(1-trd[1]/tsd[1])*(1-s.ks.bofeu[1]/100);
        l_prm:=h_prm;
        with h_prm do
        begin
         if ss.wett.glob>0 then rad:=ss.wett.glob else rad:=0.000001;
         if (ss.ks.snow=0)  or ((ss.ks.snow<=5) and (bw_zufuhr=0))
         then  {keine bzw. geringe aber trockene Schneedecke}
               btofl:=  f_bt*wkap*(s.ks.botem[1]+273)
                      + f_lt*ss.wett.lt
                      + f_gs*exp(e_gs*ln(rad))*exp(f_bg*ss.ks.bedgrd)
                      + f_et*{_bw.aet}bw_aet
         else  {mit relevanter oder schmelzender Schneedecke}
             if   bw_zufuhr>0
               then btofl:=ss.ks.botem[1]*ss.ks.bofeu[1] /({_bw.zufuhr}bw_zufuhr+ss.ks.bofeu[1])
               else btofl:=(ss.ks.botem[1]+ss.ks.botem[2])/2;
         end;{with parm}
        ss.ks.botem[1]:=btofl;
      end;



     procedure bodkonst;
     const r=20;
     var j:integer;
         w:real;

     begin
     {
      dx: Schichtdicke in cm
      dt: Zeitschritt in Tagen
      dt:=1/nt;
       r:=dx/dt;
       zddx:=2/dx
     }
       for j:=1 to sdepth do
       begin
         w:=s.ks.bofeu[j]*0.01;             { relativer Wassergehalt - bofeu ist in VOL% }
         if w>0 then wleit[j]:=k1[j]/(1.0+k2[j]*exp((-50.0)*exp(1.5*ln(w/trd[j]))))
                else wleit[j]:=wleit[j-1]; { [wleit] = cal/( cm d K ) }
         rwcap[j]:=r*(dichtewsp[j]+w);     { [wcap]  = cal/( ccm K ) }
       end;

       w:= s.ks.bofeu[candy.sprfl.btief]*0.01;
       for j:=sdepth+1 to 20 do
       begin
          wleit[j]:=k1[j]/(1.0+k2[j]*exp((-50.0)*exp(1.5*ln(w/trd[j])))) ;
          rwcap[j]:=r*(dichtewsp[j]+w);
       end;
      end;


 (* eigentliche Berechnung der Temperaturverteilung *)
    procedure bodentemp;
    const zddx=0.2;                    { [zddx] = 1/cm ; 2/dx }

    var i,j,k,index1,index2:integer;
           wleits,h1,ae,aw,aemerk:real;
           subd,superd,diag,rhs:profil;

             procedure tridag(a,b,c,r:profil;var u:profil;n:integer);  // solves the equations
             var j:integer;bet:real;gam:profil;                        // from tridiagonal format
             begin
               if(b[1]=0.0) then begin send_msg('pause1 in tridag',1) end;{falls erstes Diagonalelement =0 ist}
               bet:=b[1];
               u[2]:=r[1]/bet;
               for j:=2 to n do begin
                 gam[j]:=c[j-1]/bet;
                 bet:=b[j]-a[j]*gam[j];
                 if (bet=0) then begin send_msg('pause2 in tridag',1) end;
                 u[j+1]:=(r[j]-a[j]*u[j])/bet
               end;
               for j:=n downto 2 do begin
                 u[j]:=u[j]-gam[j]*u[j+1]
               end ;
             end;

      begin
        { TEMPERATURMODUL }
           wleits:=wleit[2];                        { oberste Bodenschicht}
           h1:=wleit[1];
           aw:=zddx*wleits*h1/(wleits+h1);         {Bestimmung der W.leitfähigkeit an der Phasengrenze 1. und 2. Rechenschicht}
                                                   {als harmon. Mittel: aw:=(2*wleit[1]*wleit[2]/(wleit[1]+wleit[2]))/10}
                                                   { mit 10=Schichtdicke in cm (=dx) }
           aemerk:=aw;
           for j:=2 to 19 do begin  { Bodenschichten bis auf die unterste }
             i:=j-1;
             h1:=wleit[j+1];
             ae:=zddx*wleits*h1/(wleits+h1);
             subd[i]:=-aw;
             superd[i]:=-ae;
             diag[i]:=ae+aw+rwcap[j];
             aw:=ae;
             wleits:=h1;
           end;
           subd[19]:=-aw-aw;                { unterste Bodenschicht }
           diag[19]:=aw+aw+rwcap[20];
           {Dreyhaupt 13.07. 2000 Beginn der Einfügung }
           subd[19]:=-aw; {neue untere Randbedingung: es wird angenommen, dass die Bodentemp in Tiefen > als 2 Meter}
                          {konstant ist (mittl. Lufttemp. des Standortes bzw. einer anderen konst. Temperatur) und die }
                          {Wärmeleitfähigkeit für tiefere Schichten gleich der Wärmeleitfähigkeit der tiefsten (20.) Schicht}
                          { ist. Das Element subd[19] wird deswegen wie die anderen Elemente subd[i] i=1,...,18 berechnet.}
                          {Die mit Einführung dieser Randbedingung notwendige Änderung der rechten Seite des Gleichungssystems}
                          {erfolgt bei der Abarbeitung der 2 Tagesschritte der Temperaturberechnung (Element rhs[19])}
           {Dreyhaupt 13.07. 2000 Ende der Einfügung }
           for k:=1 to nt do { nt=2 : Zwei Zeitschritte pro Tag}
              begin          { Zeitschleife }
               for i:=2 to 20 do {der Vektor rhs entspricht der rechten Seite des Gleichungssystems}
                           rhs[i-1]:=rwcap[i]*s.ks.botem[i];
               rhs[1]:=rhs[1]+aemerk*s.ks.botem[1]; {rhs[1] ist Summe aus dem in der obigen Schleife errechneten Wert und dem}
                                                    {Produkt aus Wärmeleitfähigkeit * Bodentemperatur der obersten Rechenschicht}

     {Analyse der trigonometrischen Formeln ergab nur marginale Effekte für die Sommer-Winter Differenzierung
      wichtiger schien eine Anpassung an verschiedene Standortverhältnisse
      (WAGNA!!, Daten von Hans Fank; Arbeit von Enrico Thiel)
      deshalb jetzt leicht vereinfachter Ansatz;
      liegen Messergebnisse vor so findet man den Faktor vor SIN aus der Amplitude und den Summand TUR als Mittelwert
      Phasenverschiebung kann u.U. graphisch abgelesen werden  }

              //untere Randbedingung
               RHS[19]:=rhs[19]+2*rwcap[20]*( amplitude*sin((s.ks.tag+d_sh)*2*pi/365)+ TUR );
               tridag(subd,diag,superd,rhs,s.ks.botem,19);
              end;
      end;

begin

if not s.wett.inkub then
  begin

  // alte Temperaturen merken
  for i:=1 to 20 do bt0[i]:=s.ks.botem[i];

  // several approaches to calculate the temperature of the uppermost soil layer
    case variante of
//     1: lubotr1(s.wett.ltvg,s.wett.ltg,s.wett.lt,s.ks.botem[1]);   //the Suckow approach is not longer implemented
   2: lubotr2(s);             //this is the default
   3: lubotr3(s);
   end;

  bodkonst;   // Konstanten berechnen
  bodentemp;  //  Gleichungssystem lösen
  h1:=datum(s.ks.tag,s.ks.jahr);
  h2:=real2string(s.wett.lt,5,1);
  h3:=real2string(s.ks.botem[15],5,1);
  // re-freezing checken:
  for i:= 1 to 20 do
    begin
     re_freezing[i]:= (bt0[i]>0) and (s.ks.botem[i]<=0);
    end;

  end else
  begin   // Inkubation : Bodentemperatur aus Wetterdaten
    for i := 1 to 20 do s.ks.botem[i]:=s.wett.btem;
  end;
end;


begin
end.