unit prmdlg2;
interface
uses  sharemem,

 cdy_glob,
 //DELPHI
Windows, Messages, SysUtils, Classes, Graphics, Controls, Dialogs,dateutils,
strutils, ComCtrls, StdCtrls, ExtCtrls,Forms, Mask,math,{ adodb,}Db,registry,
  FireDac.Dapt,
  FireDAC.Comp.Client;

type

  Tprmdlgf = class(TForm)
    cdydpath: TEdit;
    Label1: TLabel;
    Button1: TButton;
    Button2: TButton;
    cdy_r_type: TRadioGroup;
    cdy_fname: TEdit;
    Button3: TButton;
    ListBox1: TListBox;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    cdy_pfl: TCheckBox;
    preci_chkbx: TCheckBox;
    cdy_dynsp: TCheckBox;
    cdy_wgen: TCheckBox;
    cdy_sgen: TCheckBox;
    cdy_ss: TCheckBox;
    cdy_wait: TCheckBox;
    lys_chkbx: TCheckBox;
    Label13: TLabel;
    cdy_zz: TEdit;
    UpDown1: TUpDown;
    Label11: TLabel;
    cdy_srec: TEdit;
    Label19: TLabel;
    Label10: TLabel;
    cdy_stcfile: TEdit;
    cdy_gis: TCheckBox;
    Label12: TLabel;
    cdyobj: TEdit;
    Label15: TLabel;
    cdy_rf: TEdit;
    Edit1: TEdit;
    OpenDialog1: TOpenDialog;
    GroupBox4: TGroupBox;
    GroupBox5: TGroupBox;
    chk_ssd: TCheckBox;
    ComboBox1: TComboBox;
    Label9: TLabel;
    Label3: TLabel;
    cdyanf: TDateTimePicker;
    Label4: TLabel;
    cdyend: TDateTimePicker;
    Label5: TLabel;
    cdydaba: TEdit;
    Label6: TLabel;
    cdyplot: TEdit;
    Label7: TLabel;
    cdysoil: TEdit;
    Label8: TLabel;
    cdywett: TEdit;
    Label17: TLabel;
    rslst: TComboBox;
    puddle: TCheckBox;
    auto_soil: TCheckBox;
    Label2: TLabel;
    latitude: TEdit;
    ComboBox2: TComboBox;
    Label14: TLabel;
    Label16: TLabel;
    n_immi: TEdit;
    pgb1: TProgressBar;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure cdy_ssClick(Sender: TObject);
    procedure cdy_sgenClick(Sender: TObject);
    procedure UpDown1Click(Sender: TObject; Button: TUDBtnType);
 //   procedure UpDown2Click(Sender: TObject; Button: TUDBtnType);
//    procedure cdy_raClick(Sender: TObject);
    procedure cdy_r_typeClick(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure ComboBox1CloseUp(Sender: TObject);
    procedure ListBox1DblClick(Sender: TObject);
    procedure rslstChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);

    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private-Deklarationen }
    const
     got_hints:boolean=false;
    procedure save_switches;
//    procedure read_switches;
  public
    { Public-Deklarationen }
     pdata: PCdyConnex;
     odbc:integer;
     SIWA_EXCEL:boolean;
     db_alias,
     dbg_table:string;
     wait,
     go_on:boolean;
     function new_res_fname:string;
     procedure init_parmset_selection;


 function  GetMemoryUsed: UInt64;
  end;

var
  prmdlgf: Tprmdlgf;

implementation
uses
//CANDY
 selres, candy_uif, scenario,cnd_vars, cdyparm, dllcandy;
{$R *.DFM}

     // externe functions aus candy dll
{
procedure CdyLink(pRcrd: PCdyConnex);  stdcall; external 'CDY2020_DLL' index 1;
procedure cdy_init(var d: PCdyConnex); stdcall; external 'CDY2020_DLL' index 2;
procedure db_close;                   stdcall; external 'CDY2020_DLL' index 3;
 }



    (* test                                                                                   *)
