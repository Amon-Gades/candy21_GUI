{ implements result objects related at @link(gis_rslt) }
unit cnd_rs_2;
interface
uses gis_rslt,cdyspsys ,cnd_util,cnd_vars,cdysomdyn,cdywett,soilprf3;

type   {abgeleitete Objekte}
         pnmin_res =^tnmin_res;
        tnmin_res =object(tvv_rslt)
                      constructor init(inf:tinforec;i,j:byte);
                      destructor  done;
                      procedure   get_value; virtual;
                   end;
        psurf_w_res =^tsurf_w_res; // water storage above soil
        tsurf_w_res =object(tsv_rslt)
                      constructor init(inf:tinforec);
                      destructor  done;
                      procedure   get_value; virtual;
                   end;

        pnmtt_res =^tnmtt_res;
        tnmtt_res =object(tvt_rslt)
                      constructor init(inf:tinforec);
                      destructor  done;
                      procedure   get_value; virtual;
                   end;
        pcums_res =^tcums_res;
        tcums_res =object(tsv_rslt)
                      constructor init(inf:tinforec);
                      destructor  done;
                      procedure   get_value; virtual;
                   end;
        pcops_res =^tcops_res;
        tcops_res =object(tsv_rslt)
                      constructor init(inf:tinforec);
                      destructor  done;
                      procedure   get_value; virtual;
                   end;

        pnobs_res =^tnobs_res;
        tnobs_res =object(tsv_rslt)
                      constructor init(inf:tinforec);
                      destructor  done;
                      procedure   get_value; virtual;
                   end;
        pnops_res =^tnops_res;
        tnops_res =object(tsv_rslt)
                      constructor init(inf:tinforec);
                      destructor  done;
                      procedure   get_value; virtual;
                   end;
       pwmz_res =^twmz_res;
       twmz_res=object(tsv_rslt)
                      constructor init(inf:tinforec);
                      destructor  done;
                      procedure   get_value; virtual;
                   end;

        pdummy_res=^tdummy_res;
        tdummy_res=object(anyrslt)
                      constructor init(inf:tinforec);
                      destructor  done;
                      procedure   get_value; virtual;
                   end;

       pcrop_res=^tcrop_res;
       tcrop_res=object(anyrslt)
                      crop_res_rec :pointer;
                      constructor init(inf:tinforec);
                      destructor  done;
                      procedure   get_value; virtual;
                   end;


       pwt_rslt=^Twt_Rslt;
       Twt_Rslt=object(tsv_rslt)
                 wetter_pointer:pointer;   // Adresse des Sim-Wetter-Records
                 constructor init( inf :tinforec);
                 destructor  done;
                 procedure   get_value;  virtual; {legt Einzelwert auf value ab}
                end;

       pdd_rslt=^tdd_rslt;
tdd_rslt=object(tsv_rslt)
           procedure get_value; virtual;
          end;

       p_cv_res =^t_cv_res;
       t_cv_res=object(tsv_rslt)     procedure   get_value; virtual;     end;
       p_gflux_res=^t_gflux_res;
       t_gflux_res=object(tsv_rslt)  procedure   get_value; virtual;     end;
       p_ndep_res=^t_ndep_res;
       t_ndep_res=object(tsv_rslt)  procedure   get_value; virtual;     end;


var
    ndep_res:p_ndep_res;
    dummy:pdummy_res;
    n2o_res,
    no_res,
    n2_res,
    co2_res:p_gflux_res;
 //K   co2_mrs:pagdo_res;
    cv_res:p_cv_res;
    nobs_res:pnobs_res;
    nops_res:pnops_res;
    cums_res:pcums_res;
    cops_res:pcops_res;
    wmz_res :pwmz_res;
    ntt_res :pnmtt_res;
    wdf_res,
    ndf_res,
    gwb_res,
    wbl_res,
    nlc_res,
    ncr_res,
    ngv_res,
    nbo_res,
    nmn_res,
    nupt_res,
    nh4v_res,         {Summe NH4-Verluste}
    n_system_res,     {Summe N_gesamt im System}
    n_min_system_res, {Summe N_mineral. im System}
    globrad_res,      {globalstrahlung}
    air_temp_res,     {Lufttemperatur}
    k_nieds_m_res,    {Summe korrig. Niederschlag}
    k_pet_m_res,      {Summe potentielle Evapotransp. für Resultatausg.}
    k_aet_m_res,      {Summe aktuelle Evapotransp. für Resultatausg.}
    k_trans_m_res,    {Summe Transpiration}
    crep_res,
    ni_min_res,
    ni_org_res,
    ni_sym_res: psv_rslt;
    nied_res: pwt_rslt;
    aos_res,
    sos_res,
    bw10_res,
    bw3_res,
    bt3_res            :pvv_rslt;
    bwt_res,
    nmt_res            :pvt_rslt;
    n03_res,
    n36_res,
    n61_res :pnmin_res;
