{
 this is mainly the parameterization of the soil profile with the class T_soil_profile
}
{$INCLUDE cdy_definitions.pas}
unit soilprf3;

interface
{Drainage berücksichtigen (Parameterverwaltung, 13.11.95}
uses

{$IFDEF CDY_GUI}
cdy_glob,
{$ENDIF}
{$IFDEF CDY_SRV}
cdy_config,
{$ENDIF}

//CANDY
 cnd_vars,cnd_util,ok_dlg1,db,
//DELPHI
 FireDAC.Comp.Client, {adodb,}sysutils,math,
{$IFDEF WIN32}
// registry,windows,
{$ENDIF}
 {controls,}classes,{forms,}strutils,cdyptf;

type
  ptr_bo_schicht = ^bo_schicht;
  bo_schicht     = object
                     nr : integer;
                     anteil,
                     fkap,pwp_,lmd,dispers,     {Parameter}
                     bofeu,nin,                               {Zustandsgröße}
                     wout,nout : real;                        {Fluágröße}
                     constructor init(disp,fkp,pwp,lambda,xnin:real; snr:integer);
                     destructor done;
                     procedure daystep(var wver,naus,marked,bedarf : real; durchwurzelt:boolean);
                   end;

 ptr_schichtliste = ^t_schichtliste;
 t_schichtliste   = record
                     schicht : ptr_bo_schicht;
                     next:ptr_schichtliste;
                   end;

  T_soil_profile= class(Tobject)
               rrr: array[0..20] of real;    {relative rooting resistance}
               a_h,
               a_h_q,
               ct,
               ct_0,                         // referenz-c-gehalt [%]
               absetzgrad,
               b_rm,                        //ruehlmann-faktor der dichteänderung
               dmin_rm,                     //ruehlmann: Dichte der mineralischen Bodenbestandteile
               nin_0,
               k_nin,

               fkap_0,
               fkap,
                pwp_0,
               pwp,
                trd_0,
               trd,                        //!
                tsd_0,
               tsd,
               wc_ma_me,                     // Makro->mesoporen
               wc_me_mi,                     // Wassergehalt (vol%) am Übergang vom meso zu mikroporenraum
               pvol,
               hkap,
               hhth,
               fat,
               Fmana,                        // Managementfaktor der Dichteänderung
               stone_cont,
               pof4ci,
               sand,
               ton,
               ard,
               lambda  : profil;
               _a_  :double; //Temperaturleitfähigkeit
               darcy_mode:boolean;

               Dr_Depth: integer;            {Tiefe der Drainage in dm}
               Dr_Effct,                     {Verteilung des aus der Schicht abflieáenden Wassers}
               k_sat,                        { drain:=versi*dr_effct; versi:=versi-drain         }
               Fkryo,
               c_inert,                      // in %
               c_inert_kg,                   // in kg/ha
               cif     : real;
               cim     : string;
               hbez    : array[1..20] of string[10];
               kdepth,
               xtief,
               btief   : integer;
               auto_soil,
               c_inert_adapted,
               genuchten_parm,
               hydromorph :boolean;
               mdae03,mdae36,mdae69:real;
               prfbez:string;
               tmphrzn:tfdtable;


                      bd,pd,kfc,kwp,kpv:double ;   //ssd results


               constructor create(d_path,prfname:string;n_level:real;switch:Tcdy_switch; prmdoc:boolean);
               destructor  free;

               procedure   adapt(st:statrec);
               procedure   put_fkap(ix:integer; var f:profil);
               procedure   put_hkap(ix:integer; var f:profil);
               procedure   put_ct(ix:integer; var f:profil);
               procedure   put_lambda(ix:integer; var f:profil);
               procedure   put_pwp(ix:integer; var f:profil);
               procedure   put_trd(ix:integer; var f:profil);
               procedure   put_tsd(ix:integer; var f:profil);
               procedure   put_pvol(ix:integer; var f:profil);
               procedure   put_hbez(ix:integer; var n:string);
               procedure   put_fat(ix:integer; var f:real);
               procedure   put_sand(ix:integer; var f:profil);
               procedure   put_maxdepth(var ix:integer);
               procedure   put_maxrooting(var ix:integer);
               procedure   put_tildepth(var ix:integer);
               procedure   put_hhth(ix:integer; var h:integer);
               procedure   msg_trd(var msg:string);
               procedure   msg_tsd(var msg:string);
               procedure   msg_fkap(var msg:string);
               procedure   msg_pwp(var msg:string);
               procedure   msg_c_t(var msg:string);
               procedure   put_nin0(ix:integer;level:real; var nin:real);
               procedure   put_ksat(var x:real);
               procedure   put_KDeffRho(ix:integer; var KDeff, rho:double);
               function    free_drain:boolean;
               procedure   calc_btemp_prm;     // Schätzwert der Temperaturleitfähigkeit
               procedure   nmin_init(n_level:real; var s:sysstat);
               procedure   check_inert_carbon(CORG_PROZ:real; var ci_adapted:boolean);
             end;


      T_dens_dyn=class(tobject)
                   active,            // first Item !!
                   roll_over,
                   regelspur  :boolean;
                   dev_name   :string;
                   kfc_ap,
                   trd_ap,
                   bi_mittel,
                   bi_max,
                   dauer_bi,
                   gefstab,
                   bi_ra,
                   bi_ru,
                   bi,
                   trd_,
                   height_ap,
                   width,
                   p_rad,
                   p_in,
                   b_area,  //betroffener Flächenanteil (<1
                      z,  // tiefe
                   pva,    // mit den Aggregaten assoziiertes PV
                   f_bioturb,
                   ard: real;    // Aggregatdichte
                   ndrive:integer;
                   fk_,
                   pv_,
                   pw_,
                   gefstabi,
                   trd0,
                   trd,
                   h_pwp,
                   delta_trd,
                   h_fkap: array[1..3] of real;
                   bi_ar: array[1..20] of real;

                   //test
                    test_i:integer;
                    fk_test: array[1..7] of real;
                   constructor create(aprf:T_soil_profile; dyn_sprm:boolean);
                   procedure daystep(s:sysstat);
                   procedure get_management(s: sysstat;device:integer);
                   procedure tillage(depth:real;device:integer);
                   procedure calc_param  (TON,sand,por,           pwp_h,fkap_h:real; var FKap_k, pwp_k, da_mic,da_mes : Real);
                   procedure calc_par_vgv(ton,sand,_por_,_trd_,corg,pwp_h,fkap_h:real; var FKap_k, pwp_k, da_mic,da_mes : Real);

                 end;





function calc_parm    (ton,sand,por, X :real): real;
function calc_parm_vgv(ton,sand,_por_,_trd_,corg,X:real):real;

implementation
uses cdysomdyn,cdystemp,scenario,{nicht in dll darcy_fluxu1,}cdyspsys ,cdyparm;


constructor  T_dens_dyn.create(aprf:T_soil_profile; dyn_sprm:boolean);
var i:integer;
    corg:real;
    ok:boolean;
begin
  active:=dyn_sprm;                   // wenn ja, wird die Bodenstructur dynamisch verändert

