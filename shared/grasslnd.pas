 {
 class definition of the candy grassland module as child
 of the transpiration driven crop model and introducing
 animals
 }

{$INCLUDE cdy_definitions.pas}
unit grasslnd;
interface
uses

{$IFDEF CDY_GUI}
cdy_glob,
{$ENDIF}
{$IFDEF CDY_SRV}
cdy_config,
{$ENDIF}


cndplant,trkplant,cnd_vars,scenario,cdywett,cnd_util,cndmulch,cdy_bil,classes,sysutils,math;

type
     p_grass=^grass;
     grass  =class(trkpflan)
               trsum,
               bastemp,          // Basistemperatur
               daylength,          //tageslänge
               tempsum,
               tk_max,
               tk_min,
               ts1,               // Temp-summe Start Altern
               ts2,               // Temp-summe Ende  Altern
               d_crep:real;
               grd_ix,             // grüne Biomasse
               halme_ix,           //EWR-Index der abgestorbenen oberirdischen BIomasse
               root_type:integer;  //EWR-Index der abgestorbenen Wurzeln
               autofert_nyield,    // N-Entzug für auto-fertilizer merken
               n_gruen,            // N in der oberirdischen Biomasse
               cnr_halme,
               cnr_gruen,
               cnr_root :real;
               annual_n,           // Abfuhr total
               schnitt_n,          // Abfuhr durch Schnittnutzung
               weide_n,            // Abfuhr durch Weidenutzung
               mulch_n,            // Umlagerung in Mulch-Schicht
               n_rep_sum:real;
               gv       :real  ;
               weide,
               schroepfschnitt,
               sleeping :boolean;
               livestock:Tstringlist;
               constructor create(var s:sysstat;mnd:pmmtent;kfak:real;cdy_path:string);
               destructor  done(var s:sysstat);virtual;
               procedure   daystep(var s:sysstat;mnd:pmmtent);virtual;
               procedure   ernte(var s:sysstat);virtual;
               procedure   schnitt(var s:sysstat; schroepf:boolean);virtual;
               procedure   start_weide(ix:integer;gv_anz:real;s:sysstat);
               procedure   stopp_weide(ix:integer;gv_anz:real;s:sysstat);
               procedure   vegend(var s:sysstat);
               procedure   kill_crop(var s:sysstat);virtual;
             end;
implementation
 uses cdyspsys ;

procedure grass.start_weide(ix:integer;gv_anz:real;s:sysstat);
var lname:string;
    anz:real;
    j:integer;
    ok:boolean;
begin
  gv:=gv_anz;
  livestockprm.select(ix,lname,ok);
  if not ok then exit;
   j:=0;
   ok:=false;
   repeat
     inc(j);
     if j<= livestock.count then ok:=livestock.names[j-1]=lname;
  until (j>=livestock.count) or ok;
  if ok then
  begin
    // Bestand Aufstocken
    anz:=strtofloat(livestock.values[lname])+gv_anz;
    livestock.values[lname]:=floattostr(anz);
  end
  else
  begin
   // neuen item addieren
    anz:=gv_anz;
    livestock.add(lname+'='+floattostr(anz));
  end;
  weide:=true;
  send_msg(datum(s.ks.tag,s.ks.jahr)+' '+real2string(gv,4,1)+' '+lname+' auf Weide; total='+real2string(anz,4,1),0);
end;

procedure grass.stopp_weide(ix:integer;gv_anz:real;s:sysstat);
var lname:string;
    anz:real;
    j:integer;
    ok:boolean;
