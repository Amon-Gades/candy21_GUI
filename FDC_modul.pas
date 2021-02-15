{
 data modul of the project covering datasets and data source related
 to the connection object defineed in @link(candy_uif)
}
unit FDC_modul;

interface

uses
  System.SysUtils, System.Classes,candy_uif, FireDAC.Stan.Intf,system.variants,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Data.Win.ADODB, frxClass,
  frxDBSet;

type
  Tfdc = class(TDataModule)
    hqry: TFDQuery;
    cdyctrl: TFDQuery;
    FDA_update: TFDQuery;
    htab: TFDTable;
    hsrc: TDataSource;
    masqry: TFDQuery;
    masqrykey: TFDAutoIncField;
    masqrySNR: TSmallintField;
    masqryUTLG: TSmallintField;
    masqryDATUM: TSQLTimeStampField;
    masqryMACODE: TSmallintField;
    masqryWERT1: TSmallintField;
    masqryWERT2: TFloatField;
    masqryORIGWERT: TFloatField;
    masqryREIN: TWideStringField;
    massrc: TDataSource;
    masqryUNIT: TStringField;
    masqryAKTION: TStringField;
    masqrySUBJEKT: TStringField;
    mweqry: TFDQuery;
    mweqrySNR: TSmallintField;
    mweqryUTLG: TSmallintField;
    mweqryDATUM: TSQLTimeStampField;
    mweqryM_IX: TSmallintField;
    mweqryS0: TSmallintField;
    mweqryS1: TSmallintField;
    mweqryM_WERT: TFloatField;
    mweqryVARIATION: TFloatField;
    mweqryANZAHL: TSmallintField;
    mweqryS_WERT: TFloatField;
    mweqryKORREKTUR: TWideStringField;
    mklqry: TFDQuery;
    mklsrc: TDataSource;
    mwesrc: TDataSource;
    mweqryproperty: TStringField;
    mweqryunit: TStringField;
    mweqryklasse: TStringField;
    mweqryprop: TStringField;
    fdaqry: TFDQuery;
    fdasrc: TDataSource;
    actqry: TFDQuery;
    actsrc: TDataSource;
    items: TFDQuery;
    any_update: TFDQuery;
    profiles: TFDQuery;
    prfsrc: TDataSource;
    classqry: TFDQuery;
    clasrc: TDataSource;
    profile_prm: TFDQuery;
    explanations: TFDTable;
    hrz_prm: TFDTable;
    prof_data: TFDTable;
    access_table: TFDTable;
    littergreen: TFDQuery;
    litterstraw: TFDQuery;
    litterroot: TFDQuery;
    aktion: TFDTable;
    hrz_liste: TFDQuery;
    fert: TFDTable;
    cndmwml: TFDTable;
    propqry: TFDQuery;
    opspa: TFDTable;
    sbacrop: TFDTable;
    sbamanure: TFDTable;
    sbasoil: TFDTable;
    sbaomdef: TFDTable;
    crops: TFDTable;
    cdy_aprm: TFDTable;
    grassl: TFDTable;
    btprm: TFDTable;
    lives: TFDTable;
    resobj: TFDTable;
    tgparms: TFDTable;
    add_prfl: TFDQuery;
    grm_names: TFDQuery;
    grm_population: TFDQuery;
    grm_crop: TFDQuery;
    siwaprm: TFDQuery;
    c2p_qry: TFDQuery;
    clas_qry: TFDQuery;
    itemsrc: TDataSource;
    wcnt: TFDQuery;
    wyr: TFDQuery;
    wdqry: TFDQuery;
    aqry: TFDQuery;
    oqry: TFDQuery;
    mvdat: TFDTable;
    get_obslst: TFDQuery;
    dview: TFDQuery;
    mwml: TFDQuery;
    schemes: TFDQuery;
    dviewSNR: TSmallintField;
    dviewUTLG: TSmallintField;
    dviewDATUM: TSQLTimeStampField;
    dviewM_IX: TSmallintField;
    dviewS0: TSmallintField;
    dviewS1: TSmallintField;
    dviewKORREKTUR: TWideStringField;
    dviewmerkmal: TStringField;
    gmp: TFDTable;
    gm_id: TFDQuery;
    frxDB_mas: TfrxDBDataset;
    frxDB_fda: TfrxDBDataset;
    frxmarep: TfrxReport;
    frxDB_obs: TfrxDBDataset;
    frxobsrep: TfrxReport;

    procedure htabBeforeOpen(DataSet: TDataSet);
    procedure masqryCalcFields(DataSet: TDataSet);
    procedure massrcDataChange(Sender: TObject; Field: TField);
    procedure mklsrcDataChange(Sender: TObject; Field: TField);
    procedure mwesrcDataChange(Sender: TObject; Field: TField);
    procedure fdasrcDataChange(Sender: TObject; Field: TField);
    procedure dviewCalcFields(DataSet: TDataSet);

  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
     objekt:integer;
  x:tdblist;
  end;