 active:= active and ( dev_parm<>NIL );  // only full active if dwvice parameters are defined
 if active then
  begin
   bi:=0;
   dauer_bi:=0;
   bi_max:=0;
   bi_mittel:=0;
   ndrive:=0;
   roll_over:=false;       // Intialisierung
   for i:= 1 to 20 do bi_ar[i]:=0;
   for i:=1 to 3 do
   begin
    trd[i] := aprf.trd[i];
    trd0[i]:=trd[i];
    fk_[i] :=aprf.fkap[i];
   end;
   // --- mean bulk density of top soil
   trd_:=0;
   for i:= 1 to 3 do trd_:=trd_+trd[i]/3;
   //candy.sprfl.put_trd(3,trd0);  // TRD0 ist die 'normal'-Dichte für die Berechnung Lockerung-Absetzen
                           // nach Schaaf: Lagerungsdichte nach (natürlicher) Rückverfestigung
  // s.u. daystep basis_trd:=trd0*0.85;   // Bezugsdichte zur Berechnung der lastabhängigen Verdichtung; die Annahme von 0.85 ist willkürlich!!

   //--- limit of compaction is ard
   ard:=aprf.ard[1];      // Aggregatdichte (s.a. Diss Rücknagel S.60  )
   pva:=1-ard/aprf.tsd[1];

   //----- Standardwert für Bioturbation
   ok:=false;
   if dd_parm<>nil then   dd_parm.is_field('f_bioturb',ok);
   if ok then  f_bioturb:=real(dd_parm.get_pval(1,'f_bioturb'))
         else  f_bioturb:=0.001;


  // candy.sprfl.put_fkap(3,fk_);
  if active then for i:=1 to 3 do
            begin
              pv_[i]:=100*(1-trd[i]/aprf.tsd[i]);

              // Brooks-Corey:
              //            h_pwp[i] :=calc_parm(candy.sprfl.ton[i],candy.sprfl.sand[i],pv_[i],candy.sprfl.pwp[i]);
              //            h_fkap[i]:=calc_parm(sprfl.ton[i],candy.sprfl.sand[i],pv_[i],candy.sprfl.fkap[i]);
              // vanGenuchten:
                           corg:=aprf.ct_0[i];
                           h_pwp[i] :=calc_parm_vgv(aprf.ton[i],aprf.sand[i],pv_[i],trd[i],corg,aprf.pwp[i]);
                           h_fkap[i]:=calc_parm_vgv(aprf.ton[i],aprf.sand[i],pv_[i],trd[i],corg,aprf.fkap[i]);
            end;

  end;
end;


procedure T_dens_dyn.tillage(depth:real;device:integer);
var ok:boolean;
    ef, dtrd:real;
    i:integer;
begin
if not active then exit;
 if depth >=2 then
 begin
   // reset Bi     (BelastungsIndex (Rücknagel)}
  bi:=0;
  bi_max:=0;
  bi_mittel:=0;
  dauer_bi:=0;
  ndrive:=0;
  for i:=1 to 20 do bi_ar[i]:=0;
 end;
  // lockerung
  tilldev.select(device,dev_name,ok);
  if ok  then
  begin
    tilldev.is_field('EFFECT',ok);
    if ok  then
    begin
      ef:=tilldev.parm('EFFECT');
      for i:= 1 to round(depth) do
      begin
      dtrd:=max(0,  (trd[i]-2*trd0[i]/3)*ef);      // Gl.   2, S.41 Diss Schaaf
      trd[i]:= trd[i]-dtrd;
      end;
    end;
  end;
end;

procedure T_dens_dyn.get_management(s: sysstat;device:integer);
var
   hstr:string;
   ok:boolean;
begin
 if not active then exit;
 // Gerät suchen
  dev_parm.select(device,dev_name,ok);
  if not ok then
  begin
  // Fehlermeldung
     _halt(55);
     exit;
  end;
   roll_over:=true;    // Überfahrt hat stattgefunden
   b_area:=0.75*dev_parm.parm( 'wheel_tracked_area');
   p_in:=  dev_parm.parm( 'inflation_pressure');
   p_rad:= dev_parm.parm( 'wheel_load');
   dev_parm.is_field('permanent_traffic_lanes',regelspur);
//   regelspur:=dev_parm.ptab.FieldByName('permanent_traffic_lanes').AsBoolean;
   if regelspur then
   begin
    width:= dev_parm.parm( 'working_width');
    hstr:=' on lanes of '+floattostr(width)+' m ';
   end
   else hstr:='';
   add_message(datum(s.ks.tag,s.ks.jahr)+' overdrive with '+dev_name+hstr);
end;

procedure T_dens_dyn.daystep(s:sysstat);
var fk,logsp,kw, rvf,
k20,sigz,logsz ,
s_area, h,r, sand,pv,lv,
a_trd,bi_reg,
bi_ein,f,corg:double;
i,j,l:integer;


kwi,logspi,logszi,
fki: array [1..3] of double;    // rel. Füllung der Feldkapazität (0..1)

BEGIN


 if not active then exit;
 // SOC-Einfluß auf Bodendichte

  corg:=candy.soil.corg;
  if corg<=0 then Exit;   // rücksprung wenn SOM nicht initialisiert


  trd_:=0;
  for i:= 1 to 3 do
   begin
    trd0[i]     := trd_ruehlmann_new(candy.sprfl.b_rm[i], candy.sprfl.ton[i],corg){/candy.sprfl.absetzgrad[i]};
    candy.sprfl.tsd[i]:=tsd_ruehlmann(candy.sprfl.dmin_rm[i],candy.sprfl.ton[i], corg);
    trd_        :=trd_+trd[i]/3;
   end;
{ dynamik wegblenden     }
   ard:=candy.sprfl.tsd[1]*(1-pva);    // Dynamisierung der Aggregatdichte

 // natürliche Rückverfestigung
 if (s.perko[1]+s.perko[2]+s.perko[3])>0 then
     for i:=1 to 3 do
     if trd[i]<trd0[i] then
     begin
        sand:=candy.sprfl.sand[i];
        rvf:=s.perko[i]*(1+ 2*sand/(sand+exp(8.597-0.075*sand))/ power(10*i,0.6));  //i: hier: tiefe in dm 10*i ergibt tiefe in cm
        trd[i]:=trd[i]+(trd0[i]-trd[i])*( rvf / (rvf+exp(3.735-0.08835*i)));        // Faktor 10 in der Konstanten berücksichtigt !
     end;                                                                           // TRD0 - Lagerungsdichte nach Rückverfestigung

 // Kryoturbation
     for i:= 1 to 3 do
     begin
        if candy.bt.re_freezing[i] then
        begin

           pv    := 1-trd[i]/candy.sprfl.tsd[i];
           lv    :=pv-s.ks.bofeu[i]/100;
           pv    :=lv+s.ks.bofeu[i]*0.0109;
           trd[i]:=(1-pv)*candy.sprfl.tsd[i];
       end;
     end;

// Bioturbation
   for i:=1 to 3 do
   begin
     trd[i]:=trd[i]-f_bioturb*s.wmz[i];
   end;

// natürliche Regeneration bewerten
   a_trd:=0;
   for i:=1 to 3 do a_trd:=a_trd+trd[i]/3;

// entlastung:
   bi_reg:=(trd_-a_trd-0.012) / 0.29;
   if bi_reg>0 then
   begin
      dauer_bi:=min(bi_reg,dauer_bi);
   end;



// Technogene Verdichtung
 z:=10*candy.sprfl.kdepth;    // wirksame Tiefe in cm (hier:Krumentiefe)
// 1. Gefügestabilität
 fk:=0;
 for i:= 1 to 3 do
 begin
    fki[i]:= s.ks.bofeu[i]/fk_[i];
    fk:= fk+fki[i];
 end;
 FK:= 100* fk/3;