//    k_infilt_m_res: psv_rslt;   {Monatssumme des infiltr. Niederschlags}
    k_bedgrd_m_res: psv_rslt;   {"Monatssumme" des Bedeckungsgrades als Tagesäquivalent}
    k_nieds_m:      psv_rslt;   {Monatssumme des korrigierten Niederschlags}
    surf_w_res:psurf_w_res;

    n_offt,
    n_uptk,
    n_kopp,
    n_ewr    : pcrop_res;

    dd_kfc,
    dd_kwp,
    dd_kpv,
    dd_trd,
    dd_bi,
    dd_gefstab,
    dd_height_ap : pdd_rslt;

    a_info   :tinforec;
    h:sysstat;  {Hilfe zur offset-Ermittlung}
    p1,p2:pointer;
    crop_anf,        //Anfang des Croprec
 //K   cips_anf,       // Anfang des Cipsrec
    ofs:integer;    // Anfang des Statusrecords

    procedure initialize_results;

implementation

 procedure tdd_rslt.get_value;
var p:^real;
begin
 if candy.dens_dyn<>NIL
   then
   begin  p:=ptr(NativeUInt(@candy.dens_dyn.active)+info.offset);
          value:=p^;
   end else value:=-999;
end;

constructor twt_rslt.init(inf:tinforec);
begin
 inherited init(inf);
 rslt_type:=101;
 wetter_pointer:=@awo.swet;    // Adresse des wetterrecords !
end;

procedure twt_rslt.get_value;
var p:^real;
begin
 p:=ptr(NativeUInt(@candy.awo.swet)+info.offset);
 value:=p^;
end;


destructor twt_rslt.done;
begin
end;



constructor Tcrop_res.init(inf: TinfoRec);
begin
  inherited init(inf);
  crop_res_rec:=@candy.n_offtake;
  rslt_type:=100;
end;

procedure tcrop_res.get_value;
var p:^real;
begin
  crop_res_rec:=@candy.n_offtake;
  p:=ptr(NativeUInt(crop_res_rec)+info.offset);
  value:= p^;
end;
destructor tcrop_res.done;
begin
end;


constructor tdummy_res.init(inf:tinforec);
begin
  inf.offset:=0;
  inherited init(inf);
end;

destructor tdummy_res.done;
begin
  inherited done;
end;

procedure tdummy_res.get_value;
begin
   value:=-9999;
end;



constructor tnmin_res.init(inf:tinforec; i,j:byte);
begin
  inf.offset:=0;
  inherited init(inf,i,j);
end;

destructor tnmin_res.done;
begin
  inherited done;
end;
procedure tnmin_res.get_value;
var x:real;
    i:byte;
begin
  x:=0;
  for i:=n1 to n2 do
   begin
     x:=candy.s.ks.nin[i]+candy.s.ks.amn[i]+x;
   end;
 value:=x;
end;

constructor tnmtt_res.init(inf:tinforec);
begin
  inf.offset:=0;
  inherited init(inf);
end;
destructor tnmtt_res.done;
begin
  inherited done;
end;
procedure tnmtt_res.get_value;
var x:real;
    i:byte;
begin
  x:=0;
  for i:=n1 to n2 do
   begin
     x:=candy.s.ks.nin[i]+candy.s.ks.amn[i]+x;
   end;
 value:=x;
end;


constructor tsurf_w_res.init(inf:tinforec);
begin
   inf.offset:=0;
  inherited init(inf);
end;

destructor tsurf_w_res.done;
begin
  inherited done;
end;

procedure tsurf_w_res.get_value;
var x:real;
begin
  x:=candy.s.ks.snow + candy.s.ks.speisch + candy.s.ks.szep;
  value:=x;
end;

