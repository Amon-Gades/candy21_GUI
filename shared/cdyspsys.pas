
{implements the main "CANDY" class (Tcndcycl) wrapping the sub classes
for water temperature SOM and Nitrogen and several more }
{$INCLUDE cdy_definitions.pas}
unit cdyspsys;
{berücksichtigt Drainageabfluß ; 13.11.95}
{aktualisiert die fda-Daten nach Status-speichern}
{enthält polymorphe Objekte für Wetter und Pflanze}
{BUG fix: initialisierung des Startstatus aktualisiert jetzt s.opsfra}

interface

uses


{$IFDEF CDY_GUI}
cdy_glob, registry,  windows,
{$ENDIF}
{$IFDEF CDY_SRV}
cdy_config,
{$ENDIF}

//CANDY
  cnd_vars,     cdywett,  cnd_util, cdysomdyn,  cdy_bil,  ok_dlg1,
  gis_rslt, observations, cdyswat,  cdyparm,  stdplant,  cndplant, slurry,
  grasslnd, trkplant,     scenario, bestand,  soilprf3,  cndmulch, cdystemp,
//DELPHI
  sysutils, FireDAC.Comp.Client,   math, dateutils,  variants;

type
     T_Nofftake =record                       //< crop related elements of N-balance
                     N_upt_OG : real;         //< total N-uptake above ground
                     N_upt_NP : real;         //< N-uptake in by-product
                     N_upt_ER : real;         //< N-uptake in harvest residues ( i.e. root and stubble )
                     N_OFF    : real;         //< N-OFFTAKE from field (main- + by-product like grain +straw)
                end;

     Pcndcycl=^Tcndcycl;
     Tcndcycl = class(Tobject)                //< Definition of the CANDY process-model-structure
                wd_mode       :string;            //< Wasserdynamik  : fixed on KoGl
                sfname        :string;            //< status file name, can be used in initialisation
                action_label  :string;            //< text buffer for event messages
                k_nleach_y    : real;             //< annually cumulated N-leaching out of profile
                k_grndwb_y    : real;             //< annually cumulated seepage out of profile
                k_nleach_m    : real;             //< monthly cumulated N-leaching out of profile
                k_nloss_m     : real;             //< monthly cumulated N-loss out of upper and lower profile boundary
                k_grndwb_m    : real;             //< monthly cumulated seepage out of profile
                k_aet_m       : real;             //< monthly cumulated actual evapotranspiration
                k_nieds_m     : real;             //< monthly cumulated corrected rainfall
                k_pet_m       : real;             //< monthly cumulated potential evapotranspiration
                s_bdg         : real;             //< cumulative soil coverage (GER: Bedeckungsgrad)
                s_day         : real;             //< counter of simulation days
                dng_eff       : real;             //< multiplier (factor) to change amount of applied mineral N (may be used for scenario- or uncertainty analysis)
                n_status0     : real;             //< help variable: total N before each daystep
                n_status1     : real;             //< help variable: total N after each daystep
                n_verl        : real;             //< total N-loss (gaseous and leaching) out of the system during daystep
                n_pruef       : real;             //< help variable to identify invalid numeric N-sinks or - sources during one daystap
                faktor        : real;             //< (potential) multiplier to change the crop yield for transpiration driven crop growth of @link(trkpflan)
                cdyconnex     : pcdyconnex;       //< control record and information interface
                s             : sysstat;          //< record containing all relevant state variables see @link(sysstat), values are changed in sub-model-steps
                hs            : sysstat;          //< help variable to buffer state record s ( @link(sysstat) )
                cdy_switch    : Tcdy_switch;      //< control record containing values of candy switches i.e. from registry or conf-file
                msg_level     : integer;         //< possibility to suppress less important messages
                plant_mode    : integer;         //< type of crop - object: [0,1]: standard (S-shape); [2]: transpiration as driver for N-Uptake; [90]: grassland ; [99] unspecific external control ; [100] connection with grasmind, enabling plant communities
                snr_          : integer;         //< first part of field number
                utlg_         : integer;         //< second part of field number
                stat_recn     : integer;         //< number of an optional state record (in stc-file)
                fstd          : integer;         //< standarddeviation as parameter for @link(randfert)
                af            : integer;         //< type of N-fertilizer (item_ix) applied during autofertilisation
                first_day     : boolean;         //< stops output of inevitable balance errors at start
                stat_gen      : boolean;         //< new generated initial system state (as alternative to read a state record from a stc-file)
                cycl_mode     : boolean;         //< cyclic  simulation (repetition of the management-scenario)npreferably using generated climate data
                autofsce      : boolean;         //< scenario with autofertilization
                cdy_pf_enable : boolean;          {<  true: prepare activation of internal crop model}
                CANDY_SYSTEM  : boolean;          //< true: module is running within a candy application  false: external processmodells override candy modules
                candy_pflan   : boolean;          //< true: plant development of CANDY, false: external driven crop
                res_event     : boolean;          //< true: results will be written at current day additionally to the fixed schedule
                randfert      : boolean;          //< true: N-fertiliser amount follows random distribution with given parameters
                n_offtake     : T_Nofftake;       //< crop related elements of N-balance

                // implementation of modules (classes) for results, soil-water, temperatur, crop growth nnd CN-dynamics
                scene   : Tscenario;       //< Management
                awo     : Twetterobj;       //< Climate data
                b_w     : Tswat;           //< soil water
                bt      : Tbotemp;         //< soil temperature
                soil    : Tsomdyn;         //< C-N-turnover
                bilanz  : Tcnd_bilanz;     //< matter balance
                mulch   : Tmulch_lay;      //< mulch layer
                rslts   : Tcdy_rslt;       //< resultat recorder
                dens_dyn: T_dens_dyn;      //< simulate soil structure dynamics  , currently not implemented
                sprfl   : T_soil_profile;  //< soil profile object mainly containing physical properties
                observ  : Tcdy_obs;    //< observation processing (adaptation and recording)
                cndpfl  : cndpflan;    //< ancestor of all crop models !
                stdpfl  : stdpflan;    //< CANDY standard for crop growth
                trkpfl  : trkpflan;    //< N-uptake driven by transpiration
                dgruenl : grass;       //< CANDY grassland, child (descendant) of TRKPFLAN
                ecc     : Tecc;        //< external crop growth modell delivers information about matter fluxes over data interface
                constructor create(usp:pointer);                 //< builds and initializses the candy object

                // external interface
                procedure pp2cnd(wti,bdgrd,bho:extended);         //< import current plant parameters
                procedure wupt2vss(var wupt:extended;i:byte);     //< delivers actual water uptake of crop
                procedure trans2cnd(be:extended;snr:byte);        //< delivers transpiration demand to soil water model
                procedure nupt2cnd(amn,nin:extended;snr:byte);    //< delivers N-demand of crop to soil model

                // process simulation
                procedure one_day(usp:pointer;wdat:string);                   //< daystep of soil processes
                procedure status_sichern(objekt:string; update_fda:boolean);  //< save s.ks to stc file
                procedure management;                                         //< processing of management for current day
                procedure N_total;                                            //< sends a message about total N in soil incl. soil surface (not in crop)
                procedure close_cycle;                                        //< finish simulation cycle
                procedure N_gesamt;                                           //< calculates state variables of N storage in soil
                procedure old_done(msg_kill:boolean);                         //< sets most part of used memory free (preparation of desctructor)
                procedure get_rid_off(var psptr:Tparmsp );                    //< setting free of parameter objects
                procedure auto_irrig(bofeu: profil; tief:integer; nfk: profil;
                                     regen3d: double; var irrigmenge: double);//< this keeps soil moisture above a minimum level


 destructor done;                                              //< frees results
               end;