  (*ausgeblendet (vorläufig)
 // detail:
 for i:=1 to 3 do
 begin
 logspi[i]:=-3.15   * ard/trd[i] + 0.6*trd[i]+4.49;
 kwi[i]:= 2.8335 - 0.9271 * logspi[i]-0.0279*FKi[i] + 1.67E-7 * FKi[i]*FKi[i] +0.00906*logspi[i]*FKi[i] ;
 gefstabi[i]:=kwi[i]+logspi[i];
 end;
  *)


 // Kompakt
 logsp:=-3.15   * ard/trd_ + 0.6*trd_+4.49;
 kw   := 2.8335 - 0.9271 * logsp   -0.0279*FK     + 1.67E-7 * FK*FK +0.00906*logsp*FK;
 gefstab:=kw+logsp;

roll_over:=false;
if  roll_over then
begin


// 2. Bodendruck
//get p_in (INFLATION PRESSURE [kPa ? ]), p_rad - (WHEEL LOAD [ kg ]), b_area -(WHEEL TRACKED AREA [0..1])  width - (m)
(*
  append(testdaten);
  writeln(testdaten,'TAG=',s.ks.tag,' JAHR=',s.ks.jahr,' relFK=',fk);
  flush(testdaten);
  closefile(testdaten);
  *)

 (*
 for i:=1 to 3 do
 begin
  k20:=-2*logspi[i]+0.03*FKi[i]+3.2;
  r:= sqrt(100*P_rad/(2*PI*P_in));
  z:=i*10-5;
  h:= cos(arctan(r/z));
  sigz:=2*p_in*(1-power(h,k20));
  logszi[i]:=log10(sigz);
 end;
  *)

  k20  :=-2*logsp    +0.03*FK    +3.2 ;
  r    := sqrt(100*P_rad/(2*PI*P_in));   // Einheiten ? vgl mit Gl. 25       sqrt(P_rad/(2*PI*P_in/100))
  z    :=20;
  h    := cos(arctan(r/z));
  sigz :=2*p_in*(1-power(h,k20));   // in kPa
  sigz :=max(0.0001,sigz);
  logsz:=log10(sigz);              // Bodendruck !

 // 3. Indexberechnung
 bi_ein:=max(0,logsz-gefstab);   // für dieses Ereignis

 bi_mittel:= (ndrive*bi_mittel+bi_ein)/(ndrive+1);    // Mittelwertbildung
 ndrive:=ndrive+1;

 bi_max   := max(bi_max,bi_ein);   // wird bei tillage-Ereignissen >= 2 dm auf Null gesetzt; ebenso der Mittelwert bi_mittel

 // regelspurabhängig:
  bi_ra:=(( bi_mittel+bi_max)/2+bi_max)/2;

 // regelspurunabhängig                b_area ist schon mit 0.75 multipliziert (beim Einlesen)
  i:= min(20, ceil(10*bi_ein)) ;
  if (i>0) and (i<=20) then  bi_ar[i]:= bi_ar[i]+b_area;

  s_area:=0;
  bi_ru :=0;

  for j:= 10 downto 1 do
  begin
    i:=j;
    if (s_area<1) and (bi_ar[i]>0) then
      begin
       if (s_area + bi_ar[i]) <1
       then begin
              bi_ru:= bi_ru+ bi_ar[i]*(i-0.5)/10 ;
              s_area:=s_area+bi_ar[i];
            end
       else begin
              bi_ru:= bi_ru+ (1-s_area)*(i-0.5)/10;
              s_area:=1;
            end;
      end;
  end;

 //Zusammenfassung
 if width >0  then  bi:= bi_ra/width + bi_ru* (1-1/width)
              else  bi:= bi_ru;

 // 4. VerDichtung
 if bi > dauer_bi then
 begin
 dauer_bi:=bi;
 if bi>0 then
 begin
   for i:= 1 to 3 do
   begin
    delta_trd[i]:= 0.012+0.29*Bi ;
    trd[i]:= trd[i]+delta_trd[i];
    trd[i]:= min(trd[i],ard-0.01)
   end;
 end;(*if bi>0*)
 end;
       (*
        if test_I>0 then
        begin
        append(testdaten);
        writeln(testdaten,'TAG=',s.ks.tag,' JAHR=',s.ks.jahr, ' relFK=',fk,' p_rad=',p_rad,  ' k20=',k20,' logsz=',logsz,' gefstab=',gefstab, ' bi_ein=',bi_ein, ' bi=',bi, ' d_trd=',delta_trd[1]);
        flush(testdaten);
        closefile(testdaten);
        end;
       *)

   // Überfahrt wurde verarbeitet
  roll_over:=false;
 end;
       {  }
 // 5.höhenlagederbodenoberfläche

