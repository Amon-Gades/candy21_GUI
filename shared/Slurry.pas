{
  the implemented class  enables a more flexible reaction to the variability of slurry properties;
  so it is possible to process the available results of slurry analysis that are stored in the table cdy_sldat;
  the model will use the most recent record before a slurry application in the management scenario
}
{$INCLUDE cdy_definitions.pas}
unit slurry;
interface

uses
{$IFDEF CDY_GUI}
cdy_glob,
{$ENDIF}
{$IFDEF CDY_SRV}
cdy_config,
{$ENDIF}
cnd_util,sysutils, FireDAC.Comp.Client,  cnd_vars;

type Pguelledt=^Tguelledt;
     Tguelledt  = class(Tobject)                              //(db_file)
                  tabname,
                  fname,
                  pathname:string;
                  prm_rec:tFDquery;
                  d_termin:longint;
                  satznr :integer;
                  ts,nt,ct :real;
                  adapted,
                  dbok     :boolean;
                  constructor create( dbname:string);
                  procedure   adapt(s_termin:longint; stx,spec:string; var _ts,_ct,_cnr,_mor:real);
                  destructor  done;
                 end;


implementation
 uses cdyparm;

constructor Tguelledt.create(dbname:string);

begin
 dbok:=false;
 fname:=dbname;
 prm_rec:=tFDquery.create(nil);
 prm_rec.connection:=dbc;   //allg_parm.connection;
 prm_rec.SQL.add(' select * from cdy_sldat where fname='+''''+dbname+'''');
 try
  prm_rec.open;
  dbok:=prm_rec.RecordCount>0;
 except;end;
 prm_rec.close;
end;


procedure Tguelledt.adapt(s_termin:longint; stx,   spec:string; var _ts,_ct,_cnr,_mor:real);
var
    h_termin:longint;
    ok:boolean;
    cnr_t:real;
    dat:tdatetime;
    tt,mm,jj,hh:word;

begin
  prm_rec.SQL.Clear;
  prm_rec.sql.add('select DATUM, TS_GEHALT, CT_GEHALT, NT_GEHALT from cdy_sldat where STX='+stx+'and fname='''+fname+'''');   //'+tabname+'
  prm_rec.open;
  prm_rec.first;
  adapted:=false;
     // nächstgelegenen Termin suchen
  if prm_rec.RecordCount>1 then
  begin
     repeat
      prm_rec.next;
      dat:=prm_rec.fieldbyname('DATUM').asdatetime;
      decodedatefully(dat, jj,mm,tt,hh);
     h_termin:=trunc(dat)+36523;      // 1.1.1800 ist tag 1
      ok:= h_termin>s_termin;          // der hilfstermin ist zu weit; der richtige satz ist der vorgänger
     until (ok or prm_rec.Eof);
   if ok then prm_rec.prior;
  end;                              // jetzt sollte der richtige satz dastehen

  dat:=prm_rec.fieldbyname('DATUM').asdatetime;
  h_termin:=trunc(dat)+36523;      // 1.1.1800 ist tag 1
  ok:= h_termin<=s_termin;

  if ok then
  begin
    ts:=prm_rec.fieldbyname('TS_GEHALT').asfloat;    {TS in %}
    ct:=prm_rec.fieldbyname('CT_GEHALT').asfloat;    {C-Gehalt(%) aus Guelleuntersuchung bezieht sich auf TM}
    nt:=prm_rec.fieldbyname('NT_GEHALT').asfloat;    {N-Gehalt(%) aus Guelleuntersuchung bezieht sich auf TM}
    prm_rec.Close;
    if ts>0 then _ts:=ts;
    if ct>0 then _ct:=ct;
    if nt>0 then
    begin
    cnr_t := _ct/nt;
    if _mor>0 then _mor :=(_cnr-cnr_t)/cnr_t  ;  // bei mineralischem N-Anteil (vor allem bei org. Düngern
                                                  //  wird unterstellt dass die variabilität in dem mineralischen anteil besteht
                                                  // und _cnr bleibt erhalten
    if _mor <0 then         // bei unpassenden Konstellationen bleibt _mor=0
      begin
      add_message('no mineral nitrogen in FOM application');
        _cnr:=cnr_t;
        _mor:=0;
      end;
    end;
       adapted:=true;
       {$IFDEF CDY_SRV}
       add_message(datetostr(s_termin-36523,cdy_frmtsettings) +  ': manure adapted; sampling date='+ datetostr(dat,cdy_frmtsettings));
       {$ENDIF}

       {$IFDEF CDY_GUI}
       add_message(datetostr(s_termin-36523) +  ': manure adapted; sampling date='+ datetostr(dat));
       {$ENDIF}

    end   // if ok
else
 begin
  {kein passender Termin gefunden}
  {$IFDEF CDY_SRV}
  add_message(datetostr(s_termin-36523,cdy_frmtsettings)+': manure parameter not adapted');
  {$ENDIF}

  {$IFDEF CDY_GUI}
  add_message(datetostr(s_termin-36523)+': manure parameter not adapted');
  {$ENDIF}

 end;

end;

destructor Tguelledt.done;
begin
 prm_rec.Close;
 prm_rec.Free;
 prm_rec:=nil;
end;


begin
end.
