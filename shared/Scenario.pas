{
 routines to apply management actions during the model simulation
}
{$INCLUDE cdy_definitions.pas}
unit scenario;
interface
uses

{$IFDEF CDY_GUI}
cdy_glob,
{$ENDIF}
{$IFDEF CDY_SRV}
cdy_config,
{$ENDIF}

cnd_vars, cnd_util , slurry,  ok_dlg1,  soilprf3,
FireDAC.Comp.Client, classes, sysutils, math,dateutils;


type
    tdatum     = string[10];
    tspez      = string[8];
    TmmtRec    = record
                  datum:string;
                  code :byte;
                  quan :single;
                  qual :word;
                  spez :tspez;
                  ready:boolean;
               end;

    Pmmtent  =^Tmmtent;
    Tmmtent  = record
                  mmt : TmmtRec;
                  next: Pmmtent;
               end;

    Pmmtcmt  =^Tmmtcmt;
    Tmmtcmt  = record
                 code :integer;      {Maßnahme-Code}
                 name : string[15];  {Bezeichnung der Maßnahme}
                 dimn : string[15];  {Dimension des Quantitätsparameters}
                 sfile: string[8];   {Datei mit Qualitätsabstufungen}
               end;

    pmanure_rec=^tmanure_rec;
    tmanure_rec=record
                   manure_id:integer;
                   N_amout  :real;
                   app_date : tdatum;
                   next     :pmanure_rec;
                 end;

    Pauto_fert=^Tauto_fert;
    Tauto_fert=class(Tobject)
               crop,
               pre_crop: integer;
               e,
               akt_dng,
               n2_gabe,
               n3_gabe,
               rest_dng:real;
               yield   : real;
               zwischenfrucht,
               er_removed:boolean;
               manure :pmanure_rec;
               g_1a,g_1b,g_2,g_3:boolean;
               stone3,stone6,stone9,                //Steingehalt 0-30,30-60, 60-90
               nmin30,nmin60,nmin90:real;           //Nmin  0-30,30-60, 60-90
               nodref, nminref:real;
               sbaplant, sbaod:tfdquery;
               constructor create;
               procedure   clear;
               function    apply_fertilizer(t:sysstat):real;
               procedure   gabe_1a(t:sysstat);
               procedure   gabe_1b;
               procedure   gabe_2;
               procedure   gabe_3;
               procedure   add_manure(a_dat:tdatum;n_org:real;id:integer);
               procedure   adapt2newstat(t:sysstat);
             end;
    Pmndobj=^Tmndobj;
    Tmndobj   =class(Tobject) {(timeseq)}
                snum    :string;
                snr     :integer;
                utlg    :integer;
                mnd,
                actual,
                last : pmmtent;
                cmt  : pmmtcmt;
                nupt : single;
                fname,
                mname : string;  // pfad und name der MAStabelle
                constructor create(dbpath,daba:string);
                function    seed(d:tdatum):integer;
                function    harvest(d:tdatum;var kpabf:boolean):integer;
                function    abtrieb(d:tdatum;var menge:real):integer;
                function    auftrieb(d:tdatum;var menge:real):integer;
                function    pre_harvest(d:tdatum; var ss:boolean):integer;
                function    tillage(d:tdatum;var menge:real):integer;
                function    umbruch(d:tdatum; var tiefe:real):integer;
                function    irrigtn(d:tdatum;var menge:real):integer;
                function    pestizid(d:tdatum;var menge:real):integer;
                function    min_dng(d:tdatum;var menge:real):integer;
                function    start_forest(d:tdatum; var model_id:integer):integer;
                function    overdrive(d:tdatum; var idruck, anteil :real):integer;
                function    next_bb:integer;
                function    org_dng(d:tdatum;var menge:real; var spec:string):integer;
                function    today(d:tdatum):boolean;{true: Maßnahme fällig}
                procedure   act_mmt(var m:tmmtrec);{Übergabe der aktuellen Maßnahme}
                procedure   skip(neu:boolean);                  {Maßnahme übergehen}
                procedure   output(Var m:pmmtent); {komplette Liste übergeben}
                procedure   load(start,stop:tdatum;schlag:string);
                procedure   adjust(start:tdatum);
                procedure   reset(start:tdatum);
                procedure   adapt(ajahr:integer);
                procedure   calc_crep(var c_rep:real);
                procedure   list;
                destructor  done;
              end;

    Pscenario=^Tscenario;
    Tscenario=class(Tobject)

                anfg     : dt;
                ende     : dt;
                cums     : real;
                soil     : string;
                wett     : string;
                dtbk     : string;
                s_nr     : string;
                plotid   : string;
                standard : boolean;
                mnmt     : Tmndobj;
                actions  : tstrings;
              //  actiontab: tadotable;
                autofert : Tauto_fert;
                slp      : Tguelledt;
                constructor create;
                function  make_snr(sbez:string):integer;
                function  make_pnr(sbez:string):integer;
                function  qtime2dbdt(qt:integer):string;
                procedure soil_mix(bis_schicht:integer;var t:sysstat);
                procedure org_dng(msg_level,art,db:integer;menge:real;var x:sysstat; spec:string);
                procedure mindng(art:integer; menge:real ;var x:sysstat; df:real);
   
              end;






 var   till_sm,till_sc:real;

implementation

uses bestand, cdyspsys ,cdyparm;
{ not in dll
,prmdlg

}

constructor Tscenario.create;
var atb:tfdquery; id:integer;
begin

 anfg := '19800101';
 ende := '19801231';
 cums := 25000;
 soil := 'LOE';
 s_nr := '___10';
 dtbk := 'MFELD';
 autofert:=Tauto_fert.create;
 actions:=tstringlist.Create;
 plotid:='';
 standard:=true;

 atb:=tfdquery.create(nil);
 atb.sql.add('select * from CDYAKTION order by action_id');
// atb.DatabaseName:= allg_parm.databasename;
 if cdyaparm<>nil then
  begin
   atb.connection:=dbc;//allg_parm.Connection;
   atb.open;
   atb.First;
  // scene.actions.Add( 'Actions');
   repeat
     id:= atb.fieldbyname('ACTION_ID').asinteger;
     while   {candy.scene.}actions.Count < id do {candy.scene.}actions.add('dummy');
     {candy.scene.}actions.Insert( atb.fieldbyname('action_id').asinteger, atb.fieldbyname('action').asstring);
     atb.next;
   until atb.Eof;
   atb.close;
  end;
 atb.free;
end;

procedure Tauto_fert.adapt2newstat(t:sysstat);
var o,i,od_id:integer;
    menge,cnr:double;
    ok:boolean;
    name:string;

begin
  crop:=t.ks.pnr;
  for o:=1 to 6 do
  begin
     od_id:=t.ks.ops[o].nr;
     if od_id<>0 then
     begin
     opsparm.select(od_id,name,ok);
     cnr:=opsparm.parm('CNR');
     if boolean(opsparm.get_pval(od_id,'OD')) then
//     if boolean(x) then
     begin
      menge:=0;
      for i:=1 to 3 do menge:=menge+t.ks.ops[o].c[i];
     end;
     add_manure(datum(t.ks.tag,t.ks.jahr), menge/cnr, t.ks.ops[o].nr)
     end;
 end;
end;

constructor Tauto_fert.create;
begin
 manure:=nil;

 if candy=NIL then
 begin  crop:=0;
        yield:=0;
 end ;

 pre_crop:=0;
 g_1a:=false; g_1b:=false; g_2:=false;g_3:=false;
 er_removed:=true;