 f:=0;
 for i:=1 to candy.sprfl.kdepth do f:=f+(*h in dm *) candy.sprfl.trd_0[i]/trd[i] ;
 height_ap:= f*10; //in cm
 trd_ap:=0;
 for i:= 1 to 3 do
 begin
  trd_ap:=trd_ap+trd[i]/3;
  candy.sprfl.pvol[i]:= 100*(1-trd[i]/candy.sprfl.tsd[i]);
//Brooks-Corey:  calc_param( candy.sprfl.TON[i],candy.sprfl.sand[i], candy.sprfl.pvol[i],h_pwp[i],h_fkap[i],candy.sprfl.FKap[i],candy.sprfl.pwp[i], cips.d_mic,cips.d_mes);
//vanGenuchten:
//K  calc_par_vgv(candy.sprfl.TON[i],candy.sprfl.sand[i], candy.sprfl.pvol[i],trd[i],corg,h_pwp[i],h_fkap[i], candy.sprfl.FKap[i],candy.sprfl.pwp[i], 5{cips.d_mic},20{cips.d_mes});
 end;
 candy.b_w.prm_adapt;

END;

procedure   T_soil_profile.put_KDeffRho(ix:integer; var KDeff, rho:double);
var GMc,GMu,GMs ,c,s: double;
begin
 GMc:=0.632;
 GMu:= 11.225;
 GMs:=354.965;
 C:= ton[ix]/100;
 S:= sand[ix]/100;
 KDeff:= exp(C * ln(GMc) + (1-C-S) * ln(GMu) + S * ln(GMs))/1000;
 Rho:=  6.08025 * KDeff + 128.237 * KDeff*KDeff;
end;



procedure    T_soil_profile.check_inert_carbon(CORG_PROZ:real; var ci_adapted:boolean);
var i:integer;
    ci_proz:real;
begin
   //ci_adapted:=false;
   if (cim<>'PS') then exit;
   c_inert_adapted:=true;
   i:= 1;
   c_inert:=0;
  while not (pof4ci[i]=-99) do
  begin;
    ci_proz:=corg_proz*pof4ci[i];
    c_inert:= c_inert+ci_proz;
    inc(i)
  end;
   ci_adapted:=true;        // Nachricht, daß hiermit Ci eingestell wurde
   c_inert:=c_inert/(i-1);  // Mittelwert
end;

(*
constructor t_tiefboden.init(disp,fkp,pwp,lambda,nin:real;snr:integer);
begin
 new(fschicht);
 new(fschicht^.schicht,init(disp,fkp,pwp,lambda,nin,snr));
 fschicht^.next:=nil;
 aschicht:=fschicht;
 bfeu_tief:=aschicht^.schicht^.bofeu;
end;

procedure t_tiefboden.add_layer(disp,fkp,pwp,lambda,nin:real;snr:integer);
begin
  new(aschicht^.next);
  aschicht:=aschicht^.next;
  new(aschicht^.schicht, init(disp,fkp,pwp,lambda,nin,snr));
  aschicht^.next:=NIL;
  bfeu_tief:=bfeu_tief+aschicht^.schicht^.bofeu;
end;

function t_tiefboden.bofeu(s0,s1:integer):real;
var x:real;
begin
  x:=0;
  aschicht:=fschicht;
  while s0 >aschicht.schicht.nr do aschicht:=aschicht.next;
  x:=  aschicht.schicht.bofeu;
  while s1>aschicht.schicht.nr do
  begin
  x:=aschicht.schicht.bofeu+x;
  aschicht:=aschicht.next;
 end;
 x:=x/(s1-s0+1);
 result:=x;
end;


function t_tiefboden.sumno3n(s0,s1:integer):real;
var x:real;
begin
  x:=0;
  aschicht:=fschicht;
  while s0 >aschicht.schicht.nr do aschicht:=aschicht.next;
  x:=  aschicht.schicht.nin;
  while s1>aschicht.schicht.nr do
  begin
  x:=aschicht.schicht.nin+x;
   aschicht:=aschicht.next;
 end;
 result:=x;
end;

procedure t_tiefboden.daystep(var s:sysstat;var trans_rest: real);
var rooting:boolean;
begin
  aschicht:=fschicht;
  repeat
    rooting:=aschicht^.schicht^.nr<=s.ks.wutief;
    aschicht^.schicht^.daystep(s.grndwssrbldng,s.ninauswasch,s.w_marked,trans_rest,rooting);
    bfeu_tief:=bfeu_tief+aschicht^.schicht^.bofeu;
    aschicht:=aschicht^.next;
  until aschicht=NIL
end;

destructor t_tiefboden.done;
begin
  repeat
   aschicht:=fschicht^.next;
   dispose(fschicht);
   fschicht:=aschicht;
  until aschicht=NIL;
end;
  *)
constructor  bo_schicht.init(disp,fkp,pwp,lambda,xnin:real;snr:integer);
begin
  nr     :=snr;
  dispers:=disp;
  fkap   :=fkp;
  pwp_   :=pwp;
  lmd    :=lambda;
  nin    :=xnin;
  bofeu  :=fkap;
  anteil :=0;
end;

destructor bo_schicht.done;
begin
end;

procedure  bo_schicht.daystep(var wver,naus,marked,bedarf:real; durchwurzelt:boolean);
var dif,
    transp : real;
begin
  if marked>0 then anteil:=(marked*wver + anteil*bofeu)/(bofeu+wver);

  if (bedarf>0) and durchwurzelt then
  begin
   transp:=max({ratio_x*}(bofeu-pwp_),0);
   transp:=-max(-transp,-bofeu+pwp_);{minimum}
   bofeu:=bofeu-transp;
   bedarf:=bedarf-transp;
  end;

  bofeu := bofeu + wver;
  nin   := nin   + naus;
  dif   := bofeu - fkap;
  if dif > 0 then
    begin
      wver  := lmd * dif * dif / (1 + lmd * dif);
      bofeu := bofeu - wver;
      naus  := Dispers * wver / (bofeu + wver) * nin;
      nin   := nin - naus;
    end
  else
    begin
      wver:=0;
      naus:=0;
    end;
end;





{sw_m_beg}
procedure T_soil_profile.nmin_init(n_level:real; var s:sysstat);
var i,j:integer;
begin
  j:=  btief;
  for i:= 1 to j do
  begin
   s.ks.amn[i]:=0;
   put_nin0(i,n_level,s.ks.nin[i]);
  end;
  for i:=j+1 to 20 do
  begin
    s.ks.amn[i]:=0;
    s.ks.nin[i]:=0;
  end;
end;
{sw_m_end}



procedure   T_soil_profile.put_nin0(ix:integer;level:real; var nin:real);
begin

   nin:= nin_0[ix]+k_nin[ix]*(level-2);
   if nin<0.1 then nin:=0.1;

end;

constructor T_soil_profile.create(d_path,prfname:string;n_level:real;switch:Tcdy_switch; prmdoc:boolean);
                         //(dpath,prfname:string);
var hpfad,
    hrzbez,
    a_horz, l_horz,
    horz:string;

    genuchten,
    bodprof,
    horizont: tfdquery;
    ptfmode,
    i,j,k,n,lr,m ,hrz_nr:integer;
    disp,xwp,xdp,xlambda,xfk,nin, ks,_l,pv,atrd :real;
    ok:boolean;
    obsm,soc,
    x,x0:double;
    newprf,
    sba_tab:boolean;
    tprm:t_soil_parameter;
    pf_pwp,pf_fkap,p1,p2,p3:double;
    mp:t_material_property;    usa_sand:real;

    tmptab:boolean;


begin
 l_horz:='*';
 genuchten:=nil;
 ptfmode:=-1;
 auto_soil:=switch.auto_soil;
 ptfmode  :=switch.ptfmode;
 c_inert:=0;
 c_inert_kg:=0;


  newprf:=true;
 if n_level=2 then   // damit wird nur bei der 2. Initialisierung das darcy modell aufgebaut
 begin
 darcy_mode:=false;

//K  new(darcy,initialize);