var    candy  : Tcndcycl;

implementation
uses cndstat, cnd_rs_2;

procedure Tcndcycl.auto_irrig(bofeu: profil; tief:integer; nfk: profil; regen3d: double; var irrigmenge: double);

var
  i:integer;
  nfk30: double;
  nfk80: double;
  soiwa: profil;
  rain_per_lay: double;

begin

    soiwa := bofeu;        // current soil moisture
    irrigmenge := 0;       // set irrigation amount to 0
    rain_per_lay := regen3d / tief;   // distribute rain amounts over soil profile layers (atm: equally)

    // berücksichtigen:
    // - interzeption
    // - aktuelle Wurzeltiefe (im Pflanzenobjekt) pro Stadium die bewässerung bekommt
    // - Häkchenoption
    // - Irrigmenge berechnen und zum Regen dazugeben damit eine natürliche perkolation stattfindet
    // - mit verschiedenen Beregnungsoptionen

    for i := 1 to tief do

    begin

      // calculate limits of the nfk
      nfk30 := nfk[i] * 0.3;
      nfk80 := nfk[i] * 0.8;
      nfk30 := nfk[i] * 0.6;
      nfk80 := nfk[i] * 0.9;

      // auto irrigate the soil when soil mositure falls below 30 nfk+pwp
      if (bofeu[i] + rain_per_lay) <= nfk30 + sprfl.pwp[i]
      then bofeu[i] := nfk80 + sprfl.pwp[i];

      // calculate total irrigation amount
      irrigmenge := irrigmenge + bofeu[i] - soiwa[i];

    end;

  end;

procedure Tcndcycl.n_total;
var n:real;
    i:integer;
begin
  n:=s.ks.nobfl;
 for i:=1 to soil.btief do n:=n+s.ks.nin[i]+s.ks.amn[i];
 n:=n+os_n(s);
 add_message(' total active N in system='+real2string(n,5,1)+' kg/ha');
end;

procedure Tcndcycl.n_gesamt;
var n,n1:real;{n:Summe N-Gesamt im System, n1: Summe N-mineralisch im System}
    i:integer;
begin
  n:=s.ks.nobfl;
  n1:=0;
  for i:=1 to soil.btief do
  begin
    n:=n+s.ks.nin[i]+s.ks.amn[i];
    n1:=n1+s.ks.nin[i]+s.ks.amn[i];
  end;
  n:=n+os_n(s);
  s.n_system:=n;
  s.n_min_system:=n1;
end;


procedure Tcndcycl.nupt2cnd(amn,nin:extended;snr:byte);
var error:boolean;
    h1,h2,h3,h4,h5:string;
begin
 error :=(nin>s.ks.nin[snr]) or (amn>s.ks.amn[snr]);
 if not error then
 begin
  s.ks.nin[snr]:=s.ks.nin[snr]-nin;
  s.ks.amn[snr]:=s.ks.amn[snr]-amn;
  s.nupt:=s.nupt+amn+nin;
 end
 else
 begin
  h1:=real2string(s.ks.nin[snr],4,1);
  h2:=real2string(nin,4,1);
  h3:=real2string(s.ks.amn[snr],4,1);
  h4:=real2string(amn,4,1);
  h5:=real2string(snr,3,0);
  send_msg('N_error in layer'+h5+':'+h1+'-'+h2+';'+h3+'-'+h4,1);
 end;
end;

constructor Tcndcycl.create(usp:pointer);
var d,i,j,
    recno,
    h,m   : integer;
    pfl_name,
    _snr,
    msgfname:string;
    ok      : boolean;
    xums,
   amp,
    phi,
    ploc: real;

(*      *)
    procedure cnd_status(schlabez,daba,dpfad,sdat:string;var recno,stnr:integer);
    var ok:boolean;
        ii:byte;
    begin
    {Status lesen}
    ok:=true;
    if copy(sdat,1,3)='***'
      then status_lesen(dpfad+'S__'+daba,recno,s.ks)
      else begin
            val(copy(sdat,1,3),d,h);
            if h<>0 then begin
                            writeln('Fehler beim Konvertieren der Tagesnummer im Steuersatz');
                            _halt(18);
                         end;
            if (d=0)
            then
            begin
              if stnr>0 then begin recno:=last_strec;status_lesen(dpfad+'S__'+daba,last_strec,s.ks); end
                        else begin write('Fehler in der Jobsteuerung: negative Satznummer');_halt(22); end;
            end
            else
            begin
             val(copy(sdat,4,2),j,h);
            if h<>0 then begin
                            writeln('Fehler beim Konvertieren der Jahreszahl im Steuersatz');
                            _halt(18);
                         end;
             if d=1 then d:=0; {kann evtl entfallen}
             find_vor_status(dpfad+'S__'+daba,schlabez,j,d,s.ks,recno,ok);
             if not ok then _halt(23);
            end;
           end;

     {Anzahl der OPS-Fraktionen eintragen}
     s.opsfra:=0;
     for II:=1 to 6 do if s.ks.ops[ii].c[1]>0 then s.opsfra:=ii;
    end;
    (* *)

      procedure initialize_state_vars;
      var i,j:integer;
          teiler:double;
      begin
       msg_count:=-99;
       cdy_pf_enable:=true;


      k_nleach_m:=0;  k_nloss_m :=0;  k_grndwb_m:=0;   k_nleach_y:=0;
      k_aet_m   :=0;  k_grndwb_y:=0;  s_DAY     :=0;   s_bdg     :=0;
      k_nieds_m :=0;     {Summe korr. Niederschlag auf 0 setzen}
      k_pet_m   :=0;      {Summe potentielle Evapotranspiration auf 0 setzten}


       s.plantparm1:=0;    s.plantparm2:=1;   s.ninauswasch  :=0;
       s.ngfv      :=0;    s.n_min     :=0;   s.c_min        :=0;  s.c_rep    :=0;

       s.ks.tag:=daynr(cdyconnex^.adatum)-1;
       val(copy(cdyconnex^.adatum,7,4),s.ks.jahr,h);
       s.ks.snow:=0;  s.ks.speisch:=0; s.ks.szep:=0; s.ks.nobfl:=0;

       s.new_ops      :=false;
       for i:=1 to 6 do
        begin
         for j:=1 to 6 do s.ks.ops[i].c[j]:=0;
         s.ks.ops[i].nr:=0;
        end;
       s.opsfra:=0;
       s.ks.pnr       :=0; s.ks.veganf    :=0; s.ks.matanf    :=0; s.ks.tempanf   :=0;
       s.ks.dbgmax    :=0; s.ks.apool     :=0; s.ks.nvirt     :=0; s.ks.maxpflent :=0;
       s.ks.kumpflent :=0; s.ks.legans    :=false;
       s.ks.mtna      :=0; s.ks.wutief    :=0; s.ks.bedgrd    :=0; s.ks.besruh    :=true;
       s.ks.forts     :=0; s.ks.schlag    :=cdyconnex^.schlagnr;
       for i:=4 to 6 do
        begin
         s.ks.aos[i]:=0;
         s.ks.sos[i]:=0;
        end;

       teiler:=cdyaparm.parm('K_STAB')/cdyaparm.parm('K_AKT');
       xums:=cdyconnex^.cums/3;
       for j:=1 to 3 do
                      begin
                        s.ks.aos[j]:=xums/(1+teiler);
                        s.ks.sos[j]:=xums*teiler/(1+teiler);
                      end;
      with cdyconnex^ do
      for i:=1 to 20 do
       begin
        s.perko[i]:=0;
        s.entz[i] :=0;
        if candymode=2 then
        begin
         s.ks.nin[i]  := nCon[i];
         s.ks.amn[i]  := aCon[i];
         s.ks.bofeu[i]:= wCon[i];
        end
        else
        begin
         s.ks.nin[i]:=10;
         s.ks.amn[i]:=0;
        end;
       end;
      end;

