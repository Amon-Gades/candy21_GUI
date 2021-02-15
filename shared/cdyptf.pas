{ a collection of pedotransfer functions; mainly used
to complete the required set of soil properties
}
unit cdyptf;

interface
uses math, FireDAC.Comp.Client;


type
T_material_property= record   // swms interface
                      thr,ths,tha,thm,alfa,n,ks,kk,thk,a,m : double;
                     end;
T_sparm           = record
                      v  : double;
                      org: boolean;
                     end;
T_soil_parameter = record
                      ton,u,sand,fat,
                      trd,tsd,
                      pv,fkap,pwp,
                      cif ,ks   : t_sparm;
                   end;
function  tsd_ruehlmann(dmin,ton, soc_proz:double):double;
function  get_dmin(tsd,ton,soc_proz:double):double;
function  trd_ruehlmann_new(b:double;ton, soc_proz:double):double;  // so ist es publiziert
function  get_ruehlmann_b(bd,ton,soc:double ):double;                // currently not used
function  txinterpol(x1,x2,y1,y2,y:double):double;
function  usda_schluff(ton, U:double):double;
function  usda_sand(ton,U :double):double;
function  ast4rb(prm:string;x, U:double):double;
function  h2the(mp:t_material_property; h:double):double;
function  the2h(mp:t_material_property; theta:double):double;
function  k_th(bt:real;mp:t_material_property; theta:double):double;
procedure mp_vereecken(ks, trd, corg, ton,u, sand:double; var s:real; var mp:t_material_property);
procedure mp_vereecken_(mode:integer;ks, trd, corg, ton,u, sand:double; var s:real; var mp:t_material_property);
procedure mp_vereecken0(ks, trd, corg, ton,u, sand:double; var s:real; var mp:t_material_property);
procedure mp_vereecken1(ks, trd, corg, ton,u, sand:double; var s:real; var mp:t_material_property);
procedure mp_hypres    (ks, trd, corg, ton,u, sand:double; var s:real; var mp:t_material_property);
procedure mp_zacharias(ks, trd, ton,u, sand:double; var mp:t_material_property);
procedure calc_capacity( TON, U, por, pwp_h,fkap_h  : real ; var pwp_k, FKap_k: Real);
procedure lieberoth_capacity(ton,ast:real; var pwp,fkap:real);
function  str2cif(pv,fkap,pwp,p1,p2,p3:double):double;
procedure dyn_cif( ton, schluff,crep_0,crep, corg,trd,h_pwp,h_fk:double;var p1,p2,p3, dcif,fkap,tsd,pvol,pwp:real);
function  calc_cif(abst:boolean;clay, silt, soc:double):extended;
procedure empty_parm_rec(var pr:t_soil_parameter);
procedure accept_parm_rec(ton,u,sand,fat,trd,tsd,pv,fkap,pwp,cif:double; var pr:t_soil_parameter);
procedure fill_up_parm_rec(mode:integer;corg,p1,p2,p3, pf_pwp,pf_fkap:real;var pr:t_soil_parameter);
procedure ptf_get_parm(var prm:T_sparm;V:double);
procedure write_parm_rec(pr:t_soil_parameter;hrz, fname:string;var new:boolean);
procedure insert_soil_prm( pr:t_soil_parameter;hrz:string; var fname:tfdtable);
procedure lambda_calc(ast:real; var lmbda:real);
procedure ks_calc(mode:integer; corg: real;sp:t_soil_parameter;  var  mp : t_material_property) ;

implementation

 // Materialeigenschaften nach van Genuchten
// input ks-gesättigte Leitfähigkeit (wird nur weitergegeben)
//       trd- bulkdensity, Trockenrohdichte
//       Corg- C-Gehalt in %
//       ton, u (schluff), sand nach DEUTSCHER Norm
// results :  s- usda sand
//            mp- record der materialeigenschaften


