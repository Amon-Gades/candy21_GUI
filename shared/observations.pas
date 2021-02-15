{
 management of observations with the help of the class TCDY_OBS
 this includes not only the processing of observations and model data
 but also the organisation of the tables that define the properties
 ANY additional observation (property) has to be defined here as a class of TanyObs as child of the class anyRslt
}
{$INCLUDE cdy_definitions.pas}
unit observations;

interface
uses
{$IFDEF CDY_GUI}
cdy_glob,
{$ENDIF}
{$IFDEF CDY_SRV}
cdy_config,
{$ENDIF}


  //CANDY:


   cnd_util,cnd_vars,soilprf3,
   bestand,cdyswat,cdywett,
   cndmulch,ok_dlg1,cdy_bil,db ,cdysomdyn, gis_rslt,cndplant,
 //DELPHI:
  system.classes , dateutils, math, sysutils, FireDAC.Comp.Client;


type

    PanyObs=^TanyObs;
    Pobsrch=^Tobsrch;
    Tobsrch= record
               m_ix,
               list_id :integer;
             end;
     Pcdy_obs=^Tcdy_obs;
     TCDY_Obs= class(Tobject)
                  mv    : Tfdtable;
                  qadpt  : Tfdquery;
               //   cdy_stat :statrec;
                  n_adapt: integer;
                  all_obs : TStringlist;
                  asnr,autlg,
                  place  :string;

                  aobs: panyobs;
                  amix,
                  a_tag,a_jahr,     // adaptation event               ,yr_end
                  _tag,_jahr,       // observation event
                  amsg_level,
                  avon,
                  abis   :integer;
                  mw_ok,
                  gis:boolean;
                  adate:tdatetime;

                  adpt_cdy:boolean;
                  avalue:double;
            //      asprfl:T_soil_profile;

           //       o_cdy: Tcndcycl;
                  o_soil: Tsomdyn;
                  o_sprf: T_soil_profile;
                  o_yld   :{pyld; //}ertragsdaten;

                  constructor create(soilprofile:T_soil_profile;soil_o:Tsomdyn);
                  destructor  done;
                  procedure initialize;
                  procedure rewrite_mltab;
                  procedure register_observations( pcdy:pointer);
                  procedure register_ (r:PanyObs);
                  procedure skip(var ok:boolean;var ds: Tdataset; var dd,yy:integer);
                  procedure process_obs( ast:sysstat; msglv:integer);                //< processing of observations without adaptation
                  procedure adapt_state( ast:sysstat; msglv:integer);                //< processing of observations to adaptate state variables
                  procedure process_a_obs;
                  procedure adapt(m_ix,von,bis:integer; value:double);
                  procedure set_som( von,bis:integer;v:double);
                  procedure report(m_ix,von,bis:integer);
                  procedure get_info(var mix: Integer; var s0: Integer; var s1: Integer; var value: double; var adpt: Boolean);
                  procedure get_adaptation(var mix: Integer; var s0: Integer; var s1: Integer; var value: double; var adpt: Boolean);
                  procedure check(t: Integer; j: Integer; var ok: Boolean; var ds:Tdataset);       // observation ?
                  procedure acheck(t: Integer; j: Integer; var ok: Boolean; var ds:Tdataset);      // adaptation  ?


                  procedure connect(fname_:string; snr, utlg: integer; gis_mode:boolean);

                end;
    TanyObs= object(anyRslt)
              base_obj : pointer;
              get_data : procedure  (o:Tcdy_obs; P1:pointer;  Var x:double);
              constructor init(inf:tinforec);
             end;

var
obs_soiltem,     obs_soilmoistV,     obs_Cdec,         obs_NO3N,
obs_amnn,        obs_minN,           obs_soilwas,      obs_socconc,
obs_cmic,        obs_chws,           obs_transpi,      obs_tension,
obs_bat ,        obs_aet,            obs_wperko,       obs_nperko,
obs_bd,          obs_pd,             obs_fcap,         obs_pwp,
obs_pvol,        obs_admmp,          obs_admbp,        obs_admcr,
obs_cyldmp,      obs_nyldmp,         obs_cyldbp,       obs_nyldbp,
obs_dmyldmp,     obs_dmyldbp,        obs_yldnoff,      obs_WuptLay,
obs_NuptLay,     obs_no3ncon,        obs_crepflx,      obs_socstock,
obs_n2o,         obs_wdrain,         obs_ndrain,       obs_natyldbp,
obs_natyldmp,    obs_gwb,            obs_elres,        obs_lai,
obs_pet,         obs_RtDpth,         obs_acCroCov,     obs_cmulch,
obs_nmulch,      obs_dc,             obs_noffyld,      obs_soilmoistM :Panyobs;

//    o_yld   :{pyld; //ertragsdaten;


implementation
uses cnd_rs_2,types,cdyspsys  ,cdyparm;

procedure get_socconc(lobs:Tcdy_obs;p1:pointer; var v:double);
var x1,x2 :saeule;
    i:integer;
    p2 :pointer;
    hs,             // schichthöhe in m
    hfak:double;

begin
  p2:=pointer(integer(lobs.aobs.base_obj)+ lobs.aobs.info.offset2);
  x1:=saeule(p1^);
  x2:=saeule(p2^);
  v:=0;
  hs:=0.1;
  for i:= lobs.avon+1 to lobs.abis do
  begin
   hfak:=hs*100000*candy.sprfl.trd_0[i];
   v:=v+(x1[i]+x2[i])/hfak;                             // die Summation erfolgt über die Schichten !
  end;
  v:=candy.sprfl.c_inert+v /(lobs.abis-lobs.avon) ;           //
end;

procedure sum_aggprf(lobs:Tcdy_obs;p1:pointer; var v:double);
var x1,x2 :profil;
    i:integer;
    p2 :pointer;
begin
  v:=0;
  x1:=profil(p1^);
  for i:= lobs.avon+1 to lobs.abis do v:=v+x1[i];
  if lobs.aobs.info.offset2 <>0
  then
  begin
   p2:=pointer(integer(lobs.aobs.base_obj)+ lobs.aobs.info.offset2);
   x2:=profil(p2^);
   for i:= lobs.avon+1 to lobs.abis do v:=v+x2[i];
  end;
end;

procedure sum_aggsaeule(lobs:Tcdy_obs;p1:pointer; var v:double);
var x1,x2 :saeule;
    i:integer;
    p2 :pointer;
begin
  x1:=saeule(p1^);  v:=0;
  for i:= lobs.avon+1 to lobs.abis do v:=v+x1[i];
  if lobs.aobs.info.offset2 <>0
  then
  begin
   p2:=pointer(integer(lobs.aobs.base_obj)+ lobs.aobs.info.offset2);
   x2:=saeule(p2^);
   for i:= lobs.avon+1 to lobs.abis do v:=v+x2[i];
  end;
end;
 {
procedure get_cmic(lobs:Pcdy_obs;p1:pointer; var v:double);
var i : integer;
    x1:saeule;
begin
  x1:=saeule(p1^);  v:=0;
  for i:= lobs.avon+1 to lobs.abis do
  begin
  if cips.active
    then   v:=v+x1[i]
    else   v:=v+x1[i]/(5.5*sprfl^.trd_0[i]);
  end;
end;
  }
procedure get_chws(lobs:Tcdy_obs;p1:pointer; var v:double);
var x1,x2 :saeule;
    i:integer;
    p2 :pointer;
begin
  x1:=saeule(p1^);  v:=0;
  p2:=pointer(integer(lobs.aobs.base_obj)+ lobs.aobs.info.offset2);
  x2:=saeule(p2^) ;
  for i:= lobs.avon+1 to lobs.abis do v:=v+(x1[i]+x2[i])/(150*candy.sprfl.trd_0[i]) ;     {Standard 150, PUHL}
//  for ii:=ii_1+1 to ii_2 do cs:=cs+(k_stat.aos[ii]+k_stat.sos[ii])/(150*sprfl^.trd[ii]);
end;

procedure get_concw(lobs:Tcdy_obs;p1:pointer; var v:double);
var x1,x2 :profil;
    i:integer;
    p2 :pointer;
    hfak,h1,h2:double;
begin
  x1:=profil(p1^);
  p2:=pointer(integer(lobs.aobs.base_obj)+ lobs.aobs.info.offset2);
  x2:=profil(p2^);
  hfak:=1;
  h1:=0; h2:=0;
  for i:= lobs.avon+1 to lobs.abis do h1:=h1+x1[i];
  for i:= lobs.avon+1 to lobs.abis do h2:=h2+x2[i];
  if h2>0 then v:=lobs.aobs.info.faktor*h1/h2 else v:=-999;
end;




procedure get_socstock(lobs:Tcdy_obs;p1:pointer; var v:double);
var x1,x2 :saeule;
    i:integer;
    p2 :pointer;
begin

  x1:=saeule(p1^);
  p2:=pointer(integer(lobs.aobs.base_obj)+ lobs.aobs.info.offset2);
  x2:=saeule(p2^);
//  hfak:=(lobs.abis - lobs.avon)*10000;
  v:=candy.sprfl.c_inert_kg;
  for i:= lobs.avon+1 to lobs.abis do v:=v+(x1[i]+x2[i]);

end;

procedure get_gravimetric(lobs:Tcdy_obs;p1:pointer; var v:double);
var x1:profil;
    i:integer;
begin
  v:=0;
  x1:=profil(p1^);
  for i:= lobs.avon+1 to lobs.abis do v:=v+x1[i]/candy.sprfl.trd[i];
end;

procedure get_real_value(lobs:Tcdy_obs;p1:pointer; var v:double);
var x1:real;
begin
    x1:=real(p1^);
    v:=x1;
end;

procedure get_double_value(lobs:Tcdy_obs;p1:pointer; var v:double);
begin
    v:=double(p1^);
end;

procedure calc_elcond(lobs:Tcdy_obs;p1:pointer; var v:double);
    var trd, wg, deff, rho ,CSA,a,b,c:double;
       h :double;
        i,ii_1,ii_2:integer;
        x1:profil;
     //   h:real;
    begin
    h:=0;
    a := 0.848;
    b := 2.528;
    c := 0.772;
    ii_1:=lobs.avon;
    ii_2:=lobs.abis;
    x1:=profil(p1^);     // hier bofeu
    for i:= ii_1+1 to ii_2 do
    begin
       if candy.dens_dyn.active then  trd:= candy.dens_dyn.trd[i] else trd:=candy.sprfl.trd[i];
       wg:=x1[i]/(100*trd);        // wg als rel. Volumenanteil  ?? oder doch Masse ??
       candy.sprfl.put_KDeffRho(i,deff,rho);
       CSA := power(WG,a) * power(TRD,b) * c * deff;
       h:=h+ rho/CSA;
    end;
     v:= h/(ii_2-ii_1);
    end;


constructor Tcdy_obs.create(soilprofile:T_soil_profile; soil_o:Tsomdyn);
begin
  o_sprf:=soilprofile;
  o_soil:=soil_o;
end;

destructor Tcdy_obs.done;
begin
 all_obs.Free;
  mv.Close;
  mv.Free;
//dispose(aobs);
end;

procedure Tcdy_obs.initialize;
begin
 all_obs:= TStringlist.Create;
 register_observations(@candy);
end;

procedure Tcdy_obs.rewrite_mltab;
var i:integer;
    mv:tfdtable;
begin
     mv:=tfdtable.Create(nil);
     mv.Connection:=  dbc; //cdy_uif.hqry.Connection;
     mv.TableName:='cdyprop';

     mv.Open;
     for i:=1 to all_obs.Count do
     begin
      aobs:=PanyObs(all_obs.Objects[i-1]);
     if not mv.Locate('item_ix',aobs.info.mix)
     then
      mv.AppendRecord(
     [aobs.info.mix ,
      aobs.info.name ,
      aobs.info.kurzbez,
      aobs.info.Format,
      aobs.info.Typ,
      aobs.info.einheit,
      aobs.info.adpt]
                    );
     end;
     mv.Close;
     mv.Free;
end;
procedure Tcdy_obs.connect(fname_:string; snr, utlg: integer; gis_mode:boolean);
var  ovtab,         //table name
     selcond:string;       // selection condition
begin
   //  fname:=fname_;
     place:='SNR';
     gis:=gis_mode;
    if gis_mode then place:='PATCH' ;


     {  so muß die mgdat vorbereitet werden:
 INSERT INTO cdy_mgdat ( fname, patch, DATUM, M_IX, S0, S1, M_WERT, KORREKTUR, ix, S_WERT )
SELECT cdy_mgdat_1.fname, cdy_mgdat_1.patch, cdy_mgdat_1.DATUM, cdy_mgdat_1.M_IX, cdy_mgdat_1.S0, cdy_mgdat_1.S1, cdy_mgdat_1.M_WERT, cdy_mgdat_1.KORREKTUR, cdy_mgdat_1.ix, cdy_mgdat_1.S_WERT
FROM cdy_mgdat_1
ORDER BY cdy_mgdat_1.patch, cdy_mgdat_1.DATUM, cdy_mgdat_1.S0, cdy_mgdat_1.KORREKTUR;
 }

      if gis_mode then
      begin
       ovtab:='cdy_mgdat' ;
       selcond:= ' patch='+inttostr(snr);
      end
        else
      begin
        ovtab:='cdy_msdat';
        selcond:= ' snr='+inttostr(snr)+' and utlg='+inttostr(utlg);
      end;
      qadpt:=tfdquery.create(nil);
     qadpt.Connection:=dbc;//allg_parm.Connection;
     qadpt.SQL.Clear;
     qadpt.SQL.Add(' select * from '+ovtab+' where not korrektur='+''''+'N'+''''+' and fname='+''''+fname_+''''+' and '+selcond);
     qadpt.SQL.Add(' order by DATUM ');
     qadpt.Open;
     qadpt.First;
     adate:= qadpt.FieldByName('DATUM').AsDatetime;
     a_tag:=dayoftheyear( adate);
     a_jahr:=yearof(adate);
     n_adapt:=qadpt.RecordCount;

     // preparation of the table to store simulation results for the given records
     mv:=tfdtable.Create(nil);
     mv.Connection:=dbc;//allg_parm.Connection;
     if gis_mode then mv.TableName:='cdy_mgdat' else mv.TableName:='cdy_msdat';
     mv.IndexName:='cdysim';
     mv.Filter:='fname='+''''+fname_+''''+' and ' +selcond  ;
     {
    if gis_mode then mv.Filter:=mv.Filter+ ' and patch='+inttostr(snr)
                else mv.Filter:=mv.Filter+  ' and SNR='+inttostr(snr)+' and UTLG='+inttostr(utlg);
      }
     mv.Filter:=mv.Filter+  ' and KORREKTUR='+''''+'N'+'''';
     mv.Filtered:=true;
     mv.Open;
     mv.First;
     mw_ok:=mv.RecordCount>0;
     if mw_ok then
     begin
       asnr :=mv.FieldByName(place).AsString;
       if gis then autlg:='0' else autlg:=mv.FieldByName('UTLG').AsString;
       adate:= mv.FieldByName('DATUM').AsDatetime;
       _tag:=dayoftheyear( adate);
       _jahr:=yearof(adate);
     end;
end;



procedure Tcdy_obs.get_adaptation(var mix: Integer;  var s0: Integer; var s1: Integer; var value: double; var adpt: Boolean);
 var
    idx:integer;
    hs :string;
begin
   if qadpt.eof then
   begin
     adpt:=false;
     exit;
   end;

   idx:=qadpt.fieldbyname('M_IX').AsInteger;
   mix:=idx;
//   prop^.show(idx,cls,mkl);
//   merkmal:=cls+':'+mkl;
   s0:=qadpt.fieldbyname('S0').asinteger;
   s1:=qadpt.fieldbyname('S1').asinteger;
   hs:=qadpt.fieldbyname('KORREKTUR').asstring;
   adpt:=(HS='J') or (HS='Y');
   if adpt then    value:=qadpt.fieldbyname('M_WERT').asfloat
           else    value:=-999;
end;

procedure Tcdy_obs.get_info(var mix: Integer;  var s0: Integer; var s1: Integer; var value: double; var adpt: Boolean);
 var
    idx:integer;
    hs :string;
begin
   idx:=mv.fieldbyname('M_IX').AsInteger;
   mix:=idx;
//   prop^.show(idx,cls,mkl);
//   merkmal:=cls+':'+mkl;
   s0:=mv.fieldbyname('S0').asinteger;
   s1:=mv.fieldbyname('S1').asinteger;
   hs:=mv.fieldbyname('KORREKTUR').asstring;
   adpt:=(HS='J') or (HS='Y');
   if adpt then    value:=mv.fieldbyname('M_WERT').asfloat
            else    value:=-999;
end;


procedure Tcdy_obs.skip(var ok:boolean;var ds: Tdataset; var dd,yy:integer);
var a_date:tdatetime;
begin
 ok:= not( ds.eof);
 if ok  then
  begin
  ds.Next;
   if not gis
   then ok:=not ds.eof and ((asnr=ds.FieldByName(place).AsString)and ( autlg=ds.FieldByName('UTLG').AsString) )
   else ok:=not ds.eof and (asnr=ds.FieldByName(place).AsString);
  end;
  if ok  then
  begin
    a_date:= ds.FieldByName('DATUM').AsDatetime;
   // _tag
   dd:=dayoftheyear( a_date);
   // _jahr
    yy:=yearof(a_date);
 //   ok:= (tag=stag) and (jahr=sjahr);
  end;
end;

procedure Tcdy_obs.check(t: Integer; j: Integer; var ok: Boolean; var ds:Tdataset);
var dat:string;
begin
  dat:=essdatum(t,j);
 ///? ds.FieldByName('DATUM').AsString;
  ok:=false;
  if mw_ok then
  begin
   ok:=true;
   while ( ok and ( _jahr<j )) do
   begin
   skip(ok,ds,_tag,_jahr);
   end;
   if _jahr=j then
   begin
    while ( ok and (_tag<t) and (_jahr=j)) do skip(ok,ds,_tag,_jahr);
   end;
   ok:= ( ok and (t=_tag)and(j=_jahr)) ;
 end;
end;


procedure Tcdy_obs.acheck(t: Integer; j: Integer; var ok: Boolean; var ds:Tdataset);
var dat:string;
begin
  dat:=essdatum(t,j);
//  mv.FieldByName('DATUM').AsString;
///?  ds.FieldByName('DATUM').AsString;
  ok:=false;
  if mw_ok then
  begin
   ok:=true;
   while(( a_jahr<j )and ok) do skip(ok,ds,a_tag,a_jahr);
   if a_jahr=j then
   begin
    while ((a_tag<t) and (a_jahr=j) and ok) do skip(ok,ds,a_tag,a_jahr);
   end;
   ok:=ok and (t=a_tag)and(j=a_jahr);
 end;
end;

procedure Tcdy_obs.adapt_state( ast:sysstat; msglv:integer);
var a_item:integer;
     mw_da:boolean;
begin
// messwert zu verarbeiten ?
  amsg_level:=msglv;
  acheck(ast.ks.tag,ast.ks.jahr,mw_da,Tdataset(qadpt));
  adpt_cdy:=false;
  while mw_da do     {alle Sätze für diesen Tag abarbeiten}
  begin
     get_adaptation(amix,  avon, abis, avalue, adpt_cdy);
     if avon=abis then
     begin
        avon:=avon-1; {Die Zustandsgrößen sind in den Knoten bekannt d.h. bei 0.5; 1.5; 2.5 dm usw}
        abis:=abis+1; {der Wert auf einer 'glatten' Tiefe z.B. 2dm ist der MW aus 1.5[index 2] und 2.5 [index 3]}
     end;
    // process the record !!
    a_item:=all_obs.IndexOf(inttostr(amix));
    if a_item<0 then
    begin
     send_msg(datum(_tag,_jahr)+':unknown observation:'+inttostr(amix),0);
     exit;
    end;
     aobs:=PanyObs(all_obs.Objects[a_item]);
     process_a_obs;
     adpt_cdy:=false;
     skip(mw_da,Tdataset(qadpt),a_tag,a_jahr) ; // next record
     mw_da:= mw_da and ((a_tag=ast.ks.tag) and (a_jahr=ast.ks.jahr));
  end;
end;

procedure Tcdy_obs.process_obs( ast:sysstat; msglv:integer);
var a_item:integer;
     mw_da:boolean;
begin
// messwert zu verarbeiten ?
  amsg_level:=msglv;
  check(ast.ks.tag,ast.ks.jahr,mw_da,Tdataset(mv));
  adpt_cdy:=false;
  while mw_da do     {alle Sätze für diesen Tag abarbeiten}
  begin
     get_info(amix,  avon, abis, avalue, adpt_cdy);
     if avon=abis then
     begin
        avon:=avon-1; {Die Zustandsgrößen sind in den Knoten bekannt d.h. bei 0.5; 1.5; 2.5 dm usw}
        abis:=abis+1; {der Wert auf einer 'glatten' Tiefe z.B. 2dm ist der MW aus 1.5[index 2] und 2.5 [index 3]}
     end;
    // process the record !!
    a_item:=all_obs.IndexOf(inttostr(amix));
    if a_item<0 then
    begin
     send_msg(datum(_tag,_jahr)+':unknown observation:'+inttostr(amix),0);
     exit;
    end;
     aobs:=PanyObs(all_obs.Objects[a_item]);
     process_a_obs;
     skip(mw_da,Tdataset(mv),_tag,_jahr); // next record
     mw_da:= mw_da and ((_tag=ast.ks.tag) and (_jahr=ast.ks.jahr));
  end;


end;

procedure Tcdy_obs.register_(r:PanyObs);
var a_item: integer;
    obs_rec: Pobsrch;
begin
   a_item:=all_obs.AddObject(inttostr(r.info.mix),TObject(r));
   new(obs_rec);
   obs_rec.m_ix:=r.info.mix;
   obs_rec.list_id:=0;
  // search_obs.add(obs_rec);
end;


procedure Tcdy_obs.set_som( von,bis:integer;v:double);
var  hx : double;
     ii : integer;
 new_ci : boolean;
 p1,p2:pointer;

begin
    //teiler:=1+allg_parm.fieldbyname('K_STAB').asfloat/allg_parm.fieldbyname('K_AKT').asfloat;
    // Modus der C-inert Berechnung Beachten
    if (von>5) or (bis>6) then exit;

   // candy ist hier base pointer

   p1:=ptr(NativeUInt(@candy)+aobs.info.offset);
   p2:=ptr(NativeUInt(@candy)+aobs.info.offset2);

   {    if cips.active then     cips.dist_corg(v) else;     }

        begin
         o_sprf.check_inert_carbon(v,new_ci);  // hier wird bei Bedarf (Modus=POF) der inert-wert berechnet
         for ii:= von+1 to bis do
             begin
              hx:=(v-o_sprf.c_inert)*o_sprf.trd[ii]*10000;
              hx:=max(hx,0);
              saeule(p1^)[ii]:= hx/(1+kappa);
              saeule(p2^)[ii]:=hx*kappa/(1+kappa);
             end;
 //        if new_ci then send_msg(datum(k_stat.tag,k_stat.jahr)+'inert Carbon adjusted, Cdec= :'+floattostr(hx)+'/dm',1);
        end;
 end;





procedure Tcdy_obs.process_a_obs;
begin
  // adapt the system
  if adpt_cdy then
              begin
                if amix<>7
                then  adapt(amix,avon,abis,avalue)
                else  set_som(avon,abis,avalue);
               //     if amsg_level>60 then
                send_msg(datum(a_tag,a_jahr)+': cdy state adapted:'+aobs.info.Name,0);
              end
              else   report(amix,avon,abis);        // report the value


end;


procedure Tcdy_obs.report(m_ix,von,bis:integer);
var  _value:double;
     p:pointer;

begin
// get the value   _value
   if aobs.info.basis='cdy'  then   aobs.base_obj:=@candy;        // candy ist ein pointer
   if aobs.info.basis='sprfl'then  aobs.base_obj:=@o_sprf;
   if aobs.info.basis='crop'then   aobs.base_obj:=@candy.cndpfl;
   if aobs.info.basis='yld' then   aobs.base_obj:=@last_yld;
   if aobs.info.basis='soil' then   aobs.base_obj:=@candy.soil;
   if aobs.base_obj=nil then
   begin
     _value:=-99;
     exit;
   end;


   p:=ptr(NativeUInt(aobs.base_obj)+aobs.info.offset);
  try
   aobs.get_data(candy.observ,p,_value);
   except _value:=0;

  end;
// aggregation ? mw oder summe
   if aobs.info.Typ='av' then _value:=_value/(abis-avon)  ;
//   if aobs.info.Typ='fx' then _value:=_value/(abis-avon-1)  ;

// save the value
mv.edit;
mv.fieldbyname('s_wert').AsFloat:=_value;
//if aobs.info.Typ='fx'  then mv.fieldbyname('s0').AsInteger:=abis;

mv.Post;
if amsg_level>60 then
send_msg(datum(_tag,_jahr)+': observation reported:'+aobs.info.Name,0);
end;


procedure Tcdy_obs.adapt(m_ix,von,bis:integer; value:double);
var    i: integer;
       p:pointer;

begin
  if aobs.info.basis='cdy' then  aobs.base_obj:=@candy;        // candy ist ein pointer
 // hier ggf. weitere basis objekte bestimmen
   p:=ptr(NativeUInt(aobs.base_obj)+aobs.info.offset);
   if aobs.info.Typ='su' then value:=value/(bis-von) ;
   if  aobs.info.format='profil' then
    begin
     for i:=von+1 to bis do profil(p^)[i]:= value;
    end;
   if  aobs.info.format='single' then
    begin
     double(p^):=value;
    end;
(* verlegt    if amsg_level>60 then
    send_msg(datum(a_tag,a_jahr)+': cdy adapted:'+aobs.info.Name,0);
    *)
end;

constructor Tanyobs.init(inf:tinforec);
begin
 info:=inf;
 ljahr:=-1;
 n_val:=0;
 sum_val:=0;
 resultat:=0;
end;




procedure Tcdy_obs.register_observations( pcdy:pointer);
var     h_info,a_info      :tinforec;
        o_cdy:Tcndcycl;
begin
// die Messwertliste generieren

//observ.all_obs:= TStringlist.Create;

// alle Messwertobjekte definieren und in die Liste aufnehmen
//o_cdy:=Tcndcycl(pcdy);
o_cdy:=candy;
with h_info do
begin
  name:='?';
  kurzbez:='?';
  mix:=-99;
  einheit:='kg/ha';
  format:='profil';
  adpt:=true;
  faktor:=1;
end;


/// folgende lassen wir sein: ?
///
   //*  doc =74; //'DOC';
  //*  NICO =43; //'NO3N_conc(Sickerwasser)';
(*


                 dm_hp,        {dry matter Hauptprodukt}
               dm_np,        { .. Nebenprodukt}
  *)
  //*  cmin='C_min_sum'; // kum. C-Mineralisierung aus OM in kg/ha
 //*  cmfx='C_min_flx'; // C-Mineralisierung aus OM in kg/ha/d


 //*  ph =44; //'pH';
 //*  KATA =73; //'Katalaseaktivität';
 //*  co2conc=60; //'co2conc';
  //*  marver =66; //'mark.tägl.Versickerung'; //?
 //*  marked =67; //'markiertesWasser';
   //*  NSLD =71; //'letzter-N-Saldo'; {kg/ha}
   // 12, 13, 14 simazin etc.
         // 33, 34 stärke zucker
   //*  wmzMI =38; //'WMZ_MI';
 //*  wmzME =39; //'WMZ_ME';
 //*  wmzMA =40; //'WMZ_MA';
     // 41 Toberfläche
  //*  NVER =15; //'kumm.monatl.N-Austrag';{kg/ha}
 //*  GRWB =16; //'kumm.monatl.Grundwass.bld';{mm}
 //*  NVER_y=17; //'kumm.jährl.N-Austrag';{kg/ha}
 //*  GRWB_y=18; //'kumm.jhrl.Grundwass.bld';{mm}
 //*  nLoss =68; //'kumm.monatl.N-Verlust';




a_info:=h_info;
//* nitrate N          obs_no3n
with a_info do
begin
  name:='nitrate N';  kurzbez:='NO3_N';    mix:=1;      einheit:='kg/ha';
  basis:='cdy';      format:='profil';    typ:='su';    adpt:=true;
// offset:= integer(@o_cdy.s.ks.nin)-integer(@o_cdy);      //
offset:= integer(@candy.s.ks.nin)-integer(@candy);    offset2:=0;
end;
new(obs_no3n,init(a_info));
obs_no3n.get_data:=sum_aggprf;
//candy.observ.
register_(obs_no3n);
// testen       aobs.base_obj:=@candy;
//     p:=ptr(integer({aobs.base_obj}@candy)+ obs_no3n.info.offset);


//* decomposable C         obs_Cdec
with a_info do
begin
  name:='decomposable SOC';     kurzbez:='SOC_dec';    mix:=2;      einheit:='kg/ha';
  basis:='cdy';   format:='profil'; typ:='su'; adpt:=false;
  offset := integer(@candy.s.ks.aos)-integer(@candy);   //integer(@candy.n_offtake. N_upt_ER)-crop_anf;
  offset2:= integer(@candy.s.ks.sos)-integer(@candy)
  end;
new(obs_Cdec,init(a_info));
obs_Cdec.get_data:=sum_aggsaeule;
//candy.observ.
register_(obs_Cdec);

//* amonium N          obs_amnn
with a_info do
begin
  name:='amonium N';          kurzbez:='AMN_N';       mix:=3;    einheit:='kg/ha';
   basis:='cdy';   format:='profil'; typ:='su';       adpt:=true;
  offset:= integer(@candy.s.ks.amn)-integer(@candy);   offset2:= 0;
end;
new(obs_amnn,init(a_info));
obs_amnn.get_data:=sum_aggprf;
//candy.observ.
register_(obs_amnn);

//* Nmin    4
with a_info do
begin
  name:='mineralN';          kurzbez:='MIN_N';       mix:=4; einheit:='kg/ha';
   basis:='cdy';   format:='profil'; typ:='su';       adpt:=false;
  offset := integer(@candy.s.ks.nin)-integer(@candy);
  offset2:= integer(@candy.s.ks.amn)-integer(@candy);;
end;
new(obs_minn,init(a_info));
obs_minN.get_data:=sum_aggprf;
//candy.observ.
register_(obs_minN);

//*Cmic      5
{
 with a_info do
begin
  name:='Cmic';       kurzbez:='C_MIC';       mix:=5; typ:='av';  einheit:='µg/g';
  basis:='cdy';       format:='saeule'; typ:='su';     adpt:=false;
  offset := integer(@candy.s.ks.aos)-integer(@candy);
  offset2:= 0;
end;
new(obs_cmic,init(a_info));
obs_cmic.get_data:=get_cmic;
candy.observ.register_(obs_cmic);
 }
//*Chwl       6
with a_info do
begin
  name:='hotwater soluble C';  kurzbez:='C_HWS'; mix:=6;typ:='av';  einheit:='mg/100g';
    basis:='cdy';   format:='saeule'; typ:='su';    adpt:=false;
  offset := integer(@candy.s.ks.aos)-integer(@candy);
  offset2:= integer(@candy.s.ks.amn)-integer(@candy);
end;
new(obs_chws,init(a_info));
obs_chws.get_data:=get_chws;
//candy.observ.
register_(obs_chws);

//* Corg (%)   7
with a_info do
begin
  name:='SoilOrganicCarbon';  kurzbez:='Corg_conc';   mix:=7;    einheit:='M%';
  basis:='cdy';      format:='saeule';  typ:='--';        adpt:=true;
  offset := integer(@candy.s.ks.aos)-integer(@candy);   //integer(@candy.n_offtake. N_upt_ER)-crop_anf;
  offset2:= integer(@candy.s.ks.sos)-integer(@candy);
end;
new(obs_socconc,init(a_info));
obs_socconc.get_data:=get_socconc;
register_(obs_socconc);


with a_info do
begin
  name:='SOC_stock';  kurzbez:='SOC_stock';    mix:=28;             einheit:='kg/ha';
   basis:='cdy';   format:='saeule';  typ:='--';          adpt:=true;
  offset := integer(@candy.s.ks.aos)-integer(@candy);   //integer(@candy.n_offtake. N_upt_ER)-crop_anf;
  offset2:= integer(@candy.s.ks.sos)-integer(@candy);
end;
new(obs_socstock,init(a_info));
obs_socstock.get_data:=get_socstock;
register_(obs_socstock);

//* soil water   8
with a_info do
begin
  name:='soil water';  kurzbez:='soil_w';   mix:=8;     einheit:='mm';
     basis:='cdy';   format:='profil';     typ:='su'; adpt:=false;
  offset:= integer(@candy.s.ks.bofeu)-integer(@candy);   //integer(@candy.n_offtake. N_upt_ER)-crop_anf;
  offset2:=0;
  end;
new(obs_soilwas,init(a_info));
obs_soilwas.get_data:=sum_aggprf;
register_(obs_soilwas);

//* soil temperature
with a_info do
begin
  name:='soil temperature';  kurzbez:='soil_temp';   mix:=9;  einheit:='°C';
    basis:='cdy';   format:='profil';   typ:='av'; adpt:=true;
  offset:= integer(@candy.s.ks.botem)-integer(@candy);   //integer(@candy.n_offtake. N_upt_ER)-crop_anf;
    offset2:=0;
  end;
new(obs_soiltem,init(a_info));
obs_soiltem.get_data:=sum_aggprf;
register_(obs_soiltem);

 a_info:=h_info;
//* soil water  VOL
with a_info do
begin
  name:='SoilMoisture(VOL)';       kurzbez:='soilmoistV';   mix:=10;   einheit:='VOL%';
    basis:='cdy';   format:='profil'; typ:='av';                            adpt:=true;
  offset:= integer(@candy.s.ks.bofeu)-integer(@candy);   //integer(@candy.n_offtake. N_upt_ER)-crop_anf;
    offset2:=0;
  end;
new(obs_soilmoistV,init(a_info));
obs_soilmoistV.get_data:=sum_aggprf;
//candy.observ.
register_(obs_soilmoistV);

//* soil water  M
with a_info do
begin
  name:='SoilMoisture(M)';   kurzbez:='soilmoistM';   mix:=11;   einheit:='M%';
    basis:='cdy'; format:='profil';       typ:='av';       adpt:=false;
  offset:= integer(@candy.s.ks.bofeu)-integer(@candy);   //integer(@candy.n_offtake. N_upt_ER)-crop_anf;
  offset2:=0;
end;
new(obs_soilmoistM,init(a_info));
 obs_soilmoistM.get_data:= get_gravimetric;
//candy.observ.
register_(obs_soilmoistM);

 //*  crep_flx=23; //Crepflx' ;
with a_info do
begin
  name:='CrepFlx';              kurzbez:='CrepFlx';    mix:=23;       einheit:='kg/ha/d';
//    basis:='cdy';format:='saeule'; typ:='su' ; adpt:=false;
//  offset:= integer(@o_soil.dcrep)-integer(@o_soil);   offset2:=0; //
  basis:='cdy';format:='single'; typ:='--' ; adpt:=false;
  offset:= integer(@candy.s.c_rep)-integer(@candy);   offset2:=0;

end;
new(obs_crepflx,init(a_info));
obs_crepflx.get_data:=get_real_value;
//candy.observ.
register_(obs_crepflx);

//*  at =25; //'Transpiration';
 with a_info do
begin
  name:='transpiration';    kurzbez:='transp';       mix:=25;    einheit:='mm';
  basis:='cdy';             format:='single';        typ:='--';  adpt:=false;
  offset:= integer(@candy.s.wett.trans)-integer(@candy);         offset2:=0;
end;
new(obs_transpi,init(a_info));
obs_transpi.get_data:=get_real_value;
//candy.observ.
register_(obs_transpi);

 //*  tension=42; //'tension';
 {
 with a_info do
begin
  name:='water potential';  kurzbez:='tensio';       mix:=42;    einheit:='hPa';
  basis:='cdy';             format:='profil';        typ:='av'; adpt:=false;
  offset:= integer(@candy.s.tension)-integer(@candy);         offset2:=0;
end;
new(obs_tension,init(a_info));
obs_tension.get_data:=sum_aggprf;
candy.observ.register_(obs_tension);
  }
  //*  aktver=24; //'täglicheVersickerung';  GWB ?    s.grndwssrbldng;
   with a_info do
begin
  name:='seepage to groundw';  kurzbez:='GW_seep';   mix:=24;    einheit:='mm';
  basis:='cdy';               format:='single';      typ:='--';  adpt:=false;
  offset:= integer(@candy.s.grndwssrbldng)-integer(@candy);      offset2:=0;
end;
new(obs_gwb,init(a_info));
obs_gwb.get_data:=get_real_value;
//candy.observ.
register_(obs_gwb);


//*  AWZT =45; //'akt.Wurzeltiefe'; {dm}
   with a_info do
begin
  name:='ActRootDpth';  kurzbez:='actRtDpth';       mix:=45;    einheit:='dm';
  basis:='cdy';             format:='single';        typ:='--';  adpt:=false;
  offset:= integer(@candy.s.ks.wutief)-integer(@candy);         offset2:=0;
end;
new(obs_RtDpth,init(a_info));
obs_RtDpth.get_data:=get_real_value;
//candy.observ.
register_(obs_RtDpth);

 //*  ABGR =46; //'akt.Bedeckungsgrad'; {1}
 with a_info do
begin
  name:='ActCropCover';  kurzbez:='actCover';        mix:=46;    einheit:='-';
  basis:='cdy';             format:='single';        typ:='--';  adpt:=false;
  offset:= integer(@candy.s.ks.bedgrd)-integer(@candy);         offset2:=0;
end;
new(obs_AcCroCov,init(a_info));
obs_AcCroCov.get_data:=get_real_value;
//candy.observ.
register_(obs_AcCroCov);

 //*  pet =47; //'pot.Evapotranspiration';
with a_info do
begin
  name:='PotEvapTransp';  kurzbez:='PET';        mix:=47;    einheit:='mm';
  basis:='cdy';             format:='single';        typ:='--';  adpt:=false;
  offset:= integer(@candy.s.wett.pet)-integer(@candy);         offset2:=0;
end;
new(obs_pet,init(a_info));
obs_pet.get_data:=get_real_value;
//candy.observ.
register_(obs_pet);

 //*  niedk =48; //'korr.Niederschlag';
 with a_info do
begin
  name:='corrected Rain';  kurzbez:='corRain';        mix:=48;    einheit:='mm';
  basis:='cdy';             format:='single';        typ:='--';  adpt:=false;
  offset:= integer(@candy.s.wett.niedk)-integer(@candy);         offset2:=0;
end;
new(obs_pet,init(a_info));
obs_pet.get_data:=get_real_value;
//candy.observ.
register_(obs_pet);

 //*  mlc_n =50; //'N-Menge_Mulch';
 with a_info do
begin
  name:='NinMulchLayer';          kurzbez:='NtMulch';       mix:=50;        adpt:=false;
  format:='single'; typ:='--';   basis:='cdy'; einheit:='kg/ha';
  offset:= integer(@candy.s.n_mulch)-integer(@candy);   offset2:= 0;
end;
new(obs_nmulch,init(a_info));
obs_nmulch.get_data:=sum_aggprf;
//candy.observ.
register_(obs_nmulch);
 //*  mlc_c =51;//'C-Menge_Mulch';
 with a_info do
begin
  name:='CinMulchLayer';          kurzbez:='C_Mulch';       mix:=51;        adpt:=false;
  format:='single'; typ:='--';   basis:='cdy'; einheit:='kg/ha';
  offset:= integer(@candy.s.c_mulch)-integer(@candy);   offset2:= 0;
end;
new(obs_cmulch,init(a_info));
obs_cmulch.get_data:=sum_aggprf;
//candy.observ.
register_(obs_cmulch);

 //*  wmz =52; //'WMZ';
  with a_info do
begin
  name:='BiolActTime';  kurzbez:='BAT';       mix:=52;    einheit:='d';
  basis:='cdy';             format:='saeule';        typ:='av';  adpt:=false;
  offset:= integer(@candy.s.wmz)-integer(@candy);         offset2:=0;
end;
new(obs_bat,init(a_info));
obs_bat.get_data:=sum_aggprf;
//candy.observ.
register_(obs_bat);

 //*  aet_day=53; //'AET';
with a_info do
begin
  name:='act.EvapoTransp';    kurzbez:='AET';       mix:=53;    einheit:='mm';
  basis:='cdy';             format:='single';        typ:='--'; adpt:=false;
  offset:= integer(@candy.s.aet)-integer(@candy);         offset2:=0;
end;
new(obs_aet,init(a_info));
obs_aet.get_data:=get_real_value;
//candy.observ.
register_(obs_aet);

 //*  perko =54; //'Wasserabfluss(Schicht)';
  with a_info do
begin
  name:='water flux from layer';  kurzbez:='Wflux_Lay';       mix:=54;    einheit:='mm';
  basis:='cdy';             format:='profil';        typ:='fx';   adpt:=false;
  offset:= integer(@candy.s.perko)-integer(@candy);         offset2:=0;
end;
new(obs_wperko,init(a_info));
obs_wperko.get_data:=sum_aggprf;
//candy.observ.
register_(obs_wperko);

 //*  nConc =55; //'N_conc(Bodenlösung)';   nitrateNConc
with a_info do
begin
  name:='Nit.N.Conc';    kurzbez:='NO3N_Conc';    mix:=55; einheit:='mgN/L';
  basis:='cdy';   format:='profil';  typ:='--';        adpt:=false;   faktor:=100;
  offset:= integer(@candy.s.ks.nin)-integer(@candy);
  offset2:= integer(@candy.s.ks.bofeu)-integer(@candy);
end;
new(obs_no3ncon,init(a_info));
obs_no3ncon.get_data:=get_concw;
//candy.observ.
register_(obs_no3ncon);

//*  n_u_lay=56; //'N_Upt_Layer' ;
with a_info do
begin
  name:='N upt from layer';  kurzbez:='Nupt_Lay';       mix:=56;    einheit:='kg/ha';
  basis:='cdy';             format:='profil';           typ:='su';  adpt:=false;
  offset:= integer(@candy.s.n2crop)-integer(@candy);      offset2:=0;    faktor:=1;
end;
new(obs_NuptLay,init(a_info));
obs_NuptLay.get_data:=sum_aggprf;
//candy.observ.
register_(obs_NuptLay);

//*  W_u_lay=57; //'Water_Upt_Layer' ;
with a_info do
begin
  name:='W upt from layer';  kurzbez:='Wupt_Lay';       mix:=57;    einheit:='mm';
  basis:='cdy';             format:='profil';           typ:='su'; adpt:=false;
  offset:= integer(@candy.s.entz)-integer(@candy);      offset2:=0;
end;
new(obs_WuptLay,init(a_info));
obs_WuptLay.get_data:=sum_aggprf;
//candy.observ.
register_(obs_WuptLay);

 //*  nleachl=58; //'N_leach(Schicht)';
  with a_info do
begin
  name:='N flux at layer';  kurzbez:='Nflux_Lay';       mix:=58;    einheit:='kg/ha';
  basis:='cdy';             format:='profil';          typ:='fx'; adpt:=false;
  offset:= integer(@candy.s.nllay)-integer(@candy);         offset2:=0;
end;
new(obs_Nperko,init(a_info));
obs_Nperko.get_data:=sum_aggprf;
//candy.observ.
register_(obs_Nperko);

 //*  n_crp =69; //'N-Offtake(Crop)';
  with a_info do
begin
  name:='YldNofftake ';  kurzbez:='YldNoff';       mix:=69;    einheit:='kg/ha';
  basis:='yld';         format:='single';       typ:='--'; adpt:=false;
  offset:= integer(@o_yld.n_crop)-integer(@o_yld);         offset2:=0;
end;
new(obs_yldnoff,init(a_info));
obs_yldnoff.get_data:=get_real_value;
register_(obs_yldnoff);

 //*  drain_w=70; //'WasserAbf_Drain';
   with a_info do
begin
  name:='DrainWaterFlow';          kurzbez:='drainW';       mix:=70;  einheit:='mm';
    basis:='cdy';  format:='single'; typ:='--';             adpt:=false;
  offset:= integer(@candy.s.drain_flow)-integer(@candy);   offset2:= 0;
end;
new(obs_wdrain,init(a_info));
obs_wdrain.get_data:=sum_aggprf;
register_(obs_wdrain);

 //*  drain_n=72; //'Nit_N_Abf_Drain';
   with a_info do
begin
   name:='DrainNitFlow';  kurzbez:='drainN';   mix:=72;      einheit:='kg/ha';
   basis:='cdy';         format:='single';     typ:='--';    adpt:=false;
  offset:= integer(@candy.s.n_drain)-integer(@candy);   offset2:= 0;
end;
new(obs_ndrain,init(a_info));
obs_ndrain.get_data:=sum_aggprf;
register_(obs_ndrain);

//*  hptm =26; //'TM-Ertrag_HP';  {kg/ha}
 with a_info do
begin
  name:='DM-Yld-Mp ';  kurzbez:='DMYldMp';       mix:=26;    einheit:='kg/ha';
  basis:='yld';         format:='single';       typ:='--'; adpt:=false;
  offset:= integer(@o_yld.dm_hp)-integer(@o_yld);         offset2:=0;
end;
new(obs_dmyldmp,init(a_info));
obs_dmyldmp.get_data:=get_real_value;
register_(obs_dmyldmp);

 //*  nptm =27; //'TM-Ertrag_NP';  {kg/ha}
      with a_info do
begin
  name:='DM-Yld-byP ';  kurzbez:='DMYldbyP';       mix:=27;    einheit:='kg/ha';
  basis:='yld';         format:='single';       typ:='--'; adpt:=false;
  offset:= integer(@o_yld.dm_np)-integer(@o_yld);         offset2:=0;
end;
new(obs_dmyldbp,init(a_info));
obs_dmyldbp.get_data:=get_real_value;
register_(obs_dmyldbp);

 //*  nyhp =29; //'N-Menge_HP';
     with a_info do
begin
  name:='N-Yld-Mp ';  kurzbez:='NYldMp';       mix:=29;    einheit:='kg/ha';
  basis:='yld';         format:='single';       typ:='--'; adpt:=false;
  offset:= integer(@o_yld.n_yld_hp)-integer(@o_yld);         offset2:=0;
end;
new(obs_nyldmp,init(a_info));
obs_nyldmp.get_data:=get_real_value;
register_(obs_nyldmp);

 //*  nynp =30; //'N-Menge_NP';
     with a_info do
begin
  name:='N-Yld-byP ';  kurzbez:='NYldbyP';       mix:=30;    einheit:='kg/ha';
  basis:='yld';         format:='single';       typ:='--'; adpt:=false;
  offset:= integer(@o_yld.n_yld_np)-integer(@o_yld);         offset2:=0;
end;
new(obs_nyldbp,init(a_info));
obs_nyldbp.get_data:=get_real_value;
register_(obs_nyldbp);

 //*  cyhp =31; //'C-Menge_HP';
     with a_info do
begin
  name:='C-Yld-Mp ';  kurzbez:='CYldMp';       mix:=31;    einheit:='kg/ha';
  basis:='yld';         format:='single';       typ:='--'; adpt:=false;
  offset:= integer(@o_yld.c_yld_hp)-integer(@o_yld);         offset2:=0;
end;
new(obs_cyldmp,init(a_info));
obs_cyldmp.get_data:=get_real_value;
register_(obs_cyldmp);

 //*  cynp =32; //'C-Menge_NP';
     with a_info do
begin
  name:='C-Yld-byP ';  kurzbez:='CYldbyP';       mix:=32;    einheit:='kg/ha';
  basis:='yld';         format:='single';       typ:='--'; adpt:=false;
  offset:= integer(@o_yld.c_yld_np)-integer(@o_yld);         offset2:=0;
end;
new(obs_cyldbp,init(a_info));
obs_cyldbp.get_data:=get_real_value;
register_(obs_cyldbp);



 //*  noff =20; //'oberird.N-Aufnahmed.Pfl';{kg/ha}
      with a_info do
begin
  name:='N_yield';  kurzbez:='N_yield';       mix:=20;    einheit:='kg/ha';
  basis:='yld';     format:='single';        typ:='--'; adpt:=false;
  offset:= integer(@o_yld.n_crop)-integer(@o_yld);         offset2:=0;
end;
new(obs_noffyld,init(a_info));
obs_noffyld.get_data:=get_real_value;
register_(obs_noffyld);

 //*  npnat =21; //'Naturalertrag_NP';    o_cdy._plant.ed.nat_yld_np; //np
     with a_info do
begin
  name:='NatYldByp';  kurzbez:='NatYldByp';       mix:=21;    einheit:='dt/ha';
  basis:='yld';         format:='single';         typ:='--';  adpt:=false;
  offset:= integer(@o_yld.nat_yld_np)-integer(@o_yld);         offset2:=0;
end;
new(obs_natyldbp,init(a_info));
obs_natyldbp.get_data:=get_real_value;
register_(obs_natyldbp);



 //*  hpnat =22; //'Naturalertrag_HP';
     with a_info do
begin
  name:='NatYldMP';  kurzbez:='NatYldMP';       mix:=22;    einheit:='dt/ha';
  basis:='yld';         format:='single';       typ:='--'; adpt:=false;
  offset:= integer(@o_yld.nat_yld_hp)-integer(@o_yld);         offset2:=0;
end;
new(obs_natyldmp,init(a_info));
obs_natyldmp.get_data:=get_real_value;
register_(obs_natyldmp);

 //*  ONTO =35; //'Entwicklungsstadium(DC)';      mwert:=cndpfl^.ontogenese;
       with a_info do
begin
  name:='crop DC state ';  kurzbez:='crop DC';       mix:=35;    einheit:='-';
  basis:='crop';             format:='single';       typ:='--'; adpt:=false;
  offset:= integer(@candy.cndpfl.ontogenese)-integer(@candy.cndpfl);         offset2:=0;
end;
new(obs_dc,init(a_info));
obs_dc.get_data:=get_real_value;
register_(obs_dc);


  //*  lai =49; //'LAI';
      with a_info do
begin
  name:='LeafAreaIndex ';  kurzbez:='LAI';       mix:=49;    einheit:='kg/ha';
  basis:='crop';             format:='single';   typ:='--';  adpt:=false;
  offset:= integer(@candy.cndpfl.lai)-integer(@candy.cndpfl);         offset2:=0;
end;
new(obs_lai,init(a_info));
obs_lai.get_data:=get_real_value;
register_(obs_lai);

 //*  a_tm_hp=36;//'akt.TM_HP';
    with a_info do
begin
  name:='actDM_MainProd ';  kurzbez:='aDM_MnPr';     mix:=36;    einheit:='kg/ha';
  basis:='crop';             format:='single';       typ:='--';  adpt:=false;
  offset:= integer(@candy.cndpfl.a_tm_hp)-integer(@candy.cndpfl);         offset2:=0;
end;
new(obs_admmp,init(a_info));
obs_admmp.get_data:=get_real_value;
register_(obs_admmp);

 //*  a_tm_np=37;//'akt.TM_NP';
    with a_info do
begin
  name:='actDM_ByProd ';  kurzbez:='aDM_ByPr';       mix:=37;    einheit:='kg/ha';
  basis:='crop';             format:='single';       typ:='--';  adpt:=false;
  offset:= integer(@candy.cndpfl.a_tm_np)-integer(@candy.cndpfl);         offset2:=0;
end;
new(obs_admbp,init(a_info));
obs_admbp.get_data:=get_real_value;
register_(obs_admbp);

 //*  a_tm_pf=59; //'akt.TM_PF';
   with a_info do
begin
  name:='actDMcrop ';  kurzbez:='aCropDM';       mix:=59;    einheit:='kg/ha';
  basis:='crop';             format:='single';       typ:='--'; adpt:=false;
  offset:= integer(@candy.cndpfl.a_tm_tot)-integer(@candy.cndpfl);         offset2:=0;
end;
new(obs_admcr,init(a_info));
obs_admcr.get_data:=get_real_value;
register_(obs_admcr);


 //*  n2o =75; //'N2O_N' ;    mwert:=soil.gflux.n2o;
 with a_info do
begin
  name:='N2O_N';   kurzbez:='NGasLoss';      mix:=75;     einheit:='kg/ha/d';
  basis:='soil';  format:='single';      typ:='--'; adpt:=false;
  offset:= integer(@o_soil.n2oflux)-integer(@o_soil);   offset2:=0;

 end;
new(obs_n2o,init(a_info));
obs_n2o.get_data:=get_double_value;
register_(obs_n2o);


 with a_info do
begin
  name:='NGasLoss';   kurzbez:='NGasLoss';      mix:=76;     einheit:='kg/ha/d';
//  basis:='soil';  format:='single';      typ:='--'; adpt:=false;
 // offset:= integer(@o_soil.gflux.n2o)-integer(@o_soil);   offset2:=0;
 basis:='cdy';  format:='single';      typ:='--'; adpt:=false;
 offset:= integer(@candy.s.ngfv)-integer(@candy);   offset2:=0;

//  h.usp:=pointer(integer(@o_soil)+offset);
end;
new(obs_n2o,init(a_info));
obs_n2o.get_data:=get_real_value;
register_(obs_n2o);

 //*  fkap =61; //'fieldcapacity';
with a_info do
begin
  name:='field capacity';  kurzbez:='FieldCap';      mix:=61;    einheit:='VOL%';
  basis:='sprfl';             format:='profil';        typ:='av'; adpt:=false;
  offset:= integer(@o_sprf.fkap)-integer(@o_sprf);   offset2:=0;
end;
new(obs_fcap,init(a_info));
obs_fcap.get_data:=sum_aggprf;
register_(obs_fcap);

//*  pwp =62; //'permanentwiltingpoint';
with a_info do
begin
  name:='perm. wilting point';  kurzbez:='PWP';      mix:=62;    einheit:='VOL%';
  basis:='sprfl';             format:='profil';        typ:='av'; adpt:=false;
  offset:= integer(@o_sprf.pwp)-integer(@o_sprf);   offset2:=0;
end;
new(obs_pwp,init(a_info));
obs_pwp.get_data:=sum_aggprf;
register_(obs_pwp);

 //*  TRD =63; //'bulkdensity';
with a_info do
begin
  name:='bulk density';  kurzbez:='BD';      mix:=63;    einheit:='g/cm³';
  basis:='sprfl';             format:='profil';        typ:='av'; adpt:=false;
  offset:= integer(@o_sprf.trd)-integer(@o_sprf);   offset2:=0;
end;
new(obs_bd,init(a_info));
obs_bd.get_data:=sum_aggprf;
register_(obs_bd);

 //*  TSD =64; //'particledensity';
with a_info do
begin
  name:='particle density';  kurzbez:='PD';      mix:=64;    einheit:='g/cm³';
  basis:='sprfl';             format:='profil';        typ:='av'; adpt:=false;
  offset:= integer(@o_sprf.tsd)-integer(@o_sprf);   offset2:=0;
end;
new(obs_pd,init(a_info));
obs_pd.get_data:=sum_aggprf;
register_(obs_pd);

 //*  pvol =65; //'porevolume';
with a_info do
begin
  name:='pore volume';  kurzbez:='P_VOL';      mix:=65;    einheit:='VOL%';
  basis:='sprfl';             format:='profil';        typ:='av'; adpt:=false;
  offset:= integer(@o_sprf.pvol)-integer(@o_sprf);   offset2:=0;
end;
new(obs_pvol,init(a_info));
obs_pvol.get_data:=sum_aggprf;
register_(obs_pvol);

 //*  ohm='El_Res'; // spez. elektrischer Widerstand in einer geg. Tiefe
 with a_info do
begin
  name:='el_resistivity';  kurzbez:='elRes';  mix:=99;  einheit:='S';
  format:='profil';        basis:='cdy';     typ:='--';  adpt:=false;
  offset:= integer(@candy.s.ks.bofeu)-integer(@candy);    offset2:=0;
end;
new(obs_elres,init(a_info));
obs_elres.get_data:= calc_elcond;
register_(obs_elres);




end;

begin
//new(observ,init);
end.