begin{init}
{$IFDEF CDY_GUI}

// Registry nachschauen
 cdy_reg:=Tregistry.Create;
 try
    cdy_reg.RootKey := HKEY_CURRENT_USER;
    cdy_reg.openkey('\Software\candy\switches', false);
    wd_mode:=cdy_reg.ReadString('wdmode') ;
    cdy_switch.dyn_sprm  :=  cdy_reg.ReadBool('dynsp');
    cdy_switch.struc_dyn :=  cdy_reg.ReadBool('bd_dynamics');
    cdy_switch.auto_soil :=  cdy_reg.readbool('auto_soil');
    cdy_switch.wgen      :=  cdy_reg.readbool('wgen');
    cdy_switch.lysimeter :=  cdy_reg.readbool('lysm');
    cdy_switch.puddle    :=  cdy_reg.readbool('puddle');
    cdy_switch.nied_korr :=  cdy_reg.readbool('k_prec');
    cdy_switch.rslt_freq :=  cdy_reg.ReadInteger('outfr');
    cdy_switch.ptfmode   :=  cdy_reg.ReadInteger('ptfmode');
    cdy_switch.rain_coeff:=  strtofloat(cdy_reg.ReadString('f_rain'));
 finally
    cdy_reg.closekey;
    cdy_reg.free;
 end;
{$ENDIF}

{$IFDEF CDY_SRV}
     wd_mode             :=  cdy_set.wd_mode ;
    cdy_switch.dyn_sprm  :=  cdy_set.dyn_sprm;
    cdy_switch.auto_soil :=  cdy_set.auto_soil;
    cdy_switch.auto_irrg :=  cdy_set.auto_irrg;
    cdy_switch.wgen      :=  cdy_set.wgen;
    cdy_switch.lysimeter :=  cdy_set.lysimeter;
    cdy_switch.puddle    :=  cdy_set.puddle;
    cdy_switch.nied_korr :=  cdy_set.nied_korr;
    cdy_switch.rslt_freq :=  cdy_set.rslt_freq;
    cdy_switch.ptfmode   :=  cdy_set.ptfmode;
    cdy_switch.rain_coeff:=  cdy_set.rain_coeff;
{$ENDIF}

 //**** weiter initialisieren

 bilanz:=Tcnd_bilanz.Create;
 s.nupt:=0;
  sfname:='*';
 crop_result:=nil;  new(crop_result);  cp:=crop_result;
 cp^.pname:='N-Entzug total';   cp^.p_val:=-99;  new (cp^.next);     cp:=cp^.next;
 cp^.pname:='N-Entzug netto';   cp^.p_val:=-99;  new (cp^.next);  cp:=cp^.next;
 cp^.pname:='TM-Ertrag(HP)';  cp^.p_val:=-99;     new (cp^.next);   cp:=cp^.next;
 cp^.pname:='TM-Ertrag(NP)';   cp^.p_val:=-99;  new (cp^.next);   cp:=cp^.next;
 cp^.pname:='TM-Ertrag(TT)';   cp^.p_val:=-99;   new (cp^.next);  cp:=cp^.next;
 cp^.pname:='C-Pool(NP)';  cp^.p_val:=-99;   cp^.next:=nil;

 msg_level:=maxint;     {Standard: alle Nachrichten}
 cycl_mode:=false;      {Standard: keine zyklischen Berechnungen   }

 //ext_pflan    :=true;   {externes Pflanzenmodell möglich}

 candy_system :=false;  {Normalfall für die DLL: keine Kopplung an das CANDY-System}
 candy_pflan  :=false;  {keine Pflanze aktiv}
 stat_recn    :=-1   ;  {aktuelle Position unbekannt}
 {Nachrichten initialisieren}
 cdyconnex:=usp;
 // entfälltsimparm.objekt_id:=cdyconnex^.simobject;
 if cdyconnex^.gis_mode
 then assignfile(msg_file,gis_mode_fn(cdyconnex^{simparm},cdyconnex^.cdy_res_path)+'.MSG')
 else if cdyconnex^.szenari_ix > 0 then  assignfile(msg_file,cdyconnex^.cdy_res_path+'CANDYMSG.'+inttostr(cdyconnex^.szenari_ix)+'.$$$')
                                 else
                                 begin
                                  msgfname:= cdyconnex^.cdy_res_path+'CANDYMSG.msg';
                                  assignfile(msg_file,msgfname);
                                 end;
rewrite(msg_file);
close(msg_file);

if first_msg=NIL then msg_init;
plant_mode:=1; { Standard: S-Form für N-Entzug }
//get fda infos  mit   cdyconnex.datenbank+cdyconnex.SchlagNr

  if cdyconnex.CandyMode=1 then var_init( cdyconnex.cdy_db,cdyconnex.aprm_idx);//cdyconnex^.cdy_data_path+'SYSDAT\');{Parameter-Liste Initialisieren}
cdyaparm.is_field('DNG_EFF',ok);
if ok then dng_eff:=cdyaparm.parm('DNG_EFF')    else dng_eff:=1;


 { Status setzen }
 scene:=Tscenario.create;
 mulch:=Tmulch_lay.create;
 s.opsfra:=0;


 // initialisierung der Zustandsgrößen
 initialize_state_vars;

 //ist_lysimeter:=false;
 first_day:=true;
 s.daycount := 0;
 s.simanf:=datum(s.ks.tag+1,s.ks.jahr) ;                     // timer auf null
 sprfl:=T_soil_profile.create(cdyconnex^.cdy_data_path,cdyconnex^.soilprofil,{nm_stufe}2,cdy_switch, true);


