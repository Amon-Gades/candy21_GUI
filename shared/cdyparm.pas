{
 routines to simply extract parameter values from the database tables
}
{$INCLUDE cdy_definitions.pas}
unit cdyparm;
interface
uses

{$IFDEF CDY_GUI}
cdy_glob,forms, windows,
{$ENDIF}
{$IFDEF CDY_SRV}
cdy_config,
{$ENDIF}

ok_dlg1,
db,sysutils,  system.classes ,     FireDAC.Comp.Client;

// FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
//  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
//  FireDAC.Phys, FireDAC.Phys.MSAcc, FireDAC.Phys.MSAccDef, FireDAC.VCLUI.Wait,


const dbf_mode=true;




type

 Tparm_record = record
    name:string;
    prv :variant;
  end;

  Tprm_Rec=class(Tobject)
        r:Tparm_record;
   end;

  TCdy_Parm=class(TObject)
    ds    : Tdataset;
    fn    : Tstringlist;
    cnt,
    prc   : Tstringlist;
    pset  : Tprm_Rec;
    idx   : string;       apix  : integer ;
      apv   : Variant;
    constructor create( ads:Tdataset; idx_fld:string);
    procedure   build_parmspace;
    function    get_pval(ix:integer;pname:string):variant;
    procedure   get_item(inr:integer;item_lab:string; var item_ix: integer;var item:string);
    procedure   is_field(name:string; var ok:boolean);

 end;



Tparmsp=class(Tcdy_parm)
                  apname: string;


                constructor  create(dataset,idx:string; error_box:boolean);

                procedure   select(var satz:integer;var name:string;var ok:boolean);
                function    parm(prm:string):real;
              //  procedure   is_field(name:string; var ok:boolean);
               end;

{$IFDEF CDY_GUI}
procedure db_connect(db_name:string);
procedure db_disconnect;


var dbc: TFDConnection;
  {$ENDIF}

implementation

{$IFDEF CDY_GUI}
uses candy_uif;
  {$ENDIF}


procedure   TCdy_Parm.get_item(inr:integer;item_lab:string; var item_ix: integer;var item:string);

begin
  item_ix:=strtoint(cnt.strings[inr]);
  item:=string(get_pval(item_ix,item_lab));
end;

constructor Tcdy_parm.create( ads:Tdataset; idx_fld:string);
begin
   ds:=ads;
   idx:=idx_fld;
   build_parmspace;
end;

procedure Tcdy_parm.is_field(name:string; var ok:boolean);
var j:integer;
begin
 j:=fn.IndexOf(name);
 ok:=(j>=0);
end;


procedure Tcdy_parm.build_parmspace;
var
    i,j:integer;
    pix,pname:string;
    pval:variant;
    data_type:Tfieldtype;
begin
  fn:=Tstringlist.Create;
  fn.CaseSensitive:=false;
  fn.Sorted:=false;
  ds.GetFieldNames(fn);    //fieldnames;
  cnt:=Tstringlist.Create(true); // abbildung der Tabelle
  cnt.CaseSensitive:=false;
  cnt.Sorted:=false;
  ds.first;
  repeat // scan all records
    pix:=ds.fieldbyname(idx).asstring;
    prc:=Tstringlist.Create(true);
    for i := 1 to fn.Count do
    begin  // scan all columns
     pset:=Tprm_rec.Create;
     pname:=fn.Strings[i-1];
     data_type:=ds.FieldByName(pname).datatype;
     pval :=ds.FieldByName(pname).AsVariant;
// special cases
     if (data_type=ftWideString )
     then  pval:=( uppercase( ds.fieldbyname(pname).AsString));
     if ds.FieldByName(pname).isNULL then  pval:=0;
     pset.r.name:=uppercase(pname);
     pset.r.prv :=pval;
     j:=prc.AddObject(pname,pset);
    end;
    cnt.AddObject(pix,prc);
    ds.Next;
  until ds.eof ;
end;

