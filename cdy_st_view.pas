unit cdy_st_view;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Grids, cndstat,cnd_vars,cnd_util, DB;

type
  TST_View = class(TForm)
    GroupBox1: TGroupBox;
    StringGrid1: TStringGrid;
    StringGrid2: TStringGrid;
    StringGrid3: TStringGrid;
    StringGrid4: TStringGrid;
    Button2: TButton;
    Button1: TButton;
    ListBox1: TListBox;
    Button3: TButton;
    Button4: TButton;
    Label1: TLabel;
    Label2: TLabel;
 //  hquery: TQuery;
    procedure show_record;
    procedure FormActivate(Sender: TObject);
    procedure ListBox1DblClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
    n_rec:integer;
    filename:string;
    r:statrec;
    sr:sysstat;
  end;

var
  ST_View: TST_View;

implementation

uses candy_uif, range_sel_U;

{$R *.DFM}

procedure TST_View.show_record;
var l,i:integer;

begin

//  status_lesen(filename,1,r);
  with stringgrid1 do
   begin
    Cells[0,0]:='layer';
    cells[3,0]:='NH4-N';
    for i:=1 to 20 do cells[3,i]:=floattostr(r.amn[i]);
    cells[4,0]:='NO3-N';
    for i:=1 to 20 do cells[4,i]:=floattostr(r.nin[i]);
    cells[1,0]:='TEMP';
    for i:=1 to 20 do cells[1,i]:=floattostr(r.botem[i]);
    cells[2,0]:='MOIST';
    for i:=1 to 20 do cells[2,i]:=floattostr(r.bofeu[i]);
   end;
   for l:=1 to 20 do stringgrid1.Cells[0,l]:=inttostr(l);
   with stringgrid2 do
   begin
    Cells[0,0]:='layer';
    for i:=1 to 6 do cells[0,i]:=floattostr(i) ;
    cells[1,0]:='C_OMa';
    for i:=1 to 6 do cells[1,i]:=floattostr(r.aos[i]);
    cells[2,0]:='C_OMs';
    for i:=1 to 6 do cells[2,i]:=floattostr(r.sos[i]);
    cells[3,0]:='OPM1';
    for i:=1 to 6 do cells[3,i]:=floattostr(r.ops[1].c[i]);
    cells[3,7]:=inttostr(r.ops[1].nr) ;
    cells[4,0]:='OPM2';
    for i:=1 to 6 do cells[4,i]:=floattostr(r.ops[2].c[i]);
    cells[4,7]:=inttostr(r.ops[1].nr) ;
    cells[5,0]:='OPM3';
    for i:=1 to 6 do cells[5,i]:=floattostr(r.ops[3].c[i]);
    cells[5,7]:=inttostr(r.ops[1].nr) ;
    cells[6,0]:='OPM4';
    for i:=1 to 6 do cells[6,i]:=floattostr(r.ops[4].c[i]);
    cells[6,7]:=inttostr(r.ops[1].nr) ;
    cells[7,0]:='OPM5';
    for i:=1 to 6 do cells[7,i]:=floattostr(r.ops[5].c[i]);
    cells[7,7]:=inttostr(r.ops[1].nr) ;
    cells[8,0]:='OPM6';
    for i:=1 to 6 do cells[8,i]:=floattostr(r.ops[6].c[i]);
    cells[8,7]:=inttostr(r.ops[1].nr) ;
   end;
   with stringgrid3 do
   begin
    Cells[0,0]:='PARM';
    Cells[1,0]:='VALUE';
    cells[0,1]:='PNR';   cells[1,1]:=inttostr(r.pnr);
    cells[0,2]:='veganf'; cells[1,2]:=inttostr(r.veganf);
    cells[0,3]:='vegend'; cells[1,3]:=inttostr(r.vegend);
    cells[0,4]:='tempanf'; cells[1,4]:=inttostr(r.tempanf);
    cells[0,5]:='dbgmax'; cells[1,5]:=inttostr(r.dbgmax);
    cells[0,6]:='matanf'; cells[1,6]:=inttostr(r.matanf);
    cells[0,7]:='wutief'; cells[1,7]:=floattostr(r.wutief);
    cells[0,8]:='bedgrd'; cells[1,8]:=floattostr(r.bedgrd);
    cells[0,9]:='bestho'; cells[1,9]:=floattostr(r.bestho);
    cells[0,10]:='apool'; cells[1,10]:=floattostr(r.apool);
    cells[0,11]:='nvirt'; cells[1,11]:=floattostr(r.nvirt);
    cells[0,12]:='maxpflent';cells[1,12]:=floattostr(r.maxpflent);
    cells[0,13]:='kumpflent';cells[1,13]:=floattostr(r.kumpflent);
    cells[0,14]:='legans';if r.legans then cells[1,14]:=' Y' else cells[1,14]:='N';
    cells[0,15]:='mtna';cells[1,15]:=floattostr(r.mtna);
    cells[0,16]:='besruh';if r.besruh then cells[1,16]:=' Y' else cells[1,16];
    cells[0,17]:='forts';cells[1,17]:=floattostr(r.forts);
   end;

   with stringgrid4 do
   begin
    Cells[0,0]:='PARM';
    Cells[1,0]:='VALUE';
    cells[0,1]:='daynr'; cells[1,1]:=floattostr(r.tag);
    cells[0,2]:='year'; cells[1,2]:=floattostr(r.jahr);
    cells[0,3]:='plot';cells[1,3]:=r.schlag;
    cells[0,4]:='snow';cells[1,4]:=floattostr(r.snow);
    cells[0,5]:='speisch'; cells[1,5]:=floattostr(r.speisch );
    cells[0,6]:='szep';cells[1,6]:=floattostr(r.szep);
