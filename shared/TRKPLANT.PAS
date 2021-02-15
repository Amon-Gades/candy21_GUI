{ implements a plant growth object where the nitrogen uptake is related to the transiparation of the crop }
unit trkplant;
interface
uses cndplant,cnd_vars,scenario,cnd_util,math;
type
    ptrkpflan = ^trkpflan;
    trkpflan  = class(cndpflan)
                  transko :real;
                  constructor create(var s:sysstat;mnd:pmmtent;kfak:real);
                  procedure calc_n_dem(var s:sysstat);virtual;
                  procedure daystep(var s:sysstat;mnd:pmmtent); virtual;
                  procedure ernte(var s:sysstat);virtual;
                  destructor done(var s:sysstat);virtual;

                  {    destructor done;}
                 end;

implementation


constructor trkpflan.create(var s:sysstat;mnd:pmmtent;kfak:real);
//var aufgang:boolean;
begin
 aufgang:=(s.ks.pnr=0);
 cndpflan.create(s,mnd);
 transko:=plantparm.parm('TRANSK');
 if aufgang then
 begin
   case art of
    1: begin
          s.fvirt:=n_upt(s.ks.vegend,s.ks.veganf,vegdau,steil);
          s.ks.nvirt     := ziel/s.fvirt;
          s.ks.maxpflent := steil*250/vegdau;
       end;
    2: begin
          s.ks.nvirt    := ziel;
          s.ks.maxpflent:=2;
       end;
  3,4: begin
         s.ks.nvirt:=0;
         s.ks.maxpflent:=2;
         atag:=s.ks.tag;
       end;
    5: begin
        s.ks.mtna   :=ziel/transko;
     //   autofert.yield:=ziel;
       end;
  end;{case}
 {Anfangswert auf null setzen}
 s.ks.nvirt:=0;
 transko:=transko*kfak;
 s.fvirt:=transko;
 s.ks.maxpflent:=2*transko;
 end
 else
 begin
  nbok:=nbok/transko;
  s.fvirt:=transko;
  s.ks.nvirt:=0;
 end;
end;


procedure trkpflan.calc_n_dem(var s:sysstat);
var tief:integer;
    n_bedarf :real;

begin
{                     ****** Stickstoffaufnahme *****                  }
tief:=round(s.ks.wutief);
n_luft:=0;
n_bedarf:=0;
{ 1. Tagesbedarf }
if s.ks.besruh then N_Bedarf:=0
else
begin
 s.ks.nvirt:=s.ks.nvirt+transko*s.wett.trans;

 if s.ks.tag<s.ks.matanf then
 begin
 case art of
   1: begin   {"normale" einjährige Pflanze}
       N_Bedarf:=s.ks.nvirt-s.ks.kumpflent;
                { n_bedarf:=s.wett.trans*transko; }
       N_Bedarf:=Min(N_bedarf,s.ks.Maxpflent);
      end;
   2: begin     { Wintergetreide im Ansaatjahr    }
       if s.ks.forts=0
        then N_Bedarf:=0.068*s.wett.lt
        else
         begin
          N_Bedarf:=s.ks.nvirt+s.ks.apool-s.ks.kumpflent;
          { n_bedarf:=s.wett.trans*transko; }
          if n_bedarf<0 then n_bedarf:=0;
          N_Bedarf:=Min(N_bedarf,s.ks.Maxpflent);
         end;
      end;
 3,4: begin             { Leguminosen }
      s.ks.mtna:=s.ks.nvirt-s.ks.kumpflent;
      if s.ks.legans
      then              { im Ansaatjahr}
       N_Bedarf:=(s.ks.mtna-nbok*s.wett.trans)*(1-N_upt(atag,s.ks.veganf,vegdau,steil))
      else
       N_Bedarf:=nbok*s.wett.trans;  { entwickelt   }
       n_luft:=s.ks.mtna-N_bedarf;
      end;
   5: begin             { linearer N-Entzug }
       N_Bedarf:= transko * s.wett.trans ;  // original war so: s.ks.nvirt-s.ks.kumpflent;
      // if atag=(s.ks.vegend+1) then { EWR aktivieren };

      end;
   end; {case}
  end else n_bedarf:=0; {if}
end;
daily_n_dem:=n_bedarf;
s.symb_n:=n_luft;

end;



procedure trkpflan.daystep(var s:sysstat; mnd:pmmtent);
begin
 calc_n_dem(s);
inherited _daystep(s,mnd);
 (*
 if s.ks.kumpflent<transko*s.ks.nvirt then
 begin
   {neues Potential berechnen}
   s.ks.nvirt:=s.ks.nvirt*s.ks.kumpflent/(transko*s.ks.nvirt)
 end;
 *)

end;

procedure trkpflan.ernte(var s:sysstat);
begin
 {cndpflan.} inherited _ernte(s);
 add_message('pot Nupt '+real2string(s.ks.nvirt*transko,5,1)+'kg N/ha');
 add_Message('-> dbf NERT='+nert+' STRP='+real2string(s.ks.nvirt,5,1));
end;

destructor trkpflan.done(var s:sysstat);
begin
  {cndpflan.} inherited _old_done(s);
end;


begin
end.