function TCDY_parm.get_pval(ix:integer;pname:string):variant;
var i,j:integer;
    pr:Tstringlist;
    xo:Tprm_rec;
begin
  i:=cnt.IndexOf(inttostr(ix));
  if i>=0 then
  begin
    pr:=Tstringlist(cnt.Objects[i]);
    j:=pr.IndexOf(pname);
    if j>=0 then
    begin
      xo:=Tprm_rec(pr.Objects[j]);
      get_pval:=xo.r.prv;
      apix:=ix;
    end  else  get_pval:=-99;
  end   else
  begin
   apix:=-99;
  end;
end;

{$IFDEF CDY_GUI}
procedure  db_connect(db_name:string);

var host,port,user,pw,db:string;
begin
(*
  dbc:=tFDconnection.Create(nil);
  dbc.Close;
  dbc.Params.Clear;

  if fileexists(db_name) then
  begin
   dbc.Params.Add('Database='+db_name);
   dbc.Params.Add('DriverID='+'MSAcc');
   dbc.LoginPrompt:=false;
   dbc.Name:='dbc';
   dbc.Open;
  end
  else   //assuming  pg
  begin
   host:='127.0.0.1';
   port:='5432';
   user:='postgres';
   pw:='postgres';
   DB:=db_name;
   //treiber sind in : c:\Users\Public\Documents\Embarcadero\Studio\FireDAC\
   dbc.open('DriverID=PG; Server='+host+'; Port='+port+'; User_NAME='+user+'; Password='+pw+'; Database='+db);
  end;
  *)
  dbc:=cdy_uif.dbc;
end;


procedure db_disconnect;
var i:integer;
begin
 for i:=dbc.DataSetCount-1 downto 0 do
 begin
 try
  dbc.DataSets[i].disconnect(true);
 except
 end;
 end;
// dbc.Close;
// dbc.Free;
end;

{$ENDIF}

constructor Tparmsp.create(dataset,idx:string; error_box:boolean);
var ok:boolean;
    qry:tfdquery;
begin
  qry:=tFDquery.create(nil);
  qry.connection:=dbc ;
  qry.sql.Clear;
  qry.SQL.Add('select * from '+dataset+' order by '+idx);
  try
  begin
   qry.Open;
   qry.FetchAll;
  end;
  except
    begin
     if error_box then
     begin
     {$IFDEF CDY_GUI}
      application.MessageBox(pchar('table '+dataset+' or field '+idx+' is missed'),pchar('ERROR on reading parameters'),mb_ok);
      application.ProcessMessages;
     {$ENDIF}
     anything:=0;
     {$IFDEF CDY_SRV}
       _halt(0);
     {$ENDIF}
     end;
    end;
   end;
   inherited create(qry, idx);
   qry.Close;
   qry.Free;
end;


procedure Tparmsp.select(var satz:integer;var name:string;var ok:boolean);
{positioniert auf den richtigen Satz in der Datei}
var inr:integer;
    aname:string;

begin

ok:=false;

if satz<>0 then

begin
   //name �bergeben
   apv:=get_pval(satz,'NAME');
   ok:=(apix<>-99);
   if ok then
   begin
    name:=uppercase(apv);
    apix:=satz;
   end else
   begin
   name:='?';
   end;
end;

if satz=0 then
 begin
   // name suchen und idx als satz �bergeben
   inr:=0;
   repeat
     inc(inr);
     satz:=strtoint(cnt.strings[inr-1]);
     apix:=satz;
     aname:=uppercase(trim((string(get_pval(satz,name)))));
   until (aname=uppercase(name)) or (inr=cnt.Count) ;
   ok:=(aname=uppercase(name));
end;
end;

function Tparmsp.parm(prm:string):real;
var ok   : boolean;
   //  x   : variant;
     //typ : feldatr;
begin
 parm:=real(get_pval(apix,prm));                      //ptab.fieldbyname(prm).asfloat;
//parm:=x;
end;

begin
end.