procedure mp_zacharias(ks, trd, ton,u, sand:double; var mp:t_material_property);
var s,t :double ; // converted particle size dist
begin
  t:=ton;
  s:=usda_sand(ton,U) ;
 // u_:=txinterpol(sand+u+t,u+t,2,0.063,0.05)-t;   //usda-schluff
 // s:=max(0.00000001,sand-u+u_);
  if s<66.6 then                                //usda-sand
  begin
    mp.ths:=0.788-0.263*trd+0.001*T;
    mp.thr:=0;
    mp.alfa:=roundto(exp(-0.648+0.023*s-3.1618*trd+0.044*t),-6); //cm->m
    mp.n   :=roundto(1.392-0.4189*power(s,-0.024)+1.212*power(t,-0.704),-6);
  end
  else
  begin
    mp.ths:=0.890-0.322*trd+0.001*T;
    mp.thr:=0;
    mp.alfa:=roundto(exp(-4.197+0.013*s-0.276*trd+0.076*t),-6); //cm->m
    mp.n   :=roundto(-2.562+7e-9*power(s,4.004)+3.750*power(t,-0.016),-6);
  end;
  mp.tha:=mp.thr;      mp.thm:=mp.ths;
  mp.m   :=1-1/mp.n;   mp.a   :=0.5;   mp.ks  := ks;
  mp.kk :=mp.ks;
  mp.thk:=mp.ths;
end;



procedure mp_vereecken_(mode:integer;ks, trd, corg, ton,u, sand:double; var s:real; var mp:t_material_property);
begin
  if mode=0 then  mp_vereecken0(ks, trd, corg, ton,u, sand, s, mp)  ;
  if mode=2 then  mp_vereecken1(ks, trd, corg, ton,u, sand, s, mp)  ;
  if mode=1 then  mp_hypres    (ks, trd, corg, ton,u, sand, s, mp)  ;
  end;
procedure mp_vereecken0(ks, trd, corg, ton,u, sand:double; var s:real; var mp:t_material_property);
var t,u_ :double ; // converted particle size dist
begin
  t:=ton;
  s :=usda_sand   (ton,U) ;
  u_:=usda_schluff(ton,u);

  mp.ths:=0.81-0.283*trd+0.001*T;
  mp.thr :=0.015+0.005*T+0.014*corg;
  mp.alfa:=roundto(exp(-2.486+0.025*s-0.351*corg-2.617*trd-0.023*t),-6); //cm->m
  mp.n   :=roundto(exp(0.053-0.009*s-0.013*t+0.00015*s*s),-6);
  mp.m   :=1 ;   mp.a   :=0.5;   mp.ks  := ks;   mp.tha:=mp.thr;   mp.thm:=mp.ths;
  mp.kk :=mp.ks;
  mp.thk:=mp.ths;
  s:=u_+s;
end;

procedure mp_vereecken1(ks, trd, corg, ton,u, sand:double; var s:real; var mp:t_material_property);
var t,u_ :double ; // converted particle size dist
begin
// ton und schluff in M%
// alpha in 1/cm              (ich bezweifele diese Einheit
// theta Werte als Relativzahl
  t:=ton;
  s :=usda_sand   (ton,u) ;

//  mp.ths:=0.81-0.283*trd+0.001*T;
  mp.ths:=0.6355-0.1631*trd+0.0013*T;
  mp.thm:=mp.ths;
  mp.thr:=0; // 0.015+0.005*T+0.014*corg;
  mp.tha:=mp.thr;
 // mp.alfa:=roundto(exp(-2.486+0.025*s-0.351*corg-2.617*trd-0.023*t),-6); // in 1/cm  bzw 1/hPa
  mp.alfa:=roundto(exp(-4.3003+0.0138*s-0.0992*corg        -0.0097*t),-6); // in 1/cm  bzw 1/hPa


 // mp.n   :=roundto(exp(0.053-0.009*s-0.013*t+0.00015*s*s),-6);
  mp.n   :=1 + roundto(exp(-1.0846-0.0085*s-0.0236*t+0.0001*s*s),-6);

  mp.m   :=1-1/mp.n;   mp.a   :=0.5;   mp.ks  := ks;
  mp.kk :=mp.ks;
  mp.thk:=mp.ths;