begin
  anz:=0;
  gv:=gv_anz;
  livestockprm.select(ix,lname,ok);
  if not ok then exit;
   j:=0;
   ok:=false;
   repeat
     inc(j);
     if j<= livestock.count then ok:=livestock.names[j-1]=lname;
  until (j>=livestock.count) or ok;
  if ok then
  begin
    // Bestand vermindern
    anz:=max(0,strtofloat(livestock.values[lname])-gv_anz);
    if anz>0 then livestock.values[lname]:=floattostr(anz)
             else livestock.Delete(j-1);
  end;
  weide:= (livestock.count>0);
  send_msg(datum(s.ks.tag,s.ks.jahr)+' '+real2string(gv,4,1)+' '+lname+' von Weide; total='+real2string(anz,4,1),0);
end;
{
begin
  weide:=false;
  send_msg(datum(s.ks.tag,s.ks.jahr)+ ' Ende Weidehaltung',0);
end;
 }
procedure grass.schnitt(var s:sysstat; schroepf:boolean);
var ctot:real;
begin
 s.ks.bedgrd:=0.2;
 s.ks.bestho:=0;
 s.plantparm1:=0;
 s.plantparm2:=1;

 nnat:=n_gruen {s.ks.kumpflent};     // kumpflent ist der totale Entzug
 schroepfschnitt:=schroepf;                                     // n_gruen repräsentiert den aktuellen Aufwuchs
 if not schroepfschnitt then
 begin
 schnitt_n:=schnitt_n+nnat;          // ohne Berücksichtigung der als konstant angenommenen
                                     // Biomassebasis - dieser Aufwuchs wird durch
                                     // den Schnitt abgefahren
 annual_n:=annual_n+{s.ks.kumpflent}n_gruen;  // Schnittmenge für Jahresbilanz kumulieren
   ed.dm_hp:=n_gruen * cf_n2dm;

last_yld:=ed;
 last_yld.n_yld_hp:={s.ks.kumpflent} n_gruen;
 last_yld.valid:=true;
 str(nnat:5:1,nert);
 stag:=0; {am Ende Zähler zurücksetzen}
 add_message('cutting(harvest) at '+datum(s.ks.tag,s.ks.jahr)+': '+nert+'kg N/ha'+' TrnspS='+numstring(Trsum,0)+'mm');//+'  Npot='+numstring(s.ks.nvirt,1));
 end
 else
 begin
 // bei Schröpfschnitt den Ertrag als OD einbringen
 mulch_n:=mulch_n+n_gruen;
 str(n_gruen:5:1,nert);
 {
 //alt:
 ctot:=n_gruen*CNR_halme;
 mulch.add_om(ctot,halme_ix);
 }
// neu: 25.1.05 Fra
  ctot:=n_gruen*CNR_gruen;
 candy.mulch.add_om(ctot,grd_ix);

 add_message('cutting ( leave ) at '+datum(s.ks.tag,s.ks.jahr)+': '+nert+'kg N/ha'+' TrnspS='+numstring(Trsum,0)+'mm');

 end;
 s.ks.nvirt    :=0;
 s.ks.kumpflent:=0;
 n_gruen:=0;               // der neue Aufwuchs startet bei 0
 trsum:=0;
end;

constructor grass.create(var s:sysstat;mnd:pmmtent;kfak:real;cdy_path:string);
var a_name:string;
    ok:boolean;
begin
 inherited create( s,mnd,kfak);
 {spezielle Einstellungen: root=rootmax; bg=1 bh=30 !}
 { es wird unterstellt, daß immer eine Mindestmenge an Biomasse bestehen bleibt
   -nach Schnitten und nach dm Vegetationsende im Herbst. Diese Menge wird hier
    nicht einbezogen. Damit kann immer gegen 0 bilanziert werden}
 weide:=false;
 tempsum:=0;
 trsum:=0;
 bastemp:=4;  // fixe Annahme
 s.ks.legans:=false; // etablierten Bestand annehmen
 livestock:=tstringlist.create;
 s.ks.wutief:=wtmax;
 s.ks.matanf:=366;
 //s.ks.bestho:=30;
 s.ks.szep  :=0;
