{
 main routines for a standalone implementation of the model kernel without GUI ; but non the less used  within the standard candy app
}
unit dllcandy;
interface
uses
  sharemem,
  windows,
  SysUtils,
  strutils,
  Classes,
  forms,
  registry,
  firedac.dapt,
  cdy_glob,cdywett, cnd_vars ,cdyspsys, cnd_util, ok_dlg1, gis_rslt ,  cdyparm ,
  cnd_rs_2 ;

  procedure CdyLink (PRcrd :Pcdyconnex);
  procedure cdy_init(var ptr:pcdyconnex);
  procedure db_close;

implementation
{R *.res}


procedure CdyLink (PRcrd :Pcdyconnex);
  var       newr :single;
            iw :byte;
            ajahr,
            opsix : integer;
            s_pointer:pointer;
            h1    : pmsg_rec;
            teststr,
            cnd_outfile:string;
            cdy_connex:PCdyconnex;

procedure   SetUmwt;
  var        dat :  string;
  begin   (* Wetterdaten: Ess -> Candy *)
    cdy_connex:=PRcrd;
    with Cdy_Connex^ do
    begin
             dat :=  datum_;
             candy.awo.swet.datum:=dat;
             candy.awo.swet.nied:=rain;
             candy.awo.swet.glob:=glob;
             candy.awo.swet.ltem_h:=telu;
             candy.awo.wetter(awo.swet,false,true);

             if candy.awo._first then
             begin
              candy.awo.swet.ltem_v:=telu;
              candy.awo.swet.ltem_g:=telu;
              candy.awo._first:=false;
             end
             else
             begin
              candy.awo.swet.ltem_v:=awo.swet.ltem_g;
              candy.awo.swet.ltem_g:=awo.swet.ltem_h;
             end;

    end; (* with Cdy_Connex *)
  end;   (* SetUmwt *)

procedure   SoilValuesFromCandy;
  var          iW : integer;
  begin
    with   Cdy_Connex^    do   begin
    for        iW := 1  to  soildepth     do
    begin
             ncon[iw]:=candy.s.ks.nin[iw];
            acon[iw]:=candy.s.ks.amn[iw];
            wcon[iw]:=candy.s.ks.bofeu[iw];
            btem[iw]:=candy.s.ks.botem[iw];
            wilk[iw]:=candy.b_w.entgr[iw];
            fkap[iw]:=candy.b_w.sickergr[iw];
//            candy.nan2vss     (ncon[iw],acon[iw],iw); (* N-Gehalte       *)
//            candy.bofeu2wcon  (wcon[iw],iw);          (* Wassermassen    *)
//            candy.botem2btem  (btem[iw],iw);          (* Bodentemperatur *)
//            candy.b_w.get_pwp (wilk[iw],iw);
//            candy.b_w.get_fkp (fkap[iw],iw);
//            candy.b_w.con2pot (wcon[iw],wpot[iw],iw); (* Saugspannung    *) //unsinn
    end;
   end;  (* with Cdy_Connex *)
  end;   (* SoilValuesFrom Candy *)

procedure soil2connex;
begin
 cdy_connex.soildepth:=candy.b_w.bodentiefe;
end;

procedure   PlantValuesFromEss;
  var  iW : integer;
  begin
   with Cdy_Connex^ do
   begin
    for iW:=1 to 20 do
    begin
      candy.trans2cnd (wrem[iw],iw);          (* Wasserentzug     *)
      candy.nupt2cnd  (arem[iw],nrem[iw],iw); (* Stickstoffentzug *)
    end;
    candy.pp2cnd    (nRoot, Cover, Height);   (* Pflanzengrößen   *)
   end;  (* with Cdy_Connex *)
  end;   (* PlantValuesFromEss *)

procedure   RootMassToCandy;
  var  iW : integer;
  begin
    newr := 0;
    with Cdy_Connex^ do
    begin
     for iw:=1 to 20  do newr :=newr + nops[iw];