constructor tcums_res.init(inf:tinforec);
begin
  inf.offset:=0;
  inherited init(inf);
end;

destructor tcums_res.done;
begin
  inherited done;
end;

procedure tcums_res.get_value;
begin
  value:=obs_c(candy.s);
end;



  constructor tcops_res.init(inf:tinforec);
begin
  inf.offset:=0;
  inherited init(inf);
end;

destructor tcops_res.done;
begin
  inherited done;
end;

procedure tcops_res.get_value;
begin
  value:=ops_c(candy.s);
end;


constructor tnobs_res.init(inf:tinforec);
begin
  inf.offset:=0;
  inherited init(inf);
end;

destructor tnobs_res.done;
begin
  inherited done;
end;

procedure tnobs_res.get_value;
begin
  value:=obs_n(candy.s);
end;

constructor tnops_res.init(inf:tinforec);
begin
  inf.offset:=0;
  inherited init(inf);
end;

destructor tnops_res.done;
begin
  inherited done;
end;

procedure tnops_res.get_value;
begin
  value:=ops_n(candy.s);
end;

constructor twmz_res.init(inf:tinforec);
begin
  inf.offset:=0;
  inherited init(inf);
end;

destructor twmz_res.done;
begin
  inherited done;
end;

procedure t_cv_res.get_value;
begin
  with candy.s do
  value:=c_min;
end;
procedure t_gflux_res.get_value;
var p: ^double;
 begin
 // with  soil^ do
//  value:=gflux.co2;
   p:=ptr(NativeUInt(@candy.soil.btief)+info.offset);
 value:=p^;
 end;

procedure t_ndep_res.get_value;
var p:^double;
begin
  p:=ptr(NativeUInt(@candy.soil.d_immi));
  value:=p^;
end;

procedure twmz_res.get_value;
 begin
  with candy.s do
  value:=(wmz[1]+wmz[2]+wmz[3])/3;
 end;




// Body der Unit
procedure initialize_results;
begin
 if candy.rslts=nil then  candy.rslts:=Tcdy_rslt.create; // new(cdy_res,create);
  h       := candy.s;
  p1      := @h;
  ofs:=integer(p1);
//*  cips_anf:=integer(@cips.resrec);
 crop_anf:=integer(@candy.n_offtake);
 with a_info do
 begin
  name   :='C_Mineralisierung';
  kurzbez:='C_MIN';
  index  :=139;
  einheit:='kg/ha';
  typ    :='FP';
  //faktor :=0.01;
  //feldbreite:=6;
  p1      :=@h;
  p2      :=@h.wmz[1];  //dummy
  offset :=integer(p2)-integer(p1);
 end;
 new(cv_res,init(a_info));
 candy.rslts.register_rslt(cv_res);


 with a_info do
 begin
  name   :='N-Deposition';
  kurzbez:='N-deposition';
  index  :=145;
  einheit:='kg/ha';
  typ    :='FP';
  //faktor :=0.01;
  //feldbreite:=6;
  p1      :=@h;
  p2 := @candy.soil.d_immi;
  offset :=integer(p2)-integer(p1);
 end;

 new(ndep_res,init(a_info));
 candy.rslts.register_rslt(ndep_res);


 with a_info do
 begin
  name   :='N2O-emission';
  kurzbez:='N2O';
  index  :=997;
  einheit:='m³/m²';
  typ    :='FP';
  //faktor :=0.01;
  //feldbreite:=6;
  p1:=@candy.soil.btief;
  p2:=@candy.soil.n2oflux;
  offset:=integer(p2)-integer(p1);
 end;
 new(n2o_res,init(a_info));
 candy.rslts.register_rslt(n2o_res);

 with a_info do
 begin
  name   :='WMZ';
  kurzbez:='WMZ';
  index  :=104;
  einheit:='d';
  typ    :='FP';
  //faktor :=0.01;
  //feldbreite:=6;
  p1      :=@h;
  p2      :=@h.wmz[1];
  offset :=integer(p2)-integer(p1);
 end;
 new(wmz_res,init(a_info));
 candy.rslts.register_rslt(wmz_res);