//K    cells[0,7]:='recno';cells[1,7]:=inttostr(_recno);      //_recno ist unbekannt ?
//    cells[0,7]:='besruh';if r.besruh then cells[1,7]:=' Y' else cells[1,7];
 //   cells[0,8]:='forts';cells[1,8]:=floattostr(r.forts);
 //   cells[0,9]:='name';
   end;

end;

procedure TST_View.FormActivate(Sender: TObject);
var stc_dir:dirptr;
    i:integer;
begin
   label1.caption:=filename;
   listbox1.Items.Clear;
   listbox1.sorted:=true;
   stc_length(filename,n_rec);
   label2.caption:=inttostr(n_rec-1)+' records';
   get_cat_dir(filename,stc_dir);
   while stc_dir<>NIL do
   begin
       listbox1.items.add( stc_dir.schlag );
       stc_dir:=stc_dir.next;
   end;
   for i:= 0 to stringgrid1.colcount-1 do stringgrid1.cols[i].Clear;
   for i:= 0 to stringgrid2.colcount-1 do stringgrid2.cols[i].Clear;
   for i:= 0 to stringgrid3.colcount-1 do stringgrid3.cols[i].Clear;
   for i:= 0 to stringgrid4.colcount-1 do stringgrid4.cols[i].Clear;
end;

procedure TST_View.ListBox1DblClick(Sender: TObject);
var a_plot:string;
    n:integer;
    suchen:boolean;
begin
   a_plot:=listbox1.items[listbox1.itemindex];
   n:=1;
   suchen:=true;
   while (n<n_rec) and suchen do
   begin
     status_lesen(filename,n,r);
     suchen:=(a_plot<>r.schlag);
     inc(n);
   end;
   show_record;
   button2.enabled:=(satz_next>0);
   button1.enabled:=(satz_vor>0);
 end;

procedure TST_View.Button2Click(Sender: TObject);
var dummy:integer;
begin
    status_lesen(filename,satz_next,r);
    show_record;
    button2.enabled:=(satz_next>0);
    button1.enabled:=(satz_vor>0);
end;

procedure TST_View.Button1Click(Sender: TObject);
var dummy:integer;
begin
    status_lesen(filename,satz_vor,r);
    show_record;
    button1.enabled:=(satz_vor>0);
      button2.enabled:=(satz_next>0);
end;

procedure TST_View.Button3Click(Sender: TObject);
begin
 st_view.close;
end;

procedure TST_View.Button4Click(Sender: TObject);
var bn,cn:string;
    i:integer;
    cat:textfile;
    f:file;
    ok:boolean;
    h:siptr;
    schlag,
    snr_,
    utlg_,
    s0,
    s1  : string[6];

 begin
  cn:=filename;
  i:=pos('.',cn);
  if i>0 then cn:=copy(cn,1,i-1);   { Dateierweiterung entfernen }
  bn:=cn+'.bak';
  cn:=cn+'.stc';
  suche(bn,ok);
  if ok then
   begin
     assignfile(f,bn);
     erase(f);
   end;
  assignfile(f,cn);
  rename(f,bn);
  make_catalog(bn,h);
  write_catalog(cn,h);
 assignfile(cat,'CATALOG.$$$');
 reset(cat);
 while not eof(cat)  do
 begin
 readln(cat,schlag,snr_,utlg_,s0,s1);
 // fda-aktualisieren !
 {
  with hquery do
  begin
   close;
   databasename:=cdy_uif.cdydpath.text;
   sql.clear;
   sql.add(' update FDA'+range_select.cdy_db+'.dbf SET STATUSANF='+s0);
   sql.add(' ,STATUSEND='+s1);
   sql.add(' where SNR='+snr_+' and UTLG='+utlg_);
   execsql;
  end;
  }
 end;
 closefile(cat);
 formactivate(self);
 end;

end.