end;


procedure mp_hypres(ks, trd, corg, ton,u, sand:double; var s:real; var mp:t_material_property);
var a,nn,t,om,om2:double ; // converted particle size dist
begin
// ton und schluff in M%
// alpha in 1/cm              (ich bezweifele diese Einheit
// theta Werte als Relativzahl
  t:=ton;
  s :=usda_sand   (ton,u) ;

  OM:=1.724*corg;
  OM2:=OM*OM;

  mp.ths:=0.7919+0.001691*t-0.29619*trd-0.000001491*s*s+0.0000821*OM2+0.02427/t+0.01113/s+0.01472*ln(s)-0.0000733*OM*t-0.000619*trd*t-0.001183*trd*OM - 0.0001664*s;
  mp.thr:=0;
    mp.thm:=mp.ths; mp.tha:=mp.thr;
  a:=-14.96 + 0.03135*t + 0.0351*s + 0.646*OM +15.29*trd - 0.192 - 4.671*trd*trd - 0.000781*t*t - 0.00687*OM2 + 0.0449/OM + 0.0663*ln(s) + 0.1482*ln(OM) - 0.04546*trd*s - 0.4852*trd*OM +0.00673*t;
 mp.alfa:=exp(a);
 nn  :=-25.23 - 0.02195*t + 0.0074*s - 0.1940*OM + 45.5*trd - 7.24*trd*trd + 0.0003658*t*t + 0.002885*OM2 -12.81/trd - 0.1524/s - 0.01958/OM - 0.2876*ln(s) - 0.0709*ln(OM) - 44.6*ln(trd) - 0.02264*trd*t + 0.0896*trd*OM + 0.00718*t;
 mp.n:=exp(nn)+1;
 mp.m   :=1-1/mp.n;   mp.a   :=0.5;   mp.ks  := ks;
 mp.kk :=mp.ks;
 mp.thk:=mp.ths;

end;

procedure lieberoth_capacity(ton,ast:real; var pwp,fkap:real);
begin
// if ast<22  then
  FKAP:=3.40+0.85 * AST   ;       // Lieberoth, Bodenkunde S. 388
// else FKAP:=11.0+0.52 *AST;     // gilt eigentlich nicht für ton-Böden (ast ab 60)
  pwp :=1.23+0.74 * TON;     // ebenda S.389
end;



function  str2cif(pv,fkap,pwp,p1,p2,p3:double):double;
// clculation of CIF from structure
begin
result:= (pwp/p1)/( ( pwp/p1        )
                  +( (fkap-pwp)/p2 )
                  +( (pv-fkap )/p3 ) )    ;
end;


function  calc_cif(abst:boolean;clay, silt, soc:double):extended;
var p1,p2,p3,h_pwp,h_fkap,{fat,}ast,
   trd,tsd,pv,fkap,pwp :real;
   cif:extended;
begin
  p1  :=5;    p2  :=10;   p3  :=500;
  h_pwp:=power(10,4.2);   h_fkap:=power(10,1.8);
  trd :=trd_ruehlmann_new(0,clay,soc);
  tsd :=tsd_ruehlmann(0,clay,soc)  ;
  pv  :=100*(1-trd/tsd);
  ast :=txinterpol(clay,clay+silt,0.002,0.063,0.01);
  if (abst) and (ast<22)
   then
   begin
    lieberoth_capacity(clay,ast,pwp,fkap);
   end
   else
   calc_capacity(clay,silt,pv,h_pwp,h_fkap,pwp,fkap);// Books-Corey
   cif := str2cif(pv,fkap,pwp,p1,p2,p3);
   calc_cif:=cif;
end;

procedure dyn_cif( ton, schluff,crep_0,crep, corg,trd,h_pwp,h_fk:double;var p1,p2,p3, dcif,fkap,tsd,pvol,pwp:real);
// schluff und sand nach deutscher Norm !!
var s :real;
    sand:real ;
    mp: t_material_property;