// s.ks.bedgrd:=1;
 s.z_wasser:=0;
 annual_n:=0;
 weide_n:=0;
 schnitt_n:=0;
 mulch_n:=0;
  iz_cap:= s.ks.bestho*czep*S.KS.BEDGRD ;
 n_rep_sum:=0;
 s.ks.kumpflent:=0;
 n_gruen       :=0;

 s.nupt        :=0;
 {
 sleeping:= not(s.wett.lt>=5);
 if sleeping then
 begin
  s.ks.forts:=1;
  s.ks.besruh:=true;
 end;
 }
 s.ks.besruh:=false;
// d_crep  :={1.05*}graslparm^.parm('CEWR')/365; {jetzt als N-Fluß mit Anpassung an Mittelwert !!}
d_crep  :=graslparm.parm('CEWR')/graslparm.parm('VEGDAU');
{Qualität der OPS aus den Wurzeln bestimmen !}
 a_name:='Gras';
 //Gruene Pflanze;
 graslparm.select(s.ks.pnr,a_name,ok);
 grd_ix:= round(graslparm.parm('GRD_IX'));
 opsparm.select(grd_ix,a_name,ok);
 cnr_gruen:=opsparm.parm('CNR');

 // EWR und Halme
 root_type:=round(graslparm.parm('EWR_IX'));
 opsparm.select(root_type,a_name,ok);
 cnr_root:=opsparm.parm('CNR');
  //vereinfachenden Annahme:
  cnr_halme:=cnr_root;
  halme_ix:=root_type;

 // Wachstumsparameter
 tk_max:=transko;
 tk_min:=graslparm.parm('TK_MIN');
 ts1:= graslparm.parm('TS1');
 ts2:= graslparm.parm('TS2');



 d_crep  := d_crep*cnr_root;       {umrechnen N->C}
 if aufgang then autofert_nyield:=    mnd.mmt.quan
            else
             begin
              autofert_nyield :=    s.ks.apool;
              transko         :=    s.ks.mtna;
              trsum           :=    s.ks.maxpflent;
              candy.mulch.add_om(s.ks.nobfl,halme_ix);
              s.ks.nobfl:=0;
               candy.scene.autofert.yield:=autofert_nyield;
             end;  



 end;


destructor grass.done(var s:sysstat);
begin
  inherited _old_done(s);
end;


procedure grass.vegend(var s:sysstat);
var ctot:single;
begin
  if {s.ks.kumpflent}n_gruen=0 then exit;
 // n_gruen:=0; - dies erfolgt eigentlich zu Vegetationsende durch Umlagerung in Mulch
 // für die Saldo-Rechnung wird die Umlagerung des Bestandes in den Mulch als ABFUHR bewertet
 annual_n:=annual_n+ n_gruen;                   //s.ks.kumpflent ;
 mulch_n:=mulch_n+n_gruen;
 ctot:=n_gruen*CNR_halme;
 candy.mulch.add_om(ctot,halme_ix);
 n_gruen:=0;
 s.ks.kumpflent:=0;
 s.ks.nvirt    :=0;

 send_msg(datum(s.ks.tag,s.ks.jahr)+' : Abfrieren bei '+floattostr(round(10*s.wett.lt)/10)+'°C' ,5);
end;


procedure grass.kill_crop(var s:sysstat);
var ctot,n_saldo:real;
  saldo:string;
