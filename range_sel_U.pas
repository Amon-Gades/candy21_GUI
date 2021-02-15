unit range_sel_U;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,variants,
  ComCtrls, ImgList, StdCtrls,   Grids, DBGrids, DBCtrls,cdyprmedit,
 { cdy_edit_dm,} Mask,  candy_uif, OleServer, {Access97, }ExtCtrls,
  CheckLst,strutils, Menus,clipbrd, ADODB,fdc_modul,
  { cdy_registry, RpCon, RpDefine, RpRave, RpBase, RpSystem,  RpRender, RpRenderPDF,
   RpRenderPreview,  RpRenderHTML, RpRenderCanvas,
rvclass,   rvproj,  rvcsstd   , rpmemo,   RpRenderPrinter,
    RpConDS, RpFiler,}
    DB, System.ImageList,
    {, RpRenderPDF, RpRave, RpBase, RpSystem, RpDefine,
  RpRender, RpRenderCanvas, RpRenderPrinter}

    FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.Phys.MSAcc, FireDAC.Phys.MSAccDef, FireDAC.VCLUI.Wait,
  FireDAC.Comp.Client


  ;

type
  Pcdy_item=^Tcdy_item;
  Tcdy_item=record
              first_st,
              last_st,
              utlg,
              snr :integer;
              db_name,
              soil_id,
              wett_id,
              plot_id :string;
              first_day,
              last_day :Tdate;
            end;
  Trange_select = class(TForm)
    ImageList1: TImageList;
    Button1: TButton;
    loesch_btn: TButton;
    Button10: TButton;
    ImageList2: TImageList;
 //   fda_update_: TQuery;
    TreeView1: TTreeView;
    Button9: TButton;
    ImageList3: TImageList;
    Timer1: TTimer;
    Button5: TButton;
    PopupMenu1: TPopupMenu;
    m1: TMenuItem;
    deletedatabase1: TMenuItem;
    PopupMenu2: TPopupMenu;
    createanewdatabase1: TMenuItem;
    PopupMenu3: TPopupMenu;
    addanewplot1: TMenuItem;
    deleteplot1: TMenuItem;
    PopupMenu4: TPopupMenu;
    deletethisplot1: TMenuItem;
    PopupMenu5: TPopupMenu;
    add10recs1: TMenuItem;
    pastedata1: TMenuItem;
    groupsimulation1: TMenuItem;
    PopupMenu6: TPopupMenu;
    evaluationmode1: TMenuItem;
    filemode1: TMenuItem;
    PopupMenu7: TPopupMenu;
    showthispropertyonly1: TMenuItem;
    SaveDialog1: TSaveDialog;
    PageControl3: TPageControl;
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
    Panel1: TPanel;
    Label28: TLabel;
    DBGrid3: TDBGrid;
    Edit3: TEdit;
    CheckBox1: TCheckBox;
    scenario_cntrl: TPanel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label27: TLabel;
    Label30: TLabel;
    CheckListBox1: TCheckListBox;
    sc_start: TDateTimePicker;
    sc_stop: TDateTimePicker;
    Button11: TButton;
    cdy_sgen: TCheckBox;
    cdy_ss: TCheckBox;
    lys_chkbx: TCheckBox;
    cdy_of: TRadioGroup;
    Button12: TButton;
    Button13: TButton;
    Button14: TButton;
    Button15: TButton;
    CheckBox6: TCheckBox;
    res_file: TEdit;
    p_korr: TCheckBox;
    add_prm: TEdit;
    TabSheet7: TTabSheet;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Label40: TLabel;
    GroupBox2: TGroupBox;
    Label9: TLabel;
    Label10: TLabel;
    Label8: TLabel;
    Label7: TLabel;
    Label17: TLabel;
    Label31: TLabel;
    Label37: TLabel;
    fda_crep: TEdit;
    fda_fkap: TEdit;
    Button2: TButton;
    fda_start: TDateTimePicker;
    simstop: TDateTimePicker;
    db_nlevel: TComboBox;
    GroupBox3: TGroupBox;
    Label5: TLabel;
    Label6: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label15: TLabel;
    Label13: TLabel;
    Label16: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    Label36: TLabel;
    fda_immi: TEdit;
    fda_geo: TEdit;
    fda_nied: TEdit;
    fda_ltem: TEdit;
    fda_wmz: TEdit;
    fda_wett: TComboBox;
    fda_soil: TDBLookupComboBox;
    fda_sbez: TEdit;
    Button6: TButton;
    Button7: TButton;
    cdy_run: TButton;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    Button16: TButton;
    TabSheet2: TTabSheet;
    Label1: TLabel;
    GroupBox1: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label26: TLabel;
    Label38: TLabel;
    Label39: TLabel;
    DateTimePicker1: TDateTimePicker;
    Edit1: TEdit;
    itemselect: TDBLookupComboBox;
    cdyactions: TDBLookupComboBox;
    update: TButton;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    Edit2: TEdit;
    Button8: TButton;
    Button18: TButton;
    DBGrid1: TDBGrid;
    Button4: TButton;
    crp_chk: TCheckBox;
    mf_chk: TCheckBox;
    oa_chk: TCheckBox;
    tl_chk: TCheckBox;
    ir_chk: TCheckBox;
    ac_chk: TCheckBox;
    gr_chk: TCheckBox;
    TabSheet3: TTabSheet;
    mw_unit: TLabel;
    Label18: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label19: TLabel;
    Label29: TLabel;
    DBGrid2: TDBGrid;
    lcb_merkmal: TDBLookupComboBox;
    mw_date: TDateTimePicker;
    s0: TEdit;
    s1: TEdit;
    mwert: TEdit;
    mwupdt: TButton;
    RadioButton3: TRadioButton;
    RadioButton4: TRadioButton;
    m_adapt: TCheckBox;
    Button3: TButton;
    DBLookupComboBox1: TDBLookupComboBox;
    CheckBox5: TCheckBox;
    Button17: TButton;
    Button19: TButton;
    lcb_item: TDBLookupComboBox;
    procedure TreeView1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