{ template

    lfc2aom,lfm2aom,sfc2aom,sfm2aom,rom2aom,aom2rom,dom2aom,aom2dom

 with a_info do
 begin
  name   := '' ;   kurzbez:=  name ;
  index  :=  ;
  typ    :=  'MP';   //faktor :=  0.1;  feldbreite:=10;   p2:=       nil ;
  offset:=  integer(@cips.resrec.cpool[8,1])-integer(@cips.resrec);
 end;
 new( x?,init(a_info, cips.resrec));
 candy.rslts.register_rslt( x?);
 }




 with a_info do
 begin
  name   := 'PVOL_30 (SSD)' ;   kurzbez:=  name ;  einheit:='VOL%' ;
  index  := 707 ;
  typ    :=  'MP';   //faktor :=  0.1;  //feldbreite:=10;   p2:=       nil ;
  offset:=  integer(@candy.dens_dyn.kfc_ap)-integer(@candy.dens_dyn.active);
 end;
 new( dd_kpv,init(a_info));
 candy.rslts.register_rslt( dd_kpv);





 with a_info do
 begin
  name   := 'PWP_30 (SSD)' ;   kurzbez:=  name ;  einheit:='VOL%' ;
  index  := 706 ;
  typ    :=  'MP';   //faktor :=  0.1;  //feldbreite:=10;   p2:=       nil ;
  offset:=  integer(@candy.dens_dyn.kfc_ap)-integer(@candy.dens_dyn.active);
 end;
 new( dd_kwp,init(a_info));
 candy.rslts.register_rslt( dd_kwp);





  with a_info do
 begin
  name   := 'FCAP_30 (SSD)' ;   kurzbez:=  name ;  einheit:='VOL%' ;
  index  := 705 ;
  typ    :=  'MP';   //faktor :=  0.1;  //feldbreite:=10;   p2:=       nil ;
  offset:=  integer(@candy.dens_dyn.kfc_ap)-integer(@candy.dens_dyn.active);
 end;
 new( dd_kfc,init(a_info));
 candy.rslts.register_rslt( dd_kfc);




 with a_info do
 begin
  name   := 'TRD_30 (SSD)' ;   kurzbez:=  name ;  einheit:='g/cm³' ;
  index  := 704 ;
  typ    :=  'MP';   //faktor :=  0.1;  //feldbreite:=10;   p2:=       nil ;
  offset:=  integer(@candy.dens_dyn.trd_ap)-integer(@candy.dens_dyn.active);
 end;
 new( dd_trd,init(a_info));
 candy.rslts.register_rslt( dd_trd);



 with a_info do
 begin
  name   := 'DD_BI (SSD)' ;   kurzbez:=  name ;
  index  := 702 ;
  typ    :=  'MP';   //faktor :=  0.1;  //feldbreite:=10;   p2:=       nil ;
  offset:=  integer(@candy.dens_dyn.dauer_bi)-integer(@candy.dens_dyn.active);
 end;
 new( dd_bi,init(a_info));
 candy.rslts.register_rslt( dd_bi);

 with a_info do
 begin
  name   := 'DD_GefStab (SSD)' ;   kurzbez:=  name ;
  index  := 703 ;
  typ    :=  'MP';   //faktor :=  0.1;  //feldbreite:=10;   p2:=       nil ;
  offset:=  integer(@candy.dens_dyn.gefstab)-integer(@candy.dens_dyn.active);
 end;
 new( dd_gefstab,init(a_info));
 candy.rslts.register_rslt( dd_gefstab);

 with a_info do
 begin
  name   := 'DD_AP_val (SSD)' ;   kurzbez:=  name ;
  index  := 701 ;
  typ    :=  'MP';   //faktor :=  0.1;  //feldbreite:=10;   p2:=       nil ;
  offset:=  integer(@candy.dens_dyn.height_ap)-integer(@candy.dens_dyn.active);
 end;
 new( dd_height_ap,init(a_info));
 candy.rslts.register_rslt( dd_height_ap);


 with a_info do
 begin
  name   :='Grundwasserneubildung';
  kurzbez:='GWB';
  index  :=103;
  einheit:='mm';
  typ    :='FP';
  //faktor :=0.1;
  //feldbreite:=6;
  offset := integer(@h.grndwssrbldng)-ofs;
 end;
 new(gwb_res,init(a_info));
 candy.rslts.register_rslt(gwb_res);

 with a_info do
 begin
  name   :='kum.WasserFlussDrainage';
  kurzbez:='WDF';
  index  :=143;
  einheit:='mm';
  typ    :='FP';
  //faktor :=0.1;
  //FELDBREITE:=6;
  offset := integer(@h.drain_flow)-ofs;
 end;
 new(wdf_res,init(a_info));
 candy.rslts.register_rslt(wdf_res);

 with a_info do
 begin
  name   :='kum.StickstoffFlussDrainage';
  kurzbez:='NDF';
  index  :=144;
  einheit:='kg/ha';
  typ    :='FP';
  //faktor :=0.1;
  //feldbreite:=6;
  offset := integer(@h.N_drain)-ofs;
 end;
 new(ndf_res,init(a_info));
 candy.rslts.register_rslt(ndf_res);

 with a_info do
 begin
  name   :='klim. Wasserbilanz';
  kurzbez:='WBIL';
  index  :=101;
  einheit:='mm';
  typ    :='FP';
  //faktor :=0.1;
  //feldbreite:=6;
  offset := integer(@h.wett.kwbil)-ofs;
 end;
 new(wbl_res,init(a_info));
 candy.rslts.register_rslt(wbl_res);


 ////////////////////////////////////////////////////////////////////
 with a_info do
 begin
   name   :='globRad';
   kurzbez:='GLOB';
   index  :=146;
   einheit:='??';
   typ    :='MP';
   //faktor :=0.1;
   //feldbreite:=6;
   offset:=integer(@h.wett.glob)-ofs;
 end;
 new(globrad_res,init(a_info));
 candy.rslts.register_rslt(globrad_res);