//------------------------------------------------------------------------------


function Tprmdlgf.GetMemoryUsed: UInt64;
var
  st: TMemoryManagerState;
  sb: TSmallBlockTypeState;
begin
  GetMemoryManagerState(st);
  result :=  st.TotalAllocatedMediumBlockSize +
           + st.TotalAllocatedLargeBlockSize;
  for sb in st.SmallBlockTypeStates do begin
    result := result + sb.UseableBlockSize * sb.AllocatedBlockCount;
  end;
end;



function Tprmdlgf.new_res_fname:string;
var rname,hname,rpath:string;
    rnr  :integer;
begin
  rnr:=0;
  hname:=cdy_fname.Text;
  new_res_fname:=  hname;
end;


procedure Tprmdlgf.rslstChange(Sender: TObject);
begin
cdy_fname.Text:=rslst.text;
end;

procedure Tprmdlgf.Button1Click(Sender: TObject);

var
  dataset: Tesscdyconnex;
 // fda: tadotable;
  i,
  litem: integer;
  hyr,
  _stepdat,
  hstr: string;
  fileFneu: string;
  x: extended;
  p: pointer;
  tt: double;
  tester: PChar;
  numbpft,grp:integer;

  cdy_ini:Tregistry;
  amsg:Pmsg_rec;
begin
  //store the current settings for the next call
   listbox1.Items.add('pre-go: '+inttostr(GetMemoryUsed));
  save_switches;    // Vollständig ?
  //**************** initialization of CANDY ***********************************
 // new(pdata);
  with pdata^ do
   begin
      first_msg:=nil;          last_msg :=nil;

      CandyMode:=-99;    Cums:=-99;
      aprm_idx :=1;  // standard  , pset 'NORM'
      aDatum:='';     eDatum:='';      CDY_Data_Path:='';    cdy_res_path:='';
      climate:='';    SoilProfil:='';  SimObject:='';        DatenBank:='';
      SchlagNr:='';   Aussaat:='';     Ernte:='';             Variety:='';
      Datum_  :='';   RunName:='';

      soildepth:=0;      nRoot:=0;      litter1:=0;      litter2:=0;
      Cover:=0;          Height:=0;     NShoot:=0;       clitter1:=0;
      clitter2:=0;       Telu:=0;       Glob:=0;         Rain:=0;

      for i := 1 to 20 do
      begin
      wRem[i]:=0;        nRem[i]:=0;           aRem[i]:=0;         nOps[i]:=0;
      BTem[i]:=0;        wCon[i]:=0;           wPot[i]:=0;         nCon[i]:=0;
      aCon[i]:=0;        wilk[i]:=0;           fkap[i]:=0;         pvol[i]:=0;
      end;

      cdy_db:=cdy_uif.db_f_name;
      CDY_Data_Path := cdy_uif.cdydpath.text;
      cdy_res_path := cdy_uif.cdydpath.text;
   end;