{ Standortselektion }
//# struc dyn is not implemented #
if dd_parm<>nil
  then dens_dyn:=T_dens_dyn.create(sprfl,cdy_switch.dyn_sprm)
  else cdy_switch.dyn_sprm:=false;
// bringt fehlercode: if cdy_switch.dyn_sprm then  sprfl.adapt(s.ks);  {OS-Anpassung}  // ist derzeit nicht aktiv, sollte aber die Bodenstruktur an den aktuellen SOC anpassen; setzt entsprechende Parameter voraus

if cdyconnex^.candymode=1 then
  begin
   {Initialisierung Bodenwasser}
   if sprfl<>nil then sprfl.put_maxdepth(m);
   if not candy_system then  for i:=1 to m do s.ks.bofeu[i]:=sprfl.fkap[i];
  end;

{Messwerte andocken}
  observ:=Tcdy_obs.create(sprfl,soil);   // object herstellen

 if cdyconnex^.gis_mode then
  begin
   snr_ := strtoint(cdyconnex.SimObject);
   utlg_:=0;
  end else
  begin
   // im Standard-Modus: snr und utlg als pointer benutzen
   snr_ :=scene.make_snr(s.ks.schlag);
   utlg_:=scene.make_pnr(s.ks.schlag);

  end;

  observ.connect(cdyconnex^.datenbank,snr_,utlg_,cdyconnex^.gis_mode);

 {Management initialisieren}
 scene.mnmt:=Tmndobj.create(cdyconnex^.cdy_data_path,cdyconnex^.datenbank);
 {SBA-an evtl neuen Status anpassen}
 scene.autofert.adapt2newstat(s);
 {Guellemodul bei Bedarf initialisieren}
 scene.slp:=Tguelledt.create(cdyconnex^.datenbank);
 if not scene.slp.dbok then
 begin  // no success; kill object
   scene.slp.done;
   scene.slp:=nil;
 end;


 with cdyconnex^ do
  begin
   scene.anfg:=adatum; //copy(adatum,7,4)+copy(adatum,4,2)+copy(adatum,1,2);
   scene.ende:=end_dt; //copy(edatum,7,4)+copy(edatum,4,2)+copy(edatum,1,2);
   scene.cums:=cums;
   scene.s_nr:=schlagnr;
  end;
// last_termin:=-1;
 soil:=Tsomdyn.create(s,cdyconnex^.fda_immi,sprfl);
 b_w:=Tswat.create(s.ks,cdy_switch.lysimeter,cdy_switch.puddle,wd_mode,sprfl);
// übernahmen aus status
 b_w.aet   :=s.ks.aet;
 b_w.zufuhr:=s.ks.bw_zuf;

 bt:=Tbotemp.create(amp,phi,ploc,cdyconnex.fda_ltem,sprfl);

 if cdyconnex^.candymode=195 then candy_system:=true; //# cdy_connex



 soil.cums_init (cdyconnex.fda_nied,cdyconnex.fda_ltem,cdyconnex.fda_clevel,sprfl,s);
 sprfl.nmin_init(cdyconnex.fda_nlevel,s);
 b_w.moist_init (cdyconnex.fda_fkap,'KoGl',sprfl,s);
  recno:=-99;
  sfname:=' no stc file available';
  // zustände aus status initialisieren ; wenn gewünscht;
  if fileexists(cdyconnex.stc_file) then
  begin
    {Einstellungen zum Status einlesen}
    {Die Satznummer des Startstaus muá hier bereits bekannt sein !!}
    sfname:=cdyconnex.stc_file;
    recno:=cdyconnex.s_recno;
    //die bisherige schlagnummer merken, um einen anderen Status unterschieben zu können !
    _snr:=s.ks.schlag;
    status_lesen(sfname, recno, s.ks);
    // gemerkte snr wieder unterschieben
    s.ks.schlag:=_snr;
    if (s.ks.pnr>0) and (s.ks.pic_point<3) then  cdyconnex.Aussaat:=essdatum( s.ks.veganf ,s.ks.jahr-1);
    {ops-fraktionen?}
    s.opsfra:=0;
    while (s.opsfra<6) and (s.ks.ops[s.opsfra+1].nr<>0) do inc(s.opsfra);

    stat_recn:=recno;
    if s.ks.pnr<>0 then
     begin
       candy_pflan:=true;
       s.ks.forts:=1;
       plantparm.select(s.ks.pnr,pfl_name,ok);
       create_plant('',cdyconnex^.cdy_res_path,s.ks.pic_point,'',nil,0,s);
     end;
    {laut Startstatus steht jetzt der Anfangstermin fest}
      cdyconnex^.adatum:=essdatum(s.ks.tag,s.ks.jahr);
      if copy (cdyconnex^.adatum,1,6)='31.12.'
      then cdyconnex^.datum_:=essdatum(1,s.ks.jahr)
      else cdyconnex^.datum_:=cdyconnex^.adatum;
   //  add_message('simulation start at '+cdyconnex^.adatum+'; StRec='+numstring(recno,3)+' in '+sfname);
  end;



end;
{Ende: constructor}

destructor Tcndcycl.done;
begin
 rslts.Free;
end;

procedure Tcndcycl.get_rid_off(var psptr:Tparmsp );
begin
if psptr<>NIL then
 begin
   psptr.free;;
   psptr:=nil;
 end;
end;

procedure Tcndcycl.old_done(msg_kill:boolean);
var cp:ptr_cr_res_lst;
begin
 while crop_result<>NIL do
 begin
   cp:=crop_result^.next;
   dispose(crop_result);
   crop_result:=cp;
 end;

 if b_w<>nil then b_w.Free; //dispose(_bw,done);
 b_w:=nil;
 bilanz.Free;
 bilanz:=nil;
 if bt<>nil then bt.Free; //(bt,done);
 bt:=nil;
  if soil<>nil then soil.Free;//(soil,done);
 soil:=nil;
 if mulch<>nil then mulch.Free; //(mulch,done);
mulch:=nil;


if scene.mnmt<>nil then  scene.mnmt.free;// dispose(scene.mnmt,done);
 scene.mnmt:=nil;
  if sprfl<>nil then  sprfl.Free;// dispose(sprfl,done);
 if cdyaparm<>nil then
begin

 get_rid_off(plantparm);
 get_rid_off(graslparm);
 get_rid_off(opsparm);
 get_rid_off(fert_parm);
 get_rid_off(rsltprm);
 get_rid_off(dev_parm);
 get_rid_off(tilldev);
 get_rid_off(livestockprm);
 get_rid_off(cdyaparm);
 parmok:=false;
 end;
 if candy.observ<>nil then candy.observ.free; //  dispose(mwo,done);
 candy.observ:=nil;

 if candy_pflan and cdy_pf_enable and (cndpfl<>NIL)
  then
   begin

     if cndpfl.pf_mod=1 then begin
                               stdpfl.old_done(s);
                               stdpfl.done;
                               stdpfl:=nil;
                             end;

     if cndpfl.pf_mod=2 then begin
                               trkpfl.old_done(s);
                               trkpfl.done(s);
                               trkpfl:=nil;
                             end;
     cndpfl:=nil;
   end;

 if scene.slp<>nil then scene.slp.Free; //(slp,done);
 scene.slp:=nil;
