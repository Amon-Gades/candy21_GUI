unit mwshow;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,variants,
  StdCtrls, DBCtrls, Db,  Grids, DBGrids, ExtCtrls,ComObj,types97,      math,
  OleServer,{ Excel97,} ExcelXP, ADODB, VclTee.TeeGDIPlus, VCLTee.Series,
  VCLTee.TeEngine, VCLTee.TeeProcs, VCLTee.Chart, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;
//  ,  TeEngine, Series, TeeProcs, Chart,  TeeGDIPlus;

type
  Tmw_show = class(TForm)
    Button1: TButton;
   // Query1_: TQuery;
    DataSource1: TDataSource;
    DBLookupComboBox1: TDBLookupComboBox;
    DataSource2: TDataSource;
    DBLookupComboBox2: TDBLookupComboBox;
    DBGrid1: TDBGrid;
    DataSource3: TDataSource;
    DBLookupComboBox3: TDBLookupComboBox;
 //   Query4_: TQuery;
    DataSource4: TDataSource;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Button2: TButton;
    SaveDialog1: TSaveDialog;
    Button5: TButton;
    Panel1: TPanel;
    xyg_1: TChart;
    Series1: TLineSeries;
    Series2: TPointSeries;
    Label4: TLabel;
    CheckBox1: TCheckBox;
    Edit1: TEdit;
    Button3: TButton;
    Button4: TButton;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Query1: TFDQuery;
    Query2: TFDQuery;
    Query3: TFDQuery;
    Query4: TFDQuery;
    procedure Button1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure DBLookupComboBox2CloseUp(Sender: TObject);
    procedure DBLookupComboBox1CloseUp(Sender: TObject);
    procedure DBLookupComboBox3CloseUp(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure Edit1Exit(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure xyg_1DblClick(Sender: TObject);
  private
    { Private-Deklarationen }
    const
    got_hints: boolean = False ;
    var
    lcid:integer;
  public
    { Public-Deklarationen }
    a_plot:integer ;
    fname,db:string;

  end;

var mw_show: Tmw_show;

implementation

uses range_sel_U, candy_uif, sql_unit, FDC_modul;

{$R *.DFM}

procedure Tmw_show.Button1Click(Sender: TObject);
var savecng:olevariant;
    i:integer;
begin

 //delphi7
 (*
 xlsheet.Disconnect;
 savecng:=true;
 try
 xl.DisplayAlerts[lcid]:=false;
 xlbook.Close(savecng,cdy_uif.cdydpath.text+'\last_cdy_xl.xls',emptyparam,lcid);
 except end;
 xlbook.Disconnect;
 try
 xl.DisplayAlerts[lcid]:=false;
 xl.Quit;
 except end;
 xl.Disconnect;
                 *)

 query1.close;
 query2.close;
 query3.close;
 query4.close;
 mw_show.close;
end;

procedure Tmw_show.FormActivate(Sender: TObject);

begin
   if not got_hints then  cdy_uif.get_hints('mw_show',mw_show);
   got_hints:=true;
  db:=range_select.a_cdy_item^.db_name;
  query2.close;
  query2.sql.clear;
  query2.sql.add('select distinct fda.fname, 10*mw.SNR+mw.UTLG as PLOT,fda.SBEZ, fda.fname from cdy_msdat mw, cdy_Fxdat fda ');
  query2.sql.add(' where 10*mw.SNR+mw.UTLG=10*fda.SNR+fda.UTLG and mw.fname=fda.fname and mw.fname='''+db+'''');
  query2.open;

  query1.close;
  query3.close;
  query4.close;
  if query2.Locate('PLOT;FNAME',vararrayof([a_plot,db]),[])  then
  begin
    dblookupcombobox2.KeyValue:= a_plot;
    dblookupcombobox2closeup(self);
  end;
// Basis einstellung
 query3.Close;
xyg_1.series[0].Clear;
xyg_1.series[1].Clear;


end;

procedure Tmw_show.FormCreate(Sender: TObject);
begin
//xy.ClearAll;
xyg_1.Series[0].Clear;
xyg_1.Series[1].Clear;
end;

procedure Tmw_show.xyg_1DblClick(Sender: TObject);
// var ced: tcharteditor;
begin
   // chart editor
//   Ced.editChart(xyg_1.getChart());
end;

procedure Tmw_show.DBLookupComboBox2CloseUp(Sender: TObject);
begin
 panel1.Hide;
 db:=range_select.cdy_db;//
 if query2.active then db:=  query2.fieldbyname('fname').AsString;


 query1.close;
 query1.SQL.Clear;
 query1.SQL.Add(' SELECT distinct mkl.Item_ix as IDX, mkl.propname as MERKMAL,mkl.shrtname, mkl.propunit as EINHEIT  ');
 query1.SQL.Add(' from Cdyprop mkl, cdy_msdat mwe where 10*mwe.SNR+mwe.UTLG=');
 query1.SQL.Add( inttostr(dblookupcombobox2.keyvalue)+' and fname='''+db+''' and mwe.M_IX=mkl.Item_ix ');
 query1.open;
end;

procedure Tmw_show.DBLookupComboBox3CloseUp(Sender: TObject);
var t:tdate;
    miss_val:real;
// stats:
   sexp,ssim,
   sqexp,sqsim,
   spes,
   sqdif : double;
   Ndat,f      : integer;

          procedure draw_point;
          begin
           t:=   query3.fieldbyname('dat').asdatetime;
           if  (((query3.fieldbyname('exp').asfloat<>miss_val) and
               not checkbox1.Checked )or checkbox1.checked )
               and (not varisnull(query3.fieldbyname('exp').asvariant))
               then begin //  xy[1][t]:=query3.fieldbyname('exp').asfloat;
                           xyg_1.series[1].addxy(t,query3.fieldbyname('exp').asfloat);
               end;
           if  (((query3.fieldbyname('sim').asfloat<>miss_val) and
               not checkbox1.Checked ) or checkbox1.checked)
               and (not varisnull(query3.fieldbyname('sim').asvariant))
               then begin  //xy[2][t]:=query3.fieldbyname('sim').asfloat;
                           xyg_1.series[0].addxy(t,query3.fieldbyname('sim').asfloat);
               end;
          end;

          procedure reset_stats;
          begin
            sexp:=0;
            ssim:=0;
            sqdif:=0;
            spes:=0;
            sqexp:=0;
            sqsim:=0;
            ndat:=0;
          end;

          procedure update_stats;
          begin
           with query3 do
           begin
            sexp:=sexp+fieldbyname('exp').AsFloat;
            ssim:=ssim+fieldbyname('sim').AsFloat;
            sqexp:=sqexp+sqr(fieldbyname('exp').AsFloat);
            sqsim:=sqsim+sqr(fieldbyname('sim').AsFloat);
            sqdif:=sqdif+sqr(fieldbyname('sim').AsFloat-fieldbyname('exp').AsFloat);
            spes:=spes+fieldbyname('exp').AsFloat*fieldbyname('sim').AsFloat;
            inc(ndat);
           end;
          end;

          function rmse: double;
          begin
            rmse:= sqrt( sqdif/ndat)  ;
          end;

          function error_st (err:double; num:integer) : string;
          var f:integer;
          begin
            f:= round(num-ln(abs(err))/ln(10));
            error_st:=floattostr(roundto(err,-f));
          end;

          function me: double;
          begin
            me:= ( sexp-ssim)/ndat;
          end;

          function efficiency:double;
          var ef :double;
          begin
             try
             ef:= 1- sqdif/(sqexp-(sexp*sexp/ndat));   // Nash-Sutcliffe model efficiency coefficient
             except ef:=-999999;
             end;
            efficiency:= ef;
          end;
begin
// Graphtitle
// xy.appearance.GraphTitle:=dblookupcombobox2.Text+'; sampling depth: '+dblookupcombobox3.Text+'dm';
// xy.XAxis.ShowAsTime:=true;
// xyg_1.Title.caption:= dblookupcombobox2.Text+'; sampling depth: '+dblookupcombobox3.Text+'dm';
   xyg_1.Title.caption:= dblookupcombobox2.Text+': '+dblookupcombobox1.text+'; sampling depth: '+dblookupcombobox3.Text+'dm';

xyg_1.series[0].Clear;
xyg_1.series[1].Clear;
// Tabelle füllen
  with query3 do
  begin
    close;
    sql.clear;
    sql.add('select DATUM as dat,M_WERT as exp,S_WERT as sim from cdy_msdat ');
    sql.add('where 10*SNR+UTLG=:plot and M_IX=:mix');

    if query3.Connection.Params.DriverID='PG'
    then sql.add(' and (S0 || ''-'' || S1)=:depth and fname='''+db+''' order by DATUM')
    else sql.add(' and (str(S0)+''-''+str(S1))=:depth and fname='''+db+''' order by DATUM');
    parambyname('plot').Value:=query2.fieldbyname('PLOT').asinteger;
    parambyname('mix').value:=query1.fieldbyname('IDX').asinteger;
    parambyname('depth').value:=query4.fieldbyname('depth').asstring;
    open;
  end;
 // Diagramm zeichnen
 miss_val:=strtofloat( edit1.text);
// xy.XAxis.Min:=  query3.fieldbyname('dat').asdatetime;
// xy.ClearAll;
 query3.First;
 draw_point;
 query3.next;
 //xy.Plotting:=false;
 dbgrid1.datasource:=nil;
 while not query3.eof do
 begin
   draw_point;
    if  (query3.fieldbyname('exp').asfloat<>miss_val)
    and (query3.fieldbyname('sim').asfloat<>miss_val)
    then update_stats;
   query3.next;
 end;
 button2.Show;
// xy.plotting:=true;
  dbgrid1.datasource:=datasource3;
  f:= round(5-ln(rmse)/ln(10));
  label5.caption:='RMSE='+error_st(rmse,4);
  label6.Caption:='ME  ='+error_st(me,4);
  label7.Caption:='Efcy='+error_st(efficiency,4);
  label5.Show;
  label6.Show;
  label7.show;
 panel1.Show;
end;

procedure Tmw_show.DBLookupComboBox1CloseUp(Sender: TObject);
var hdl:string;
begin

 query4.SQL.Clear;
 if query4.Connection.Params.DriverID='PG'      //
 then query4.SQL.Add(' select distinct (S0 || ''-'' || S1):: varchar as depth , S0, S1 from cdy_msdat ')
 else query4.SQL.Add(' select distinct str(S0)+''-''+str(S1) as depth , S0, S1 from cdy_msdat ');

 query4.SQL.Add('  where 10*SNR+UTLG=:plot and M_IX=:mix and fname=:fn ');



with query4 do
 begin
    close;
     parambyname('plot').value:=query2.fieldbyname('PLOT').asinteger;
     parambyname('mix').value:= query1.fieldbyname('IDX').asinteger;
     parambyname('fn').value:=db;
     open;
    dblookupcombobox3.listfieldindex:=0;
 end;

 hdl:={trim(query1.fieldbyname('MERKMAL').asstring)+}' [' + trim(query1.fieldbyname('EINHEIT').asstring)+']';
 xyg_1.Axes.left.Title.caption:=hdl;

 query4.First;
 dblookupcombobox3.KeyValue:=query4.FieldByName('depth').AsVariant;
 DBLookupComboBox3CloseUp(nil);
 if pos('-99',query4.FieldByName('depth').AsString)>0
 then  begin
        dblookupcombobox3.Hide;
        label2.Hide;
        xyg_1.Title.caption:= dblookupcombobox2.Text+': '+dblookupcombobox1.text;
 end
 else  begin
        label2.Show;
        dblookupcombobox3.show;
       xyg_1.Title.caption:= dblookupcombobox2.Text+': '+dblookupcombobox1.text+'; sampling depth: '+dblookupcombobox3.Text+'dm';
 end;
end;

procedure Tmw_show.Button2Click(Sender: TObject);
begin
// fdc.hqry.databasename:=cdy_uif.cdydpath.text;
 fdc.hqry.sql.clear;
 fdc.hqry.sql.add('update cdy_mvdat set S_WERT=:swert where 10*SNR+UTLG=:plot ');
 fdc.hqry.sql.add(' and M_IX=:mix and DATUM=:dat and S0=:s0  and S1=:s1   and fname='''+db+'''');
 with query3 do
 begin
   first;
   repeat
     // Datensatz kopieren
    fdc.hqry.parambyname('plot').value  :=query2.fieldbyname('PLOT').asinteger;
    fdc.hqry.parambyname('mix').value  :=query1.fieldbyname('IDX').asinteger;
    fdc.hqry.parambyname('swert').value  :=query3.fieldbyname('sim').asfloat;
    fdc.hqry.parambyname('dat').value :=query3.fieldbyname('dat').asdatetime;
    fdc.hqry.parambyname('s0').value   :=query4.fieldbyname('S0').asinteger;
    fdc.hqry.parambyname('s1').value  :=query4.fieldbyname('S1').asinteger;
    fdc.hqry.ExecSQL;
    next;
   until query3.eof;
 end;


end;

procedure Tmw_show.Button3Click(Sender: TObject);
begin
// xy.Print;
xyg_1.PrintLandscape;
end;

procedure Tmw_show.Button4Click(Sender: TObject);
var fname:string;
    ok:boolean;
begin
if savedialog1.execute then
begin
 fname:=savedialog1.FileName;
 xyg_1.SaveToMetafile(fname);
end;
end;

procedure Tmw_show.CheckBox1Click(Sender: TObject);
begin
   dblookupcombobox3CloseUp(self);
end;

procedure Tmw_show.Edit1Exit(Sender: TObject);
begin
     dblookupcombobox3CloseUp(self);
end;

procedure Tmw_show.Button5Click(Sender: TObject);
var   zeile,spalte,i:integer;
 //     wsheet, oleworkbook, xla  ,xlsheet    : Variant;
begin


// jetzt die Version für delphi2010
{
   try
    i:= xla.cells.item[1,1];
   except
    xla := CreateOleObject('Excel.Application');
    OleWorkBook   :=  XlA.WorkBooks.Add(xlWBATWorksheet)
   end;

   i:=1;
   xla.visible:=true;
   xlsheet:=xla;

// Datenübertragung
 query3.first;
 XlSheet.Cells.item[1,1] :='DATE';
 XlSheet.Cells.item[1,2] :='EXP';
  XlSheet.Cells.item[1,3] :='SIM';
 for zeile:=1 to query3.RecordCount do
 begin
  XlSheet.Cells.item[zeile+1,1] := query3.FieldByName('dat').asdatetime;
  XlSheet.Cells.item[zeile+1,2] := query3.FieldByName('exp').asfloat;
  XlSheet.Cells.item[zeile+1,3] := query3.FieldByName('sim').asfloat;
 query3.Next;
 end;
 }
 sql_form.grid2excel(dbgrid1);
end;
end.
