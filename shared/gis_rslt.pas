{provides routines for result processing together with @link(cnd_rs_2)}
{$INCLUDE cdy_definitions.pas}
unit gis_rslt;
interface
uses

{$IFDEF CDY_GUI}
cdy_glob,
{$ENDIF}
{$IFDEF CDY_SRV}
cdy_config,
{$ENDIF}
cnd_vars,


//  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
//  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
//  FireDAC.Phys, FireDAC.Phys.MSAcc, FireDAC.Phys.MSAccDef, FireDAC.VCLUI.Wait,
  FireDAC.Comp.Client,

  {$IFDEF CDY_GUI}
 registry,
  windows,
{$ENDIF}
  classes,strutils,sysutils;

type TinfoRec=record
                 index      : integer;
                 mix        : integer;
                 Name       : String[50];
                 Format,
                 Basis,
                 Kurzbez,
                 Einheit    : string[15];
                 Typ        : string[2];   // i_types: 0 = single value; 1 = sum; 2 = average
                 faktor     : real;
                 offset,
                 offset2     : longint;
                 adpt        : boolean;
               end;

     PanyRslt=^anyRslt;
     anyRslt= object {Ursprung aller Einzel-Result-Objekte(, die auf statrec zugreifen)}
                 rslt_type:byte;
                 soildepth,
                 ljahr    : integer;
                 adr      : pointer;
                 value,
                 resultat : real;    { Wert}
                 sum_val  : real;    {Hilfssumme}
                 N_val    : integer; { Anzahl d. Einzelwerte}
                 S_val    : real;    { Streuung}
                 info     : TinfoRec;
                 constructor init( inf :tinforec );
                 destructor  done;
                 procedure   reset;     virtual;
                 procedure   get_value;  virtual;
                 procedure   update;
                 procedure   get_dim; virtual;
                 procedure   put_value(d:string;gis:boolean); virtual;
               end;

     Psv_Rslt=^Tsv_Rslt;              {single value}
     Tsv_Rslt= object(anyRslt) {Vorfahr fuer aktuelle Result-Objekte, d.h. der Wert der Zustandsgröße an genau einem Termin}
                 constructor init( inf :tinforec);
                 destructor  done;
                 procedure   get_value;  virtual; {legt Einzelwert auf value ab}
               end;

     Pvv_Rslt=^Tvv_Rslt;              {vector value}
     Tvv_Rslt= object(anyRslt) {Vorfahr fuer aktuelle Result-Objekte, d.h. der Wert der Zustandsgröße an genau einem Termin}
                  n1,n2 :byte;   {erste und letzte Komponente des Sub-Vektors }
                 constructor init( inf :tinforec; i,j:byte );
                 destructor  done;
                 procedure   get_value;  virtual;   {legt Mittelwert(n1,n2) auf value ab}
               end;

     Pvt_Rslt=^Tvt_Rslt;              {total vector value}
     Tvt_Rslt= object(Tvv_Rslt) {Vorfahr fuer aktuelle Result-Objekte, d.h. der Wert der Zustandsgröße an genau einem Termin}
                 constructor init( inf :tinforec);
                 destructor  done;
                 procedure   get_dim; virtual; {n1:=1,legt  n2 aus profiltiefe fest}
               end;

     PRsltRec=^TRsltRec;
     TRsltRec=record
                 RSLT:PanyRslt;
                 next:PRsltRec;
              end;


     TCDY_Rslt= class(Tobject)
                  lst,
                  rtab    : TFDtable;
                  rqry    : TFDquery;
                  cdy_stat :statrec;
                  all_RSLT,
                  sel_RSLT :PRsltRec;
                  activated,                 {true nach reset}
                  _file    :boolean;
                  yr_end   :string;
                  res_FILE :text;
                  res_obj,                   {Anzahl der registrierten Objekte}
                  res_obj_sel,               {Anzahl der selektierten Objekte}
                  output_f :integer;
                  constructor create;
                  destructor  done;
                  procedure close_rslt;
                  procedure reset(OName :string {;  sprm:Tsimparm});
                  procedure makereslist;
                  procedure update( simj,aktj:integer {; sprm:Tsimparm}) ;
                  procedure register_RSLT(r:PanyRslt);
                end;

