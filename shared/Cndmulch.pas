{

  Definition einer Mulch-Schicht auf der Bodenoberfläche

  Zustandsgröße:  org_matter :   Masse der organischen Substanz in kg/ha
                  bzw. c_ops :   C-Masse (folt aus org_matter*1.724

  Prozesse     :  daystep    :   Abbildung der Umsatzdynamik


  Methoden     :  add_om(x)  :   erhöht org_matter um x
                  einarbeiten:   OM wird in erste Bodenschicht gebracht
                                 Mulchschicht verschwindet

 }

unit cndmulch;
interface
uses cnd_vars,cnd_util,ok_dlg1,scenario,math  ;



type p_ops_pool=^ops_pool;
     ops_pool  = record
                   n_menge,
                   c_menge:real;
                   ops_nr :integer;
                   next_pool : p_ops_pool;
                 end;

type p_mulch_lay=^Tmulch_lay;
     Tmulch_lay  = class(Tobject)
                     org_matter:p_ops_pool;
                     k_mulch   :real;

                     constructor create;
                     procedure   daystep(var s:sysstat);
                     procedure   add_om(ctot:real; ix:integer);
                     procedure   einarbeiten(var x:sysstat);
                     procedure   sum_c(var c_mulch:real);
                     procedure   sum_n(var n_mulch:real);
                     function    pool_count :integer;
                     function    c_pool_size(ix:integer):real;
                     destructor  done;
                   end;

//var mulch:Tmulch_lay;
implementation
uses cdyspsys ;
constructor Tmulch_lay.create;
var // afield:feldatr;
    ok    :boolean;
begin
 org_matter:=nil;
 k_mulch:=0;
// ok:=(allg_parm.findfield('K_MULCH')<>nil);
 cdyaparm.is_field('K_MULCH',ok);
 if ok then
 begin
  k_mulch:=cdyaparm.parm('K_MULCH');
 end;
end;

function Tmulch_lay.pool_count:integer;
var n:integer; p:p_ops_pool;
begin
  n:=0;
  p:=org_matter;
  while p<>NIL do
  begin
   inc(n);
   p:=p^.next_pool;
 end;
 pool_count:=n;
end;

function Tmulch_lay.c_pool_size(ix:integer):real;
var x:real; p:p_ops_pool;
begin
  p:=org_matter;
  while p<>NIL do
  begin
   if p.ops_nr=ix then x:=p.c_menge;
   p:=p^.next_pool;
 end;
 c_pool_size:=x;
end;
procedure Tmulch_lay.sum_n(var n_mulch:real);
var p:p_ops_pool;
begin
 n_mulch:=0;
 p:=org_matter;
 while p<>NIL do
 begin
   n_mulch:=n_mulch+p^.n_menge;
   p:=p^.next_pool;
 end;
end;

procedure Tmulch_lay.sum_c(var c_mulch:real);
var p:p_ops_pool;
begin
 c_mulch:=0;
 p:=org_matter;
 while p<>NIL do
 begin
   c_mulch:=c_mulch+p^.c_menge;
   p:=p^.next_pool;
 end;
end;                    (***************

     procedure add_ops(c_ops:real;ops_ix:integer;var x:sysstat);
     begin
      i:=1;
      while (i<x.opsfra) and (x.ks.ops[i].nr<>ops_ix) do inc(i);
      if x.ks.ops[i].nr=ops_ix
           then
            begin                    { es existiert schon die gleiche Fraktion }
             x.ks.ops[i].c[1]:=x.ks.ops[i].c[1]+c_ops;
            end
           else
            begin
            if x.opsfra<maxfraz then inc(x.opsfra)
                                else { Fraktionszahl reduzieren }
                                 begin
                                  kill_ops_fra(x);
                                  inc(x.opsfra);
                                  if x.opsfra>maxfraz then
                                    begin
                                     add_message('zu viele OPS-Fraktionen ! - Abbruch');
                                     _halt(7);
                                    end;
                                  x.new_ops:=true;  {das Objekt "Boden" soll die OPS neu einordnen}
                                 end;
            i:=x.opsfra;
            x.ks.ops[i].c[1]:=c_ops;
            x.ks.ops[i].nr  :=ops_ix;
            x.new_ops:=true;
            end;
     end;
                                        *****************)
procedure Tmulch_lay.einarbeiten(var x:sysstat);
var p:p_ops_pool;

begin
  p:=org_matter;
  while p<>nil do
  begin
   //add_ops(p^.c_menge,p^.ops_nr,x);
   candy.scene.org_dng (99,p^.ops_nr,0,p^.c_menge,x,'0');
   p^.c_menge:=0;
   if p<>nil then p:=p^.next_pool;
  end;
end;

procedure Tmulch_lay.add_OM(ctot:real;ix:integer);
var p,p_:p_ops_pool;
    ops:string;
    ok:boolean;
    ntot,
    cnr      :real;
begin
// Transfer von externen Quellen in die Mulchschicht
 P:=org_matter;
 opsparm.select(ix,ops,ok);
 if not ok then _halt(6);
 cnr :=opsparm.parm('CNR');
 ntot:=ctot/cnr;
 while (p<>nil) and (p^.ops_nr<>ix) do
 begin
  p_:=p;
  p:=p^.next_pool;
 end;
 if p=nil then
 begin

   if org_matter=NIL then begin
                           new(org_matter) ;
                           p:=org_matter;
                          end
                     else begin
                           new( p_.next_pool );
                           p:=p_.next_pool
                          end;
   p^.c_menge:=0;
   p^.n_menge:=0;
   p^.ops_nr :=ix;
   p^.next_pool:=nil;
 end;

 p^.n_menge:=p^.n_menge+ntot;
 p^.c_menge:=p^.c_menge+ctot;
end;

destructor Tmulch_lay.DONE;
var p:p_ops_pool;
begin
 p:=org_matter;
 while org_matter <> nil do
 begin
   p:=org_matter^.next_pool;
   dispose(org_matter);
   org_matter:=p;
 end;
end;

procedure Tmulch_lay.daystep(var s:sysstat);
var x,bat,cadd,nadd:real;
    p    :p_ops_pool;
begin
 if s.wett.lt<0 then exit;   //keine Aktivitäten bei Frost
 x:=(s.wett.lt-35)/10;
 bat:=min(1,exp(x*ln(2.1)));
 x:=k_mulch*bat;
 if x>0 then
 begin
   p:=org_matter;
   while p<>nil do
   begin
     cadd:=x*p^.c_menge;
     if cadd>0 then
     begin
      nadd:=x*p^.n_menge;
      p^.c_menge:=p^.c_menge-cadd;
      p^.n_menge:=p^.n_menge-nadd;
     // add_ops(cadd,p^.ops_nr,s);
        candy.scene.org_dng (9,p^.ops_nr,0,cadd,s,'0');  // Weitergabe an den Boden
     end;
     p:=p^.next_pool;
   end;

 end;

end;

begin
end.