begin
  sand:=100-ton-schluff;
  tsd:= tsd_ruehlmann(-99,ton,corg);      // -99 bedeutet Fehlwert; OK
  pvol:=100*(1-trd/tsd);
  //var3:  Rawls
  calc_capacity(ton,schluff,pvol,h_pwp,h_fk,pwp,fkap);
  p1:=4+(crep_0-crep)/55.0;
  p1:=min(p1,p2*1.8);
  p1:=max(p1,2);
  dcif:=str2cif(pvol,fkap,pwp,p1,p2,p3);
end;

function trd_ruehlmann_new(b:double;ton, soc_proz:double):double;  // so ist es publiziert
var a_trd, faktor:double;
begin
 if b<>0 then faktor:= 2.684+140.943*b    // b: after site specific calibration
         else
         begin                               // 'standardisierte' Dichte nach Rühlmann&Körschens 2009
              faktor:= 1.78345- 0.0081*ton;  // ebenda angegebene Regressionsgleichung
              // old  b     := -0.0778;
              // consistent solution: 7/2016
              b:=(faktor-2.684)/140.943
         end;
  a_trd:= faktor*exp(b*soc_proz*10);  // eq. 4 bei Rühlmann&Koerschens
 // jr_b:=b;      // b wert merken !!
 result:=a_trd;
end;

function get_ruehlmann_b(bd,ton,soc:double ):double;
 var L,H,dx,dl,dh,x,k:real;
 cnt:longint;
 begin
  L:=-0.01;
  H:=0;
  cnt:=0;
  dl:=trd_ruehlmann_new(L,ton,soc)-bd ;
  dh:=trd_ruehlmann_new(H,ton,soc)-bd ;
  repeat
     x:=(abs(dh)*l+abs(dl)*h)/(abs(dh)+abs(dl));
     dx:= trd_ruehlmann_new(x,ton,soc)-bd ;
     if (dx<0) then begin
                      dl:=dx;
                      l:=x;
                    end
               else begin
                      dh:=dx;
                      h:=x;
                    end;
      inc(cnt);
     k:= abs(dx)/bd;
  until (  k<0.000001  );
  get_ruehlmann_b:=x;
 end;

 function get_dmin(tsd,ton,soc_proz:double):double;
var dmin, qos,roh_om,  obsm:double;
begin
  qos   :=soc_proz/55;
  roh_om:= 1.127+0.373*qos;
  dmin:=(1-qos)*tsd*roh_om /( roh_om-qos);
end;



procedure insert_soil_prm( pr:t_soil_parameter;hrz:string; var fname:tfdtable);
begin
  fname.Append;
  fname.FieldByName('NAME').AsString:=hrz;
  fname.FieldByName('clay').asfloat :=pr.ton.v;
  fname.FieldByName('silt').asfloat :=pr.u.v;
  fname.FieldByName('FAT').asfloat :=pr.fat.v;
  fname.FieldByName('BD').asfloat :=pr.trd.v;
  fname.FieldByName('PD').asfloat :=pr.tsd.v;
  fname.FieldByName('PV').asfloat :=pr.pv.v;
  fname.FieldByName('FC').asfloat :=pr.fkap.v;
  fname.FieldByName('PWP').asfloat :=pr.pwp.v;
  fname.FieldByName('CIP').asfloat :=pr.cif.v;
  fname.FieldByName('KS').asfloat :=pr.ks.v;

  fname.post;
end;