//var cdy_res:Tcdy_rslt;


implementation
uses   db,  ok_dlg1 ,  cnd_util,soilprf3,cdyspsys ,cdyparm;




constructor Tcdy_rslt.create;
 {$IFDEF CDY_GUI}

var cdy_ini:tregistry;
   {$ENDIF}
begin
 _file    :=false;
 activated:=false;
 new(all_rslt);
 all_rslt^.rslt:=NIL;
 all_rslt^.next:=NIL;
 new(sel_Rslt);
 sel_rslt^.rslt:=NIL;
 sel_rslt^.next:=NIL;
 output_f := 0;
 res_obj  := 0;
 res_obj_sel:=0;


 {$IFDEF CDY_GUI}
 cdy_ini:=tregistry.create;
  try
     cdy_ini.RootKey := HKEY_CURRENT_USER;
     cdy_ini.openkey('\Software\candy\switches', false);
     yr_end:=cdy_ini.ReadString('yr_end');
 finally
 cdy_ini.closekey;
 cdy_ini.free;
 inherited;
 end;
 {$ELSE}
 yr_end:=cdy_set.yr_end;
  {$ENDIF}

end;

procedure Tcdy_rslt.close_rslt;
begin
 if _file then close(res_file);
 _file:=false;
 if false //K database<>nil
 then
 begin

 end;
end;

destructor Tcdy_rslt.done;
begin
 close_rslt;
 _file:=false;
end;

procedure Tcdy_rslt.reset(OName :string{;  sprm:Tsimparm});
{
 eigentliche Initialisierung des Objektes
  - die Liste der selektierten Objekte wird aufgestellt (nach Tabelle in rstlprm)
  - die Datei für die Ausgabe wird angelegt
  - der Datei-Header wird geschrieben
  - die Frequenz für die Aufzeichnung wird initialisiert
}
var //db:p_db_file;
    p,s :PRsltrec;

    db_index:integer;

    idx,
    mw_ix ,i  :integer;
    x:real;
    hsa,   //hilfsstring
    sel,
    rname:string;
    qry:tfdquery;
    rntab:tfdtable;


begin
 output_f := candy.cdy_switch.rslt_freq;
 rntab:=tfdtable.Create(nil);
 rntab.connection:=dbc;//allg_parm.Connection;
 rntab.TableName:='CDY_RSLT';
 rntab.Open;
                                                   //res_obj  := 0;
 res_obj_sel:=0;

 //if (not sprm.risk_ana) or (sprm.risk_ana and not activated) then
// if not false then