begin
  (* ernte
  mulch.sum_n(m);
newr:=  0;
annual_n:=annual_n+n_gruen;
bilanz^.calc_n_saldo(annual_n-m+n_rep_sum,n_saldo);
bilanz^.reset;     {saldo auf null stellen}
nert:=real2string(n_gruen,6,1);
s.ks.pnr:=0;
s.ks.bedgrd:=0;
s.ks.bestho:=0;
s.ks.wutief:=0;
s.ks.kumpflent:=0;

s.graslparm1:=0;
s.graslparm2:=1;
ed.valid:=true;
last_yld:=ed;
n_uptake:=0;
n_gruen:=0;
saldo:=real2string(n_saldo,6,1);
send_msg(datum(s.ks.tag,s.ks.jahr)+' '+nert+' kg N/ha N-Entzug im Erntejahr '+name,0);
send_msg(datum(s.ks.tag,s.ks.jahr)+' '+saldo+' kg N/ha Saldo(Input-Uptake)',0);


  *)
 // n_gruen:=0; - dies erfolgt eigentlich zu Vegetationsende durch Umlagerung in Mulch
 // für die Saldo-Rechnung wird die Umlagerung des Bestandes in den Mulch als ABFUHR bewertet
 mulch_n:=mulch_n+n_gruen;
 ctot:=n_gruen*CNR_halme;
 candy.mulch.add_om(ctot,halme_ix);
 n_gruen:=0;
 candy.bilanz.calc_n_saldo(n_rep_sum,0,n_saldo); // richtig ??
 s.ks.kumpflent:=0;
 s.ks.nvirt    :=0;
 send_msg(datum(s.ks.tag,s.ks.jahr)+' : Crop eliminated',5);
 saldo:=real2string(n_saldo,6,1);
 send_msg(datum(s.ks.tag,s.ks.jahr)+' '+saldo+' kg N/ha Saldo(Input-Uptake)',0);

end;

procedure grass.daystep(var s:sysstat;mnd:pmmtent);
var a_dat:string;
    od_id,j,h:integer;
    ok:boolean;
    c_inp,n_upt,anz,m,a_d_crep,
    d_n_rep,n_saldo:real;
    lname:string;
begin
{am 15.9. clearing of OM-SBA-Pools}
if s.ks.tag=258 then begin   candy.scene.autofert.clear;
                             candy.scene.autofert.yield:=autofert_nyield;
                     end;
 {immer an Neujahr werden Summen zurückgesetzt !}
 if s.ks.tag=1 then
 begin
 // autofert.init;   {am 1.1. sba-init}
 // annual_n wird bei saldo-rechnung rückgesetzt
 s.ks.nvirt    :={s.ks.kumpflent} n_gruen;     // Übertrag mitnehmen
 n_rep_sum     :=0;
 mulch_n       :=0;
 weide_n       :=0;
 schnitt_n     :=0;
 tempsum       :=0;
 end;  //tag=1





 if weide then
  begin
 (******************** Weidehaltung ********************)
   // Exkrementeanfall als OD
   for j:=1 to livestock.count do
     begin
    // livestockprm.select(ix,lname,ok);
      h:=0; // suche Name
      lname:=livestock.names[j-1];
      livestockprm.select(h,lname,ok);
      anz:=strtofloat(livestock.values[lname]);
      if anz<0.01 then anz:=0;
      od_id :=round(livestockprm.parm('OD_ID'));
      c_inp :=livestockprm.parm('C_INP');
      n_upt :=livestockprm.parm('N_UPT');

      candy.scene.org_dng(99,od_id,-1,c_inp*anz,s,'0');      // 7.2 Kg C/ha pro GV

     // Aufnahme durch Tiere - entspricht der Schnittnutzung
     // 0.18kg N /ha wird pro Kuh gefressen

     n_gruen :=n_gruen-n_upt*anz;
     if n_gruen<0 then
     begin
      send_msg(datum(s.ks.tag,s.ks.jahr)+' additional nutrition : '+real2string(-n_gruen,3,1)+' kg N/ha',1);
      n_gruen:=0;
     end;
    // Bilanzen
     annual_n:=annual_n+n_upt*anz;
     weide_n :=weide_N+n_upt*anz;
     end;
   end;
 (*********************** Wiese ************************)
 daily_n_dem:=0;
 if s.wett.lt>4 then
 begin

  tempsum:=tempsum+s.wett.lt-4;
  if tempsum<=ts1 then transko:=tk_max
                  else if tempsum<ts2 then transko:=tk_min+(tk_max-tk_min)*(ts2-tempsum)/(ts2-ts1)
                                      else
                                      begin
                                       transko:=tk_min;
                                      end;