// optional state settings
   pdata.s_recno :=strtoint(cdy_srec.Text);
   pdata.stc_file:=cdy_stcfile.Text;

  pdata.first_msg := nil;                                                         // Message Liste auf NIL
  pdata.last_msg := nil;
 //simulation object
  pdata.SoilProfil := cdysoil.Text;                                               // wichtig: Bezeichner des Boden-Profils in den CANDY-Parametern ; Tabellen profile und cndhrzn
  pdata.aDatum := datetostr(cdyanf.Date);                                         // wichtig: Anfangs- und End-Datum in den Maßnahmen und Meßwerten
  pdata.eDatum := datetostr(cdyend.Date);
  pdata.end_Dt := datetostr(cdyend.Date);
  pdata.SimObject := sysutils.stringreplace(cdyplot.Text,'_','',[rfReplaceAll]) ;                                               // wichtig: Objekt_id in der Resulttabelle
  pdata.SchlagNr  := cdyplot.Text;// rightstr('_____' + Edit2.Text, 5);           // wichtig: Identifikation des Schlages in Meßwert, Maßnahme und Festdaten
  pdata.DatenBank := cdydaba.Text;//.items[ComboBox1.ItemIndex];                  // wichtig: Identifikatin der Region (alias Folder, Betrieb, Gruppe ....)
  pdata.climate   := cdywett.text; //'*';
  pdata.fda_latitude:=strtofloat(latitude.Text);
  pdata.fda_immi:=strtofloat(n_immi.Text);
  pdata.gis_mode  := cdy_gis.Checked;
 //(some) dummy initial conditions
  pdata.Cums := 9;                                                             // sinnvolle Anfangswerte ?
  pdata.rain := -999;    pdata.Glob := -999;      pdata.Telu := -999;
   // definition of standard litter    pdata.litter1 := 1;      pdata.litter2 := 9;

  // -------- CDY:INITIALISIERUNG ----------------------------------------------
  pdata^.RunName := rslst.Text;                                                 // beliebiges Label
  pdata^.CandyMode:=1;
 //K pdata.rain := 60;    // GANZ W I C H T I G :  NUR für die Initialisierung steht im RAIN attribute die N-Immission !!!

  cdy_init(pdata);    // eigentlich wenig essentieller, einmaliger (!) Aufruf der Initialisierung zur Vorbereitung der CANDY-Objekte

  CdyLink(pdata);  // eigentlicher Initialisierungsschritt mittels CandyMode=1
  // --------- CDY: ENDE INITIALISIERUNG ---------------------------------------
  cdyanf.Date:=strtodate(pdata.aDatum);   // if stc initialization was selected
  //---------- CDY: SCENARIO RUN -----------------------------------------------
  pgb1.Min:=0;
  pgb1.Max:=  yearof(cdyend.Date)-yearof(cdyanf.Date);

 // pgb1.Max:= round( (cdyend.Date)-(cdyanf.Date));
  pgb1.position:=pgb1.min;
  repeat
    pdata.Datum_ := datetostr(cdyanf.Date);
    hyr:=trim(inttostr(yearof(cdyanf.Date)));
    _stepdat:='31.12.'+hyr;                             // Datum setzen
    pdata.eDatum :=  datetostr(cdyanf.Date);
    pdata.end_dt := _stepdat;//datetostr(DP3.Date);
     // **************** CANDY Aufruf mit Modus 0 !!! *****************************
    pdata.CandyMode := 0;
    CdyLink(pdata);
    if pdata.first_msg <> pdata.last_msg then                                     // evtl wichtig: Auslesen der Message-Liste
    begin
      amsg := pdata.first_msg;
      repeat
        if amsg.neu then
        begin
          if amsg.code < 9 then
          begin
            litem := ListBox1.items.Add(amsg.message);
            ListBox1.ItemIndex := litem;
            application.ProcessMessages;
          end;
          amsg.neu := false;
        end;
        amsg := amsg.Next;
      until amsg = nil;
    end;
    application.ProcessMessages;
      if wait then
      begin
       if application.MessageBox('you want to stop the running simulation ?','break requested ?',mb_yesno)=id_yes then exit;
       wait:=false;
      end;
    cdyanf.Date:=strtodate(_stepdat)+1;
    pgb1.Position:= pgb1.Max -  (yearof(cdyend.Date)-yearof(cdyanf.Date));
  // pgb1.Position:=  pgb1.Position+1; //.Max -  round((cdyend.Date)-(cdyanf.Date));
  until strtodate(_stepdat)>=cdyend.Date;

   // ************** CANDY-Absch(l)iessen ****************************************

    pdata.CandyMode := -2;           // shutdown vorbereiten
    CdyLink(pdata);         // alle Objekte schliessen, ausser Message-Liste
    db_close;           // Datenbank-Verbindung für DLL beenden

    with pdata^ do
    begin                                         // message-Liste killen
      while first_msg <> NIL do
      begin
        last_msg := first_msg;
        first_msg := first_msg^.Next;
        dispose(last_msg);
      end;
    end;

    if pdata <> nil then dispose(pdata);              // Verbindungsrecord killen
    pdata := nil;

    listbox1.ItemIndex:=listbox1.Items.add('post-go: '+inttostr(GetMemoryUsed));
    listbox1.ItemIndex:=listbox1.Items.add('CANDY run finished !');
    ListBox1.items.SaveToFile('candymsg.$$$');

    if go_on then application.Terminate   // automode ?
    else application.MessageBox('click OK to go to continue', 'Simulation finished', mb_ok );
    prmdlgf.close;