////////////////////////////////////////////////////////////////////
 with a_info do
 begin
   name   :='Lufttemp';
   kurzbez:='LTEMP';
   index  :=141;
   einheit:='°C';
   typ    :='MP';
   //faktor :=0.1;
   //feldbreite:=6;
   offset:=integer(@h.wett.lt)-ofs;
 end;
 new(air_temp_res,init(a_info));
 candy.rslts.register_rslt(air_temp_res);


 with a_info do
 begin
  name   :='Niederschlag';
  kurzbez:='NIED';
  index  :=128;
  einheit:='mm';
  typ    :='FP';
  //faktor :=0.1;
  //feldbreite:=6;
  offset := integer(@awo.swet.nied)-integer(@awo.swet);
 end;
 new(nied_res,init(a_info));
 candy.rslts.register_rslt(nied_res);
//////////////////////////////////////////////////////////////////////


 with a_info do
 begin
  name   :='N-Auswaschung';
  kurzbez:='N_leach';
  index  :=102;
  einheit:='kg/ha';
  typ    :='FP';
  //faktor :=0.1;
  //feldbreite:=6;
  offset := integer(@h.ninauswasch)-ofs
 end;
 new(nlc_res,init(a_info));
 candy.rslts.register_rslt(nlc_res);


 with a_info do
 begin
  name   :='gasf. N-Verluste';
  kurzbez:='N_gfv';
  index  :=106;
  einheit:='kg/ha';
  typ    :='FP';
  //faktor :=0.1;
  //feldbreite:=6;
  offset := integer(@h.ngfv)-ofs;
 end;
 new(ngv_res,init(a_info));
 candy.rslts.register_rslt(ngv_res);

 with a_info do
 begin
  name   :='N-Mineralisierung';
  kurzbez:='N_MIN_S';
  index  :=107;
  einheit:='kg/ha';
  typ    :='FP';
  //faktor :=0.1;
  //feldbreite:=6;
  offset := integer(@h.n_min)-ofs;
 end;
 new(nmn_res,init(a_info));
 candy.rslts.register_rslt(nmn_res);

 with a_info do
 begin
  name   :='C in AOS (0-30cm)';
  kurzbez:='C_AOS';
  index  :=90;
  einheit:='dt/ha';
  typ    :='ZP';
  //faktor :=1;
  //feldbreite:=6;
  offset := integer(@h.ks.aos)-ofs;
 end;
 new(aos_res,init(a_info,1,3));
 candy.rslts.register_rslt(aos_res);


 with a_info do
 begin
  name   :='C in SOS (0-30cm)';
  kurzbez:='C_SOS';
  index  :=91;
  einheit:='dt/ha';
  typ    :='ZP';
  //faktor :=1;
  //feldbreite:=6;
 offset := integer(@h.ks.sos)-ofs;
 end;