procedure write_parm_rec(pr:t_soil_parameter;hrz, fname:string;var new:boolean);
var f:textfile;
begin
assignfile(f,fname);
if new then begin rewrite(f); new:=false;end else append(f);
writeln(f,'horizon, parameter, value, original');
write(f,hrz); write(f,', clay, ');write(f,pr.ton.v); write(f,', ');writeln(f,pr.ton.org);
write(f,hrz); write(f,', silt, ');write(f,pr.u.v);   write(f,', ');writeln(f,pr.u.org);
write(f,hrz); write(f,', sand, ');write(f,pr.sand.v);write(f,', ');writeln(f,pr.sand.org);
write(f,hrz); write(f,', FAT, ');write(f,pr.fat.v);write(f,', ');writeln(f,pr.fat.org);
write(f,hrz); write(f,', bd, ');write(f,pr.trd.v);write(f,', ');writeln(f,pr.trd.org);
write(f,hrz); write(f,', pd, ');write(f,pr.tsd.v);write(f,', ');writeln(f,pr.tsd.org);
write(f,hrz); write(f,', pvol, ');write(f,pr.pv.v);write(f,', ');writeln(f,pr.pv.org);
write(f,hrz); write(f,', fcap, ');write(f,pr.fkap.v);write(f,', ');writeln(f,pr.fkap.org);
write(f,hrz); write(f,', pwp, ');write(f,pr.pwp.v);write(f,', ');writeln(f,pr.pwp.org);
write(f,hrz); write(f,', cif, ');write(f,pr.cif.v);write(f,', ');writeln(f,pr.cif.org);
write(f,hrz); write(f,', ks, ');write(f,pr.ks.v);write(f,', ');writeln(f,pr.ks.org);
close(f);
end;

procedure ks_calc(mode:integer; corg: real;sp:t_soil_parameter; var  mp : t_material_property);
var at,l,s,e,t:real;
begin
 e:=sp.pv.v;
 t:=sp.ton.v;
 s:=usda_sand(sp.ton.v,sp.u.v);
if mode =1 then   // aus lambda
begin
 at :=txinterpol(sp.fat.v,sp.u.v+sp.ton.v,0.0063,0.063,0.01);
 lambda_calc(at,l);
 mp.ks:=100*l*(sp.pv.v-sp.fkap.v); //in mm/d
end;
if mode=2 then // R&B
begin

   l:= 20.5-2*t;
   mp.ks:=10*exp(l);
end;

if mode=3 then
begin
 mp.ks:=25.4*power(10,(-0.6+0.0126*S-0.0064*T))*24 ;   //nach Cosby et al. 1984

end;

end;

function  k_th(bt:real; mp:t_material_property; theta:double):double;
var  kt,kr,se:double;
begin
   //   bt:=20;
      if bt<-0.5 then kt:=0
                 else kt:=998.12/(0.5548*bt*bt-49.57*bt+1767.6) ;

      if theta>= mp.thm then   kr:=1
                        else

                        begin
                         se:= (theta-mp.tha)/(mp.thm-mp.tha);
                         if se<=0 then kr:=0
                                  else kr:= sqrt(se)*sqr(1-power((1-power(se,1/mp.m)),mp.m));
                        end;
     k_th:=mp.ks*kr/100;  // k in mm/d       //testweise durch 100 dividiert
end;


procedure ptf_get_parm(var prm:t_sparm; V:double)   ;
begin
  prm.v:=-99;
  prm.org:=true;
  if not( v= -99) then  prm.v:=v else prm.org:=false;
end;

procedure rbs2tex(ba:string; ton:double; var u,s:double);

begin

end;



procedure lambda_calc(ast:real; var lmbda:real);
begin
 lmbda:=1.6-0.1565*ast+0.008424*ast*ast-0.0002551*ast*ast*ast;
 lmbda:=lmbda+0.00000428*power(ast,4)-0.00000003625*power(ast,5)+0.0000000001207*power(ast,6);
end;


procedure fill_up_parm_rec(mode:integer;corg,p1,p2,p3, pf_pwp,pf_fkap:real;var pr:t_soil_parameter);
var x_pwp,x_fkap,h_fkap,h_pwp,dummy,ast :real;
    matp:  t_material_property;