//    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure mwupdtClick(Sender: TObject);
//    procedure DataSource1DataChange(Sender: TObject; Field: TField);
    procedure updateClick(Sender: TObject);
    procedure cdyactionsCloseUp(Sender: TObject);
    procedure RadioButton1Click(Sender: TObject);
    procedure RadioButton2Click(Sender: TObject);
    procedure DBGrid1KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure TreeView1Expanded(Sender: TObject; Node: TTreeNode);
    procedure TreeView1Collapsed(Sender: TObject; Node: TTreeNode);
    procedure TreeView1Changing(Sender: TObject; Node: TTreeNode; var AllowChange: Boolean);
    procedure TreeView1Collapsing(Sender: TObject; Node: TTreeNode;var AllowCollapse: Boolean);
    procedure TreeView1MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure loesch_btnClick(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure cdy_runClick(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure RadioButton3Click(Sender: TObject);
    procedure RadioButton4Click(Sender: TObject);
    procedure DBGrid2KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure fda_wettChange(Sender: TObject);
    procedure TreeView1EndDrag(Sender, Target: TObject; X, Y: Integer);
    procedure TreeView1StartDrag(Sender: TObject;
      var DragObject: TDragObject);
    procedure TreeView1DragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure Button3Click(Sender: TObject);

    procedure Button7Click(Sender: TObject);

    procedure FormShow(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure TabSheet2Enter(Sender: TObject);
    procedure DBGrid1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure DBGrid1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure TabSheet2Exit(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button4Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    procedure Button13Click(Sender: TObject);
    procedure Button14Click(Sender: TObject);
    procedure Button15Click(Sender: TObject);
    procedure Button12Click(Sender: TObject);
    procedure Button16Click(Sender: TObject);
    procedure Edit2Exit(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure itemselectCloseUp(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure fda_sbezExit(Sender: TObject);
    procedure TreeView1ContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
    procedure m1Click(Sender: TObject);
    procedure m0Click(Sender: TObject);
    procedure deletedatabase1Click(Sender: TObject);
    procedure createanewdatabase1Click(Sender: TObject);
    procedure addanewplot1Click(Sender: TObject);
    procedure deleteplot1Click(Sender: TObject);
    procedure add10recs1Click(Sender: TObject);
    procedure pastedata1Click(Sender: TObject);
    procedure TabSheet3Enter(Sender: TObject);

    procedure groupsimulation1Click(Sender: TObject);
    procedure TreeView1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure CheckBox1Click(Sender: TObject);
    procedure Edit3Change(Sender: TObject);
//    procedure help_table_BeforeOpen(DataSet: TDataSet);
    procedure filemode1Click(Sender: TObject);
    procedure evaluationmode1Click(Sender: TObject);
    procedure fda_soilMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Label6DblClick(Sender: TObject);
    procedure Label5DblClick(Sender: TObject);
    procedure CheckBox5Click(Sender: TObject);
    procedure DBLookupComboBox1CloseUp(Sender: TObject);
    procedure DBGrid2MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure DBGrid2CellClick(Column: TColumn);
    procedure showthispropertyonly1Click(Sender: TObject);
    procedure TabSheet3Show(Sender: TObject);

    procedure printmanagement1Click(Sender: TObject);
    procedure MeasurementReport1Click(Sender: TObject);
    procedure Button18Click(Sender: TObject);
    procedure Button17Click(Sender: TObject);
    procedure any_chkClick(Sender: TObject);
    procedure TabSheet1Exit(Sender: TObject);
    procedure db_nlevelChange(Sender: TObject);
    procedure Button19Click(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure CheckBox3Click(Sender: TObject);
    procedure lcb_itemCloseUp(Sender: TObject);
    procedure lcb_merkmalCloseUp(Sender: TObject);

    //    procedure FormCreate(Sender: TObject);
   // procedure TabSheet1Show(Sender: TObject);
  private
    { Private declarations }
     const
      got_hints:boolean=false;
     var
     gis_call,
     gis_interface,
     draging:boolean;
     fda_nlevel:integer;

         h_item,old_item :ttreenode;
         old_cdy,h_cdy: pcdy_item;

  public
    { Public declarations }
    file_mode,
    cdy_success,
    just_expanded:boolean;
    a_item,
    active_item:ttreenode;
    cdy_db,
    plot,
    olddate,
    oldmacode,
    a_path:string;

    a_cdy_item:Pcdy_item;
    old_mwdate,old_mix,old_s0,old_s1,old_mw,
    snr_,utlg_:string;
    d_snr,d_utlg,d_db:string;  {Parameter für drag and drop}
    s_db, s_snr,s_utlg:string; {Parameter für drag and drop}
    wert2changed:boolean;
    call_candy:boolean;
    spec_da:integer;

   procedure sort_table(db,ftype,sortstring:string);
   procedure find_wetter_stat;
   procedure create_db;
 //  procedure createMW_files(db:string);
   procedure prepare_mwe;
   procedure item_click(shift:Tshiftstate);
   procedure click_on_item(db_name,I_text:string; exact_match:boolean);
   procedure  rebuilt_treeview;
   procedure set_mw_filter;
   procedure mw_evaluation;
//   procedure write_reg(schluessel,wert:string);
  end;

var
  range_select: Trange_select;

implementation
uses {anfrage,}cnd_vars,soilprf3,cndstat, get_db_name, mwshow, mw_modul_U,
  cdy_st_view,  selres,  cnd_util,  cdy_glob,
    registry, {sze_stat, wcdy_utils,}
  ask_how_many_recs,
  {experiment_report,   settings,} prmdlg2, wetgen1;

{$R *.DFM}




procedure Trange_select.sort_table(db,ftype,sortstring:string);
var sql_text:string ;
begin
 {
 hquery.CloseDatabase(hquery.database);
 with hquery  do
 begin
  close;
  databasename:=cdy_uif.cdydpath.text;
  sql.clear;
  sql_text:=' select * from '+ftype+db;
  sql.add(sql_text);
  hquery.open;
  hquery.first;
 end;
// htable.databasename:=cdy_uif.cdydpath.text;
// htable.tablename:=ftype+db+'.dbf';
// table1.EmptyTable;
  table1.tablename:='killme.db';
  table1.TableType:= ttparadox;
  table1.databasename:=cdy_uif.cdyrpath.text;
 batchmove1.mappings.clear;
 batchmove1.mode:=batcopy;
 batchmove1.source:=hquery;
 batchmove1.destination:=table1;
 batchmove1.execute ;
// step 2
 with hquery  do
 begin
  close;
  databasename:=cdy_uif.cdyrpath.text;
  sql.clear;
  sql_text:='select * from killme order by '+sortstring;
  sql.add(sql_text);
  open;
 end;
 htable.databasename:=cdy_uif.cdydpath.text;
 htable.tablename:=ftype+db+'.dbf';
 htable.EmptyTable;
 batchmove1.mappings.clear;
 batchmove1.mode:=batappend;
 batchmove1.source:=hquery;
 batchmove1.destination:=htable;
 batchmove1.execute ;
 }
end;

function cdy_db_name(masfile:string):string;
var i:integer;
    x:string;
begin
  i:=pos('FDA',uppercase(masfile));
  x:=copy(uppercase(masfile),i+3,5);
  cdy_db_name:=x;
end;



procedure Trange_select.FormShow(Sender: TObject);
{var f_name,cdy_db,plot:string;
    ok   :integer;
    f_search:Tsearchrec;
    r_node,a_node,s_node,p_node,f_node:ttreenode;
    a_cdy_item:pcdy_item;
    }
begin
// pagecontrol2.Show;
// tabsheet6.Show;
 wert2changed:=false;
 // if cdy_uif.winmode then
           begin
           fdc.profiles.close;
           fdc.profiles.open;
           fda_soil.listsource:=fdc.prfsrc;
           checkbox3.show;
           checkbox4.show;
           end ;
           {
           else
                begin
                     checkbox3.hide;
                     checkbox4.hide;
                   //  fda_soil.listsource:=cdy_edit.profiles;
                end;
            }

 find_wetter_stat;
 // böden finden
// pagecontrol1.hide;
// pagecontrol2.BringToFront;
// pagecontrol2.Show;
// tabsheet6.Show;
 rebuilt_treeview;
end;

procedure trange_select.rebuilt_treeview;
var f_name,cdy_db,plot, shown_db_name:string;
    ok   :boolean;
    f_search:Tsearchrec;
    r_node,a_node,s_node,p_node,f_node:ttreenode;
    a_cdy_item:pcdy_item;
begin

 treeview1.Items.Clear;
 fdc.actqry.open;
 fdc.items.Open;
 fdc.items.First;
 // FDA-items ermitteln   Anfang der Suchkette
   fdc.hqry.SQL.Clear;
   fdc.hqry.SQL.Add('select distinct fname from cdy_fxdat');
   fdc.hqry.Open;
   fdc.hqry.first;
   ok:=(fdc.hqry.RecordCount>0);

 with treeview1.Items do
 begin
  shown_db_name:= cdy_uif.db_f_name  ;
  if length(shown_db_name)>50 then
  begin
   shown_db_name:= leftstr( cdy_uif.db_f_name, 23)+'...'+ rightstr( cdy_uif.db_f_name, 23)
  end;

 // extractfilename()
  r_node:= add(nil,shown_db_name);
  r_node.imageIndex:=6;
  r_node.SelectedIndex:=7;
  r_node.expanded:=true;
 end;
 while ok do
 begin
//old  f_name:=f_search.name;
  f_name:=fdc.hqry.FieldByName('fname').AsString;
//old  cdy_db:=cdy_db_name(f_name);
  cdy_db:=f_name;
  with treeview1.Items do
    begin
       a_node:=addchild(r_node,cdy_db);
       a_node.ImageIndex:=2;
       a_node.SelectedIndex:=3;
       f_node:=addchild(a_node,'files');
       f_node.ImageIndex:=8;
       f_node.selectedIndex:=9;
       p_node:=addchild(a_node,'plots');
       p_node.ImageIndex:=0;
       p_node.selectedIndex:=1;
       with fdc.fdaqry do
       begin
        close;
        sql.Clear;
        sql.add( 'select SBEZ,SNR,UTLG, STANDORT, WETTER, STATUSANF,STATUSEND,SIMSTAND,STARTDAT from cdy_fxdat where fname=''' + f_name+'''');
        open;
        first;
        while not eof do
        begin
          new(a_cdy_item);
          a_cdy_item^.db_name:=cdy_db;
          a_cdy_item^.soil_id:=fieldbyname('STANDORT').asstring;
          a_cdy_item^.wett_id:=fieldbyname('WETTER').asstring;
          a_cdy_item^.snr:=fieldbyname('SNR').asinteger;
          a_cdy_item^.utlg:=fieldbyname('UTLG').asinteger;
          a_cdy_item^.first_st:=fieldbyname('STATUSANF').asinteger;
          a_cdy_item^.last_st:=fieldbyname('STATUSEND').asinteger;
          a_cdy_item^.last_day:=fieldbyname('SIMSTAND').asdatetime;
          a_cdy_item^.first_day:=fieldbyname('STARTDAT').asdatetime;
          plot:=trim(fieldbyname('SNR').asstring)+trim(fieldbyname('UTLG').asstring);
          a_cdy_item^.plot_id:=copy('_____',1,5-length(plot))+plot;
          plot:=a_cdy_item^.plot_id;
          plot:=plot+': '+fieldbyname('SBEZ').asstring;
          s_node:=addchild(p_node,plot);
          s_node.imageindex:=4;
          s_node.selectedindex:=5;
          s_node.data:=a_cdy_item;
          next;
        end;
        close;
        sql.clear;
       end;
       s_node:=addchild(f_node,'FX_'+f_name+'_dat');  // add fda
       s_node.imageindex:=4;
       s_node.selectedindex:=5;
//old       f_name:='MAS'+cdy_db+'.DBF';
            f_name:='MA_'+cdy_db+'_dat';
//old       if fileexists(a_path+'\'+f_name) then

       begin
        s_node:=addchild(f_node,f_name);
        s_node.imageindex:=4;
        s_node.selectedindex:=5;
       end;

       // File-Modus (geht nur VOR der Kartenansicht, weil das file nicht freigegeben wird
       s_node.imageindex:=4;
       s_node.selectedindex:=5;
       f_name:='GIS'+cdy_db+'_dat';    //+'.DBF';
// die prüfung muß noch überlegt werden
       if fileexists(a_path+'\'+f_name) then
       begin
        s_node:=addchild(f_node,f_name);
        s_node.imageindex:=4;
        s_node.selectedindex:=5;
       end ;

//old       f_name:='GUE'+cdy_db+'.DBF';
       f_name:='SL_'+cdy_db+'_dat';
//old       if fileexists(a_path+'\'+f_name) then
       begin
        s_node:=addchild(f_node,f_name);
        s_node.imageindex:=4;
        s_node.selectedindex:=5;
       end;
(* erst mal weglassen bis xx1xx
       f_name:='MMH'+cdy_db+'.DBF';
       if fileexists(a_path+'\'+f_name) then
       begin
        s_node:=addchild(f_node,f_name);
        s_node.imageindex:=4;
        s_node.selectedindex:=5;
       end;


       xx1xx *)

       f_name:='MV_'+cdy_db+'_dat';

       begin
        s_node:=addchild(f_node,f_name);
        s_node.imageindex:=12;
        s_node.selectedindex:=13;
        s_node.data:=a_cdy_item;
       end;

       f_name:='MS_'+cdy_db+'_dat';

       begin
        s_node:=addchild(f_node,f_name);
        s_node.imageindex:=16;
        s_node.selectedindex:=17;
        s_node.data:=a_cdy_item;
       end;

(* erst mal nicht  *)
       f_name:='MG_'+cdy_db+'_dat';
    //   if fileexists(a_path+'\'+f_name) then
       begin
        s_node:=addchild(f_node,f_name);
        s_node.imageindex:=15;
        s_node.selectedindex:=15;
       end ;



       f_name:='S__'+cdy_db+'.STC';
       if fileexists(a_path+'\'+f_name) then
       begin
        s_node:=addchild(f_node,f_name);
        s_node.imageindex:=10;
        s_node.selectedindex:=11;
       end;


       f_name:='GIS'+cdy_db+'.shp';  // Kartensymbol
       if fileexists(a_path+'\'+f_name) then
       begin
        s_node:=addchild(a_node,f_name);
        s_node.imageindex:=14;
        s_node.selectedindex:=14;
       end;

    end;
  fdc.hqry.Next;
  ok:=not (fdc.hqry.Eof); //oldfindnext(f_search);
 end;
// old findclose(f_search);
// ende der suchkette
 fdc.hqry.Close;
 r_node.Expand(false);
  active_item:=nil;
 a_item:=treeview1.TopItem;
end;

procedure Trange_select.prepare_mwe;
var a_item:TTreenode;
    a_cdy_item:Pcdy_item;

    var m_file,s_file,h:string;begin
(*
 a_item:={treeview1.selected} active_item;
 a_cdy_item:=a_item.data;
 if a_cdy_item<>NIL then
 begin
  range_select.cdy_db:=a_cdy_item^.db_name;
  range_select.plot  :=a_cdy_item^.plot_id;
 end;
 range_select.close;

                 *)
 {
 plot:=snr_+utlg_;
plot:=copy('_____',1,5-length(plot))+plot;
}

 // h:=cdyplot.text;
 // h:=copy(h,1,length(h)-1);
 // while h[1]='_' do h:=copy(h,2,length(h));
 fdc.mweqry.Close;
(*111 noch nicht umgestellt: *)
  mw_modul.snr :=snr_;
  mw_modul.utlg:=utlg_;
  mw_modul.Date_a.date:=(fda_start.date);
  mw_modul.Date_e.date:=(simstop.date);
  mw_modul.f_name:=cdy_db;
  mw_modul.showmodal;


(*111*)

 end;

procedure Trange_select.Button1Click(Sender: TObject);
begin
 range_select.close;
end;

procedure Trange_select.mwupdtClick(Sender: TObject);
var mw_adapt:char;
bm:tbookmark;
adat:Tdate;
s0_,s1_:string;
ins_mode:boolean;
begin
 ins_mode:=radiobutton3.Checked;
 bm:=fdc.mweqry.GetBookmark;
if m_adapt.checked then mw_adapt:='Y' else mw_adapt:='N';
if radiobutton3.checked then
  with fdc do
  begin
   any_update.sql.clear;
   if gis_call
     then any_update.sql.add('insert into cdy_mgdat (FNAME,patch,UTLG, ')
     else any_update.sql.add('insert into cdy_mvdat (FNAME,SNR,UTLG, ');
    any_update.sql.add(' DATUM,M_IX,S0,S1,M_WERT,KORREKTUR) Values (');
 //   any_update.sql.add('''*'''+', ' );
    any_update.sql.add(''''+cdy_db+''''+', ');
   { if gis_call then any_update.sql.add( inttostr(karte.patrec.patch)+', ')
                else
                }
                 any_update.sql.add( snr_+',');
    any_update.sql.add( utlg_+', '+''''+datetostr(mw_date.Date)+'''' +', ');
    any_update.sql.add(floattostr(lcb_merkmal.keyvalue)+', ');
    any_update.sql.add(s0.text+', '+s1.text+', '+ stringreplace(mwert.text,',','.',[]) );
    any_update.sql.add(','+''''+mw_adapt+''''+')');
    any_update.sql.add('   ');
    any_update.execsql;

    adat:= mw_date.date;
    s0_:=s0.Text;
    s1_:=s1.Text;
    fdc.mweqry.close;
    fdc.mweqry.open;

  //  fdc.mweqry.Locate('DATUM;M_IX;S0;S1',vararrayof([adat,lcb_merkmal.keyvalue,s0_,s1_]),[] );
  {  bm:=fdc.mweqry.GetBookmark;
    fdc.mweqry.close;
    fdc.mweqry.open;
    fdc.mweqry.GotoBookmark(bm);
    fdc.mweqry.FreeBookmark(bm);
}
    radiobutton3.Checked:=true;

  end;
if radiobutton4.checked then
  with fdc.any_update do
  begin
    sql.clear;
//    sql.add('update cdy_mvdat SET  [FIRST]='+'''*'''+', ');
    sql.add('update cdy_mvdat SET  ');
    sql.add('DATUM='+''''+ datetostr(mw_date.Date)+'''' +', ');
    sql.add('M_IX= '+floattostr(lcb_merkmal.keyvalue)+', ');
    sql.add('S0='+s0.text+', S1='+s1.text+', M_WERT=0'+ stringreplace(mwert.text,',','.',[]) );
    sql.add(' , KORREKTUR='+''''+mw_adapt+'''');
    sql.add('where FNAME='''+cdy_db+''' and SNR='+snr_+' and UTLG='+utlg_+' and DATUM=:old_date and M_IX='+old_mix);
    sql.add(' and S0='+old_s0+' and S1='+old_s1+' and M_WERT=0'+stringreplace(old_mw,',','.',[]));
    parambyname('old_date').value:=old_mwdate;
    execsql;
  end;

    fdc.mweqry.close;
    fdc.mweqry.open;
    fdc.mweqry.GotoBookmark(bm);
    fdc.mweqry.FreeBookmark(bm);
    radiobutton3.Checked:= ins_mode;

 // fdc.mweqry.Refresh;
end;


procedure Trange_select.updateClick(Sender: TObject);
var   rdate:Tdate;
      test,
      orgwert,wert_2,_rein:string;
      a_macode:integer;
      bm:Tbookmark;
      o_wert,wert2,x1,x2  :real;
      ins_mode:boolean;
begin
  ins_mode:=radiobutton1.Checked;
  rdate:=datetimepicker1.date;
  olddate  :=fdc.masqry.fieldbyname('DATUM').asstring;
  oldmacode:=fdc.masqry.fieldbyname('MACODE').asstring;
// Zusammenspiel von Origwert, Rein, und WERT2
  a_macode:= cdyactions.keyvalue;
// versuch: (17.10.06 FRA)
  if edit1.text<>'' then  o_wert  := strtofloat(edit1.text) else o_wert:=0;
 if (oldmacode<>'') {and not checkbox1.checked} then
  case a_macode of
  1,12:  begin
       if edit2.text='?' then
       begin
       // Aussaat-Aufgang wert2: N-Entzug origwert:naturalertrag
       x1    := fdc.crops.lookup('ITEM_IX',{fdc.masqryWert1.asinteger}itemselect.KeyValue,'N_GEHALT');
       wert2 :=x1*o_wert;
       end
       else  wert2:=strtofloat(  stringreplace(edit2.text,',','.',[]) );
      // Aussaat-Aufgang wert2: N-Entzug origwert:naturalertrag
       x1    := fdc.crops.lookup('ITEM_IX',{fdc.masqryWert1.asinteger}itemselect.KeyValue,'N_GEHALT');
       if not wert2changed then wert2 :=x1*o_wert;
      end;
  2,9:  begin
       if edit2.text='?' then
       begin
          x1    := fdc.crops.lookup('ITEM_IX',{fdc.masqryWert1.asinteger}itemselect.KeyValue,'N_GEHALT');
          wert2 :=x1*o_wert;
       end else wert2:=strtofloat(  stringreplace(edit2.text,',','.',[]) );

      end;
  3:  begin
      // org. Düngung    wert2: C-input  origwert:FM-Zufuhr
       x1    := fdc.opspa.lookup('ITEM_IX',{fdc.masqrywert1.asinteger}itemselect.KeyValue,'TS_GEHALT');
       x2    := fdc.opspa.lookup('ITEM_IX',{fdc.masqrywert1.asinteger}itemselect.KeyValue,'C_GEH_TS');
       if not wert2changed then wert2:=o_wert*x1*x2*100; // 100: Umrechnung dt->kg
      end;
  4:  begin
      // N-Mineraldüngung  wert2: NH4-Anteil  origwert: N-Zufuhr
       wert2    := fdc.fert.lookup('ITEM_IX',{fdc.masqrywert1.asinteger}itemselect.KeyValue,'AMMANTEIL');
      end;
  0,5:  begin
      // Bodenbearbeitung  wert2: dm-tiefe   origwert:cm-tiefe
      if not wert2changed then  wert2:=round(o_wert/10 );
      end;
  6:  begin
      // Beregnung   wert2 =origwert
      if not wert2changed then wert2:=o_wert;
      end;


  23: begin
      // Mischwald
       wert2:=strtofloat(  stringreplace(edit1.text,',','.',[]) );
      end;


  end;
 if wert2changed then
  begin
   wert2:=strtofloat(  stringreplace(edit2.text,',','.',[]) );
  end;

  orgwert:=stringreplace(edit1.text,',','.',[]);
  if orgwert='' then orgwert:='0';
  wert_2 :=floattostr(round(wert2));
  fdc.any_update.sql.clear;
  if wert2changed then _rein:='J' else _rein:='N'  ;
  wert2changed:=false;
  if  radiobutton2.checked then
  with fdc do    //overwrite mode
  begin
   any_update.sql.clear;
   any_update.sql.add(' update '+'cdy_MAdat  SET');
   any_update.sql.add(' DATUM= '''+datetostr(datetimepicker1.date)+'''');
   any_update.sql.add(' , MACODE='+floattostr( a_macode));
   any_update.sql.add(' , WERT1= '+floattostr( itemselect.keyvalue));
   any_update.sql.add(' , WERT2= '+wert_2);
   any_update.sql.add(' , ORIGWERT='+orgwert);
   any_update.sql.add(' , REIN= '+''''+_rein+'''');
   any_update.sql.add(' where SNR='+snr_+' and UTLG='+utlg_ +' and DATUM= :the_date');  //das Datumsformat ist nicht verträglich  //+' and DATUM='''+olddate+'''');
   any_update.sql.add(' and MACODE='+oldmacode+' and fname='''+cdy_db+'''');
   any_update.ParamByName('the_date').Value:=olddate;
  end;

  if not radiobutton2.checked then
  with fdc do   //insert mode
  begin
   any_update.sql.clear;
   any_update.sql.add(' insert into cdy_madat (FNAME,DATUM,MACODE,WERT1,WERT2,ORIGWERT,SNR,UTLG) VALUES (  ');
   any_update.sql.add(''''+cdy_db+''''+',');
   any_update.sql.add(''''+datetostr(datetimepicker1.date)+'''');
   any_update.sql.add(','+floattostr( a_macode));
   any_update.sql.add(' ,'+floattostr( itemselect.keyvalue));
   any_update.sql.add(' , '+wert_2);
   any_update.sql.add(' , '+orgwert);
   any_update.sql.add(' , '+snr_+' ,'+utlg_ +' )' );
  // any_update.sql.add(' , '+''''+_rein+''''+' )');
   test:=any_update.sql.text;
  end;

  fdc.any_update.execsql;
 bm:=fdc.masqry.GetBookmark;
 fdc.masqry.close;
 fdc.masqry.open;
 fdc.masqry.GotoBookmark(bm);
  fdc.masqry.FreeBookmark(bm);
 //fdc.masqry.Locate('DATUM',datetimepicker1.date,[]);
 radiobutton1.Checked:=ins_mode;
end;

procedure Trange_select.cdyactionsCloseUp(Sender: TObject);
var keyval:integer;
  begin
  keyval:=cdyactions.keyvalue;
  range_select.edit2.enabled:=true;
case keyval of
 1,2,9,12: begin
     fdc.items.Filter:='OBJEKT=1';
     range_select.label3.caption:='N-uptake (kg/ha)=';
    end;

  3 : begin
      fdc.items.filter:='OBJEKT='+floattostr(keyval);
      range_select.label3.caption:='C-input (kg/ha)=';
    end;
 4: begin
      fdc.items.filter:='OBJEKT='+floattostr(keyval);
      range_select.label3.caption:='NH4-amount (%)=';
      range_select.edit2.enabled:=false;
     end;
  0,5: begin
      fdc.items.filter:='OBJEKT=5' ;
      range_select.label3.caption:='lower calc. layer';
      range_select.edit2.enabled:=false;
     end;

  21,22,23: begin
      fdc.items.filter:='OBJEKT='+floattostr(keyval);
      range_select.label3.caption:='xxx=';
      range_select.edit1.Text:='-99';

  end;
  6,7,8,10,11: Begin

       fdc.items.filter:='OBJEKT='+floattostr(keyval);
       fdc.items.Filtered:=false;
       range_select.label3.caption:='';
       range_select.edit2.enabled:=false;

     end;

else fdc.items.filter:='OBJEKT=-99';
end;
range_select.label4.caption:=fdc.aktion.lookup('ACTION_ID',keyval,'DEF_INTENSITY');

range_select.label2.caption:=fdc.aktion.lookup('ACTION_ID',keyval,'UNIT_INTENSITY');


with fdc do
begin
items.filtered:=true;
itemselect.keyvalue:=1;
itemselect.show;
end;
end;

procedure Trange_select.RadioButton1Click(Sender: TObject);
begin
 radiobutton1.checked:=true;
 radiobutton2.checked:=false;
 update.caption:='insert'
end;

procedure Trange_select.RadioButton2Click(Sender: TObject);
begin
 radiobutton2.checked:=true;
 radiobutton1.checked:=false;
 update.caption:= 'update';
end;

procedure Trange_select.DBGrid1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var taste:word;
    rdate:tdate;
    amacode:string;
begin
  taste:=key;
  if taste=46 then
  with fdc.any_update do
  begin
   // aktuellen Satz löschen
   sql.Clear;
   sql.add('delete from MAS'+cdy_db +'.dbf  where SNR='+snr_+' and UTLG=' +utlg_);
   sql.add(' and DATUM='''+fdc.masqry.fieldbyname('DATUM').asstring+'''');
   sql.add(' and MACODE='+fdc.masqry.fieldbyname('MACODE').asstring);
   fdc.masqry.next;
   rdate:=datetimepicker1.date;
   amacode:=fdc.masqry.fieldbyname('MACODE').asstring;
   execsql;
   fdc.masqry.Close;
   fdc.masqry.open;
   fdc.masqry.Locate('DATUM;MACODE',vararrayof([datetostr(rdate),amacode]),[]);
  end;
end;


procedure Trange_select.TreeView1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);

var new_item :ttreenode;
    last_year :integer;

begin
  button5.Enabled:=false;
  try
  if a_item.ImageIndex in [4,5] then   button6.Click;      //fx data updaten
  except; end;
  h_item:=a_item;                                // alten item merken
//  if h_item.Data<>nil then old_cdy:= h_item.Data;
  a_item:=treeview1.getnodeat(x,y);            // gewählten item bestimmen
//  h_cdy:=a_item.Data;
  if (a_item<>nil) and
  (a_item.ImageIndex in [4,5]) and (pos(':',a_item.Text)>0) then
  begin  // wenn es ein candy item ist, dann altes candy item de-taggen und  neues taggen
     try
      if   (old_item <> nil )
      and  (pos('#',old_item.Text)>0)
  //    and  (pos(':',h_item.Text)>0)
         then old_item.Text:=rightstr(old_item.Text,length(old_item.Text)-1);
     except;end;
      if a_item.Text[1]<>'#'  then    a_item.Text:='#'+a_item.Text;
      old_item:=a_item;
  end;

  if a_item=NIL then a_item:=h_item  ;      // wenn daneben geklickt, beleibt alles wie zuvor
//  if h_item<>NIL then
  if h_item<>a_item then  h_item.stateindex:=-1;      // alten item deselektieren



  if a_item=NIL then exit;                        // nur weiter wenn Objekt getroffen
  // a_item.stateindex:=2;
   //.Selected:=true;
   //focused:=true;
  if button=mbleft then
begin
  if (h_item<>a_item) or (h_item.ImageIndex in [14,15]) then     Item_click(shift);
end;
treeview1.popupmenu:=nil;
if (button=mbright) and (a_item.ImageIndex in [2,3])
then begin
      cdy_db:=a_item.text;
      treeview1.popupmenu:=popupmenu1;
     end;

if (button=mbright) and (a_item.ImageIndex in [0,1])
then begin
      cdy_db:=a_item.text;
      treeview1.popupmenu:=popupmenu3;
     end;
if (button=mbright) and (a_item.ImageIndex in [6,7])
then begin
treeview1.PopupMenu:=popupmenu2;
     end;

if (button=mbright) and (a_item.ImageIndex in [16,17])
then begin
treeview1.PopupMenu:=popupmenu6;
     end;

if (button=mbright) and (a_item.ImageIndex =5)
then begin
treeview1.PopupMenu:=popupmenu4;
     end;
  // if karte.Showing then karte.BringToFront;

  timer1.Enabled:=true;
//  application.ProcessMessages;
end;

procedure trange_select.Item_click(shift:tshiftstate);
 var new_item :ttreenode;
    last_year, last_page :integer;
    h_item  :ttreenode;
begin
  a_item.stateindex:=1;                           // Knoten markieren
  last_page := pagecontrol1.activepageindex;
  // alle cdy - Objekte deselektieren
  Begin
    h_item:=treeview1.TopItem;
   if (h_item<>NIL)  and (h_item.ImageIndex=5) then h_item.ImageIndex:=4;
    repeat
      if h_item<>NIL then h_item:=h_item.getNext;
      if (h_item<>NIL) then if  (h_item.ImageIndex=5)  then  h_item.ImageIndex:=4;
    until h_item=nil;
  end;
  treeview1.Refresh;
  button9.Enabled:=false;
  label1.caption:=a_item.Text;
  label29.Caption:=a_item.Text;
  loesch_btn.enabled:=false;
  button5.Enabled:=false;
  button10.enabled:=false;
  fdc.htab.close;
  panel1.hide;
  pagecontrol1.BringToFront;

  if (a_item<>nil)
  and (a_item.parent.parent<>NIL)
  and (a_item.ImageIndex in [4,5])
  and (a_item.Parent.parent.GetLastChild.ImageIndex in [14,14]) then
  begin
    // GIS -Interface, Meßwerte verstecken
        gis_interface:=true;
  end
  else gis_interface:=false;

  if (a_item.parent<>NIL) and (a_item.Parent.ImageIndex in [8,9]) then
  begin
    fdc.htab.Close;
    fdc.htab.filter:='fname='+''''+cdy_db+'''';
   fdc.htab.Filtered:=true;
    case a_item.imageindex of
    4,5{,12,16 }:     begin                   //dataset
        if uppercase(copy(a_item.text,length(a_item.text)-2,3))='DAT'
        then
         begin
              pagecontrol1.hide ;
              file_mode:=true;
              if copy(a_item.Text,1,2)='MA' then   fdc.htab.tablename:='cdy_madat';//a_item.Text;
              if copy(a_item.Text,1,2)='FX' then   fdc.htab.tablename:='cdy_fxdat';//a_item.Text;
              if copy(a_item.Text,1,3)='SL_' then   fdc.htab.tablename:='cdy_SLdat';//a_item.Text;

              fdc.htab.open;
              panel1.Show;
              panel1.BringToFront;
         end;
         end;{4,5}
    10,11:      //stc-file
    begin
        if uppercase(copy(a_item.text,length(a_item.text)-2,3))='STC'
        then
         begin
              file_mode:=true;
            st_view.filename:=cdy_uif.cdydpath.text+'\'+a_item.text;
            st_view.showmodal;
            panel1.hide;
         end;
    end;


     15,12,13,16,17:    begin //MW-file
                  file_mode:=true;
                  fdc.htab.Close;
                  if copy(a_item.Text,1,3)='MV_' then   fdc.htab.tablename:='cdy_MVdat';//a_item.Text;
                  if copy(a_item.Text,1,3)='MS_' then   fdc.htab.tablename:='cdy_Msdat';//a_item.Text;
                  if copy(a_item.Text,1,3)='MG_' then   fdc.htab.tablename:='cdy_mgdat';//a_item.Text;

                  if ( copy(a_item.Text,1,3)='MV_' )
                  or ( copy(a_item.Text,1,3)='MG_' )
                  or (
                       (copy(a_item.Text,1,3)='MS_') and (filemode1.Checked)
                      )

                  then
                  begin
                  // Table view

                   pagecontrol1.hide ;
                  //old# fdc.htab.tablename:=a_item.Text;

                   fdc.htab.open;
                   panel1.Show;
                   panel1.BringToFront;
                   exit;
                  end
                  else
                  begin

//                 if a_item.imageindex=11 then a_item.imageindex:=12;
//                 treeview1.Refresh;
{***1
                 a_cdy_item:=a_item.data;
                 mw_show.fname:=a_item.text;
                 mw_show.Caption:=a_cdy_item^.db_name;
                // Table zur ACCESS db moven
                // fdc.htab.databasename:='cdyparm';
                 htable.databasename:=cdy_uif.cdydpath.text;
                 htable.tablename:=a_item.Text;
                 fdc.htab.tablename:='MW_TABLE';
                 fdc.htab.Close;
                 with batchmove1 do
                 begin
                   source:=htable;
                 //  destination:=fdc.htab;
                   mode:=batcopy;
                   execute;
                 end;
                 fdc.htab.Close;
1***}
                if copy(a_item.text,1,3)='MW_' then mw_show.Button2.show else mw_show.button2.hide;

                if a_cdy_item=NIL then mw_show.a_plot:=0;
                  mw_show.db:=cdy_db;
                  mw_show.showmodal;
                 // 'normale' Anzeige sicherstellen
                   pagecontrol1.hide ;
                   panel1.Show;
                   panel1.BringToFront;
                end;
              end;

    end; //case
  end;
                (*** keine karte
      if not (karte=nil) and (a_item.ImageIndex in [ 14,14 ]) then  // Karte zeigen
      begin
       if not karte.Showing then
       begin
        // erst die Karte zeigen !
         karte.show;

         karte.shp_fname:=a_item.Text;
         karte.shapes.Items.clear;
         karte.shapes.Items.Add(karte.shp_fname);
         karte.shapes.ItemIndex:=0;

         karte.shapesclick(self);  // Karte darstellen

         karte.result_map:=false;
         karte.edit1.Hide;
         karte.updown1.Hide;
         karte.Label3.Hide;
         karte.gis_mode:=(a_item.ImageIndex=14);
         karte.BringToFront;
         {
         repeat
           application.ProcessMessages;
          until not karte.showing;
        // wie wurde karte beendet ?
          }
       end;
      end;
             **)
     button5.Enabled:=false;       // was macht der ??
     if a_item.imageindex in  [ 2,3 ] then  // db  level
     begin
      file_mode:=false;
      cdy_db:=a_item.text;
      button9.Enabled:=true;
      {
      if a_item.GetLastChild.ImageIndex=14
      then button5.Enabled:=false else button5.Enabled:=true;
      }
      // aktuelle db in registry schreiben
     //? write_reg_ss('cdy_db',cdy_db);
    end;

   if a_item.imageindex in  [ 8,9 ] then  // Diskette  (file level)
   begin
      cdy_db:=a_item.Parent.text;
      loesch_btn.enabled:=true;
   end;

   if a_item.imageindex in [0,1,6,7] then
    begin
      button10.enabled:=true;
    end;

  if a_item.Data=NIL then
  begin
//      pagecontrol1.hide;
//      panel1.BringToFront;
    //  if karte.Showing then
      begin
         //karte.BringToFront;
         // karte.SetFocus;
         //application.BringToFront
         // range_select.Hide;
      end;
  end
  else
  begin
   a_cdy_item:=a_item.data;
   fdc.masqry.close;
    // Focus on new document
    if (active_item<>nil) and (active_item.imageindex=5) then active_item.imageindex:=active_item.imageindex-1;
    active_item:=a_item;
    if active_item.imageindex =4 then   active_item.imageindex:=active_item.imageindex+1;
    treeview1.Refresh;
    if (a_item.parent<>NIL) and (a_item.Parent.ImageIndex in [0,1]) then file_mode:=false;
    if not file_mode then
    begin
     pagecontrol1.Show;
     pagecontrol1.BringToFront;
    end;
    loesch_btn.Enabled:=true;
    range_select.cdy_db:=a_cdy_item^.db_name;
    range_select.plot  :=a_cdy_item^.plot_id;
    fdc.masqry.close;
    fdc.fdaqry.close;
    fdc.masqry.SQL.clear;
    snr_ :=floattostr(a_cdy_item^.snr);
    utlg_:=floattostr(a_cdy_item^.utlg);
    mw_show.a_plot:=10*a_cdy_item^.snr+ a_cdy_item^.utlg;
    fdc.actqry.open;
    fdc.items.open;

// testen ob spec verfügbar
    fdc.hqry.Close;
   // fdc.hqry.Connection:= cdy_uif.ado_cdyprm;
    fdc.hqry.sql.clear;
    fdc.hqry.sql.add('select * from cdy_madat where fname='''+cdy_db+'''');
    fdc.hqry.Open;
    if fdc.hqry.Fields.FindField('spec')=NIL then spec_da:=0 else   spec_da:=1;
    fdc.hqry.close;

    fdc.masqry.sql.clear;
    fdc.masqry.sql.add(a2p('select Key, SNR,UTLG, [DATUM], MACODE,WERT1,WERT2,ORIGWERT,REIN from cdy_madat where fname='''+cdy_db+''''));
    fdc.masqry.sql.add(' and ( macode=99');
    if mf_chk.checked then fdc.masqry.sql.add(' or macode=4 ');
    if tl_chk.checked then fdc.masqry.sql.add(' or macode in (0,5) ');
    if oa_chk.checked then fdc.masqry.sql.add(' or macode=3 ');
    if ir_chk.checked then fdc.masqry.sql.add(' or macode=7 ');
    if ac_chk.checked then fdc.masqry.sql.add(' or macode=8 ');
    if gr_chk.checked then fdc.masqry.sql.add(' or macode in (6,10,11) ');
    if crp_chk.checked then fdc.masqry.sql.add(' or macode in (0,1,2,6,9,12) ');
    fdc.masqry.sql.add(a2p(' ) and snr='+snr_+' and utlg='+utlg_+' order by [DATUM],MACODE'));
    //fdc.masqry.SQL.SaveToFile('check0.sql');
    fdc.masqry.open;

    fdc.fdaqry.sql.clear;
    fdc.fdaqry.sql.add('select * from cdy_fxdat where fname='''+cdy_db+'''');
    fdc.fdaqry.sql.add(' and SNR='+snr_+' and UTLG='+utlg_);
    fdc.fdaqry.open;
    fda_crep.Text:= fdc.fdaqry.fieldbyname('CREP').asstring;
    fda_nlevel:= fdc.fdaqry.fieldbyname('NLEVEL').asinteger;
    db_nlevel.ItemIndex:= fdc.fdaqry.fieldbyname('NLEVEL').asinteger-1;
    fda_fkap.Text:= fdc.fdaqry.fieldbyname('NFK0').asstring;
    fda_soil.keyvalue:= fdc.fdaqry.fieldbyname('STANDORT').asstring;
    fda_immi.Text:= fdc.fdaqry.fieldbyname('IMMISSION').asstring;
    fda_wett.Itemindex:=fda_wett.items.indexof(fdc.fdaqry.fieldbyname('WETTER').asstring);
    fda_start.date:= fdc.fdaqry.fieldbyname('STARTDAT').asdatetime;
    fda_sbez.text:= fdc.fdaqry.fieldbyname('SBEZ').asstring;
    fda_ltem.Text:= fdc.fdaqry.fieldbyname('LTEM').asstring;
    fda_nied.Text:= fdc.fdaqry.fieldbyname('NIED').asstring;
    a_cdy_item.last_st:=fdc.fdaqry.fieldbyname('STATUSEND').asinteger;
    a_cdy_item.first_st:=fdc.fdaqry.fieldbyname('STATUSANF').asinteger;
    if fdc.fdaqry.fields.findfield('WMZ')<>NIL
      then fda_wmz.Text := fdc.fdaqry.fieldbyname('WMZ').asstring
      else fda_wmz.Text :='-';
    fda_geo.Text:= fdc.fdaqry.fieldbyname('GEOBREITE').asstring;
    // stop date
     fda_wett.onchange(self);
    if fdc.fdaqry.fields.findfield('STOPDAT')<>NIL
      then simstop.date := fdc.fdaqry.fieldbyname('STOPDAT').asdatetime;
    // Prognose-Button
    if a_cdy_item.last_st > 0 then  button16.enabled:=true else  button16.enabled:=false;

    // Messwerte
       showthispropertyonly1.Caption:='&show all properties' ;


(*    if not (gis_interface) and fileexists(cdy_uif.cdydpath.text+'\'+'MWE'+cdy_db+'.dbf')
       then
 *)

//       begin

        fdc.mweqry.close;
        fdc.mweqry.filtered:=false;
//        showthispropertyonly1.Caption:='&show this property only';
//        application.ProcessMessages;
 // showthispropertyonly1.Caption:='&show this property only'
        fdc.mweqry.sql.Clear;
        fdc.mweqry.sql.add(' select * from cdy_MVDAT where fname='''+cdy_db+'''');
        fdc.mweqry.sql.add(' and SNR='+snr_+' and UTLG='+utlg_+' order by DATUM ');
        fdc.mweqry.SQL.SaveToFile('getmwe.sql');
        fdc.mweqry.open;
   //    tabsheet3.pagecontrol:=pagecontrol1;
      //  end ;
   //    end
  (*
    else        TabSheet3.PageControl:=pagecontrol2;

    begin

       // was könnte sich hier geändert haben
           if (ssShift in shift)
     then pagecontrol1.activepageindex:=last_page
     else  if (not draging) then   pagecontrol1.ActivePageIndex:=0;

//      if not (draging  or (not draging and not ([ssShift] in shift))) then   pagecontrol1.ActivePageIndex:=0;
       end;

   *)
     // falls wir aus dem GIS-Modus aufgerufen wurden, soll doch eine Registerkarte mit Messwerten gezeigt werden
   (*** keine karte
      if (gis_call) then
       begin
        with fdc.mweqry do
        begin
        close;
        filtered:=false;
        showthispropertyonly1.Caption:='&show this property only';
        sql.Clear;
        sql.add(' select * from cdy_mgdat where fname="'+cdy_db+'"');
        sql.add(' and patch='+inttostr(karte.patrec.patch)+' order by DATUM  ');
        open;
        label29.caption:=a_item.text+'; patch '+inttostr(karte.patrec.patch);
        tabsheet3.pagecontrol:=pagecontrol1;
        end ;
       end;
    ***)
   end;
  // a_item:=treeview1.TopItem;
 //  a_item.stateindex:=1;
 //  treeview1.refresh;
     pagecontrol1.ActivePage:=tabsheet1;
end;


procedure Trange_select.TreeView1Expanded(Sender: TObject;
  Node: TTreeNode);
var a_item:ttreenode;
    indx  :integer;
begin
   just_expanded:=true;
   a_item:=node;
   indx:=a_item.ImageIndex;
   if round(indx/2 +0.1)*2=indx then
 {  if not a_item.selected then } a_item.ImageIndex:= a_item.ImageIndex+1;
end;

procedure Trange_select.TreeView1Collapsed(Sender: TObject;
  Node: TTreeNode);
var a_item:ttreenode;
begin
   a_item:=node;
{   if not a_item.Selected then} a_item.ImageIndex:= a_item.ImageIndex-1;
end;


procedure Trange_select.Button15Click(Sender: TObject);
var i:integer;
begin
 for i:=0 to checklistbox1.Items.Count-1 do
 begin
  checklistbox1.checked[i]:=not  checklistbox1.checked[i];
 end;
end;

procedure Trange_select.Button14Click(Sender: TObject);
var i:integer;
begin
 for i:=0 to checklistbox1.Items.Count-1 do
 begin
    checklistbox1.checked[i]:=false;
 end;
end;


procedure Trange_select.TreeView1Changing(Sender: TObject; Node: TTreeNode;
  var AllowChange: Boolean);
begin
 Allowchange:=false;
end;

function node_selected(node:ttreenode):boolean;
var hnode: ttreenode;
    hit :boolean;
begin
  hit:=false;
  if node.HasChildren then
  begin
    hnode:=node.getfirstchild;
    repeat
    begin
      hit  :=node_selected(hnode);
      hnode:=hnode.getnextsibling;
    end;
    until hit or (hnode=nil);
  end
  else
   begin
    // jetzt aktiviertes Dokument suchen
    while (node<>NIL) and (node.imageindex<>5) do
    begin
      node:=node.GetNextsibling;
    end;
    if (node<>NIL) then hit:= (node.ImageIndex=5);
   end;
  result:=hit;
 end;



procedure Trange_select.TreeView1Collapsing(Sender: TObject;
  Node: TTreeNode; var AllowCollapse: Boolean);

begin
 allowcollapse:= not node_selected(node);
end;

procedure Trange_select.TreeView1MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
 just_expanded:=false;
end;

procedure Trange_select.loesch_btnClick(Sender: TObject);
var del_ok:boolean;
    hnode:ttreenode;
    fname,hstring:string;
    f:file;
    qry:tfdquery;
begin

   //   if a_item.imageindex in [8,9] then
   begin
    { #

    anfragedlg.label1.caption:='The Folder '+cdy_db+' is to be deleted!';
    anfragedlg.showmodal;
    del_ok:=anfragedlg.accept;
    if not del_ok then exit;
     # }

    hstring:= 'The Folder '+cdy_db+' is to be deleted!';
   if application.MessageBox(pwidechar(hstring), 'please confirm',mb_yesno)=id_no then exit;

   qry:=tfdquery.Create(nil);
   qry.Connection:=cdy_uif.dbc;
   // fname:= cdy_uif.cdydpath.text+'\MAS'+cdy_db+'.dbf';
   // if fileexists(fname) then begin    assignfile(f,fname);erase(f);end;
    qry.SQL.Clear;
    qry.SQL.Add('delete from cdy_madat where fname='''+cdy_db+'''');
    qry.ExecSQL;
//    fname:= cdy_uif.cdydpath.text+'\MWE'+cdy_db+'.dbf';
//    if fileexists(fname) then begin    assignfile(f,fname);erase(f);end;
    qry.SQL.Clear;
    qry.SQL.Add('delete from cdy_mvdat where fname='''+cdy_db+'''');
    qry.ExecSQL;

    qry.SQL.Clear;
    qry.SQL.Add('delete from cdy_msdat where fname='''+cdy_db+'''');
    qry.ExecSQL;

    qry.SQL.Clear;
    qry.SQL.Add('delete from cdy_sldat where fname='''+cdy_db+'''');
    qry.ExecSQL;

//        fname:= cdy_uif.cdydpath.text+'\FDA'+cdy_db+'.dbf';
//    if fileexists(fname) then begin    assignfile(f,fname);erase(f);end;
    qry.SQL.Clear;
    qry.SQL.Add('delete from cdy_fxdat where fname='''+cdy_db+'''');
    qry.ExecSQL;

    fname:= cdy_uif.cdydpath.text+'\S__'+cdy_db+'.dbf';
    if fileexists(fname) then begin    assignfile(f,fname);erase(f);end;
    active_item:=nil;
    a_item:=nil;
     formshow(self);
   end;
(*### das entfällt
   // nur FDA-Einträge behandeln !!
   if a_item.imageindex=5 then
   begin
    anfragedlg.label1.caption:='Es werden in der Datenbank '+cdy_db+
                                 ' alle Einträge für SNR='+snr_+
                                 ' und UTLG='+utlg_+
                                 ' in FDA,MAS u. MWE Tabellen gelöscht!';
    anfragedlg.showmodal;
    del_ok:=anfragedlg.accept;
    if del_ok  then
    with cdy_edit.fda_change do
    begin
      // MWE-Einträge Löschen
       sql.clear;
       sql.add('delete from MWE'+cdy_db+'.dbf where SNR='+snr_+' and UTLG='+utlg_);
       execsql;
      // MAS-Einträge Löschen
       sql.clear;
       sql.add('delete from MAS'+cdy_db+'.dbf where SNR='+snr_+' and UTLG='+utlg_);
       execsql;
     // fda-Eintrag Löschen
       sql.clear;
       sql.add('delete from FDA'+cdy_db+'.dbf where SNR='+snr_+' and UTLG='+utlg_);
       execsql;
     // Objekt aus tree entfernen
       hnode:=a_item;
       a_item:=a_item.Parent;
       a_item.Collapse(del_ok);
       hnode.Delete;
     // Editierpaneel verbergen
       pagecontrol1.Hide;
       loesch_btn.enabled:=false;
    end;
  end;
  ###*)
  qry.Free;
end;

procedure Trange_select.find_wetter_stat;
var wstat,wname:string;
    finish:boolean;
    wfile,jfile:tsearchrec;
    l:integer;
procedure check_wett_stat(wfilename:string);
var i:integer;
    jahr,a_jahr:integer;
    _jahr:string;
    ok:boolean;
begin
{
 if uppercase(copy(wfilename,1,3))='WET' then
 begin
  wstat:=wfileName;

  i:=4 ;
  while not( pos(wstat[i],'0123456789')>0 )
  and   ( i<length(wstat)              ) do inc(i);
  if i<length(wstat) then
  begin
  // Wetterdatei gefunden
  wstat:=copy(wstat,4,i-4);
  // alle Dateien für diese Station ermitteln
  findfirst(cdy_uif.cdywpath.text+'\wet'+wstat+'*.dbf',faAnyFile,jfile);
  // Jahr ermitteln
  i:=length(jfile.name)-4;
  wname:=wstat;
  wstat:=jfile.name;
  while ( pos(wstat[i],'0123456789')>0 ) and  ( i>0 ) do dec(i);
  _jahr:=(copy(jfile.name,i+1,length(jfile.name)-4-i));
  jahr:=strtoint(_jahr);
  ok:=false;
  repeat
  if (FindNext(jfile) = 0)
   then begin
         // Jahr ermitteln
         wstat:=jfile.name;
         i:=length(jfile.name)-4;
         while ( pos(wstat[i],'0123456789')>0 ) and  ( i>0 ) do dec(i);
         a_jahr:=strtoint(copy(jfile.name,i+1,length(jfile.name)-4-i));
         if a_jahr>jahr then jahr:=a_jahr;
        end
   else begin FindClose(jfile); ok:=true; end;
 until ok;
                  }

  _jahr:=inttostr(jahr);
  if fda_wett.items.indexof(wname)<0 then fda_wett.Items.Addobject(wname,TOBJECT(jahr));
  //fda_wett.items[fda_wett.items.Count]:='TTT';


end;

begin
//////// select distinct wstat, widx from cdy_cldat
// Wetterstationen suchen
fdc.hqry.Close;
fdc.hqry.sql.Clear;
fdc.hqry.SQL.Add('select distinct wstat from cdy_cldat');
fdc.hqry.Open;
fdc.hqry.First;
repeat
   wname:=trim(fdc.hqry.fieldbyname('wstat').asstring);
   jahr:=0;
  if fda_wett.items.indexof(wname)<0 then fda_wett.Items.Addobject(wname,TOBJECT(jahr));
  fdc.hqry.next;
until fdc.hqry.eof ;
// wstat:= '';
// findfirst(cdy_uif.cdywpath.text+'\wet*.dbf',faAnyFile,wfile);
// check_wett_stat(wfile.name);
(* kill following
 finish:=false;
 repeat
 if (FindNext(wfile) = 0)
   then check_wett_stat(wfile.name)
   else begin FindClose(wfile); finish:=true; end;
 until finish;
 *)
end;

procedure Trange_select.Button6Click(Sender: TObject);
var  id_text:string;
     nnn:integer;
begin
{
    fdc.fdaqry.sql.clear;
    fdc.fdaqry.sql.add('select * from FDA'+cdy_db+'.dbf ');
    fdc.fdaqry.sql.add('where SNR='+snr_+' and UTLG='+utlg_);
    fdc.fdaqry.open;
}
 if not (pagecontrol1.Visible and (pagecontrol1.ActivePageIndex=0)) then
 begin
 exit;
 end;
//:=stringreplace(fda_ltem.text,',','.',[]);
with fdc.fda_update do
begin
  id_text:=copy(a_item.Text,1,pos(':',a_item.Text));
  a_item.Text:=id_text+fda_sbez.Text ;
  sql.clear;
  sql.add('update cdy_fxdat set ');
  sql.add(' SBEZ='+''''+fda_sbez.text+'''');
  sql.add(', STANDORT='+''''+fda_soil.text+'''');
  sql.add(', WETTER='+''''+fda_wett.items[fda_wett.itemindex]+'''');
  sql.add(', IMMISSION='+fda_immi.text);
  sql.add(', LTEM='+stringreplace(fda_ltem.text,',','.',[]));
  sql.add(', NIED='+stringreplace(fda_nied.text,',','.',[]));
  sql.add(', CREP='+stringreplace(fda_crep.text,',','.',[]));
  sql.add(', NLEVEL='+inttostr(fda_nlevel));
  sql.add(', NFK0='+fda_fkap.text);
  sql.add(', GEOBREITE='+stringreplace(fda_geo.text,',','.',[]));
  sql.add(', STARTDAT='+''''+datetostr(fda_start.date)+'''');
  if fdc.fdaqry.fields.findfield('WMZ')<>NIL then   sql.add(', WMZ=0'+stringreplace(fda_wmz.text,',','.',[]));
  if fdc.fdaqry.fields.findfield('STOPDAT')<>NIL
  then  sql.add(', STOPDAT='+''''+datetostr(simstop.date)+'''');
        sql.add(' where SNR='+snr_+' and UTLG='+utlg_+' and fname='''+cdy_db+'''');
end;

 nnn:=0;
 try        // falls die daten nicht vollständig ausgefüllt wurden, gibt es fehlrmeldungen, die so unterdrückt werden
  fdc.fda_update.execsql;
  except; end;

 nnn:=fdc.fda_update.RowsAffected;

 if nnn<>1 then
 begin
 application.MessageBox('no update if identifier, soil, climate or dates are empty','error',mb_ok);
 fdc.fda_update.sql.SaveToFile('fda_update.sql');
 end;
end;


procedure Trange_select.cdy_runClick(Sender: TObject);
var cmd_line,plot:string;
    mw_file,s_file      :string;
    f            :file;
    bf           :textfile;
    bm:Tbookmark;

    candy_canceled:boolean;
    cdyreg:Tregistry;
   {
function switch(s:string):string;
var si:integer;
begin
  si:=pos(s,settings.switches);
  switch:=' '+copy(settings.switches,si,2) ;
end;
    }


      procedure set_simparm;
      var dlg_result,
          z,i,hh,l:integer;
          filename,
          prmstring,
          hstr,hs,
          dpath:string;
        switch_reg :Tregistry;

      begin
      (*
       //go_on:=false;
       dpath:='\';
       if dpath='\' then
       begin
        dpath:=expandfilename('*.*');
        dpath:=copy(dpath,1,pos('*',dpath)-1);
       end;
       // zur Entwurfszeit immer stddir

       dpath:=getcurrentdir;
       prmdlgf.preci_chkbx.Checked:=true;
       msgrq:=true;  {Messagedatei immer schreiben}
       daydruck:=false;
       pendruck:=false;
       dedruck :=false;
       modruck:=false;
       yrdruck:=true;  prmdlgf.cdy_r_type.itemindex:=5;
        *)


       with prmdlgf do
        begin
                 (*
        //  if simparm.random_fert then cdy_rf.text:=floattostr(simparm.fert_std);
          updown1.position:=1 ;
          cdy_zz.text:=updown1.Position.ToString;
         //? cdy_mc.text:=inttostr(simparm.msg_class);
          cdy_pfl.checked :=true;
          cdy_dynsp.checked:=false;
          cdy_wgen.checked:=false;
          cdy_sgen.checked:=false;
          cdy_ss.checked  :=true;
          cdy_wait.checked:=true;
          cdy_gis.checked :=false;

          lys_chkbx.checked:=false;
               *)
          cdydaba.text:=cdy_db;
          cdyplot.text:=plot;
          cdysoil.text:=  fda_soil.text;
          cdywett.text:=fda_wett.text; //items[fda_wett.itemindex];
          cdyanf.date :=fda_start.date;
          n_immi.text :=fda_immi.text;
          cdyend.date :=simstop.date;
          cdy_stcfile.text:='?';
         // cdy_srec.text:=floattostr(simparm.s_recno);
          cdyobj.text :=snr_+utlg_;
        //  cdy_rf.text :='1';
          cdydpath.text     :=cdy_uif.cdydpath.text;
          (*?  ?*)
          cdy_fname.text:='RS_'+cdydaba.Text+cdyplot.Text;

        end;


       end;



begin
button6.Click;




call_candy:=false;
// benutzte Datenbank sortieren
//entfällt sort_table(cdy_db,'MAS','SNR,UTLG,DATUM');
 plot:=snr_+utlg_;
 plot:=copy('_____',1,5-length(plot))+plot;


 prmdlgf.cdy_fname.text:='RS_'+cdy_db;


 set_simparm;  // aktuellen plot übernehmen

 if  prmdlgf.pdata=nil then  new( prmdlgf.pdata);
 prmdlgf.pdata.fda_clevel:=strtofloat(fda_crep.Text);
 prmdlgf.pdata.fda_fkap:=strtofloat(fda_fkap.Text);
 prmdlgf.pdata.fda_nlevel:= db_nlevel.itemindex;
 prmdlgf.pdata.fda_LTEM:=strtofloat(fda_ltem.Text);
 prmdlgf.pdata.fda_nied:=strtofloat(fda_nied.Text);
 // Voraussetzung für abbruchbehandlung
  cdy_reg:=Tregistry.Create;
  try
    cdy_reg.RootKey := HKEY_CURRENT_USER;
    cdy_reg.openkey('\Software\candy', True);
    cdy_reg.writebool('cdy_can',false);
   finally
    cdy_reg.closekey;
    cdy_reg.free;
   inherited;
  end;

  //Messwerte vorbereiten
 if checkbox2.checked then prepare_mwe;


  prmdlgf.init_parmset_selection;
  prmdlgf.showmodal;


  // Nachbereitung
  // wurde das Modell gecanceled ?
  candy_canceled:=true;
  cdy_reg:=Tregistry.Create;
  try
    cdy_reg.RootKey := HKEY_CURRENT_USER;
    cdy_reg.openkey('\Software\candy', True);
    candy_canceled:=cdy_reg.readbool('cdy_can');
   finally
    cdy_reg.closekey;
    cdy_reg.free;
   inherited;
  end;
//?  if not candy_canceled then
  begin
  // FDA-Sicht aktualisieren
  fdc.profiles.Open;
   bm:=fdc.fdaqry.GetBookmark;
   fdc.fdaqry.close;
   fdc.fdaqry.open;
   fdc.fdaqry.GotoBookmark(bm);
   fdc.fdaqry.FreeBookmark(bm);

   fda_soil.keyvalue:= fdc.fdaqry.fieldbyname('STANDORT').asstring;


   a_cdy_item.last_st:=fdc.fdaqry.fieldbyname('STATUSEND').asinteger;
   st_view.filename:=cdy_uif.cdydpath.text+'\S__'+cdy_db+'.stc';
   if fileexists( st_view.filename) then  st_view.Button4.click;
   if checkbox2.Checked  then
   begin
      mw_evaluation;
   end;
  end;


end;

procedure Trange_select.mw_evaluation;
var    m:integer;
begin
    m:= application.MessageBox('launch evaluation module ?','CANDY postprocessing',mb_yesno);
    if m=IDYES then
    begin
 // Table zur ACCESS db moven
                 //htable.databasename:=cdy_uif.cdydpath.text;
                 //htable.tablename:='MW_'+cdy_db+'.dbf';

               //  fdc.htab.databasename:='cdyparm';
               (*****
                 fdc.htab.tablename:='MW_TABLE';
                 fdc.htab.Close;
                 with batchmove1 do
                 begin
                   source:=htable;
               //    destination:=fdc.htab;
                   mode:=batcopy;  // wenn der Fehlr hier kommt, dann ist die Tabelle in access gesperrt
                   execute;
                 end;
                 fdc.htab.Close;
               *****)
                 mw_show.Button2.show;
                 mw_show.fname:= 'MW_'+cdy_db  ;
                 mw_show.Caption:=a_cdy_item^.db_name;
                 mw_show.showmodal;
    end;
end;

procedure Trange_select.Button10Click(Sender: TObject);
var index:integer;
    new_snr:integer;
    new_sbez:string;
    new_item: ttreenode;
begin
{create new database
if a_item.imageindex in [6,7] then
begin
  create_db;
  ACTIVE_ITEM:=NIL;
  a_item:=treeview1.TopItem; }
 // SATZ IN FDA-TABELLE ANHÄNGEN
{   WITH CDY_EDIT.FDA_CHANGE DO
   BEGIN
     SQL.CLEAR;
     SQL.ADD('INSERT INTO FDA'+CDY_DB+'.DBF (SNR,UTLG,SBEZ) VALUES(');
     SQL.ADD('1,0,"NEW")');
     EXECSQL;
   END;
 }

 // exit;
// end;

{ start new item }
  new_snr:=-999;
 if(a_item.imageindex<2)
  then  Begin
         // neue snr bereitstellen
         cdy_db:=a_item.Parent.Text;
         with fdc.hqry do
         begin
           sql.clear;
           sql.add('select max(SNR) as SNR from cdy_FXDAT where fname='''+cdy_db+'''' );
           open;
           first;
           new_snr:=fieldbyname('SNR').asinteger+1;
           close;
          // Satz in fda-tabelle anhängen
           sql.clear;
           sql.add('insert into cdy_FXDAT (fname,SNR,UTLG,SBEZ) VALUES(');
           new_sbez:='new'+floattostr(new_snr) ;
           sql.add(''''+cdy_db+'''' +','+floattostr(new_snr)+',0,'''+new_sbez+''')');
           execsql;
           fda_sbez.text:=new_sbez;
         end;
         // Inhalt updaten
         utlg_:='0';
         snr_:= floattostr(new_snr);
         fdc.profiles.first;
         with fdc.fda_update do
          begin
            sql.clear;
            sql.Add('update   cdy_FXDAT  set ');
            sql.add(' STANDORT='+''''+fdc.profiles.fieldbyname('NAME').asstring+'''');
            sql.add(', WETTER='+''''+fda_wett.items[0]+'''');
            sql.add(', IMMISSION=50');
            sql.add(', LTEM=10');
            sql.add(', NIED=500');
            sql.add(', CREP=9');
            sql.add(', NLEVEL=3');
            sql.add(', NFK0=100');
            sql.add(', GEOBREITE=51');
            sql.add(', STARTDAT='+''''+datetostr(fda_start.date)+'''');
           if fdc.fdaqry.fields.findfield('WMZ')<>NIL then   sql.add(', WMZ=35');
            sql.add(' where fname='''+cdy_db+''' and  SNR='+snr_+' and UTLG='+utlg_);
            execsql;
           end;


         // create new object
         new_item:=treeview1.Items.addchild(a_item,'neu');
         new_item.ImageIndex   :=4;
         new_item.selectedIndex:=5;
         new_item.Selected  :=true;
         new(a_cdy_item);
         new_item.data      :=a_cdy_item;
         a_cdy_item^.db_name:=cdy_db;
         a_cdy_item^.soil_id:='?';
         a_cdy_item^.wett_id:='?';
         a_cdy_item^.snr:=new_snr;
         a_cdy_item^.utlg:=0;
         a_cdy_item^.first_st:=-1;
         a_cdy_item^.last_st:=-1;
         a_cdy_item^.last_day:=0;
         a_cdy_item^.first_day:=0;
         plot:=floattostr(new_snr)+'0';
         a_cdy_item^.plot_id:=copy('_____',1,5-length(plot))+plot;
         plot:=a_cdy_item^.plot_id;
         plot:=plot+': '+ new_sbez;
         new_item.text:=plot;
         a_item:=new_item;

         // Satz für edit in basic-info bereitstellen
        end;

end;



procedure Trange_select.RadioButton3Click(Sender: TObject);
begin
 radiobutton3.checked:=true;
 radiobutton4.checked:=false;
 mwupdt.caption:='insert' ;
end;

procedure Trange_select.RadioButton4Click(Sender: TObject);
begin
 radiobutton4.checked:=true;
 radiobutton3.checked:=false;
 mwupdt.caption:='update';
end;

procedure Trange_select.DBGrid2KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var taste:word;
    rdate:tdate;
    amixcode:string;
begin
  taste:=key;
  if taste=46 then
  with fdc.any_update do
  begin
   // aktuellen Satz löschen
   sql.Clear;
   sql.add('delete from MWE'+cdy_db +'.dbf  where SNR='+snr_+' and UTLG=' +utlg_);
   sql.add(' and DATUM='''+old_mwdate+'''');
   sql.add(' and M_IX='+old_mix);
   sql.add(' and M_WERT='+old_mw);
   sql.add(' and S0='+old_s0);
   sql.add(' and S1='+old_s1);
   execsql;

   fdc.mweqry.first;
   fdc.mweqry.refresh;
  end;
end;

procedure Trange_select.fda_wettChange(Sender: TObject);
var last_year,
    wfile,test    :string;
    i,h,j:integer;
begin
    // stop date
(* soll letzten mögliches rechentermin ermitteln

   i:= integer(fda_wett.items.objects[fda_wett.itemindex]);
   last_year:=inttostr(i);

   wfile:='wet'+fda_wett.items[fda_wett.itemindex]+last_year+'.dbf';
   hquery.close;
   hquery.sql.clear;
   hquery.databasename:= cdy_uif.cdywpath.text;
   hquery.sql.add('select max(DATUM) as stopdate from '+wfile+' where NIED>=0');
if fileexists( cdy_uif.cdywpath.text+'\'+wfile ) then
begin
   hquery.open;
   hquery.first;
   test:= hquery.fieldbyname('stopdate').asstring;
   if length(test)>0 then
   begin
   val(test[1],j,h);
   if h=0 then simstop.date:=hquery.fieldbyname('stopdate').asdatetime
                               else
                               begin
                                  simstop.date:=strtodate('31.12.'+last_year);
                               end;
  end;
end;
*)
end;

procedure Trange_select.TreeView1EndDrag(Sender, Target: TObject; X,
  Y: Integer);
  var d_item:ttreenode;
      id_TEXT:string;
      recnum:integer;
//      cdy_data:Pcdy_item;


begin
if not draging then exit;

draging:=false;
if target=treeview1 then
begin
  try
   d_item:=treeview1.getnodeat(x,y);
  except exit; end;
  end;
 if d_item=nil then Exit;

   if d_item.imageindex=4 then
   begin
     d_db:=Pcdy_item(d_item.data)^.db_name;
     d_snr := floattostr(Pcdy_item(d_item.data)^.snr);
     d_utlg:= floattostr(Pcdy_item(d_item.data)^.utlg);

if pagecontrol1.ActivePageIndex=0 then
begin
    with fdc.fda_update do
    begin
    id_text:=copy(d_item.Text,1,pos(':',d_item.Text));
    d_item.Text:=id_text+fda_sbez.Text ;
    sql.clear;
    sql.Add('update   cdy_fxdat   set ');
    sql.add(' SBEZ='+''''+fda_sbez.text+'''');
    sql.add(', STANDORT='+''''+fda_soil.text+'''');
    sql.add(', WETTER='+''''+fda_wett.items[fda_wett.itemindex]+'''');
    sql.add(', IMMISSION='+fda_immi.text);
    sql.add(', LTEM='+stringreplace(fda_ltem.text,',','.',[]));
    sql.add(', NIED='+stringreplace(fda_nied.text,',','.',[]));
    sql.add(', CREP='+stringreplace(fda_crep.text,',','.',[]));
    sql.add(', NLEVEL='+inttostr(fda_nlevel));
    sql.add(', NFK0='+fda_fkap.text);
    sql.add(', GEOBREITE='+stringreplace(fda_geo.text,',','.',[]));
    sql.add(', STARTDAT='+''''+datetostr(fda_start.date)+'''');
    if fdc.fdaqry.fields.findfield('WMZ')<>NIL then   sql.add(', WMZ='+fda_wmz.text);
    if fdc.fdaqry.fields.findfield('STOPDAT')<>NIL then   sql.add(', STOPDAT='+''''+datetostr(simstop.date)+'''');
    sql.add(' where SNR='+d_snr+' and UTLG='+d_utlg +' and FNAME='+''''+d_db+'''');
    execsql;
    end;
end;


if pagecontrol1.ActivePageIndex=1 then
begin
// Massnahmen transportieren
 with fdc.fda_update do
 begin
 sql.clear;
 sql.Add(' insert into cdy_madat  ( SNR , UTLG , FNAME, DATUM, MACODE, WERT1, WERT2, ORIGWERT, REIN ) ');
 sql.Add(' SELECT '+ D_SNR+' AS snr_neu,'+ D_UTLG+' AS UTLG_NEU,'+''''+ d_DB+''''+' AS FNAME_NEU, DATUM, MACODE, WERT1, WERT2, ORIGWERT, REIN ');
 sql.Add(' from cdy_madat  WHERE SNR='+S_snr+' AND UTLG='+s_utlg+' and fname='+''''+s_db+''''  );
 execsql;
 recnum:= RowsAffected;
 end;
end;

if pagecontrol1.ActivePageIndex=2 then
begin
//Messwerte transportieren
 with fdc.fda_update do
 begin
 sql.clear;
// sql.Add(' insert into cdy_mvdat  ( SNR , UTLG , FNAME, [DATUM], M_IX, [S0], [S1], M_WERT, variation, anzahl, s_wert, korrektur, [first] ) ');
// sql.Add(' SELECT '+ D_SNR+' AS snr_neu,'+ D_UTLG+' AS UTLG_NEU,'+ '"'+ d_DB+'"'+' AS FNAME_NEU, DATUM, M_IX, S0, S1, M_WERT, variation, anzahl, s_wert, korrektur, first ');

 sql.Add(' insert into cdy_mvdat  ( SNR , UTLG , FNAME,  DATUM , M_IX, S0, S1, M_WERT,  korrektur  ) ');
 sql.Add(' SELECT '+ D_SNR+' AS snr_neu,'+ D_UTLG+' AS UTLG_NEU,'+ ''''+ d_DB+''''+' AS FNAME_NEU, DATUM, M_IX, S0, S1, M_WERT, korrektur ');
 sql.Add(' from cdy_mvdat  WHERE fname='+''''+ s_db+ '''' +' AND UTLG='+s_utlg+' and SNR='+S_snr   );
 execsql;
 recnum:= RowsAffected;
 end;
end;

ShowMessage(IntToStr(recnum) + ' records transfered');
end;
end;

procedure Trange_select.TreeView1StartDrag(Sender: TObject;
  var DragObject: TDragObject);
begin
   draging:=false;
   if active_item=nil then exit;
   if active_item.imageIndex=5 then
   begin
        draging:=true;
        s_db  :=a_cdy_item^.db_name;
        s_snr :=floattostr(a_cdy_item^.snr);
        s_utlg:=floattostr(a_cdy_item^.utlg);
   end;
end;

procedure Trange_select.TreeView1DragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
  var d_item:ttreenode;
      d_snr:string;
begin
  if y<0 then
        TreeView1.Perform( WM_VSCROLL, SB_LINEUP, 0 );
  if (treeview1.Height-y)<5 then
        TreeView1.Perform( WM_VSCROLL, SB_LINEdown, 0 );


   d_item:=treeview1.getnodeat(x,y);
   if d_item<>NIL then accept:=( d_item.imageindex=4) and (pagecontrol1.ActivePageIndex in [0,1,2])

end;

procedure Trange_select.Button3Click(Sender: TObject);
begin
      //#   mw_show.fname:='MWE'+a_cdy_item^.db_name+'.dbf';
         mw_show.Caption:=a_cdy_item^.db_name;
        // Table zur ACCESS db moven
    //    fdc.htab.databasename:='cdyparm';
    (**#
        htable.databasename:=cdy_uif.cdydpath.text;
        htable.tablename:=mw_show.fname;
        fdc.htab.tablename:='MW_TABLE';
        fdc.htab.Close;
        with batchmove1 do
                 begin
                   source:=htable;
      //             destination:=fdc.htab;
                   mode:=batcopy;
                   execute;
                 end;
       #**)
        fdc.htab.Close;
        mw_show.button2.hide;
        mw_show.DBLookupComboBox2.keyvalue:=10*a_cdy_item^.snr+a_cdy_item^.utlg;
        mw_show.DBLookupComboBox2CloseUp(self);
        mw_show.showmodal;

 end;
{
procedure Trange_select.createMW_files(db:string);
var s_file,d_file,p,s:string;
begin
überfl
 p:=cdy_uif.cdydpath.text;//quellpfad
 s:=cdy_uif.cdy_p_path;   //sourcepfad
 s_file:=s+'\MESSWERT.STR';  d_file:=p+'\MWE'+db+'.DBF';
 copyfile(pchar(s_file),pchar(d_file),false);
 s_file:=s+'\MESSWERT.STR';  d_file:=p+'\MW_'+db+'.DBF';
 copyfile(pchar(s_file),pchar(d_file),false);

end;
    }
procedure Trange_select.create_db;
var s_file,d_file,p,s, newsnr:string;
begin
 // new database
 fget_db_name.showmodal;
 cdy_db:= leftstr(fget_db_name.db_name.text+'______',5);

 // insert into cdy_fxdat

         with fdc.hqry do
         begin
           sql.clear;
           sql.add('select max(SNR)+1 as SNR from cdy_FXDAT where fname='''+cdy_db+'''' );
           open;
           first;
           try newsnr:=fdc.hqry.fieldbyname('SNR').AsString
           except  {   else } newsnr:='1'; end;
            close;
            if length(newsnr)=0 then newsnr:='1';

          // Satz in fda-tabelle anhängen
           sql.clear;
           sql.add('insert into cdy_FXDAT (fname,SNR,UTLG,SBEZ) VALUES(');
           sql.add(''''+cdy_db+''','+newsnr+',0,'''+'neu'+''')');
           execsql;
           fda_sbez.text:='1';
         end;
         // Inhalt updaten
         utlg_:='0';
         snr_:= '1';

         fdc.fdaqry.close;
         fdc.fdaqry.sql.clear;
         fdc.fdaqry.sql.add('select * from cdy_fxdat');
         fdc.fdaqry.Open;
         fdc.profiles.first;
         with fdc.fda_update do
          begin
            sql.clear;
            sql.Add('update   cdy_FXDAT  set ');
            sql.add(' STANDORT='+''''+fdc.profiles.fieldbyname('NAME').asstring+'''');
            sql.add(', WETTER='+''''+fda_wett.items[0]+'''');
            sql.add(', IMMISSION=50');
            sql.add(', LTEM=10');
            sql.add(', NIED=500');
            sql.add(', CREP=9');
            sql.add(', NLEVEL=3');
            sql.add(', NFK0=100');
            sql.add(', GEOBREITE=51');
            sql.add(', STARTDAT='+''''+datetostr(fda_start.date)+'''');
            if fdc.fdaqry.fields.findfield('WMZ')<>NIL then   sql.add(', WMZ=35');
            sql.add(' where fname='''+cdy_db+''' and  SNR='+snr_+' and UTLG='+utlg_);
            execsql;
           end;
         fdc.fdaqry.close;

 formshow(self);
end;

procedure Trange_select.any_chkClick(Sender: TObject);
begin
    fdc.masqry.sql.clear;
    fdc.masqry.sql.add('select key, SNR,UTLG, DATUM, MACODE,WERT1,WERT2,ORIGWERT,REIN from cdy_madat where fname='''+cdy_db+'''');
    fdc.masqry.sql.add(' and ( macode=99');
    if mf_chk.checked then fdc.masqry.sql.add(' or macode=4 ');
    if tl_chk.checked then fdc.masqry.sql.add(' or macode in (0,5) ');
    if oa_chk.checked then fdc.masqry.sql.add(' or macode=3 ');
    if ir_chk.checked then fdc.masqry.sql.add(' or macode=7 ');
    if ac_chk.checked then fdc.masqry.sql.add(' or macode=8 ');
    if gr_chk.checked then fdc.masqry.sql.add(' or macode in (6,10,11) ');
    if crp_chk.checked then fdc.masqry.sql.add(' or macode in (0,1,2,6,9,12) ');
    fdc.masqry.sql.add(' ) and snr='+snr_+' and utlg='+utlg_+' order by DATUM,MACODE');
    fdc.masqry.open;
end;

procedure Trange_select.Button7Click(Sender: TObject);
var s:sysstat;
    rnr,h:integer;
    st_name,plot:string;
    wmz:real;
begin
button6.click;
(*** erst mal noch nicht
var_init(   cdy_UIF.cdydpath.text+'\sysdat\',1);
plot:=snr_+utlg_;
plot:=copy('_____',1,5-length(plot))+plot;
{profil aufbauen !!}
  new(sprfl,init(cdy_UIF.cdydpath.text+'\sysdat\',fda_soil.text,1,false,true,'*'));
  {OS-Einstellen}
  val(fda_wmz.text,wmz,h);
  cums_init(wmz,strtofloat(fda_nied.text),strtofloat( fda_ltem.text),strtofloat(fda_crep.text),sprfl, s,false);
  if h<>0 then
  begin
   fda_wmz.Text:=floattostr(wmz);
   with fda_update do
   if fdc.fdaqry.fields.findfield('WMZ')<>NIL then
   begin
    sql.clear;
  {  sql.Add(' update   FDA'+cdy_db+'.dbf  set WMZ='+stringreplace(fda_wmz.text,',','.',[]));
    sql.add(' where SNR='+snr_+' and UTLG='+utlg_);}
    sql.add(' update cdy_fxdat  SET WMZ='+stringreplace(fda_wmz.text,',','.',[]));
    sql.add(' where SNR='+snr_+' and UTLG='+utlg_+' and fname="'+cdy_db+'"');
    execsql;
   end;
  end;
 {Temperatur und Feuchte anpassen}
  temp_init(0,strtofloat( fda_ltem.text),datetostr(fda_start.date),s);
  moist_init(strtofloat( fda_fkap.text)/100,sprfl,s,'?was soll hier stehen?');
  {Stickstoff einstellen}
  nmin_init( fda_nlevel,sprfl,s);
  allg_init(datetostr(fda_start.date),plot,sprfl,s);
 {Status in Catalog schreiben !}
  st_name:=cdy_UIF.cdydpath.text+'\S__'+cdy_db+'.stc';
  if not fileexists(st_name)
   then
     begin  {Datei nicht vorhanden}
      stc_create(st_name);
     end;
  rnr:=-1;  {new branch}
  status_schreiben(st_name,s.ks,rnr);
  //update fda

  with fdc.hqry do
  begin
   close;
   sql.clear;
   sql.add(' update cdy_fxdat  SET STATUSANF='+inttostr(rnr));
   sql.add(' ,STATUSEND='+inttostr(rnr));
   sql.add(' where SNR='+snr_+' and UTLG='+utlg_+' and fname="'+cdy_db+'"');
   execsql;
  end;
  a_cdy_item.last_st:=rnr;
  a_cdy_item.first_st:=rnr;

  **)

end;




procedure Trange_select.click_on_item(db_name,I_text:string; exact_match:boolean);
var hitem:ttreenode;
function match(s1,s2:string;ex_mode:boolean):boolean;
var ok:boolean;
    i:integer;
begin

   if ex_mode then ok:=(s1=s2)
              else begin
                     i:=pos(s2,s1);
                     ok:=(i>0)
                   end;
  match:=ok;
end;
begin
  hitem:=treeview1.items.getfirstnode;
  // suche database
  db_name:=uppercase(db_name);
  while (hitem<>nil)
  and not match(uppercase(hitem.text),db_name,true) do hitem:=hitem.GetNext;

  if hitem<>nil then hitem.expand(true); // db gefunden
  // suche schlag
  while (hitem<>nil )
  and not match(hitem.text,I_text,exact_match)
   do hitem:=hitem.getnext;
   if hitem<>nil then
   begin
   if a_item<>NIL then a_item.stateindex:=-1;
   a_item:=hitem;
   a_item.Expand(true);
   gis_call:=true;
   item_click([ssleft]);
   gis_call:=false;
   end;

end;

procedure Trange_select.Button2Click(Sender: TObject);
var p,s_file,d_file:string;
     mr:integer;
begin
{
p:=cdy_uif.cdydpath.text;
if not fileexists(p+'\MMH'+cdy_db+'.dbf')   then
begin
 s_file:='MMH.STR';  d_file:=p+'\MMH'+cdy_db+'.DBF';
 copyfile(pchar(s_file),pchar(d_file),false);
end;
   fmmh.croplist.open;
   fmmh.omlist.open;

 fmmh.mmh_crop.tablename:='MMH'+cdy_db+'.dbf';
 fmmh.mmh_crop.DatabaseName:=p;
 fmmh.mmh_crop.open;
 fmmh.mmh_om.tablename:='MMH'+cdy_db+'.dbf';
 fmmh.mmh_om.open;
 mr:=fmmh.showmodal;
 fmmh.mmh_crop.close;
 fmmh.mmh_om.close;
 if mr=10 then
 begin
 fda_crep.text:=floattostr(round( 10*( fmmh.cr_crop+fmmh.cr_om))/10);
 with fda_update do
 begin
  sql.clear;
  sql.Add('update   FDA'+cdy_db+'.dbf  set ');
  sql.add(' CREP='+stringreplace(fda_crep.text,',','.',[]));
  if fdc.fdaqry.fields.findfield('WMZ')<>NIL then   sql.add(', WMZ='+fda_wmz.text);
  sql.add(' where SNR='+snr_+' and UTLG='+utlg_);
  execsql;
 end;
 end;
 }
end;

procedure Trange_select.TabSheet1Exit(Sender: TObject);
begin
button6.Click;
end;

procedure Trange_select.TabSheet2Enter(Sender: TObject);
begin
 if not fdc.crops.Active then fdc.crops.open;
  if not fdc.opspa.Active then fdc.opspa.open;
   if not fdc.fert.Active then fdc.fert.open;
end;

procedure Trange_select.DBGrid1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
  var aname:string;
  begin
   { aname:=sender.ClassName;
    label1.caption:=aname;}
    //application.processmessages;
end;

procedure Trange_select.DBGrid1MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
  var aname:string;
  begin
  {
    aname:=sender.ClassName;
    dbgrid1.
    label1.caption:=aname;
   }
end;

procedure Trange_select.DBGrid1CellClick(Column: TColumn);

  begin
   if column.FieldName='ORIGWERT' then edit1.SetFocus;


end;

procedure Trange_select.TabSheet2Exit(Sender: TObject);
begin
{
    fdc.masqry.sql.clear;
    fdc.masqry.sql.add('select DATUM, MACODE,WERT1,WERT2,ORIGWERT from MAS'+cdy_db+'.dbf ');
    fdc.masqry.sql.add(' order by SNR,UTLG, DATUM,MACODE');
    fdc.masqry.open;
     htable.tablename:= MAS'+cdy_db+'.dbf ';
     batchmove1.source:=fdc.masqry;
     batchmove1.execute;
    fdc.masqry.sql.clear;
    fdc.masqry.sql.add('select DATUM, MACODE,WERT1,WERT2,ORIGWERT from MAS'+cdy_db+'.dbf ');
    fdc.masqry.sql.add('where snr='+snr_+' and utlg='+utlg_+' order by DATUM,MACODE');
    fdc.masqry.open;
}
end;

procedure Trange_select.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
//? write_reg_ss('cdy_db','');
end;

procedure Trange_select.Button4Click(Sender: TObject);
var _snr_,_utlg_,_sbez_:string;
{
 my_rep:travereport;
 my_page:travepage;
 my_text:travetext;
 }
 begin
  //cdy_edit.
  fdc.frxmarep.PrepareReport(true);
  //cdy_edit.
  fdc.frxmarep.ShowReport(true);
 {
 rvproject1.SelectReport('management',true);
 my_rep :=travereport( rvproject1.projman.FindRaveComponent('management',nil));
 my_page:=travepage  ( rvproject1.projman.FindRaveComponent('MainPage',my_rep));
 my_text:=travetext  ( rvproject1.projman.FindRaveComponent('Text2',my_page) );
 my_text.Text:='plot '+fda_sbez.Text+' in folder '+a_cdy_item.db_name+' !' ;
 rvproject1.open;
 rvproject1.ProjectFile:= 'cdy_rprt_2010.rav' ;
  }
  {
  // if no_preview_mnd.checked  then
 begin
 RvSystem1.DefaultDest := rdFile;
 RvSystem1.DoNativeOutput := false;
 RvSystem1.RenderObject := RvRenderPDF1;
 RvSystem1.OutputFileName :=a_cdy_item.db_name+'_'+fda_sbez.Text+'_man.pdf';
 RvSystem1.SystemSetups := RvSystem1.SystemSetups - [ssAllowSetup];
 end  ;
   }
//  rvproject1.ExecuteReport('management');

end;

procedure Trange_select.Button8Click(Sender: TObject);
var mybm:tbookmark;
    a_key:longint;
begin
// alternative: key ermitteln
//  FNAME;SNR;UTLG;DATUM;MACODE;WERT1;WERT2;ORIGWERT

// a_key:=fdc.masqry.fieldbyname('key').asinteger;


//  with fdc {cdy_edit} do
  begin
  mybm:=fdc.masqry.GetBookmark;
  fdc.htab.TableName:='cdy_MAdat';
  fdc.htab.Open;

 if fdc.htab.locate ('key',fdc.masqrykey.Value,[])
{
  if table1.Locate('FNAME;SNR;UTLG;DATUM;MACODE;WERT1;WERT2;ORIGWERT',
     vararrayof([cdy_db,mas_sqlSNR.Value,mas_sqlUTLG.Value,
               mas_sqlDATUM.Value,mas_sqlMACODE.Value,
               mas_sqlWERT1.Value,mas_sqlWERT2.Value,mas_sqlORIGWERT.Value]),[])
 }
  then
    begin
     fdc.masqry.close;
     fdc.htab.Delete;
    end;
  fdc.htab.close;
  fdc.masqry.open;
  fdc.masqry.GotoBookmark(mybm);
  fdc.masqry.FreeBookmark(mybm);
  //fdc.masqry.Locate('DATUM',datetimepicker1.date,[]);
  end;
end;

procedure Trange_select.Button9Click(Sender: TObject);
var          t,t1,t2:tdatetime;
             snr,c_line,obj,f:string;
             ok:boolean;
           //  hqr:tadoquery;
             tablist:tstrings;
begin
(******************************* ist jetzt überflüssig, da group-mode bereits in der datenbank arbeitet
tablist:=tstringlist.Create;
 fdc.fdaqry.sql.clear;
 fdc.fdaqry.sql.add('select * from cdy_FxDat where fname="'+cdy_db+'" ');
 //fdc.fdaqry.sql.add('where SNR='+snr_+' and UTLG='+utlg_);
 fdc.fdaqry.open;
 fdc.fdaqry.first;
 // Anfang und ende
// sc_start.DateTime
t1:= fdc.fdaqry.fieldbyname('STARTDAT').AsDateTime;
 if  fdc.fdaqry.Fields.findfield('STOPDAT')<>NIL then
// sc_stop.DateTime
t2:= fdc.fdaqry.fieldbyname('STOPDAT').AsDateTime;
//#   frm_cdy_region2.checklistbox1.Clear;
 while not fdc.fdaqry.eof do
 begin
 //   checklistbox1.Items.add(
 {
 c_line:=  'Plot '+
   fdc.fdaqry.fieldbyname('SNR').asstring+
   fdc.fdaqry.fieldbyname('UTLG').asstring +': '+
    fdc.fdaqry.fieldbyname('SBEZ').asstring;
 //test anf
  }
     t:=fdc.fdaqry.FieldByName('STARTDAT').AsDateTime;
      if t>t1 then t1:=t;
      t:=fdc.fdaqry.FieldByName('STOPDAT').AsDateTime;
      if t<t2 then t2:=t;

       obj:= fdc.fdaqry.fieldbyname('SNR').asstring
                   +fdc.fdaqry.fieldbyname('UTLG').asstring;
       snr:='_____'+fdc.fdaqry.fieldbyname('SNR').asstring
                   +fdc.fdaqry.fieldbyname('UTLG').asstring;
       snr:=RightStr(snr,5);
      c_line:=' '    ;
       c_line:=c_line+' S='+snr;
       c_line:=c_line+' P='+fdc.fdaqry.fieldbyname('STANDORT').asstring;
       c_line:=c_line+' W='+fdc.fdaqry.fieldbyname('WETTER').asstring;
       c_line:=c_line+' D='+cdy_db+' O='+obj;

 //#      frm_cdy_region2.CheckListBox1.items.Add(c_line);

 // test end
   fdc.fdaqry.next;
 end;
 fdc.fdaqry.close;
 // test anf2
{
 frm_cdy_region2.sc_start.Date:=t1;
 frm_cdy_region2.sc_stop.Date:=t2;
 FRM_CDY_region2.edit3.text:='sim_result'; // sinnvoll ?
 }
//Datenbank erzeugen !!!!
cdy_uif.ado_cdyprm.GetTableNames(tablist);
//#if tablist.IndexOf( FRM_CDY_region2.edit3.text) >0 then
begin
  // tabelle vorhanden
end;
//# else
begin
// neue Tabelle anlegen
hqr:=tadoquery.Create(nil);
hqr.Connection:=fdc.fdaqry.Connection;
//hqr.SQL.Add('create table '+ FRM_CDY_region2.edit3.text+'( ID Autoincrement ,DATUM DateTime, MERKMAL_ID Integer, OBJEKT_ID integer, WERT float )');   //? feldliste
hqr.ExecSQL;
hqr.Free;
end;



   {
   FRM_CDY_region2.Edit4.Text:= FRM_CDY_region2.edit3.text;
   frm_cdy_region2.PageControl1.ActivePage:=frm_cdy_region2.TabSheet1;
   frm_cdy_region2.gis_mode:=false;
   frm_cdy_region2.show;
   }
 // test end2
    ********************************************************************)
end;

procedure Trange_select.Button11Click(Sender: TObject);
begin
 sel_res_frm.show;
end;

procedure Trange_select.Button13Click(Sender: TObject);
var i:integer;
begin
 for i:=0 to checklistbox1.Items.Count-1 do
 begin
    checklistbox1.checked[i]:=true;
 end;
end;

procedure Trange_select.Button12Click(Sender: TObject);
var cmd_line,plot,hstr,tabname  :string;
    m_file,s_file,saveas ,snr,utlg,fname     :string;
    f            :file;
    bf           :textfile;
    i,j,k:integer;
    bm:tbookmark;
    hqry:tfdquery;
begin

 // Szenario-Modus
 // batch file vorbereiten
 assignfile(bf,cdy_uif.cdydpath.text+'\SZERUN.BAT');
 rewrite(bf);

//Festdaten öffnen
 fdc.fdaqry.sql.clear;
 fdc.fdaqry.sql.add('select * from CDY_FxDat where fname='''+cdy_db+'''');
 fdc.fdaqry.open;
 fdc.fdaqry.first;

 call_candy:=false;
// benutzte Datenbank sortieren  (entfällt das im ado mode ?
// sort_table(cdy_db,'MAS','SNR,UTLG,DATUM');
hqry:=tfdquery.Create(nil);
 hqry.Connection:=cdy_uif.dbc;
// alle Items abarbeiten
for i:=0 to checklistbox1.items.count-1 do
if checklistbox1.Checked[i] then
begin
tabname:=res_file.text;
plot:=copy( checklistbox1.Items[i],pos(':',checklistbox1.Items[i])+2,length(checklistbox1.Items[i]));
if trim(tabname)='*' then tabname:=plot;
 fdc.fdaqry.locate('SBEZ',variant(plot),[]);
 plot:= fdc.fdaqry.fieldbyname('SNR').asstring+ fdc.fdaqry.fieldbyname('UTLG').asstring;
 plot:=copy('_____',1,5-length(plot))+plot;
 cmd_line:='A='+datetostr(sc_start.date) + ' E='+datetostr(sc_stop.date);
 cmd_line:=cmd_line+' D='+cdy_db+' S='+plot
                   +' P='+ fdc.fdaqry.fieldbyname('STANDORT').asstring
                   +' W='+ fdc.fdaqry.fieldbyname('WETTER').asstring;
 cmd_line:=cmd_line+' DP='+cdy_uif.cdydpath.text ;
 cmd_line:=cmd_line+' W- P-' ;
 if cdy_sgen.Checked  then   cmd_line:=cmd_line+' S+';
 if cdy_ss.Checked    then   cmd_line:=cmd_line+' SS';
 if lys_chkbx.Checked then   cmd_line:=cmd_line+' L+';
 if p_korr.Checked    then   cmd_line:=cmd_line+' K+'
                      else   cmd_line:=cmd_line+' K-';
 if cdy_of.ItemIndex>0 then
 begin
  case cdy_of.ItemIndex of
  1: hstr:=' OF=1';
  2: hstr:=' OF=5';
  3: hstr:=' OF=10';
  4: hstr:=' OF=30';
  5: hstr:=' OF=300';
  end;
  hstr:= hstr  +' R='+tabname   ;
  cmd_line:=cmd_line+hstr;
 end;
 cmd_line:= cdy_uif.cdy_p_path+'CDY20_UIF '+cmd_line+' '+add_prm.text+' GO ! ';
 Chartooem(PChar(cmd_line), buf ); writeln(bf,buf);

 if checkbox6.checked then
 begin //Messwerte vorbereitenin
  snr :=fdc.fdaqry.FieldByName('snr').AsString;
  utlg:=fdc.fdaqry.FieldByName('utlg').AsString;
  fname:=fdc.fdaqry.FieldByName('fname').AsString;
  hqry.SQL.Clear;
  hqry.SQL.add('delete from cdy_msdat  where SNR='+snr+' and UTLG='+UTLG+' and fname='''+fname+'''');
  hqry.ExecSQL;
  hqry.sql.clear;
  hqry.SQL.add('insert into cdy_msdat  select fname,snr,utlg,datum,m_ix,s0,s1,m_wert,korrektur, ');
  hqry.SQL.add(' fname+str( SNR*10+UTLG)+str( DATUM)+str(  M_IX)+str(S0) +str(S1)+korrektur as ix ');
  hqry.SQL.add(' from cdy_mvdat where  SNR='+snr+' and UTLG='+utlg+' and fname='''+fname+'''');
  hqry.ExecSQL;
  hqry.sql.clear;
  hqry.SQL.add('update cdy_msdat set S_WERT=-99  where SNR='+snr+' and UTLG='+utlg+' and fname='''+fname+'''');
  hqry.ExecSQL;
  hqry.sql.clear;
 end;

end;  // nächsten Eintrag
Flush(bf);  { Sicherstellen, daß der Text tatsächlich in die Datei geschrieben wird. }
closeFile(bf);
call_candy:=true;
hqry.Free;

 // Modell aufrufen
  reset(bf);
  if call_candy then repeat
  readln( bf,  cmd_line);
    // cdymain.batch_line:=cmd_line;
    // cdymain.show;
    // cdymain.do_it;
    application.MessageBox('bau','stelle',mb_ok);
     i:=pos('S=',cmd_line)+2;
     j:=pos('P=',cmd_line)-i;
     plot:=copy(cmd_line,i,j);
     copyfile(pwidechar(cdy_uif.cdydpath.text+'\CANDYMSG.msg '),pwidechar(cdy_uif.cdydpath.text+'\'+cdy_db+plot+'.msg'),false);
  until eof(bf) ;

 closefile(bf);

  // mögliche Nachbereitung
  // wurde das Modell gecanceled ?
(* vorläufig unberücksichtigt
  candy_canceled:=true;
  cdy_reg:=Tregistry.Create;
  try
    cdy_reg.RootKey := HKEY_CURRENT_USER;
    cdy_reg.openkey('\Software\candy', True);
    candy_canceled:=cdy_reg.readbool('cdy_can');
   finally
    cdy_reg.closekey;
    cdy_reg.free;
   inherited;
  end;
  if not candy_canceled then
  begin
    ....
  end;
  *)

 (****************** das passt hier nicht richtig ****************************************
  // Nachbereitung
// FDA-Sicht aktualisieren
   bm:=fdc.fdaqry.GetBookmark;
   fdc.fdaqry.close;
   fdc.fdaqry.open;
   fdc.fdaqry.GotoBookmark(bm);
   fdc.fdaqry.FreeBookmark(bm);
   a_cdy_item.last_st:=fdc.fdaqry.fieldbyname('STATUSEND').asinteger;


  st_view.filename:=cdy_uif.cdydpath.text+'\S__'+cdy_db+'.stc';
  if fileexists( st_view.filename) then  st_view.Button4.click;

   mw_evaluation;

  ****************** das passt hier nicht richtig ****************************************)

{ noch nicht freigegeben:
 if not cdy_sgen.Checked then
 begin
  frm_sze_stat.fda_name:='FDA'+cdy_db+'.dbf ';
  frm_sze_stat.show;
 end;
}
end;

procedure Trange_select.Button16Click(Sender: TObject);
var wmz:real;
    h:integer;
    wmz_:string;
    bm:tbookmark;
begin
 button6.click;
// Prognose-Starten
(** nicht mehr da

  bm:=fdc.fdaqry.getbookmark;
  fdc.fdaqry.close;
  fdc.fdaqry.open;
  fdc.fdaqry.GotoBookmark(bm);
  fdc.fdaqry.freeBookmark(bm);
  cndprogf.label1.caption:=cdy_db+': '+fda_sbez.text;
  cndprogf.a_schlagbez:= fda_sbez.text;
  cndprogf.a_profile:= fda_soil.Text;
  cndprogf.a_rest:=60;
  cndprogf.edit1.Text:='60';
  cndprogf.a_daba:=cdy_db;
  wmz_:=stringreplace(fda_wmz.Text,',','.',[]);
  val(wmz_,wmz,h);
  if h<>0 then
  begin
   var_init(   cdy_UIF.cdydpath.text+'\sysdat\');
   new(sprfl,init(cdy_UIF.cdydpath.text+'\sysdat\',fda_soil.text,1,false,false,'*'));
   wmz:=w_m_z(sprfl^.fat[1],strtofloat(fda_nied.text),strtofloat( fda_ltem.text));
   dispose(sprfl,done);
  end;
  cndprogf.a_wmz :=wmz;
  cndprogf.a_recno:=    fdc.fdaqry.fieldbyname('STATUSEND').asinteger;
  cndprogf.a_immission:=fdc.fdaqry.FieldByName('immission').asfloat;
  //a_cdy_item.last_st;  // letzter Statussatz;
  cndprogf.show;
  ***)
end;


procedure Trange_select.Button17Click(Sender: TObject);
var _snr_,_utlg_,_sbez_:string;
{
 my_rep:travereport;
 my_page:travepage;
 my_text:travetext;
 }
 begin
//cdy_edit.
fdc.frxobsrep.PrepareReport(true);
//cdy_edit.
fdc.frxobsrep.ShowReport(true);
 {
 rvproject1.SelectReport('measurement',true);
 my_rep :=travereport( rvproject1.projman.FindRaveComponent('measurement',nil));
 my_page:=travepage  ( rvproject1.projman.FindRaveComponent('MainPage',my_rep));
 my_text:=travetext  ( rvproject1.projman.FindRaveComponent('Text2',my_page) );
 my_text.Text:='plot '+fda_sbez.Text+' in folder '+a_cdy_item.db_name+' !' ;
 rvproject1.open;
 rvproject1.ProjectFile:= 'cdy_rprt_2010.rav' ;
 rvproject1.ExecuteReport('measurement');
  }
end;



procedure Trange_select.Edit2Exit(Sender: TObject);
begin
{if edit2.text<>
  wert2changed:=true;
  label26.Show;
  }
end;

procedure Trange_select.Edit2Change(Sender: TObject);
begin
  wert2changed:=true;
  label26.Show;
end;



procedure Trange_select.Timer1Timer(Sender: TObject);
begin
{
 if karte=nil then exit;

 if karte.Showing then karte.BringToFront;
 }
 timer1.Enabled:=false;
end;

procedure Trange_select.Edit1Change(Sender: TObject);
begin
   edit2.Text:='?';
   wert2changed:=false;
  label26.hide;
end;

procedure Trange_select.itemselectCloseUp(Sender: TObject);
var k:integer;
begin
k:=  cdyactions.keyvalue;

if  not(   k  in [21,22] ) then
 edit1.Text:='';
end;

procedure Trange_select.FormActivate(Sender: TObject);
begin
// if not karte.call_plot_select    then  timer1.Enabled:=true;
if not got_hints then cdy_uif.get_hints('range_select',range_select);
 got_hints:=true;
 fdc.classqry.open;
// checkbox2.Checked:=cdy_uif.mw_dlg;
// checkbox3.Checked:=cdy_uif.qck_st;
end;

procedure Trange_select.fda_sbezExit(Sender: TObject);
var id_text:string;
begin
// wird erst bei fda update angepasst
//   id_text:=copy(a_item.Text,1,pos(':',a_item.Text));
//   a_item.Text:=id_text+fda_sbez.Text
button6.Click;
end;

procedure Trange_select.TreeView1ContextPopup(Sender: TObject;
  MousePos: TPoint; var Handled: Boolean);
begin
if popupmenu=popupmenu1 then
   popupmenu1.Items[1].Enabled:=not( a_item.GetLastChild.ImageIndex=14);
end;

procedure Trange_select.m1Click(Sender: TObject);
begin
// button5.click;
//K frm_gis_menu.DirectoryListBox1.Directory:=cdy_UIF.cdydpath.text;
//K  frm_gis_menu.show;
end;

procedure Trange_select.m0Click(Sender: TObject);
begin
 button9.click;
end;

procedure Trange_select.db_nlevelChange(Sender: TObject);
begin
fda_nlevel:= db_nlevel.ItemIndex+1;
end;

procedure Trange_select.deletedatabase1Click(Sender: TObject);
begin
 loesch_btn.Click;
end;

procedure Trange_select.createanewdatabase1Click(Sender: TObject);
begin
  create_db;
        ACTIVE_ITEM:=NIL;
        a_item:=treeview1.TopItem;
end;

procedure Trange_select.addanewplot1Click(Sender: TObject);
begin
 button10.Click;
end;

procedure Trange_select.deleteplot1Click(Sender: TObject);
var cdydb,fname,id,condition:string;
     snr,utlg:integer;
     delq:tfdquery;
begin
id:= a_cdy_item.db_name+':'+a_cdy_item.plot_id;
if  application.MessageBox(pchar(' Do you really want to delete ALL data of plot '+id+' ?'),'Confirm Delete',mb_yesno)= idyes then
begin
// alle einträge löschen
delq:=tfdquery.create(nil);
delq.connection:=cdy_uif.dbc;
snr:=a_cdy_item.snr;
utlg:=a_cdy_item.utlg;
cdydb:=a_cdy_item.db_name;
condition:=' where fname='''+cdydb+''' and SNR='+inttostr(snr)+' and UTLG=' +inttostr(utlg);
// fxdat
   begin
    delq.SQL.clear;
    delq.SQL.add('delete from cdy_fxdat'+condition);
    delq.ExecSQL;
   end;
// madat
   begin
    delq.SQL.clear;
    delq.SQL.add('delete from cdy_madat'+condition);
   try delq.ExecSQL; except; end;
   end;
// mwdat
   begin
    delq.SQL.clear;
    delq.SQL.add('delete from cdy_MVdat'+condition);
    try delq.ExecSQL; except; end;
   end;
//msdat
   begin
    delq.SQL.clear;
    delq.SQL.add('delete from cdy_msdat'+condition);
   try delq.ExecSQL; except; end;
   end;

   begin
    delq.SQL.clear;
    delq.SQL.add('delete from cdy_sldat'+condition);
   try delq.ExecSQL; except; end;
   end;
//mmh
{skip
   fname:='MMH'+a_cdy_item.db_name+'.dbf';
   if fileexists(dpth+fname) then
   begin
    delq.SQL.clear;
    delq.SQL.add('delete from '+fname+condition);
    delq.ExecSQL;
   end;
   endskip}
// fertig
delq.free;
rebuilt_treeview;
end;
end;

procedure Trange_select.add10recs1Click(Sender: TObject);

begin

 rec_app_quest.show;

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
    h := Clipboard.GetAsHandle(CF_TEXT);
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


procedure Trange_select.pastedata1Click(Sender: TObject);
 var
      fname:string;
      i:integer;
      zstr:tstringlist;
begin
 zstr:=tstringlist.Create;
 if HolAusClipboard(Zstr) then
 begin
  fname:=dbgrid3.selectedfield.FieldName;
  if dbgrid3.DataSource.DataSet.RecNo<dbgrid3.DataSource.DataSet.RecordCount then
  begin
  // sätze übernemen
   for i:=1 to zstr.Count do
   begin
    dbgrid3.DataSource.DataSet.Edit;
    dbgrid3.DataSource.DataSet.FieldByName(fname).AsString:=zstr.Strings[i-1];
    dbgrid3.DataSource.DataSet.Post;
    dbgrid3.DataSource.DataSet.Next;
   end;
  end;
 end;
 zstr.free;
end;

procedure Trange_select.TabSheet3Enter(Sender: TObject);
begin
   fdc.mklqry.Open;
//#    fdc.mklqry.open;
//    cdy_edit.qklasse.Open;
end;



procedure Trange_select.groupsimulation1Click(Sender: TObject);
begin
// switch settings

 p_korr.Checked   :=prmdlgf.preci_chkbx.checked;
 cdy_sgen.Checked :=prmdlgf.cdy_sgen.checked;
 cdy_ss.Checked   :=prmdlgf.cdy_ss.checked;
 lys_chkbx.Checked:=prmdlgf.lys_chkbx.checked;

 scenario_cntrl.BringToFront;
 scenario_cntrl.Show;
 label23.caption:=cdy_db;
 fdc.fdaqry.sql.clear;
 fdc.fdaqry.sql.add('select * from cdy_FxDat where fname='''+cdy_db+''' ');
 //fdc.fdaqry.sql.add('where SNR='+snr_+' and UTLG='+utlg_);
 fdc.fdaqry.open;
 fdc.fdaqry.first;
 // Anfang und ende
 sc_start.DateTime:= fdc.fdaqry.fieldbyname('STARTDAT').AsDateTime;
 if  fdc.fdaqry.Fields.findfield('STOPDAT')<>NIL then
 sc_stop.DateTime:= fdc.fdaqry.fieldbyname('STOPDAT').AsDateTime;
 checklistbox1.Clear;
 while not fdc.fdaqry.eof do
 begin
   checklistbox1.Items.add( 'Plot '+
   fdc.fdaqry.fieldbyname('SNR').asstring+
   fdc.fdaqry.fieldbyname('UTLG').asstring +': '+
    fdc.fdaqry.fieldbyname('SBEZ').asstring);
   fdc.fdaqry.next;
 end;
 fdc.fdaqry.close;
end;

procedure Trange_select.TreeView1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
  var k:word;
begin
   {
//beim Laptop: PgDn:34  / PpUp=33
    k:=key;
    label30.Caption:=inttostr(k);
    if k=123 then treeview1.scrollby(0,12) else
    begin
         treeview1.scrollby(0,-12);
         treeview1.Repaint;
    end;
    }
// Routine ausgeblendet 27.10.2004 Fra    
end;

procedure Trange_select.CheckBox1Click(Sender: TObject);
begin
 fdc.htab.Close;
 if checkbox1.Checked then
 begin
 // Filter setzen
 fdc.htab.Filter:='fname='+''''+cdy_db+''''+' and '+edit3.Text ;
 fdc.htab.Filtered:=true;
 end
 else
 begin
 fdc.htab.filter:='fname='+''''+cdy_db+'''';
 fdc.htab.Filtered:=true;
 end;
 fdc.htab.Open;
end;

procedure Trange_select.CheckBox2Click(Sender: TObject);

begin
 cdy_reg:=Tregistry.Create;
  cdy_reg.RootKey := HKEY_CURRENT_USER;
  if cdy_reg.OpenKey('\Software\candy\switches', False)
  then
  begin
    cdy_reg.WriteBool('obs_dlg',checkbox2.checked);
  end;
   cdy_reg.CloseKey;
   cdy_reg.Free;
end;

procedure Trange_select.CheckBox3Click(Sender: TObject);
begin
 cdy_reg:=Tregistry.Create;
  cdy_reg.RootKey := HKEY_CURRENT_USER;
  if cdy_reg.OpenKey('\Software\candy\switches', False)
  then
  begin
    cdy_reg.WriteBool('quick_start',checkbox2.checked);
  end;
  cdy_reg.CloseKey;
  cdy_reg.Free;
end;

procedure Trange_select.Edit3Change(Sender: TObject);
begin
 checkbox1.Checked:=false;
end;
 {
procedure Trange_select.htab_BeforeOpen(DataSet: TDataSet);
begin
 fdc.htab.Filter:='';
 fdc.htab.Filtered:=false;
 checkbox1.Checked:=false;
end;
  }
procedure Trange_select.filemode1Click(Sender: TObject);
begin
 filemode1.checked:= not filemode1.checked ;
  evaluationmode1.checked:= not evaluationmode1.checked ;
  item_click([ssleft]);
end;

procedure Trange_select.evaluationmode1Click(Sender: TObject);
begin
 if a_cdy_item=nil then exit;
 evaluationmode1.checked:= not evaluationmode1.checked ;
 filemode1.checked:= not filemode1.checked  ;
  item_click([ssleft]);

end;

procedure Trange_select.fda_soilMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if shift=[ssright] then
  begin
    fdc.profile_prm.open;
    fdc.profile_prm.Locate('PROFIL',variant(fda_soil.KeyValue),[]);
    cdy_parms.PageControl1.ActivePage:=  cdy_parms.TabSheet7;
    cdy_parms.show;
   end;
end;

procedure Trange_select.Label6DblClick(Sender: TObject);
begin
  range_select.find_wetter_stat;
    cli_tool.a_wstat:=   range_select.fda_wett.Items[fda_wett.itemindex];
    //  cli_tool.cb_wstat.ItemIndex:= cli_tool.cb_wstat.Items.IndexOf(fda_wett.Items[fda_wett.itemindex]);
    // cli_tool.cb_wstatCloseUp(nil);
   cli_tool.show;
end;

procedure Trange_select.Label5DblClick(Sender: TObject);
begin
     fdc.profile_prm.close;
     fdc.profile_prm.open;
     fdc.profile_prm.first;
     fdc.profile_prm.Locate('PROFIL',variant(fda_soil.KeyValue),[]);
     cdy_parms.PageControl1.ActivePage:=  cdy_parms.TabSheet7;
     cdy_parms.show;
end;

procedure Trange_select.set_mw_filter;
begin
{


SELECT CDYPROP.item_ix, CDYPROP.propname as merkmal, CDYPROP.shrtname as bezeichnung, CDYPROP.propunit, CDYPROP.adptbl, cdyprclass.item_ix as klasse
FROM CDYPROP INNER JOIN (cdyprclass INNER JOIN cdycl2pr ON cdyprclass.item_ix = cdycl2pr.class_item) ON CDYPROP.item_ix = cdycl2pr.prop_item
WHERE (((cdyprclass.item_ix)=1));

                        }
     with      fdc.mklqry do
    if checkbox5.checked and (fdc.classqry.fieldbyname('item_ix').asinteger<>0) then

    begin
     // filter setzen

      close;
      sql.clear;
     sql.add(' SELECT CDYPROP.item_ix, CDYPROP.propname as merkmal, CDYPROP.shrtname as bezeichnung, ');
     sql.add(' CDYPROP.propunit, CDYPROP.adptbl, cdyprclass.item_ix as klasse ');
     sql.add(' FROM CDYPROP INNER JOIN (cdyprclass INNER JOIN cdycl2pr ON ');
     sql.add(' cdyprclass.item_ix = cdycl2pr.class_item) ON CDYPROP.item_ix = cdycl2pr.prop_item ');
     sql.add(' WHERE cdyprclass.item_ix='+fdc.classqry.fieldbyname('item_ix').asstring);


      open;
      lcb_merkmal.ListSource:=fdc.mklsrc;
    end
    else
    begin
     // filter rücksetzen
      close;
      sql.clear;
      sql.add(' select item_ix  ,propname as Merkmal, shrtname as Bezeichnung, adptbl, propunit , 0 as KLASSE from cdyprop order by propname ');


      open;
       lcb_merkmal.ListSource:=fdc.mklsrc;
    end;





end;

procedure Trange_select.CheckBox5Click(Sender: TObject);
begin
 set_mw_filter;
end;

procedure Trange_select.DBLookupComboBox1CloseUp(Sender: TObject);
begin
 set_mw_filter;
end;

procedure Trange_select.lcb_itemCloseUp(Sender: TObject);
begin
//lcb_merkmal.KeyValue:=fdc.mklqry.fieldbyname(lcb_item.ListField).asvariant;
end;

procedure Trange_select.lcb_merkmalCloseUp(Sender: TObject);
begin
//lcb_item.KeyValue:=fdc.mklqry.fieldbyname(lcb_merkmal.ListField).asvariant;
end;

procedure Trange_select.DBGrid2MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
//if button=mbright then      dbgrid2.PopupMenu:=popupmenu7;
end;

procedure Trange_select.DBGrid2CellClick(Column: TColumn);
begin
   dbgrid2.PopupMenu:=popupmenu7;
end;

procedure Trange_select.showthispropertyonly1Click(Sender: TObject);
var a_mix:string;
begin
 with fdc.mweqry do
   begin
   a_mix:=fieldbyname('M_IX').AsString;
   end;

 if ( showthispropertyonly1.Caption='&show this property only') and (a_mix<>'')
 then
 begin
   with fdc.mweqry do
   begin
   a_mix:=fieldbyname('M_IX').AsString;
   close;
   //databasename:= cdy_uif.cdydpath.text;
   sql.Clear;
   sql.add(' select * from CDY_MVDat where fname='''+cdy_db+''' ');
   sql.add(' and SNR='+snr_+' and UTLG='+utlg_+' and M_IX='+a_mix+' order by DATUM  ');
   open;
   end;
   showthispropertyonly1.Caption:='&show all properties'
 end
 else
 begin
   with fdc.mweqry do
   begin
//   a_mix:=fieldbyname('M_IX').AsString;
   close;
   //databasename:= cdy_uif.cdydpath.text;
   sql.Clear;
   sql.add(' select * from CDY_MVDat where fname='''+cdy_db+''' ');
   sql.add(' and SNR='+snr_+' and UTLG='+utlg_+'  order by DATUM  ');
   open;
   end;
   showthispropertyonly1.Caption:='&show this property only'
 end;
end;

procedure Trange_select.TabSheet3Show(Sender: TObject);
begin
  showthispropertyonly1Click(nil);
end;


procedure Trange_select.printmanagement1Click(Sender: TObject);
var _snr_,_utlg_,_sbez_:string;
begin
{
exp_rep.cdy_db:=cdy_db;
exp_rep.label1.Caption:=cdy_db;
exp_rep.show;

}
(***************************

//*  fdc.fdaqry.databasename:=cdy_uif.cdydpath.text;
 fdc.fdaqry.sql.clear;
 fdc.fdaqry.sql.add('select * from FDA'+cdy_db+'.dbf ');
 fdc.fdaqry.open;
 //QR#  rep_mas_group.QRLabel1.Caption:='Management data of '+cdy_db;
//* fdc.masqry.databasename:=cdy_uif.cdydpath.text;

// while not fdc.fdaqry.eof do
 begin

    fdc.masqry.sql.clear;
    fdc.masqry.sql.add('select f.sbez as s_bez, m.SNR,m.UTLG, m.DATUM, m.MACODE,m.WERT1,m.WERT2,m.ORIGWERT,m.REIN from MAS'+cdy_db+'.dbf m, FDA'+cdy_db+'.dbf f');
    fdc.masqry.sql.add('where f.snr=m.snr and f.utlg=m.utlg order by SNR,UTLG,DATUM,MACODE'); //'where snr='+_snr_+' and utlg='+_utlg_+
    fdc.masqry.open;
  // Report ausführen
  rep_mas_group.QuickRep1.Preview;

 end;
 fdc.masqry.close;
 fdc.masqry.SQL.Clear;
 ******************************)
end;

procedure Trange_select.MeasurementReport1Click(Sender: TObject);
begin
(************************
//* fdc.fdaqry.databasename:=cdy_uif.cdydpath.text;
 fdc.fdaqry.sql.clear;
 fdc.fdaqry.sql.add('select * from FDA'+cdy_db+'.dbf ');
 fdc.fdaqry.open;
//* fdc.mweqry.databasename:=cdy_uif.cdydpath.text;
 fdc.mweqry.sql.clear;
 fdc.mweqry.sql.add('select * from MWE'+cdy_db+'.dbf ');
 fdc.mweqry.open;
//QR#  rep_meas_group.QRLabel1.Caption:='Measurement data of '+cdy_db;
//QR#  rep_meas_group.quickrep1.preview;
 fdc.mweqry.close;
 fdc.mweqry.sql.clear;
 ***********************)
end;

procedure Trange_select.Button18Click(Sender: TObject);
var i:integer;
    subj:string;
begin
   olddate  :=fdc.masqry.fieldbyname('DATUM').asstring;
   oldmacode:=fdc.masqry.fieldbyname('MACODE').asstring;
  // frm_om_result.label1.Caption:= fdc.masqry.fieldbyname('SUBJEKT').asstring;
//C   frm_om_result.edit5.text:=     fdc.masqry.fieldbyname('WERT1').asstring;
//C   frm_om_result.Edit4.Text:=     datetostr( datetimepicker1.date);
   subj:=fdc.masqry.FieldByName('subjekt').asstring;
   i:=pos('#',subj);
//C   frm_om_result.stx_label.caption:=copy(subj,i+1,length(subj)-i);
//C   frm_om_result.show;
end;




procedure Trange_select.Button19Click(Sender: TObject);
begin
fdc.mweqry.Delete;
end;

end.