new(sos_res,init(a_info,1,3));
 candy.rslts.register_rslt(sos_res);

 with a_info do
 begin
  name   :='umsetzbarer Kohlenstoff (0-30cm)';
  kurzbez:='CUMS';
  index  :=92;
  einheit:='kg/ha';
  typ    :='ZP';
  //faktor :=1;
  //feldbreite:=6;
 offset := integer(@h.ks.sos)-ofs;
 end;
 new(cums_res,init(a_info));
 candy.rslts.register_rslt(cums_res);


  with a_info do
 begin
  name   :='OPS Kohlenstoff';
  kurzbez:='COPS';
  index  :=93;
  einheit:='kg/ha';
  typ    :='ZP';
  //faktor :=1;
  //feldbreite:=6;
 offset := integer(@h.ks.sos)-ofs;
 end;
 new(cops_res,init(a_info));
 candy.rslts.register_rslt(cops_res);


 with a_info do
 begin
  name   :='Bodenwasser 0-100cm';
  kurzbez:='BW_0_10';
  index  :=109;
  einheit:='mm';
  typ    :='ZP';
  //faktor :=1;
  //feldbreite:=6;
  offset := integer(@h.ks.bofeu)-ofs;
 end;
 new(bw10_res,init(a_info,1,10));
 candy.rslts.register_rslt(bw10_res);

 with a_info do
 begin
  name   :='Bodenwasser 0-30cm';
  kurzbez:='BW_0_3';
  index  :=108;
  einheit:='mm';
  typ    :='ZP';
  //faktor :=1;
  //feldbreite:=6;
  offset := integer(@h.ks.bofeu)-ofs;
 end;
 new(bw3_res,init(a_info,1,3));
 candy.rslts.register_rslt(bw3_res);


 with a_info do
 begin
  name   :='Bodentemperatur 0-30cm';
  kurzbez:='BT_0_3';
  index  :=110;
  einheit:='øC';
  typ    :='MQ';
  //faktor :=0.1;
  //feldbreite:=6;
  offset := integer(@h.ks.botem)-ofs;
 end;
 new(bt3_res,init(a_info,1,3));
 candy.rslts.register_rslt(bt3_res);

 with a_info do
 begin
  name   :='N auf Bodenoberfläche';
  kurzbez:='N_OBFL';
  index  :=111;
  einheit:='kg/ha';
  typ    :='ZP';
  //faktor :=1;
  //feldbreite:=6;
  offset := integer(@h.ks.nobfl)-ofs;
 end;
 new(nbo_res,init(a_info));
 candy.rslts.register_rslt(nbo_res);

 with a_info do
 begin
  name   :='Nmin 0-30cm';
  kurzbez:='NMIN_0_3';
  index  :=112;
  einheit:='kg/ha';
  typ    :='ZP';
  //faktor :=1;
  //feldbreite:=6;
  offset := integer(@h.ks.nin)-ofs;
 end;
 new(n03_res,init(a_info,1,3));
 candy.rslts.register_rslt(n03_res);

 with a_info do
 begin
  name   :='Nmin 30-60cm';
  kurzbez:='NMIN_3_6';
  index  :=113;
  einheit:='kg/ha';
  typ    :='ZP';
  //faktor :=1;
  //feldbreite:=6;
 end;

 new(n36_res,init(a_info,4,6));
 candy.rslts.register_rslt(n36_res);

 with a_info do
 begin
  name   :='Nmin 60-100cm';
  kurzbez:='NMIN_6_10';
  index  :=114;
  einheit:='kg/ha';
  typ    :='ZP';
  //faktor :=1;
  //feldbreite:=6;
 end;
 new(N61_res,init(a_info,7,10));
 candy.rslts.register_rslt(N61_res);

 with a_info do
 begin
  name   :='Bodenwasser (0-smax)';
  kurzbez:='BW_PRFL';
  index  :=115;
  einheit:='mm';
  typ    :='ZP';
  //faktor :=1;
  //feldbreite:=6;
  offset:=integer(@h.ks.bofeu)-ofs;
 end;
 new(bwt_res,init(a_info));
 candy.rslts.register_rslt(bwt_res);

 with a_info do
 begin
  name   :='min-N im Boden (0-smax)';
  kurzbez:='NMIN_PRFL';
  index  :=116;
  einheit:='kg/ha';
  typ    :='ZP';
  //faktor :=1;
  //feldbreite:=6;
  offset:=integer(@h.ks.nin)-ofs;
 end;
 new(ntt_res,init(a_info));
 candy.rslts.register_rslt(ntt_res);



 with a_info do
 begin
  name   :='N in OPS';
  kurzbez:='N_OPS';
  index  :=117;
  einheit:='kg/ha';
  typ    :='ZP';
  //faktor :=1;
  //feldbreite:=6;
 end;
 new(nops_res,init(a_info));
 candy.rslts.register_rslt(nops_res);


 with a_info do
 begin
  name   :='N in OBS';
  kurzbez:='N_OBS';
  index  :=118;
  einheit:='kg/ha';
  typ    :='ZP';
  //faktor :=1;
  //feldbreite:=6;
 end;
 new(nobs_res,init(a_info));
 candy.rslts.register_rslt(nobs_res);


 with a_info do
 begin
  name   :='C-REP-Fluss';
  kurzbez:='C_REP_SUM';
  index  :=135;
  einheit:='kg/ha';
  typ    :='FP';
  //faktor :=10;
  //feldbreite:=6;
    offset:=integer(@h.c_rep)-ofs;