end;

procedure   Tauto_fert.add_manure(a_dat:tdatum;n_org:real;id:integer);
var h:pmanure_rec;
begin
if id=35 then exit; {zum testen}
if manure=nil then
begin
  new(manure);
  manure.next:=nil;
  manure.app_date:=a_dat;
  manure.N_amout:=n_org;
  manure.manure_id:=id;
end
else
begin
 h:=manure;
 while h.next<>nil do h:=h.next;
 new(h.next);
 h:=h.next;
 h.next:=nil;
 h.app_date:=a_dat;
 h.N_amout:=n_org;
 h.manure_id:=id;
end;
end;


procedure Tauto_fert.clear;
var h:pmanure_rec;
begin

h:=manure;
while h<>nil do
 begin
  h:=manure.next;
  dispose(manure);
  manure:=h;
 end;
 // yield:=0; nur wenn kein crop !!
if candy.cndpfl=NIL then begin  crop:=0;  yield:=0; end;
 g_1a:=false; g_1b:=false; g_2:=false;g_3:=false;
 candy.scene.autofert.zwischenfrucht:=false;
end;

function Tauto_fert.apply_fertilizer(t:sysstat):real;

begin
if not g_1a then gabe_1a(t)
            else if not g_1b then gabe_1b
                             else if not g_2  then gabe_2
                                              else if not g_3  then gabe_3;
apply_fertilizer:=akt_dng;
end;

procedure Tauto_fert.gabe_1a(t:sysstat);
  var wpt:pMmtEnt;
      hm :pmanure_rec;
      i,j,d,t1,t2,yr:integer;
      od_gegeben: boolean;
      n_pfl_top,
      f1,f2,e1,e2,e3,e4,e5, N_soll:single;

        function mdae_stone(x:single):single;
        var f:single;
        begin
          f:=0.6;
          if x<=30 then f:=0.8;
          if x<=10 then f:=1;
          mdae_stone:=f;
        end;

begin
 // welche Fruchtart ?
 if crop=0 then
 begin
  // Düngung erfolgt vor Aussaat
    wpt:=candy.scene.mnmt.actual;
    while (wpt^.mmt.code<>1)
    and (wpt^.next<>NIL) do
    begin
     wpt:=wpt^.next;
    end;
    if    (wpt^.next<>NIL) and (wpt^.mmt.code=1)
    then     begin  // Aussaat gefunden
                     crop :=wpt^.mmt.qual;
                     yield:=wpt^.mmt.quan;
             end
             else _halt(121);
 end;

  // Zugriff auf Pflanzenparameter
  sbaplant:=tfdquery.create(nil);
//  sbaplant.databasename:='cdyparm';
  sbaplant.connection:=dbc;  //allg_parm.Connection;
  sbaplant.sql.Add('select sba.*,cdy.N_GEHALT from sbacrop sba, CDYPFLAN cdy where cdy.SBA_ID=sba.sba_crop_id ');
  sbaplant.sql.add(' and cdy.ITEM_IX='+inttostr(crop));
  sbaplant.open;
  sbaplant.first;
  // Ertragsziel umrechnen
  if candy.cndpfl<>candy.dgruenl then
  begin
   yield:=yield/sbaplant.fieldbyname('N_GEHALT').AsFloat;
  end;
  // Ertragsbereich einordnen
 e1:=0;
 n2_gabe:=sbaplant.fieldbyname('N2').asfloat;
 n3_gabe:=sbaplant.fieldbyname('N3_m' ).asfloat; // mittlerer Ertrag
 if yield< sbaplant.fieldbyname('yield_low' ).asfloat then
 begin
  e1:=-sbaplant.fieldbyname('N_decrease').asfloat;
  n3_gabe:=sbaplant.fieldbyname('N3_l' ).asfloat;
 end;
 if yield> sbaplant.fieldbyname('yield_high').asfloat then
 begin
  e1:=+sbaplant.fieldbyname('N_increase').asfloat;
  n3_gabe:=sbaplant.fieldbyname('N3_h' ).asfloat;
 end;
 n_soll:=sbaplant.fieldbyname('nominal_N').asfloat;
 // Nmin bestimmen
  j:=min(candy.sprfl.btief,3);
  stone3:=0;
  stone6:=0;
  stone9:=0;
  for i:=1 to j do stone3:=stone3 + candy.sprfl.stone_cont[i];
  stone3:=stone3/j;
  if j=3 then
  begin
      j:=min(candy.sprfl.btief,6);
      if j>3 then
      begin
      for i:=4 to j do stone6:=stone6 + candy.sprfl.stone_cont[i];
      stone6:=stone6/(j-3);
      if j=6 then
      begin
          j:=min(candy.sprfl.btief,9);
          if j>6 then
          begin
           for i:=7 to j do stone9:=stone9 + candy.sprfl.stone_cont[i];
           stone9:=stone9/(j-6);
          end;
      end;
      end;
  end;

  nmin30:= n_min_soil(t,3);
  nmin60:=n_min_soil(t,6)-nmin30;
  nmin90:=n_min_soil(t,9)-nmin30-nmin60;

 // MDAE für Nmin
  nminref:= nmin30*mdae_stone(stone3)*candy.sprfl.mdae03/100;
 n_pfl_top:=nminref;
  if sbaplant.fieldbyname('sample_depth').asfloat>30 then nminref:=nminref+nmin60*mdae_stone(stone6)*candy.sprfl.mdae36/100;
  if sbaplant.fieldbyname('sample_depth').asfloat>60 then nminref:=nminref+nmin90*mdae_stone(stone9)*candy.sprfl.mdae69/100;

 // organische Dünger
   sbaod:=tfdquery.create(nil);
 //  sbaod.DatabaseName:='cdyparm';
   sbaod.Connection:=dbc;// allg_parm.Connection;
  //alt:   sbaod.SQL.Add('select sba.* from sbamanure sba, CDYPFLAN cdy where sba.sba_crop_id=cdy.SBA_ID and cdy.ITEM_IX='+inttostr(crop));
    //Zusatz Select  ops.ITEM_IX
   // Zusatz from:  CDYOPSPA ops
   // Zusatz where:   and  ops.sba_id=sba.sba_om_id

   // neu:
 sbaod.SQL.Add('select sba.*,ops.ITEM_IX from sbamanure sba, CDYPFLAN cdy, CDYOPSPA ops ');
 sbaod.sql.add(' where sba.sba_crop_id=cdy.SBA_ID  and  ops.sba_id=sba.sba_om_id and cdy.ITEM_IX='+inttostr(crop));



   sbaod.Open;

   sbaod.First;
   // Liste Abarbeiten
    e2:=0;
    od_gegeben:=false;    //Standardannahme
    hm:=manure;
    if hm<>NIL then
    while hm<>NIL do
    begin
    sbaod.Filtered:=false;
    // old:    sbaod.Filter:='cdy_om_id='+inttostr(hm.manure_id);
    // neu:
    sbaod.Filter:='ITEM_IX='+inttostr(hm.manure_id);
    sbaod.filtered:=true;
    sbaod.First;
    if sbaod.RecordCount>0 then
    begin
     t1:=sbaod.fieldbyname('T1').asinteger;
     t2:=sbaod.fieldbyname('T2').asinteger;
     f1:=sbaod.fieldbyname('mdae_T1').asfloat/100;
     f2:=sbaod.fieldbyname('mdae_T2').asfloat/100;
     d:= daynr(hm.app_date);
     yr:=longjahrzahl(hm.app_date);
     od_gegeben:= od_gegeben or (  (yr=t.ks.jahr) and ((t.ks.tag-d)<=10)  );  // war od-gabe in den letzten 10 Tagen ??
     if d<150 then d:=d+365;
     if d>t1 then
          if d<t2 then e2:=e2+hm.N_amout*( f1+ (f2-f1)* (d-t1)/(t2-t1))
                  else e2:=e2+hm.N_amout*f2;
     end;
     hm:=hm.next;
    end;
 // Vorfruchteffekte
   sbaod.Filtered:=false;
   sbaod.Filter:='';
   sbaod.Close;
   sbaod.SQL.clear;
   sbaod.sql.add('select * from sbacrop sba, CDYPFLAN cdy where sba.sba_crop_id=cdy.SBA_ID and cdy.ITEM_IX='+inttostr(pre_crop));
   sbaod.Open;
   sbaod.First;
   e3:=0;
   if sbaod.recordcount=1 then
   begin
     if er_removed then e3:= sbaod.fieldbyname('N_p_crop_bp_rem').AsFloat
                   else e3:= sbaod.fieldbyname('N_p_crop_bp_left').asfloat;
   end;
 // Schwerer Boden ?
   e4:=0;
   if candy.sprfl.fat[1]>50 then e4:=20;

 // Zwischenfrucht
  e5:=0;
  if zwischenfrucht then e5:=8;

  e:=e1-e2-e3+e4-e5;
  e:=sign(e)*min(abs(e),40);
  n_soll:=n_soll+e;
  akt_dng:=n_soll-nminref;
  akt_dng:=max(0,akt_dng);
  if ((akt_dng+n_pfl_top)< sbaplant.fieldbyname('min_N_top').asfloat) then akt_dng:=sbaplant.fieldbyname('min_N_top').asfloat-n_pfl_top;
 // düngung ausführen

  add_message('autofert 1a');
 // bei org. Düngung unmittelbar vorher wird der Bedarf auf 1b verschoben
 rest_dng:=0;
 if od_gegeben then
 begin
  rest_dng:=akt_dng;
  akt_dng :=0;
 end
 else
 if akt_dng>sbaplant.fieldbyname('max_N1').asfloat then
 begin
  rest_dng:=akt_dng-sbaplant.fieldbyname('max_N1').asfloat;
  akt_dng :=sbaplant.fieldbyname('max_N1').asfloat;
 end;

 //else rest_dng:=0;
 g_1a:=true;
 sbaplant.free;sbaod.Free; 