var
  fdc: Tfdc;

implementation
uses range_sel_u,cdyprmedit;//, cdy_edit_dm;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}



procedure Tfdc.dviewCalcFields(DataSet: TDataSet);
begin
  mwml.First;
  while  dview.fieldbyname('m_ix').asinteger <> mwml.fieldbyname('item_ix').asinteger
       do mwml.next;
  dviewmerkmal.asstring:=mwml.fieldbyname('BEZEICHNUNG').asstring;
end;

procedure Tfdc.fdasrcDataChange(Sender: TObject; Field: TField);

var spec:boolean;
begin
// Gülle modul ?
spec:=false;
if fdc.masqry.Active then

if pos('#',fdc.masqry.FieldByName('subjekt').asstring)>0 then spec:=true;

if (spec) and ( actqry.FieldByName('action_id').asinteger=3)
 then
  range_select.button18.show
 else range_select.button18.hide;
end;

procedure Tfdc.htabBeforeOpen(DataSet: TDataSet);
begin

  htab.Filter:='';
  htab.Filtered:=false;
  range_select.checkbox1.Checked:=false;
end;



procedure Tfdc.masqryCalcFields(DataSet: TDataSet);
begin

   masqryAKTION.asstring:= actqry.lookup('action_id',masqry.fieldbyname('MACODE').asinteger,'ACTION');
  {
  if (cdy_edit.mas_sql.fieldbyname('MACODE').asinteger<3)
  or (cdy_edit.mas_sql.fieldbyname('MACODE').asinteger=12)
  or (cdy_edit.mas_sql.fieldbyname('MACODE').asinteger=9)
  }
  fdc.items.filtered:=false;
  case masqry.fieldbyname('MACODE').asinteger of
   1,2,9,12: {  then }objekt:=1;                      //cdy_edit.items.filter:='objekt=1';
   0,5     :          objekt:=5;                      //cdy_edit.items.filter:='objekt=5';
   else               objekt:=masqry.fieldbyname('MACODE').asinteger;
   fdc.items.filter:='objekt='+ inttostr(objekt);
  end;

 // fdc.items.filtered:=true;      {filter verhindert erfolgreiches lookup !}

  masqryUNIT.asstring:=actqry.lookup('ACTION_ID',masqry.fieldbyname('MACODE').asinteger,'UNIT_INTENSITY');

  try     masqrySUBJEKT.asstring:=fdc.items.lookup('item_ix;objekt',VarArrayof([masqry.fieldbyname('WERT1').asinteger,objekt]),'item');
  except  masqrySUBJEKT.asstring:='?' ;
  end;
end;


procedure Tfdc.massrcDataChange(Sender: TObject; Field: TField);