//  offset:=ofs(h.c_rep)-ofs(h);
 end;
 new(crep_res,init(a_info));
 candy.rslts.register_rslt(crep_res);


 with a_info do
 begin
  name   :='N Input mineralisch';
  kurzbez:='NI_MIN';
  index  :=119;
  einheit:='kg/ha';
  typ    :='FP';
  //faktor :=1;
  //feldbreite:=6;
  offset:=integer(@h.mdng_n)-ofs;
 end;
 new(ni_min_res,init(a_info));
 candy.rslts.register_rslt(ni_min_res);

 with a_info do
 begin
  name   :='N Input organisch';
  kurzbez:='NI_ORG';
  index  :=120;
  einheit:='kg/ha';
  typ    :='FP';
  //faktor :=1;
  //feldbreite:=6;
  offset:=integer(@h.odng_n)-ofs;

 end;
 new(ni_org_res,init(a_info));
 candy.rslts.register_rslt(ni_org_res) ;

 with a_info do
 begin
  name   :='N Input symbiontisch';
  kurzbez:='NI_SYM';
  index  :=121;
  einheit:='kg/ha';
  typ    :='FP';
  //faktor :=1;
  //feldbreite:=6;
  offset:=integer(@h.symb_n)-ofs;

 end;
 new(ni_sym_res,init(a_info));
 candy.rslts.register_rslt(ni_sym_res);


 with a_info do
 begin
  name   :='N-Aufnahme in Bestand';
  kurzbez:='N_UPT';
  index  :=122;
  einheit:='kg/ha';
  typ    :='FP';
  //faktor :=1;
  //feldbreite:=6;
  offset:=integer(@h.nupt)-ofs;
 end;
 new(nupt_res,init(a_info));
 candy.rslts.register_rslt(nupt_res);


 with a_info do
 begin
  name   :='NH4-Verlust gasförmig';
  kurzbez:='NH4VT';
  index  :=123;
  einheit:='kg/ha';
  typ    :='FP';
  //faktor :=0.01;
  //feldbreite:=6;
  offset:=integer(@h.nh4verl)-ofs;
 end;
 new(nh4v_res,init(a_info));
 candy.rslts.register_rslt(nh4v_res);


 with a_info do
 begin
   name   :='N-Summe im System';
   kurzbez:='NSUMSYS';
   index  :=124;
   einheit:='kg/ha';
   typ    :='ZP';
   //faktor :=0.01;
   //feldbreite:=8;
   offset:=integer(@h.n_system)-ofs;
 end;
 new(n_system_res,init(a_info));
 candy.rslts.register_rslt(n_system_res);


 with a_info do
 begin
   name   :='Summe N-min im System';
   kurzbez:='N_M_SUMSYS';
   index  :=125;
   einheit:='kg/ha';
   typ    :='ZP';
   //faktor :=0.01;
   //feldbreite:=6;
   offset:=integer(@h.n_min_system)-ofs;
 end;
 new(n_min_system_res,init(a_info));
 candy.rslts.register_rslt(n_min_system_res);


 with a_info do
 begin
   name   :='Bedeckungsgrad';
   kurzbez:='M_BEDGRD';
   index  :=127;
   einheit:='d';
   typ    :='MP';
   //faktor :=0.1;
   //feldbreite:=6;
   offset:=integer(@h.ks.bedgrd)-ofs;
 end;
 new(k_bedgrd_m_res,init(a_info));
 candy.rslts.register_rslt(k_bedgrd_m_res);

 with a_info do
 begin
   name   :='Summe korr.Niederschlag';
   kurzbez:='NIED_K';
   index  :=100;
   einheit:='mm';
   typ    :='FP';
   //faktor :=0.1;
   //feldbreite:=6;
   offset:=integer(@h.wett.niedk)-ofs;
 end;
 new(k_nieds_m_res,init(a_info));
 candy.rslts.register_rslt(k_nieds_m_res);

 with a_info do
 begin
   name   :='Summe Pot. Evapotr.';
   kurzbez:='PET_SUMME';
   index  :=129;
   einheit:='mm';
   typ    :='FP';
   //faktor :=0.1;
   //feldbreite:=6;
   offset:=integer(@h.wett.pet)-ofs;
 end;
 new(k_pet_m_res,init(a_info));
 candy.rslts.register_rslt(k_pet_m_res);

  with a_info do
 begin
   name   :='Summe akt. Evapotr.';
   kurzbez:='AET_SUMME';
   index  :=142;
   einheit:='mm';
   typ    :='FP';
   //faktor :=0.1;
   //feldbreite:=6;
   offset:=integer(@h.aet)-ofs;
 end;
 new(k_pet_m_res,init(a_info));
 candy.rslts.register_rslt(k_pet_m_res);



 with a_info do
 begin
   name   :='Summe Transpiration';
   kurzbez:='S_TRANSP';
   index  :=130;
   einheit:='mm';
   typ    :='FP';
   //faktor :=0.1;
   //feldbreite:=6;
   offset:=integer(@h.wett.trans)-ofs;
 end;
 new(k_trans_m_res,init(a_info));
 candy.rslts.register_rslt(k_trans_m_res);


 with a_info do
 begin
   name   :='Water storage above soil ';
   kurzbez:='WSAS';
   index  :=140;
   einheit:='mm';
   typ    :='ZP';
   //faktor :=0.1;
   //feldbreite:=6;
   offset:=integer(@h.wett.trans)-ofs;
 end;
 new(surf_w_res,init(a_info));
 candy.rslts.register_rslt(surf_w_res);

