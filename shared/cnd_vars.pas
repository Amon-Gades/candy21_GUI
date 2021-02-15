{
central collection of definitions for types, records and variables (besides @link(cdy_glob)
}
{$INCLUDE cdy_definitions.pas}
(*
unit cnd_vars;
interface
uses cdyparm,classes,ok_dlg1,{dbtables,}
 FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.Phys.MSAcc, FireDAC.Phys.MSAccDef, FireDAC.VCLUI.Wait,
  FireDAC.Comp.Client ;
  *)
unit cnd_vars;
interface
uses

{$IFDEF CDY_GUI}
cdy_glob,
{$ENDIF}
{$IFDEF CDY_SRV}
cdy_config,
{$ENDIF}

cdyparm,classes,
 FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys,
  {$IFDEF MSWINDOWS}
  FireDAC.Phys.MSAcc, FireDAC.Phys.MSAccDef,    FireDAC.VCLUI.Wait,
   {$ENDIF}
  FireDAC.Comp.Client ;


{ESS-Version}
const v_ID='V E R S I O N   2020';
const graph_anzahl= 2;
      btsohle     =10;
      kurv_col    =11;
       MAXFRAZ=        6;
       S_MAX   =       6;
       KAOS   =  0.00556;
       KAPPA  =      2.8;
       CNROS  =      8.5;
       MAXOD  =       10;
       OS_Sigma  =  0.00090;
       OS_LAMBDA =  os_sigma/kappa;
       sanz   =        4;
       veg_brk= 365;         // Julian day where a new year starts for vegetation


type

    feldatr =(db_Date,Zeichenkette,Zahlen,Logikwert,unbekannt,null);

 zeike=string[255];
     str4 =string[4];
     str3 =string[3];
     dt   =string[10];        //war 8
     feld3=array[1..20] of real;
     SAEULE=ARRAY[1..S_MAX] OF REAL;


      OBSt   =RECORD
                   SOS:SAEULE;
                   AOS:SAEULE;
             END;
      OPSt   =RECORD
                   name:string;
                   k   :real;
                   eta :real;
                   CNR :REAL;
             END;


     opstyp  = record
                 c : saeule;
                 nr: integer;
               end;


     ptr_cr_res_lst=^cr_res_lst;     {Erg.Zwischenspeicher fÅr Bestandsobjekte}
     cr_res_lst    = record
                       pname  :string;
                       p_val  :real;
                       next   :ptr_cr_res_lst;
                     end;



 profil= array[1..20] of real;

      statrec = record                { Status zum Ende eines Sim.-laufes }
               tag      : integer;   { Tagesnummer des letzten Tages       }
                                     { Ausnahme: wenn 31.12. dann tag=0    }
               jahr     : integer;
               schlag   : string[6]; { Schlagkennung                       }
               snow     : real;      { Schneehˆhe                          }
               speisch,
               szep     : real;
               botem    : profil;     { Bodentemperaturprofil               }
               bofeu    : profil;     { Bodenfeuchteprofil                  }
               nin      : profil;     { Nitrat-N}
               amn      : profil;     { Ammonium-N}
               nobfl    : real;       {N auf der Oberfl‰che}
               aos      : saeule;     { aktive OS}
               sos      : saeule;     { stabile OS}
               ops      : array[1..6] of opstyp;   {OPS-Fraktionen}
               pnr      : integer;   { Kenn. der noch aktiven Pflanze      }
               veganf   : integer;   { Parameter des candy-Pflanzenmoduls}
               vegend,
               tempanf,
               dbgmax,
               matanf   : integer;
               apool    : real;
               nvirt    : real;      {...}
               maxpflent: real;
               kumpflent: real;
               legans   : boolean;
               mtna     : real;
               wutief   : real;   { erreichte Wurzeltiefe in dm         }
               bedgrd   : real;   { erreichter Bedeckungsgrad       }
               bestho   : real;   { erreichte Bestandeshˆhe in cm       }
               besruh   : boolean;   { 1: Pfl. w‰chst nicht; 0: Pfl. wÑchst}
               forts    : integer;   { 0: Ansaatjahr, 1: Folgejahr         }
               pic_point: integer;   { Typ des Pflanzenmodells  }
               aet,
               bw_zuf   : real;
               end;
      syswett=record
               ltmin,
               ltmax,
               ltvg,
               ltg,
               lt,
               gwd,
               ncgw,
               niedk,
               nied3d,
               wspeed,
               lfeu,
               pe,
               pet,
               pei,
               wbil,
               kwbil,  {klimatische Wasserbilanz}
               trstr,
               trans,
               rf,
               glob,

               btem,                   // Bodentemperatur bei Inkubationsversuchen
               theta   :real;          // Bodenfeuchte bei Inkubationsversuchen
               inkub,                  // meldet Inkubationsversuch
               theta_opt :boolean;     // Bodenfeuchte im Optimum

              end;
      sysstat=record
              new_ops:boolean;
               simanf   : dt;
              daycount,
              opsfra:integer;
              drain_flow,
              n_drain,
              z_wasser,
              obflflux,
              fvirt,           {Korrektur des virtuellen N-Entzuges}
              plantparm1,
              plantparm2 :real;
              dnz  :saeule;
              wmz,bat   :profil;
              perko,
              nllay,
              n2crop,
              entz  :profil;
              symb_n,        {symbiontische N-Bindung      }
              mDng_n,        {Mineral-N-Input(DÅnger)+Immis}
              oDng_n,        {Org-N-Input (DÅnger+EWR)     }
              nupt,          {tÑgliche N-Aufnahme des Bestandes}
              nh4verl,       {tÑgl. NH4-Verluste}

              n_system,  {Dreyhaupt 17.10.2000: Summe des Gesamt-N im System (Ammon. u. Nitrat-N im gesamten Bodenprofil,}
                         {N auf Oberfl., N in org. Substanz)}
              n_min_system,   {Dreyhaupt 17.10.2000: Summe des min. N im System}
              trnsp_soll,           { Transpirationsbedarf}
              Infilt,               { Wasserinfiltration  }
              aet,                  { Tageswert der AET}
              ae_srf,               { Tageswert der Verdunstung von Wasser an der Oberfl‰che  also Schnee und Interzeption }
              n_mulch,
              c_mulch,
              grndwssrbldng,
              w_marked,
              ninauswasch,
              N_marked,
              n_min,
              c_min,
              c_rep : real;
              ngfv  :real;
              wett  :syswett;
              ks    :statrec;
              usp   :pointer;   {unspezifischer pointer}
              tension  :profil;  { Saugspannung}
             end;

      Tcum_stat = object
                   procedure reset;
                   procedure update(st:sysstat);
                   var
                    grndwssrbldng,
                    w_marked,
                    ninauswasch,
                    c_min,
                    n_min,
                    ngfv    : real;
                  end;
      msg_PT  =^msgrec;
      msgrec  =record
                 info : string[78];
                 next : msg_pt;
                 vorg : msg_pt;
               end;



      mndptr  =^mndrec;             { Zeiger auf agrotechnische Ma·nahme }
      mndrec  = record
                tagnr : integer;    { Nr. des Tages, an dem die Ma·nahme   }
                                    { realisiert werden soll               }

                art   : integer;    { Art der Maﬂnahme                     }
                                    { 1: Aufgang             2: Ernte      }
                                    { 3: org. Dng.           4: min. Dng   }
                                    { 5: Bodenbearbeitung    6: Probenahme }
                                    { 7: Beregnung                         }

                spez1 : integer;    { Ma·nahmespezifikation                }
                                    { bei art=1 : Fruchtart ( Nr. )        }
                                    { bei art=2 : nicht definiert          }
                                    { bei art=3 : DÅngerart ( Nr. )        }
                                    { bei art=4 : N-Aufwandmenge           }
                                    { bei art=5 : Bearbeitungstiefe in dm  }
                                    { bei art=6 : Kennziffer               }
                                    { bei art=7 : nicht definiert          }

                spez2 : integer;
                                    { bei art=1 : N-Entzug zur Ernte       }
                                    { bei art=2 : nicht definiert          }
                                    { bei art=3 : C-Aufwandmenge           }
                                    { bei art=4 : Ammoniumanteil           }
                                    { bei art=5 : nicht definiert          }
                                    { bei art=6 : Entnahmetiefe            }
                                    { bei art=7 : Zusatzwassermenge in mm  }


                next  : mndptr       { Zeiger auf nÑchste Ma·nahme          }
                end;


type ertragsdaten = record
               valid       : boolean;
               dm_hp,        {dry matter Hauptprodukt}
               dm_np,        { .. Nebenprodukt}
               dm_pf,        {Summe aus hp+np}
               fm_hp,        {fresh matter}
               fm_np,
               c_yld_hp,     {C- bzw. N-ErtrÑge fÅr Haupt- u. Nebenprodukt}
               c_yld_np,
               n_yld_hp,
               n_yld_np,
               n_crop,       {N-im oberirdischen Bestand (HP+NP)}
               nat_yld_np,
               nat_yld_hp          {Naturalertrag}
                           : real;
            end;


     conpoint= ^conrec;              { Zeiger auf Steuersatz         }
     conrec  = record                { Satz aus der Steuerdatei      }
               wetter   : string[12];{ zu benutzende Wetterdatei     }
               standort : string; { Standortauswahl (KÅrzel)      }
               schlabez : string[6];{xxxx-x}
               madat    : string[8]; { zu benutzende Ma·nahmedatei   }
               daba     : string[5]; { Datenbankbezug                }
               geobreit : real;
               recno    : string[3];   { Satznummer des Startstatus    }
               sdat     : string[5]; { Datum nach dem Starttermin    }
               wetterjahr:string;    { Zeichenkette, die das verwendete Wetter bezeichnet}
               edatum,
               adatum,
               pfl_mod,
               erg_dbf,              { Ergebnisdatenbank }
               dpath,                { Pfad zur Datenbank }
               wpath,                { Pfad zu Wetterdaten}
               mxtname  :string;     { Name des MXT-Files }
               erg_frq,              { 1,5,10,30 :HÑufigkeit der Listenausgabe}
               wdh_anz  : longint;   { Anzahl der Wiederholungszyklen}
               wait_rq  : boolean;   { am Ende Warten }
               next     : conpoint;  { Zeiger auf nÑchsten Schritt   }
               end;

    VAR
  // soilstate:Tsoilstate;
    cumstat:Tcum_stat;
    buf: array [0..8191] of ansichar;
    last_yld:ertragsdaten;
    out_request,
    no_wait_after_error,
    debug_mode  :boolean;
    yrend      :string;
//    outfile :textfile;
    cp,crop_result : ptr_cr_res_lst;
    cursor        :word;
    step_count,
    msg_count     :integer;
    first_msg,
    last_msg,
    show_msg      : Tstringlist;
    nutzer        : string[2];
    msg_file,             {Message file $$$}
    poutfile      :textfile;

    name:string[30];
    js  :string;                   { Jahreszahl (jj) als String    }
    fi,txtdat,
    fequo,
    fstmi,
    fpast      :text;              { Hilfsdateien fÅr ASCII-Daten  }
    i,j,k,                         { Hilfsvariablen                }
    end_tag,                       { Tagesnummer fÅr Simulationsende }
    end_jahr,
    jahr       :integer;           { Jahreszahl                    }

    zeile,kommentar:zeike;         { Hilfsstrings                  }

    W_ANF,W_END,W_RECS : integer;  { Beschreibung der Wetterdaten  }
    MET_RECS           : integer;  { Anzahl der SÑtze in Zieldatei }
    waitrequest,
    neuer_anfang,
    prm_out,
    ok1,abbruch,out,
    error_file,mnd_ok,
    met_ok,con_ok,ats_req,
    dyn_veganf,prj,cn_rq,tritsim,
    std_ok,schaltjahr : boolean;    { Logik-Schalter                }
    control           : conpoint;   { Zeiger auf Steuer-Satz }
    condat            : conrec;     { Steuersatz   }
    anfang, schluss   : integer;


    dynveg      : integer;
    dvegru          : integer; { Beginn der Vegetationsruhe     }
    Fruchtart   : zeike;

    graf,mode,driver  :integer;
    smax,smin,
    zmax,zmin         : array [1..graph_anzahl] of integer;
    tmax,wmax,
    tmin,wmin,
    last_strec,        {letzter Statusrecord}
    scr_s,scr_z,scr_z0:integer;
    drawcolor         :integer;
    Error : integer;
    am_ende_warten,
    dayly_wmz,monthly_wmz,
    grafik_an,msgrq   : boolean;
    hotkey            : char;
    heap_anf          : pointer;

    mnd               : mndptr;

//    allg_parm:ttable;//Tquery;
 //   allg_parm:tFDtable;//Tquery;
 {  standort,}cdyaparm,trkprm,plantparm,graslparm,opsparm,fert_parm, {pest_parm, }
   livestockprm,rsltprm,dev_parm, dd_parm,tilldev,irrgdev ,CIPS_PARM    : Tparmsp;
   parmset:string;
   parmok :boolean;
//   parmrec:integer;

    {Dreyhaupt 22.12.1999 Beginn der Einf¸gung}
    zustand_alt:real;   {Summe aus Interzeptionsspeicher, Schnee, Bodenfeuchte im Profil, Bodenfeuchte im Tiefboden
                         und Wasser auf OberflÑche VOR Durchlauf Bodenwassermodul}
    zustand_neu:real;   {Summe aus Interzeptionsspeicher, Schnee, Bodenfeuchte im Profil, Bodenfeuchte im Tiefboden
                         und Wasser auf OberflÑche NACH Durchlauf Bodenwassermodul}
    bofeu_zae:byte;     {Hilsvariable}
    whh_differenz:real; {Differenz im Wasserhaushalt:
                           (zustand_alt + korr. NS - AET - GWB -ObwerflÑchenwasser) minus neuer Zustand }
    obflflux_summe:real;{Summe des Wassers, welches durch OberflÑchenabflu· "verlorengeht"}
    {Dreyhaupt 22.12.1999 Ende der EinfÅgung}

{Bildschirmfarben}
      toplincol,
      toplinbg,
      dwnlincol,
      dwnlinbg,
      buttonbg,
      errtxtcol,
      errtxtbg,
      stdtxtcol,
      stdtxtbg,
      winhdlcol,
      winhdlbg,
      nprof_nin,
      nprof_amn,
      wprof,
      pflnges,
      pfldiff,
      bodn,
      rootn        : byte;



procedure VAR_INIT(dpth:string;apidx:integer);
procedure  set_objects;

implementation

 uses  scenario, cdyspsys  ;

procedure set_objects;
begin
  //soilstate.b_w:=Tvssbw(soilstate.p1);
end;


procedure Tcum_stat.reset;
begin
  c_min:=0;
end;

procedure Tcum_stat.update(st:sysstat);
begin
   c_min:=c_min+st.c_min;
end;
{
provides the parameter space for most of the candy objects
parameters are the database file (incl. path): dpth
and the item_ix (apix) of the record of general parameters (cdyaparm)
}
procedure VAR_INIT(dpth:string;apidx:integer);
{Parameterdateien initialisieren}
//var par_ix:integer  ;
begin
 parmok:=false;
 cumstat.reset;
 {$IFDEF CDY_GUI}
 db_connect(dpth);
 {$ENDIF}


 cdyaparm:=Tparmsp.create('CDYAPARM','item_ix',true);
 cdyaparm.select(apidx,parmset,parmok);
 //{$IFDEF CDY_GUI}
 //abbruch:= abbruch or ok_dlg.abbruch;
 //abbruch:=ok_dlg.abbruch;
 //{$ENDIF}
  plantparm:=Tparmsp.create('CDYPFLAN','ITEM_IX',true);
 {das ist f¸r TRKPLANT2 erforderlich
 try
 new(trkprm,init('PLPTRAN',true));   //// wo sind die Daten  ?
 except trkprm:=nil;
 end;
 }
//? abbruch:= abbruch or ok_dlg.abbruch;
 try
  graslparm:=Tparmsp.create('CDYGRAS','ITEM_IX',true);
 except graslparm:=nil;
 end;
 opsparm:=Tparmsp.create('CDYOPSPA','ITEM_IX',true);
//? abbruch:= abbruch or ok_dlg.abbruch;
 livestockprm:=Tparmsp.create('CDYLIVES','ITEM_IX',true);
//? abbruch:= abbruch or ok_dlg.abbruch;
fert_parm:=Tparmsp.create('CDYMINDG','ITEM_IX',true);
//? abbruch:= abbruch or ok_dlg.abbruch;
 rsltprm:=Tparmsp.create('CDY_RSLT','RESULTNR',true);

//? abbruch:= abbruch or ok_dlg.abbruch;
//? parmok:= not abbruch;
 tilldev:=Tparmsp.create('CDYTILLDEV','ITEM_IX',true);

//? parmok:= not abbruch;

 irrgdev:=Tparmsp.create('CDYIRRGDEV','ITEM_IX',true);


 try
 dev_parm:=Tparmsp.create('CDYDEVPA','ITEM_IX',true);
 except
  dev_parm:=nil;
 end;

{$IFDEF CDY_SRV}
 try
 dd_parm:= Tparmsp.create('CDYSSDPA','ITEM_IX',true);
 except
  dd_parm:=nil;
 end;
 {$ELSE}
  dd_parm:=nil;
 {$ENDIF}

 {
 try
 new(CIPS_parm,init('CDY_cips',false));
 except
  CIPS_parm:=nil;
 end;
  if not CIPS_parm.ptab.Active then
 }
 begin
 CIPS_parm:=NIL;
 end;



 // candy.scene.create_action_list;

end;


begin
//parmset:='NORM';   //Standardenstellung
last_yld.valid:=false;
{Ausgabefrequenz auf monatlich setzen}
{
daydruck:=false;
pendruck:=false;
dedruck :=false;
}
first_msg:=nil;
end.