end;

procedure Tauto_fert.gabe_1b;
begin
  akt_dng:=rest_dng;
  rest_dng:=0;
  g_1b:=true;
   add_message('autofert 1b');
end;

procedure Tauto_fert.gabe_2;
begin
  akt_dng:=n2_gabe;
  g_2:=true;
   add_message('autofert 2');
end;

procedure Tauto_fert.gabe_3;
begin
   akt_dng:=n3_gabe;
   g_3:=true;
    add_message('autofert 3');
end;

     procedure Tscenario.soil_mix(bis_schicht:integer;var t:sysstat);
     var i,j:integer;
         sw,snin,samn,saos,ssos :real;

         sops :array[1..6] of real;

     begin

 //K   if cips.active then cips.tillage(bis_schicht, till_sm, till_sc);
      sw:=0;
     snin:=0;
     samn:=0;
     saos:=0;
     ssos:=0;
     for i:=1 to 6 do sops[i]:=0;
     for i:=1 to bis_schicht do
       begin
        snin:=snin+t.ks.nin[i];
        samn:=samn+t.ks.amn[i];
        saos:=saos+t.ks.aos[i];
        ssos:=ssos+t.ks.sos[i];
        sw:=sw+t.ks.bofeu[i];
        for j:=1 to t.opsfra do sops[j]:=sops[j]+t.ks.ops[j].c[i];
       end;
     for i:=1 to bis_schicht do
        begin
         t.ks.bofeu[i]:=sw/bis_schicht;
         t.ks.nin[i]:=snin/bis_schicht;
         t.ks.amn[i]:=samn/bis_schicht;
         t.ks.aos[i]:=saos/bis_schicht;
         t.ks.sos[i]:=ssos/bis_schicht;
         for j:=1 to t.opsfra do t.ks.ops[j].c[i]:=sops[j]/bis_schicht;
        end;
     end;
    (*
    *******************************
    *)

     procedure Tscenario.org_dng(msg_level,art,db:integer;menge:real;var x:sysstat; spec:string);
     var i,ttt, mmm  :integer;
         stnr: char;
         dn:longint;
         cnr,           {im organischen Teil}
         mor,           {min N / org N}
         ts,            {TS%}
         cg,            {C% in TS}

         od_amn,
         ef_amn,
         ops_c_amount,

         help,
         od_nt    :real;
         name,n_od:string;
         slp_adapted,
         ok:boolean;
     begin
      ops_c_amount:=menge;
         slp_adapted:=false;
      if ops_c_amount<0 then
      begin
       {es wird unterstellt, daß die Nebenprod.Menge der letzten Ernte appliziert wird}
       cp:=crop_result;
       while cp^.pname<>'C-Pool(NP)' do cp:=cp^.next;
       ops_c_amount:=cp^.p_val;
       if ops_c_amount<0 then ops_c_amount:=0;
      end;

       opsparm.select(art,name,ok);
       cnr:=opsparm.parm('CNR');
       ts :=opsparm.parm('TS_GEHALT')*100;
       cg :=opsparm.parm('C_GEH_TS')*100;
       mor:=opsparm.parm('MOR');
       {wenn'Guelle(spz)' dann Guellemodul aktivieren}

       dn:=pos('#',name);
       if dn<>0 then
       begin
       if slp<>NIL then
         begin
          {Stallindex ermitteln: Zeichen hinter #}
          stnr:=name[dn+1];
          {menge der originalsubstanz ermitteln}
          menge:=10000*menge/(ts*cg);
          ttt:=tagdat(x.ks.tag,x.ks.jahr);
          mmm:=monat(x.ks.tag,x.ks.jahr);
          dn:=jul_day(ttt,mmm,x.ks.jahr);
          // alternativ
          dn:=trunc(strtodate(datum(x.ks.tag,x.ks.jahr)))+36523;
          {
           wenn diese Technik für alle org. Dünger angewandt werden soll
           muß der Bezug nicht der Stallindex, sondern die OPS_ID sein
                  slp^.adapt(dn,art,ts,cg,cnr,mor);
          }

          slp.adapt(dn,stnr,'0',ts,cg,cnr,mor);   {Untersuchungsergebnisse auswerten}
             slp_adapted:=true;
          ops_c_amount:=menge*ts*cg/10000;
         end  //slp<>NIL
        else
         begin
          ops_c_amount:=0;
          menge:=0;
          add_message('application is ignored');
         end;
       end; // if dn<>0
      {ende Guelle-Modul}

      // specialbehandlung OD (ersetzt Guelle-Modul)

      if spec<>'0' then
      begin
          {menge der originalsubstanz ermitteln}
          menge:=10000*menge/(ts*cg);
          ttt:=tagdat(x.ks.tag,x.ks.jahr);
          mmm:=monat(x.ks.tag,x.ks.jahr);
          dn:=jul_day(ttt,mmm,x.ks.jahr);
          slp.adapt(dn,inttostr(art),spec,ts,cg,cnr,mor);
          slp_adapted:=true;
          ops_c_amount:=menge*ts*cg/10000;
      end;

      // ende spec OD

      menge:=ops_c_amount;
      {CIPS-Kopplung }
     // test:  add_message(' ops_cdy: '+' D='+essdatum(x.ks.tag,x.ks.jahr)+'   X='+floattostr(menge)+'  ID='+inttostr(art)+' is_od= ja');

//K      if cips.active then cips.add_ops(menge,art);



      i:=1;
      { Suchen ob schon die gleiche OPS-Art existiert }
      while (i<x.opsfra) and (x.ks.ops[i].nr<>art) do inc(i);
      {
      if slp<>nil then slp_adapted:=slp.adapted
                  else slp_adapted:=false;
      }
      if (x.ks.ops[i].nr=art) and not slp_adapted
      then
       begin                    { es existiert schon die gleiche Fraktion }
        x.ks.ops[i].c[1]:=x.ks.ops[i].c[1]+menge;
       end
      else
       begin
       if x.opsfra<maxfraz then inc(x.opsfra)
                           else { Fraktionszahl reduzieren }
                            begin
                             help:=os_n(x);
                             kill_ops_fra(x);
                             help:=os_n(x);
                             inc(x.opsfra);
                             if x.opsfra>maxfraz then
                               begin
                                add_message('zu viele OPS-Fraktionen ! - Abbruch');
                                _halt(7);
                               end;
                             x.new_ops:=true;  {das Objekt "Boden" soll die OPS neu einordnen}
                            end;
       i:=x.opsfra;
       x.ks.ops[i].c[1]:=menge;
       x.ks.ops[i].nr  :=art;
       x.new_ops:=true;
       end;

       {eine organische Düngung besteht neben der OS-Gabe aus Wasserzufuhr}
       x.z_wasser:=x.z_wasser      +menge*(100-ts)/(100*ts*cg);
       x.ks.bofeu[1]:=x.ks.bofeu[1]+menge*(100-ts)/(100*ts*cg);
       { ... und Mineraldüngung}
       od_amn:=mor*menge/cnr;
       x.mDNG_n:=x.mDNG_n+od_amn;    { Mineraldüngeranteil  }
       x.oDng_n:=x.oDng_n+menge/cnr; {organischer Stickstoff}
       autofert.add_manure( datum(x.ks.tag,x.ks.jahr), menge/cnr,art);
       x.ngfv:=0;
       if (db>2) or (db<0) then
       begin
         ef_amn:=od_amn*0.80;
         x.ngfv:=x.ngfv+(od_amn-ef_amn);
       end
       else ef_amn:=od_amn;
       x.ks.amn[1]:=x.ks.amn[1]+ef_amn;
       od_nt:=od_amn+menge/cnr;               //gesamte N-Menge
       str(od_nt:5:1,n_od);
       send_msg(datum(x.ks.tag,x.ks.jahr)+' '+n_od+' kg N/ha'+' OM:'+name+numstring(menge,5)+' kg C/ha',msg_level);
       if x.ngfv<>0 then
       begin
        send_msg('    NH4-loss: '+real2string(x.ngfv,5,1)+' kg N/ha',msg_level);
         x.nh4verl:=x.nh4verl+x.ngfv;       {NH4-Verluste des aktuellen Simulationstages}
      end;
     end;








     procedure Tscenario.mindng(art : integer; menge:real ;var x:sysstat; df:real);
     var sollwt,dnin,damn:real;
         amn_proz :real;
         n_md : string;
         ok:boolean;
         i:integer;
         name:string;
     begin
       fert_parm.select(art,name,ok);
       amn_proz:=fert_parm.parm('AMMANTEIL');
 //KI      fert_parm.is_field('NINHITI',ok);
 //KI      if ok then candy.soil.inh_time:=fert_parm.parm('NINHITI')
  //KI     else  candy.soil.inh_time:=999;

       // reset time
     //KI  for i:=1 to 3 do  candy.soil.ninh_bat[i]:=0;

      {'normale' Dng oder Dng nach Sollwert ?}
      if menge<0 then
      begin
       if menge=-999 then menge:=autofert.apply_fertilizer(x)
       else
       begin
       {eine negative N-Menge wird als N-Sollwert behandelt}
       sollwt:=-menge;

       {die Düngung ergibt sich aus dem aktuellen Nmin-Vorrat in 0-9 dm}
       menge:=sollwt;
       for i:=1 to 9 do menge:=menge-x.ks.nin[i]-x.ks.amn[i];

       {jedoch muß menge>0 sein}
       if menge<0 then menge:=0;
       end;
      end;
      // Reduktionsfaktor anwenden

      menge:=menge*df;

      x.mDng_n:=x.mDng_n+menge;
      dnin:=menge*(100-amn_proz)/100;
      damn:=menge-dnin;
      x.ks.nin[1]:=x.ks.nin[1]+dnin;
      x.ks.amn[1]:=x.ks.amn[1]+damn;
      str(menge:5:1,n_md);

      send_msg(datum(x.ks.tag,x.ks.jahr)+' '+n_md+' kg N/ha min.Fert.',0);

     end;





{
function dbfdaynr(datum:dt):integer;
TYPE
  feld = ARRAY[1..12] OF INTEGER;
CONST
  mol: feld = (31,28,31,30,31,30,31,31,30,31,30,31);
VAR
  monend     : feld;
  d,j,h,m  : integer;
  mo       : real;
  schaltjahr : boolean;
begin
val(copy(datum,7,2),d,h);
val(copy(datum,5,2),mo,h);
m:=round(mo);
val(copy(datum,1,4),j,h);
schaltjahr:= (j mod 4)=0;
if schaltjahr then mol[2]:=29 else mol[2]:=28;
h:=0;
for j:=1 to m-1 do h:=h+mol[j];
dbfdaynr:=h+d;
end;

}

(*********
FUNCTION db_datum(t,J: INTEGER):dt;
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
   db_datum:=h1+'1231';
   exit;
  end;
  schaltjahr:=(j mod 4 = 0);
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
str(ta:2,h);if h[1]=' ' then h[1]:='0'; h1:= h;
str(mo:2,h);if h[1]=' ' then h[1]:='0';h1:=h+h1;
str( j:4,h);
db_datum:=h+h1;
end;
          ******************)
function  Tscenario.qtime2dbdt(qt:integer):string;
const _yd:array [1974..1997] of integer
         =(   0,  365,  731, 1096,
           1461, 1826, 2192, 2557,
           2922, 3287, 3653, 4018,
           4383, 4748, 5114, 5479,
           5844, 6209, 6575, 6940,
           7305, 7670, 8036, 8401);
var
jahr:integer;
d:string;
begin
 qt:=qt+1;
 jahr:=1975;
 while qt>_yd[jahr] do
 begin
 inc(jahr);
 end;
 d:=datum(qt-_yd[jahr-1],jahr);
 qtime2dbdt:=d;
end;


function Tscenario.make_snr(sbez:string):integer;
var i,h:integer;
begin
 while sbez[1]='_' do sbez:=copy(sbez,2,length(sbez)-1);

 if pos('-',sbez)>0 then sbez:=copy(sbez,1,length(sbez)-2)   {___1-0}
                    else sbez:=copy(sbez,1,length(sbez)-1);  {___10}
 val(sbez,i,h);
 make_snr:=i;
end;

function Tscenario.make_pnr(sbez:string):integer;
var i,h:integer;
begin
 val(sbez[length(sbez)],i,h);
 make_pnr:=i;
end;

function  Tmndobj.seed(d:tdatum):integer;
var wpt:pMmtEnt;
begin
 if today(d) then
  begin
    wpt:=actual;
    while (wpt^.mmt.datum=d)
      and not(wpt^.mmt.code in [1,12])

      and not wpt^.mmt.ready
      and (wpt^.next<>NIL) do wpt:=wpt^.next;
    if  (wpt^.mmt.datum=d)
    and not wpt^.mmt.ready
    and (wpt^.mmt.code in [1,12] )  then     begin
                                    seed:=wpt^.mmt.qual;
                                    nupt:=wpt^.mmt.quan;
                                    wpt^.mmt.ready:=true;
                                    candy.scene.autofert.crop:=wpt^.mmt.qual;
                                    candy.scene.autofert.yield:=nupt;
                                    end
                           else seed:=0;
  end;
end;

function  Tmndobj.start_forest(d:tdatum; var model_id:integer):integer;
var wpt:pMmtEnt;
begin
 if today(d) then
  begin
    wpt:=actual;
    while (wpt^.mmt.datum=d)
      and not (wpt^.mmt.code in [21,22,23])

      and not wpt^.mmt.ready
      and (wpt^.next<>NIL) do wpt:=wpt^.next;
    if  (wpt^.mmt.datum=d)
    and not wpt^.mmt.ready
    and (wpt^.mmt.code in [21,22,23] )  then
                                  begin
                                    start_forest:=wpt^.mmt.qual;
                                    model_id:=wpt^.mmt.code ;
                                    nupt:=wpt^.mmt.quan;
                                    wpt^.mmt.ready:=true;
                                  end
                           else start_forest:=0;
  end;
end;


function  Tmndobj.pestizid(d:tdatum;var menge:real):integer;
var wpt:pMmtEnt;
begin
 menge:=0;
 if today(d) then
  begin
    wpt:=actual;
    while (wpt^.mmt.datum=d)
      and (wpt^.mmt.code<>8)
      and not wpt^.mmt.ready
      and (wpt^.next<>NIL) do wpt:=wpt^.next;
    if  (wpt^.mmt.datum=d)
    and not wpt^.mmt.ready
    and (wpt^.mmt.code=8)  then
                            begin
                                pestizid:=wpt^.mmt.qual;
                                menge:=wpt^.mmt.quan;
                                wpt^.mmt.ready:=true;
                            end
                           else pestizid:=0;
  end;
end;

function  Tmndobj.tillage(d:tdatum;var menge:real):integer;
var wpt:pMmtEnt;
begin
 menge:=0;
 if today(d) then
  begin
    wpt:=actual;
    while (wpt^.mmt.datum=d)
      and (wpt^.mmt.code<>5)
      and not wpt^.mmt.ready
      and (wpt^.next<>NIL) do wpt:=wpt^.next;
    if  (wpt^.mmt.datum=d)
    and not wpt^.mmt.ready
    and (wpt^.mmt.code=5)  then
                            begin
                                if wpt^.mmt.qual >0 then tillage:=wpt^.mmt.qual
                                                    else tillage:=-99;

                                menge:=wpt^.mmt.quan;
                                wpt^.mmt.ready:=true;
                            end
                           else tillage:=0;
  end;
end;
function Tmndobj.next_bb:integer;
var zeit,d1,d2:integer;
    t0,t1,t2:tdatum;
    wpt:pMMTENT;
begin
  wpt:=actual;
  zeit:=30;
  t1:=actual^.mmt.datum;
  t0:='1231'+copy(t1,5,4);
  d1:=dbfdaynr(t1);
  d2:=d1;
  while (wpt^.next<>NIL)
    and (wpt^.mmt.code<>5)
    and ((d2-d1)<30 )
    and  (wpt^.next^.mmt.datum<>'ENDE')                       {   (zeit<5)}
   do
    begin
      wpt:=wpt^.next;
      t2:=wpt^.mmt.datum;
      d2:=dbfdaynr(t2);
      if {d2>d1}(wpt^.mmt.code=5) then zeit:=d2-d1
              { else zeit:=d2+dbfdaynr(t0)-d1};
    end;
  next_bb:=zeit;
end;

function  Tmndobj.auftrieb(d:tdatum;var menge:real):integer;
var wpt:pMmtEnt;
begin
 menge:=0;
 if today(d) then
  begin
    wpt:=actual;
    while (wpt^.mmt.datum=d)
      and (wpt^.mmt.code<>10)
      and not wpt^.mmt.ready
      and (wpt^.next<>NIL) do wpt:=wpt^.next;
    if  (wpt^.mmt.datum=d)
    and not wpt^.mmt.ready
    and (wpt^.mmt.code=10)  then
                            begin
                                auftrieb:=wpt^.mmt.qual;
                                menge:=wpt^.mmt.quan;
                                wpt^.mmt.ready:=true;
                            end
                           else auftrieb:=0;
  end;
end;

function  Tmndobj.abtrieb(d:tdatum;var menge:real):integer;
var wpt:pMmtEnt;
begin
 menge:=0;
 if today(d) then
  begin
    wpt:=actual;
    while (wpt^.mmt.datum=d)
      and (wpt^.mmt.code<>11)
      and not wpt^.mmt.ready
      and (wpt^.next<>NIL) do wpt:=wpt^.next;
    if  (wpt^.mmt.datum=d)
    and not wpt^.mmt.ready
    and (wpt^.mmt.code=11)  then
                            begin
                                abtrieb:=wpt^.mmt.qual;
                                menge:=wpt^.mmt.quan;
                                wpt^.mmt.ready:=true;
                            end
                           else abtrieb:=0;
  end;
end;

function  Tmndobj.min_dng(d:tdatum;var menge:real):integer;
var wpt:pMmtEnt;
begin
 menge:=0;
 if today(d) then
  begin
    wpt:=actual;
    while (wpt^.mmt.datum=d)
      and (wpt^.mmt.code<>4)
      and not wpt^.mmt.ready
      and (wpt^.next<>NIL) do wpt:=wpt^.next;
    if  (wpt^.mmt.datum=d)
    and not wpt^.mmt.ready
    and (wpt^.mmt.code=4)  then
                            begin
                                min_dng:=wpt^.mmt.qual;
                                menge:=wpt^.mmt.quan;
                                wpt^.mmt.ready:=true;
                            end
                           else min_dng:=0;
  end;
end;


function  Tmndobj.overdrive(d:tdatum;var idruck,anteil:real):integer;
var wpt:pMmtEnt;
    i:integer;
begin
 idruck:=0;
 if today(d) then
  begin
    wpt:=actual;
    while (wpt^.mmt.datum=d)
      and (wpt^.mmt.code<>14)
      and not wpt^.mmt.ready
      and (wpt^.next<>NIL) do wpt:=wpt^.next;
    if  (wpt^.mmt.datum=d)
    and not wpt^.mmt.ready
    and (wpt^.mmt.code=14)  then
                            begin
                               overdrive:=wpt^.mmt.qual;
                                idruck:=wpt^.mmt.quan;
                                val(wpt^.mmt.spez,anteil,i);
                                wpt^.mmt.ready:=true;
                            end
                           else overdrive:=0;
  end;
end;

function  Tmndobj.org_dng(d:tdatum;var menge:real; var spec:string):integer;
var wpt:pMmtEnt;
begin
 menge:=0;
 if today(d) then
  begin
    wpt:=actual;
    while (wpt^.mmt.datum=d)
      and (wpt^.mmt.code<>3)
      and not wpt^.mmt.ready
      and (wpt^.next<>NIL) do wpt:=wpt^.next;
    if  (wpt^.mmt.datum=d)
    and not wpt^.mmt.ready
    and (wpt^.mmt.code=3)  then
                            begin
                                org_dng:=wpt^.mmt.qual;
                                menge:=wpt^.mmt.quan;
                                spec:=wpt^.mmt.spez;
                                wpt^.mmt.ready:=true;
                            end
                           else org_dng:=0;
  end;
end;

function  Tmndobj.irrigtn(d:tdatum;var menge:real):integer;
var wpt:pMmtEnt;
begin
 menge:=0;
 if today(d) then
  begin
    wpt:=actual;
    while (wpt^.mmt.datum=d)
      and (wpt^.mmt.code<>7)
      and not wpt^.mmt.ready
      and (wpt^.next<>NIL) do wpt:=wpt^.next;
    if  (wpt^.mmt.datum=d)
    and not wpt^.mmt.ready
    and (wpt^.mmt.code=7)  then
                            begin
                                irrigtn:=max(wpt^.mmt.qual,1);
                                menge:=wpt^.mmt.quan;
                                wpt^.mmt.ready:=true;
                            end
                           else irrigtn:=0;
  end;
end;


function  Tmndobj.harvest(d:tdatum;var kpabf:boolean):integer;
var wpt:pMmtEnt;
begin
 if today(d) then
  begin
    wpt:=actual;
    while (wpt^.mmt.datum=d)
      and (wpt^.mmt.code<>2)
      and not wpt^.mmt.ready
      and (wpt^.next<>NIL) do wpt:=wpt^.next;
    if  (wpt^.mmt.datum=d)
    and not wpt^.mmt.ready
    and (wpt^.mmt.code=2)  then begin
                                 kpabf:=( wpt^.mmt.qual=0 );
                                 harvest:=1 ;
                                 wpt^.mmt.ready:=true;
                                 candy.scene.autofert.pre_crop:=candy.scene.autofert.crop;
                                 candy.scene.autofert.er_removed:= kpabf;
                                 candy.scene.autofert.clear;
                                end
                           else harvest:=0;
  end;
end;

function  Tmndobj.pre_harvest(d:tdatum; var ss:boolean):integer;
var wpt:pMmtEnt;
begin
 ss:=false; //Standardannahme: kein Schröpfschnitt!
 if today(d) then
  begin
    wpt:=actual;
    while (wpt^.mmt.datum=d)
      and (wpt^.mmt.code<>6)
      and not wpt^.mmt.ready
      and (wpt^.next<>NIL) do wpt:=wpt^.next;
    if  (wpt^.mmt.datum=d)
    and not wpt^.mmt.ready
    and (wpt^.mmt.code=6)  then begin
                                 pre_harvest:=wpt^.mmt.qual;
                                 ss:=wpt.mmt.quan<0;
                                 wpt^.mmt.ready:=true;
                                end
                           else pre_harvest:=0;
  end;
end;



function  Tmndobj.umbruch(d:tdatum; var tiefe:real):integer;
var wpt:pMmtEnt;
begin
 if today(d) then
  begin
    wpt:=actual;
    while (wpt^.mmt.datum=d)
      and (wpt^.mmt.code<>0)
      and not wpt^.mmt.ready
      and (wpt^.next<>NIL) do wpt:=wpt^.next;
    if  (wpt^.mmt.datum=d)
    and not wpt^.mmt.ready
    and (wpt^.mmt.code=0)  then begin
                                 if wpt^.mmt.qual >0
                                 then umbruch:=wpt^.mmt.qual
                                 else umbruch:=-99;

                                 tiefe:=wpt^.mmt.quan;
                                 wpt^.mmt.ready:=true;
                                 candy.scene.autofert.crop:=0;
                                end
                           else umbruch:=0;
  end;
end;


function Tmndobj.today(d:tdatum):boolean;
begin
 if actual<>NIL then today:= actual^.mmt.datum=d
                else today:= false;
end;

procedure Tmndobj.act_mmt(var m:tmmtrec);
begin
 m:=actual^.mmt;
end;

procedure Tmndobj.skip(neu:boolean);
begin
 if actual<>last then  actual:=actual^.next;
 while(actual<>last) and ((actual^.mmt.ready) OR NEU) do
 begin
    actual:=actual^.next;
 end;
end;


constructor Tmndobj.create(dbpath,daba:string);

begin
  //standard:=true;
  fname:=daba;
  mname:=dbpath+'MAS'+daba+'.DBF';
   //  timeseq.init(mname);
  new(mnd);
  mnd^.next:=nil;
  last:=mnd;
end;


procedure   Tmndobj.output(Var m:pmmtent);
var h1,h2:pmmtent;
begin
h1:=mnd;
new(m);
h2:=m;
{1. Fall leere Liste}
if h1=nil then
 begin
  m:=nil;
  exit;
 end;
{2.Fall keine leere Liste}
while h1<>nil do
 begin
  h2^:=h1^;
  h2^.next:=nil;
  h1:=h1^.next;
  if h1<>nil then new(h2^.next);
  h2:=h2^.next;
 end;
end;

procedure Tmndobj.adapt(ajahr:integer);
begin
actual:=mnd;
while actual<>last do
  begin
    actual^.mmt.datum:=datum(dbfdaynr(actual^.mmt.datum),
                                dbfyear(actual^.mmt.datum)+ajahr);
    actual:=actual^.next;
  end;
  actual:=mnd;
end;

procedure   Tmndobj.adjust(start:tdatum);
var tagnr,jahrz:integer;
     d1,d2:tdatetime;
begin
tagnr:=dbfdaynr(start);
jahrz :=dbfyear(start);
{actual:=mnd;}
d1:= strtodate(actual^.mmt.datum);

d2:= strtodate(start);
tagnr:=round(dayspan(d1,d2));
if tagnr>0 then
while (actual^.next<>NIL)
  and (d2>d1) do
  begin
  send_msg(' skipped: '+actual.mmt.datum+'; dnr='+inttostr(dbfdaynr(actual^.mmt.datum))+' yr='+  inttostr(dbfyear(actual^.mmt.datum)),1);
  skip(false);
  if   actual^.mmt.datum <>'ENDE' then
  d1:= strtodate(actual^.mmt.datum);
  end;

if (d2>d1) then actual:=NIL;
if actual = nil then send_msg('no management actions available ',1)
                else send_msg('1.management action:  '+actual.mmt.datum ,1);
end;

procedure Tmndobj.reset(start:tdatum);
begin
  actual:=mnd;
  while actual^.next<>NIL do
   begin
    actual^.mmt.ready:=false;
    ACTUAL:=ACTUAL^.NEXT;
   end;
  actual:=mnd;
  //Tmndobj.
  adjust(start);
end;


procedure Tmndobj.calc_crep(var c_rep:real);
var m:pmmtent;
    name:string;
    ok:boolean;
    ajr,jr,h,n:integer;
    c_ewr,f_ewr,eta,cnr,crep,cinp:real;
begin
m:=actual;
ajr:=-1;
crep:=0;
n:=0;
while m^.next<>NIL do
begin
 cinp:=0;
 val(copy(m^.mmt.datum,1,4),JR,h);
 if jr<>ajr then
 begin
  N:=n+1;
  ajr:=jr;
 end;
 if (m^.mmt.code=1) or (m^.mmt.code=12)  then
 begin
   h:=m^.mmt.qual;
   plantparm.select(h,name,ok);
   c_ewr:=plantparm.parm('CEWR');
   f_ewr:=plantparm.parm('FEWR');
   h:=round(plantparm.parm('EWR_IX'));
   opsparm.select(h,name,ok);
   eta:=opsparm.parm('ETA');
   cnr:=opsparm.parm('CNR');
   cinp:=(c_ewr+f_ewr*m^.mmt.quan)*cnr*eta;
 end;
 if m^.mmt.code=3 then
 begin
   h:=m^.mmt.qual;
   opsparm.select(h,name,ok);
   eta:=opsparm.parm('ETA');
   cinp:=m^.mmt.quan*eta;
 end;
 crep:=crep+cinp;

 m:=m^.next;
end;
c_rep:=crep/(100*n);
end;

procedure   Tmndobj.load(start,stop:tdatum;schlag:string);
var
    ende :boolean;
    m    :pmmtent;

    id  :string;
    h,
    un,
    yr,
    sn,anz   :integer;
   // fa   :feldatr;
    mqry :tfdquery;

begin
 val(copy(start,7,4),yr,h);
 m:=mnd;
 last:=mnd;
 actual:=mnd;
 un:= candy.scene.make_pnr(schlag);
 sn:= candy.scene.make_snr(schlag);
 mqry:=tfdquery.create(nil);
 mqry.connection:=dbc; //allg_parm.Connection;
// 'normale' Ausführung
if candy.scene.standard then
 Begin

 mqry.SQL.Add('select * from cdy_madat  ');

 mqry.SQL.Add(' where snr= '+inttostr(sn));
 mqry.sql.Add(' and fname='+''''+fname+'''');
// dies verhindert zyklische Rechnung: mqry.SQL.Add(' and   UTLG= '+inttostr(un) +' and datum>=:tanf order by SNR,UTLG,DATUM,MACODE');
// neu:
 mqry.SQL.Add(' and   utlg= '+inttostr(un) +' order by snr,utlg,datum,macode');

 End
 else
 begin    // BLE-mode


 mqry.SQL.Add('SELECT cdy_madat_f.fname, netplot.plot_id AS snr, 0 AS utlg, cdy_madat_f.DATUM,  cdy_madat_f.MACODE, ');
 mqry.SQL.Add(' cdy_madat_f.WERT1, cdy_madat_f.WERT2, cdy_madat_f.ORIGWERT,  cdy_madat_f.REIN ');
 mqry.SQL.Add(' FROM (cdy_madat_f INNER JOIN netplot ON (cdy_madat_f.fname = netplot.fname) ');
 mqry.SQL.Add(' AND (cdy_madat_f.SNR = netplot.snr) AND (cdy_madat_f.UTLG = netplot.utlg) ');
 mqry.SQL.Add(' AND (cdy_madat_f.SNR = netplot.snr) AND (cdy_madat_f.fname = netplot.fname) ');
 mqry.SQL.Add(' AND (cdy_madat_f.UTLG = netplot.utlg) AND (cdy_madat_f.SNR = netplot.snr)) ');
 mqry.SQL.Add(' LEFT JOIN cdy_mplot ON cdy_madat_f.key = cdy_mplot.ma_id ');
 mqry.SQL.Add(' WHERE (((cdy_mplot.ma_id) Is Null)) ');
 mqry.sql.Add(' and  netplot.plot_id='+candy.scene.plotid+' and cdy_madat_f.SNR= '+inttostr(sn)+' and cdy_madat_f.fname="'+fname+'" ');
 mqry.SQL.Add(' and cdy_madat_f.UTLG='+inttostr(un) );
 mqry.SQL.Add('union ');
 mqry.SQL.Add('SELECT cdy_madat_f.fname, netplot.plot_id AS snr, 0 AS utlg, cdy_madat_f.DATUM, cdy_madat_f.MACODE, ');
 mqry.SQL.Add(' cdy_madat_f.WERT1, cdy_mplot.intensity AS wert2,-99 AS ORIGWERT, cdy_madat_f.REIN ');
 mqry.SQL.Add(' FROM (cdy_madat_f INNER JOIN netplot ON (cdy_madat_f.SNR = netplot.snr) ');
 mqry.SQL.Add(' AND (cdy_madat_f.UTLG = netplot.utlg) AND (cdy_madat_f.fname = netplot.fname) ');
 mqry.SQL.Add(' AND (cdy_madat_f.SNR = netplot.snr) AND (cdy_madat_f.UTLG = netplot.utlg) ');
 mqry.SQL.Add(' AND (cdy_madat_f.SNR = netplot.snr) AND (cdy_madat_f.fname = netplot.fname)) ');
 mqry.SQL.Add(' INNER JOIN cdy_mplot ON (netplot.plot_id = cdy_mplot.plot_id) ');
 mqry.SQL.Add(' AND (cdy_madat_f.key = cdy_mplot.ma_id) ');
 mqry.SQL.Add(' WHERE (((cdy_madat_f.MACODE)<>4)) ');
  mqry.sql.Add(' and  netplot.plot_id='+candy.scene.plotid+' and cdy_madat_f.SNR= '+inttostr(sn)+' and cdy_madat_f.fname="'+fname+'" ');
 mqry.SQL.Add(' and cdy_madat_f.UTLG='+inttostr(un) );
 mqry.SQL.Add('union ');
 mqry.SQL.Add('SELECT cdy_madat_f.fname, netplot.plot_id AS snr, 0 AS utlg, cdy_madat_f.DATUM, cdy_madat_f.MACODE, ');
 mqry.SQL.Add('  cdy_madat_f.WERT1, cdy_madat_f.WERT2, cdy_mplot.intensity AS origwert, cdy_madat_f.REIN ');
 mqry.SQL.Add(' FROM (cdy_madat_f INNER JOIN netplot ON (cdy_madat_f.SNR = netplot.snr) ');
 mqry.SQL.Add(' AND (cdy_madat_f.UTLG = netplot.utlg) AND (cdy_madat_f.fname = netplot.fname) ');
 mqry.SQL.Add(' AND (cdy_madat_f.SNR = netplot.snr) AND (cdy_madat_f.UTLG = netplot.utlg) ');
 mqry.SQL.Add(' AND (cdy_madat_f.SNR = netplot.snr) AND (cdy_madat_f.fname = netplot.fname)) ');
 mqry.SQL.Add(' INNER JOIN cdy_mplot ON (cdy_madat_f.key = cdy_mplot.ma_id) ');
 mqry.SQL.Add(' AND (netplot.plot_id = cdy_mplot.plot_id) ');
 mqry.SQL.Add(' WHERE (((cdy_madat_f.MACODE)=4))  ');
 mqry.sql.Add(' and  netplot.plot_id='+candy.scene.plotid+' and cdy_madat_f.SNR= '+inttostr(sn)+' and cdy_madat_f.fname="'+fname+'" ');
 mqry.SQL.Add(' and cdy_madat_f.UTLG='+inttostr(un) );
 mqry.SQL.Add(' order by  DATUM, MACODE');

{old UND GETESTET

 mqry.SQL.Add('SELECT cdy_madat_f.fname,cdy_madat_f.snr,cdy_madat_f.utlg,cdy_mplot.plot_id,   ');
 mqry.SQL.Add(' cdy_madat_f.DATUM, cdy_madat_f.MACODE, cdy_madat_f.WERT1,cdy_mplot.intensity as wert2, ');
 mqry.SQL.Add(' cdy_mplot.intensity AS origwert, cdy_madat_f.rein  ');
 mqry.SQL.Add(' FROM cdy_madat_f INNER JOIN cdy_mplot ON cdy_madat_f.key = cdy_mplot.ma_id ');
 mqry.SQL.Add(' where cdy_madat_f.SNR= '+inttostr(sn)+' and cdy_mplot.plot_id='+ plot_id  );
 mqry.sql.Add(' and cdy_madat_f.fname="'+fname+'" ');
 mqry.SQL.Add(' and cdy_madat_f.UTLG= '+inttostr(un) +' order by SNR,UTLG,DATUM,MACODE');
 }

 end;
 mqry.open;
 {
 form2.datasource1.dataset:=mqry;
 form2.showmodal;
 }
 mqry.First;
 anz:=mqry.RecordCount;
 send_msg(inttostr(anz)+' records received',1);
 val(copy(stop,7,4),yr,h);    {yr ist jetzt das Endejahr}
 //if ok then
 repeat
  m^.mmt.ready:=false;
  m^.mmt.code:= mqry.fieldbyname('MACODE').asinteger;
  // standart: wert1: qual wert2: quan
  m^.mmt.qual:=mqry.fieldbyname('WERT1').asinteger;
  m^.mmt.qual:=mqry.fieldbyname('WERT2').asinteger;
  if mqry.FindField('SPEC') <> NIL then   id:= trim(mqry.fieldbyname('SPEC').asstring) else id:='';
  m^.mmt.spez:= id  ;

 // weiters spezialbehandlung

 if m^.mmt.code=3 then
 begin  // org. Dünger spezifizieren ?
 if mqry.FindField('SPEC') <> NIL then   id:= trim(mqry.fieldbyname('SPEC').asstring) else id:='';
  if length(id)>0 then m^.mmt.spez:=id else m^.mmt.spez:='0';
 end;

  if m^.mmt.code in [4,10,11,7]
  then
  begin
   m^.mmt.qual:=mqry.fieldbyname('WERT1').asinteger;
   m^.mmt.quan:=mqry.fieldbyname('ORIGWERT').asfloat;
  end
  else
  begin
   if m^.mmt.code=9
   then
   begin
    m^.mmt.code:=2;
    m^.mmt.qual:=1; {ER bleiben auf acker}
    m^.mmt.quan:=mqry.fieldbyname('WERT2').asfloat;
   end
   else
   begin
    if m^.mmt.code=2
     then m^.mmt.qual:=0
     else m^.mmt.qual:=mqry.fieldbyname('WERT1').asinteger;
    m^.mmt.quan:=mqry.fieldbyname('WERT2').asinteger;
   end;
  end;
{$IFDEF CDY_SRV}
  m^.mmt.datum:=datetostr(mqry.fieldbyname('DATUM').AsDateTime, cdy_frmtsettings);
{$ENDIF}

{$IFDEF CDY_GUI}
  m^.mmt.datum:=mqry.fieldbyname('DATUM').AsString;
{$ENDIF}

  if ( m.mmt.code in [1,2] ) then
  begin
    if ( m.mmt.code in [1,2] ) and ( mqry.fieldbyname('REIN').asstring='J' )         // Sonderbehandlung Ernte
    then         //wenn n-Entzug und ertrag in mas gegeben, dann den N-Gehalt bestimmen und hier merken
     begin
     if mqry.fieldbyname('WERT2').AsFloat=0 then
      begin
        _halt(4);
        exit;
      end;
      h:= round(1000*mqry.fieldbyname('ORIGWERT').asfloat/mqry.fieldbyname('WERT2').AsFloat);
      m.mmt.spez:= inttostr(h);
     end
     else m^.mmt.spez:='*';   // sonst keine Spezialinformation
  end;

 if m^.mmt.code=14 then
 begin  // überfahren
 if mqry.FindField('ORIGWERT') <> NIL then   id:= trim(mqry.fieldbyname('ORIGWERT').asstring) else id:='';
  if length(id)>0 then m^.mmt.spez:=id else m^.mmt.spez:='0';
 end;

  mqry.Next;
  // if ok then timeseq.im_scenario(yr,ok);
  // ende:=not ok;
  ende:=mqry.Eof;
  if m^.next=NIL then begin new(m^.next); m^.next^.next:=nil; end;
  m   :=m^.next;
  m^.mmt.datum:='ENDE';
  last:=m;
 until ende;
 mqry.free;
end;

procedure Tmndobj.list;
var m:pmmtent;
begin
 writeln('Schlagnr:',snr,'(',utlg,')','  ',jahr);
 m:=mnd;
 if m<>last then
 repeat
 writeln(m^.mmt.datum:8,m^.mmt.code:8,m^.mmt.quan:8,m^.mmt.qual:8);
 m:=m^.next;
 until m=last;
 writeln('ENDE');
end;


destructor Tmndobj.done;
begin
 // timeseq.done;
  while mnd<>NIL do
  begin
   actual:=mnd^.next;
   dispose(mnd);
   mnd:=actual;
  end;

end;

(*
procedure Tscenario.create_action_list;
var atb:tfdquery; id:integer;
begin
 atb:=tfdquery.create(nil);
 atb.sql.add('select * from CDYAKTION order by action_id');
// atb.DatabaseName:= allg_parm.databasename;
 if allg_parm<>nil then
  begin
   atb.connection:=allg_parm.Connection;
   atb.open;
   atb.First;
  // scene.actions.Add( 'Actions');
   repeat
     id:= atb.fieldbyname('action_id').asinteger;
     while   {candy.scene.}actions.Count < id do {candy.scene.}actions.add('dummy');
     {candy.scene.}actions.Insert( atb.fieldbyname('action_id').asinteger, atb.fieldbyname('action').asstring);
     atb.next;
   until atb.Eof;
   atb.close;
  end;
 atb.free;
end;
  *)
begin
{
 candy.scene.anfg := '19800101';
 candy.scene.ende := '19801231';
 candy.scene.cums := 25000;
 candy.scene.soil := 'LOE';
 candy.scene.s_nr := '___10';
 candy.scene.dtbk := 'MFELD';
 candy.scene.autofert:=Tauto_fert.create;
 candy.scene.actions:=tstringlist.Create;
 candy.scene.plotid:='';
 candy.scene.standard:=true;
 }
 end.

(*
procedure get_command;
var t0,t1,sl,sn,db:string;
    cu:real;

 t0:='';t1:='';sl:='';sn:='';db:='';cu:=0;

 For i:=1 to paramcount do
 begin


  if capital(copy(paramstr(i),1,4))='ANFG'
     then t0:=capital(copy(paramstr(i),6,8);

  if capital(copy(paramstr(i),1,4))='ENDE'
     then t1:=capital(copy(paramstr(i),6,8);


  if capital(copy(paramstr(i),1,4))='SOIL'
     then sl:=capital(copy(paramstr(i),6,8);

  if capital(copy(paramstr(i),1,4))='S_NR'
     then sn:=capital(copy(paramstr(i),6,5);


  if capital(copy(paramstr(i),1,4))='DTBK'
     then db:=capital(copy(paramstr(i),6,5);


  if capital(copy(paramstr(i),1,4))='CUMS'
     then val(copy(paramstr(i),6,5),cu,h);


if t0='' or  t1='' or sl='' or sn='' or db='' or cu=0
then       { kein Job-Kommando angegeben }
   {  diagnose('benutze internes Scenario')}

else
 begin
  scene.anfg := t0;
  scene.ende := t1;
  scene.cums := cu;
  scene.soil := sl;
  scene.s_nr := sn;
  scene.dtbk := db;

 end;
end;
*)
