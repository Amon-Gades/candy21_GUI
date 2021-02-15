 { the class stdpflan implements the basic routines for plant growth that may be overridden by some child objects   }
unit stdplant;
interface
uses cndplant,cnd_vars,scenario,cnd_util,math;
type
    pstdpflan = ^stdpflan;
    stdpflan  = class(cndpflan)



               { einige spezielle Strukturen         }
               nsym,             {Summe der symbiontischen N-Bindung}
               gsum,             {Strahlungssumme    }
               esum,             { Summe PET         }
               asum,             { Summe AET         }
               aest,             { Aerationsstress    }
               wstr,             {Wstr:Summe PET/AET }
               wsum,             {Temperatursumme    }
               tsum   : real;    {Transpirationssumme}


               constructor create(var s:sysstat;mnd:pmmtent);
               procedure calc_n_dem(var s:sysstat);virtual;
               procedure daystep(var s:sysstat;mnd:pmmtent);    override;
               procedure ernte(var s:sysstat); override;
               procedure  old_done(var s:sysstat); override;
               destructor done;
               {               destructor done;    }
               end;

Implementation

procedure stdpflan.old_done(var s:sysstat);
begin
 inherited _old_done(s);
end;
destructor stdpflan.done;
begin
end;

constructor stdpflan.create(var s:sysstat;mnd:pmmtent);
//var aufgang:boolean;
begin
 hi:=0;
 aufgang:=(s.ks.pnr=0);
 inherited create(s,mnd);
 if aufgang then
 begin
 {Summen auf NULL}
  nsym:=0;             {Summe der symbiontischen N-Bindung}
  gsum:=0;             {Strahlungssumme    }
  esum:=0;             { Summe PET         }
  asum:=0;             { Summe AET         }
  aest:=0;             {Aerationsstress    }
  wstr:=0;             {Wstr:Summe PET/AET }
  wsum:=0;             {Temperatursumme    }
  tsum:=0;             {Transpirationssumme}

  case art of
    1,3: begin
          s.fvirt:=n_upt(s.ks.vegend,s.ks.veganf,vegdau,steil);
          s.ks.nvirt     := ziel/s.fvirt;
          s.ks.maxpflent := steil*s.ks.nvirt/vegdau;
       end;
    2: begin
          s.ks.nvirt    := ziel;
          s.ks.maxpflent:=2;
       end;
    {   // alte Variante
    3: begin
        s.ks.mtna   :=ziel/(s.ks.vegend-s.ks.veganf);
        s.ks.nvirt  :=ziel;
       end;
    4,5: begin
        s.ks.mtna   :=ziel/265;   //es werden 265 Vegetationstage pro Hauptnutzungsjahr unterstellt
        s.ks.nvirt  :=ziel;
       end;
       }

  4,5: begin
        s.ks.mtna   :=ziel/vegdau;
        s.ks.nvirt  :=ziel;
       end;
  end;
 end;
end;



procedure stdpflan.calc_n_dem(var s:sysstat);
var tief:integer;
    n_bedarf :real;
    i:integer;
    sn:real;
begin