with a_info do
begin
  name:='N-Offtake by Crop';
  kurzbez:='N_off_crop';
  index:=201;
  einheit:='kg/ha';
  typ:='FP';
  //faktor:=1;
  //feldbreite:=6;
  offset:=integer(@candy.n_offtake.N_OFF)-crop_anf;
end;
new(n_offt,init(a_info));
candy.rslts.register_RSLT(n_offt);


with a_info do
begin
  name:='N-Uptake by Crop';
  kurzbez:='N_upt_crop';
  index:=202;
  einheit:='kg/ha';
  typ:='FP';
  //faktor:=1;
  //feldbreite:=6;
  offset:=integer(@candy.n_offtake.N_upt_OG)-crop_anf;
end;
new(n_uptk,init(a_info));
candy.rslts.register_RSLT(n_uptk);


with a_info do
begin
  name:='by-product: N-Uptake';
  kurzbez:='Nupt_BPR';
  index:=203;
  einheit:='kg/ha';
  typ:='FP';
  //faktor:=1;
  //feldbreite:=6;
  offset:=integer(@candy.n_offtake. N_upt_NP)-crop_anf;
end;
new(n_kopp,init(a_info));
candy.rslts.register_RSLT(n_kopp);

with a_info do
begin
  name:='crop residues: N-Uptake';
  kurzbez:='Nupt_CrRes';
  index:=204;
  einheit:='kg/ha';
  typ:='FP';
  //faktor:=1;
  //feldbreite:=6;
  offset:=integer(@candy.n_offtake. N_upt_ER)-crop_anf;
end;
new(n_ewr,init(a_info));
candy.rslts.register_RSLT(n_ewr);

with a_info do
begin
  name:='dummy';
  kurzbez:='dummy';
  index:=0;
  einheit:='?';
  typ:='FP';
  //faktor:=1;
  //feldbreite:=6;
  offset:=0;
end;
new(dummy,init(a_info));
candy.rslts.register_RSLT(dummy);

candy.rslts.makereslist;

end;

end.
