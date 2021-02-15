unit sql_unit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, registry, strutils, fdc_modul,
  Dialogs, StdCtrls, DB,   FileCtrl, Grids, DBGrids, ComCtrls,  comobj,  OleServer,  types97, math,
  ADODB, Excel2000;

type
  Tsql_form = class(TForm)
    Button1: TButton;
    Memo1: TMemo;
    DataSource1: TDataSource;
    CheckBox1: TCheckBox;
    Button3: TButton;
    Button4: TButton;
    SaveDialog1: TSaveDialog;
    OpenDialog1: TOpenDialog;
    Label2: TLabel;
    UpDown1: TUpDown;
    Label1: TLabel;
    Label3: TLabel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    DBGrid1: TDBGrid;
    StringGrid1: TStringGrid;
    Button2: TButton;
    Button5: TButton;
    Button6: TButton;
    xla: TExcelApplication;
    procedure Button1Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormShow(Sender: TObject);

    procedure UpDown1Click(Sender: TObject; Button: TUDBtnType);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
    cdyini:tregistry ;
    memos: array[0..11] of Tstringlist;
    mem_id: integer;
    regdel:string;
    procedure read_registry;
  public
    { Public declarations }
    var_count:integer;
    procedure grid2excel(G:Tdbgrid);
  end;

var
  sql_form: Tsql_form;

implementation

uses candy_uif, tabedit1;

{$R *.dfm}

procedure Tsql_form.read_registry;
begin
  // registry lesen
  cdyini:=Tregistry.Create;
  cdyini.RootKey := HKEY_CURRENT_USER;
  cdyini.OpenKey('\Software\candy', false);
  if cdyini.KeyExists('sql_deli')
  then  regdel:=cdyini.ReadString('sql_deli')
  else  regdel:='!,!';
  cdyini.closekey;
  cdyini.free;

end;

procedure Tsql_form.Button1Click(Sender: TObject);
var i,j,l:integer;
try_drop:boolean;
sqltxt:string;

