{ wraps all types of crop models providing generalized routines
   to create and kill a plant object during the simulation run
   when the related management action is processed in @link(cdyspsys) }
unit bestand;
 {$UNDEF GRASSMIND}
//{$DEFINE GRASSMIND}


interface
uses
        {$IFDEF GRASSMIND}
    sharemem,   link2grami,
       {$ENDIF}
    cnd_vars,scenario,stdplant,cndplant ,grasslnd,trkplant {,zfzalf,forsten,zrzalf},

//ww12,  siwapfl1,
sysutils;
         //test
procedure create_plant( cdy_path,res_path:string; modus:integer; p_spez:string; mnd:pmmtent; faktor:real; var s:sysstat);
procedure kill_plant(modus:integer; s:sysstat);
{
var

    cndpfl:cndpflan;     //urahn !
    stdpfl:stdpflan;     // CANDY Pflanze
    trkpfl:trkpflan;     // N-Aufnahme durch transpiration getsteuert
    dgruenl:grass;       // CANDY Gruenland  , Nachkomme von TRKPFLAN
    ecc:Tecc;            // externes Pflanzenmodul gibt entwicklung vor

 }
 //    zalfzr:p_zalf_zr;
 //    zalfzf:p_zalf_zf;
 //   konife:p_konifere;
 //   laubwd:p_laubwald;
 //   mischwd:p_mischwald;
 //   zalfww:pww;
 //   siwa_pfl:p_siwapfl;

    {$IFDEF GRASSMIND}
 //    grassmind:pgrami4cdy;
    {$ENDIF}
implementation


uses ok_dlg1,cdyspsys ;
procedure create_plant( cdy_path,res_path:string; modus:integer; p_spez:string; mnd:pmmtent; faktor:real; var s:sysstat);
var i:integer;

begin
for i:=1 to 20 do s.n2crop[i]:=0;  // initialisierung n_fluss

 case modus of

 0,1: begin             {Standard-Pflanze}
//     new(stdpfl,init(s,mnd));
     candy.stdpfl:=stdpflan.create(s,mnd);
     candy.cndpfl:=candy.stdpfl;
     candy.cndpfl.pf_mod:=modus;
    end;

 2: begin             {Transpirationsantrieb}
     //new(trkpfl,init(s,mnd,faktor));
     candy.trkpfl:=trkpflan.create(s,mnd,faktor);
     candy.cndpfl:=candy.trkpfl;
     candy.cndpfl.pf_mod:=modus;
    end;
   (*
 3: begin             {ZR-Modell vom ZALF-Müncheberg}
     new(zalfZR,init(s,p_spez,mnd,cdy_path));
     candy.cndpfl:=zalfzr;
     candy.cndpfl^.pf_mod:=modus;
    end;

 4: begin             {ZF-Modell vom ZALF-Müncheberg}
     new(zalfZF,init(s,p_spez,mnd,cdy_path));
     candy.cndpfl:=zalfzf;
     candy.cndpfl^.pf_mod:=modus;
    end;


 5: begin             {TRITSIM-WW Modell vom ZALF-Müncheberg}
     new(zalfWW,INIT(S,MND,CDY_PATH{,GEOBREIT,SAATSTäRKE,TAGZAHL,GBM<=0?}));
     candy.cndpfl:=zalfww;
     candy.cndpfl^.pf_mod:=modus;
    end;

 6: begin             {TRITSIM-WR Modell vom ZALF-Mncheberg}
      {fehlt noch total}
    end;

    {
 7: begin
      new(qpmww,init(s,mnd,cdy_path));
      cndpfl:=qpmww;
      cndpfl^.pf_mod:=modus;
    end;
     }
10: begin {Simwasser-Pflanzenmodell-Familie}
     new(siwa_pfl,init(s,p_spez,mnd,cdy_path,res_path));
     cndpfl:=siwa_pfl;
     cndpfl^.pf_mod:=modus;
    end;
       *)
90:begin  {Dauergruenland}
    if (candy.dgruenl<>NIL) and (candy.cndpfl=candy.dgruenl) then exit; // Dauergruenland wird fortgesetzt
    if graslparm=NIL then
    begin
    // Parameter fehlen
    _halt(56);
    end;

    // new(dgruenl,init(s,mnd,1,cdy_path));
     candy.dgruenl:=grass.create(s,mnd,1,cdy_path);
     candy.cndpfl:=candy.dgruenl;
     candy.cndpfl.pf_mod:=modus;
    end;

99:begin {ext.contr.crop}
    // new(ecc,init(s));
     candy.ecc:=Tecc.create(s);
     candy.cndpfl:=candy.ecc;
     candy.cndpfl.pf_mod:=modus;
   end;


100:begin {grassmind}

   {$IFDEF GRASSMIND}
      new(grassmind,init(s,mnd));
      candy.cndpfl:=grassmind;
      candy.cndpfl^.pf_mod:=modus;
   {$ENDIF}
    end;

 (*******
21:begin  {Koniferen-Bestand}
     new(mischw,init(s,p_spez,mnd,cdy_path,0));
     cndpfl:=konife;
     cndpfl^.pf_mod:=modus;
    end;

22:begin  {Laubwald-Bestand}
     new(mischwd,init(s,p_spez,mnd,cdy_path,1));
     cndpfl:=laubwd;
     cndpfl^.pf_mod:=modus;
    end;

23:begin  {Mischwald-Bestand}
     new(mischwd,init(s,strtoint(p_spez),mnd,cdy_path));
     cndpfl:=mischwd;
     cndpfl^.pf_mod:=modus;
    end;
          ********)
 end;
end;



procedure kill_plant(modus:integer; s:sysstat);

begin


 case modus of
 1: begin
     candy.stdpfl.old_done(s);
    // dispose(stdpfl,done);
     candy.stdpfl.done;
     candy.cndpfl:=NIL;
    end;
 end;{case}


end;




begin
end.