 end;
 prfbez:=prfname;
{Lesen der physikalischen Parameter aus der Profilbeschreinung}
{Achtung: alle 20 Schichten müssen mit Parametern belegt werden}
{Die Verkürzung der Rechentiefe erfolgt in den dafür geeigneten Modulen}
 //tiefboden:=NIL;
  c_inert_adapted:=false; //Standardeinstellung am anfang
  i:=1;
  xdp:=cdyaparm.parm('DISP_KF');
  tmphrzn:=tfdtable.Create(nil);
  tmphrzn.connection:=dbc;//allg_parm.Connection;
  tmphrzn.TableName:='tmphrzn';
  bodprof:=tfdquery.Create(nil);
  bodprof.Connection:=dbc;//allg_parm.Connection;
  bodprof.sql.add('select * from cndhrzn');
  bodprof.Open;
  bodprof.First;
  n_level:=bodprof.RecordCount;    // initialisierung : verhindert vorzeitige initialisierung des darcy moduls
  bodprof.Close;
  bodprof.sql.Clear;
  sba_tab:=false;
(***
  // MDAE's ermitteln
  mdae03:=0;
  mdae36:=0;
  mdae69:=0;
  bodprof.sql.Clear;
  sba_tab:=true;

 try
  bodprof.sql.Add('select * from sbasoil where profil='''+prfname+''' ');
  bodprof.open;
 except sba_tab:=false end;

 if sba_tab then
  begin
    bodprof.first;

    if bodprof.RecordCount=1 then
    begin
      mdae03:=bodprof.fieldbyname('MDAE00_30').asfloat;
      mdae36:=bodprof.fieldbyname('MDAE30_60').asfloat;
      mdae69:=bodprof.fieldbyname('MDAE60_90').asfloat;
    end;
    bodprof.Close;
  end;

  ***)

  bodprof.sql.Clear;
  bodprof.sql.Add('select * from profile where profil='''+prfname+''' order by HORIZONT ');
  bodprof.open;
  bodprof.first;
  horizont:=tfdquery.create(nil);
  horizont.Connection:=dbc;//allg_parm.Connection;
 //// horizont.databasename:='cdyparm';
 // horizont.databasename:=allg_parm.DatabaseName;
 // horizont.sql.Add('select * from cndhrzn where name=:ahorz');
  j:=bodprof.recordcount;
  m:=0;
  hydromorph:=false;
  hrz_nr:=0;
  while not bodprof.eof do  { wdh. für alle Horizonte}
  begin
   {Horizont-Anfang}
   n:=m+1;     { n ist die Nummer der ersten Schicht im aktuellen Horizont}
   m:=bodprof.fieldbyname('HORIZONT').asinteger;  //Mächtigkeit des Horizontes in dm
   k:=0;
   horizont.close;
   a_horz:= bodprof.fieldbyname('HORIZ_NAME').asstring;

   if genuchten<>nil then
   begin
   genuchten.Close;
   genuchten.SQL.Clear;
   genuchten.SQL.Add('select * from van_genuchten where horiz_name='''+a_horz+'''');
   genuchten.open;
   genuchten.First;
   genuchten_parm:= ( genuchten.RecordCount=1 );
   end;

  // horizont.parambyname('ahorz').asstring:=  a_horz;
  horizont.sql.clear;
  horizont.sql.Add('select * from cndhrzn where name='''+a_horz+'''');
  horizont.open;


   // bisher: hier krumenspezifische Einstellungen

   for lr:=n to m do { alle Schichten in diesem Horizont belegen}
   begin
     pof4ci[lr] :=-99; // fehlwert als standart
     rrr[lr]:=0;
     if horizont.FieldDefList.Find('RELROOTRES')<>nil then
     begin
      rrr[lr]:=horizont.fieldbyname('RELROOTRES').asfloat;
     end;

     stone_cont[lr]:=0; // Standardwert zuweisen;
     if horizont.FieldDefList.Find('STONE_CONT')<>nil then
     begin
      stone_cont[lr]:=horizont.fieldbyname('STONE_CONT').asfloat;
     end;
     hbez[lr]   :=hrzbez;
     hhth[lr]   :=(m-n+1)/1.0;

     // vorläufige Parameter einlesen
     empty_parm_rec(tprm);
     ptf_get_parm(tprm.fkap,horizont.fieldbyname('FKAP').asfloat);
     ptf_get_parm(tprm.pwp, horizont.fieldbyname('PWP').asfloat);
     ptf_get_parm(tprm.tsd, horizont.fieldbyname('TSD').asfloat);
     ptf_get_parm(tprm.trd, horizont.fieldbyname('TRD').asfloat);
     ptf_get_parm(tprm.fat, horizont.fieldbyname('FAT').asfloat);
     ptf_get_parm(tprm.ks,  horizont.fieldbyname('KF').asfloat);
     ptf_get_parm(tprm.ton, horizont.fieldbyname('TON').asfloat);
     ptf_get_parm(tprm.u,  horizont.fieldbyname('SCHLUFF').asfloat);
     ct_0[lr]   := horizont.fieldbyname('CT').asfloat;
    // wird aus registry ermittelt (ptfmode) ptfmode:=3;
     p1:=1;p2:=1;p3:=1;
     pf_pwp:=4.2;
     pf_fkap:=1.8;
    // parametersatz auf Vollständigkeit prüfen und ergänzen
    if tprm.ton.v<=0 then
     begin
     // Fehlermeldung
      _halt(11);
      exit;
     end;
    if tprm.u.v<=0 then
     begin
      if tprm.fat.v>0 then  tprm.u.v:=txinterpol(tprm.ton.v,tprm.fat.v,0.002,0.0063,0.063);
     end;
    if tprm.sand.v<=0 then
     begin
      tprm.sand.v:=100-tprm.ton.v-tprm.u.v;
     end;

    ks        := horizont.fieldbyname('KF').asfloat;

    if auto_soil  then
    begin
      tmptab:=true;
      fill_up_parm_rec(ptfmode,ct_0[lr],p1,p2,p3, pf_pwp,pf_fkap,tprm);
      if a_horz<>l_horz then
      begin
       if prmdoc then
       begin
        try
         tmphrzn.Open;
        except  tmptab:=false;
        end;

        if tmptab
        then insert_soil_prm(tprm, a_horz, tmphrzn)
        else write_parm_rec(tprm, a_horz,d_path+prfname+'.spm',newprf);
       end;
       l_horz:=a_horz;
      end;
     if ks<0 then ks:=tprm.ks.v;
    end;
    // candy parameter übernehmen

     nin_0[lr]  := horizont.fieldbyname('NIN0').asfloat;
     K_nin[lr]  := horizont.fieldbyname('K_NIN').asfloat;
     fkap_0[lr] :=tprm.fkap.v;
     pwp_0[lr]  :=tprm.pwp.v;
     tsd_0[lr]  :=tprm.tsd.v;
     trd_0[lr]  :=tprm.trd.v;
     fat[lr]    :=tprm.fat.v;
     ton[lr]    :=tprm.ton.v;
     sand[lr]   :=tprm.sand.v;
      trd[lr]    := trd_0[lr];                 {Anfangswert}
     hkap[lr]   := horizont.fieldbyname('HKAP').asfloat;
     pv        := 100*(1-trd_0[lr]/tsd_0[lr]);
     lambda[lr] := 0.01 * ks / (pv-fkap_0[lr]);
      absetzgrad[lr]:= horizont.fieldbyname('K_TRD').asfloat ;
     if absetzgrad[lr] >0 then atrd:=      trd[lr]/absetzgrad[lr]  ;

     b_rm[lr]:= get_ruehlmann_b(trd[lr],ton[lr],ct_0[lr]);

     dmin_rm[lr]:=get_dmin(tsd_0[lr],ton[lr],ct_0[lr]);

     ard[lr]:=-99;
      try
      if horizont.FindField('ARD')<>NIL then
      begin
       ard[lr]:=horizont.fieldbyname('ARD').asfloat;
      end;
      except end;


      // Wassergehaltsklassen für Porenraumseparation festlegen
      wc_ma_me[lr]:=fkap_0[lr];// Makroporen oberhalb FK
      wc_me_mi[lr]:=pwp_0[lr]; // Mesoporen oberhalb PWP


     if (horizont.fieldbyname('HYDROMORPH').asboolean) then
      begin
       k_sat:=ks;
       hydromorph:= true;
      end
      else hydromorph:=false;

     cif       := 0.05;

     // Krumenspezifische Einstellungen

  if horizont.fieldbyname('KRUME').asinteger=1 then
  begin
   kdepth:=m;
  // standard:
   cim:='PS';
  // Nutzerangaben lesen
   if horizont.FindField('CIP')<>nil then cif:=  horizont.fieldbyname('CIP').asfloat;
   if horizont.FindField('CIM')<>nil then cim:=  horizont.fieldbyname('CIM').asstring;
   if pos(cim,'KORU')=0 then cim:='PS';   //standard falls unsinn eingelesen

   if cim='  KO' then c_inert:=cif* tprm.fat.v;                    { horizont.fieldbyname('FAT').asfloat}
   if cim='RU' then c_inert:=1.097*(1-exp(-0.0747* tprm.ton.v)); {horizont.fieldbyname('TON').asfloat}
   if cim='PS' then
       begin
             pof4ci[lr]:=100*pwp_0[lr]/(pv+49*fkap_0[lr]+50*pwp_0[lr]);      // Überprüft !!!!!!!!!!!
            {    Amac:= 2*(PV-FC)/(500);    Ames:= 2*(FC-PW)/10;    Amic:= 2*PW/5;   }
            c_inert:= c_inert + pof4ci[lr]*ct_0[lr];
       end;
       c_inert_kg:=c_inert_kg + 10000* pof4ci[lr]*ct_0[lr] * tprm.trd.v; {  horizont.fieldbyname('TRD').asfloat} // für 1 dm !
      end;
    end ;

  {Horizont-Ende}

  // für verbindung mit darcy-wasserfluss: horizont-Initialisierung

   if n_level=2 then   // damit wird nur bei der 2. Initialisierung das darcy modell aufgebaut
   begin
     //temporär:
     darcy_mode:=true;
     if darcy_mode then
     begin
      inc(hrz_nr);
      if genuchten_parm then
         begin
           mp.thr :=genuchten.FieldByName('the_r').AsFloat;
           mp.tha:=mp.thr;
           mp.ths :=genuchten.FieldByName('the_s').AsFloat;
           mp.thm :=mp.ths;
           mp.a   := genuchten.FieldByName('a').AsFloat;
           mp.alfa:=genuchten.FieldByName('alpha').AsFloat;
           mp.n   :=genuchten.FieldByName('n').AsFloat;
           mp.m   :=genuchten.FieldByName('m').AsFloat;
           mp.ks:=ks;
           mp.kk :=mp.ks;
           mp.thk:=mp.ths;
         end
         else mp_vereecken(ks, tprm.trd.v, ct_0[lr-1], tprm.ton.v, tprm.u.v, tprm.sand.v, usa_sand, mp);
      { nicht für dll    }
     //K  darcy.dcreate_hrz(hrz_nr,m,mp);
     end;
   end;
  // kein send_msg in der Initialisierungsphase
  // nur als Kontrolle  add_message('HRZ: '+horizont.parambyname('ahorz').asstring+
  // '    LMD='+floattostr(round(lambda[l-1]*10000)/10000));

  bodprof.next;
  end;

  c_inert    := c_inert/kdepth;
  c_inert_kg := c_inert_kg/kdepth;

  btief:=m;
  if darcy_mode then
  begin
    {nicht für dll    }
   //K darcy.prepare_gw(2000,1);      // Restschicht bis Grundwasser
  end;
  xtief:=m;
  if btief>20 then btief:=20;
  if m<20 then
  for lr:=m+1 to 20 do
  begin
   trd_0[lr]:=trd_0[m];
   tsd_0[lr]:=tsd_0[m];
   hkap[lr] :=hkap[m];
   hbez[lr] :=hbez[m];
   fkap[lr] :=0;
  end;
  for lr:=1 to 20 do
  begin
   fkap[lr]:=fkap_0[lr];
   pwp[lr] :=pwp_0[lr];
   trd[lr] :=trd_0[lr];
   tsd[lr] :=tsd_0[lr];
   pvol[lr]:=(1-trd[lr]/tsd[lr])*100;

   if pvol[lr]<fkap[lr] then  _halt(9);        // Fehler abfangen pvol<fkap

   ct[lr]  :=ct_0[lr];
  end;
   horizont.close;
  horizont.free;

 bodprof.Close;
 bodprof.SQL.clear;
 dr_depth:=0;

 bodprof.sql.add('select * from profile');
 bodprof.open;    // gibt es drainageparameter ?
 if bodprof.FieldList.Find('DR_EFFCT')    <> nil then
 begin
 {
 chklst:=tstringlist.Create;
 prmdlgf.cdyparm.GetFieldNames('profile',chklst);
 if chklst.IndexOf('DR_EFFCT') >0 then  begin
 }

  bodprof.Close;
 bodprof.SQL.clear;
 try
 bodprof.SQL.Add( 'select * from PROFILE where DR_EFFCT>0 and PROFIL='+''''+prfname+'''');
 bodprof.open;
 except dr_depth:=-99 end;
 if dr_depth=0 then
  begin
 bodprof.First;
 if bodprof.recordcount=0
  then   dr_depth:=-99
  else begin
         dr_depth:= bodprof.fieldbyname('DR_DEPTH').asinteger;
         dr_effct:= bodprof.fieldbyname('DR_EFFCT').asfloat;
       end;
// except dr_depth:=-99
 end; // if or try


 end;
 // chklst.Free;
 bodprof.free;

 rrr[0]:=0;
// new(dens_dyn,init);

// temperaturleitfähikeit
  calc_btemp_prm;


  tmphrzn.Close;
  tmphrzn.free;
 //K cips.initialize(kdepth);
 //screen.cursor:=crdefault;
end;

procedure T_soil_profile.calc_btemp_prm;
var i:integer;
     wg,ewg,cp,cv,cs,
     stc,
     lmbda:double;   //Wärmeleitfähigkeit
begin
   _a_:=0;
  for i:=1 to btief do
  begin
    stc:=stone_cont[i]/100;
    wg:= fkap[i]/trd[i];
    if sand[i]>(1+stc)/2
    then lmbda:= 0.1442 * (0.7 * LOG10(wg) + 0.4) * power(10, 0.6243*trd[i] )
    else lmbda:= 0.1442 * (0.9 * LOG10(wg) - 0.2) * power(10, 0.6243*trd[i] );
    lmbda:=(1-stc)*lmbda+stc* 2.93;                //2.93 [W/m/K]: wert für Granit
    cs:= 721.22 ;// spez wärme des gesteins [j/kg/K]
    ewg:=wg * (1-stc);
    cp:= (100*cs+4190*ewg )/(100+ewg);
    cv:=      cp*trd[i]*power(10,3);  // [j/m²/K]
    _a_ :=(_a_*(i-1)+lmbda/cv)/i;
  end;
end;

destructor T_soil_profile.free;
begin
if candy.dens_dyn<> nil then candy.dens_dyn.free;
end;

procedure   T_soil_profile.msg_trd(var msg:string);
var i:integer;
begin
 msg:='';
 for i:=1 to kdepth do  msg:=msg+real2string(trd[i],5,2)+' ';
end;

procedure   T_soil_profile.msg_C_T(var msg:string);
var i:integer;
begin
 msg:='';
 for i:=1 to kdepth do  msg:=msg+real2string(ct[i],5,2)+' ';
end;

procedure   T_soil_profile.msg_tsd(var msg:string);
var i:integer;
begin
 msg:='';
 for i:=1 to kdepth do  msg:=msg+real2string(tsd[i],5,2)+' ';
end;
procedure   T_soil_profile.msg_pwp(var msg:string);
var i:integer;
begin
 msg:='';
 for i:=1 to kdepth do  msg:=msg+real2string(pwp[i],5,2)+' ';
end;
procedure   T_soil_profile.msg_fkap(var msg:string);
var i:integer;
begin
 msg:='';
 for i:=1 to kdepth do  msg:=msg+real2string(fkap[i],5,2)+' ';
end;

procedure   T_soil_profile.put_hbez(ix:integer; var n:string);
begin
 n:=hbez[ix];
end;

procedure   T_soil_profile.put_fat(ix:integer; var f:real);
begin
 f:=fat[ix];
end;

procedure   T_soil_profile.put_sand(ix:integer; var f:profil);
var i:integer;
begin
 for i:= 1 to ix do f[i]:=sand[i];
end;

procedure   T_soil_profile.put_lambda(ix:integer; var f:profil);
begin
 f:=lambda;
end;

procedure   T_soil_profile.put_maxdepth(var ix:integer);
begin
 ix:=btief;
end;

procedure   T_soil_profile.put_maxrooting(var ix:integer);
begin
 ix:=xtief;
end;

procedure   T_soil_profile.put_ksat(var x:real);
begin
 x:=k_sat;
end;

procedure   T_soil_profile.put_tildepth(var ix:integer);
begin
 ix:=kdepth;
end;

procedure   T_soil_profile.put_hhth(ix:integer;var h:integer);
begin
 h:=round(hhth[ix]);
end;


procedure T_soil_profile.put_fkap(ix:integer;var f:profil);
var i:integer;
begin
 for i:=1 to ix do f[i]:=fkap[i];
end;
procedure T_soil_profile.put_hkap(ix:integer;var f:profil);
var i:integer;
begin
 for i:=1 to ix do f[i]:=hkap[i];
end;

procedure T_soil_profile.put_ct(ix:integer;var f:profil);
var i:integer;
begin
 for i:=1 to ix do f[i]:=ct[i];
end;

procedure T_soil_profile.put_pwp(ix:integer;var f:profil);
var i:integer;
begin
 for i:=1 to ix do f[i]:=pwp[i];
end;

procedure T_soil_profile.put_trd(ix:integer;var f:profil);
var i:integer;
begin
 for i:=1 to ix do f[i]:=trd[i];
end;


procedure T_soil_profile.put_tsd(ix:integer;var f:profil);
var i:integer;
begin
 for i:=1 to ix do f[i]:=tsd[i];
end;


procedure T_soil_profile.put_pvol(ix:integer;var f:profil);
var i:integer;
begin
 for i:=1 to ix do f[i]:=pvol[i];
end;

function T_soil_profile.free_drain: boolean;
begin
// test    hydromorph:=true;
  free_drain:= not hydromorph;
end;




procedure T_soil_profile.adapt(st:statrec);
var ks,u,h_fc,h_pwp:double;
    s   : real;
    i   : integer;
    amp : T_material_property;
begin
 bd:=0; pd:=0;
   h_fc   := power(10, 1.8);
  h_pwp  := power(10, 4.2);
{Anpassen der physikalischen Parameter an den OS-Gehalt und die Lagerungsdichte}
 for i:=1 to kdepth do
 {die Anpassung erfolgt nur im Krumenbereich}
 begin

  // Bei Frost nimmt das Volumen um 9% zu die Dichte um 1/1.09 ab => fkryo=0.917
   // if candy.bt.re_freezing[i] then fkryo:=1+0.09*st.bofeu[i]/100 else fkryo:=1;
     fkryo:=1;     //test
     fmana[i]:=1;  //test

    trd[i]:=trd[i]*fkryo*fmana[i];  // fmana[i] wird von der Bewirtschaftungsmassnahme gesetzt
  // anschließend managementeffect wieder zurücksetzen
    fmana[i]:=1;

    tsd[i]:=tsd_ruehlmann(dmin_rm[i],ton[i],candy.soil.corg);
    bd:=bd+trd[i];
    pd:=pd+tsd[i];
 end;
 bd:=bd/kdepth;
 pd:=pd/kdepth;
 u:=100-ton[1]-sand[1];
 mp_vereecken_(1, ks, bd, candy.soil.corg, ton[1], u, sand[1],  s ,amp);
 kwp:= h2the(amp,h_pwp);
 kfc:= h2the(amp,h_fc);
 kpv:= 100*(1-bd/pd);
 candy.dens_dyn.kfc_ap:=kfc;

end;



  // Übernahme aus der Arbeit von jens dreyhaupt
  //Bestimmung der Bodenphysik des 2. Horizontes mittels Prozedur rechnen_tief_1


 function calc_parm(ton,sand,por, X :real): real;
 var  y_b,q_r,q_e,lam,sand_c, hx, z:   Real;
 // Umkehrfunktion zur Parameterbestimmung der pF-Kurve
 begin
     sand_c:=sand;
     por:=por/100;
     y_b:=EXP(5.3396738+0.1845038*TON-2.48394546*por-0.00213853*TON*TON-0.04356349*sand_c*por-0.61745089*TON*por+0.00143598*sand_c*sand_c*por*por-0.00855375*TON*TON*por*por-0.00001282*sand_c*sand_c*TON+0.00895359*TON*TON*por-0.00072472*sand_c*sand_c*por+0.0000054*TON*TON*sand_c+0.5002806*por*por*TON);
     lam:=EXP(-0.7842831+0.0177544*sand_c-1.062498*por-0.00005304*sand_c*sand_c-0.00273493*TON*TON+1.11134946*por*por-0.03088295*sand_c*por+0.00026587*sand_c*sand_c*por*por-0.00610522*TON*TON*por*por-0.00000235*sand_c*sand_c*TON+0.00798746*TON*TON*por-0.00674491*por*por*TON);
     q_r:=-0.0182482+0.00087269*sand_c+0.00513488*TON+0.02939286*por-0.00015395*TON*TON-0.0010827*sand_c*por-0.00018233*TON*TON*por*por+0.00030703*TON*TON*por-0.0023584*por*por*TON;
     q_e:=0.01162-0.001473*sand_c-0.002236*TON+0.98402*por+0.0000987*TON*TON+0.003616*sand_c*por-0.010859*TON*por-0.000096*TON*TON*por-0.002437*por*por*sand_c+0.0115395*por*por*TON;

     z:=(0.01*x-q_r)/(q_e-q_r);
     hx:=y_b*exp(-ln(z)/lam);

     calc_parm:=hx;

 end;


 function calc_parm_vgv(ton,sand,_por_,_trd_,corg,X:real):real;

      var   ths,thr,alfa,n,m,a,hx,thx :real;

          procedure mp_vereecken(ks, trd, corg, t, s,por:double; var ths,thr,alfa,n,m,a:real );
      // converted particle size dist
          begin
              ths:=0.81-0.283*trd+0.001*T;
              thr :=0.015+0.005*T+0.014*corg;
               por:=por/100;
              thr:=-0.0182482+0.00087269*s+0.00513488*T+0.02939286*por-0.00015395*T*T-0.0010827*s*por-0.00018233*T*T*por*por+0.00030703*T*T*por-0.0023584*por*por*T;
              ths:=0.01162-0.001473*s-0.002236*T+0.98402*por+0.0000987*T*T+0.003616*s*por-0.010859*T*por-0.000096*T*T*por-0.002437*por*por*s+0.0115395*por*por*T;


              alfa:=roundto(exp(-2.486+0.025*s-0.351*corg-2.617*trd-0.023*t),-6); //cm->m
              n   :=roundto(exp(0.053-0.009*s-0.013*t+0.00015*s*s),-6);
              if n>1 then m   :=1-1/n else m:=1;    a   :=0.5;
          end;

         function  the2h(ths,thr,alfa,m,n, theta:double):double;
         var qth,h1,h2 :double;
         begin
            qth:=(ths-thr)/(theta-thr);
            h1:=ln( exp(ln(qth)/m)-1);
            h2:= exp(h1/n);
            the2h:=h2/alfa;
         end;

    begin
       mp_vereecken(-99, _trd_, corg, ton, sand,_por_, ths,thr,alfa,n,m,a );
       thx:=x/100;
       hx:=the2h( ths,thr,alfa,m,n,thx);
       calc_parm_vgv:=hx;
    end;





  procedure t_dens_dyn.calc_par_vgv(ton,sand,_por_,_trd_,corg,pwp_h,fkap_h:real;  var FKap_k, pwp_k, da_mic,da_mes : Real);
  var   ths,thr,alfa,n,m,a,hp,hf :real;

          procedure mp_vereecken(ks, trd, corg, t, s,por:double; var ths,thr,alfa,n,m,a:real );
           // converted particle size dist
          begin
              ths :=0.81-0.283*trd+0.001*T;
              thr :=0.015+0.005*T+0.014*corg;
              por :=por/100;
              thr :=-0.0182482+0.00087269*s+0.00513488*T+0.02939286*por-0.00015395*T*T-0.0010827*s*por-0.00018233*T*T*por*por+0.00030703*T*T*por-0.0023584*por*por*T;
              ths :=0.01162-0.001473*s-0.002236*T+0.98402*por+0.0000987*T*T+0.003616*s*por-0.010859*T*por-0.000096*T*T*por-0.002437*por*por*s+0.0115395*por*por*T;
              alfa:=roundto(exp(-2.486+0.025*s-0.351*corg-2.617*trd-0.023*t),-6); //cm->m
              n   :=roundto(exp(0.053-0.009*s-0.013*t+0.00015*s*s),-6);
              if n>1 then m   :=1-1/n else m:=1;    a   :=0.5;
          end;

         function h2the( ths,thr,alfa,n,m,a:real; h:double):double;
         begin
           h:=abs(h);
           h2the := thr+(ths-thr)/power((1+power(alfa*h,n)),m);
         end;

  begin
     //Materialeigenschaften

     mp_vereecken(-99, _trd_, corg, ton, sand,_por_ ,ths,thr,alfa,n,m,a );

     hp:=pwp_k; // alte pwp Zwischenspeichern
     pwp_k:=h2the(ths,thr,alfa,n,m,a,pwp_h)*100;    //van-Genuchten
     da_mic:=(hp-pwp_k);   // Änderung pwp
     if da_mic>0 then da_mic:=da_mic/hp else da_mic:=da_mic/(fkap_k-hp);

     hf:=fkap_k;  //alte FK merken
     fkap_k:=h2the(ths,thr,alfa,n,m,a,fkap_h)*100;  //van-Genuchten
     da_mes:=(hf-fkap_k);
     if da_mes>0 then da_mes:=da_mes/(hf- hp) else da_mes:= da_mes/(100*_por_-hf)


  end;


  procedure T_dens_dyn.calc_param( TON, sand, por,pwp_h,fkap_h  : real ; var FKap_k, pwp_k, da_mic,da_mes : Real);
    (*
    Bedeutung der Parameter:
    TON---> Ton, silt---> Schluff,
    *)

{  const p=0.7359;
//        Dops=0.488;
//        a=0.4981;
//        b=0.2471;
        c=0.3787;
        exponent1=-0.5389;
        exponent2=-0.0234;
 }
   // Indikatorgrößen für PWP und FKAP  ; oder vielleicht doch besser variable, die von aussen gepflegt werden können
   //   H_c_PWP =15000;
   //   H_c_FKAP=60;

  var  y_b,q_r,q_e,lam,sand_c,hp,hf:   Real;

  begin//prozedur

    //Fkap und PWP ausrechnen
    //Bestimmung von FKAP und PWP mit Brooks-Corey-Parametern;
    //Lit.: Rawls, W. J., Brakensiek, D.L.: Prediction of Soil Water Properties for Hydrologic Modeling
    // ist die Verwendung der Korngrößen hier sachlich richtig ????
     por:=por/100;
     sand_c:=sand;
     y_b:=EXP(5.3396738+0.1845038*TON-2.48394546*por-0.00213853*TON*TON-0.04356349*sand_c*por-0.61745089*TON*por+0.00143598*sand_c*sand_c*por*por-0.00855375*TON*TON*por*por-0.00001282*sand_c*sand_c*TON+0.00895359*TON*TON*por-0.00072472*sand_c*sand_c*por+0.0000054*TON*TON*sand_c+0.5002806*por*por*TON);
     lam:=EXP(-0.7842831+0.0177544*sand_c-1.062498*por-0.00005304*sand_c*sand_c-0.00273493*TON*TON+1.11134946*por*por-0.03088295*sand_c*por+0.00026587*sand_c*sand_c*por*por-0.00610522*TON*TON*por*por-0.00000235*sand_c*sand_c*TON+0.00798746*TON*TON*por-0.00674491*por*por*TON);
     q_r:=-0.0182482+0.00087269*sand_c+0.00513488*TON+0.02939286*por-0.00015395*TON*TON-0.0010827*sand_c*por-0.00018233*TON*TON*por*por+0.00030703*TON*TON*por-0.0023584*por*por*TON;
     q_e:=0.01162-0.001473*sand_c-0.002236*TON+0.98402*por+0.0000987*TON*TON+0.003616*sand_c*por-0.010859*TON*por-0.000096*TON*TON*por-0.002437*por*por*sand_c+0.0115395*por*por*TON;
     hp:=pwp_k; // alte pwp Zwischenspeichern
     pwp_k:=(q_r+(q_e-q_r)*exp(lam*ln(y_b/pwp_h)))*100;
     da_mic:=(hp-pwp_k);   // Änderung pwp
     if da_mic>0 then da_mic:=da_mic/hp else da_mic:=da_mic/(fkap_k-hp);

     hf:=fkap_k;  //alte FK merken
     fkap_k:=(q_r+(q_e-q_r)*exp(lam*ln(y_b/fkap_h)))*100;
     da_mes:=(hf-fkap_k);
     if da_mes>0 then da_mes:=da_mes/(hf- hp) else da_mes:= da_mes/(100*por-hf)

     // da_xxx : positiv: Porenraumklasse ist reduziert; C-Fluss into upper class
     //        : beschreibt den Anteil des zu migrierenden C-Pools
  end;(*procedure *)

 begin
end.