end;

procedure Tprmdlgf.Button2Click(Sender: TObject);
var creg:Tregistry;
begin
 modalresult:=mrcancel;

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


//cdymain.close;
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





procedure Tprmdlgf.cdy_r_typeClick(Sender: TObject);
begin
 if cdy_r_type.itemindex>0
  then button3.enabled:=true
  else button3.enabled:=false;
 if cdy_r_type.itemindex>0
  then begin  cdy_fname.enabled:=true;  end
  else begin  cdy_fname.enabled:=false; end;
end;


procedure Tprmdlgf.Button3Click(Sender: TObject);
begin
   save_switches;
   sel_res_frm.show;
end;

procedure Tprmdlgf.FormActivate(Sender: TObject);
var switch_reg :Tregistry;
 akey,i:integer;
 hname:string;
 tnlist:tstrings;
 msz:longint;
begin


if not got_hints then cdy_uif.get_hints('prmdlgf',prmdlgf);
got_hints:=true;
 switch_reg:=Tregistry.Create;
 try
  switch_reg.RootKey := HKEY_CURRENT_USER;
  if switch_reg.openkey('\Software\candy',False)
  then
  begin
  akey:=1;
  try
    akey:=  switch_reg.ReadInteger('cdykey');
  except;   end;

 { try
   cdy_fname.Text:= switch_reg.ReadString('restab');
  except
   cdy_fname.Text:='RS_simres';
  end;
  }

  listbox1.Clear;
  listbox1.Items.add('pre-go: '+inttostr(GetMemoryUsed));

  end;

  if (akey mod 3)=0 then   chk_ssd.Enabled:=true;


  //if (akey mod 5)=0 then    chk_swms.Enabled:=true;
  //if (akey mod 7)=0 then     gd_edt.Enabled:=true;

  if switch_reg.OpenKey('\Software\candy\switches', False)
  then
  begin
     //chk_cips.Checked:=switch_reg.ReadBool('cips');
     chk_ssd.Checked:=switch_reg.ReadBool('bd_dynamics');
     //chk_swms.Checked:=switch_reg.ReadString('wdmode')='DARCY';
     //gd_edt.Text     :=switch_reg.ReadString('gdmode');
     cdy_pfl.checked   :=  switch_reg.readbool('cdypfl');
   //ist wirkungslos  cdy_dynsp.checked :=  switch_reg.readbool('dynsp');
     cdy_wgen.checked  :=  switch_reg.readbool('wgen');
     cdy_sgen.checked  :=  switch_reg.readbool('sgen');
     cdy_ss.checked    :=  switch_reg.readbool('stst');
     cdy_wait.checked  :=  switch_reg.readbool('wait');
     //cdy_prs.checked   :=  switch_reg.readbool('prsm');
     lys_chkbx.checked :=  switch_reg.readbool('lysm');
     cdy_gis.checked   :=  switch_reg.readbool('gism');
     if switch_reg.ValueExists('y_end')
     then  edit1.Text:=switch_reg.ReadString('y_end')
     else  edit1.text:='31.12';
     //preci_chkbx.checked   :=  switch_reg.readbool('k_prec');
     cdy_r_type.itemindex  :=  switch_reg.ReadInteger('outfr');
