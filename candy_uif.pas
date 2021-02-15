{ main form with user interface ,  processes the batch mode and queries the registry }
unit candy_uif;

interface

uses   sharemem,   wetgen1,        observations,
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,cdyprotokoll,
  ComCtrls, StdCtrls, ExtCtrls, Mask,math,  registry, jpeg,
    ActiveX,  wininet, ioutils,    strutils,   DB, system.Variants,
  Vcl.Imaging.GIFImg, Vcl.OleServer, Excel2000, Vcl.OleCtrls, SHDocVw,
  Vcl.Imaging.pngimage,  FireDAC.Comp.Client, DsInformation, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.VCLUI.Wait, FireDAC.Phys.MSAcc, FireDAC.Phys.MSAccDef,
  FireDAC.Phys.PGDef, FireDAC.Phys.ODBCBase, FireDAC.Phys.PG;

type
  Tdblist =array [0..9] of string;
  Tcdy_UIF = class(TForm)
    cdydpath: TEdit;
    Label1: TLabel;
    Button3: TButton;
    Button5: TButton;
    Button1: TButton;
    Button2: TButton;
    Button9: TButton;
    OpenDialog1: TOpenDialog;
    Button10: TButton;
    Button11: TButton;
    StatusBar1: TStatusBar;
    Button6: TButton;
    dbhist: TComboBox;
    Label2: TLabel;
    Image1: TImage;
    Button4: TButton;
    gui_doc: TRadioButton;
    db_doc: TRadioButton;
    sub_doc: TRadioButton;
    wb: TWebBrowser;
    dbc: TFDConnection;
    FDPhysPgDriverLink1: TFDPhysPgDriverLink;
    FDPhysMSAccessDriverLink1: TFDPhysMSAccessDriverLink;
    xla: TExcelApplication;
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure cdyparmAfterConnect(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    procedure Button12Click(Sender: TObject);
    procedure cdydpathChange(Sender: TObject);
    procedure cdywpathChange(Sender: TObject);
    procedure StatusBar1DblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Image1DblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure dbhistCloseUp(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure dbhistKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);

  private
    { Private-Deklarationen }
//    procedure adapt_db_structure;
    procedure compress_stc(sz_id:integer; s_path, base_name:string);

  public
    { Public-Deklarationen }
    message_shown:boolean;
    grassmind_dll,
    sim_call,    sql_call   :boolean;
    cdy_reg:Tregistry;
    startdir,
    ps,rs,             // strings für ado-connection ps:provider; rs: ado_parms
    db_f_name,
    access_dll,
    cdy_p_path,       //exe directory drive:x\y\
    userhome         // users home dir
                  :string;

    procedure form_init;      // main initialization routine !!

    procedure  check_database;
    procedure get_hints(fname:string; afrm:tform);
    procedure checkcdydpath;

    //Fire dac preparation !!
    procedure db_connect(dbname:string);
    procedure db_disconnect;
  end;

var
  cdy_UIF: Tcdy_uif;
   cdy_observ:Tcdy_obs;

implementation

uses  path_sel_u, range_sel_U, mw_modul_U, cdyprmedit,  {prmU1,}  cnd_util, cdy_r_vw,
 { mapdraw,  wetgen1, dbi_main, cndprog,} sql_unit,  { cdyparm,} prmdlg2,  cdy_glob,
  ok_dlg1, {settings,}cndstat, cnd_vars, gis_rslt, cnd_rs_2, data_interface, fdc_modul,
  cdy_news,system.inifiles, Unit8;
{$R *.DFM}







{
procedure Tprmdlgf.Button1Click(Sender: TObject);
begin
// thisjob.no_more_action:=false;
// modalresult:=mrok;
// prmdlgf.close;
end;

procedure Tprmdlgf.Button2Click(Sender: TObject);
begin
// modalresult:=mrcancel;
cdymain.close;
prmdlgf.close;
end;

procedure Tprmdlgf.cdy_ssClick(Sender: TObject);
begin
if cdy_ss.checked then cdy_sgen.checked:=true;
end;

procedure Tprmdlgf.cdy_sgenClick(Sender: TObject);
begin
 if not cdy_sgen.checked then cdy_ss.checked:=false;
end;

procedure Tprmdlgf.UpDown1Click(Sender: TObject; Button: TUDBtnType);
begin
   if (updown1.position<>0) then cdy_zz.text:=inttostr(updown1.position) else cdy_zz.text:='-';
end;

procedure Tprmdlgf.UpDown2Click(Sender: TObject; Button: TUDBtnType);
begin
    if (updown2.position<>0) then cdy_ra_wdh.text:=inttostr(updown2.position) else cdy_ra_wdh.text:='-';

end;

procedure Tprmdlgf.cdy_raClick(Sender: TObject);
begin

 if cdy_ra.checked then
 begin
  cdy_ra_wdh.enabled:=true;
  updown2.enabled   :=true;
 end
 else
 begin
  cdy_ra_wdh.enabled:=false;
  updown2.enabled   :=false;
 end
end;

procedure Tprmdlgf.cdy_r_typeClick(Sender: TObject);
begin
 if cdy_r_type.itemindex=1
  then cdy_of.enabled:=true
  else cdy_of.enabled:=false;
 if cdy_r_type.itemindex>0
  then cdy_fname.enabled:=true
  else cdy_fname.enabled:=false;
end;
 }
procedure Tcdy_UIF.Button3Click(Sender: TObject);
begin
 if directoryexists(cdydpath.Text) then  path_sel.org_path:= cdydpath.text;
 path_sel.showmodal;
 cdydpath.text:=path_sel.sel_path;
 cdy_reg:=Tregistry.Create;
 try
  cdy_reg.RootKey := HKEY_CURRENT_USER;
  if cdy_reg.OpenKey('\Software\candy', True)
  then
  begin
  cdy_reg.WriteString('dpath', cdydpath.text);
  cdy_reg.WriteString('rpath', cdydpath.text );
  end;
 finally
 cdy_reg.closekey;
 cdy_reg.free;
 inherited;
 end;
 //karte.GetShapes;
 //button7.visible:=karte.has_shapes;
end;

procedure Tcdy_UIF.Button4Click(Sender: TObject);

  var url_, url2:widestring;
    flags: olevariant;
   PersistStream: IPersistStreamInit;
   Stream: IStream;
   FileStream: TFileStream;
   hfile: textfile;
   aline,hline,_ba,_clay,_silt,_skel,_tem,_rain, gname,clid:string;
   p,l,i:integer;
   search_phrase:string;
 begin
 if gui_doc.checked then search_phrase:=  'working with the user interface';
 if db_doc.checked then search_phrase:=  'description of database structure';
 if sub_doc.checked then search_phrase:=  'detailed description of submodels';
//optimizer    url_:='http://www.ufz.de/index.php?en=39727';
url_:='http://www.ufz.de/index.php?en=39725';
   ccb_info.Wb1.Navigate(url_) ;
   while ccb_info.Wb1.ReadyState < READYSTATE_INTERACTIVE do   Application.ProcessMessages;
   if not Assigned(ccb_info.WB1.Document) then
   begin
     ShowMessage('Document not loaded!') ;
     Exit;
   end;
   PersistStream := ccb_info.WB1.Document as IPersistStreamInit;
   FileStream := TFileStream.Create('tmp_file.html', fmCreate) ;
   try
     Stream := TStreamAdapter.Create(FileStream, soReference) as IStream;
     if Failed(PersistStream.Save(Stream, True)) then ShowMessage('SaveAs HTML fail!') ;
   finally
     FileStream.Free;
   end;
   assignfile(hfile, 'tmp_file.html');
   reset(hfile);
   repeat
     readln(hfile,aline);
 //  until eof(hfile) or ( pos('manual for optimizer handling',aline)>0);
     until eof(hfile) or ( pos(search_phrase,aline)>0);
   i:=pos('"/',aline);
   l:=pos('.pdf"',aline);

   url_:=copy(aline,i+1,l-i+3);

   { option:
     repeat
     readln(hfile,aline);
   until eof(hfile) or ( pos('optimizer; application',aline)>0);
    i:=pos('"/',aline);
   l:=pos('.exe"',aline);
    url2:=copy(aline,i+1,l-i+3);
    }
       closefile(hfile);

url_:=' http://www.ufz.de'+url_;
//label13.Caption:=url_;
//webbrowser1.navigate(url_);
ccb_info.wb1.Navigate2(url_,flags,flags,flags,flags);
ccb_info.wb1.show;
ccb_info.Show;
end;
procedure Tcdy_uif.get_hints(fname:string; afrm:tform);
var ic:longint;
    dc: tcomponent;
    ccln,cnm: string;
begin
//  hqry.Close;
 application.ShowHint:=true;
 for ic:=0 to  afrm.ComponentCount-1 do
 begin
 try
   dc:=afrm.Components[ic];
   ccln:=dc.classname;                        //TComboBox
   if pos(ccln ,'TLabel TEdit TButton TCheckBox TComboBox TDBCheckBox TDBEdit TDBGrid')>0 then
   begin
     cnm:=dc.name;
     fdc.explanations.First;
     if fdc.explanations.Locate('CDYFORM;CType;CName',VarArrayof([fname,ccln,cnm]),[])
     then
     begin
        if ( trim(fdc.explanations.FieldByName('cHint').AsString) = trim(fdc.explanations.FieldByName('cName').AsString) )
        or (trim(fdc.explanations.FieldByName('cHint').AsString) ='-' )
        then tcontrol(dc).ShowHint:=false
        else
        begin
         tcontrol(dc).hint:= trim(fdc.explanations.FieldByName('CHint').AsString);
         tcontrol(dc).ShowHint:=trim(tcontrol(dc).Hint)<>'-';
        end;
     end
     else
     begin
      fdc.explanations.AppendRecord([fname,cnm,ccln,cnm]);
     end;
   end;
 except; end;
 end;
end;




procedure  Tcdy_uif.check_database;
var cdy_ini:Tregistry;
   ttab:tfdtable;   i:integer;
    ic:longint;
    dc: tcomponent;
    ccln,cnm: string;
begin
 fdc.hqry.Close;
 fdc.hqry.sql.Clear;
 fdc.hqry.SQL.Add(' select * from cdyrslt_lists');
  try
 fdc.hqry.Open;
  except
  fdc.hqry.Close;
  fdc.hqry.sql.Clear;
    if   dbc.Params.DriverID='PG'
    then fdc.hqry.SQL.Add(' create table CDYRSLT_LISTS (item_ix serial not null, listname char(20))')
    else fdc.hqry.SQL.Add(' create table CDYRSLT_LISTS (item_ix Autoincrement, listname char(20))');
  fdc.hqry.ExecSQL;
  end;
 fdc.hqry.Close;
 fdc.hqry.sql.Clear;
   fdc.hqry.SQL.Add(' select * from cdyrslt_selection');
  try
 fdc.hqry.Open;
  except
  fdc.hqry.Close;
  fdc.hqry.sql.Clear;
  if   dbc.Params.DriverID='PG'
    then fdc.hqry.SQL.Add(' create table CDYRSLT_SELECTION (item_ix serial not null, list_ix Integer, resultnr integer)')
    else fdc.hqry.SQL.Add(' create table CDYRSLT_SELECTION (item_ix Autoincrement, list_ix Integer, resultnr integer)');
  fdc.hqry.ExecSQL;
  end;

   fdc.hqry.Close;
   fdc.hqry.sql.Clear;
   fdc.hqry.SQL.Add(' select * from cdyprclass');
  try
  fdc.hqry.open;
  except
  fdc.hqry.Close;
  fdc.hqry.sql.Clear;
    if   dbc.Params.DriverID='PG'
    then fdc.hqry.SQL.Add('  create table CDYPRCLASS (item_ix serial nut null, classname char(20) )')
    else fdc.hqry.SQL.Add(' create table CDYPRCLASS (item_ix Autoincrement, classname char(20) )');
  fdc.hqry.ExecSQL;
  fdc.hqry.sql.Clear;
  fdc.hqry.SQL.Add(' insert into CDYPRCLASS ( classname  ) values ( "nitro" )');
  fdc.hqry.ExecSQL;
  fdc.hqry.sql.Clear;
  fdc.hqry.SQL.Add(' insert into CDYPRCLASS ( classname  ) values ("SOM")');
  fdc.hqry.ExecSQL;
  fdc.hqry.sql.Clear;
  fdc.hqry.SQL.Add(' insert into CDYPRCLASS ( classname  ) values ("environment")');
  fdc.hqry.ExecSQL;
  fdc.hqry.sql.Clear;
  fdc.hqry.SQL.Add(' insert into CDYPRCLASS ( classname  ) values ("crop")');
  fdc.hqry.ExecSQL;
  fdc.hqry.sql.Clear;
  fdc.hqry.SQL.Add(' insert into CDYPRCLASS ( classname  ) values ("my list")');
  fdc.hqry.ExecSQL;
  fdc.hqry.sql.Clear;
  end;


     fdc.hqry.Close;
 fdc.hqry.sql.Clear;
   fdc.hqry.SQL.Add(' select * from cdycl2pr');
  try
 fdc.hqry.open;
  except
  fdc.hqry.Close;
  fdc.hqry.sql.Clear;
  fdc.hqry.SQL.Add(' create table CDYCL2PR ( class_item integer, prop_item integer )');
  fdc.hqry.ExecSQL;    fdc.hqry.Close;   fdc.hqry.sql.Clear;
  fdc.hqry.SQL.Add(' insert into CDYCL2PR ( class_item,prop_item  ) values (1,1  )');
  fdc.hqry.ExecSQL;    fdc.hqry.Close;   fdc.hqry.sql.Clear;
  fdc.hqry.SQL.Add(' insert into CDYCL2PR ( class_item,prop_item  ) values (1,3  )');
  fdc.hqry.ExecSQL;    fdc.hqry.Close;   fdc.hqry.sql.Clear;
  fdc.hqry.SQL.Add(' insert into CDYCL2PR ( class_item,prop_item  ) values (1,4  )');
  fdc.hqry.ExecSQL;    fdc.hqry.Close;   fdc.hqry.sql.Clear;
  fdc.hqry.SQL.Add(' insert into CDYCL2PR ( class_item,prop_item  ) values (2,2  )');
  fdc.hqry.ExecSQL;    fdc.hqry.Close;   fdc.hqry.sql.Clear;
     fdc.hqry.SQL.Add(' insert into CDYCL2PR ( class_item,prop_item  ) values (2,5  )');
  fdc.hqry.ExecSQL;    fdc.hqry.Close;   fdc.hqry.sql.Clear;
     fdc.hqry.SQL.Add(' insert into CDYCL2PR ( class_item,prop_item  ) values (2,6  )');
  fdc.hqry.ExecSQL;    fdc.hqry.Close;   fdc.hqry.sql.Clear;
     fdc.hqry.SQL.Add(' insert into CDYCL2PR ( class_item,prop_item  ) values (2,7  )');
  fdc.hqry.ExecSQL;    fdc.hqry.Close;   fdc.hqry.sql.Clear;
     fdc.hqry.SQL.Add(' insert into CDYCL2PR ( class_item,prop_item  ) values (2,28  )');
  fdc.hqry.ExecSQL;    fdc.hqry.Close;   fdc.hqry.sql.Clear;
     fdc.hqry.SQL.Add(' insert into CDYCL2PR ( class_item,prop_item  ) values (3,9  )');
  fdc.hqry.ExecSQL;    fdc.hqry.Close;   fdc.hqry.sql.Clear;
     fdc.hqry.SQL.Add(' insert into CDYCL2PR ( class_item,prop_item  ) values (3,10  )');
  fdc.hqry.ExecSQL;    fdc.hqry.Close;   fdc.hqry.sql.Clear;
     fdc.hqry.SQL.Add(' insert into CDYCL2PR ( class_item,prop_item  ) values (3,11  )');
  fdc.hqry.ExecSQL;    fdc.hqry.Close;   fdc.hqry.sql.Clear;
     fdc.hqry.SQL.Add(' insert into CDYCL2PR ( class_item,prop_item  ) values (3,42)');
  fdc.hqry.ExecSQL;    fdc.hqry.Close;   fdc.hqry.sql.Clear;
     fdc.hqry.SQL.Add(' insert into CDYCL2PR ( class_item,prop_item  ) values (3,46)');
  fdc.hqry.ExecSQL;    fdc.hqry.Close;   fdc.hqry.sql.Clear;
     fdc.hqry.SQL.Add(' insert into CDYCL2PR ( class_item,prop_item  ) values (3,52)');
  fdc.hqry.ExecSQL;    fdc.hqry.Close;   fdc.hqry.sql.Clear;
     fdc.hqry.SQL.Add(' insert into CDYCL2PR ( class_item,prop_item  ) values (3,53)');
  fdc.hqry.ExecSQL;    fdc.hqry.Close;   fdc.hqry.sql.Clear;
     fdc.hqry.SQL.Add(' insert into CDYCL2PR ( class_item,prop_item  ) values (4,23)');
  fdc.hqry.ExecSQL;    fdc.hqry.Close;   fdc.hqry.sql.Clear;
     fdc.hqry.SQL.Add(' insert into CDYCL2PR ( class_item,prop_item  ) values (4,25)');
  fdc.hqry.ExecSQL;    fdc.hqry.Close;   fdc.hqry.sql.Clear;
     fdc.hqry.SQL.Add(' insert into CDYCL2PR ( class_item,prop_item  ) values (4,45)');
  fdc.hqry.ExecSQL;    fdc.hqry.Close;   fdc.hqry.sql.Clear;
     fdc.hqry.SQL.Add(' insert into CDYCL2PR ( class_item,prop_item  ) values (4,46)');
  fdc.hqry.ExecSQL;    fdc.hqry.Close;   fdc.hqry.sql.Clear;
     fdc.hqry.SQL.Add(' insert into CDYCL2PR ( class_item,prop_item  ) values (4,56)');
  fdc.hqry.ExecSQL;    fdc.hqry.Close;   fdc.hqry.sql.Clear;
     fdc.hqry.SQL.Add(' insert into CDYCL2PR ( class_item,prop_item  ) values (4,57)');
  fdc.hqry.ExecSQL;    fdc.hqry.Close;   fdc.hqry.sql.Clear;
     fdc.hqry.SQL.Add(' insert into CDYCL2PR ( class_item,prop_item  ) values (5,1)');
  fdc.hqry.ExecSQL;    fdc.hqry.Close;   fdc.hqry.sql.Clear;
        fdc.hqry.SQL.Add(' insert into CDYCL2PR ( class_item,prop_item  ) values (5,7)');
  fdc.hqry.ExecSQL;    fdc.hqry.Close;   fdc.hqry.sql.Clear;
        fdc.hqry.SQL.Add(' insert into CDYCL2PR ( class_item,prop_item  ) values (5,9)');
  fdc.hqry.ExecSQL;    fdc.hqry.Close;   fdc.hqry.sql.Clear;
        fdc.hqry.SQL.Add(' insert into CDYCL2PR ( class_item,prop_item  ) values (5,10)');
  fdc.hqry.ExecSQL;    fdc.hqry.Close;   fdc.hqry.sql.Clear;

  end;

{
 fdc.hqry.Close;
  hqry.sql.Clear;
    hqry.SQL.Add(' delete * from cdyprop');
  try
  hqry.execSql;
  except
   hqry.Close;
   hqry.sql.Clear;
   hqry.SQL.Add(' create table CDYPROP (item_ix integer, propname char(20), shrtname char(10), format char(10), typ char(2), propunit char(10), adptbl logical )');
   hqry.ExecSQL;
  end;

  cdy_observ:=Tcdy_obs.create(nil,nil);
  cdy_observ.initialize;
  cdy_observ.rewrite_mltab;
  cdy_observ.Free;

   new(observ,init());
   observ.initialize;
   observ.rewrite_mltab;
 }
 // iirigation devices
    fdc.hqry.Close;
 fdc.hqry.sql.Clear;
 fdc.hqry.SQL.Add(' select * from cdyirrgdev ');
  try
 fdc.hqry.open;
  except
  fdc.hqry.Close;
  fdc.hqry.sql.Clear;
      if   dbc.Params.DriverID='PG'
    then fdc.hqry.SQL.Add(' create table cdyirrgdev (item_ix serial nit null, name char(20), effect float )')
    else  fdc.hqry.SQL.Add(' create table cdyirrgdev (item_ix autoincrement, name char(20), effect float )');
  //fdc.hqry.SQL.Add(' create table cdyirrgdev (item_ix integer, name char(20), effect float )');
  fdc.hqry.ExecSQL;
  fdc.hqry.Close;
  fdc.hqry.sql.Clear;
//  fdc.hqry.SQL.Add(' insert into cdyirrgdev (name , effect  ) values  (''duese'', 1 )');
  fdc.hqry.SQL.Add(' insert into cdyirrgdev (item_ix,name , effect  ) values  (1,''duese'', 1 )');
  fdc.hqry.ExecSQL;


  end;


 // observation schemes

   fdc.hqry.Close;
 fdc.hqry.sql.Clear;
 fdc.hqry.SQL.Add(' select * from cdy_obsch ');
  try
 fdc.hqry.open;
  except
  fdc.hqry.Close;
  fdc.hqry.sql.Clear;
  fdc.hqry.SQL.Add(' create table CDY_OBSCH (item_ix Autoincrement, sname char(20) )');
  fdc.hqry.ExecSQL;
  end;

    fdc.hqry.Close;
 fdc.hqry.sql.Clear;
 fdc.hqry.SQL.Add(' select * from cdy_obslt ');
  try
 fdc.hqry.open;
  except
  fdc.hqry.Close;
  fdc.hqry.sql.Clear;
  fdc.hqry.SQL.Add(' create table CDY_OBSLT (item_ix Autoincrement, sch_ix integer, intervall integer, m_ix integer, s0 integer, s1 integer, start date, enddat date,  PRIMARY KEY (item_ix) )');
  fdc.hqry.ExecSQL;
  end;




 // check existing mvdat
  fdc.hqry.Close;
  fdc.hqry.sql.Clear;
  fdc.hqry.SQL.Add('SELECT cdy_mvdat.m_ix, CDYPROP.item_ix FROM cdy_mvdat LEFT JOIN CDYPROP ON cdy_mvdat.m_ix = CDYPROP.item_ix');
  fdc.hqry.SQL.Add(' GROUP BY cdy_mvdat.m_ix, CDYPROP.item_ix  HAVING (((CDYPROP.item_ix) Is Null))');

  fdc.hqry.open;
  fdc.hqry.First;
   if fdc.hqry.RecordCount>0 then

   begin
    if application.MessageBox('should CANDY move the inconsistent records to bad_mvdat ?','observation data not consistent',mb_yesno)
      = idyes then
    begin
   fdc.hqry.Close;
   fdc.hqry.sql.Clear;
  if   dbc.Params.DriverID='PG' then      fdc.hqry.SQL.Add(' create table bad_mvdat as ');
   fdc.hqry.SQL.Add('SELECT cdy_mvdat.key, cdy_mvdat.fname, cdy_mvdat.first, cdy_mvdat.snr, cdy_mvdat.utlg, cdy_mvdat.datum,');
   fdc.hqry.SQL.Add(' cdy_mvdat.m_ix, cdy_mvdat.s0, cdy_mvdat.s1, cdy_mvdat.m_wert, cdy_mvdat.variation, cdy_mvdat.anzahl, cdy_mvdat.s_wert, cdy_mvdat.korrektur ');

     if not  (dbc.Params.DriverID='PG') then fdc.hqry.SQL.Add('    INTO bad_mvdat ');

   fdc.hqry.SQL.Add(' FROM cdy_mvdat LEFT JOIN cdyprop ON cdy_mvdat.m_ix = cdyprop.item_ix WHERE (((cdyprop.item_ix) Is Null)) ');
    try
     fdc.hqry.ExecSQL;
     fdc.hqry.Close;
     fdc.hqry.sql.Clear; // now delete
     fdc.hqry.SQL.Add('DELETE cdy_mvdat.* FROM cdy_mvdat LEFT JOIN cdyprop ON cdy_mvdat.m_ix = cdyprop.item_ix ');
     fdc.hqry.SQL.Add(' WHERE (((cdyprop.item_ix) Is Null));  ');
  //   fdc.hqry.SQL.SaveToFile('check1.sql');
     fdc.hqry.ExecSQL;
     except
      application.MessageBox('move not successful, please check the table cdy_msdat for invalid M_IX values','observation data not consistent');
     end;
    end;
    end;

 fdc.hqry.Close;
 fdc.hqry.sql.Clear;
 fdc.hqry.SQL.Add(' select * from cdy_explain');
  try
 fdc.hqry.Open;
  except
  fdc.hqry.Close;
  fdc.hqry.sql.Clear;
  fdc.hqry.SQL.Add(' create table cdy_explain (CDYForm char(20), cName char(20), cType char(20), cHint char(125))');
  fdc.hqry.ExecSQL;
   application.MessageBox('table cdy_explain re-created; please get a new database from the CANDY website','mouse tip hints will not work properly');

  end;
  fdc.explanations.Open;
  fdc.hqry.Close;
 fdc.hqry.sql.Clear;



 // structure adaptation check


 ttab:=tfdtable.Create(nil);
 ttab.Connection:=dbc; //cdy_uif.ado_cdyprm;
 ttab.TableName:='cdypflan' ;

 ttab.Open;
 if ttab.Fields.FindField('source')=nil then
 begin
  fdc.hqry.SQL.Clear;
  fdc.hqry.SQL.Add('alter table cdypflan add source char (80) ');
  fdc.hqry.ExecSQL;
  fdc.hqry.sql.clear;
 end;
 ttab.close;

  ttab.Open;
 if ttab.Fields.FindField('dm_nat')=nil then
 begin
  fdc.hqry.SQL.Clear;
  fdc.hqry.SQL.Add('alter table cdypflan add dm_nat float ');
  fdc.hqry.ExecSQL;
  fdc.hqry.sql.clear;
 end;
 ttab.Free;


 ttab:=tfdtable.Create(nil);
 ttab.Connection:=dbc; //cdy_uif.ado_cdyprm;
 ttab.TableName:='cdyopspa' ;

 ttab.Open;
 if ttab.Fields.FindField('source')=nil then
 begin
  fdc.hqry.SQL.Clear;
  fdc.hqry.SQL.Add('alter table cdyopspa add source char (80) ');
  fdc.hqry.ExecSQL;
  fdc.hqry.sql.clear;
 end;
 ttab.Free;

 ttab:=tfdtable.Create(nil);
 ttab.Connection:=dbc;//cdy_uif.ado_cdyprm;
 ttab.TableName:='cdy_rslt' ;

 ttab.Open;
 if ttab.Fields.FindField('remark')=nil then
 begin
  fdc.hqry.SQL.Clear;
  fdc.hqry.SQL.Add('alter table cdy_rslt add remark char 80 ');
  fdc.hqry.ExecSQL;
  fdc.hqry.sql.clear;
  fdc.hqry.SQL.Add('delete * from cdy_rslt');
  fdc.hqry.ExecSQL;
  fdc.hqry.sql.clear;
 end;
 ttab.Free;


 ttab:=tfdtable.Create(nil);
 ttab.Connection:=dbc; //cdy_uif.ado_cdyprm;
 ttab.TableName:='cdy_cldat' ;
 ttab.Open;
 if ttab.Fields.FindField('sonn')<>nil then
 begin
 ttab.Close;
fdc.hqry.SQL.Add('select * from cdy_cldat where  (((glob) Is Null) AND ((sonn)>=0))');
fdc.hqry.Open;
fdc.hqry.First;
 if fdc.hqry.RecordCount>0 then
 begin
  i:=application.MessageBox('should candy replace empty GLOB records with -999','possible problem with climate data', mb_yesno);
  if i=6 then
  begin
 fdc.hqry.sql.Clear;
 fdc.hqry.SQL.Add('UPDATE cdy_cldat SET  glob = -999 WHERE  glob Is Null AND sonn >=0');
 fdc.hqry.ExecSQL;
 fdc.hqry.sql.Clear;
  end;
 end;
 end;
 ttab.Free;

end;

procedure Tcdy_UIF.Button5Click(Sender: TObject);
begin
 if  directoryexists(cdydpath.Text) then
  begin
     range_select.a_path:=cdydpath.Text;
     range_select.fda_soil.show;
     range_select.Label5.show;
     range_select.Button7.show;
     range_select.Button16.show;
     range_select.cdy_run.show;
     range_select.show;
 end
 else application.MessageBox(' please select a valid data path',' non existing directory', mb_ok);
 cdydpath.Text:= extractfiledir(application.ExeName);
 end;

procedure Tcdy_UIF.Button1Click(Sender: TObject);
var syspath:string;
begin

   cdy_parms.PageControl1.ActivePage:=  cdy_parms.TabSheet9;
   cdy_parms.ShowModal;
end;

procedure Tcdy_UIF.Button2Click(Sender: TObject);
var i,j:integer;
begin
//application.Terminate;
while dbc.DataSetCount>0 do   dbc.DataSets[dbc.DataSetCount-1].Close;

{
j:= dbc.DataSetCount;
for i:=1 to j  do
begin
dbc.DataSets[i-1].Close;
end;
 }
 dbc.Close;
 cdy_uif.close;
    //  dispose(observ,done);
    //   observ:=nil;
end;





procedure Tcdy_UIF.Form_init;
var stc,pname, _datapath,_simend,{_respath}h,of_,psi,hstr,histfilename:string;
    list,slist :Tstringlist;
    i,j,k,{odbc,}id,wdh,hh:integer;
 //   _use_stc       ok :boolean;
     dblist:tdblist;
     akey:HKEY;
     x:real;
      //integer
      procedure get_num(var a_field: string; regstring:string; std:integer);
      var h:string  ;
      begin
                 try begin
                   h:=inttostr(cdy_reg.readinteger(regstring));
                   a_field:=h;
                 end;
                 except begin
                         a_field:=inttostr(std);
                         cdy_reg.WriteString(regstring,inttostr(std));
                        end;
                   end;
      end;

      //string
      procedure get_dta(var a_field: tedit; regstring,std:string);
      var h:string  ;
      begin
                 try begin
                   h:=cdy_reg.readString(regstring);
                   if h<>'' then a_field.text:=h else a_field.Text:=std;
                 end;
                 except begin
                         a_field.text:=std;
                         cdy_reg.WriteString(regstring,std);
                        end;
                   end;
      end;

      //switch
      procedure get_swt(var a_field: tcheckbox; regstring:string; std:boolean);
      var h:byte  ;
      begin
                 try begin
                      h:=cdy_reg.readinteger(regstring);
                      a_field.checked:=(h=1);
                     end;

                  except begin
                         a_field.checked:=std;
                         if std then  cdy_reg.Writeinteger(regstring,1)
                                else  cdy_reg.Writeinteger(regstring,0);
                        end;
                  end;
      end;




begin


 wb.Hide;

//  statusbar1.Panels.Items[1].Text:='Version: '+info1.GetThisExeVersion;
 cdy_p_path:= ExtractFilePath(Application.ExeName); // mit end-slash !!

 userhome:=system.IOUtils.Tpath.GetHomePath;

 cdy_reg:=Tregistry.Create;
 try
  cdy_reg.RootKey := HKEY_CURRENT_USER;
  if cdy_reg.OpenKey('\Software\candy', False)
  then
  begin
     try cdy_reg.writestring('ppath',cdy_p_path      );  finally;inherited;   end;

     db_f_name:='';
     try db_f_name:= cdy_reg.readString('database'); finally;inherited;   end;

     ps:='';
     try ps:= cdy_reg.readString('provider'); finally;inherited;   end;

     rs:='';
     try rs:= cdy_reg.readString('ado_parm'); finally;inherited;   end;

     cdydpath.text:=cdy_reg.readString('dpath');

     writeprotokoll('registry :'+cdydpath.text+';'+cdy_p_path+';'+db_f_name);

     checkcdydpath;

  end
  else
   begin
    cdy_reg.CreateKey('\Software\candy');
    cdy_reg.openkey('\Software\candy', True);
    cdy_reg.writestring('dpath',cdydpath.text);
    writeprotokoll('new registry items');
   end;

 //  prmdlgf.init_parmset_selection;

  if cdy_reg.OpenKey('\Software\candy\switches', False)
  then
  begin

   get_swt(range_select.checkbox3,'quick_start',false);
   get_swt(range_select.CheckBox2,'obs_dlg',true);
   get_swt(prmdlgf.cdy_sgen,'sgen',true);
   get_swt(prmdlgf.cdy_ss,'stst',true);
   get_swt(prmdlgf.cdy_wait,'wait',false);
   get_swt(prmdlgf.chk_ssd,'bd_dynamics',false);
   get_swt(prmdlgf.cdy_dynsp,'dynsp',false);
   get_swt(prmdlgf.cdy_wgen,'wgen',false);
   get_swt(prmdlgf.lys_chkbx,'lysm',false);
   get_swt(prmdlgf.auto_soil,'auto_soil',false);
   get_swt(prmdlgf.puddle,'srf_wret',false);
   get_swt(prmdlgf.preci_chkbx,'k_prec',false);
   get_swt(prmdlgf.cdy_gis,'gism',false);

     //     get_dta(wdmode,'wdmode','KoGl');
   get_dta(prmdlgf.edit1,'y_end','31.12');
   get_dta(prmdlgf.latitude,'lat','55');
   get_num(hstr,'outfr',5);   prmdlgf.cdy_r_type.ItemIndex:=strtoint(hstr);
   get_num(hstr,'f_rain',1);  prmdlgf.cdy_rf.text  :=hstr;
   get_num(hstr,'parm_set',0);  prmdlgf.combobox1.ItemIndex:=strtoint(hstr);
   get_num(hstr,'ptf_mode',2);  prmdlgf.combobox2.ItemIndex:=strtoint(hstr);


  end;

 finally
 cdy_reg.closekey;
 cdy_reg.free;
 inherited;
 end;

  // Datenbank anpassen
 pname:='*';
 _datapath:='*';
 _simend:='*';

 sim_call:=false;
 sql_call:=false;



 for i:= 1 to paramcount do
  begin
    psi:=paramstr(i);
    if uppercase(paramstr(i))='GO' then
    begin
     sim_call:=true;
    end;

   if paramstr(i)='?' then application.MessageBox('...\cdy20_uif.EXE PDB=C:\your_dir\cdyprm.mdb DP=C:\your_data_path ','How to call the interface ',mb_ok);

   if uppercase(copy(paramstr(i),1,4))='PDB=' then
    begin
     pname:=copy(paramstr(i),5,length(paramstr(i)));
     db_f_name:=pname; //pg
    end;

   if uppercase(copy(paramstr(i),1,4))='NIM=' then
    begin
       prmdlgf.n_immi.Text:=copy(paramstr(i),5,length(paramstr(i)));
    end;

     if capital(copy(paramstr(i),1,3))='DP='
     then
     begin
        prmdlgf.pdata.cdy_data_path:=(copy(paramstr(i),4,length(paramstr(i))));
        prmdlgf.pdata.cdy_data_path:=trim(prmdlgf.pdata.cdy_data_path);
        if copy(prmdlgf.pdata.cdy_data_path,length(prmdlgf.pdata.cdy_data_path),1)<>'\'
        then prmdlgf.pdata.cdy_data_path:=prmdlgf.pdata.cdy_data_path+'\';
     end;


    if uppercase(copy(paramstr(i),1,3))='DP=' then
    begin
     _datapath:=copy(paramstr(i),4,length(paramstr(i)));
     prmdlgf.pdata.cdy_data_path:=trim(_datapath);
     if copy(prmdlgf.pdata.cdy_data_path,length(prmdlgf.pdata.cdy_data_path),1)<>'\'
     then prmdlgf.pdata.cdy_data_path:=prmdlgf.pdata.cdy_data_path+'\';
     if directoryexists(_datapath)then
     begin
          cdydpath.Text:=_datapath;
          prmdlgf.cdydpath.Text:=_datapath;
     end;
     cdy_reg:=Tregistry.Create;
     try
      cdy_reg.RootKey := HKEY_CURRENT_USER;
      cdy_reg.openkey('\Software\candy', True);
     cdy_reg.writestring('dpath',cdydpath.text);
     finally
     cdy_reg.closekey;
     cdy_reg.free;
     end; // try
    end; // if  uppercase

    (*
    if uppercase(copy(paramstr(i),1,3))='RS=' then
    begin
     _respath:=copy(paramstr(i),4,length(paramstr(i)));
    end;

    if uppercase(copy(paramstr(i),1,6))='STC_ON'
     then
     begin
   //?     _use_stc:=true;
     end;
         *)
    if uppercase(copy(paramstr(i),1,6))='DBCALL' then
    begin
     sql_call:=true;;
    end;

  // with simparm do
   begin
     (*
     if capital(copy(paramstr(i),1,5))='UNIT='
     then
     begin
        intas_mode:=true;
        unit_n:=strtoint(copy(paramstr(i),6,length(paramstr(i))));
     end;
       *)
     if capital(copy(paramstr(i),1,5))='PSET=' then
     begin
     parmset:= copy(paramstr(i),6,length(paramstr(i)));
      prmdlgf.combobox1.ItemIndex:=  prmdlgf.combobox1.Items.IndexOf(parmset);
     end;

     if capital(copy(paramstr(i),1,3))='SZ='
     then
     begin
        prmdlgf.pdata.szenari_ix:=strtoint(copy(paramstr(i),4,length(paramstr(i))));
        prmdlgf.pdata.SimObject:=copy(paramstr(i),4,length(paramstr(i)));
        prmdlgf.cdyobj.Text:=prmdlgf.pdata.SimObject;
     end;
    (* ?
     if capital(copy(paramstr(i),1,3))='RP='
     then
     begin
        prmdlgf.pdata.cdy_res_path:=(copy(paramstr(i),4,length(paramstr(i))));
        prmdlgf.pdata.cdy_res_path:=trimm(prmdlgf.pdata.cdy_res_path);
        if copy(prmdlgf.pdata.cdy_res_path,length(prmdlgf.pdata.cdy_res_path),1)<>'\'
        then prmdlgf.pdata.cdy_res_path:=prmdlgf.pdata.cdy_res_path+'\';
     end;
        *)
     {
     if capital(copy(paramstr(i),1,3))='WP='
     then
     begin
        wet_path:=capital(copy(paramstr(i),4,length(paramstr(i))));
        wet_path:=trimm(wet_path);
        if copy(wet_path,length(wet_path),1)<>'\' then wet_path:=wet_path+'\';
     end;
           }
     if capital(copy(paramstr(i),1,2))='Z='
     then
     begin
        val(copy(paramstr(i),3,length(paramstr(i))),prmdlgf.pdata.ncycl,hh);
        if hh<>0 then prmdlgf.pdata.ncycl:=1;
        prmdlgf.cdy_zz.text:= prmdlgf.pdata.ncycl.ToString;
     end;

              {
     if capital(copy(paramstr(i),1,2))='MC'
     then
     begin
        val(copy(paramstr(i),3,length(paramstr(i))),msg_class,hh);
        if hh<>0 then msg_class:=99;
     end;
             }

     if capital(copy(paramstr(i),1,3))='OF='
     then
     begin
        val(copy(paramstr(i),4,length(paramstr(i))),wdh,hh);
     //   prmdlgf.cdy_of.enabled:=true;
        case wdh of
         1: begin {daydruck:=true;} prmdlgf.cdy_r_type.itemindex:=1; end;
         5: begin {pendruck:=true;} prmdlgf.cdy_r_type.itemindex:=2; end;
        10: begin { dedruck:=true;} prmdlgf.cdy_r_type.itemindex:=3; end;
        30: begin {modruck:=true;}  prmdlgf.cdy_r_type.itemindex:=4; end;
       300: begin {yrdruck:=true;}  prmdlgf.cdy_r_type.itemindex:=5; end;
        end;
     end;
     {
     if capital(copy(paramstr(i),1,3))='DS=' then
     begin
        val(copy(paramstr(i),4,length(paramstr(i))),fert_std,hh);
        if hh=0 then   random_fert:=true;
        prmdlgf.cdy_ds.Text:=fert_std.tostring;
     end;
       }
     if capital(copy(paramstr(i),1,3))='LT=' then
     begin
        hstr:=paramstr(i);
        hstr:=copy(hstr,4,length(hstr));
        hh:=pos(',',hstr);
        if hh>0 then
        begin
          hstr:=copy(hstr,1,hh-1)+'.'+copy(hstr,hh+1,length(hstr));
        end;
        val(hstr,x,hh);
        if hh<>0 then hstr:='55';
        prmdlgf.latitude.text:=hstr ;
     end;


    if capital(copy(paramstr(i),1,3))='RF='
     then
     begin
        hstr:=paramstr(i);
        hh:=pos(',',hstr);
        if hh>0 then
        begin
          hstr:=copy(hstr,1,hh-1)+'.'+copy(hstr,hh+1,length(hstr));
        end;

        prmdlgf.cdy_rf.text:=hstr; //        val(copy(hstr,4,length(hstr)),simparm.r_faktor,hh);
     end;
           // einschub
                            (*
           if capital(copy(paramstr(i),1,5))='LTEM='
             then
             begin
                hstr:=paramstr(i);
                hh:=pos(',',hstr);
                if hh>0 then
                begin
                  hstr:=copy(hstr,1,hh-1)+'.'+copy(hstr,hh+1,length(hstr));
                end;
                val(copy(hstr,6,length(hstr)),_tul,hh);
             end;
                          *)
            // ende

            {
     if capital(copy(paramstr(i),1,3))='AF='
     then
     begin
        //auto_fert:=true;
        hstr:=paramstr(i);
        val(copy(hstr,4,length(hstr)),simparm.FERTilizer,hh);
     end;
             }
     (*
     if capital(copy(paramstr(i),1,2))='RA'
     then
     begin
        val(copy(paramstr(i),3,length(paramstr(i))),n_risk_ana,hh);
        if hh<>0 then n_risk_ana:=20;
        risk_ana:=true;
        prmdlgf.cdy_ra_wdh.Text:=n_risk_ana.tostring;
        prmdlgf.cdy_ra.checked:=true;
     end;
       *)

     if capital(copy(paramstr(i),1,2))='A='
     then
     begin
         prmdlgf.pdata.aDatum:=copy(paramstr(i),3,length(paramstr(i)));
         prmdlgf.cdyanf.date:=strtodate(copy(paramstr(i),3,length(paramstr(i))));
     end;

     if capital(copy(paramstr(i),1,2))='E='
     then
     begin
        prmdlgf.cdyend.date:=strtodate(copy(paramstr(i),3,length(paramstr(i))));
     end;

     if capital(copy(paramstr(i),1,2))='R='
     then
     begin
       prmdlgf.pdata.runname:=copy(paramstr(i),3,length(paramstr(i)));
        if uppercase(leftstr(prmdlgf.pdata.runname,3))<>'RS_' then prmdlgf.pdata.runname:='RS_'+prmdlgf.pdata.runname;
         prmdlgf.cdy_r_type.itemindex:=5;    // ausgabe frequenz im rs_table   : jährlich
//        simparm.outfile_style:=2;
        prmdlgf.cdy_fname.text:=prmdlgf.pdata.runname;
        prmdlgf.cdy_fname.enabled:=true;
     end;



     if capital(copy(paramstr(i),1,2))='P='
     then
     begin
       prmdlgf.pdata.soilprofil:=copy(paramstr(i),3,length(paramstr(i)));
       prmdlgf.cdysoil.Text:= prmdlgf.pdata.soilprofil;
     end;

    if capital(copy(paramstr(i),1,2))='O='
     then
     begin
       prmdlgf.pdata.SimObject{ objekt_id}:=copy(paramstr(i),3,length(paramstr(i)));
       prmdlgf.cdyobj.Text:=    prmdlgf.pdata.SimObject;
     end;

     if capital(copy(paramstr(i),1,2))='D='
     then
     begin
       prmdlgf.pdata.datenbank :=copy(paramstr(i),3,length(paramstr(i)));
       prmdlgf.cdydaba.text:= prmdlgf.pdata.datenbank ;
     end;

     if capital(copy(paramstr(i),1,4))='SNU='
     then
     begin
        prmdlgf.pdata.schlagnr:=rightstr('_____'+copy(paramstr(i),5,length(paramstr(i))),5);
        prmdlgf.cdyplot.text:=  prmdlgf.pdata.schlagnr;
     end;

     if capital(copy(paramstr(i),1,2))='S='
     then
     begin
        prmdlgf.pdata.schlagnr:=copy(paramstr(i),3,length(paramstr(i)));
        prmdlgf.cdyplot.text:=  prmdlgf.pdata.schlagnr;
        hstr:= prmdlgf.pdata.schlagnr;
        j:=pos('_',hstr);
        while j>0 do
        begin
         hstr:=rightstr(hstr,length(hstr)-1);
          j:=pos('_',hstr);
        end;
        prmdlgf.cdyobj.text:= hstr;
     end;

     if capital(copy(paramstr(i),1,2))='W='
     then
     begin
        prmdlgf.pdata.climate:=copy(paramstr(i),3,length(paramstr(i)));
       // if prmdlgf.pdata.climate='INKUB' then wett_fix:=''
       //                     else wett_fix :=copy(paramstr(i),6,2);
       prmdlgf.cdywett.Text:=  prmdlgf.pdata.climate
     end;

    if capital(copy(paramstr(i),1,4))='ZOF='
    then
      begin
        val(copy(paramstr(i),5,5),prmdlgf.pdata.amdy_offset,hh);
      end;

              {
    if capital(copy(paramstr(i),1,2))='Z='
    then
      begin
        prmdlgf.cdy_zz.text:= copy(paramstr(i),3,9);
         val(copy(paramstr(i),3,9),prmdlgf.pdata.ncycl,hh);
      end;
             }

    if capital(copy(paramstr(i),1,3))='ST='
    then
      begin
        hh:=pos('#',paramstr(i));
        prmdlgf.pdata.stc_file:=copy(paramstr(i),4,hh-4);
        val(copy(paramstr(i),hh+1,5),prmdlgf.pdata.s_recno,hh);
        if hh<>0 then prmdlgf.pdata.stc_file:='?'
                 else  begin
                   prmdlgf.cdy_stcfile.text:= prmdlgf.pdata.stc_file;
                   prmdlgf.cdy_srec.Text:= inttostr(prmdlgf.pdata.s_recno);
                 end;
      end;

    if capital(paramstr(i))='V+' then prmdlgf.cdy_pfl.checked :=false;

//    if capital(paramstr(i))='D+' then spm_dyn :=TRUE;

    if capital(paramstr(i))='Z+' then prmdlgf.cdy_wgen.checked:=true;

    if capital(paramstr(i))='S+' then  prmdlgf.cdy_sgen.Checked     :=true;

    if capital(paramstr(i))='SS' then begin
                                       prmdlgf.cdy_sgen.Checked     :=true;
                                       prmdlgf.cdy_ss.Checked:=true;
                                      end;

    if capital(paramstr(i))='W-' then
    begin
     prmdlgf.cdy_wait.checked:=false;
    end;

    if capital(paramstr(i))='G+' then prmdlgf.pdata.gis_mode:=true;

    if capital(paramstr(i))='L+' then
    begin

     prmdlgf.lys_chkbx.Checked:=true;
    end;
    if capital(paramstr(i))='K-' then
    begin
     prmdlgf.preci_chkbx.Checked:=false;
    end;

    if capital(paramstr(i))='K+' then
    begin
     prmdlgf.preci_chkbx.Checked:=true
    end;

    if capital(paramstr(i))='!'  then prmdlgf.go_on:=true; // kein Dialogfenster sondern gleich rechnen
   end;{for}{with simparm}


  end;



// Database connection !
  db_connect(db_f_name);

// check and repair database structure
  check_database;

  histfilename:= extractfilepath(application.ExeName)+'cdydbhist.txt';
  if fileexists(histfilename) then dbhist.Items.LoadFromFile(histfilename);
  for j:=0 to dbhist.Items.Count-1 do
    begin
      if not fileexists(dbhist.Items[j]) then dbhist.Items.Delete(j);
    end;
    application.ProcessMessages;
  // neue DB bereits enthalten ?
  j:= dbhist.Items.IndexOf(db_f_name);
  // wenn nicht zufügen
  if j<0 then  dbhist.Items.Add(db_f_name);

  // korrigierte liste zurückschreiben
  try
  dbhist.Items.SaveToFile(userhome+'\cdydbhist.txt');
  except   end;
  if rightstr(db_f_name,1)=';' then k:=1 else k:=0;

  if cdy_uif.dbhist.Items.IndexOf(leftstr(db_f_name,length(db_f_name)-k))<0
  then  dbhist.itemindex:=dbhist.items.add(leftstr(db_f_name,length(db_f_name)-k))
  else  dbhist.itemindex:=dbhist.items.IndexOf(leftstr(db_f_name,length(db_f_name)-k));
//#  disintegrate_ado_connection(ado_cdyprm.connectionstring,listbox1.items);
//#  register_ado_connection(listbox1.items);
 // bleibt die Frage ob ich auch die form prmdlgf aktivieren könnte zwecks dialog
 // simparm sind nicht gesetzt
 // cdymain.batch_line:=cdymain.batch_line+' ! ';

   check_database;


// ist noch nicht "scharf" ,da candy nicht existiert   :  cnd_rs_2.initialize_results;
  if sim_call  then
  begin


  // Fehlende Daten aus FDA abfragen !!! wie z.B. N-immission

   //?  qry.sql.Clear;
  //?   qry.sql.Add('select * from cdy_fxdat   where fname='+''''+trim(fieldbyname('fname').asstring)+''''+' and snr='+trim(fieldbyname('snr').asstring));
  //?   qry.ExecSQL;

       prmdlgf.Showmodal;
       cdy_uif.close;
       application.Terminate;
       application.MessageBox('BAU','STELLE',mb_ok);
  end;

  if sql_call then
  begin
   sim_call:=true;
   with fdc.cdyctrl do
   begin
     sql.Clear;
     sql.Add( ' SELECT Str([STOPDAT]+1) AS anf, netsoil.profile AS prfl, netclim.wstat AS wst, cdy_link.R_faktor AS rf,');
     sql.Add( ' cdy_link.plot_id AS obj, netplot.srecno, netplot.fname, netplot.snr, netplot.utlg ');
     sql.Add( ' FROM ((netclim INNER JOIN (netsoil INNER JOIN (net INNER JOIN cdy_link ');
     sql.Add( ' ON net.Id = cdy_link.net_id) ON netsoil.soil_id = cdy_link.soil_id) ');
     sql.Add( ' ON netclim.climate_id = cdy_link.climate_id) INNER JOIN netplot ON ');
     sql.Add( ' (cdy_link.net_id = netplot.net_id) AND (cdy_link.plot_id = netplot.plot_id) ');
     sql.Add( ' AND (cdy_link.plot_id = netplot.plot_id)) INNER JOIN cdy_fxdat ON ');
     sql.Add( ' (netplot.fname = cdy_fxdat.FNAME) AND (netplot.snr = cdy_fxdat.SNR) AND (netplot.utlg = cdy_fxdat.UTLG) ');
     sql.Add( ' WHERE net.active=1 and cdy_link.cdy_call=1  ');
     open;
     first;
     repeat
     // build batch_line
        application.MessageBox('BAU','STELLE2',mb_ok);
      {
      cdymain.batch_line:= 'A='+trim(fieldbyname('anf').asstring)+' E='+_simend+ ' D=' +trim(fieldbyname('fname').asstring);
      cdymain.batch_line:= cdymain.batch_line + ' S='+rightstr('_____'+trim(fieldbyname('snr').asstring)+trim(fieldbyname('utlg').AsString),5);
      cdymain.batch_line:= cdymain.batch_line + ' O='+trim(fieldbyname('obj').AsString);
      cdymain.batch_line:= cdymain.batch_line + ' W='+trim(fieldbyname('wst').AsString);
      cdymain.batch_line:= cdymain.batch_line + ' RF='+trim(fieldbyname('rf').AsString);
      cdymain.batch_line:= cdymain.batch_line + ' P='+trim(fieldbyname('prfl').AsString);
      if _respath<>'*' then cdymain.batch_line:= cdymain.batch_line + ' R='+ _respath;
      if _datapath<>'*' then cdymain.batch_line:= cdymain.batch_line + ' DP='+ _datapath;
      // outputfrequency
      OF_:='1';
      if _use_stc
      then
      begin
       stc:=_datapath+'\'+trim(fieldbyname('fname').asstring)+'.stc';
       cdymain.batch_line:= cdymain.batch_line + ' OF='+of_+' W- P- G+ L- Z- D- K+ S- GO ST='+ stc+'#'+trim(fieldbyname('srecno').AsString);
      end
      else cdymain.batch_line:= cdymain.batch_line + ' OF='+of_+' W- P- G+ L- Z- D- K+ S+ SS GO ';

      cdymain.Show;
      cdymain.do_it;
      cdy_uif.close;
      next;
      }
     until eof;

     // Status zusammenfassen
      compress_stc(0,_datapath+'\', trim(fieldbyname('fname').asstring));

    // letzten stop aktualisieren

     fdc.hqry.sql.Clear;
     fdc.hqry.sql.Add('update cdy_fxdat set stopdat='+''''+_simend+''''+' where fname='+''''+trim(fieldbyname('fname').asstring)+''''+' and snr='+trim(fieldbyname('snr').asstring));
     fdc.hqry.ExecSQL;
    end;    //with
  end; //sqlcall



 end;  //procedure





procedure Tcdy_UIF.compress_stc(sz_id:integer;   s_path, base_name:string);
//                              |                   |       |
//                              |                   |        --Basis name für stc
//                              |                   |       (für alle stc-files konstant)
//                              |                   |
//                              |                   | --Verzeichnis für STC-file
//                              --scenaro_id
//
//
var fname,objektnr,stc_name:string;
    all_recs:integer;
    ks:statrec;
    iobjekt,
    stnr:integer;
    (*
    objektliste: p_obj_lst;
    qry{,gislst}:tquery;
    *)
    crop:string;
begin
  stc_name:=base_name;//sim_scen.fieldbyname('stc_file').asstring;   // name des 'großen' Statuscatalogs, der alle einzelrecords zusammenfasst
//  qry:=tquery.Create(nil);
//  qry.DatabaseName:='lasa';

if fileexists(s_path+stc_name+'.stc') then
begin
  if fileexists(s_path+stc_name+'.bst') then  deletefile(s_path+stc_name+'.bst');
  renamefile(s_path+stc_name+'.stc',s_path+stc_name+'.bst' );
  deletefile(s_path+stc_name+'.stc');
end;

  stc_create(s_path+stc_name+'.stc');          // neue Datei erzeugen
//  query2.Open;                          // objektliste öffnen
//  query2.First;
//  all_recs:=query2.RecordCount;
//  progressbar1.max:=all_recs;
//  while not query2.eof do     // für jeden record den Status übertragen
fdc.cdyctrl.First;
while not fdc.cdyctrl.eof do
  begin
//     ProgressBar1.StepBy(1);
//    objektnr:=query2.fieldbyname('cdy_objekt').asstring;

     objektnr:=fdc.cdyctrl.fieldbyname('obj').asstring;
     fname:=s_path+'GIS'+base_name+objektnr+'.stc';
     if fileexists(fname) then
     begin
     status_lesen(fname,0,ks);
     stnr:=-1;
     status_schreiben(s_path+stc_name,ks,stnr);
     end else stnr:=-99;


     fdc.hqry.sql.Clear;
     fdc.hqry.sql.Add('update netplot set srecno='+inttostr(stnr)+' where fname='+''''+base_name+''''+' and plot_id='+objektnr);
     fdc.hqry.ExecSQL;

    // query2.next;
    fdc.cdyctrl.Next;
   end;
   //query2.close;
   //qry.Free;

end;

procedure Tcdy_UIF.dbhistKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
 var a: word;
     ok,i:integer;
     ditem,histfilename:string;
begin
  a:=key;
  if a=46  then
  begin
    ditem:=dbhist.Items[dbhist.itemindex];
    ok:=application.MessageBox(pwidechar(ditem),'delete this item from list?',mb_yesno);
    if ok=idyes then
    begin
      i:=dbhist.ItemIndex;
      dbhist.DeleteSelected;
      histfilename:= extractfilepath(application.ExeName)+'cdydbhist.txt';
      dbhist.Items.SaveToFile(histfilename);
      dbhist.Items.Clear;
      dbhist.Items.loadfromFile(histfilename);
    end;
  end;

   application.ProcessMessages;
   dbhist.ItemIndex:=0;
   dbhist.refresh;
   application.ProcessMessages;
 //#  cdy_ado.switchdatasource(ado_cdyprm, dbhist.Items[0],listbox1);
 //#  register_ado_connection(listbox1.Items);
   db_f_name:=dbhist.Items[0];

   dbhist.ItemIndex:=0;

   db_connect(db_f_name);
   //dbhist.refresh;
   application.ProcessMessages;
end;



procedure Tcdy_UIF.dbhistCloseUp(Sender: TObject);
begin
//    cdy_ado.switchdatasource(ado_cdyprm,  dbhist.Items[dbhist.ItemIndex]     ,listbox1);
//    register_ado_connection(listbox1.Items);
    db_f_name:=dbhist.Items[dbhist.ItemIndex];
    db_connect(db_f_name);
end;


{
procedure Tcdy_UIF.form_init_bde;
var modus,pname, _datapath,_clipath,_respath,h:string;
    list,slist :Tstringlist;
    i,pcnt,id:integer;
    x:real;

begin


end;
       }


procedure Tcdy_UIF.Image1DblClick(Sender: TObject);
begin
 //frm_settings.show;
end;



procedure Tcdy_UIF.FormActivate(Sender: TObject);
var
PersistStream: IPersistStreamInit;
   Stream: IStream;
   FileStream: TFileStream;
   wpath,aline,newsline:string;
   hfile:textfile;
   p0,p1,nn,ln:integer;
   cnt:boolean;
begin
exit;
if message_shown or sim_call then exit;
 cnt:=false;
 try
 cnt:=InternetCheckConnection(pwideChar('https://www.ufz.de/index.php?de=42459'),1,0);
 except;end;
 if  cnt then
 begin
   cdy_reg:=Tregistry.Create;
   cdy_reg.RootKey := HKEY_CURRENT_USER;
   if cdy_reg.OpenKey('\Software\candy', False)
   then
   begin
     ln:=0;
     try ln:= cdy_reg.ReadInteger('imsg'); except;  end;
     try wpath:= cdy_reg.readstring('ppath'  ); except;  end;
     wb.Hide;
     wb.Navigate('https://www.ufz.de/index.php?de=42458');
     while Wb.ReadyState < READYSTATE_INTERACTIVE do   Application.ProcessMessages;
     if   Assigned(WB.Document) then
     begin
       PersistStream := WB.Document as IPersistStreamInit;
       FileStream := TFileStream.Create(wpath+'\tmp_news.html', fmCreate) ;
       try
         Stream := TStreamAdapter.Create(FileStream, soReference) as IStream;
         if Failed(PersistStream.Save(Stream, True)) then ShowMessage('SaveAs HTML fail!') ;
       finally
         FileStream.Free;
       end;
       assignfile(hfile,wpath+'\tmp_news.html');
       reset(hfile);
       repeat
         readln(hfile,aline);
         aline:=utf8tostring(aline);
       until eof(hfile) or ( pos('#',aline)>0);
       p0:=pos('#',aline);
       p1:=pos('*end',aline);
       aline:=copy(aline,p0,p1-p0-1);
       p0:=pos('#',aline);
       repeat
         p1:=pos(':',aline);
         nn:=strtoint(copy(aline,p0+1,p1-p0-1));
         aline:=copy(aline,p1,length(aline));
         p0:=pos('<p>',aline)  ;
         aline:=copy(aline,p0+3,length(aline));
         p1:=pos('</p',aline) ;
         newsline:=leftstr(aline,p1-1);
         if nn>ln then
         begin
          p1:=pos('<br',newsline);
          if p1>0 then newsline:=leftstr(newsline,p1-1);

          cdynews.newslist.items.add(newsline);
          //listbox2.Items.Add(newsline);
         end;
         aline:=copy(aline,p1,length(aline));
         p0:=pos('#',aline);
       until (p0=0) ;
       if nn>ln then
       begin
         if not message_shown then
         begin
          cdynews.ShowModal;
          message_shown:=true;
         if cdynews.MResult=2 then
           begin
            try cdy_reg.writeinteger('imsg',nn     );  finally;inherited;   end;
           end;
         end;
       end;
       closefile(hfile);
     end;
     cdy_reg.Free;
   end;
 end;
end;

procedure Tcdy_UIF.FormCreate(Sender: TObject);
var p:widestring;
    a,b,c,d:word;
procedure GetBuildInfo(var V1, V2, V3, V4: Word);
{From Steve Schafer }
var
  VerInfoSize: DWORD;
  VerInfo: pointer;
  VerValueSize: DWORD;
  VerValue: PVSFixedFileInfo;
  Dummy: DWORD;

begin
  VerInfoSize := GetFileVersionInfoSize(PChar(ParamStr(0)), Dummy);
  GetMem(VerInfo, VerInfoSize);
  GetFileVersionInfo(PChar(ParamStr(0)), 0, VerInfoSize, VerInfo);
  VerQueryValue(VerInfo, '\', pointer(VerValue), VerValueSize);
  with VerValue^ do
    begin
      V1 := dwFileVersionMS shr 16;
      V2 := dwFileVersionMS and $FFFF;
      V3 := dwFileVersionLS shr 16;
      V4 := dwFileVersionLS and $FFFF;
    end;
  FreeMem(VerInfo, VerInfoSize);
end;



begin
dbhist.Items.clear;
startdir:=getcurrentdir;
 p:=extractfiledir(application.ExeName)+'\';
 grassmind_dll:= fileexists(p+'forgrassmind.dll') ;
 message_shown:=false;
 getbuildinfo(a,b,c,d);
 statusbar1.Panels[3].Text:=' version: '+inttostr(a)+inttostr(b)+'.'+inttostr(c)+':'+inttostr(d);
 //form_init;
end;

procedure Tcdy_UIF.FormShow(Sender: TObject);
var h:boolean;
begin
//if cdy_uif.winmode then  cdy_edit.profiles.dataset:=cdy_edit.prof_win;
// karte.GetShapes;
// if karte.has_shapes then button7.visible:=true;
(*
 cdy_reg:=tregistry.Create;
 cdy_reg.RootKey := HKEY_CURRENT_USER;
 h:=cdy_reg.OpenKey('\Software\candy\switches',false);
 cdy_reg.CloseKey;
 cdy_reg.Free;
 cdy_reg:=NIL;
 *)
// if (not h) then frm_settings.Show else frm_settings.read_registry;
// frm_settings.saveClick(nil);

end;

procedure Tcdy_UIF.Button6Click(Sender: TObject);
begin
sql_form.show;
end;

procedure Tcdy_UIF.Button7Click(Sender: TObject);
begin
{
 range_select.a_path:=cdydpath.Text;
 range_select.show;
 karte.Destroy;
 application.createForm(Tkarte,karte);
 karte.GetShapes;
 karte.show;

 ado_cdyprm.Close;
 if EditConnectionString(ado_cdyprm) then     disintegrate_ado_connection(ado_cdyprm.connectionstring,listbox1.items);;
 ado_cdyprm.open;
 register_ado_connection(listbox1.items);   }
end;

procedure Tcdy_UIF.Button9Click(Sender: TObject);
 var list:tstringlist;  h1,h2:string;
     cdy_ini:Tregistry; i,j:integer;
begin

 if opendialog1.execute then
 begin
   // neuen Namen feststellen
   db_f_name:=opendialog1.FileName ;
   cdy_ini:=Tregistry.Create;
   try
    cdy_ini.RootKey := HKEY_CURRENT_USER;
    if cdy_ini.OpenKey('\Software\candy', False)
    then cdy_ini.writestring('database',db_f_name);
    finally
    cdy_ini.closekey;
    cdy_ini.free;
    inherited;
   end;
 end else exit;
 db_connect(db_f_name);
 check_database;
end;

procedure Tcdy_UIF.cdyparmAfterConnect(Sender: TObject);
begin
 // cdy_uif.cdyparm.Session.getaliasparams('cdyparm_',listbox1.items);
  writeprotokoll('db connected');
end;





procedure Tcdy_UIF.Button10Click(Sender: TObject);
begin
 //cdy_res_view.rdir:=cdydpath.text;
cdy_res_view.show;
end;

procedure Tcdy_UIF.Button11Click(Sender: TObject);
begin
  range_select.find_wetter_stat;
 // cli_tool.cb_wstat.Items:=   range_select.fda_wett.items;
 // cli_tool.wstat_clb.Items:=   range_select.fda_wett.items;
  cli_tool.show;
end;

procedure Tcdy_UIF.Button12Click(Sender: TObject);
begin
// frm_sze_stat.show;
end;

procedure Tcdy_UIF.cdydpathChange(Sender: TObject);
begin
// checkcdydpath;
end;

procedure Tcdy_uif.checkcdydpath;
begin
 if cdydpath.Text='?' then exit;
 
 if not Directoryexists(trim(cdydpath.Text)) then
 begin
  application.MessageBox('path of access database will be adopted', 'non existing datapath in registry', mb_ok);
  cdydpath.Text:= extractfiledir(db_f_name);
  if not Directoryexists(trim(cdydpath.Text))then cdydpath.Text:='?';
//  cdy_reg:=Tregistry.Create;
  try
//   cdy_reg.RootKey := HKEY_CURRENT_USER;
//   if cdy_reg.OpenKey('\Software\candy', True)
//   then
//    begin
     cdy_reg.WriteString('dpath', cdydpath.text);
     cdy_reg.WriteString('rpath', cdydpath.text );
//    end;
  finally
 //  cdy_reg.closekey;
 //  cdy_reg.free;
   inherited;
  end;
 end;
application.ProcessMessages;
end;


procedure Tcdy_UIF.cdywpathChange(Sender: TObject);
begin
{
 if DirectoryExists(cdywpath.Text) then
 begin
 cdy_we_conn.close;
 cdy_we_conn.connectionstring:=cs1+cdywpath.text+cs3+'Extended Properties="dBASE III";';
 cdy_we_conn.open;
 end;
 }
end;

procedure Tcdy_UIF.db_connect(dbname:string);

var host,port,user,pw,db,inifile:string;
     dbini: Tinifile;
    histfilename,
    drv  :string;
    cdy_ini:tregistry;
    i,j:integer;
begin
  i:=pos('[',dbname);
  j:=pos(']',dbname);
  if j>0 then dbname:=copy(dbname,i+1,j-i-1);


  dbc.Close;
  dbc.Params.Clear;
  if UpperCase(rightstr(dbname,3))='MDB' then
  begin
    // try to connect to access
    dbc.Params.Add('Database='+dbname);
   dbc.Params.Add('DriverID='+'MSAcc');
   dbc.LoginPrompt:=false;
   dbc.Name:='dbc';
   try
   dbc.Open;
   except    end;
  end
  else
   begin      //assuming local pg
   host:='127.0.0.1';
   port:='5432';
   user:='candy_user';
   pw:='candy_go';

   inifile:=extractfilepath(application.ExeName)+'pg4candy.ini';
   dbini:=tinifile.Create(inifile);
   drv :=dbini.ReadString('[driver]','w32',' ');
   if dbini.SectionExists(dbname) then
   begin
     port:=dbini.ReadString(dbname,'port','5432');
     host:=dbini.ReadString(dbname,'host','127.0.0.1');
     user:=dbini.ReadString(dbname,'user','candy_user');
     pw  :=dbini.ReadString(dbname,'pw','candy_go');
   end;




    // ?   DB:=dbname;
   //treiber sind in : c:\Users\Public\Documents\Embarcadero\Studio\FireDAC\
   try
   dbc.open('DriverID=PG; Server='+host+'; Port='+port+'; User_NAME='+user+'; Password='+pw+'; Database='+dbname);
   except   end;
  end;

  if not dbc.Connected then
  begin
    if application.MessageBox('please select a proper database!','no database found',mb_okcancel)=id_ok
    then
    begin
    if opendialog1.Execute then
    begin
      dbname:=opendialog1.FileName;
      db_connect(dbname);
    end;
    end else application.Terminate;
  end;

   histfilename:= extractfilepath(application.ExeName)+'cdydbhist.txt';
   if fileexists(histfilename) then cdy_uif.dbhist.Items.LoadFromFile(histfilename);

  if dbc.connected then
  begin
   if cdy_uif.dbhist.Items.IndexOf(dbname)<0 then
    begin
    cdy_uif.dbhist.ItemIndex:=cdy_uif.dbhist.Items.Add(dbname);

    cdy_uif.dbhist.Items.SaveToFile(histfilename);
    end;
   cdy_uif.dbhist.ItemIndex:=cdy_uif.dbhist.Items.IndexOf(dbname);

    // Registrierung aktualisieren
   cdy_ini:=Tregistry.Create;
   try
    cdy_ini.RootKey := HKEY_CURRENT_USER;
    if cdy_ini.OpenKey('\Software\candy', False)
    then
     begin
      cdy_ini.writestring('database',dbname);
     end;
    finally
    cdy_ini.closekey;
    cdy_ini.free;
    inherited;
   end;
  end;
 end;



procedure Tcdy_UIF.db_disconnect;
var i:integer;
begin
 for i:=dbc.DataSetCount-1 downto 0 do
 begin
 try
  dbc.DataSets[i].disconnect(true);
 except
 end;
 end;
 dbc.Close;
 dbc.Free;
end;


procedure Tcdy_UIF.StatusBar1DblClick(Sender: TObject);
begin
  // frm_devinf.show;
end;
end.
