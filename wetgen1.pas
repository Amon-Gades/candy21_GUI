unit wetgen1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
    StdCtrls, FileCtrl,  ExtCtrls, Buttons,
  Data.Win.ADODB, Data.DB, Vcl.Menus, Vcl.DBCtrls,  Vcl.Grids,
  Vcl.DBGrids, VCLTee.TeEngine, VCLTee.Series, VCLTee.TeeProcs, VCLTee.Chart,
  Vcl.ComCtrls,{ vorbi_c, }    variants,ComObj,types97, CheckLst,    strutils,
                           cdywett,  cdyspsys, wg_proc,
  { DBTables, }
  clipbrd,
  PBCheckLB, VclTee.TeeGDIPlus, VCLTee.DBChart;

type
  Tcli_tool = class(TForm)
    Label3: TLabel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    elm_grp: TRadioGroup;
    wgname: TEdit;
    Edit1: TEdit;
    Button1: TButton;
    lb: TListBox;
    Label1: TLabel;
    Label2: TLabel;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    DBNavigator1: TDBNavigator;
    Label4: TLabel;
    Button2: TButton;
    GroupBox1: TGroupBox;
    Button7: TButton;
    Label5: TLabel;
    Edit2: TEdit;
    Label6: TLabel;
    Edit3: TEdit;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    PopupMenu1: TPopupMenu;
    pastedata1: TMenuItem;
    CheckBox1: TCheckBox;

    DataSource2: TDataSource;
    DBLookupComboBox1: TDBLookupComboBox;

    DataSource3: TDataSource;
    DBGrid2: TDBGrid;
    wstat_clb: TPBCheckListBox;
    Memo1: TMemo;

    Label7: TLabel;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    DBChart1: TDBChart;
    Series2: TFastLineSeries;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);

    procedure elm_grpClick(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure cb_wstat_CloseUp(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
 //   procedure wstat_clbDblClick(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure DBGrid1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure pastedata1Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure DBLookupComboBox1CloseUp(Sender: TObject);
    procedure DataSource3DataChange(Sender: TObject; Field: TField);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DBGrid2DblClick(Sender: TObject);
    procedure w_g_xMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure DataSource2DataChange(Sender: TObject; Field: TField);
//    procedure FormShow(Sender: TObject);

  private
    { Private-Deklarationen }
     const
        got_hints:boolean=false;
     var
        lastindex:integer;
        dwo      :Tdbwetter;
     procedure wstat_select;
  public
    { Public-     }
    fn,ws,yr:string;
    a_wstat:string;
           XlApp, XlBook, XlSheet, XlSheets, Range : Variant; // Excel 97
  end;

var
  cli_tool: Tcli_tool;

implementation
    uses candy_uif, cnd_util,range_sel_U, sql_unit, FDC_modul;
{$R *.DFM}

procedure Tcli_tool.Button1Click(Sender: TObject);

begin

   make_wg( cdy_uif.cdydpath.text,cdy_uif.cdydpath.Text,wgname.Text);

end;

procedure Tcli_tool.Button2Click(Sender: TObject);

begin
 a_wstat:='';
 cli_tool.Close;

end;

procedure Tcli_tool.wstat_select;
var p:wetpoint;
    d:tdate;

    i:integer;
    ok_sonn,ok_glob,ok_x,ok_m:booleAn;

begin

 fn:= fdc.wyr.FieldByName('widx').asstring;
  yr:=rightstr(fn,4);
  ws:=leftstr(fn,3);


 fdc.htab.filtered:=false;
 fdc.htab.filter:='widx='''+fn+'''';
 fdc.htab.filtered:=true;

 fdc.wdqry.SQL.Clear;
 if fdc.wyr.Connection.Params.DriverID='PG'
 then  fdc.wdqry.SQL.Add(' select  *, 1 as x from cdy_cldat where wstat='+''''+ws+''''+' and extract (year from datum)='+yr)
 else  fdc.wdqry.SQL.Add(' select  *, 1 as x from cdy_cldat where wstat='+''''+ws+''''+' and year(datum)='+yr);


 fdc.wdqry.Open;
 ok_sonn:= (fdc.wdqry.FindField('SONN')<>nil);
 ok_glob:= (fdc.wdqry.FindField('GLOB')<>nil);

 ok_x   := (fdc.wdqry.FindField('LTMAX')<>nil);
 ok_m   := (fdc.wdqry.FindField('LTMIN')<>nil);



 elm_grp.Items.Clear;
 elm_grp.Items.Add('Temperature');
 elm_grp.Items.Add('Precipitation');
 if  ok_sonn then     elm_grp.Items.Add('Sunshine');
 if  ok_glob then elm_grp.Items.Add('Glob.Radiation') ;
 if  ok_x then elm_grp.Items.Add('Temp (max)');
 if  ok_m then elm_grp.Items.Add('Temp (min)');

  if lastindex>(-1) then  elm_grp.ItemIndex:=lastindex
                    else  elm_grp.ItemIndex:=0;
end;

procedure Tcli_tool.w_g_xMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
  var mx,vx,my,vy:double;    d:tdate;
begin
(*
my:=w_g.GetCursorPos.y;
mx:= w_g.GetCursorPos.x ;
 vX:=w_g.Axes.Bottom.CalcPosPoint(round(mX));
 d:=tdate(vx);
  vY:=w_g.Axes.Left.CalcPosPoint(round(mY));
label7.Caption:={floattostr(vx)+';  '+}datetostr(d)+';  '+floattostr(vy);
*)
end;

procedure Tcli_tool.elm_grpClick(Sender: TObject);
var p:wetpoint;
    d:tdatetime;
    w:simwet;
    s,elm:string;
    dnr:integer;

procedure draw_climate;
begin
//w_g.BottomAxis.DateTimeFormat:='dd.mm.yyyy';
  s:=elm_grp.items.strings[elm_grp.ItemIndex];

  if s=  'Temperature'         then  elm:='LTEM';
  if s=  'Precipitation'       then  elm:='NIED';
  if s=  'Sunshine'            then  elm:='SONN';
  if (s=  'Glob.Radiation' )   then  elm:='GLOB';
  if s=  'Temp (min)'          then  elm:='LTMIN';
  if s=  'Temp (max)'          then  elm:='LTMAX';
//noch importieren  if s=  'Glob.Radiation(wg)'  then  w_g.series[0].AddXY(d,sdr2grd(strtoint(edit1.text),dnr,w.sonn));

  //  if s=  'WindSpeed' then  wg[1][d]:=w.nied;
//  if s=  'Humidity' then  wg[1][d]:=w.lfeu;
  fdc.wdqry.close;
  fdc.wdqry.SQL.Clear;
   if fdc.wyr.Connection.Params.DriverID='PG'
 then   fdc.wdqry.SQL.Add('select datum ,'+elm+' as x from cdy_cldat where wstat='+''''+ws+''''+' and extract(year from datum)='+yr)
 else   fdc.wdqry.SQL.Add('select datum ,'+elm+' as x from cdy_cldat where wstat='+''''+ws+''''+' and year(datum)='+yr);
  fdc.wdqry.Open;
end;

begin

   draw_climate;
end;

procedure Tcli_tool.FormActivate(Sender: TObject);
begin
  if not got_hints then  cdy_uif.get_hints('cli_tool',cli_tool);
  got_hints:=true;
  lastindex:=-1;
  fdc.htab.TableName:='cdy_cldat';
  fdc.htab.Open ;
  fdc.wyr.close;
  fdc.wcnt.Close;
  fdc.wcnt.Open;
  fdc.wcnt.First;
  if fdc.wcnt.Locate('wstat',a_wstat,[]) then
  begin
    dblookupcombobox1.KeyValue:=a_wstat;
    fdc.wyr.Close;
    fdc.wyr.Open;
  end;
end;

procedure Tcli_tool.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 a_wstat:='';
 fdc.htab.Close;
 fdc.htab.TableName:='';
end;



procedure Tcli_tool.Button3Click(Sender: TObject);
var zeile,spalte:integer;
    p:wetpoint;
    s:simwet;
    d:tdate;
    vlst:Tchartvaluelist;
begin
{
 // Ole actions
 try
  XlApp  := CreateOleObject('Excel.Application');
  XlBook := XlApp.WorkBooks.Add(xlWBATWorksheet);
                                // xlWBATChart, xlWBATExcel4IntlMacroSheet,
                                // xlWBATExcel4MacroSheet, xlWBATWorksheet
  XlSheet  := XlApp.WorkBooks[1].Sheets[1]; // Active Sheet
  XlSheets := XlApp.Sheets; // Array of Sheets

  if VarType(XlApp) <> VarDispatch then begin  // If we are not connected with MsExcel
   ShowMessage('MS Excel 97 not this installed');
   Exit;
  end;

  // Form actions
 XlApp.Visible := True;
//  SetSpinSheet(1);
//  SetTxtToWrite;

 except
  XlApp.Quit;
  ShowMessage('Error when opening OLE with MsExcel 97');
  exit;
 end;
// Datenübertragung
p:=dwo.wett_anf;
 XlSheet.Cells[1,1] :='DATE';
 XlSheet.Cells[1,2] :=elm_grp.items.strings[elm_grp.itemindex];
 zeile:=0 ;

 while copy(p.datum,1,5)<>'31.12' do
 begin
  inc(zeile);
  s.datum:=p.datum;
  dwo.wetter(s,true,false);
  d:=strtodate(p.datum);
  XlSheet.Cells[zeile+1,1] := p.datum;
  XlSheet.Cells[zeile+1,2] := w_g.Series[0].YValues[zeile-1];
  p:=p.Next;
 end;
 //  last record
   inc(zeile);
  s.datum:=p.datum;
  dwo.wetter(s,true,false);
  d:=strtodate(p.datum);
  XlSheet.Cells[zeile+1,1] := p.datum;
  XlSheet.Cells[zeile+1,2] := w_g.Series[0].YValues[zeile-1];
}
sql_form.grid2excel(dbgrid1);
end;



procedure Tcli_tool.cb_wstat_CloseUp(Sender: TObject);
var wetfiles:string;
  sr: TSearchRec;
  ci:integer;

begin

   wstat_clb.Clear;
   fdc.htab.close;

 //  wgname.Text:=  cb_wstat.Items[cb_wstat.itemindex]

end;

procedure Tcli_tool.Button4Click(Sender: TObject);
var i:integer;
begin
 for i:=1 to wstat_clb.Items.Count do wstat_clb.checked[i-1]:=true;
end;

procedure Tcli_tool.Button5Click(Sender: TObject);
var i:integer;
begin
 for i:=1 to wstat_clb.Items.Count do wstat_clb.checked[i-1]:=false;
end;

procedure Tcli_tool.Button6Click(Sender: TObject);
var i:integer;
begin
 for i:=1 to wstat_clb.Items.Count do wstat_clb.checked[i-1]:=not wstat_clb.checked[i-1];
end;



procedure Tcli_tool.Button7Click(Sender: TObject);
var fname,str_name:string;
    a_dat :tdate;
   rwo:Trndwetter;
    swet:simwet;
    dnr:integer;
     ok_sonn:boolean;
       function fcopy(s,d:string):boolean;
        var ok:boolean;
        begin
           if fileexists(s) then
           ok:=copyfile(pchar(s),pchar(d),false);
           fcopy:=ok;
        end;

begin

  fdc.wdqry.close;
  fdc.wdqry.SQL.Clear;
  fdc.wdqry.SQL.Add(' select * from cdy_cldat');
  fdc.wdqry.Open;
  ok_sonn:= (fdc.wdqry.FindField('SONN')<>nil);
  fdc.wdqry.Close;
  if radiobutton2.Checked and not ok_sonn then
  begin
    fdc.wdqry.SQL.Clear;
    fdc.wdqry.SQL.Add(' alter table cdy_cldat add SONN float');
    fdc.wdqry.ExecSQL;
  end;



  if checkbox1.checked then
  begin
//   new( rwo, init(0,0,1,0, cdy_uif.cdydpath.text+'\'+copy(edit2.Text,1,3)+'.per',0));
  rwo:=Trndwetter.create(0,0,1,0, cdy_uif.cdydpath.text+'\'+copy(edit2.Text,1,3)+'.per',0);
   rwo.yr_init(strtoint(edit3.Text));
  end;
  dnr:=1;
  fname:=edit3.Text;
  // Tabelle füllen
   fdc.htab.Open;
   fdc.htab.append;
   a_dat:=strtodate('01.01.'+edit3.text);
//   while copy(datetostr(a_dat),1,5)<>'31.12' do
   repeat
   begin
    inc (dnr);
    fdc.htab.append;
    fdc.htab.FieldByName('DATUM').asdatetime:=a_dat;
    fdc.htab.FieldByName('wstat').AsString:=trim(edit2.Text);
    fdc.htab.FieldByName('WIDX').AsString:= trim(edit2.Text)+'_'+trim(edit3.Text);
    a_dat:=a_dat+1;
    if checkbox1.checked then
    begin
     swet.datum:= datetostr(a_dat-1);//essdatum(dnr,strtoint(edit3.Text));
     rwo.wetter(swet,true,false);
     fdc.htab.FieldByName('NIED').asfloat:=swet.nied;
     fdc.htab.FieldByName('LTEM').asfloat:=swet.ltem_h;
     fdc.htab.FieldByName('GLOB').asfloat:=swet.glob;
    end;
    fdc.htab.post;
   end;
   until copy(datetostr(a_dat-1),1,5)='31.12' ;
   fdc.htab.close;
   // auf neue Wetterstation einstellen
   // range_select.find_wetter_stat;
   // cb_wstat.Items:=   range_select.fda_wett.items;
   // cb_wstat.ItemIndex:=cb_wstat.Items.IndexOf(copy(edit2.Text,1,3));


 fdc.wyr.Close;
 fdc.wyr.Open;
 fdc.wcnt.close;
 fdc.wcnt.Open;

 fdc.wcnt.Locate('wstat', edit2.text,[]);
 dblookupcombobox1.KeyValue:=edit2.Text;

//   cb_wstatcloseUp(self);
//   wstat_clb.ItemIndex:=wstat_clb.Items.IndexOf(table2.tablename);
//   wstat_clbdblclick(self);

end;

procedure Tcli_tool.DataSource2DataChange(Sender: TObject; Field: TField);
begin
fdc.wyr.Close;
if fdc.wyr.Connection.Params.DriverID='PG' then
begin
fdc.wyr.SQL.Clear;
fdc.wyr.SQL.add('SELECT (cdy_cldat.wstat||'+''''+'_'+''''+'|| extract( year from DATUM ))::varchar AS widx    FROM cdy_cldat ');
fdc.wyr.SQL.add(' where wstat=:wstat GROUP BY extract(year from DATUM), cdy_cldat.wstat order BY extract(year from DATUM), cdy_cldat.wstat');
end;

fdc.wyr.ParamByName('wstat').AsString:=fdc.wcnt.FieldByName('wstat').asstring;

//fdc.wyr.SQL.SaveToFile('check0.sql');
fdc.wyr.Open;
end;

procedure Tcli_tool.DataSource3DataChange(Sender: TObject; Field: TField);
begin
 wstat_select;
end;

procedure Tcli_tool.DBGrid1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
  var gc:tgridcoord;
      fname:string;
      i:integer;
begin
{
gc:= dbgrid1.MouseCoord(x,y);
fname:=dbgrid1.fields[gc.X].FieldName;
if fdc.htab.RecNo<fdc.htab.RecordCount then
begin
  // sätze übernemen
  for i:=1 to 10 do
  begin
    fdc.htab.FieldByName(fname).AsString:='0';
  end;

end;
  }
end;
 procedure Tcli_tool.DBGrid2DblClick(Sender: TObject);
begin
 wstat_clb.items.add(fdc.wyr.FieldByName('widx').asstring);
end;

procedure Tcli_tool.DBLookupComboBox1CloseUp(Sender: TObject);
begin
fdc.wyr.Close;
fdc.wyr.Open;
wgname.Text:=fdc.wcnt.FieldByName('wstat').AsString;
end;

function HolAusClipboard(var z: Tstringlist): boolean;{ overload;}
var
  h: THandle;
  p: PChar;
  hs,s: string;
  i,k:integer;
begin
  ClipBoard.Open;
  try
    h := Clipboard.GetAsHandle(CF_UNICODETEXT);
    p := GlobalLock(h);
    s := ansiuppercase(p);
    GlobalUnlock(h);
  finally
    Clipboard.Close;
  end;

  s := stringreplace(s, #13, '/', [rfreplaceall]);
  s := stringreplace(s, #10, '', [rfreplaceall]);
  s := stringreplace(s, #32, '', [rfreplaceall]);
 //  s := stringreplace(s, '.', ',', [rfreplaceall]);

 { s := stringreplace(s, 'DM', '', [rfreplaceall]);
  s := stringreplace(s, 'EUR', '', [rfreplaceall]);
  s := stringreplace(s, '€', '', [rfreplaceall]);
  s := stringreplace(s, '¥', '', [rfreplaceall]);
  s := stringreplace(s, '£', '', [rfreplaceall]);
  }
  try
    begin
   repeat
   i:=length(s);
   k:=pos('/',s);
   hs:=copy(s,0,k-1);
   z.Add(hs);
   s:=copy(s,k+1,i);
   until s='';
    end;
  except result := false;
    exit;
  end;

  result := true;
end;


procedure Tcli_tool.pastedata1Click(Sender: TObject);
 var gc:tgridcoord;
      fname:string;
      i:integer;
      zstr:tstringlist;
begin
zstr:=tstringlist.Create;
  if HolAusClipboard(Zstr) then
 begin
  fname:=dbgrid1.selectedfield.FieldName;
  if fdc.htab.RecNo<fdc.htab.RecordCount then
begin
  // sätze übernemen
  for i:=1 to zstr.Count do
  begin
    fdc.htab.Edit;
    fdc.htab.FieldByName(fname).AsString:=zstr.Strings[i-1];
    fdc.htab.Post;
    fdc.htab.Next;
  end;
  end;
end;
 zstr.free;
end;



procedure Tcli_tool.Button8Click(Sender: TObject);
var rwo:prndwetter;
    swet:simwet;
begin
 
end;

end.
