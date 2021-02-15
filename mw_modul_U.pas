unit mw_modul_U;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,   strutils,

  Grids, DBGrids,   StdCtrls, DBCtrls, CheckLst, ComCtrls, dateutils,
  ExtCtrls,math, ADODB, DB;


type
  Pmw_item=^Tmw_item;
  Tmw_item=record
               selected:boolean;
               a_ix    :integer;
           end;
  Tmw_modul = class(TForm)
    Button1: TButton;
    dview_src: TDataSource;
    mwml_src: TDataSource;
   // mw_update: TQuery;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    CheckListBox1: TCheckListBox;
    Button2: TButton;
    DBLookupComboBox1: TDBLookupComboBox;
    Button3: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    RadioGroup1: TRadioGroup;
    Button4: TButton;
    Label4: TLabel;
    Label5: TLabel;
    Date_e: TDateTimePicker;
    Date_a: TDateTimePicker;
   // hquery: TQuery;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    Label6: TLabel;
    DBGrid1: TDBGrid;
    CheckBox1: TCheckBox;
    Edit3: TEdit;
    Button10: TButton;
    DBGrid2: TDBGrid;
    lst_src: TDataSource;
    PrBar1: TProgressBar;
    DBLookupComboBox2: TDBLookupComboBox;
    sch_src: TDataSource;
    Label7: TLabel;
    CheckBox2: TCheckBox;
    procedure FormActivate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure CheckListBox1ClickCheck(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
 //   procedure Table1_CalcFields(DataSet: TDataSet);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
//    procedure Table2_CalcFields(DataSet: TDataSet);
    procedure DBLookupComboBox1CloseUp(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure DBLookupComboBox2CloseUp(Sender: TObject);
    procedure schemesAfterOpen(DataSet: TDataSet);
    procedure Button3Click(Sender: TObject);

  private
    { Private declarations }
    const
    got_hints: boolean = False ;
    var
    one_layer:boolean;
  public
    { Public declarations }
    a_object:pmw_item;
    utlg,
    snr,

    f_name,
    d_dir,
    p_dir  : string;
    a_cursor:tcursor;
    new_recs:integer;
    procedure sort_mwe;
    procedure import_dataset;
  end;

var
  mw_modul: Tmw_modul;

implementation

uses  candy_uif, range_sel_U, {cdy_edit_dm,}registry, FDC_modul,cnd_util;

{$R *.DFM}
procedure Tmw_modul.schemesAfterOpen(DataSet: TDataSet);
begin
     if fdc.schemes.RecordCount>0 then
     begin
       label7.Show;
       dblookupcombobox2.show;

     end
     else
     begin
       label7.hide;
       dblookupcombobox2.hide;
     end;
end;

procedure Tmw_modul.sort_mwe;
begin
{
  table2.tablename:='killme.db';
  table2.TableType:= ttparadox;
  table2.databasename:=getcurrentdir;
  table1.filtered:=false;
  table1.Refresh;
  batchmove1.source:=table1;
  batchmove1.Destination:=table2;
  batchmove1.mode:=batcopy;
  batchmove1.execute;
  hquery.close;
  hquery.sql.clear;
  hquery.databasename:=getcurrentdir;
  hquery.sql.append('select * from killme.db order by  SNR,UTLG,DATUM, M_IX,S0');
  hquery.open;
  batchmove1.mode:=batappend;
  table1.close;
  table1.EmptyTable;
  batchmove1.Destination:= table1;
  batchmove1.source:=hquery;
  batchmove1.execute;
  table1.open;
  table1.filtered:=true;
  }
end;

procedure Tmw_modul.FormActivate(Sender: TObject);
var
    eintrag,t:string;
    i,a_idx:integer;

begin
   if not got_hints then  cdy_uif.get_hints('mw_modul',mw_modul);
   got_hints:=true;

new_recs:=0;
a_cursor:=screen.Cursor;
pagecontrol1.ActivePageIndex:=0;
 fdc.mvdat.Close;
 fdc.mvdat.Filter:= 'SNR='+snr+' and UTLG='+UTLG+' and fname='''+f_name+'''';
 fdc.mvdat.Filtered:=true;

 fdc.dview.close;
 fdc.dview.SQL.Clear;
 fdc.dview.SQL.Add(' select * from cdy_mhdat where  SNR='+snr+' and UTLG='+UTLG+' and fname='''+f_name+''' order by snr*10+utlg, datum, m_ix' );

 label6.Caption:='>>'+f_name+'<<';
 fdc.mwml.open;
 fdc.any_update.close;

// mw_s preparieren

 fdc.any_update.SQL.Clear;
 fdc.any_update.SQL.add('delete from cdy_mhdat '); // where SNR='+snr+' and UTLG='+UTLG+' and fname='''+f_name+'''');
 fdc.any_update.ExecSQL;
{ fdc.any_update.SQL.Clear;
 fdc.any_update.SQL.add('delete from cdy_msdat  where SNR='+snr+' and UTLG='+UTLG+' and fname='''+f_name+'''');
 fdc.any_update.ExecSQL;
 }
 fdc.mvdat.open;
 fdc.dview.Close;
 fdc.dview.open;


// fdc.mvdat.Refresh;
 dblookupcombobox1.KeyValue:=1;
 fdc.aqry.sql.Clear;
 fdc.aqry.sql.add('select distinct M_IX from cdy_mvdat  where SNR='+snr+' and UTLG='+utlg+' and fname='''+f_name+''' order by M_IX ');
 fdc.aqry.open;
 fdc.aqry.first;
 while not fdc.aqry.eof do
 begin
  fdc.mwml.First;
  i:=0;
  while
   (fdc.mwml.fieldbyname('item_ix').asinteger<>fdc.aqry.fieldbyname('M_IX').asinteger)
   and not fdc.mwml.eof
  do fdc.mwml.next;
  if  fdc.mwml.eof then exiT;
  a_idx  :=fdc.mwml.fieldbyname('item_ix').asinteger;
  eintrag:=fdc.mwml.fieldbyname('BEZEICHNUNG').asstring;
  new(a_object);
  a_object^.a_ix    :=a_idx;
  a_object^.selected:=false;
  i:= checklistbox1.items.addobject(eintrag,tobject(a_object) );
  fdc.aqry.next;
 end;
 fdc.schemes.Open;
 dbgrid2.hide;
button10.hide;
pagecontrol1.ActivePageIndex:=0;
end;

procedure Tmw_modul.Button10Click(Sender: TObject);
var mix,int,s_0,s_1, i :integer ;
   adat,edat          :tdate;
begin
screen.Cursor:=  a_cursor;
checkbox1.Checked:=false;    // to be on safe side
checkbox2.Checked:=true;
fdc.get_obslst.open;
fdc.get_obslst.First;
repeat
  mix:=fdc.get_obslst.FieldByName('mix').AsInteger;
  int:=fdc.get_obslst.FieldByName('itv').AsInteger;
  s_0:=fdc.get_obslst.FieldByName('s0').AsInteger;
  s_1:=fdc.get_obslst.FieldByName('s1').AsInteger;
  adat:=fdc.get_obslst.FieldByName('a_dt').Asdatetime;
  edat:=fdc.get_obslst.FieldByName('e_dt').Asdatetime;
  date_a.Date:=adat;
  date_e.Date:=edat;
  edit1.Text:=inttostr(s_0);
  edit2.Text:=inttostr(s_1);
  radiogroup1.ItemIndex:=int;
  dblookupcombobox1.keyvalue:=mix;
  import_dataset;
  fdc.get_obslst.Next;
until fdc.get_obslst.eof;
end;

procedure Tmw_modul.Button1Click(Sender: TObject);
var creg:tregistry;
begin
  range_select.call_candy:=true;

 if  (new_recs=0) and (fdc.mvdat.RecordCount<1) then
 begin
  creg:=Tregistry.Create;
 try
    creg.RootKey := HKEY_CURRENT_USER;
    creg.openkey('\Software\candy', True);
    creg.writebool('cdy_can',true);

 finally
  creg.closekey;
  creg.free;
 inherited;
 end;
 end;
 fdc.mvdat.close;
 fdc.mwml.close;
 fdc.aqry.close;
 //cleaning up
 fdc.any_update.Close;
 fdc.any_update.SQL.Clear;
 //if fdc.any_update.Connection.Params.DriverID='PG'
 //   then fdc.any_update.SQL.Add('delete from  CDY_MSDAT    using  CDY_MHDAT where CDY_MSDAT.ix = CDY_MHDAT.ix ')
 //   else
//     fdc.any_update.SQL.Add('DELETE CDY_MSDAT.*  FROM CDY_MSDAT INNER JOIN CDY_MHDAT ON CDY_MSDAT.ix = CDY_MHDAT.ix');
 if fdc.any_update.Connection.Params.DriverID='PG'
 then fdc.any_update.SQL.Add(' DELETE  FROM cdy_msdat WHERE SNR='+SNR+'  AND UTLG='+UTLG)
 else fdc.any_update.SQL.Add(' DELETE *  FROM cdy_msdat WHERE SNR='+SNR+'  AND UTLG='+UTLG);
 fdc.any_update.ExecSQL;
 //get new data
 fdc.any_update.Close;
 fdc.any_update.SQL.Clear;
 fdc.any_update.SQL.Add('INSERT INTO cdy_msdat ( fname, SNR, UTLG, DATUM, M_IX, S0, S1, M_WERT, KORREKTUR, ix, S_WERT )');
 fdc.any_update.SQL.Add(' SELECT cdy_mhdat.fname, cdy_mhdat.SNR, cdy_mhdat.UTLG, cdy_mhdat.DATUM, cdy_mhdat.M_IX,');
 fdc.any_update.SQL.Add(' cdy_mhdat.S0, cdy_mhdat.S1, cdy_mhdat.M_WERT, cdy_mhdat.KORREKTUR, cdy_mhdat.ix, cdy_mhdat.S_WERT ');
 fdc.any_update.SQL.Add(' FROM cdy_mhdat ORDER BY cdy_mhdat.SNR, cdy_mhdat.UTLG, cdy_mhdat.DATUM, cdy_mhdat.M_IX, cdy_mhdat.S0, cdy_mhdat.S1, cdy_mhdat.korrektur  ');
 fdc.any_update.ExecSQL;
 fdc.any_update.Close;
 fdc.any_update.SQL.Clear;
// fdc.any_update.SQL.add('update cdy_msdat set ix= fname+str( SNR*10+UTLG)+str(year(DATUM))+right("0"+trim(month(datum)),2)+right("0"+trim(day(datum)),2)+str(  M_IX)+str(S0) +str(S1) ');
// fdc.any_update.ExecSQL;
// fdc.any_update.Close;
 mw_modul.close;
end;



procedure Tmw_modul.Button2Click(Sender: TObject);

var i,n :integer;
    a_ix:integer;
    t,
    pid_, d_,m_,s0_,s1_:string;
    p:pmw_item;
    mm,dd,yr,hdat :string;
begin
    hdat:=datetostr(range_select.fda_start.Date);
    dd:=copy(hdat,1,2);
    mm:=copy(hdat,4,2);
    yr:=copy(hdat,7,4);
    hdat:=dd+'/'+mm+'/'+yr;
    n:=checklistbox1.items.count;
    for i:=0 to n-1  do
    begin
      p:=pmw_item( checklistbox1.Items.Objects[i]);
      if checklistbox1.checked[i]
      and  (checklistbox1.State[i]<> cbGrayed)
      then
        begin
           a_ix:=p^.a_ix;
           fdc.any_update.sql.clear;

           if fdc.any_update.Connection.Params.DriverID='PG'
           then
           begin
           fdc.any_update.SQL.add('insert into cdy_mhdat ( fname,snr,utlg,datum,m_ix,s0,s1,m_wert,korrektur,ix ) ');
           fdc.any_update.SQL.add(' select fname,snr,utlg,datum,m_ix,s0,s1,avg(m_wert) as m_wert ,korrektur, ');
           fdc.any_update.SQL.add('(fname ||'' ''|| (snr*10+utlg) ||'' ''|| extract(year from datum) ||'' ''|| right( ''00''|| extract(doy from datum),3)  ');
//           fdc.any_update.SQL.add(' extract(month from datum) ||'' ''|| extract(day from datum) ');
           fdc.any_update.SQL.add('||'' ''|| m_ix||'' ''|| s0 ||'' ''||s1) as ix ');


       //    fdc.any_update.SQL.add(' (fname || (snr*10+utlg) || datum || m_ix || s0 || s1) as ix ') ;
           end
           else
           begin
           fdc.any_update.SQL.add('insert into cdy_mhdat ( fname,snr,utlg,datum,m_ix,s0,s1,m_wert,korrektur,ix ) select fname,snr,utlg,datum,m_ix,s0,s1,avg(m_wert) as m_w ,korrektur, ');
//           fdc.any_update.SQL.add(' fname+str( SNR*10+UTLG)+str(year(DATUM))+right(''0''+trim(month(datum)),2)+right(''0''+trim(day(datum)),2)+str(M_IX)+str(S0) +str(S1) as ix ');
           fdc.any_update.SQL.add(' fname+str( SNR*10+UTLG)+str(year(DATUM))+'' '' + right( ''00''+trim(str( 1+ datum-dateserial( year(DATUM),1,1  ))),3) +str(M_IX)+str(S0) +str(S1) as ix ');
//           str( 1+ datum-dateserial( year(DATUM),1,1 ))

           end;
           fdc.any_update.SQL.add(' from cdy_mvdat where M_IX='+floattostr(a_ix));
            if fdc.any_update.Connection.Params.DriverID='PG'
           then fdc.any_update.sql.add(' and DATUM >='+''''+hdat+'''' )
           else fdc.any_update.sql.add(' and DATUM >=#'+hdat+'#' );

           fdc.any_update.sql.add(' and SNR='+snr+' and UTLG='+utlg+' and fname='''+f_name+'''');
           fdc.any_update.sql.add(' group by  fname,snr,utlg,datum,m_ix,s0,s1,korrektur ');
         //  fdc.any_update.SQL.SaveToFile('check0.sql');
         //  t:=fdc.any_update.sql.text;
           fdc.any_update.ExecSQL;
           fdc.any_update.sql.clear;
           fdc.any_update.SQL.add('update cdy_mhdat set S_WERT=-99  where SNR='+snr+' and UTLG='+utlg+' and fname='''+f_name+'''');
           fdc.any_update.ExecSQL;
           fdc.mvdat.last;
           checklistbox1.State[i]:= cbGrayed;
           p^.selected:=true;

        end;
    end;
          fdc.dview.Close;
          fdc.dview.Open;
         //  table2.Refresh;
    screen.Cursor:=  a_cursor;
end;



procedure Tmw_modul.CheckListBox1ClickCheck(Sender: TObject);
var  i:integer;
     p:pmw_item;

begin
 i:=checklistbox1.ItemIndex;
 p:=pmw_item(checklistbox1.items.objects[i]);
 if p^.selected
       then begin
             checklistbox1.checked[i]:=true;
             checklistbox1.state[i]:=cbgrayed;
            end;
end;

procedure Tmw_modul.DBLookupComboBox1CloseUp(Sender: TObject);
var a_ix,mwcl: integer;
begin
try
 a_ix:=   dblookupcombobox1.keyvalue;
 if pos(trim(fdc.mwml.FieldByName('format').AsString),'profilsaeule')>0 then   mwcl:=1 else mwcl:=0;
except  dblookupcombobox1.KeyValue:=1;

 end;

  one_layer:=(fdc.mwml.FieldByName('typ').AsString='fx');
 if one_layer then
 begin
//  label1.Hide;
  edit1.Hide;
  label2.Hide;
 end
 else

 if mwcl=0 then
 begin
  label1.Hide;
  edit1.Hide;
  label3.Hide;
  edit2.Hide;
  edit1.Text:='-99'   ;
  edit2.Text:='-99'   ;
 end
 else
 begin
  label1.Show;
  edit1.Show;
  label3.Show;
  edit2.Show;
  edit1.Text:='0';
  edit2.Text:='3';
 end;

end;

procedure Tmw_modul.DBLookupComboBox2CloseUp(Sender: TObject);
begin
fdc.get_obslst.Close;
fdc.get_obslst.SQL.Clear;
fdc.get_obslst.SQL.add('SELECT cdy_obslt.item_ix, cdy_obslt.intervall AS itv, cdy_obslt.m_ix AS mix, cdy_obslt.s0, cdy_obslt.s1, ');
fdc.get_obslst.SQL.add('  cdy_obslt.start AS a_dt, cdy_obslt.enddat AS e_dt, CDYPROP.shrtname  as sn');
fdc.get_obslst.SQL.add(' FROM cdy_obslt INNER JOIN CDYPROP ON cdy_obslt.m_ix = CDYPROP.item_ix ');
fdc.get_obslst.SQL.add(' WHERE cdy_obslt.sch_ix='+fdc.schemes.FieldByName('item_ix').AsString);
//fdc.get_obslst.SQL.add('select intervall as itv,m_ix as mix,s0,s1,start as a_dt,enddat as e_dt from cdy_obslt where sch_ix='+fdc.schemes.FieldByName('item_ix').AsString);
fdc.get_obslst.Open;
dbgrid2.Show;
button10.Show;
end;

procedure Tmw_modul.FormClose(Sender: TObject; var Action: TCloseAction);
var i,n:integer;
  p:pmw_item;
begin
 with checklistbox1 do
 begin
  n:=items.count-1;
  for i:=0 to n do
  begin
   p:=pmw_item(items.objects[i]);
   dispose(p);
  end;
  items.Clear;
 end;
end;


procedure Tmw_modul.Button3Click(Sender: TObject);
var sch_ix: integer;
   a_cursor:tcursor;
   a_ix:string;
begin
screen.Cursor:=  a_cursor;
  a_ix:= inttostr( dblookupcombobox1.keyvalue);   //fdc.mwml.fieldbyname('INDEX').asstring;
 if checkbox2.Checked then import_dataset;
// schema
 if checkbox1.Checked then
 begin
 fdc.schemes.Close;
 fdc.get_obslst.Close;
 fdc.any_update.SQL.Clear;
 fdc.any_update.sql.add(' select item_ix from cdy_obsch where sname='''+trim(edit3.Text)+'''');
 fdc.any_update.Open;
 if fdc.any_update.RecordCount>0
  then sch_ix:=fdc.any_update.FieldByName('item_ix').AsInteger
  else
  begin
   fdc.any_update.SQL.Clear;
   fdc.any_update.SQL.Add('insert into cdy_obsch (sname) values('''+trim(edit3.Text)+''')');
   fdc.any_update.ExecSQL;
   fdc.any_update.SQL.Clear;
   fdc.any_update.sql.add(' select item_ix from cdy_obsch where sname='''+trim(edit3.Text)+'''');
   fdc.any_update.Open;
   sch_ix:=fdc.any_update.FieldByName('item_ix').AsInteger;
  end;

   fdc.any_update.SQL.Clear;
   fdc.any_update.SQL.Add('insert into cdy_obslt (sch_ix,intervall,m_ix,s0,s1,start, enddat)');
   fdc.any_update.SQL.Add('   values('+inttostr(sch_ix)+', '+inttostr(radiogroup1.ItemIndex)+', '+a_ix+', '+edit1.text+', '+edit2.text+', '''+datetostr(date_a.date)+''', '''+datetostr(date_e.date)+'''  )');
//   fdc.any_update.SQL.SaveToFile('fillobslst.sql');
   fdc.any_update.ExecSQL;



  fdc.schemes.Open;
  fdc.schemes.Locate('sname',edit3.text,[]);
  dblookupcombobox2.KeyValue:=fdc.schemes.FieldByName('item_ix').AsInteger;
  dblookupcombobox2.onCloseUp(nil);
 end;

end;


procedure Tmw_modul.import_dataset;
var korr_,a_ix,s0_,s1_:string;
    t,l   :tdate;
    dt,y,m,d:word;
    m_ix,s0,s1,plot,skip:INTEGER;

    daydiff, daycnt:integer;

procedure add_record;
var d,dn,sn,six:string;
    h:integer;
begin

    if l> date_e.date then exit;
   d:=datetostr(l);
   h:=  strtoint(SNR)*10+strtoint(UTLG) ;
   sn:= inttostr(h )      ;
   if one_layer then edit1.Text:=edit2.Text;

  // s0_:=rightstr('00'+trim(edit1.Text),2);
  // s1_:=rightstr('00'+trim(edit2.Text),2);
  s0_:=' '+trim(edit1.Text);
  s1_:=' '+trim(edit2.Text);

   dn:=trim(inttostr(julday(d)));

   //if fdc.any_update.Connection.Params.DriverID='PG'
  // then
  // six:=  f_name+' '+sn+' '+copy(d,7,4)+rightstr('0'+copy(d,4,2),2)+rightstr('0'+copy(d,1,2),2)+' ' +a_ix+s0_ +s1_      ;
  six:=  f_name+' '+sn+' '+copy(d,7,4)+' '+rightstr('00'+dn,3)+' ' +a_ix+s0_ +s1_   ;
   fdc.any_update.sql.clear;
   fdc.any_update.sql.add(' insert into cdy_mhdat (fname,korrektur,m_wert,datum,snr,utlg,m_ix,s0,s1,ix) ');
   fdc.any_update.sql.add(' values ('''+f_name+''',''N'',-99,'''+d+''','+snr+','+utlg+','+a_ix+','+edit1.text+','+edit2.text+',');
//  set ix= fname+str( SNR*10+UTLG)+str(year(l))+right("0"+trim(month(l)),2)+right("0"+trim(day(l)),2)+a_ix+s0_ +s1_ ');

  fdc.any_update.sql.add(''''+ six +'''  )');
 //   fdc.any_update.sql.add('"'+ f_name+sn+d+a_IX+ s0_ +s1_+korr_+'" )' );

 //  d:=fdc.any_update.sql.text;
 //fdc.any_update.SQL.SaveToFile('check1.sql');
try
     fdc.any_update.ExecSQL;
except
 inc( skip );
end;
   //  kein Vorteil:
  // d:= f_name+sn+d+a_IX+ s0_ +s1_+korr_ ;
  // hdtab.AppendRecord([  f_name,strtoint(snr),strtoint(utlg),l,strtoint(a_ix)  ,strtoint(s0_),strtoint(s1_),-99,'N', d ,-99  ]);

   fdc.dview.Close;
   fdc.dview.Open;
//   table2.Refresh;


end;



begin
 a_ix:= inttostr( dblookupcombobox1.keyvalue);   //fdc.mwml.fieldbyname('INDEX').asstring;
 date_a.date:=floor(date_a.date);
 date_e.date:=floor(date_e.date);
if checkbox2.Checked then
begin
a_cursor:=screen.Cursor;
screen.Cursor:=  crhourglass;
 //save_cursor:=screen.cursor;
 //screen.cursor:=crhourglass;
daydiff:=daysbetween(date_e.Date,date_a.date);
inc(new_recs);
prbar1.Position:=0;
skip:=0;
prbar1.Max:=daydiff;
prbar1.Show;

//dblookupcombobox1
//fdc.mwml.Locate('NAME',variant(dblookupcombobox1.listfield),[])


 korr_:='N';
 case radiogroup1.itemindex of
  0:                         //daily
    begin
      l:=date_a.date;
      //while l<=date_e.date do
      //begin
      repeat
       add_record;
       l:=l+1;
       prbar1.Position:= prbar1.Position+1;
      until floor (l)> floor(date_e.date);
      //end; //while
    end;
  1:                         // 5 days
    begin
     t:= date_a.date;
     l:=t;
      add_record;
      prbar1.Position:= 1;
     while t<date_e.date do
      begin
       repeat
        t:=t+1;
        decodedate(t+1,y,m,d);
       until (d in [1,6,11,16,21,26]);
       IF T<date_e.date then
       begin
         l:=T;
         add_record;
         prbar1.Position:= prbar1.Position+5;
       end;
      end; //while
     if floor(l)<> floor(date_e.date) then
      begin
        l:=date_e.date;
        add_record;
        prbar1.Position:=daydiff;
      end;

    end;
  2:                         // 10 days
    begin
     t:= date_a.date;
     l:=t;
     add_record;
           prbar1.Position:= 1;
     while t<date_e.date do
      begin
       repeat
        t:=t+1;
        decodedate(t+1,y,m,d);
       until (d in [1,11,21]);
       IF T<date_e.date then
       begin
         l:=T;
         add_record;
                  prbar1.Position:= prbar1.Position+10;
       end;
      end; //while
      if floor(l)<> floor(date_e.date) then
      begin
        l:=date_e.date;
        add_record;
              prbar1.Position:=daydiff;
      end;

    end;
  3:                         // monthly
    begin
     t:= date_a.date;
     l:=t;
     add_record;
           prbar1.Position:= 1;
     while t<date_e.date do
      begin
       repeat
        t:=t+1;
        decodedate(t+1,y,m,d);
       until d=1;
       l:=t;
       add_record;
        prbar1.Position:= prbar1.Position+30;
      end; //while
     if floor(l)<> floor(date_e.date) then
      begin
        l:=date_e.date;
        add_record;
        prbar1.Position:=daydiff;
      end;
    end;
  4:                                //yearly
      begin
     t:= date_a.date;
     l:=t;
     add_record;
           prbar1.Position:= 1;
     while t<date_e.date do
      begin
       repeat
        t:=t+1;
        decodedate(t+1,y,m,d);
       until (d=1) and (m=1);
        l:=t;
        add_record;
        prbar1.Position:= prbar1.Position+365;
      end; //while
     if floor(l)<> floor(date_e.date) then
      begin
        l:=date_e.date;
        add_record;
        prbar1.Position:=daydiff;
      end;

  end;


 end; //case
 if skip>0 then
 begin
 // schlüsselverletzung auswerten
  application.MessageBox(Pwidechar(inttostr(skip)+' skipped records because of key violence'),'WARNING',mb_ok)  ;
 end;
 sort_mwe;
 screen.Cursor:= a_cursor;
 fdc.mvdat.last;
 prbar1.Hide;
 end;


end;

(*

procedure Tmw_modul.Table2_CalcFields(DataSet: TDataSet);
begin
    fdc.mwml.First;
  while
   fdc.dview.fieldbyname('M_IX').asinteger<>fdc.mwml.fieldbyname('Item_ix').asinteger
  do fdc.mwml.next;
 fdc.dviewmerkmal.asstring:=fdc.mwml.fieldbyname('BEZEICHNUNG').asstring;

end;
  *)
procedure Tmw_modul.Button4Click(Sender: TObject);
var i,j:integer;
begin
screen.Cursor:=  a_cursor;
 fdc.any_update.SQL.Clear;
 fdc.any_update.SQL.add('delete from cdy_mhdat  where SNR='+snr+' and UTLG='+UTLG+' and fname='''+f_name+'''');
 fdc.any_update.ExecSQL;
 fdc.dview.Close;
 fdc.dview.open;

   checklistbox1.Clear;
   formactivate(self);

end;

procedure Tmw_modul.Button5Click(Sender: TObject);
begin
 range_select.call_candy:=false;
 fdc.mvdat.close;
 fdc.mwml.close;
 fdc.aqry.close;
 mw_modul.close;
end;

procedure Tmw_modul.Button6Click(Sender: TObject);
var i:integer;
begin
for i:=0 to checklistbox1.Items.Count-1 do
begin
   if not (checklistbox1.State[i]=cbgrayed) then
    checklistbox1.checked[i]:=true;
end;
end;
procedure Tmw_modul.Button7Click(Sender: TObject);
var i:integer;
begin
for i:=0 to checklistbox1.Items.Count-1 do
  if not (checklistbox1.State[i]=cbgrayed) then
    checklistbox1.checked[i]:=false;
end;

procedure Tmw_modul.Button8Click(Sender: TObject);
var i:integer;
begin
for i:=0 to checklistbox1.Items.Count-1 do
   if not (checklistbox1.State[i]=cbgrayed) then
    checklistbox1.checked[i]:=not checklistbox1.checked[i];
end;

end.