{                     ****** Stickstoffaufnahme *****                  }
tief:=round(s.ks.wutief);
{ 1. Tagesbedarf }
atag:=  s.daycount;      //s.ks.tag;
n_luft:=0;
n_bedarf:=0;
if s.ks.besruh then N_Bedarf:=0
else
begin
 if s.wett.lt<5 then N_Bedarf:=0
 else
 case art of
   1: begin             {"normale" einjährige Pflanze}
       N_Bedarf:=s.ks.apool+ s.ks.NVirt * N_upt(atag,s.ks.veganf,vegdau,steil) - s.ks.kumpflent;
  // testeinschub
      if n_bedarf> s.ks.maxpflent then
      begin
      sn:=0;
       for i:= 1 to 18 do sn:=sn+s.ks.nin[i]+s.ks.amn[i];
       N_Bedarf:=Min(N_bedarf,s.ks.Maxpflent);
      end;
      end;
   2: begin             { Wintergetreide im Ansaatjahr}
       if s.ks.forts=0
        then N_Bedarf:=0.068*s.wett.lt
        else
         begin
          s.ks.nvirt:=Max(s.ks.nvirt, s.ks.apool);
          N_Bedarf:=s.ks.apool+ (s.ks.NVirt-s.ks.apool) * N_upt(atag,s.ks.veganf,vegdau,steil) - s.ks.kumpflent;
          N_Bedarf:=Min(N_bedarf,s.ks.Maxpflent);
         end;
      end;
  4: begin             { Leguminosen }
        n_luft  :=s.ks.mtna*(1-nbok);
        N_Bedarf:=s.ks.mtna-N_luft;
      end;
  3: begin  { anuelle Leguminosen}
       N_Bedarf:=s.ks.apool+ s.ks.NVirt * N_upt(atag,s.ks.veganf,vegdau,steil) - s.ks.kumpflent;
       N_Bedarf:=Min(N_bedarf,s.ks.Maxpflent);
       n_luft   :=N_bedarf*(1-nbok);
       N_bedarf:=N_bedarf-n_luft;   // Anteil aus dem Bodenpool
      end;
   5: begin           { linearer N-Entzug }
       N_Bedarf:=s.ks.mtna;
       //if atag=(s.ks.vegend+1) then { EWR aktivieren };
      end;
   end; {case}
end;
 daily_n_dem:=n_bedarf;
 s.symb_n:=n_luft;
end;


procedure stdpflan.daystep(var s:sysstat; mnd:pmmtent);


      function d_as(s:sysstat):real;
      var i,j:integer;
          w,aest:real;
      begin

      w:=0;
      j:=round(s.ks.wutief);
      if j>0 then
      begin
        if j>10 then j:=10;
        for i:= 1 to j do w:=w+s.ks.bofeu[i];
        aest:=12.51-13.55*w/300{soil^.pvol(j)};
        if aest<0 then aest:=0;
        if aest>1 then aest:=1;
      end else aest:=0;

      d_as:=aest;

      end;


begin
     calc_n_dem(s);
     inherited _daystep(s,mnd);


  nsym :=nsym+s.symb_n;
  gsum :=gsum+s.wett.glob*s.ks.bedgrd;
     esum :=esum+s.wett.pet;
 //    asum :=asum+bw^.aet;
 //    as   :=as+d_as(s);
     tsum :=tsum+s.wett.trans;
 //    wsum :=wsum+sockel(s.wett.lt,5)*s.ks.bedgrd;
     wstr :=wstr+s.wett.trstr;
{
 ***********************************************

  if spz_out then writeln(spzfile,datum(s.ks.tag,s.ks.jahr):10,
                                  gsum    :7:0,
                                  esum    :6:1,
                                  asum    :6:1,
                                  as      :6:1,
                                  tsum    :6:1,
                                  wsum    :6:1,
                                  wstr    :6:1);

 *********************************************** }


end;


procedure stdpflan.ernte(var s:sysstat);
var  wert:string;
begin

 {cndpflan.}  inherited _ernte(s);
 str(nsym:4:1,wert);
 add_message(datum(s.ks.tag,s.ks.jahr)+' symb. N-Fix.='+wert+' kg/ha ');
 str(tsum:4:1,wert);
 add_message(datum(s.ks.tag,s.ks.jahr)+' Transpiration='+wert+' mm ');

 {
 zeile:='RD='+real2string(gsum,6,0);
 zeile:=zeile+' PE='+real2string(esum,6,1);
 zeile:=zeile+' AE='+real2string(asum,6,1);
 zeile:=zeile+' AS='+real2string(as  ,6,1);
 zeile:=zeile+' TP='+real2string(tsum,6,1);
 zeile:=zeile+' TM='+real2string(wsum,6,1);
 zeile:=zeile+' TS='+real2string(wstr,6,1);
 add_message( zeile);
 }
end;

begin
end.
