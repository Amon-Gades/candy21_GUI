{
definition of data types and routines to communicate between the routines defined in @link(dllcandy) and the candy process simulation itselfs
}
unit      Cdy_Glob;            (*  10.03.94 xxx *)

  interface
  uses registry;
//  uses sharemem;
  const  MaxAnzLayers = 20;

  type
    Tcdy_switch = Record
        lysimeter, puddle,
        auto_soil,
        auto_irrg,
        struc_dyn,
        dyn_sprm,
        wgen,
        nied_korr         : boolean;
        rain_coeff        :double;
        ptfmode,
        rslt_freq         :integer;
    End;

    PMsg_Rec        =^TMsg_Rec;
    TMsg_rec        = record
                         message: string;
                         code   : integer;
                         neu    : boolean;
                         next   : PMsg_rec;
                         befo   : PMsg_rec;
                      end;

    PCdyConnex   =^TEssCdyConnex;
    TEssCdyConnex   = record
 {Kommunikationsliste}
      first_msg,
      last_msg    : PMSG_REC;
      Datum_,      (* Datum des aktuellen Tages:  TT.MM.JJJJ    *)
      end_dt       (* Datum des letzten   Tages:  TT.MM.JJJJ    *)       //?
                  : string;
  {Steuerungsgrößen}
      szenario_ix,   //aus simparm
      cdy_db,         //db_f_name ?
      RunName     : String;
      aprm_idx ,   (* record selection selection for cdyaparm *)
      s_recno,     (* record number in stc file /optional      *)
      CandyMode    (*  1: CANDY wird initialisiert                  *)
                   (*  2: CANDY übernimmt Startwerte vom CONNEX     *)
                   (*  3: externe Steuerung der Pflanzenentwicklung *)
                   (* 95: CANDY übernimmt Startwerte aus Status     *)
                   (*  0: 'normaler' Tagesschritt                   *)
                   (* -1: Übernahme der EWR und Tagesschritt        *)
                   (* -2: CANDY-Objekte beseitigen                  *)
                  : integer;
      gis_mode    : boolean;
 {inputs für eine standard-Initialisierung}
      fda_latitude,
      fda_immi,
      fda_clevel,
      fda_nlevel,
      fda_fkap,
      fda_nied,
      fda_ltem    :real;


 {Inputs für CANDY-Scenario-Manager}
      aDatum,       (*  Beginn der Simulation                  *)
      eDatum,       (*  Ergebnis-Ausgabe (RES)                 *)
      CDY_Data_Path,(* Candy-Daten-Pfad                                     *)
      cdy_res_path,
      climate,      (* Wetterstation*)
      SoilProfil,   (* Bodenprofil des Standortes; LOE, LAU,...             *)
      SimObject,    (* object ID für resultat *)                        //simparm.objekt_id ?

      DatenBank,    (* Auswahl der Datenbank: MFELD, BARNS, QUEDL ...       *)
      SchlagNr,     (* Nummer des Schlages am STandort: ___10,  ___11       *)
      stc_file       (* optionaler startstatus *)
                    : string;
      Cums          (* Startwert f. umsetzb. Kohlenst.  15000...40000 kg/ha *)
                    : extended;
       ncycl,
       amdy_offset,        // offset bei Zyklus-Rechnung
       szenari_ix   : integer; { szenario index (nur im debug modus) }



 {OUTPUT vom CANDY-Scenario-Manager}
      Aussaat,     (* Von CANDY-Datenbank: Datum für die Aussaat           *)
      Ernte,       (* Von CANDY-Datenbank: Datum für die Ernte             *)
      Variety      (* Von CANDY-Datenbank: Pflanzenart (z.Zt. Wheat        *)
                    : string;
     soildepth    (* Anzahl der Bodenschichten in CANDY(output)            *)
                    : integer;

{CANDY-Input vom Pflanzenmodul}
      nRoot,        (* Anzahl der Wurzelcompartments d.h Wurzeltiefe in dm  *)
      litter1,      (* ID für frischen Bestandesabfall                      *)
      litter2       (* ID für seneszenten Bestandesabfall                   *)
                    :integer;

      Cover,       (* akt.Bedeckungsgrad nach Koitzsch (0...1)             *)
      Height,      (* akt. Höhe des Pflanzenbestandes                      *)
      NShoot,      (* Information: Gesamtstickstoff des Sproß in kg/ha *)

      clitter1,    (* frischer Bestandesabfall in kg C/ha/d *)
      clitter2     (* seenszenter Bestandesabfall in kg C/ha/d *)

                    :extended;
      wRem,        (* Wasserentzug: Ess-Verfahren                          *)
      nRem,        (* Nitrat-N-Entzug / Bodenschicht                       *)
      aRem,        (* Ammoniumentzug / Bodenschicht                        *)
      nOps         (* ErnteWurzelRückstände / Bodenschicht                 *)
              : array [1..20] of extended;

{CANDY-Input vom Umweltmodul für den zu rechnenden Tag}
      Telu,        (* Ess_Environ: Lufttemperatur                          *)
      Glob,        (* Ess_Environ: Globalstrahlung                         *)
      Rain         (* Ess_Environ: Niederschlag                            *)
                    : extended;
{CANDY-Outputs}
      BTem,        (* Candy: Bodentemperatur / Bodenschicht                *)
      wCon,        (* Candy: Wassermasse / Bodenschicht                    *)
      wPot,
      nCon,        (* Candy: Stickstoffgehalt / Bodenschicht               *)
      aCon,        (* Candy: Ammoniumgehalt / Bodenschicht                 *)
      wilk,        (* Welkepunkt                                           *)
      fkap,        (* Feldkapazität=Sickergrenze                           *)
      pvol         (* Porenvolumen                                         *)
             : array [1..20] of extended;

                      end; (* TEssCdyConnex *)


// var   Cdy_Connex   : PCdyConnex;

     procedure SEND_MSG(text:string; C:integer);
     procedure KILL_MSG;
     procedure kill_old_msg;

     function cnd_error(pRcrd:pointer):boolean;
     function cnd_warning(pRcrd:pointer):boolean;
     FUNCTION essdatum(t,J: INTEGER):string;
 var  cdy_reg:Tregistry;

  implementation
  uses cdyspsys;

 
  FUNCTION essdatum(t,J: INTEGER):string;
{Berechnung der Tages- und Monatszahl aus der Nummer t des Tages im Jahr }
TYPE
  feld = ARRAY[1..12] OF INTEGER;
CONST
  mol: feld = (31,28,31,30,31,30,31,31,30,31,30,31);
VAR
  monend: feld;
  m     : BYTE;
  ta,mo  :integer;
  schaltjahr:boolean;
  h,h1      :string;

BEGIN
  if t=0 then
  begin
   str((j-1):4,h);
   h1:=copy(h,3,2);
   essdatum:='31.12.'+h;
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
      t:=t-366;
      if schaltjahr then dec(t);
      schaltjahr:=(j mod 4 = 0);
    end;
    m:= succ(m);
  UNTIL (t <= monend[m]);
  mo:= m;
  IF(m = 1) THEN ta:= t ELSE ta:= t - monend[m - 1];
  str(ta:2,h);if h[1]=' ' then h[1]:='0'; h1:=   h+'.';
  str(mo:2,h);if h[1]=' ' then h[1]:='0';h1:=h1+h+'.';
  str( j:4,h);h1:=h1+h;
  essdatum:=h1;
end;

  procedure SEND_MSG(text:string; C:integer);
  var help: pMsg_rec;
     Cdy_Connex   : PCdyConnex;
  begin
    cdy_connex:=candy.cdyconnex;
   help:=cdy_connex^.last_msg;
   with cdy_connex^ do
    begin
     if last_msg<>NIL then
      begin
       new(last_msg^.next);
       last_msg:=last_msg^.next;
      end
     else
      begin
       new(first_msg);
       last_msg:=first_msg;
      end;
     last_msg^.befo:=help;
     last_msg^.next:=nil;
     last_msg^.message:=text;
     last_msg^.code:=c;
     last_msg^.neu :=true;
    end;
  end;

  procedure KILL_MSG;
  var help: pMsg_rec;
     Cdy_Connex   : PCdyConnex;
  begin
  cdy_connex:=candy.cdyconnex;
   with cdy_connex^ do
    while first_msg<>NIL do
    begin
     help:=first_msg^.next;
     dispose(first_msg);
     first_msg:=help;
     end;
   cdy_connex^.first_msg:=nil;
   cdy_connex^.last_msg:=NIL

  end;

  procedure list_msg(p:pointer);
  var help:pMsg_rec;
  Cdy_Connex   : PCdyConnex;
  begin
  cdy_connex:=PCdyConnex(p);
  with cdy_connex^ do
   begin
     help:=first_msg;
     while help<>NIL do
      begin
        write(help^.message:74,help^.code:2);
        if help^.neu then writeln(' !') else writeln( ' *');
        help:=help^.next;
      end; {while}
        writeln('keine weiteren Nachrichten');
   end; {with cdyconnex^}
  end;{procedure list_msg}

  function cnd_error(pRcrd:pointer):boolean;
   var help:pMsg_rec;
       Cdy_Connex   : PCdyConnex;
   begin

    Cdy_Connex := PCdyConnex (pRcrd);
    with cdy_connex^do
     begin
        help:=last_msg;
        if help<>NIL then
        begin
        while (help^.next<>NIL) and (help^.code<>2) do help:=help^.next;
        cnd_error:=(help^.code=2);
        end
        else
        cnd_error:=false;
     end;{with}
   end;

  function cnd_warning(pRcrd:pointer):boolean;
   var help:pMsg_rec;
    Cdy_Connex   : PCdyConnex;
   begin
    Cdy_Connex := PCdyConnex (pRcrd);
     with cdy_connex^do
     begin
        help:=last_msg;
        if help<>NIL then
        begin
        while (help^.next<>NIL) and (help^.code<>1) do help:=help^.next;
        cnd_warning:=(help^.code=1);
        end
        else cnd_warning:=false;
     end;{with}
   end;

  procedure KILL_old_MSG;
  var help,lmsg,vmsg: pMsg_rec;
   Cdy_Connex   : PCdyConnex;
  begin
  cdy_connex:=candy.cdyconnex;
   with cdy_connex^ do
   begin
    lmsg:=first_msg;
    vmsg:=lmsg;
    while lmsg<>NIL do
    begin
     help:=lmsg^.next;
      if not lmsg^.neu
       then
         begin
          {Kette neu verknüpfen}
          if vmsg=lmsg then begin
                              if lmsg=first_msg then first_msg:=help;
                              vmsg:=help;
                              help^.befo:=vmsg;
                            end
                       else begin
                              if lmsg=last_msg then last_msg:=vmsg;
                              vmsg^.next:=help;
                              help^.befo:=vmsg;
                             end;
          dispose(lmsg);
          lmsg:=help;
         end; {Kette neu verknüpfen}
     end; {while lmsg<>NIL}
    end;  {with  cdyconnex}
  end;    {   procedure   }


  begin
   (*
   simparm.korr_preci:=true;

   with pdummy do
   begin
      first_msg:=nil;
      last_msg :=nil;
      Datum_   :='';
      cdy_db:='';
      RunName:='';
      CandyMode:=-99;
      aDatum:='';
      eDatum:='';
      CDY_Data_Path:='';
      cdy_res_path:='';
      climate:='';
      SoilProfil:='';
      SimObject:='';
      DatenBank:='';
      SchlagNr:='';
      Cums:=-99;
      Aussaat:='';
      Ernte:='';
      Variety:='';
      soildepth:=0;
      nRoot:=0;
      litter1:=0;
      litter2:=0;
      Cover:=0;
      Height:=0;
      NShoot:=0;
      clitter1:=0;
      clitter2:=0;
      Telu:=0;
      Glob:=0;
      Rain:=0;
      for i := 1 to 20 do
      begin
      wRem[i]:=0;
      nRem[i]:=0;
      aRem[i]:=0;
      nOps[i]:=0;
      BTem[i]:=0;
      wCon[i]:=0;
      wPot[i]:=0;
      nCon[i]:=0;
      aCon[i]:=0;
      wilk[i]:=0;
      fkap[i]:=0;
      pvol[i]:=0;
      end;


   end;   *)
  end.  (* Cdy_Glob *)