end;


procedure Tcndcycl.trans2cnd(be:extended;snr:byte);
begin               // s.entz ist hier nur die bedeckte Entnahme !!
 s.entz[snr]:=be;  //be: Anspruch aus grassmind
 s.wett.trans:=s.wett.trans+be;
end;

procedure Tcndcycl.wupt2vss(var wupt:extended;i:byte);
begin
 wupt:=-99.9{hs.entz[i]-bw^.ubent[i]; original Koitzsch}
end;

procedure Tcndcycl.pp2cnd(wti,bdgrd,bho:extended);
begin
if not candy_pflan then
begin
 s.ks.wutief  := wti;
 s.ks.bedgrd  := bdgrd;
 s.ks.bestho  := bho;
 s.plantparm1 := bdgrd;
 s.plantparm2 := 1-bdgrd;
 if s.plantparm2<0.2 then s.plantparm2:=0.2;
end;
end;


procedure Tcndcycl.one_day(usp:pointer;wdat:string);
var  ms:sysstat;
    ayear,wyear,i,idepth:integer;
    finish,
    noerror_halt:boolean;
    irri: double;
    nfk:profil;
 {
  function ess_plant(var pname:string):boolean;
  begin
         ess_plant:=ext_pflan and ((pname='W-Weizen') or
                                   (pname='W-Gerste') or
                                   (pname='Winterraps'));
  end;
  }