begin
// ton, schluff und sand MUESSEN bekannt sein

 if pr.fat.v<0 then pr.fat.v:=txinterpol(pr.ton.v,pr.u.v,0.002,0.063,0.0063);
  ast :=txinterpol(pr.fat.v,pr.u.v+pr.ton.v,0.0063,0.063,0.01);
 if corg=0 then corg:=0.04*pr.fat.v+0.5;  // ganz grobe Hausnummer

 if pr.trd.v<0 then pr.trd.v:=trd_ruehlmann_new(0,pr.ton.v,corg);

 if pr.tsd.v<0 then
  if pr.pv.v<0 then pr.tsd.v:=tsd_ruehlmann(0,pr.ton.v,corg)
               else pr.tsd.v:=pr.trd.v/(1-pr.pv.v/100);
 if pr.pv.v<0 then  pr.pv.v:=100*(1-pr.trd.v/pr.tsd.v);

 //Hilfsgrößen ausrechenen
 h_fkap:=power(10,pf_fkap);
 h_pwp :=power(10,pf_pwp);

 if mode=1 then  calc_capacity(pr.ton.v,pr.u.v,pr.pv.v,h_pwp,h_fkap,x_pwp,x_fkap);  // Broocks-Corey

 if mode=2 then //Vereecken/vanGenuchten
 begin
     mp_vereecken(-99,pr.trd.v,corg,pr.ton.v,pr.u.v, pr.sand.v,dummy, matp);
     x_fkap:= h2the(matp,-1*h_fkap)*100;
     x_pwp := h2the(matp,-1*h_pwp)*100;
 end;

 if mode=3 then //Lieberoth
 begin
     lieberoth_capacity(pr.ton.v,ast,x_pwp,x_fkap);
 end;

  if mode=4 then //Zacharias/vanGenuchten
 begin
     mp_zacharias(-99,pr.trd.v,pr.ton.v,pr.u.v, pr.sand.v, matp);
     x_fkap:= h2the(matp,-1*h_fkap)*100;
     x_pwp := h2the(matp,-1*h_pwp)*100;
 end;


 if pr.fkap.v<0 then    pr.fkap.v:=x_fkap;

 if pr.pwp.v<0 then     pr.pwp.v:=x_pwp;

 if pr.cif.v<0 then pr.cif.v:=(pr.pwp.v/p1)/((pr.pwp.v/p1)+((pr.fkap.v-pr.pwp.v)/p2)+((pr.pv.v-pr.fkap.v)/p3));


 ks_calc(3{mode}, corg, pr,  matp ) ;

 if pr.ks.v<0 then
 begin
  pr.ks.v:=matp.ks;
  pr.ks.org:=false;
 end;
end;


procedure accept_parm_rec(ton,u,sand,fat,trd,tsd,pv,fkap,pwp,cif:double; var pr:t_soil_parameter);
begin
  if ton>0 then
  begin
    pr.ton.v:=ton;
    pr.ton.org:=true;
  end;
  if u>0 then
  begin
    pr.u.v:=u;
    pr.u.org:=true;
  end;
  if sand>0 then
  begin
    pr.sand.v:=sand;
    pr.sand.org:=true;
  end;

  if fat>0 then
  begin
    pr.fat.v:=fat;
    pr.fat.org:=true;
  end;

  if trd>0 then
  begin
    pr.trd.v:=trd;
    pr.trd.org:=true;
  end;

  if tsd>0 then
  begin
    pr.tsd.v:=tsd;
    pr.tsd.org:=true;
  end;

  if pv>0 then
  begin
    pr.pv.v:=pv;
    pr.pv.org:=true;
  end;

  if fkap>0 then
  begin
    pr.fkap.v:=fkap;
    pr.fkap.org:=true;
  end;

    if pwp>0 then
  begin
    pr.pwp.v:=pwp;
    pr.pwp.org:=true;
  end;

  if cif>0 then
  begin
    pr.cif.v:=cif;
    pr.cif.org:=true;
  end;
end;

procedure empty_parm_rec(var pr:t_soil_parameter);
begin
with pr do
begin
 ton.v:=-99; ton.org:=false;
 u.v:=-99;   u.org:=false;
 sand.v:=-99;sand.org:=false;
 fat.v:=-99; fat.org:=false;
 trd.v:=-99; trd.org:=false;
 tsd.v:=-99; tsd.org:=false;
 pv.v:=-99;  pv.org:=false;
 fkap.v:=-99;fkap.org:=false;
 pwp.v:=-99; pwp.org:=false;
 cif.v:=-99; cif.org:=false;
 ks.v:=-99;  ks.org:=false;