//     if simparm.outfile_style<0 then
//     cdy_r_type.itemindex:=switch_reg.readInteger('outfm');
     if     switch_reg.ValueExists('siwa_excel')
        then  siwa_excel:=switch_reg.readbool('siwa_excel')
        else  siwa_excel:=false;
     if     switch_reg.ValueExists('debug')
        then dbg_table:=switch_reg.readstring('debug')
        else  dbg_table:='?';

   end
  else
   begin
    switch_reg.CreateKey('\Software\candy\switches');
    switch_reg.openkey('\Software\candy\switches', false);
    switch_reg.writebool('cdypfl',cdy_pfl.checked);
    switch_reg.writebool('dynsp',cdy_dynsp.checked);
    switch_reg.writebool('wgen',cdy_wgen.checked);
    switch_reg.writebool('sgen',cdy_sgen.checked);
    switch_reg.writebool('stst',cdy_ss.checked);
    switch_reg.writebool('wait',cdy_wait.checked);
//    switch_reg.writebool('prsm',cdy_prs.checked);
    switch_reg.writebool('lysm',lys_chkbx.checked);
    switch_reg.writebool('gism',cdy_gis.checked);
    switch_reg.writebool('k_prec',preci_chkbx.checked);
    switch_reg.WriteInteger('outfr',cdy_r_type.itemindex);
//    switch_reg.WriteInteger('outfm',cdy_r_type.itemindex);
   end;
 finally
 switch_reg.closekey;
 switch_reg.free;
 inherited;
 end;

 if cdy_fname.Text='' then cdy_fname.Text:='RS_demo';
 // find available RS_tables
 tnlist:=tstringlist.Create;
 cdy_uif.dbc.gettablenames('','','',tnlist);
// cdy_uif.ado_cdyprm.GetTableNames(tnlist,false);
 rslst.items.add(cdy_fname.text);
 for i:=1 to tnlist.Count do
 begin
    hname:=tnlist[i-1].DeQuotedString;
    if uppercase(leftstr(hname,3))='RS_' then
    begin
      rslst.items.add(hname);
    end;
 end;
 rslst.ItemIndex:=rslst.items.indexof(cdy_fname.text);
 init_parmset_selection;
 // autostart ?
 if go_on then
 begin
   button1.Click;
 end;

end;



procedure Tprmdlgf.FormCreate(Sender: TObject);
begin
  KeyPreview := True;
new(pdata);
end;



procedure Tprmdlgf.save_switches;
type ar1=array[0..5]of integer;
     ar2=array[1..2]of string;
var switch_reg :Tregistry;
    bl,pp:string;
    zz:integer;
    bf:textfile;

const ofra:ar1=(0,1,5,10,30,300);
      offa:ar2=(' X=',' R=');
begin
bl:=' A='+copy(datetimetostr(cdyanf.datetime),1,10)+' E='+copy(datetimetostr(cdyend.datetime),1,10)
+' D='+cdydaba.text+' S='+cdyplot.text+' P='+cdysoil.text+' W='+cdywett.text
+' DP='+cdydpath.text ;
 if cdy_r_type.itemindex>0 then
 begin
  bl:=bl+offa[1]+cdy_fname.text+' OF='+inttostr(ofra[cdy_r_type.itemindex]);
 end;