begin
   {typecasting}
   cdyconnex:={PEssCdyConnex(}usp; //);
 //------- check date ------------------------------------------------------
   finish:=false;
    if hs.ks.jahr>s.ks.jahr then
    begin
      s.ks.tag:=0;
      s.ks.jahr:=hs.ks.jahr;
    end;
    if essdatum(s.ks.tag+1,s.ks.jahr)<>cdyconnex^.datum_ then
    begin
     send_msg('Datumsfehler:'+cdyconnex^.datum_+'<>'+essdatum(s.ks.tag,s.ks.jahr),2);
    end;
   repeat
   next_day(s);

            if {connexbedingung} false and (cndpfl=nil) then
              begin
                   {CANDY-Pflanze}
                   candy_pflan:=false;
                   faktor:=1; {kann bei Transpirationsantrieb das Ertragsniveau modifizieren}
                   send_msg(cdyconnex.Datum_+': external crop initialized',0);
                   plant_mode:=99;
                   create_plant(cdyconnex^.cdy_data_path,cdyconnex^.cdy_res_path,plant_mode,'',nil,faktor,s);
              end;
   if (cndpfl<>nil) and (cndpfl.pf_mod=99) then ecc.connexdaten:=cdyconnex^;
   noerror_halt:=false;
   s.symb_n:=0;
   s.mdng_n:=0;
   s.odng_n:=0;
   s.nh4verl:=0;

   finish:=( essdatum(s.ks.tag,s.ks.jahr)=cdyconnex^.end_dt);         // is this the last day ?

   candy.res_event:=(essdatum(s.ks.tag,s.ks.jahr)=cdyconnex^.eDatum);   // additional result output required ?

   //---- potential state adaptation from observations -----------------------
    observ.adapt_state(s,msg_level);

   // memorize current state and calculate some infos for balance check at the end of the day
    hs:=s;
    n_status0:=s.ks.nobfl+os_n(s);
    for i:=1 to soil.btief do n_status0:=n_status0+s.ks.nin[i]+s.ks.amn[i];
   {Dreyhaupt 22.12.1999 Beginn der Einfügung}
   zustand_alt:=zustand_neu;
   s.z_wasser:=0;
   {Dreyhaupt 22.12.1999 Ende der Einfügung}

   //---- process management actions -----------------------------------------
   management;         {Massnahmen durchführen}

   //---- get climate data for current day -----------------------------------
    awo.swet.datum:=essdatum(s.ks.tag,s.ks.jahr); // Datum bestimmen
    awo.wetter(awo.swet,false,true);              // Wetterobjekt aktualisieren



    awo.putsrec(s);                               // WetterDaten in Status übernehmen

   //----- soil temperature daystep with yesterdays soil water state
   bt.daystep(s);         {Tagesschritt: Temperaturdynamik im Bodenprofil}



    ///////////////////////////////////////////
    // Auto irrigation
    ///////////////////////////////////////////
   if (s.ks.pnr<>0) and cdy_switch.auto_irrg then
    begin
     // calculate nfk for every soil layer
     idepth:=max(3,ceil(s.ks.wutief)) ;
     for i := 1 to idepth do  nfk[i] := sprfl.fkap[i] - sprfl.pwp[i];

     // process auto irrigation
     auto_irrig(s.ks.bofeu,idepth, nfk, s.wett.nied3d, irri);
        // correct with free interzeption capacity
                 irri:= irri + cndpfl.iz_cap - s.ks.szep;
     end   else  irri:=0;

   // add irrigation information (amount, date) to the message file
   if irri > 0 then
      add_message(datum(s.ks.tag, s.ks.jahr) + ' - Auto irrigation: ' + real2string(irri, 2, 1) + ' mm');


   s.Infilt:=s.wett.niedk+irri;




   //---- soil water daystep: part 0  : interzeption -------------------------

   s.wett.kwbil:=s.wett.niedk-s.wett.pet;
   {Prozesse: Interzeption jedoch nur wenn kein Schnee}
   if (s.wett.lt>0.5) and (s.ks.snow=0) then
   begin
      if s.ks.pnr<>0 then
                      begin
                        cndpfl.interzeption(s);
                      end
                       else
                      begin
                        s.infilt:=s.wett.niedk+s.ks.szep;
                        s.ks.szep:=0;
                      end;
   end;
//------ soil structure dynamics (not yet finally implemented)----------------
   if dens_dyn<>nil then dens_dyn.daystep(s);{Dichtedynamik berechnen}

//----- soil water daystep: part 1 : snow dynamics, evaporation (incl. from interzept)
   s.obflflux:=0;
   b_w.tag_anfangen(s);{ Schneedynamik, Interzeptionsverdunstung,Evaporation}

//---- crop growth -----------------------------------------------------------
   if (s.ks.pnr<>0) and candy_pflan then
    begin
     for i:=1 to 20 do s.n2crop[i]:=0;
     cndpfl.daystep(s,scene.mnmt.actual);
    end
    else s.nupt:=0;

//----- soil water daystep: part 2 : transpiration and percolation -------------
   if s.ks.pnr<>0 then
    begin
     b_w.plantuptake(s);   {Wasserbilanz im Boden}
    end;

   b_w.tag_beenden(s);     {Versickerung}

//----- matter turnover in mulch layer (if existent)
   mulch.daystep(s);       {Tagesschritt: Mulchschicht}

//---- some service code
    {Zusatzwasser rücksetzen}
    s.z_wasser:=0;         // Z_wasser stammt aus org. Düngern
    if cdyconnex^.gis_mode then
    begin
      // Abfluß in Tabelle der GISDB schreiben
    end;
    if abs(s.obflflux) > 0.00001 then
    begin
     add_message (datum (s.ks.tag,s.ks.jahr) +  ': surface runoff: '+ real2string(s.obflflux,1,6)+ ' mm');
     obflflux_summe:=obflflux_summe + s.obflflux;
    end;

     // the water-watchdog is sleeping and has no teeth !! it should be re-activated
    if not first_day and (abs(zustand_alt-zustand_neu)>0.00001)
    then add_message (datum(s.ks.tag,s.ks.jahr)+ ': diff. in waterbalance: '+real2string(zustand_alt-zustand_neu,1,8) + ' mm');


   k_nleach_m:=k_nleach_m+s.ninauswasch;
   k_nloss_m :=k_nloss_m +s.ngfv;
   k_aet_m   :=k_aet_m   +s.aet;
   k_grndwb_m:=k_grndwb_m+s.grndwssrbldng;
   k_nleach_y:=k_nleach_y+s.ninauswasch;
   k_grndwb_y:=k_grndwb_y+s.grndwssrbldng;
   s_day     :=s_day+1;
   s_bdg     :=s_bdg+s.ks.bedgrd;
   k_nieds_m:=k_nieds_m+s.wett.niedk;
   k_pet_m:=k_pet_m+s.wett.pet;

   ayear:=s.ks.jahr;
   wyear:=longjahrzahl(wdat);
   if ayear<>wyear then
   begin
   ms:=s;
   {Datum swappen}
   s.ks.jahr:=ms.ks.jahr;
   s.ks.tag:=ms.ks.tag;
   end;

//--- C-N-turnover in soil (FOM and SOM)
   soil.daystep(s);   {Tagesschritt: C-N-Umsatz in der Krume}

//--- more service code
    bilanz.update(s);
    cumstat.update(s);
    n_verl:=s.ninauswasch+s.ngfv+s.nh4verl;
    mulch.sum_n(s.n_mulch);
    n_status1:={s.n_mulch+}os_n(s)+s.ks.nobfl;

//---- write model results into observation table
    observ.process_obs(s,msg_level);

//---- check for balance leeks
    for i:=1 to soil.btief do n_status1:=n_status1+s.ks.nin[i]+s.ks.amn[i];
    n_pruef:=n_status1-(n_status0-n_verl-soil.n_drain+s.mdng_n+s.odng_n+s.symb_n-s.nupt);
    if not first_day and (abs(n_pruef)>0.00001)
     then  add_message (datum(s.ks.tag,s.ks.jahr)+ ': Diff. in N-Budget: '+real2string(n_pruef,1,8) + ' kg/ha');
    candy.n_gesamt;   {Berechnung der N-Summe im System}
//---- not implemented: adapt soil physics to SOC  oder  dens_dyn.daystep(s);
      if cdy_switch.dyn_sprm then sprfl.adapt(s.ks);  {OS-Anpassung, falls Schalter}
//    candy.rslts.output_f:=cdy_switch.rslt_freq   ;
     if  cdy_switch.rslt_freq >0 then  candy.rslts.update(s.ks.jahr,s.ks.jahr{,simparm});

  {ist dieser Tag der Monatsletzte ? wenn ja werden die Summen auf Null gesetzt}
   if copy(datum(s.ks.tag,s.ks.jahr),4,2) <> copy(datum(s.ks.tag+1,s.ks.jahr),4,2)    then {Monatswechsel}
   begin
     k_grndwb_m:=0;
     k_nleach_m:=0;
     k_nloss_m :=0;
     k_aet_m   :=0;
     k_nieds_m:=0;
     k_pet_m:=0;
    if  s.ks.tag>={365}veg_brk then  //# turning point
     begin  {neues Jahr}
        send_msg('coverage with green crop: '+real2string(s_bdg,5,1)+'d   of '+real2string(s_day,3,0)+'d',1);
        k_grndwb_y:=0;
        k_nleach_y:=0;
        s_day     :=0;
        s_bdg     :=0;
        if s.ks.pnr>0 then s.ks.forts:=1;  //Pflanze im  Erntejahr

     end;
   end;

   if cdyconnex^.candymode=5 then
                              begin
                                status_sichern('*',true);   // '*' meint,daß die Sicherung in S__<datenbank(range)>.STC ERFOLGT
                                cdyconnex^.candymode:=0;
                              end;
   hs:=s;
   first_day:=false;
   next_day(hs);
   until finish ;
   end;

procedure Tcndcycl.close_cycle;
   {Zyklus schließen}
begin
   if cycl_mode and (scene.ende=cdyconnex^.datum_) then  //# cdy_connex
   begin
     s.ks.tag:=0;
     s.ks.jahr:=longjahrzahl(cdyconnex^.adatum)+ cdyconnex^.amdy_offset;   //# cdy_connex
     scene.mnmt.reset( essdatum(s.ks.tag,s.ks.jahr));// altcdy_connex^.adatum);

   end;
end;


 procedure Tcndcycl.status_sichern(objekt:string; update_fda:boolean);
 var snr,utlg: string;
     fdata:tfdtable;
     x:real;
     hstat:statrec;
 begin
      {Status Schreiben}
    if copy (cdyconnex^.datum_,1,6)='31.12.' then
    begin
     inc(s.ks.jahr);
     s.ks.tag:=0;
    end;
    str(snr_,snr);
    str(utlg_,utlg);

    if objekt='*' then sfname:=cdyconnex^.cdy_data_path+'S__'+cdyconnex^.datenbank
                  else
                   begin sfname:=objekt;           //hier könnte der Pfad zum Datenverzeichnis fehlen
                         stat_recn:=-1;
                   end;
    //Objektnummer des Bestandes merken
    hstat:=s.ks;
    if cndpfl<>NIL then     s.ks.pic_point:=cndpfl.pf_mod
                   else     s.ks.pic_point:=0;
    // für Dauergrünland muß noch eine Sonderbehandlung erfolgen

      if  (cndpfl<>NIL) and (cndpfl.pf_mod=90) then
      begin
        s.ks.apool    :=dgruenl.autofert_nyield;
        s.ks.mtna     :=dgruenl.transko;
        s.ks.maxpflent:=dgruenl.trsum;
        x:=mulch.c_pool_size(dgruenl.halme_ix);
        s.ks.nobfl:=x;

      end;

    // Ende Sonderbehandlung

    s.ks.aet   :=b_w.aet;        // wird für die Temperaturmodellierung gebraucht
    s.ks.bw_zuf:=b_w.zufuhr;

    status_schreiben(sfname,s.ks,stat_recn);
    s.ks:=hstat;
    last_strec:=stat_recn;
    if not cdyconnex^.gis_mode {update_fda} then
    begin

     fdata:=tfdtable.Create(nil);
     fdata.Connection:=dbc; //allg_parm.Connection;
     fdata.TableName:='cdy_fxdat';
     fdata.Open;
     fdata.Locate('SNR;UTLG;FNAME',vararrayof([snr_,utlg_,cdyconnex.Datenbank]),[]);
     fdata.edit;
     fdata.fieldbyname('statusend').asinteger:=stat_recn;
     fdata.post;
     fdata.Close;
     fdata.Free;
    end;
 end;


 procedure Tcndcycl.management;
 var pfl_mod,name, crop, spec,
     parm_spez :string;
    _tag,_dat:dt;
    irreff,
     a,smenge:real;
     i, bb_time,action_id,
     art,hlp:integer;
     kp_abfuhr,
     schroepf,
     ok:boolean;
 begin
    // die N-offtake-komponenten Null setzen

    n_offtake.N_upt_OG:=0;
    n_offtake.N_upt_NP:=0;
    n_offtake.N_upt_ER:=0;
    n_offtake.N_OFF   :=0;

   {Prüfe ob Maßnahme fällig}
   (* Startjahr-1+lfd. Jahr *)
   _tag:=datum(s.ks.tag,s.ks.jahr);
   _dat:= datum(s.ks.tag,s.ks.jahr);

   with scene do
   while mnmt.today(_tag) do
   begin
    out_request:=true;
    action_id:=mnmt.actual.mmt.code;
    action_label:=scene.actions[action_id]+' ';
    art:=mnmt.seed(_tag);
    if (art<>0)  then
    if (cndpfl=NIL) then
      begin
         plantparm.select(art,name,ok);
         pfl_mod:='CANDY_S';
         {hier kann auch das Modell, mit dem die Pflanze abgebildet werden soll }
         {aus der Parameterdatei ermittelt werden}
         plantparm.is_field('MODELL',ok{,ftyp});
         if ok then {plantparm^.get_field('MODELL',pfl_mod,ftyp)}
         pfl_mod:=string(plantparm.get_pval(art,'MODELL'));
         // pfl_mod:=plantparm.ptab.fieldbyname('MODELL').asstring;;
         pfl_mod:= trim(pfl_mod);

         if length(pfl_mod)>7 then
         begin
          pfl_mod:=copy(pfl_mod,1,7);
         end;

         if pfl_mod='GRASSMI'
         then
         begin
          send_msg(_dat+' starting '+name+'(GRASSMIND)',0);
          create_plant(cdyconnex^.cdy_data_path,cdyconnex^.cdy_res_path,100,parm_spez,scene.mnmt.actual,1,s);

         end;

         if pfl_mod='ZALF_ZR'
         then
         begin
          send_msg(_dat+' starting '+name+'(ZALF_ZR)',0);
          create_plant(cdyconnex^.cdy_data_path,cdyconnex^.cdy_res_path,3,parm_spez,scene.mnmt.actual,1,s);
          candy_pflan:=true;
          end;
         if pfl_mod='ZALF_ZF'
         then
         begin
          // besondere Einstellung : parm_spez:='*';

          parm_spez:='*';

          send_msg(_dat+' starting '+name+'(ZALF_ZF)',0);
          create_plant(cdyconnex^.cdy_data_path,cdyconnex^.cdy_res_path,4,parm_spez,scene.mnmt.actual,1,s);
         candy_pflan:=true;
          end;

        if pfl_mod='ZALF_WW'
        then
        begin
          send_msg(_dat+' starting '+name+'(ZALF_WW)',0);
          create_plant(cdyconnex^.cdy_data_path,cdyconnex^.cdy_res_path,5,parm_spez,scene.mnmt.actual,1,s);
          candy_pflan:=true;
        end;

        if pfl_mod='CDYDGRN'
        then
        begin
        if cndpfl=nil then
         begin
          send_msg(_tag+'Start Dauergruenland',0);
          create_plant(cdyconnex^.cdy_data_path,cdyconnex^.cdy_res_path,90,parm_spez,scene.mnmt.actual,1,s);
          candy_pflan:=true;
         end
         else   if cndpfl.pfl_name='Dauergrünland' then send_msg(_tag+'Fortsetzung Dauergruenland',0);
        end;

        if pfl_mod='SIWAMOD'
        then
        begin
          send_msg(_dat+' starting '+name+'(SIWAMOD)',0);
          create_plant(cdyconnex^.cdy_data_path,cdyconnex^.cdy_res_path,10,parm_spez,scene.mnmt.actual,1,s);
          candy_pflan:=true;
        end;

         if pfl_mod='ESS'
         then
             begin
                 send_msg('sowing '+name+'(ESS)',0);
                 candy_pflan:=false;
             end;

         if (pfl_mod='CANDY_S') and  cdy_pf_enable then
              begin
                   {CANDY-Pflanze}
                   candy_pflan:=true;
                   faktor:=1; {kann bei Transpirationsantrieb das Ertragsniveau modifizieren}
                   send_msg(_dat+': '+action_label+name+'(CANDY)',0);
                   create_plant(cdyconnex^.cdy_data_path,cdyconnex^.cdy_res_path,plant_mode,'',scene.mnmt.actual,faktor,s);
              end;

        if (pfl_mod='CANDY_T') and  cdy_pf_enable then
              begin
                   {CANDY-Pflanze mit Transpirationsantrieb}
                   candy_pflan:=true;
                   faktor:=1; {kann bei Transpirationsantrieb das Ertragsniveau modifizieren}
                   send_msg(_dat+' starting '+name+'(CANDY)',0);
                   create_plant(cdyconnex^.cdy_data_path,cdyconnex^.cdy_res_path,2,'',scene.mnmt.actual,faktor,s);
              end;
         cdyconnex^.variety:=name;
         cdyconnex^.aussaat:=essdatum(s.ks.tag,s.ks.jahr);
       //  cndpfl.stdat:=essdatum(s.ks.tag,s.ks.jahr);
      end
      else
      begin
        // Nachricht, daß Aufgang übergangen wurde
        send_msg(_dat+'A L E R T :'+name+' could not be initialized !',0)
      end;


     art:=mnmt.start_forest(_tag,hlp);
      if art<>0 then
         begin
          parm_spez:=inttostr(art);
          { hlp enthält die modell id 21: Koniferen, 22: Laubwald
             art zeigt den Parametersatz (item_ix) der entsprechenden tabelle
             }
          create_plant(cdyconnex^.cdy_data_path,cdyconnex^.cdy_res_path,hlp,parm_spez,scene.mnmt.actual,1,s);
          candy_pflan:=true;
         end;


    art:=mnmt.umbruch(_tag,smenge);
    if art<>0 then
      begin
      crop:=' no crop ';
      for i:=1 to 20 do s.n2crop[i]:=0;
        if cndpfl<>nil
        then
        Begin
        
         // Zwischenfrucht ? wächst nicht von mai bis juni
         if   (cdyconnex.aussaat<>'')      // Datumprüfung nur wenn aussaat bekannt
         and ( s.ks.tag<120) // umbruch ´vor mai    und ausaat nach juli
         and  (comparedate( strtodate(cdyconnex.Aussaat),strtodate( essdatum(215,s.ks.jahr-1) ) ) =1 )
         then autofert.zwischenfrucht:=true else autofert.zwischenfrucht:=false;
          crop:=' '+cndpfl.pfl_name+' ';
          // Bestand in Mulch beamen
          cndpfl.kill_crop(s);
        end;
        mulch.einarbeiten(s);
        smenge:=min(smenge,3);
        soil_mix(trunc(smenge),s);
        send_msg(_dat+': '+crop+action_label+real2string(smenge,3,0)+'dm',0);
        candy_pflan:=false;
        if cndpfl<>nil
        then
        Begin
        if (cndpfl.pf_mod=100) then
        begin
        //  grassmind.done;
        end;
         cndpfl.old_done(s);
         //dispose(cndpfl,done);
         cndpfl.done;
         cndpfl:=NIL;         {muß explizit gesetzt werden !!!!!}
        end;
      end;


   {Ernte ?}

    IF (cndpfl<>NIL) and cndpfl.selbsternten
     THEN art:=cndpfl.erntebereit
     ELSE art:=mnmt.harvest(_tag,kp_abfuhr);
    if art<>0 then
    begin
     if candy_pflan and cdy_pf_enable
     then
        begin
         if cndpfl<>nil then
         begin
         // Zwischenfrucht ? wächst nicht von mai bis juni
         if  ( s.ks.tag<120) // umbruch ´vor mai    und aussaat nach juli
         and  (comparedate( strtodate(cdyconnex.Aussaat),strtodate( essdatum(215,s.ks.jahr-1) ) ) =1 )
         then autofert.zwischenfrucht:=true else autofert.zwischenfrucht:=false;
          s.usp:=mnmt.mnd;
          cndpfl.ernte(s);
          for i:=1 to 20 do s.n2crop[i]:=0;
         {Ergebnisse merken}
          res_event:=true;
         {6. C-Nebenprodukt (pot. OD)}
          cp:=crop_result; while cp.pname<>'C-Pool(NP)' do cp:=cp.next;
          cp.p_val:=cndpfl.c_shoot;
          cp:=crop_result; while cp.pname<>'N-Entzug netto' do cp:=cp.next;
          cp.p_val:=cndpfl.nit_yld;
          if not kp_abfuhr then
          begin
            cndpfl.get_koppel_ops(smenge,n_offtake.N_upt_NP,hlp);
            if smenge>0 then
             org_dng(0,hlp,0,smenge,s,'0');
          end;
          // N-Bilanzkomponenten für resultataufzeichnung
              n_offtake.N_upt_OG:=cndpfl.nit_yld;
              n_offtake.N_upt_ER:=cndpfl.n_ewr;
              with n_offtake do N_OFF   := N_UPT_OG-N_UPT_NP;
          candy_pflan:=false;
          if (cndpfl.pf_mod=100) then
          begin
           //grassmind.done;
          end;
          cndpfl.old_done(s);
        //  dispose(cndpfl,done);
          cndpfl.done;
          cndpfl:=NIL;         {muß explizit gesetzt werden !!!!!}
         end
         else
         begin
         {$IFDEF CDY_SRV}
         append(poutfile);
         writeln(poutfile, 'no crop active; harvest event will be ignored');
         close(poutfile);
         {$ENDIF}

         {$IFDEF CDY_GUI}
          ok_dlg.Label1.caption:='no crop active; harvest event will be ignored';
          ok_dlg.ShowModal;
         {$ENDIF}
         end;
        end
     else
        begin
         send_msg(action_label,0);
         cdyconnex^.ernte:= essdatum(s.ks.tag,s.ks.jahr);
        end;
    end;

    art:=mnmt.pre_harvest(_tag, schroepf);
    if art<>0 then
    begin
      cndpfl.Schnitt(s,schroepf);
               // N-Bilanzkomponenten für resultataufzeichnung
              n_offtake.N_upt_OG:=cndpfl.nnat ;
            //  n_offtake.N_upt_ER:=cndpfl.n_ewr;
              with n_offtake do N_OFF   := N_UPT_OG;

    end;

    art:=mnmt.min_dng(_tag,smenge);
    if art<>0 then
    begin
      // smenge:=smenge*dng_eff;             // ursprüngliche Variante, die so nicht mit der SBA-zusammenarbeitet
                                           // deshalb wir die Anwendung des dng_eff in die eigentliche Düngungsroutine verlegt
       if randfert then
       begin
         smenge:=nvt(smenge,fstd)-n_min_soil(s,6);
         smenge:=max(0,smenge);
       end;
       mindng(art,smenge,s,dng_eff);
    end;

   art:=mnmt.auftrieb(_tag,smenge);
   if art<>0 then
   begin
    if dgruenl<>NIL then  dgruenl.start_weide(art, smenge,s);
   end;

   art:=mnmt.abtrieb(_tag,smenge);
   if art<>0 then
   begin
    if dgruenl<>NIL then     dgruenl.stopp_weide(art, smenge,s);

   end;

    art:=mnmt.org_dng(_tag,smenge,spec);
    if (art<>0) then
     begin
      bb_time:=mnmt.next_BB;
      org_dng(0,art,bb_time,smenge,s,spec);
     end;

    art:=mnmt.tillage(_tag,smenge);
    if art<>0 then
      begin    //smenge ist die Bearbeitungstiefe;
        mulch.einarbeiten(s);
        smenge:=min(smenge,3);

        // Annahme: die Dichte verringere sich um 20%
        // option:   Fmana[i]:= f_mana(art);   // art: Zeiger auf BB-Werkzeug
        for i:= 1 to ceil(smenge) do  sprfl.Fmana[i]:=0.8;

        soil_mix(trunc(smenge),s);
        if dens_dyn<>nil then  dens_dyn.tillage(smenge,art);
        send_msg(_dat+': '+action_label+real2string(smenge,3,0)+'dm',0);
      end;

    art:=mnmt.irrigtn(_tag,smenge);
    if art<>0 then
    begin
     if smenge>0
     then
     begin
       {normale Beregnung}
       irrgdev.select(art, name,ok);
       irreff:=irrgdev.parm('effect');
       smenge:=smenge *  irreff;
        awo.irrg2wett(smenge)
     end
     else
     begin
       {Zugabe von markiertem Wasser}
       smenge          := -smenge;
       s.ks.bofeu[1]   := s.ks.bofeu[1]+smenge;
       b_w.anteil[1] := smenge/s.ks.bofeu[1];
     end;
     send_msg(real2string(smenge,3,0)+'mm'+action_label,0);
    end;

     art:=mnmt.overdrive(_tag,smenge,a);
    if (art<> 0) and (dens_dyn<>nil) then
    begin
       dens_dyn.get_management(s,art);              // Standard-Daten aus der parametertabelle lesen
       if smenge>0 then dens_dyn.p_rad  :=smenge;   // Nutzer-spezifische Angaben überschreiben
       if a>0      then dens_dyn.p_in   :=a;
       dens_dyn.roll_over:=true;
    end;

    mnmt.skip(FALSE);
  end;


 end;



begin
end.