end;//with
end;

function trd_ruehlmann_alt(b,ton, soc_proz:double):double;
var a_trd:double;
begin                       // alte Version, beruht auf personal communication
 if b<>0 then  a_trd:= (2.631+15.811*b)*exp(b*soc_proz)
         else  a_TRD:= 1.64 - 0.0075*TON -0.0611* soc_proz;
 result:=a_trd;
end;

function trd_ruehlmann(b,ton, soc_proz:double):double;  // so ist es publiziert
var a_trd, faktor:double;
begin
 if b<>0 then faktor:= 2.684+14.0943*b    // b: after site specific calibration
         else
         begin                               // 'standardisierte' Dichte nach Rühlmann&Körschen 2009
              faktor:= 1.78345- 0.0081*ton;  // ebenda angegebene Regressionsgleichung
              b     := -0.0778;
         end;
  a_trd:= faktor*exp(b*soc_proz);  // eq. 4 bei Rühlmann&Koerschens

 result:=a_trd;
end;



function tsd_ruehlmann(dmin,ton, soc_proz:double):double;
var r_tsd,qos,roh_om:double;
begin
// dmin an Bodendaten anpassen  dmin:=2.659+0.003*t;
  if dmin<=0 then dmin:= 2.659+0.003*ton;
  qos:=soc_proz/55;
  roh_om:= 1.127+0.373*qos;
  r_tsd:=qos/roh_om + (1-qos)/dmin;            // ruhlmann: std=2.684;
  result:=1/r_tsd;
end;


// Theta in pressure head umrechnen (van genuchten-Ansatz)
// input: materialeigenschaften
 function  the2h(mp:t_material_property; theta:double):double;
 var qth,h1,h2,h4,diff:double;
 begin
   diff:=(theta-mp.tha);
 if diff<0 then diff:=0.000001;
    qth:=(mp.thm-mp.tha)/diff;
    h4:=exp(ln(qth)/mp.m);
    if h4>1 then
    begin
    h1:=ln( h4-1);
    h2:= exp(h1/mp.n);
    end else h2:=0.01;
    the2h:=h2/mp.alfa;
 end;

// pressure head in Theta umrechnen (van genuchten-Ansatz)
// input: materialeigenschaften
 function  h2the(mp:t_material_property; h:double):double;
 begin
   // funktioniert wenn h in cm gegeben; alpha=0.0174; n=1.3757; m:=1-1/n
   if h<0 then
   begin
   h:=abs(h);
   h2the := mp.tha+(mp.thm-mp.tha)/power((1+power(mp.alfa*h,mp.n)),mp.m);
   end else h2the:=mp.thm;
 end;

 // ton:  D,USDA => 0.002
 // schluff D=> 0.063 ; USDA => 0.05

function  usda_schluff(ton, U:double):double;
 begin
    usda_schluff:=txinterpol(ton,u,0.002,0.063,0.05);
 end;

function usda_sand(ton,U :double):double;
begin
    usda_sand:= 100-ton-usda_schluff(ton,u);
end;


function  ast4rb(prm:string;x, U:double):double;
var ast:double;
 begin
   ast:=-99;
    if prm='TON' then ast :=txinterpol(x,u,0.002,0.063,0.01);
    if prm='FAT' then ast :=txinterpol(x,u,0.006,0.063,0.01);
   result:=ast;
 end;



//  Texturinterpolation input: yi:Korngröße, xi:Mengenanteil
//                                 result: Mengenanteil für Korngröße y
function txinterpol(x1,x2,y1,y2,y:double):double;
var ly2,ly1,lx1,lx2,lx,ly:double;
begin
    lx1:=x1;
    lx2:=x2;
    ly:=ln(y);
    ly1:=ln(y1);
    ly2:=ln(y2);
    lx:=lx1+(ly-ly1)*(lx2-lx1)/(ly2-ly1);
    txinterpol:=lx;
end;