{############################
procedure sql_execute;
begin
if (pos('insert', lowercase(query1.SQL.Text))> 0)
or (pos('update', lowercase(query1.SQL.Text))> 0)
or (pos('delete', lowercase(query1.SQL.Text))> 0)
or (pos('into',   lowercase(query1.SQL.Text))>0)
or (pos('drop',    lowercase(query1.SQL.Text))>0)
 then checkbox1.checked:=true else checkbox1.Checked:=false;

if checkbox1.checked then query1.ExecSQL
                      else query1.open;

end;
################################}


procedure sql_execute;
const deli_: array [0..2] of string = (' ', ',', ';');
var idel,i,j,k,w:integer;
    zeile, item,
    txtfilename,
    dmode,        // *: fixed width #: special delimiter
    dspec,
    tname:string;
    sql_text:string;
    deli: array of string;
    f:textfile;
begin
//regdel:='!,!.!/!"!, !';
idel:=0;
for i := 1 to length(regdel) do if regdel[i]='!' then inc(idel);
setlength(deli,idel+1);
j:=1;
while regdel[j]='!' do
begin
inc(j);
dec(idel);
end;
deli[0]:=' ';
for i := 1 to idel do
  begin
    while regdel[j]='!' do inc(j);
    deli[i]:='';
    while regdel[j]<>'!' do begin deli[i]:=deli[i]+regdel[j] ; inc(j); end;
  end;


idel:=0;
txtfilename:='';
w:=0;
dmode:='?';
j:= (pos('totxt',    lowercase(fdc.hqry.SQL.Text)));
if j   >0 then
begin
 sql_text:= fdc.hqry.SQL.text;
// is there a delimiter format ?
 k:=j+5;
 while sql_text[k]<>' ' do inc(k);
 if k>(j+5) then
 begin
  dmode:= sql_text[j+5];
  dspec:= copy(sql_text,j+6,k-j-6);
 end;
 w:=strtoint(dspec);
 sql_text:=leftstr(sql_text,j-1)+ rightstr(sql_text, length(sql_text)-k);
 while SQL_Text[j]=' ' do inc(j);
 tname:=SQL_Text[j];
 SQL_Text[j]:=' ';
 inc(j);
 while (SQL_Text[j] <>chr(13)) and (SQL_Text[j] <>' ') do
 begin
 tname:=tname+SQL_Text[j];
 SQL_Text[j]:=' ';
 inc(j);
 end;

 fdc.hqry.SQL.Clear;
 fdc.hqry.SQL.Add(sql_text);
 if (pos('\',tname)=0) then tname:=  cdy_uif.cdydpath.text+'\'+tname;

 txtfilename:=tname // suffix wird vorgegeben +'.txt';


end;



if (pos('insert',    lowercase(fdc.hqry.SQL.Text))> 0)
or (pos('update',    lowercase(fdc.hqry.SQL.Text))> 0)
or (pos('delete',    lowercase(fdc.hqry.SQL.Text))> 0)
or (pos('into',      lowercase(fdc.hqry.SQL.Text))>0)
or (pos('drop',      lowercase(fdc.hqry.SQL.Text))>0)
or (pos('edit_table',lowercase(fdc.hqry.SQL.Text))>0)
 then checkbox1.checked:=true else checkbox1.Checked:=false;
if checkbox1.checked then
                     begin
                      if pos('edit',lowercase(fdc.hqry.SQL.Text))=0
                        then fdc.hqry.ExecSQL
                        else // edit modus
                        begin
                          j:=pos('edit_table',lowercase(fdc.hqry.SQL.Text));
                          tname:=copy(fdc.hqry.SQL.Text,j+11,length(fdc.hqry.SQL.Text));
//                          ftabed.adotable1.Connection:=cdy_uif.ado_cdyprm;
                          fdc.htab.tablename:=tname;         // ftabed.adotable1.tablename:=tname;

                          fdc.htab.open; //ftabed.ADOTable1.Open;
                          ftabed.waitmode:=true;
                          ftabed.show;
                          repeat
                            application.ProcessMessages;
                          until not ftabed.waitmode ;
                        end;
                     end
                     else fdc.hqry.open;
if txtfilename<>'' then
begin
  assignfile(f,txtfilename);
  rewrite(f);
  fdc.hqry.First;
  repeat
   zeile:='';
   k:= fdc.hqry.FieldCount;
   for j:=1 to k do
   begin
    item:=fdc.hqry.Fields.FieldByNumber(j).FieldName;
    if lowercase(item)<>'ix' then
      begin
       item:=fdc.hqry.Fields.FieldByNumber(j).asstring;
       if dmode='*' then zeile:=zeile+rightstr('          '+item,w)
                    else if j=k then zeile:=zeile+item
                                else zeile:=zeile+item+deli[w];
      end;
   end;
   writeln(f,zeile);
   fdc.hqry.Next;
  until fdc.hqry.eof ;
  closefile(f);
end;

end;





begin
if mem_id<10 then inc(mem_id)
else
begin
 for i:=2 to 10 do memos[i-1]:=memos[i]
end;
memos[mem_id].Clear;
memos[mem_id].addstrings(memo1.Lines);
label1.Caption:=inttostr(mem_id);
fdc.hqry.close;

fdc.hqry.sql.clear;
l:=memo1.Lines.Count;
try_drop:=false;
for I := 0 to l - 1 do
begin
  sqltxt:=trim(memo1.lines[i]);
  if  (length(sqltxt)>0) and (sqltxt[1]<>'''') then
  Begin // proceed if no comment
     if trim(sqltxt)='go' then
     begin
     // execute sql command
      application.processmessages;
      if try_drop then
      begin
       try_drop:=false;
       try
        sql_execute;
       except; end;
      end
      else  sql_execute;
      // clean up  after execute
      fdc.hqry.Close;
      fdc.hqry.sql.clear;
     end
     else
     begin
      // build up sql command
      j:=pos('drop', sqltxt);
      if j>0 then try_drop:=true;
      j:=length(sqltxt)  ;
      if j>0 then fdc.hqry.SQL.add(sqltxt);
     end;
   End;
end;
// execute last statement
if length (fdc.hqry.SQL.Text)>0 then
sql_execute;
end;

{ sql -script für R-Interface
    if  fileexists(sql_source) then
  begin
   assignfile(sqlfile, sql_source);
   reset(sqlfile);
   try_drop:=false;
   repeat
     readln(sqlfile,sqltxt);
     if trim(sqltxt)='go' then
     begin
     application.processmessages;
     if try_drop then
     begin
      try_drop:=false;
      try
      spez_qry.ExecSQL;
      except; end;
     end
     else  spez_qry.ExecSQL;
     spez_qry.Close;
     spez_qry.sql.clear;
     end else  begin
                  i:=pos('drop', sqltxt);
                  if i>0 then try_drop:=true;
                  // snr updaten
                  i:= pos('#fl_id',sqltxt);
                  if i>0 then sqltxt:=stuffstring(sqltxt,i,6,asnr);
                  spez_qry.SQL.add(sqltxt);
               end;
   until eof(sqlfile);
  end;
 }
procedure Tsql_form.Button4Click(Sender: TObject);
begin
if savedialog1.Execute then
memo1.Lines.SaveToFile(savedialog1.FileName);
end;

procedure Tsql_form.Button5Click(Sender: TObject);
var i:integer;
begin
 //clear grid

 for i:=  1 to stringgrid1.rowCount  do
 begin
 stringgrid1.Cells[0,i]:='' ;  stringgrid1.Cells[1,i]:='';
 end;
 var_count:=0;
end;

procedure tsql_form.grid2excel(G:Tdbgrid);
var i,f,k,l,lcid:integer;
    x:variant;
    x_:string;
    tab: Tdataset;


begin
  // excel-mappe hochfahren
//lcid:=getuserdefaultlcid;
//to fix an error if office locale is different :
//https://stackoverflow.com/questions/4945024/old-format-or-invalid-type-library
  lcid:=LOCALE_USER_DEFAULT;
   xla.Connect;
   xla.visible[lcid]:=true;
   xla.Workbooks.Add(EmptyParam,lcid);

   f:=g.Columns.Count;
   l:=g.DataSource.DataSet.RecordCount;

   for i:=1 to f do  xla.cells.item[1,i]:= g.Columns[i-1].Title.caption;

  g.DataSource.DataSet.First;
   for i := 1 to l do
   begin
     for k:=1 to f do
     begin
      x:=g.columns[k-1].Field.asvariant;
      try
      xla.cells.item[1+i,k]:=   x;
      except
      xla.cells.item[1+i,k]:=g.columns[k-1].Field.asstring;
      end;
     end;
       g.DataSource.DataSet.next;
   end;
 //   xla.ActiveWorkbook.SaveCopyAs('d:\daten\workfile.xlsx',lcid);

end;





procedure Tsql_form.Button6Click(Sender: TObject);
var i,f:integer;
x:double;
x_:string;
    tab: Tdataset;
       wsheet,
    oleworkbook,
    xla               : Variant;
begin
  // excel-mappe hochfahren
{
  tab:=dbgrid1.DataSource.DataSet;

   try
    i:= xla.cells.item[1,1];
   except
    xla := CreateOleObject('Excel.Application');
    OleWorkBook   :=  XlA.WorkBooks.Add(xlWBATWorksheet)
   end;
   tab.Open;
   f:= tab.FieldList.Count;
   i:=1;
   xla.visible:=true;
   for i:=1 to f do  xla.cells.item[1,i]:=tab.FieldList.Fields[i-1].FieldName;
   tab.First;
   repeat
     for i:=1 to f do
     begin
     xla.cells.item[1+tab.RecNo,i]:=   tab.FieldList.Fields[i-1].Asstring;
     end;
     tab.Next;
    until tab.Eof
 }
    grid2excel(dbgrid1);
end;



procedure Tsql_form.Button2Click(Sender: TObject);
var i,ii,il,jj,jl,vc:integer;
    vn: array[1..10] of string   ;

begin
if mem_id<10 then inc(mem_id)
else
    begin
     for i:=2 to mem_id do memos[i-1]:=memos[i]
    end;
memos[mem_id].Clear;
memos[mem_id].addstrings(memo1.Lines);
vc:=0;
il:=  memo1.Lines.Count;
for vc := 1 to var_Count  do
begin
    vn[vc]:= stringgrid1.Cells[0,vc];
    for ii:=0 to il-1 do
    begin
      if  pos('$', memo1.Lines[ii])>0  then
      begin
         memo1.Lines[ii]:=stringreplace(memo1.Lines[ii], vn[vc], stringgrid1.Cells[1,vc],[rfreplaceall,rfignorecase]);
      end;
    end;
    application.ProcessMessages;
end;
end;

procedure Tsql_form.Button3Click(Sender: TObject);
var ii,il,jj,jl,vc,ic:integer;
    hvn:string;
    vn: array[1..10] of string   ;
    known:boolean;
begin
vc:=0;
 for ic := 1 to stringgrid1.RowCount do if stringgrid1.Cells[0,ic]>'' then inc(vc);
                                        
if opendialog1.Execute then memo1.Lines.LoadFromFile(opendialog1.FileName);
il:=  memo1.Lines.Count;
for ii:=0 to il-1 do
begin
  for jj := 1 to length(memo1.Lines[ii]) do
  if memo1.Lines[ii][jj]='$' then
  begin
  hvn:='';
   jl:=1;
   repeat inc(jl) until (memo1.Lines[ii][jj+jl+1]=' ') or ((jj+jl)=length(memo1.Lines[ii]));
   hvn:=copy(memo1.lines[ii],jj, jl+1);
   known:=false;
   for ic := 1 to stringgrid1.RowCount do  known:=known or (stringgrid1.Cells[0,ic]=hvn);
   if not known  then
   begin
   inc(vc);
   vn[vc]:=hvn;
   stringgrid1.Cells[0,vc]:=vn[vc];
   end;
  end;
end;
var_count:=vc;
end;

procedure Tsql_form.FormShow(Sender: TObject);
var i:integer;
begin

for i:=0 to 10 do memos[i]:=tstringlist.create;
mem_id:=0;
end;




procedure Tsql_form.UpDown1Click(Sender: TObject; Button: TUDBtnType);
begin
updown1.Position:=0;
 if (button=btnext) and (mem_id>1) then dec(mem_id);
 if (button=btprev) and (mem_id<10) then inc(mem_id);
 memo1.Lines.Clear;
 mem_id:=min(mem_id,10);
 mem_id:=max(0,mem_id);
 memo1.lines.AddStrings(memos[mem_id]);
 label1.Caption:=inttostr(mem_id);
end;

procedure Tsql_form.FormActivate(Sender: TObject);
begin
updown1.Position:=0;
read_registry;
end;

procedure Tsql_form.FormClose(Sender: TObject; var Action: TCloseAction);
var i:integer;
begin
for i:=1 to 10 do
begin
 if memos[i]<> nil then memos[i].free;
end;
end;

procedure Tsql_form.FormCreate(Sender: TObject);
begin
  stringgrid1.Cells[0,0]:='parameter';
  stringgrid1.Cells[1,0]:='value';
end;

end.