// begin
   rname:=candy.cdyconnex^.cdy_res_path+candy.cdyconnex^.RunName+'.res';
   if res_obj>0 then
   {#1}
     begin
       {Schritt 1: Auswahlliste aufstellen}
      if sel_rslt<>NIL then
      repeat
       s:=sel_RSLT;
       sel_rslt:=sel_rslt.next;
       dispose(s);
      until sel_rslt=nil;
      new(sel_rslt);
      s:=sel_rslt;
      s.RSLT:=nil;
      s.next:=nil;
      for i:= 1 to rsltprm.cnt.Count do
       begin  {Objektzeiger in die Auswahlliste stellen}
        rsltprm.get_item(i-1,'AUSWAHL',idx,sel);
        if sel='*' then
        begin
         db_index:=integer(rsltprm.get_pval(idx,'RESULTNR'));
         p:=all_rslt; {1. Liste der registrierten Objekte durchsuchen}
         while (p<>NIL) and (p^.next<>NIL) and (p^.rslt^.info.index<>db_index) do p:=p^.next;
         if p^.rslt^.info.index=db_index then { Treffer !!}
         begin
           inc(res_obj_sel);
           if s^.rslt=NIL
           then  s^.rslt:=p^.rslt    {spezial: erster Eintrag}
           else
             begin  {normaler Fall}
               new(s^.next);
               s:=s^.next;
               s^.rslt:=p^.rslt;
               s^.next:=nil;
               s.RSLT.reset;
             end;
             s^.rslt^.info.mix:=mw_ix;
             x:=rsltprm.parm('I_TYPE');
             hsa:='ZFM';
             if  (ansichar (s^.rslt^.info.Typ[1]) <> ansichar(hsa[round(x)+1]) )
             then
             begin
            {$IFDEF CDY_GUI}
             ok_dlg.label1.caption:=' i_type will be changed for '+ s^.rslt^.info.Name+' from '+ s^.rslt^.info.Typ[1]+' to '+hsa[round(x)+1];
             ok_dlg.ShowModal;
             {$ENDIF}
             s^.rslt^.info.Typ[1]:=ansichar(hsa[round(x)+1]);
             end;
             s.RSLT.reset;
         end;
         if s^.rslt^.rslt_type=210 then
          begin
            s^.rslt^.get_dim;
          end;
         end; //if auswahl
       end;
    // Testweise gismode Standard setzen !!!

       begin  // im Gis_mode wird keine textdatei geschrieben !!
       rtab    :=tfdtable.create(nil);
       rtab.connection:=dbc; //allg_parm.connection;
       rtab.TableName:=candy.cdyconnex^.runname; //sprm.ergfile;
       rqry    :=Tfdquery.Create(nil);
       rqry.Connection:=dbc; //allg_parm.Connection;
       rqry.SQL.Clear;
        try
         rtab.open;
         except
         if length(candy.cdyconnex^.runname)<3 then candy.cdyconnex^.runname:='RS_0';
         qry:=tfdquery.create(nil);
         qry.connection:=dbc;//allg_parm.connection;
         if dbc.Params.DriverID='PG'
         then  qry.SQL.Add('create table '+candy.cdyconnex^.runname+'( id serial not null,datum timestamp, merkmal_id integer, objekt_id integer,wert double precision) ')
         else   qry.SQL.Add('create table '+candy.cdyconnex^.runname+'( id autoincrement not null,datum datetime, merkmal_id integer, objekt_id integer,wert single) ');
         qry.ExecSQL;
         qry.Free;
         rtab.Open;
        end;
       rqry.SQL.Clear;
       rqry.SQL.Add('delete from '+candy.cdyconnex^.runname+' where objekt_id='+candy.cdyconnex^.simobject {objekt_id});
       rqry.ExecSQL;

       rtab.First;
       s:=sel_rslt;

       lst:=tfdtable.create(nil);
       lst.connection:=dbc;//allg_parm.Connection;
       lst.TableName:= 'CDY_RSLT';
       lst.Open;

       if s.RSLT<>nil then
       while s<>NIL do
         begin
          inc(db_index);
          lst.Locate('RESULTNR',variant(s^.rslt^.info.index),[]);
      //    prmdlgf.table1.locate('OBJEKTNR',variant(s^.rslt^.info.index),[]);
      //    s^.rslt^.info.name:=prmdlgf.table1.fieldbyname('RESULTAT').asstring;
            s^.rslt^.info.name:=lst.fieldbyname('RESULTAT').asstring;
          s:=s^.next;
         end;

       end;

     end;
   {#1}
   activated:=true;

   //end; {if not risk_ana}
   rntab.Close;
   rntab.Free;
end;

procedure Tcdy_rslt.makereslist;
var p:Prsltrec;
    rntab:tfdtable;
begin
 rntab:=tfdtable.Create(nil);
 rntab.connection:=dbc;//allg_parm.Connection;
 rntab.TableName:='CDY_RSLT';
 rntab.Open;
 p:=all_rslt;
 while p<>nil do
 begin
   if  not rntab.Locate('RESULTNR',p.RSLT.info.index,[loCaseInsensitive]) then
   begin
    rntab.Append;
    rntab.FieldByName('RESULTNR').AsInteger:=p.RSLT.info.index;
    rntab.FieldByName('UNIT').AsString:=     p.RSLT.info.Einheit;
    rntab.FieldByName('RESULTAT').AsString:=  p.RSLT.info.Kurzbez;
    rntab.FieldByName('I_TYPE').AsInteger:= pos(p.RSLT.info.typ[1],'ZFM')-1;
    if rntab.FindField('REMARK')<>nil then  rntab.FieldByname('REMARK').AsString:=p.RSLT.info.Name;
    rntab.Post;
   end;
   p:=p^.next;
 end;

end;

procedure Tcdy_rslt.update( simj,aktj:integer{; sprm:Tsimparm}) ;
{
  -> diese Routine kann erst nach dem RESET aufgerufen werden
  alle Einträge der Liste mit den selektierten Objekten werden abgearbeitet
  jeder Eintrag verweist auf ein Resultatobjekt, dessen Methoden aktiviert werden

}

var p:pRsltRec;
    output:boolean;
    a_dat,
    heute,
    morgen:string;

function match(s1,s2:string):boolean;
var i:byte;
begin
 i:=pos(s1,s2);
 match:=i<>0;
end;

begin
  if res_obj_sel>0 then  {Anzahl der selektierten Objekte}
  begin
    {Bestimmen ob Ausgabe erfoderlich}
   (*
    if sprm.risk_ana
    then
     begin
       output:=({sprm.simend}cdy_connex^.edatum=essdatum(candy.s.ks.tag,simj));
     end
    else
    *)
     begin
      (*
      if sprm.random_fert then
      begin
        heute:= copy(datum(candy.s.ks.tag,aktj{original: simj}),1,5);
        output:=containsstr(heute,yr_end); //  false; alte notlösung
      end
      else
      *)
        begin
        morgen:= copy(datum(candy.s.ks.tag+1,aktj{original: simj}),1,2);
        heute:= copy(datum(candy.s.ks.tag,aktj),1,5);
       {old
         output:=  daydruck
               or (pendruck and match(morgen,'01 06 11 16 21 26'))
               or (dedruck  and match(morgen,'01 11 21'))
               or ((morgen='01') and modruck)
               or (containsstr(heute,yr_end) and yrdruck)
               or (candy.res_event);
        }
        //new
        output:= (output_f=1)                                           //daydruck
               or ((output_f=2) and match(morgen,'01 06 11 16 21 26'))  //pendruck
               or ((output_f=3)  and match(morgen,'01 11 21'))          //dedruck
               or ((morgen='01') and (output_f=4))                      //modruck
               or (containsstr(heute,yr_end) and (output_f=5))          //yrdruck
               or (candy.res_event);

       end;
     end;
    if output then
    begin
     candy.res_event:=false;
     if candy.s.ks.tag=0 then inc(simj); {Notlösung zur Korrektur des Datum}
     a_dat:= copy(datum(candy.s.ks.tag,aktj),1,6)+copy(essdatum(candy.s.ks.tag,simj),7,4);
     if (output_f=4)and (copy(a_dat,1,2)='29') then                //modruck im schaltjahr
     begin
       if not ist_schaltjahr(simj) then a_dat[2]:='8';
     end;
//test
    end;

    p:=sel_rslt;   {Selektionsliste}
    while p<>NIL do
    begin
       p^.rslt^.get_value;
       p^.rslt^.update;             {Methode des Objektes aufrufen   }
       if output then
        begin
         p^.rslt^.put_value(a_dat,true);   {Objekt zum Schreiben veranlassen}
         p^.rslt^.reset;       {rückstellen}
        end;
       p:=p^.next;
    end;
  //  if output and not sprm.gis_mode then writeln(res_file); {Zeile abschlieáen}
  end;
end;

procedure Tcdy_rslt.register_RSLT(r:PanyRslt);
var p:pRsltRec;
begin
   p:=all_rslt;
   if p^.rslt=NIL
    then p^.rslt:=r     {erster Eintrag}
    else
    begin
       while p^.next<>NIL do p:=p^.next;
       new(p^.next);
       p:=p^.next;
       p^.next:=NIL;
       p^.rslt:=r;
    end;
   inc(res_obj);
end;


constructor anyrslt.init(inf:tinforec);
begin
 info:=inf;
 ljahr:=-1;
 n_val:=0;
 sum_val:=0;
 resultat:=0;
end;

destructor anyrslt.done;
begin
end;

destructor tsv_rslt.done;
begin
end;



destructor tvv_rslt.done;
begin
end;

destructor tvt_rslt.done;
begin
end;



procedure anyrslt.update;
var z_typ:ansichar;
begin
 z_typ:=info.typ[1];
 case z_typ of
 'Z':  resultat:=value;
 'F':  resultat:=resultat+value;
 'M':  begin
        inc(n_val);
        sum_val:=sum_val+value;
        resultat:=sum_val/n_val;
       end;
 end; {case}
end;

procedure anyrslt.reset;
begin
 resultat:=0;
 n_val   :=0;
 sum_val :=0;
end;

procedure anyrslt.get_value;
begin
end;

constructor tsv_rslt.init(inf:tinforec);
begin
 inherited init(inf);
 rslt_type:=100;
end;



constructor tvv_rslt.init(inf:tinforec; i,j:byte);
begin
 inherited init(inf);
 rslt_type:=200;
 n1:=i;
 n2:=j;
end;

constructor tvt_rslt.init(inf:tinforec);
begin
 inherited init(inf,0,0);
 rslt_type:=210;
end;



procedure tsv_rslt.get_value;
var p:^real;

begin
 p:=ptr(NativeUInt(@candy.s)+info.offset);
 value:=p^;
end;


procedure tvv_rslt.get_value;
var p:^profil;
    i:byte;
    x :profil;
begin
 p  := ptr(NativeUInt(@candy.s)+info.offset);
 x:=p^;
 value:=x[n1];
 for i:=n1+1 to n2 do value:=value+x[i];
 if info.typ[2]='Q' then value:=value/(1+n2-n1);
end;

procedure anyrslt.put_value(d:string; gis:boolean);
begin
   // ausgabe in Access Tabelle  : schreiben direkt
   // ausgabe in access tabelle : sql    (ist das die schnellere variante ???
     candy.rslts.rqry.SQL.Clear;
     if candy.cdyconnex^.simobject=''
     then  candy.rslts.rqry.SQL.append(' insert into '+candy.rslts.rtab.tablename+' (datum, merkmal_id, wert) values ('+''''+d+''''+','+ inttostr(info.index)+','+floattostr(resultat)+')')
     else
     begin
      candy.rslts.rqry.SQL.add(' insert into '+candy.rslts.rtab.tablename+' (datum, objekt_id, merkmal_id, wert) ');
      candy.rslts.rqry.SQL.add('values ( :dat ,'+ candy.cdyconnex^.simobject +','+inttostr(info.index)+', :wrt )');
       {$IFDEF CDY_SRV}
      candy.rslts.rqry.parambyname('dat').AsDateTime:=strtodate(d,cdy_frmtsettings);
       {$ENDIF}
       {$IFDEF CDY_GUI}
      candy.rslts.rqry.parambyname('dat').AsDateTime:=strtodate(d);
       {$ENDIF}



      candy.rslts.rqry.parambyname('wrt').AsFloat:= resultat ;
      //      values ('+''''+d+''''+','+ candy.cdyconnex^.simobject +','+inttostr(info.index)+','+floattostr(resultat)+')');
     end;
 //    candy.rslts.rqry.SQL.SaveToFile('lastupdatesql.txt');
     candy.rslts.rqry.ExecSQL;
    reset;
end;

procedure tvt_rslt.get_dim;
var n:integer;
begin
 n1:=1;
 if candy.sprfl<>nil  then
 begin
  candy.sprfl.put_maxdepth(n);
  n2:=n;
 end;
end;

procedure anyrslt.get_dim;
begin
end;

begin
//#2 if cdy_res=nil then  new(cdy_res,init);
 //res_event:=false;
end.