// Materialeigenschaften nach van Genuchten
// input ks-gesättigte Leitfähigkeit (wird nur weitergegeben)
//       trd- bulkdensity, Trockenrohdichte
//       Corg- C-Gehalt in %
//       ton, u (schluff), sand nach DEUTSCHER Norm
// results :  s- usda sand
//            mp- record der materialeigenschaften

procedure mp_vereecken(ks, trd, corg, ton,u, sand:double; var s:real; var mp:t_material_property);
var t,u_ :double ; // converted particle size dist
begin
// ton und schluff in M%
// alpha in 1/cm
// theta Werte als Relativzahl
  t:=ton;
  u_:=txinterpol(u+t,t,0.063,0.002,0.05)-t;   //usda-schluff
  s:=100-t-u_;                                //usda-sand
  mp.ths:=0.81-0.283*trd+0.001*T;
  mp.thm:=mp.ths;
  mp.thr:=0.015+0.005*T+0.014*corg;
  mp.tha:=mp.thr;
  mp.alfa:=roundto(exp(-2.486+0.025*s-0.351*corg-2.617*trd-0.023*t),-6); // in 1/cm  bzw 1/hPa
  mp.n   :=roundto(exp(0.053-0.009*s-0.013*t+0.00015*s*s),-6);
  mp.m   :=1;   mp.a   :=0.5;   mp.ks  := ks;
  mp.kk :=mp.ks;
  mp.thk:=mp.ths;

end;

  procedure calc_capacity( TON, U, por, pwp_h,fkap_h  : real ; var pwp_k, FKap_k : Real);
    // Bedeutung der Parameter:         TON---> Ton, silt---> Schluff,
    // Indikatorgrößen für PWP und FKAP -->    H_c_PWP =15000;    H_c_FKAP=60;

  var  y_b,q_r,q_e,lam,sand_c:   Real;

  begin//prozedur

    //Fkap und PWP ausrechnen
    //Bestimmung von FKAP und PWP mit Brooks-Corey-Parametern;
    //Lit.: Rawls, W. J., Brakensiek, D.L.: Prediction of Soil Water Properties for Hydrologic Modeling
    // ist die Verwendung der Korngrößen hier sachlich richtig ????
     por:=por/100;

     sand_c:=usda_sand(ton,U);

     y_b:=EXP(5.3396738+0.1845038*TON-2.48394546*por-0.00213853*TON*TON-0.04356349*sand_c*por-0.61745089*TON*por+0.00143598*sand_c*sand_c*por*por-0.00855375*TON*TON*por*por-0.00001282*sand_c*sand_c*TON+0.00895359*TON*TON*por-0.00072472*sand_c*sand_c*por+0.0000054*TON*TON*sand_c+0.5002806*por*por*TON);
     lam:=EXP(-0.7842831+0.0177544*sand_c-1.062498*por-0.00005304*sand_c*sand_c-0.00273493*TON*TON+1.11134946*por*por-0.03088295*sand_c*por+0.00026587*sand_c*sand_c*por*por-0.00610522*TON*TON*por*por-0.00000235*sand_c*sand_c*TON+0.00798746*TON*TON*por-0.00674491*por*por*TON);
     q_r:=-0.0182482+0.00087269*sand_c+0.00513488*TON+0.02939286*por-0.00015395*TON*TON-0.0010827*sand_c*por-0.00018233*TON*TON*por*por+0.00030703*TON*TON*por-0.0023584*por*por*TON;
     q_e:=0.01162-0.001473*sand_c-0.002236*TON+0.98402*por+0.0000987*TON*TON+0.003616*sand_c*por-0.010859*TON*por-0.000096*TON*TON*por-0.002437*por*por*sand_c+0.0115395*por*por*TON;

    // PWP=f(pwp_h)
     pwp_k:=(q_r+(q_e-q_r)*exp(lam*ln(y_b/pwp_h)))*100;

    //FKAP=f(fkap_h)
     fkap_k:=(q_r+(q_e-q_r)*exp(lam*ln(y_b/fkap_h)))*100;

  end;(*procedure *)


end.