// schalter
if  cdy_wait.checked    then bl:=bl+' W+' else bl:=bl+' W-';
//if  cdy_prs.checked     then bl:=bl+' P+' else bl:=bl+' P-';
if  lys_chkbx.checked   then bl:=bl+' L+' else bl:=bl+' L-';
if  preci_chkbx.checked then bl:=bl+' K+' else bl:=bl+' K-';
if  cdy_wgen.checked    then bl:=bl+' Z+' else bl:=bl+' Z-';
if  cdy_dynsp.checked   then bl:=bl+' D+' else bl:=bl+' D-';
if  cdy_gis.checked     then bl:=bl+' G+' else bl:=bl+' G-';
if  cdy_sgen.checked
then begin bl:=bl+' S+'; if  cdy_ss.checked then bl:=bl+' SS'; end
else bl:=bl+' S-';
zz:=strtoint(cdy_zz.text );
if zz>1 then bl:=bl+' Z='+cdy_zz.text;
  switch_reg:=Tregistry.Create;

  pp:=cdy_uif.startdir; //switch_reg.ReadString('ppath');

 try
    switch_reg.RootKey := HKEY_CURRENT_USER;
    if not switch_reg.openkey('\Software\candy', false)
    then
    begin
      application.MessageBox('Registrierung nicht gefunden oder unvollständig', 'CANDY-FEHLER', mb_ok);
      exit;
    end;

    switch_reg.writeString('restab',trim(cdy_fname.Text));    // letzten restab-bezeichner merken

    switch_reg.openkey('\Software\candy\switches', false);
    switch_reg.WriteString('wdmode','KoGl');
    switch_reg.writebool('BD_dynamics',chk_ssd.checked);
    switch_reg.writebool('cdy_can',false);
    switch_reg.writebool('cdypfl',cdy_pfl.checked);
    switch_reg.writebool('dynsp',cdy_dynsp.checked);
    switch_reg.writebool('wgen',cdy_wgen.checked);
    switch_reg.writebool('sgen',cdy_sgen.checked);
    switch_reg.writebool('stst',cdy_ss.checked);
    switch_reg.writebool('wait',cdy_wait.checked);
    switch_reg.writebool('lysm',lys_chkbx.checked);
    switch_reg.writebool('puddle',puddle.checked);
    switch_reg.writebool('auto_soil',auto_soil.checked);
    switch_reg.writebool('gism',cdy_gis.checked);
    switch_reg.writebool('k_prec',preci_chkbx.checked);
    switch_reg.WriteString('y_end',edit1.Text);
    switch_reg.WriteString('lat',latitude.Text);
    switch_reg.WriteInteger('outfr',cdy_r_type.itemindex);
    switch_reg.WriteInteger('ptfmode',combobox2.ItemIndex+1);

    // if chk_swms.Checked then switch_reg.WriteString('wdmode','DARCY')  else
    // switch_reg.writebool('cips',chk_cips.checked);
    // switch_reg.WriteString('gdmode',gd_edt.Text);
    // switch_reg.WriteInteger('outfm',cdy_r_type.itemindex);
    // switch_reg.writebool('prsm',cdy_prs.checked);

 finally
 switch_reg.closekey;
 switch_reg.free;
 inherited;
 end;

end;

procedure Tprmdlgf.init_parmset_selection;
var ptab:tfdtable;
begin
   // cdyparm.Session.getaliasparams(db_alias,listbox1.items);
 //pg   if fileexists(cdy_uif.db_f_name) then
 // db sollte schon offen sein?
  cdy_uif.db_connect(cdy_uif.db_f_name)     ;
 //pg   else    exit;
    ptab:=tfdtable.create(nil);
    ptab.TableName:='CDYAPARM';
    ptab.connection:=cdy_uif.dbc;
    ptab.Open;
    combobox1.items.clear;
    combobox1.ItemIndex:=combobox1.items.add('NORM');
    combobox1.Repaint;
    if ptab.Fields.findField('PARMSATZ')<>nil then
    begin
       ptab.First;
       repeat
         if uppercase(ptab.FieldByName('PARMSATZ').asstring)<>'NORM'
         then combobox1.ItemIndex:=combobox1.Items.Add(trimright(ptab.FieldByName('PARMSATZ').asstring));
        ptab.next;
       until ptab.eof
    end;
    ptab.Close;
    ptab.Free;
    if parmset<>'' then
    begin
     combobox1.ItemIndex:= combobox1.Items.IndexOfName(parmset);
    end;
end;

procedure Tprmdlgf.ComboBox1CloseUp(Sender: TObject);
begin
parmset:=combobox1.Items[combobox1.Itemindex];
end;

procedure Tprmdlgf.ListBox1DblClick(Sender: TObject);
  var list:tstringlist;
  db_f_name:string;
      cdy_ini:Tregistry;
begin

end;

procedure Tprmdlgf.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if key=19 then  wait:= true else wait:=false;
  application.processmessages;
end;

end.