//?     candy.getops (newr);  (* nach Ernte: RootMass --> CANDY *)
    end;  (* with Cdy_Connex *)
  end;  (* RootMassToCandy *)

  begin (* ------------------- CdyLink ------------------------------------ *)
   Cdy_Connex := PCdyConnex (pRcrd);
   with Cdy_Connex^ do
   begin
    case CandyMode of
     -99: begin
           // not available
           end;

      1,2:  begin
                     {Ergebnisausgabe für Bodenmodell}
                   //cnrslt:=false;
                   gis_mode:= cdy_connex.gis_mode;
                   RunName:=  replacetext(RunName,' ','_');
                   RunName:=  replacetext(RunName,'-','_');
                   RunName:=  replacetext(RunName,'+','_');
                   RunName:=  replacetext(RunName,'/','_');
                   RunName:=  replacetext(RunName,'*','_');

                   candy  :=Tcndcycl.create(cdy_connex);
                   {Message-Liste im cdyconnex rücksetzen}

                   Kill_msg;
                   add_message('cdyaparm : PSET = '+parmset);
                   add_message('soil profile: '+  cdy_connex.SoilProfil );


                   add_message('simulation start at '+candy.cdyconnex.adatum) ;  //'; StRec='+numstring(recno,3)+' in '+sfname);
                   if candy.cdyconnex.s_recno>0 then
                   begin
                    add_message('binary STC file detected:'+candy.cdyconnex.stc_file);
                    add_message('simulation initialized from StRec='+numstring(candy.cdyconnex.s_recno,3));
                   end
                   else
                    begin
                     add_message('regular initialization from estimates');
                     add_message('estimated BAT : '+real2string(candy.soil.hwmz,7,1)+' d');
                     add_message('estimated Crep: '+real2string(cdy_connex.fda_clevel,7,3)+' dt/ha');
                    end;

                   add_message('water dynamics following: ' +candy.b_w.wdmode);
                   add_message('parameters of temperatur module:');
                   add_message(candy.bt.parmstr);
                   add_message('average air temperature='+floattostr(cdy_connex.fda_ltem)+' °C');
                   add_message('management: '+cdy_connex.datenbank+cdy_connex.schlagnr+
                              ' from '+candy.scene.anfg+' to '+candy.scene.ende);

                   candy.observ.initialize;
                   candy.observ.rewrite_mltab;


                   // result processing

                   initialize_results;
                   candy.rslts.reset('object'{,simparm});
            {       daydruck:=false;  pendruck:=false; modruck:=true;
                   evdruck:=true;
             }

                   //management
                   candy.scene.mnmt.load(candy.scene.anfg,candy.scene.ende,schlagnr);
                   candy.scene.mnmt.adjust(candy.scene.anfg);
                   if cdy_connex.climate<>'*' then
                   begin

                    //dwo
                    candy.AWO:=Tdbwetter.CREATE( candy);//1{tbed},1{tunb},1{simparm.r_faktor},{geobreit}55,cdy_connex.climate);
                    add_message('climate data: '+  cdy_connex.climate);
                     candy.awo.ext_src:=false;
                   end
                   else
                   begin
                     candy.awo:=TExtWetter.create(1,1,1,55) ;
                   end;
                   candy.awo._first:=true;  //es folgt der erste aufruf einer Zeitreihe
                   soil2connex;
                   SoilValuesFromCandy;
                   CandyMode := 0;
          end;

      0:  begin    if cdy_connex.climate='*'  then    SetUmwt    ;  // externes wetter übernehmen
                   candy.res_event:=(cdy_connex^.datum_=cdy_connex^.eDatum);
                   candy.one_day (Cdy_Connex,cdy_connex.Datum_);
                   ajahr:=strtoint(rightstr(cdy_connex.Datum_,4));
                   SoilValuesFromCandy;
          end;

     -1:  begin    CandyMode := 0;        (* Pflanzen geerntet. Wurzel- *)
                   SetUmwt;               (* masse an Candy übergeben.  *)
                   PlantValuesFromEss;
                   RootMassToCandy;
                   candy.one_day (Cdy_Connex,cdy_connex.Datum_);
                   {Ergebnisaufbereitung für RES-Kanal}
                   // aus candy.s ;   //?
                   if candy.rslts.res_obj_sel >0  then candy.rslts.update({sim}jahr,jahr{,simparm});
                   SoilValuesFromCandy;
          end;
     -2:  begin (* Vorbereitung des Dispose *)

                   if candy<>NIL then
                   begin
                   send_msg('candy closed',1);
                   candy.old_done(false);
                   candy.Free;   //candy.rslts.free; //dispose(cdy_res,done);

                   candy:=nil;
                    { //K
                   if dwo <>NIL then dispose(dwo ,done);
                    dwo := NIL ;
                    }
                    //K dwo:=nil;
                   awo:=nil;
                   end;
                  ok_dlg.Release;
                  ok_dlg.Free;
                  ok_dlg:=nil;
          End;

    end;   (* Case CandyMode  *)
    end;   (* with Cdy_Connex^ *)
    //end   (* if ...*)
    (*    else
         begin
         if cdy_connex^.candymode>0
          then send_msg('CANDY constructor failed: DLL has not been initialized ! ',2)
          else send_msg('CANDY not alife',2);
         end;
    *)
  end;     (* EssCdyLink *)


  {
function  EssCdy_wCon2wPot (wMasse :extended; sNmbr :integer) :extended;export;
  var     Theta :extended;
  begin   candy.b_w.con2pot (wMasse, Theta, sNmbr);
          EssCdy_wCon2wPot := theta;
  end; (* EssCdy_wCon2wPot *)
   }

procedure cdy_init(var ptr:pcdyconnex);
var i:longint;
    cdyreg:tregistry;
    r:Tesscdyconnex;
begin

// r:= ptr^;
// Ausgabefile zur Behelfsausgabe
// assign(poutfile,'dlltest.txt');
// rewrite(poutfile);
// writeln(poutfile,'candy_dll- testversion 04062011');
//T writeln(poutfile,r.runname);
// close(poutfile);

 // Flagge zeigen
 //hallofrm:=thallofrm.create(nil);
 //hallofrm.Label1.Caption:=r.RunName;
 //halloworld.hallofrm.Showmodal;
 //hallofrm.Release;
 //hallofrm.Free;


 // OK-Fenster generieren
 ok_dlg:=tok_dlg.create(nil);


 end;



procedure db_close;
begin
  db_disconnect;
end;

 

   // begin
  end.   (* Cdy_Lib1 *)
