unit cdy_r_vw;
// die Unit enthält neben den wichtigen Routinen jede Menge unnützen Code,
// der aus einer anderen Anwendung stammt und denich aus Zeitgründen nicht entfernt habe

// falss erforderlich, ist Table2 auf dem Formular an ein anderes Ziel anzupassen
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db,  StdCtrls, FileCtrl, ComCtrls, Grids, DBGrids, ExtCtrls,math,
  ComObj,types97,variants, {Excel97,} OleServer, ADODB, DBCtrls, {TeEngine,} system.DateUtils,
   {TeeProcs, Chart,} VclTee.TeeGDIPlus, Excel2000, VCLTee.Series, VCLTee.TeEngine,
  VCLTee.TeeProcs, VCLTee.Chart;

type
  Tcdy_res_view = class(TForm)
    Button2: TButton;
    ListBox2: TListBox;
    ComboBox1: TComboBox;
    Button3: TButton;
    Edit1: TEdit;
    Label1: TLabel;
    FileListBox1: TListBox;
    DataSource1: TDataSource;

    rosrc: TDataSource;
    DBLookupComboBox1: TDBLookupComboBox;
    xyg_1: TChart;
    Series1: TLineSeries;
    xla: TExcelApplication;
    Edit2: TEdit;
    CheckBox1: TCheckBox;
    Label2: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FileListBox1DblClick(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure DBLookupComboBox1CloseUp(Sender: TObject);
    procedure FileListBox1KeyDown(Sender: TObject; var Key: Word;  Shift: TShiftState);
    procedure Edit2Exit(Sender: TObject);

  private
    { Private-Deklarationen }
    save_cursor:Tcursor;
     _mid,_oid:string;
    lcid:integer;
    savecng:olevariant;
        hint: array of string;
  //  wsheet, xlbook, xla  ,xlsheet    : Variant;
  public
    updatemode,
    finish:boolean;
    workbook,
    objekt_name,
    rdir       :string;
    mwert:real;
    rec_anz:integer;
    { Public-Deklarationen }
    //  XlApp, XlBook, XlSheet, XlSheets, Range : Variant; // Excel 97
  end;

const fehlwert=-99999;


{Typvereinbarungen}
type
    Tresdesc= record
                 mid:integer;
                 hint:string;
               end;
     attr_rec  = record
                    nr     : integer;
                    mix    : integer;
                    name   : string;
                    typ    : string;
                    faktor : real;
                    einheit: string;
                    a_pos  : integer;
                    flength: integer;
                  end;
     p_attr_lst=^attr_lst;
     attr_lst  = record
                    attr:attr_rec;
                    next:p_attr_lst;
                  end;



     p_termin_lst   =^termin_lst;
     termin_lst     = record
                       termin: string;  {vorl„ufig wird Datum als string gespeichert}
                       jday  : longint; {Tage seit dem 1.3.1700}
                       next  : p_termin_lst;
                      end;

     p_eintr_lst=^eintr_lst;
     eintr_lst  = record
                   zeit:p_termin_lst;
                   wert:real;
                   next:p_eintr_lst;
                  end;

     p_value_lst=^value_lst;
     value_lst  = record
                    attrbt  :p_attr_lst;
                    eintrag :p_eintr_lst;
                    next    :p_value_lst;
                  end;


     p_reslt_obj=^reslt_obj;
     reslt_obj  = object
                      fpath,
                      fname,
                      txtzeile,
                      sim_code,

                      idxline   :string;
                      attribute :p_attr_lst;
                      zeitp     :p_termin_lst;
                      daten     :p_value_lst;

                      constructor init( dpath,dname:string);
                      procedure   list(nr:integer;ja,je:longint);
                      procedure   cmpr(nr:integer;ja,je:longint);
                      function    anfang_chk(j:longint):string;
                      function    ende_chk  (j:longint):string;
                      procedure    wert(merkmal:string;ja,je:longint; var xx:real);
                      function    lfdwert(merkmal:string; lj:longint):real;
                      procedure   list2txt(txt_name:string);
                   //   procedure   col2dbf(dbf_name:string; merkmal:string);
                      procedure  list2db;
                      destructor  done;
                   end;

var reslt:reslt_obj;
    xf:textfile;
  cdy_res_view: Tcdy_res_view;
  d_path:string;
    xlconnect :boolean;
implementation

uses { Unit1,}candy_uif, { rslt_reg,} strutils, FDC_modul;

{$R *.DFM}


function dbf2dat(dbfdat:string):string;
begin
 dbf2dat:=copy(dbfdat,7,2)+'.'+copy(dbfdat,5,2)+'.'+copy(dbfdat,1,4);
end;



function jul_day(d,m,a:integer):longint;
var jd:longint;
begin
if m<3 then jd:=trunc(365.25*(a-1)) + trunc(30.6*(m+13)) + d - 621049
       else jd:=trunc(365.25* a   ) + trunc(30.6*(m+1 )) + d - 621049;
jul_day:=jd;
end;


procedure new_attribute;
var i,anz, id:integer;
    summe,
    x:real;
    mid,oid,
    z:string;
    ha:P_attr_lst;
    ht:p_termin_lst;
    t,tmin,tmax:tdate;
    datecheck:string;
    mm,dd,yy:integer;
begin

with cdy_res_view do
 begin
 dd:= dayof(strtodate(edit2.Text));
 mm:= monthof(strtodate(edit2.Text));
 yy:= yearof(strtodate(edit2.Text));
// datecheck:=' where day(datum)>='+inttostr(dd)+' and month(datum)>='+inttostr(mm)+' and year(datum)>='+inttostr(yy);
  if fdc.hqry.Connection.Params.DriverID='PG'
  then  datecheck:=' where datum>= make_date('+inttostr(yy)+','+inttostr(mm)+','+inttostr(dd)+') '
  else  datecheck:=' where datum>= dateserial('+inttostr(yy)+','+inttostr(mm)+','+inttostr(dd)+') ';

 id:=integer(combobox1.Items.Objects[combobox1.ItemIndex]);
 mid:=inttostr(id);
 cdy_res_view._mid:=mid;
 oid:=fdc.oqry.FieldByName('objekt_id').AsString;
 cdy_res_view._oid:=oid;
 fdc.hqry.close;
 fdc.hqry.sql.clear;
 if trim(oid)='' then  fdc.hqry.sql.add(' select * from '+objekt_name+datecheck+' and merkmal_id='+mid+' order by datum')
                 else  fdc.hqry.sql.add(' select * from '+objekt_name+datecheck+' and merkmal_id='+mid+' and objekt_id='+oid+' order by datum');


// old: fdc.hqry.sql.add(' select * from '+objekt_name+ ' where merkmal_id='+mid+' and objekt_id='+oid+' order by datum');
 fdc.hqry.open;
 fdc.hqry.First;
 anz:=0;
 summe:=0;
 tmin:= fdc.hqry.FieldByName('Datum').AsDateTime;
 edit2.Text:=fdc.hqry.FieldByName('Datum').Asstring;
 try
 strtodate(cdy_res_view.edit2.text);
 except
 edit2.Text:='01.01.1900';
 end;
 // cdy_res_view.xygraph1.Plotting:=false;
// cdy_res_view.xygraph1.ClearAll ;
  listbox2.Items.Clear;
  xyg_1.Series[0].clear;


 repeat
   x:=fdc.hqry.FieldByName('wert').asfloat;
   t:=fdc.hqry.FieldByName('Datum').AsDateTime;
   tmax:=t;
   z:=datetostr(t)+' : '+floattostr(x);
   cdy_res_view.listbox2.items.add(z);
 //  cdy_res_view.xygraph1[1][t]:=x;
   xyg_1.Series[0].AddXY(t,x);
   summe:=summe+x;
   inc(anz);
   fdc.hqry.Next;
 until fdc.hqry.eof ;
 end;
 {cdy_res_view.xygraph1.xaxis.Min:=tmin;
 cdy_res_view.xygraph1.xaxis.Max:=tmax;
 cdy_res_view.xygraph1.xaxis.ShowAsTime:=true;
 cdy_res_view.xygraph1.Plotting:=true;
 }
 cdy_res_view.edit1.text:=floattostr(summe/anz);
 cdy_res_view.rec_anz:=anz;
// cdy_res_view.combobox1change(nil);
end;

function dbf2jday(dbfdat:string):longint;
var d,m,a,j:integer;
    h:longint;
begin
  val(copy(dbfdat,7,2),d,j);
  val(copy(dbfdat,5,2),m,j);
  val(copy(dbfdat,1,4),a,j);
  h:=jul_day(d,m,a);
  dbf2jday:=h;
end;

procedure reslt_obj.list2txt(txt_name:string);
var ha:p_attr_lst;
    hv:p_value_lst;
    he:p_eintr_lst;
    ht:p_termin_lst;
    x:real;
    kum:boolean;
    xf:text;
begin
end;

procedure reslt_obj.list2db;
var ha:p_attr_lst;
    hv:p_value_lst;
    he:p_eintr_lst;
    ht:p_termin_lst;
    x:real;
    oid,
    h,
    mix:integer;
    t:Tdatetime;
    a_name:string;
    kum:boolean;
    mkidx:array[1..5] of integer;
begin

end;

procedure reslt_obj.list(nr:integer;ja,je:longint);
var ha:p_attr_lst;
    hv:p_value_lst;
    he:p_eintr_lst;
    x:real;
    kum:boolean;
begin
end;


procedure reslt_obj.cmpr(nr:integer;ja,je:longint);
var ha:p_attr_lst;
    hv:p_value_lst;
    he:p_eintr_lst;
    x:real;
    kum:boolean;
    j:integer;
begin
end;

function reslt_obj.anfang_chk(j:longint):string;
var  hz:p_termin_lst;
begin
end;

function reslt_obj.ende_chk(j:longint):string;
var  hz,h1:p_termin_lst;
begin
end;

procedure reslt_obj.wert(merkmal:string; ja,je:longint; var xx:real);
var ha:p_attr_lst;
    hv:p_value_lst;
    he:p_eintr_lst;
    x:real;
    kum:boolean;
    j:integer;
begin
end;


function reslt_obj.lfdwert(merkmal:string; lj:longint):real;
var ha:p_attr_lst;
    hv:p_value_lst;
    he:p_eintr_lst;
    x:real;
    kum:boolean;
    j:integer;
begin
  {Welches Merkmal ?}
  ha:=attribute;
  x:=0;
  j:=0;
  while (ha<>nil) and (trim(ha^.attr.name)<>merkmal) do
  begin
   ha:=ha^.next;
  end;
  if ha<>nil then
  begin
   kum:=ha^.attr.typ='(F)';
   hv:=daten;
   while hv^.attrbt<>ha do hv:=hv^.next;
   he:=hv^.eintrag;
   j:=1;
   while (he<>nil) and (j<lj)  do
   begin
      j:=j+1;
      he:=he^.next
    end;
    x:=he^.wert;
  end
  else x:=-999.9;
  lfdwert:=x;
end;

{
procedure cdy_res_view.ComboBox1MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var
  idx: integer;
  olh: string;
begin
  with checklistbox1 do
    begin
      olh := hint;
      idx := itematpos(point(x, y), false);
      if (idx <= items.count - 1) then hint :=hints[idx] //items.strings[idx]
      else hint := '';
      if hint <> olh then application.cancelhint
    end
end;

 }
constructor reslt_obj.init(dpath,dname:string);

var ha:p_attr_lst;
    hv:p_value_lst;
    he:p_eintr_lst;
    hz:p_termin_lst;
    recno,
    p,h,a,m,d,offs,mid,i :integer;
    z:string;
    x:real;
    f_:textfile;
    resdesc:tresdesc;
begin
 with cdy_res_view do
 begin
 z:=dblookupcombobox1.keyvalue;
 fdc.aqry.Close;
 fdc.aqry.SQL.Clear;
 fdc.aqry.SQL.Add(' SELECT  RESULTAT,  merkmal_id,  unit , remark FROM CDY_RSLT,'+dname);
 fdc.aqry.SQL.Add(' where  merkmal_id =  cdy_rslt.resultNR  ');
 fdc.aqry.SQL.Add('  and objekt_id='+z);
 fdc.aqry.SQL.Add(' GROUP BY  RESULTAT, merkmal_id, unit,remark ');

 fdc.aqry.Open;
 fdc.aqry.first;
 setlength(hint,fdc.aqry.RecordCount+1);
 combobox1.Items.Clear;
 i:=0;
 repeat
  resdesc.mid:= fdc.aqry.FieldByName('merkmal_id').asinteger;
  resdesc.hint:=fdc.aqry.FieldByName('remark').asstring;
  hint[i]:= resdesc.hint;
  inc(i);
  combobox1.Items.Addobject(fdc.aqry.FieldByName('resultat').asstring+'['+fdc.aqry.FieldByName('unit').asstring+']',tobject(resdesc.mid));
  fdc.aqry.Next;
 until fdc.aqry.eof;

 end;


end;

destructor    reslt_obj.done;
var ha:p_attr_lst;
    hd:p_value_lst;
    he:p_eintr_lst;
    hz:p_termin_lst;
begin
  hz:=zeitp;
  while hz<>NIL do
  begin
   hz:=hz^.next;
   dispose(zeitp);
   zeitp:=hz;
  end;
  ha:=attribute;
  while ha<>NIL do
  begin
    ha:=ha^.next;
    dispose(attribute);
    attribute:=ha;
  end;
  hd:=daten;
  while hd<>NIL do
  begin
    hd:=hd^.next;
    he:=daten^.eintrag;
    while he<>NIL do
    begin
      he:=he^.next;
      dispose(daten^.eintrag);
      daten^.eintrag:=he;
    end;
    dispose(daten);
    daten:=hd;
  end;

end;



procedure Tcdy_res_view.Button1Click(Sender: TObject);
var i_name, tmp_name, hstr:string ;
     cnt,maxcnt:integer;
     ha: p_attr_lst;

begin
 // button1.enabled:=false;
 //save_cursor:=screen.cursor;
 //screen.cursor:=crhourglass;




end;

procedure Tcdy_res_view.Button2Click(Sender: TObject);
var
    i:integer;
begin

cdy_res_view.close;
end;

procedure Tcdy_res_view.FormCreate(Sender: TObject);
var i:integer;
    p:string;
begin

//   cdy_res_view.button1.enabled:=false;
   cdy_res_view.finish:=false;
   cdy_res_view.updatemode:=false;
   cdy_res_view.workbook:='?';

end;




procedure Tcdy_res_view.FileListBox1DblClick(Sender: TObject);
begin
 objekt_name:= filelistbox1.Items[filelistbox1.ItemIndex];

 fdc.oqry.SQL.Clear;
 fdc.oqry.SQL.Add(' select distinct objekt_id from '+objekt_name+'  order by objekt_id  desc ');
 fdc.oqry.Open;
 fdc.oqry.First;

 dblookupcombobox1.KeyValue :=fdc.oqry.FieldByName('objekt_id').AsString;

 DBLookupComboBox1CloseUp(nil);


 end;

procedure Tcdy_res_view.FileListBox1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
  var d_item:string;
      antw,i:integer;
begin
antw:=idno;
if key=46 then antw:= application.MessageBox(pwidechar(d_item),'Delete selected tables ?',mb_yesno);
if antw=idyes then
 begin
 for i := 1 to filelistbox1.Items.Count do
 begin
    if filelistbox1.Selected[i-1] then
    begin
     d_item:=filelistbox1.Items[i-1];
     fdc.any_update.SQL.Clear;
     fdc.any_update.SQL.Add(' drop table '+d_item);
     fdc.any_update.ExecSQL;
    end;
  end;
 cdy_res_view.FormActivate(nil);
 end;
end;

procedure Tcdy_res_view.ComboBox1Change(Sender: TObject);
var i:integer;
begin
    save_cursor:=screen.cursor;
    screen.cursor:=crhourglass;
    listbox2.Clear;
    new_attribute;
    i:=combobox1.ItemIndex;
//    label3.Caption:=hint[i];
      xyg_1.Title.Caption:=trim(hint[i]);
      xyg_1.Axes.Left.Title.Caption:=trim(combobox1.Items[i]);
    screen.cursor:=save_cursor;
end;



procedure Tcdy_res_view.DBLookupComboBox1CloseUp(Sender: TObject);
var old_item:string;
begin
 try
   old_item:=combobox1.Items[combobox1.ItemIndex];
 except
   old_item:='*';
 end;
 combobox1.items.clear;
 reslt.init('', objekt_name);
 try
   combobox1.ItemIndex:=max(0,combobox1.Items.IndexOf(old_item));
 except;
   combobox1.itemindex:=0;
  end;
 new_attribute;


end;

procedure Tcdy_res_view.Edit2Exit(Sender: TObject);
begin
new_attribute;
end;

procedure Tcdy_res_view.Button3Click(Sender: TObject);
var p:variant;
     x:real;
     i,j:integer;
    ha:P_attr_lst;
    ht:p_termin_lst;
    datecheck,
    dd,mm,yy:string;
begin
  if fdc.hqry.Connection.Params.DriverID='PG' then
  begin
  application.MessageBox(' this feature is not available on PostGres','sorry',mb_ok);
  exit;
  end;

 dd:= inttostr(dayof(strtodate(edit2.Text)));
 mm:= inttostr(monthof(strtodate(edit2.Text)));
 yy:= inttostr(yearof(strtodate(edit2.Text)));
// datecheck:=' and day(datum)>='+dd+' and month(datum)>='+mm+' and year(datum)>='+yy;
 datecheck:=' and dateserial('+yy+','+mm+','+dd+') <= datum';
fdc.hqry.Close;
fdc.hqry.SQL.Clear;
fdc.hqry.SQL.Add(' TRANSFORM First(wert) AS Wert_ SELECT datum FROM '+objekt_name);
//fdc.hqry.SQL.Add(' where  merkmal_id='+_mid   );
fdc.hqry.SQL.Add(' where  merkmal_id>0 '    );
if checkbox1.Checked then fdc.hqry.SQL.Add(datecheck) ;
if not(trim(_oid)='') then  fdc.hqry.SQL.Add('  and objekt_id='+_oid );
fdc.hqry.SQL.Add(' GROUP BY datum PIVOT merkmal_id ');
fdc.hqry.SQL.SaveToFile('test.sql');
fdc.hqry.Open;
fdc.hqry.First;
j:=fdc.hqry.FieldCount;
//lcid:=getuserdefaultlcid;
//to fix an error with office locale different :
//https://stackoverflow.com/questions/4945024/old-format-or-invalid-type-library
lcid:=LOCALE_USER_DEFAULT;
// excel-mappe hochfahren

   xla.Connect;
   xla.visible[lcid]:=true;
   xla.Workbooks.Add(EmptyParam,lcid);


 i:=3;
 repeat
 for j:=1 to fdc.hqry.Fields.Count do
 begin
  xla.cells.item[i,j]:=fdc.hqry.Fields.Fields[j-1].AsString;
 end;
 inc(i);
 sleep(5);
application.ProcessMessages;
 fdc.hqry.Next;
 until fdc.hqry.Eof;

 //headlines
  xla.cells.item[1,1] :='Date';
 for j:=2 to fdc.hqry.Fields.Count do
 begin
   i:= strtoint(fdc.hqry.Fields.Fields[j-1].FieldName);
   fdc.aqry.First;
   fdc.aqry.Locate('merkmal_id',i,[]);
   xla.cells.item[1,j] := fdc.aqry.FieldByName('RESULTAT').AsString;
   xla.cells.item[2,j] := fdc.aqry.FieldByName('UNIT').AsString;    //inttostr(i);
 end;
 xlconnect :=true;
end;



procedure Tcdy_res_view.FormActivate(Sender: TObject);
var tlist:tstrings;
     I:integer;
     item:string;
begin
// if finish then   button2click(cdy_res_view);
 // Tabellenverzeichnis auf stellen ?
 filelistbox1.Clear;
 tlist:=tstringlist.create;
 cdy_uif.dbc.GetTableNames('','','',tlist);
 for i:= 1 to tlist.count do
 begin
    item:=tlist.Strings[i-1];
    if uppercase(leftstr(item,3))='RS_' then
    begin
     filelistbox1.Items.Add(item) ;
    end;
 end;
 tlist.Free;
end;



begin
xlconnect:=false;

end.