var macode:integer;
begin

  fdc.aktion.open;
  if masqry.RecordCount=0 then exit;

  {if cdy_edit.mas_sql.fieldbyname('MACODE').asinteger >0
   then range_select.radiobutton2.OnClick(self)
   else range_select.radiobutton1.onclick(self);
   }
   // eigentlich ist overwrite standart
  range_select.radiobutton2.OnClick(self);
  fdc.items.filtered:=false;
  range_select.itemselect.keyvalue:=999;
  macode:= masqry.fieldbyname('MACODE').asinteger ;
  range_select.cdyactions.keyvalue:=macode;
  range_select.datetimepicker1.date:=masqry.fieldbyname('DATUM').asdatetime;
  range_select.edit1.text:=masqry.fieldbyname('ORIGWERT').asstring;
  range_select.edit2.text:=masqry.fieldbyname('WERT2').asstring;
  range_select.label2.caption:=fdc.aktion.lookup('action_id',masqry.fieldbyname('MACODE').asinteger,'UNIT_INTENSITY');
  range_select.label4.caption:=fdc.aktion.lookup('action_id',masqry.fieldbyname('MACODE').asinteger,'DEF_INTENSITY');
  //range_select.CheckBox1.checked:=cdy_edit.mas_sql.fieldbyname('REIN').asstring='J';
  range_select.edit2.enabled:=true;
    case macode of
     1,2,9,12: begin
         fdc.items.Filter:='OBJEKT=1';  //Fruchtarten zulassen
         range_select.label3.caption:='N-uptake (kg/ha)=';
        end;
     3 : begin
          fdc.items.filter:='OBJEKT='+floattostr(macode);
          range_select.label3.caption:='C-Input (kg/ha)=';
        end;
     4: begin
          fdc.items.filter:='OBJEKT='+floattostr(macode);
          range_select.label3.caption:='NH4-amount (%)=';
          range_select.edit2.enabled:=false;
         end;

      7: begin
          fdc.items.filter:='OBJEKT='+floattostr(macode);
          range_select.label3.caption:='irrigation with ';
          range_select.edit2.enabled:=false;
         end;

      0,5: begin                      // Umbruch und Bearbeitung - gleiche Werkzeuge
          fdc.items.filter:='OBJEKT=5';
          range_select.label3.caption:='lower calc. layer';
          range_select.edit2.enabled:=false;
         end;
      21,22,23: begin
          fdc.items.filter:='OBJEKT='+floattostr(macode);
          range_select.label3.caption:='xxx=';
      end;

     6, 8,10,11: Begin
           fdc.items.filter:='OBJEKT='+floattostr(macode);
            //cdy_edit.items.filtered:=false;
           range_select.label3.caption:='';
           range_select.edit2.enabled:=false;
         end;

     else fdc.items.filter:='OBJEKT=-99';


    end;
  fdc.items.filtered:=true;
  range_select.itemselect.keyvalue:=masqry.fieldbyname('WERT1').asinteger;
  range_select.wert2changed:=(masqry.fieldbyname('REIN').asstring='J');
  if  range_select.wert2changed then range_select.label26.show else range_select.label26.hide;
end;


procedure Tfdc.mklsrcDataChange(Sender: TObject; Field: TField);
begin

//  range_select.mw_unit.Caption:=qrymerkmal.fieldbyname('EINHEIT').asstring;
  range_select.mw_unit.Caption:=mklqry.fieldbyname('propunit').asstring;

//  range_select.lcb_item.keyvalue:=mklqry.fieldbyname('BEZEICHNUNG').asvariant;
//?  application.ProcessMessages;
  range_select.m_adapt.Enabled:=mklqry.fieldbyname('adptbl').asboolean;
  //  range_select.lcb_item.KeyValue:=cdy_edit.qrymerkmal.fieldbyname(range_select.lcb_merkmal.ListField).asvariant;

end;

procedure Tfdc.mwesrcDataChange(Sender: TObject; Field: TField);
begin
   if not(mweqry.state=dsedit) then
begin

if mweqry.fieldbyname('M_IX').asinteger >0
 then range_select.radiobutton4.OnClick(self)
 else range_select.radiobutton3.onclick(self);
 // EDIT-Felder aktualisieren
 range_select.mw_date.date:=mweqry.fieldbyname('DATUM').asdatetime;
 range_select.s0.text:=mweqry.fieldbyname('S0').asstring;
 range_select.s1.text:=mweqry.fieldbyname('S1').asstring;
 range_select.mwert.text:=mweqry.fieldbyname('M_WERT').asstring;
 range_select.lcb_merkmal.keyvalue:=mweqry.fieldbyname('M_IX').asinteger;

 range_select.old_mwdate:= datetostr( range_select.mw_date.date);
 range_select.old_mix:= inttostr( range_select.lcb_merkmal.keyvalue);
 range_select.old_s0:= range_select.s0.text;
 range_select.old_s1:= range_select.s1.text;
 range_select.old_mw:= range_select.mwert.text;
 range_select.m_adapt.checked:=(mweqry.fieldbyname('KORREKTUR').asstring='J') or (mweqry.fieldbyname('KORREKTUR').asstring='Y' );
 mklqry.Locate('ITEM_IX',mweqry.fieldbyname('M_IX').asvariant,[]);
 end;
end;

end.
