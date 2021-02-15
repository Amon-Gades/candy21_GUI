unit cdyprmedit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
    Grids, DBGrids, ComCtrls, StdCtrls, Mask, DBCtrls, ExtCtrls,    wininet,
  FileCtrl,registry, {xyGraph,}math,strutils{,cndwett},cnd_util,variants, ADODB, DB,
   VclTee.TeeGDIPlus, VCLTee.TeEngine, VCLTee.Series, VCLTee.TeeProcs,   fdc_modul,
  VCLTee.Chart       ,
        FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.Phys.MSAcc, FireDAC.Phys.MSAccDef, FireDAC.VCLUI.Wait,
  FireDAC.Comp.Client





  //, TeEngine, Series, TeeProcs, Chart, VclTee.TeeGDIPlus
  ;

type
  Tcdy_parms = class(TForm)
    PageControl1: TPageControl;
    Button1: TButton;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    DBGrid1: TDBGrid;
    fert_src: TDataSource;
    ops_src: TDataSource;
    crop_src: TDataSource;
    DBGrid2: TDBGrid;
    DBGrid3: TDBGrid;
    DBGrid4: TDBGrid;
    aktn_src: TDataSource;
    TabSheet6: TTabSheet;
    prp_src: TDataSource;
    DBGrid7: TDBGrid;
    ds_profiles: TDataSource;
    ds_prof_data: TDataSource;
    ds_hrz_prm: TDataSource;
    TabSheet5: TTabSheet;
    resobj_src: TDataSource;
    DBGrid5: TDBGrid;
    TabSheet8: TTabSheet;
    wdrive: TDriveComboBox;
    wdir: TDirectoryListBox;
    wdat: TFileListBox;
    DBGrid6: TDBGrid;
    Label1: TLabel;
 //   wet_table: TTable;
    TabSheet9: TTabSheet;
    ListBox1: TListBox;
    Label2: TLabel;
    access_src: TDataSource;
    DBGrid9: TDBGrid;
    TabSheet10: TTabSheet;
    btprmsrc: TDataSource;
    DBGrid10: TDBGrid;
    idx: TRadioGroup;
    TabSheet11: TTabSheet;
    Label7: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    cb_legume: TCheckBox;
    Label39: TLabel;
    bestho: TEdit;
    lai2cov: TEdit;
    hrvi: TEdit;
    rooting: TEdit;
    PageControl3: TPageControl;
    TabSheet12: TTabSheet;
    TabSheet13: TTabSheet;
    TabSheet14: TTabSheet;
    Label41: TLabel;
    nct0: TEdit;
    Label46: TLabel;
    Button6: TButton;
    Label42: TLabel;
    nct1: TEdit;
    Label47: TLabel;
    Label43: TLabel;
    _ncnf: TEdit;
    Label40: TLabel;
    _nckr: TEdit;
    Label44: TLabel;
    Label37: TLabel;
    tkmax: TEdit;
    Label38: TLabel;
    tkmin: TEdit;
    Label45: TLabel;
    Edit11: TEdit;
  //  ncgr: TxyGraph;
    Bevel1: TBevel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label28: TLabel;
    t_0: TEdit;
    t_1: TEdit;
    t_2: TEdit;
    t_3: TEdit;
    Label14: TLabel;
    Label15: TLabel;
    photsr: TEdit;
    excoef: TEdit;
    Label16: TLabel;
    areawt: TEdit;
    Label35: TLabel;
    Label36: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    _bt1: TEdit;
    _bt2: TEdit;
    ptu_harv: TEdit;
    ptu_root: TEdit;
    Bevel2: TBevel;
    Image2: TImage;
    Label48: TLabel;
    Label49: TLabel;
    Label50: TLabel;
    Panel2: TPanel;
    Label51: TLabel;
    ComboBox1: TComboBox;
    Label52: TLabel;
    Label53: TLabel;
    DateTimePicker1: TDateTimePicker;
  //  ptugr: TxyGraph;
    Button7: TButton;
    Edit25: TEdit;
    siwaprmsrc: TDataSource;
    siwacrop: TDBLookupComboBox;
    TabSheet15: TTabSheet;
    DBGrid11: TDBGrid;
    Button8: TButton;
    Button9: TButton;
    TabSheet16: TTabSheet;
    Label56: TLabel;
    Label57: TLabel;
    Label58: TLabel;
    Label59: TLabel;
    c_ewr: TEdit;
    f_ewr: TEdit;
    _ewr_id: TEdit;
    Label60: TLabel;
    _grd_id: TEdit;
    Label61: TLabel;
    Label62: TLabel;
    c_cep: TEdit;
    zeta_b: TEdit;
    Label63: TLabel;
    Label64: TLabel;
    Button11: TButton;
    Button12: TButton;
    GroupBox1: TGroupBox;
    Button13: TButton;
    om_selection: TDBLookupComboBox;
    TabSheet17: TTabSheet;
    sbasoilsrc: TDataSource;
    DBGrid12: TDBGrid;
    Label55: TLabel;
    sbacropsrc: TDataSource;
    DBGrid13: TDBGrid;
    DBGrid14: TDBGrid;
    sbamanuresrc: TDataSource;
    DBGrid15: TDBGrid;
    sbaomdefsrc: TDataSource;
    tgprm: TTabSheet;
    DBGrid16: TDBGrid;
    tpgp_src: TDataSource;
    ptug: TChart;
    Series1: TLineSeries;
    Series2: TLineSeries;
    ngr: TChart;
    LineSeries1: TLineSeries;
    LineSeries2: TLineSeries;
    Series3: TLineSeries;
    tab_cdyaparm: TTabSheet;
    DBGrid17: TDBGrid;
    aparmsrc: TDataSource;
    T_grassland: TTabSheet;
    livesrc: TDataSource;
    grasslsrc: TDataSource;
    DBGrid18: TDBGrid;
    DBGrid19: TDBGrid;
    Label67: TLabel;
    Label68: TLabel;
    GrassMind: TTabSheet;
    Panel3: TPanel;
    Button2: TButton;
    Panel4: TPanel;
    DBNavigator2: TDBNavigator;
    grm_crop_LCB: TDBLookupComboBox;
    B_new_crop: TButton;
    Edit_3: TEdit;
    grm_popl_src: TDataSource;
    grm_crop_src: TDataSource;
    cb_litter_green: TDBLookupComboBox;
    cb_litter_straw: TDBLookupComboBox;
    cb_litter_root: TDBLookupComboBox;
    DBGrid20: TDBGrid;
    Label78: TLabel;
    Label83: TLabel;
    Label84: TLabel;
    ds_green_litter: TDataSource;
    ds_straw_litter: TDataSource;
    ds_root_litter: TDataSource;
    Button5: TButton;
    Button14: TButton;
    DBGrid21: TDBGrid;
    clas_src: TDataSource;
    DBGrid22: TDBGrid;
    c2p_src: TDataSource;
    DBNavigator3: TDBNavigator;
    RadioGroup1: TRadioGroup;
    TabSheet7: TTabSheet;
    Panel1: TPanel;
    Label20: TLabel;
    Label22: TLabel;
    Label24: TLabel;
    Label26: TLabel;
    Label29: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label6: TLabel;
    Label54: TLabel;
    Label65: TLabel;
    Label66: TLabel;
    Label23: TLabel;
    Label25: TLabel;
    Label27: TLabel;
    Label69: TLabel;
    Label70: TLabel;
    Label71: TLabel;
    Label72: TLabel;
    Label73: TLabel;
    Label74: TLabel;
    Label75: TLabel;
    Label76: TLabel;
    Label77: TLabel;
    Label82: TLabel;
    Label81: TLabel;
    DBEdit2: TDBEdit;
    DBEdit4: TDBEdit;
    DBEdit6: TDBEdit;
    DBEdit8: TDBEdit;
    DBEdit10: TDBEdit;
    DBEdit11: TDBEdit;
    DBEdit13: TDBEdit;
    DBEdit15: TDBEdit;
    DBEdit16: TDBEdit;
    Button3: TButton;
    DBCheckBox1: TDBCheckBox;
    DBEdit1: TDBEdit;
    DBEdit17: TDBEdit;
    IC_group: TGroupBox;
    Label8: TLabel;
    IC_K: TRadioButton;
    IC_R: TRadioButton;
    Edit2: TEdit;
    IC_S: TRadioButton;
    Button10: TButton;
    DBEdit18: TDBEdit;
    DBEdit19: TDBEdit;
    topsoil_dd: TComboBox;
    tb_rootres: TTrackBar;
    GroupBox2: TGroupBox;
    Label30: TLabel;
    Label5: TLabel;
    Label21: TLabel;
    Label79: TLabel;
    Label80: TLabel;
    DBEdit12: TDBEdit;
    DBEdit20: TDBEdit;
    DBEdit3: TDBEdit;
    DBGrid8: TDBGrid;
    DBNavigator1: TDBNavigator;
    prf_names: TDBLookupComboBox;
    Edit1: TEdit;
    Button4: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure TabSheet_7Show(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure wdatDblClick(Sender: TObject);
   procedure ListBox1DblClick(Sender: TObject);
    procedure TabSheet9Show(Sender: TObject);

    procedure cndmwml_AfterOpen(DataSet: TDataSet);
    procedure idxClick(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure hrz_prm_AfterInsert(DataSet: TDataSet);
    procedure ds_prof_dataUpdateData(Sender: TObject);
    procedure ds_hrz_prmDataChange(Sender: TObject; Field: TField);
    procedure IC_KClick(Sender: TObject);
    procedure IC_RClick(Sender: TObject);
    procedure Edit2Exit(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure ComboBox1CloseUp(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure TabSheet11Show(Sender: TObject);
    procedure siwacropCloseUp(Sender: TObject);
    procedure TabSheet13Show(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure DBEdit11Enter(Sender: TObject);
    procedure ds_prof_dataDataChange(Sender: TObject; Field: TField);
    procedure IC_SClick(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    procedure Button13Click(Sender: TObject);
    procedure Button12Click(Sender: TObject);
    procedure hrz_prm_AfterOpen(DataSet: TDataSet);
    procedure sbaomdefsrcDataChange(Sender: TObject; Field: TField);
    procedure sbacropsrcDataChange(Sender: TObject; Field: TField);
    procedure FormShow(Sender: TObject);
    procedure tgprmEnter(Sender: TObject);
    procedure prf_namesClick(Sender: TObject);
    procedure prf_namesCloseUp(Sender: TObject);
    procedure DBGrid8CellClick(Column: TColumn);
    procedure PageControl1Enter(Sender: TObject);
    procedure T_grasslandEnter(Sender: TObject);
    procedure T_grasslandShow(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure GrassMindShow(Sender: TObject);
    procedure grm_crop_LCBCloseUp(Sender: TObject);
    procedure grm_crop_srcUpdateData(Sender: TObject);
    procedure DBNavigator2Click(Sender: TObject; Button: TNavigateBtn);
    procedure Edit_3Change(Sender: TObject);
    procedure B_new_cropClick(Sender: TObject);
    procedure topsoil_ddCloseUp(Sender: TObject);
    procedure tb_rootresChange(Sender: TObject);
    procedure DBEdit19Change(Sender: TObject);
    procedure tb_rootresExit(Sender: TObject);
    procedure topsoil_ddExit(Sender: TObject);

    procedure topsoil_ddChange(Sender: TObject);
    procedure topsoil_ddClick(Sender: TObject);
    procedure DBNavigator1Click(Sender: TObject; Button: TNavigateBtn);
    procedure DBEdit18Change(Sender: TObject);
    procedure Button14Click(Sender: TObject);
    procedure TabSheet2Show(Sender: TObject);
    procedure RadioGroup1Click(Sender: TObject);  private
    { Private declarations }
    const
     got_hints:boolean=false;

 //   procedure get_hints;

  public
    { Public declarations }
//procedure export_systabs (d_tab_name:string;s_tab:Ttable);
   hrz_prm_edit:boolean;
       procedure analyse_prm;
       procedure save_prm(new_rec:boolean; new_crop_name:string);
  end;

var
  cdy_parms: Tcdy_parms;

implementation

uses candy_uif,  range_sel_U, get_a_name, GrassParameters, data_interface;



{$R *.DFM}

procedure Tcdy_parms.save_prm(new_rec:boolean; new_crop_name:string);
var siwatab:tfdtable;
    i,ix:integer;
begin
 siwatab:=tfdtable.create(nil);
 siwatab.connection:=cdy_uif.dbc;
 siwatab.TableName:='cdysiwap';
 siwatab.Open;
 fdc.crops.open;
 fdc.crops.First;
 ix:=fdc.crops.fieldbyname('ITEM_IX').asinteger;

 while not fdc.crops.Eof do
 begin
  if fdc.crops.fieldbyname('ITEM_IX').asinteger>ix then ix:=fdc.crops.fieldbyname('ITEM_IX').asinteger;
  fdc.crops.Next;
 end;
 if new_rec then
 begin
   siwatab.Append;
   siwatab.FieldValues['ITEM_IX']:=ix+1;
   siwatab.FieldValues['NAME']:=new_crop_name;
   siwatab.Post;
   fdc.crops.Append;
   fdc.crops.FieldValues['ITEM_IX']:=ix+1;
   fdc.crops.FieldValues['NAME']:=new_crop_name;
   fdc.crops.FieldValues['MODELL']:='SIWAMOD';
   fdc.crops.FieldValues['N_GEHALT']:= strtofloat(nct1.Text);
   fdc.crops.post;
 end
 else
 begin
   siwatab.Locate('ITEM_IX', fdc.siwaprm.fieldbyname('s.ITEM_IX').value,[]);
   fdc.crops.Locate('ITEM_IX', fdc.siwaprm.fieldbyname('s.ITEM_IX').value,[]);
 end;
 siwatab.edit;
 with siwatab do
 begin
  fieldvalues['LEGUM']:=cb_legume.checked;
  fieldvalues['RIPING']:=strtofloat(ptu_harv.Text);
  fieldvalues['T_0']:=strtofloat(t_0.Text);
  fieldvalues['T_1']:=strtofloat(t_1.Text);
  fieldvalues['T_2']:=strtofloat(t_2.Text);
  fieldvalues['T_3']:=strtofloat(t_3.Text);
  fieldvalues['NCT0']:=strtofloat(nct0.Text);
  fieldvalues['NCT1']:=strtofloat(nct1.Text);
  fieldvalues['NCNF']:=strtofloat(_ncnf.Text);
  fieldvalues['NCKR']:=strtofloat(_nckr.Text)/1000;
  fieldvalues['BTEMP1']:=strtofloat(_bt1.Text);
  fieldvalues['BTEMP2']:=strtofloat(_bt2.Text);
  fieldvalues['TKMAX']:=strtofloat(tkmax.Text);
  fieldvalues['TKMIN']:=strtofloat(tkmin.Text);
  fieldvalues['HRVI']:=strtofloat(hrvi.Text);
  fieldvalues['ROOTING']:=strtofloat(ptu_root.Text);
  fieldvalues['PHOTSR']:=strtofloat(photsr.Text);
  fieldvalues['AREAWT']:=strtofloat(areawt.Text);
  fieldvalues['EXCOEF']:=strtofloat(excoef.Text);
  fieldvalues['BHMAX']:=strtofloat(bestho.Text);
  fieldvalues['WTMAX']:=strtofloat(rooting.Text);
  fieldvalues['LAIatCD1']:=strtofloat(lai2cov.text);
 end;
 siwatab.Post;

 fdc.crops.edit;
 with fdc.crops do
 begin
  fieldvalues['BHMAX']:=strtofloat(bestho.Text);
  fieldvalues['WTMAX']:=strtofloat(rooting.Text);
  fieldvalues['CEWR']:=strtofloat(c_ewr.Text);
  fieldvalues['FEWR']:=strtofloat(f_ewr.Text);
  fieldvalues['CZEP']:=strtofloat(c_cep.Text);
  fieldvalues['ZETB']:=strtofloat(zeta_b.Text);
  fieldvalues['GRD_IX']:=strtofloat(_grd_id.Text);
  fieldvalues['EWR_IX']:=strtofloat(_ewr_id.Text);

 end;
 fdc.crops.post;

 i:=siwacrop.ListFieldIndex;
 fdc.siwaprm.Close;
 fdc.siwaprm.Open;
 siwacrop.ListFieldIndex:=i;
 siwatab.Free;
end;

procedure Tcdy_parms.analyse_prm;
var fname:string;
    sdat:tdate;
    bt1,bt2,ptu_r,ptu_h ,lt  , geo, daylgt,
    ptu,sumptu,bastemp,devstg:real;
    d,yr:integer;
    h_str:string;
 //   qltem:tquery;
begin
(*
geo:=strtofloat(edit25.Text);
new(awo,init(1,1,1,geo));
 //filename bauen
 h_str:=rightstr(datetostr(datetimepicker1.Date),4);
 yr:=strtoint(h_str);
  fname:= cdy_uif.cdywpath.text+'\wet'+combobox1.Items[combobox1.itemindex]+h_str+'.dbf';
 // Wetterdatei öffnen (incl. Folgejahr)
   if not fileexists(fname) then
   begin
     h_str:= copy(h_str,3,2);
     fname:= cdy_uif.cdywpath.text+'\wet'+combobox1.Items[combobox1.itemindex]+h_str+'.dbf';
   end;
   if not fileexists(fname) then
   begin
     //kein wetter vorhanden
     exit;
   end;
 // qltem:=tquery.Create(nil);
 // qltem.SQL.Add('select datum,ltem from '+extractfilename(fname));
  h_str:=inttostr(yr+1);
    fname:= cdy_uif.cdywpath.text+'\wet'+combobox1.Items[combobox1.itemindex]+h_str+'.dbf';
   if not fileexists(fname) then
   begin
     h_str:= copy(h_str,3,2);
     fname:= cdy_uif.cdywpath.text+'\wet'+combobox1.Items[combobox1.itemindex]+h_str+'.dbf';
   end;
   if fileexists(fname) then
   begin
     // qltem.SQL.Add('  union select datum,ltem from '+extractfilename(fname));
   end;
   //qltem.DatabaseName:=cdy_uif.cdywpath.text;
   sumptu:=0;
   qltem.Open;

   qltem.First;
   bt1:=strtofloat(_bt1.Text);
   bt2:=strtofloat(_bt2.Text);
   ptu_r:=strtofloat(ptu_root.Text);
   ptu_h:=strtofloat(ptu_harv.Text);
// Temperatursumme bilden
  bastemp:=bt1;
  ptugr.ClearAll;
  ptugr.Plotting:=false;
  ptugr[1].DrawPoints:=false;
  ptugr[2].DrawPoints:=false;
  ptugr[2].WhichYAxis:=ptugr.YAxis_Second;
   while qltem.FieldByName('DATUM').asdatetime <datetimepicker1.Date do qltem.Next;
   repeat
   lt:=qltem.fieldbyname('LTEM').asfloat;
   daylgt:=awo^.period( daynr(qltem.FieldByName('DATUM').asstring),365);

   ptu:=(lt-bastemp)*daylgt;
   ptu:=max(0,ptu);
   sumptu:=sumptu+ptu;
   devstg:=10*min(1,sumptu/ptu_h);
   if devstg>=0.5 then bastemp:=bt2;

      ptugr[1 ][qltem.FieldByName('DATUM').asdatetime]:=sumptu;
      ptugr[2][qltem.FieldByName('DATUM').asdatetime]:=devstg;
       qltem.Next;
   until  (sumptu>=ptu_h) or qltem.eof ;
   //   qltem.free;
     ptugr.Plotting:=true;

     *)
end;

 {
procedure Tcdy_parms.export_systabs (d_tab_name:string;s_tab:Ttable);
var syspath:string;
    i:integer;
begin

end;
       }
procedure Tcdy_parms.Button1Click(Sender: TObject);
begin
 cdy_parms.close;
end;

procedure Tcdy_parms.Button2Click(Sender: TObject);
var acrp:string;
begin
  form_2.selname:='*';
if fdc.grm_crop.Active then
begin
  form_2.selname:=  fdc.grm_crop.FieldByName('art_id').AsString;
end;
form_2.show
end;



procedure Tcdy_parms.FormCreate(Sender: TObject);
var cdy_ini:Tregistry;
    ic:longint;
    dc: tcomponent;
    ccln,cnm: string;
begin

// cdy_parms.close;

 cdy_ini:=Tregistry.Create;
 try
  cdy_ini.RootKey := HKEY_CURRENT_USER;
  if cdy_ini.OpenKey('\Software\candy', False)
  then      wdir.directory:=cdy_ini.readString('wpath');
   finally;inherited;
 end;
end;
(****
procedure Tcdy_parms.get_hints;
var cdy_ini:Tregistry;
    ic:longint;
    dc: tcomponent;
    ccln,cnm: string;
begin
  hqry.Close;
  hqry.sql.Clear;
  hqry.SQL.Add(' select * from cdy_explain');
  try
  hqry.Open;
  except
     hqry.Close;
  hqry.sql.Clear;
  hqry.SQL.Add(' create table cdy_explain (CDYForm char(20), cName char(20), cType char(20), cHint char(125))');
  hqry.ExecSQL;
  end;
  hqry.Close;
    hqry.sql.Clear;
 explanations.Open;
 for ic:=0 to  cdy_parms.ComponentCount-1 do
 begin
 try
   dc:=cdy_parms.Components[ic];
   ccln:=dc.classname;
   if pos(ccln ,'TLabel TEdit TDBGrid')>0 then
   begin
     cnm:=dc.name;
     if explanations.Locate('CDYFORM;CType;CName',Vararrayof(['cdy_parms',ccln,cnm]),[])
     then
     begin
     tlabel(dc).hint:= explanations.FieldByName('CHint').AsString;
     tlabel(dc).ShowHint:=true;
     end
     else
     begin
      explanations.AppendRecord(['cdy_parms',cnm,ccln,cnm]);
     end;
   end;
 except; end;

 end;
end;
     ***)

procedure Tcdy_parms.TabSheet_7Show(Sender: TObject);
begin

   if not fdc.profile_prm.Active then
   begin
       fdc.profile_prm.open;
       fdc.profile_prm.first;
   end;
   application.ProcessMessages;
   prf_names.KeyValue:=fdc.profile_prm.fieldbyname('PROFIL').asstring;
   prf_namesCloseUp(nil);
   fdc.prof_data.open;
   fdc.hrz_prm.open;
   if fdc.hrz_prm.FindField('STONE_CONT')<>nil then
   begin
      dbedit18.DataSource:=ds_hrz_prm;
   end
   else  dbedit18.DataSource:=nil;
   if fdc.hrz_prm.FindField('ARD')<>nil then
   begin
      dbedit20.DataSource:=ds_hrz_prm;
      dbedit20.Color:=clwindow;
   end
   else
   begin
   dbedit20.DataSource:=nil;
   dbedit20.Enabled:=false;
   dbedit20.color:=clinactiveborder;
   end;
   fdc.hrz_prm.open;
   dbgrid8.columns[1].PickList.clear;
   fdc.hrz_liste.open;
   fdc.hrz_liste.First;
   while not fdc.hrz_liste.eof do
   begin
     dbgrid8.columns[1].PickList.add(fdc.hrz_liste.fieldbyname('NAME').asstring);
     fdc.hrz_liste.next;
   end;
   fdc.hrz_liste.close;
  // tabsheet7.visible:=true;
   pagecontrol1.ActivePage:=tabsheet7;
   application.ProcessMessages;
end;

procedure Tcdy_parms.FormActivate(Sender: TObject);
var i:integer; a_page:ttabsheet;
begin
 a_page:=pagecontrol1.ActivePage;
 if not cdy_UIF.grassmind_dll then  grassmind.TabVisible:=false;


 if not fdc.profile_prm.Active then
begin
   fdc.profile_prm.open;
   fdc.profile_prm.first;
end;
tabsheet_7show(nil);
application.ProcessMessages;


 fdc.cndmwml.open;
 fdc.propqry.Open;
 fdc.clas_qry.open;
 fdc.c2p_qry.Open;
 fdc.resobj.open;
 fdc.aktion.open;
 fdc.fert.open;
 fdc.crops.open;
 fdc.opspa.open;
 fdc.btprm.open;
 //sbasoil.Databasename:=btprm.databasename;
 label55.show;
 try
 begin fdc.sbasoil.open;
 label55.Hide;

 //sbamanure.Databasename:=btprm.databasename;
 fdc.sbamanure.open;
// sbacrop.Databasename:=btprm.databasename;
 fdc.sbacrop.Open;
// sbaomdef.Databasename:=btprm.databasename;
 fdc.sbaomdef.open;
 end;
 fdc.sbamanure.Filter:='sba_crop_id='+fdc.sbacrop.fieldbyname('sba_crop_id').asstring+' and sba_om_id='+fdc.sbaomdef.fieldbyname('sba_om_id').asstring;
 fdc.sbamanure.Filtered:=true;
 except
 begin
  label55.caption:='no sba data found'
 end;
 end;

 {
for i:=1 to cdy_parms.componentcount do
begin
  if (cdy_parms.Components[i].ClassName='TTable')
  and  (cdy_parms.Components[i].Name<> 'htable' )
  and  (cdy_parms.Components[i].Name<>'wet_table')
  and  (cdy_parms.Components[i].Name<>'access_table')
  and  (cdy_parms.Components[i].Name<>'prof_data')
  and  (cdy_parms.Components[i].Name<>'hrz_prm')
   then
    TTable(cdy_parms.Components[i]).open;
end;
}
pagecontrol1.ActivePage:=a_page;
//tabsheet7;  // hart verdrahteter Bodenzugriff
tabsheet11.TabVisible:=false;
tgprm.TabVisible:=false;


dbgrid8.Visible:=true;
if not got_hints then cdy_uif.get_hints('cdy_parms',cdy_parms);
got_hints:=true;

end;

procedure Tcdy_parms.Button3Click(Sender: TObject);
begin
 fdc.hrz_prm.Edit;
 {
 dbedit3.Field.AsFloat:=-0.15;  //k_TRD
 dbedit5.Field.AsFloat:=-0.045;  //k_TSD
 dbedit7.Field.AsFloat:=5;  //k_FKAP
 dbedit9.Field.AsFloat:=1.5;  //k_PWP
 }
 dbedit16.Field.AsFloat:=2;  //k_NIN
 dbedit15.Field.AsFloat:=5;  //NIN0
 dbedit4.Field.AsFloat:=2.55;  //TSD
 dbedit13.Field.AsFloat:=0.16;  //HKAP
 fdc.hrz_prm.post;
end;

procedure Tcdy_parms.Button4Click(Sender: TObject);
begin
  fdc.add_prfl.ParamByName('name').Value:=edit1.text;
//  add_prfl.ParamByName('name').asstring:=edit1.text;
  fdc.add_prfl.execsql;
  fdc.profile_prm.close;
  fdc.profile_prm.open;
  button4.Enabled:=false;
  prf_names.KeyValue:=edit1.text;
  prf_namesCloseUp(nil);
end;

procedure Tcdy_parms.wdatDblClick(Sender: TObject);
begin
{
    wet_table.close;
    wet_table.databasename:=wdir.Directory;
    wet_table.tablename:=wdat.FileName;
    label1.caption:=extractfilename(wdat.filename);
    wet_table.open;
    }
end;


procedure Tcdy_parms.ListBox1DblClick(Sender: TObject);
begin
    label2.caption:=listbox1.Items[listbox1.itemindex] ;
    fdc.access_TABLE.close;
    fdc.access_table.TableName:=label2.caption;
    fdc.access_table.open;
end;

procedure Tcdy_parms.PageControl1Enter(Sender: TObject);
begin
fdc.cdy_aprm.Open;
end;

procedure Tcdy_parms.prf_namesClick(Sender: TObject);
var i:integer;
begin
{
i:=1;;
prof_data.IndexFieldNames:='';
prof_data.MasterSource:=nil;
prof_data.Close;
}
end;

procedure Tcdy_parms.prf_namesCloseUp(Sender: TObject);
begin
dbgrid8.columns[0].PickList.clear;

dbgrid8.columns[0].PickList.add(fdc.profile_prm.fieldbyname('profil').asstring);

fdc.prof_data.Close;
fdc.prof_data.Filter:='profil='+''''+fdc.profile_prm.fieldbyname('profil').asstring+'''';
//fdc.prof_data.Open;
fdc.prof_data.Filtered:=true;
//? fdc.prof_data.IndexFieldNames:='horizont asc';
fdc.prof_data.Open;

end;

procedure Tcdy_parms.RadioGroup1Click(Sender: TObject);
begin
if radiogroup1.ItemIndex=0 then
begin
  // alle
  fdc.opspa.Filtered:=false;
end;
 if radiogroup1.ItemIndex=1 then
begin
  // oram
   fdc.opspa.Filtered:=false;
   fdc.opspa.Filter:= 'OD=TRUE';
   fdc.opspa.Filtered:=true;
end;

if radiogroup1.ItemIndex=2 then
begin
  // crop
    fdc.opspa.Filtered:=false;
    fdc.opspa.Filter:= 'OD=FALSE';
    fdc.opspa.Filtered:=true;
end;
end;

procedure Tcdy_parms.TabSheet9Show(Sender: TObject);
begin
  listbox1.Items.clear;
  cdy_uif.dbc.getTableNames('','','',listbox1.Items);
  //(  cdy_uif.cdyparm.DatabaseName ,'*', false,false,listbox1.Items);
  listbox1.Refresh;
end;



procedure Tcdy_parms.tb_rootresChange(Sender: TObject);
 var rrr: real;
begin
rrr:=round(tb_rootres.Position) /100;
dbedit19.text:=  floattostr(rrr);
dbedit19.Update;
end;

procedure Tcdy_parms.tb_rootresExit(Sender: TObject);
 var rrr: real;
begin
rrr:=round(tb_rootres.Position) /100;
fdc.hrz_prm.Edit;
fdc.hrz_prm.FieldByName('relrootres').Value:=rrr;
fdc.hrz_prm.Post;
end;

procedure Tcdy_parms.tgprmEnter(Sender: TObject);
begin
fdc.tgparms.Open;
end;

procedure Tcdy_parms.T_grasslandEnter(Sender: TObject);
begin
fdc.lives.open;
fdc.grassl.open;
end;

procedure Tcdy_parms.T_grasslandShow(Sender: TObject);
begin
fdc.lives.open;
fdc.grassl.open;

end;

procedure Tcdy_parms.cndmwml_AfterOpen(DataSet: TDataSet);
var i:integer;
begin
{
 idx.Items.Clear;
 cndmwml.IndexDefs.Update;
 for i:=0 to cndmwml.IndexDefs.Count-1 do
  idx.Items.add(cndmwml.IndexDefs.items[i].name);
  idx.ItemIndex:=0;
 // es brauch eine andere Lösung
//  if cndmwml.IndexDefs.Count>0 then cndmwml.IndexName:=idx.Items[0];
}
end;

procedure Tcdy_parms.idxClick(Sender: TObject);
begin
  fdc.propqry.Close;
  fdc.propqry.SQL.Clear;
  fdc.propqry.SQL.Add(' select * from cdyprop order by '+idx.Items[ idx.ItemIndex]);
  fdc.propqry.Open;
 // cndmwml.IndexName:=idx.Items[ idx.ItemIndex];
end;

procedure Tcdy_parms.Edit1Change(Sender: TObject);
begin
 button4.Enabled:=true;
end;

procedure Tcdy_parms.hrz_prm_AfterInsert(DataSet: TDataSet);
begin
{   hrz_liste.open;
   hrz_liste.First;
   while not hrz_liste.eof do
   begin
     dbgrid8.columns[1].PickList.add(hrz_liste.fieldbyname('NAME').asstring);
     hrz_liste.next;
   end;
   hrz_liste.close;
   }
end;

procedure Tcdy_parms.ds_prof_dataUpdateData(Sender: TObject);
begin

   dbgrid8.columns[1].PickList.clear;
   fdc.hrz_liste.open;
   fdc.hrz_liste.First;
   while not fdc.hrz_liste.eof do
   begin
     dbgrid8.columns[1].PickList.add(fdc.hrz_liste.fieldbyname('name').asstring);
     fdc.hrz_liste.next;
   end;
   fdc.hrz_liste.close;
end;

procedure Tcdy_parms.ds_hrz_prmDataChange(Sender: TObject; Field: TField);
begin

 if fdc.hrz_prm.FieldByName('hydromorph').isnull then
 begin
  dbcheckbox1.Checked:=false;
 // hrz_prm.FieldByName('hydromorph').value:=false;

 end;
 if not  hrz_prm_edit then
 begin
  topsoil_dd.ItemIndex:= fdc.hrz_prm.FindField('KRUME').asinteger;
 end;
 hrz_prm_edit:=false;
if (fdc.hrz_prm.FindField('KRUME').asinteger=1) and (fdc.hrz_prm.FindField('CIM')<>nil) then
begin
if fdc.hrz_prm.State= dsedit then exit;
 ic_group.Show ;
 if uppercase(fdc.hrz_prm.fieldbyname('CIM').AsString)='KO' then ic_k.Checked:=true;
 if uppercase(fdc.hrz_prm.fieldbyname('CIM').AsString)='RU' then ic_r.Checked:=true;
 if uppercase(fdc.hrz_prm.fieldbyname('CIM').AsString)='PS' then ic_s.Checked:=true;
 if fdc.hrz_prm.FieldByName('hydromorph').isnull then   fdc.hrz_prm.FieldByName('hydromorph').value:=false;
 
 if fdc.hrz_prm.FieldByName('CIM').IsNull then
 begin
   edit2.Text:='0';
   ic_s.Checked:=true;
 end;
 edit2.Text:=fdc.hrz_prm.fieldbyname('CIP').AsString;
 end
else ic_group.hide
end;

procedure Tcdy_parms.IC_KClick(Sender: TObject);
begin
    // Einstellungen speichern
    fdc.hrz_prm.edit;
    fdc.hrz_prm.FieldByName('CIM').AsString:='KO';
    fdc.hrz_prm.Post;
end;

procedure Tcdy_parms.IC_RClick(Sender: TObject);
begin
    fdc.hrz_prm.edit;
    fdc.hrz_prm.FieldByName('CIM').AsString:='RU';
    fdc.hrz_prm.Post;
end;

procedure Tcdy_parms.Edit2Exit(Sender: TObject);
begin
     fdc.hrz_prm.edit;
    fdc.hrz_prm.FieldByName('CIP').Asfloat:=strtofloat(edit2.text);
    fdc.hrz_prm.Post;
end;

procedure Tcdy_parms.Edit_3Change(Sender: TObject);
begin
if length(trim(edit_3.Text))>2 then
begin
b_new_crop.Enabled:=true;
grm_crop_lcb.Enabled:=false;
end;
end;

procedure Tcdy_parms.Button5Click(Sender: TObject);
begin
webdata.crop_mode:=true;
webdata.show;
fdc.crops.Close;
fdc.crops.Open;
dbgrid1.DataSource.DataSet.Refresh;
end;

procedure Tcdy_parms.Button6Click(Sender: TObject);
var i:integer;
    x,y1,y2,y3,nc0,nc1,ncnf,nckr:real;
begin
ngr.Series[0].Clear;
ngr.Series[1].Clear;
ngr.Series[2].Clear;
  nc0:=strtofloat(nct0.Text)/100;
  nc1:=strtofloat( nct1.Text)/100;
 ncnf:=strtofloat( _ncnf.Text);
 nckr:=strtofloat( _nckr.Text)/1000;
{
  ncgr.plotting:=false;
  ncgr[1].DrawPoints:=false;
  ncgr[2].DrawPoints:=false;
  ncgr[3].DrawPoints:=true;
  ncgr[3].WhichYAxis:=ncgr.YAxis_Second;
 }
  for i:= 0 to 100 do
  begin
   x:=i/10;
 y1:=nc1+(nc0-nc1)/exp(ncnf*x);
    // ncgr[1][x]:=100*y1;
     ngr.Series[0].AddXY(x,100*y1);
   y2:=strtofloat(edit11.text)*y1;
 //  ncgr[2][x]:=100*y2  ;
     ngr.Series[1].AddXY(x,100*y2);
   y3:= max(0, (y2-nckr)/(y1*0.75-nckr));
//   ncgr[3][x]:=y3
     ngr.Series[2].AddXY(x,y3);
  end;
//  ncgr.plotting:=true;
end;

procedure Tcdy_parms.Button7Click(Sender: TObject);
begin
 {range_select.find_wetter_stat;
combobox1.Items:=range_select.fda_wett.Items;}
end;

procedure Tcdy_parms.ComboBox1CloseUp(Sender: TObject);
begin
 analyse_prm;
end;



procedure Tcdy_parms.topsoil_ddClick(Sender: TObject);
begin
   hrz_prm_edit:=true;
end;

procedure Tcdy_parms.topsoil_ddCloseUp(Sender: TObject);
begin
  {
hrz_prm.Edit;
hrz_prm.FieldByName('krume').Value:=topsoil_dd.ItemIndex;
hrz_prm.Post;
   }
end;

procedure Tcdy_parms.topsoil_ddChange(Sender: TObject);
begin
{
 hrz_prm.Edit;
hrz_prm.FieldByName('krume').Value:=topsoil_dd.ItemIndex;
hrz_prm.Post;
}

if topsoil_dd.ItemIndex=1 then
begin
  ic_group.Visible:=true;
end
else  ic_group.Visible:=false;
application.ProcessMessages;
end;

procedure Tcdy_parms.topsoil_ddExit(Sender: TObject);
begin

fdc.hrz_prm.Edit;
fdc.hrz_prm.FieldByName('krume').Value:=topsoil_dd.ItemIndex;
fdc.hrz_prm.Post;
 hrz_prm_edit:=false;
end;

procedure Tcdy_parms.Button8Click(Sender: TObject);
begin
  save_prm(false, ''); // auf dem gleichen record speichern
end;

procedure Tcdy_parms.TabSheet11Show(Sender: TObject);
begin
  fdc.siwaprm.open;
  siwacrop.ListField:='c.NAME';
  siwacrop.KeyField:='s.ITEM_IX';
  siwacrop.KeyValue:=fdc.siwaprm.fieldbyname('s.ITEM_IX').asvariant;
  siwacropCloseUp(nil);
end;

procedure Tcdy_parms.siwacropCloseUp(Sender: TObject);
begin
// Daten in Editor übernehmen
   //ptugr.ClearAll;
   cb_legume.Checked:=fdc.siwaprm.fieldbyname('LEGUM').asboolean;
   rooting.Text:= fdc.siwaprm.fieldbyname('s.WTMAX').asstring;
   bestho.Text:= fdc.siwaprm.fieldbyname('s.BHMAX').asstring;
   hrvi.Text:= fdc.siwaprm.fieldbyname('hrvi').asstring;
   _bt1.Text:= fdc.siwaprm.fieldbyname('BTEMP1').asstring;
   _bt2.Text:= fdc.siwaprm.fieldbyname('BTEMP2').asstring;
  // ptu_root.Text:= fdc.siwaprm.fieldbyname('ROOTING').asstring;
  // ptu_harv.Text:= fdc.siwaprm.fieldbyname('RIPING').asstring;
   photsr.Text:= fdc.siwaprm.fieldbyname('PHOTSR').asstring;
  excoef.Text:= fdc.siwaprm.fieldbyname('EXCOEF').asstring;
  areawt.Text:= fdc.siwaprm.fieldbyname('AREAWT').asstring;
  t_0.Text:= fdc.siwaprm.fieldbyname('T_0').asstring;
  t_1.Text:= fdc.siwaprm.fieldbyname('T_1').asstring;
  t_2.Text:= fdc.siwaprm.fieldbyname('T_2').asstring;
  t_3.Text:= fdc.siwaprm.fieldbyname('T_3').asstring;
  nct0.Text:= fdc.siwaprm.fieldbyname('NCT0').asstring;
  nct1.Text:= fdc.siwaprm.fieldbyname('NCT1').asstring;
  _ncnf.Text:= fdc.siwaprm.fieldbyname('NCNF').asstring;
  _ncKR.Text:= floattostr(fdc.siwaprm.fieldbyname('NCKR').asfloat*1000);
  tkmax.Text:= fdc.siwaprm.fieldbyname('TKMAX').asstring;
  tkmin.Text:= fdc.siwaprm.fieldbyname('TKMIN').asstring;
  lai2cov.text:=fdc.siwaprm.fieldbyname('LAIatCD1').asstring;
  fdc.crops.Open;
  fdc.crops.Locate('ITEM_IX',fdc.siwaprm.FieldValues['s.ITEM_IX'],[]) ;
  _ewr_id.Text:=fdc.crops.fieldbyname('EWR_IX').asstring;
  _grd_id.Text:=fdc.crops.fieldbyname('GRD_IX').asstring;
  c_ewr.Text:=fdc.crops.fieldbyname('CEWR').asstring;
  f_ewr.Text:=fdc.crops.fieldbyname('FEWR').asstring;
  c_cep.Text:=fdc.crops.fieldbyname('CZEP').asstring;
  zeta_b.Text:=fdc.crops.fieldbyname('ZETB').asstring;
  end;

procedure Tcdy_parms.TabSheet13Show(Sender: TObject);
begin
range_select.find_wetter_stat;
combobox1.Items:=range_select.fda_wett.Items;
combobox1.ItemIndex:=1;
end;

procedure Tcdy_parms.TabSheet2Show(Sender: TObject);
var cnt:boolean;
begin
   cnt:=InternetCheckConnection(pwideChar('https://www.ufz.de/index.php?de=42459'),1,0);
   if not cnt then
   begin
    button5.Hide;
   end;

end;

procedure Tcdy_parms.Button9Click(Sender: TObject);
begin
    with frm_get_a_name do
    begin
     caption:='SAVE NEW CROP';
     edit1.Text:='?';
     label1.Caption:='enter a new (unique) crop name :' ;
     button1.caption:='ESC';
     button2.Caption:='SAVE';
     showmodal;
     if last_button=2 then
     begin
      // einstellungen speichern
      save_prm(true, frm_get_a_name.Edit1.text); // neuer satz=true; name von edit
     end;
    end;
end;

procedure Tcdy_parms.B_new_cropClick(Sender: TObject);
var new_item:string;
begin
// close grm_crop
fdc.grm_crop.Close;
fdc.grm_population.close;
// get new id
fdc.grm_crop.sql.Clear;
fdc.grm_crop.SQL.Add('select max(item_ix)+1 as new_item from grassmind_poplist');
fdc.grm_crop.Open;
new_item:=fdc.grm_crop.FieldByName('new_item').Asstring;
fdc.grm_crop.Close;
// append record
fdc.grm_crop.sql.Clear;
fdc.grm_crop.SQL.Add('insert into grassmind_poplist ( item_ix,bname  ) values ');
fdc.grm_crop.SQL.Add('('+ new_item+', "'+edit_3.text+'" )');
fdc.grm_crop.ExecSQL;

// es muß noch der record an cdypflan angehängt werden
{pflichtfelder: item_ix, Name, Modell, art=-1, n_gehalt   }
 // get new id  of cdypflan
fdc.grm_crop.sql.Clear;
fdc.grm_crop.SQL.Add('select max(item_ix)+1 as new_item from cdypflan');
fdc.grm_crop.Open;
new_item:=fdc.grm_crop.FieldByName('new_item').Asstring;
fdc.grm_crop.Close;

// append record
fdc.grm_crop.sql.Clear;
fdc.grm_crop.SQL.Add('insert into cdypflan ( item_ix, name, art, n_gehalt, modell  ) values ');
fdc.grm_crop.SQL.Add('('+ new_item+', "'+edit_3.text+'" , -1, 0.3, "GRASSMIND" )');
fdc.grm_crop.ExecSQL;

// re-open grm_crop


fdc.grm_population.open;

fdc.grm_population.Locate('bname',variant(edit_3.Text),[]) ;
grm_crop_lcb.KeyValue:=new_item;
grm_crop_lcbCloseUp(nil);

 edit_3.Text:='?';
b_new_crop.Enabled:=false;
grm_crop_lcb.Enabled:=true;
end;

procedure Tcdy_parms.Button10Click(Sender: TObject);
var T,U,fat:real;
begin
T:=strtofloat(dbedit17.Text);
U:=strtofloat(dbedit1.Text);
fat:=T+0.3325*U;       //Faktor= [ld(6.3)-ld(2)]/[ld(63)-ld(2)] (ld:Zweierlogarithmus)
dbedit11.Text:= floattostr(fat);
fdc.hrz_prm.edit;
fdc.hrz_prm.FieldByName('FAT').Asfloat:=FAT;
fdc.hrz_prm.Post;
//dbedit11.DataSource.u
end;

procedure Tcdy_parms.DBEdit11Enter(Sender: TObject);
begin
 button10.Enabled:= not (dbedit17.Field.IsNull or dbedit1.Field.IsNull);
end;

procedure Tcdy_parms.DBEdit18Change(Sender: TObject);
begin
 if DBEdit18.Text='' then DBEdit18.Text:='0' ;
end;

procedure Tcdy_parms.DBEdit19Change(Sender: TObject);
begin
if dbedit19.Text='' then dbedit19.Text:='0';

try
tb_rootres.Position:= round(strtofloat(dbedit19.Text)*100);
  dbedit19.update;
  except; end;
end;


procedure Tcdy_parms.DBGrid8CellClick(Column: TColumn);
var i:integer;
begin
 if column.Title.Caption='PRF_NAME' then
 begin
   i:=1;
 end;
end;

procedure Tcdy_parms.grm_crop_LCBCloseUp(Sender: TObject);
var item:string;
begin
// show popuation list
item:=fdc.grm_population.FieldByName('item_ix').AsString;
with fdc.grm_crop do
begin
  close;
  sql.Clear;
  sql.Add('SELECT id, art_id, aname as Name, abundance, pl_id ,alias');
  sql.Add(' FROM grm_crop ');
  sql.Add('where grm_crop.pl_id='+item);
  open;
end;




end;

procedure Tcdy_parms.DBNavigator1Click(Sender: TObject; Button: TNavigateBtn);
var prfl:string;
begin
  if Button=nbInsert then
  begin
    prfl:=prf_names.KeyField;
  end;
end;

procedure Tcdy_parms.DBNavigator2Click(Sender: TObject; Button: TNavigateBtn);
var bn:string;
     abn:double;
begin
 if button=nbpost then
 begin
   // record abspeicher;
// bn:=grm_crop.fieldbyname('name').asstring;
//bn:=grm_crop.fieldbyname('abundance').asinteger;
 end;
end;

procedure Tcdy_parms.ds_prof_dataDataChange(Sender: TObject;
  Field: TField);
begin

 button10.Enabled:=false;
// if length(prof_data.FieldByName('horiz_name').AsString) >0 then begin panel5.Show;  end else begin end;

end;

procedure Tcdy_parms.IC_SClick(Sender: TObject);
begin
    fdc.hrz_prm.edit;
    fdc.hrz_prm.FieldByName('CIM').AsString:='PS';
    fdc.hrz_prm.Post;
end;

procedure Tcdy_parms.Button11Click(Sender: TObject);
begin
 groupbox1.Caption:=' select crop for root quality assessment ';
 fdc.opspa.Filter:=' not OD ';
 fdc.opspa.Filtered:=true;
 om_selection.KeyValue:=strtoint(_ewr_id.Text);
 groupbox1.show;
end;

procedure Tcdy_parms.Button13Click(Sender: TObject);
begin

if  groupbox1.Caption=' select crop for root quality assessment '
then _ewr_id.Text:= fdc.opspa.fieldbyname('ITEM_IX').asstring
else _grd_id.Text:= fdc.opspa.fieldbyname('ITEM_IX').asstring ;
groupbox1.Hide;
fdc.opspa.Filtered:=false;
end;

procedure Tcdy_parms.Button14Click(Sender: TObject);
begin
webdata.crop_mode:=false;
webdata.show;
dbgrid1.DataSource.DataSet.Refresh;
end;

procedure Tcdy_parms.Button12Click(Sender: TObject);
begin
 groupbox1.Caption:=' select organic matter ';
 fdc.opspa.Filter:=' od ';
 fdc.opspa.Filtered:=true;
 om_selection.KeyValue:=strtoint(_grd_id.Text);
 groupbox1.show;
end;

procedure Tcdy_parms.hrz_prm_AfterOpen(DataSet: TDataSet);
begin
 if dataset.FindField('STONE_CONT')=nil then
 begin
   dbedit18.Hide;
   label54.Hide;
 end
 else
 begin
   dbedit18.show;
   label54.show;
 end;
end;

procedure Tcdy_parms.sbaomdefsrcDataChange(Sender: TObject; Field: TField);
begin
if fdc.sbacrop.Active and fdc.sbaomdef.active then
begin
 fdc.sbamanure.Filter:='sba_crop_id='+fdc.sbacrop.fieldbyname('sba_crop_id').asstring+' and sba_om_id='+fdc.sbaomdef.fieldbyname('sba_om_id').asstring;
 fdc.sbamanure.Filtered:=true;
end;
end;

procedure Tcdy_parms.sbacropsrcDataChange(Sender: TObject; Field: TField);
begin
if fdc.sbacrop.Active and fdc.sbaomdef.active then
begin
  fdc.sbamanure.Filter:='sba_crop_id='+fdc.sbacrop.fieldbyname('sba_crop_id').asstring+' and sba_om_id='+fdc.sbaomdef.fieldbyname('sba_om_id').asstring;
  fdc.sbamanure.Filtered:=true;
end;
end;

procedure Tcdy_parms.FormShow(Sender: TObject);
begin

//tabsheet9.Show;
end;

procedure Tcdy_parms.GrassMindShow(Sender: TObject);
begin
 grm_crop_lcb.Enabled:=true;
 B_new_crop.Enabled:=false;
 fdc.litterroot.Open;
 fdc.littergreen.Open;
 fdc.litterstraw.Open;
 fdc.grm_population.Open;
 fdc.grm_names.Open;
with fdc.grm_names do
begin
first;
repeat
dbgrid20.Columns[0].PickList.add(fieldbyname('name').asstring);
next;
until eof;
end;
end;

procedure Tcdy_parms.grm_crop_srcUpdateData(Sender: TObject);
var item,art:integer;
    aname:string;
begin
//  lookup for art_id
item:=fdc.grm_population.FieldByName('item_ix').Asinteger  ;

aname:=fdc.grm_crop.FieldByName('Name').AsString;
fdc.grm_names.First;
fdc.grm_names.Locate('name',variant(aname) ,[] );
fdc.grm_crop.fieldbyname('art_id').asinteger:=fdc.grm_names.fieldbyname('art_id').asinteger;
fdc.grm_crop.FieldByName('pl_id').AsInteger:=item

end;

end.