end;


begin
  inherited transpiration(s,1);   // Vorgriff auf daystep !!
  inherited calc_n_dem(s);
  trsum:=trsum+s.wett.trans;
  {jetzt spezielle Annahmen für Dauergruenland}
  d_n_rep:=d_crep/cnr_root;
  daily_n_dem:=daily_n_dem+d_n_rep; {Wurzelbedarf addieren}

  //* maximum definieren*/
  daily_n_dem:=min(daily_n_dem,4);

  // Leguminosenbindung berücksichtigen:

  N_luft:=daily_n_dem*(1-nbok);
  n_luft:=max(n_luft,0);
  daily_n_dem:=daily_n_dem-n_luft;
  inherited _daystep(s,mnd);          // N-Aufnahme in Pflanzenpool  = s.nupt
  s.symb_n:=n_luft;
  if s.wett.lt<(0) then vegend(s);  //Abfrieren
 (******* Korrektur bei N-Mangel ********)
   if daily_n_dem>0 then
   begin
    d_n_rep:=d_n_rep*(s.nupt/(n_luft+daily_n_dem)); // Bei N_mangel: Reduktion des rep-Anteils
    a_d_crep:=d_n_rep*cnr_root;
    // Netto-Zuwachs der oberirdischen Biomasse= s.nupt-d_n_rep
    n_gruen:=n_gruen+s.nupt-d_n_rep;
    candy.scene.org_dng(99,root_type,0,a_d_crep,s,'0');
    n_rep_sum:=n_rep_sum+d_n_rep;
   end;
 end;

 a_dat:=datum(s.ks.tag,s.ks.jahr);

 if copy(a_dat,1,5)='31.12' then
 begin
  {Jahr abschließen}
  // derInput über EWR muß gleichzeitig als Entzug bewertet werden, da es keine externe Quelle darstellt
  candy.mulch.sum_n(m);
  candy.bilanz.calc_n_saldo(annual_n-m+n_rep_sum,0,n_saldo);
  send_msg(a_dat+': annual N-offt. S/W/M (kg N/ha)='+real2string(schnitt_n,5,1)+'/'+real2string(weide_n,5,1)+'/' +real2string(mulch_n,5,1),0);
  send_msg(datum(s.ks.tag,s.ks.jahr)+' '+real2string(n_saldo,6,1)+' kg N/ha Saldo(Input-Uptake)',0);
  candy.bilanz.reset;     {saldo auf null stellen}
  annual_n:=m;
  n_rep_sum:=0;
 end;



end;


procedure grass.ernte(var s:sysstat);

var m,
    n_saldo,
    newr:real;
    saldo:string;
begin
candy.mulch.sum_n(m);
newr:=  0;
annual_n:=annual_n+n_gruen;
candy.bilanz.calc_n_saldo(annual_n-m+n_rep_sum,0,n_saldo);
candy.bilanz.reset;     {saldo auf null stellen}
nert:=real2string(n_gruen,6,1);
s.ks.pnr:=0;
s.ks.bedgrd:=0;
s.ks.bestho:=0;
s.ks.wutief:=0;
s.ks.kumpflent:=0;

ed.dm_hp:=n_gruen * cf_n2dm;
s.plantparm1:=0;
s.plantparm2:=1;
ed.valid:=true;
last_yld:=ed;

n_uptake:=0;
n_gruen:=0;
saldo:=real2string(n_saldo,6,1);

send_msg(datum(s.ks.tag,s.ks.jahr)+' '+nert+' kg N/ha N-Entzug im Erntejahr '+name,0);
send_msg(datum(s.ks.tag,s.ks.jahr)+' '+saldo+' kg N/ha Saldo(Input-Uptake)',0);

end;


begin
end.

