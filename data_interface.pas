unit data_interface;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,math,
  Dialogs, OleCtrls, SHDocVw, HTTPApp, HTTPProd, StdCtrls, DB,inifiles, ADODB,strutils,
 { cdyexec,}   ExtCtrls,   ComCtrls, jpeg,   ActiveX,  wininet,
  VclTee.TeeGDIPlus, Xml.xmldom, Xml.XMLIntf, Xml.Win.msxmldom, Xml.XMLDoc,
  Vcl.DBCtrls, Vcl.Grids, Vcl.DBGrids, Soap.SOAPHTTPTrans;

type
  feld1=array[1..7] of real;
  Twebdata = class(TForm)
    wb: TWebBrowser;
    Button4: TButton;
    Button5: TButton;
    ListBox1: TListBox;
    Button1: TButton;
    Edit5: TEdit;
    Button7: TButton;
    Button8: TButton;
    Button9: TButton;
    Edit6: TEdit;
    ComboBox2: TComboBox;
    Button10: TButton;
    Label6: TLabel;
    ComboBox3: TComboBox;
    Button12: TButton;
    Label1: TLabel;
    procedure Button1Click(Sender: TObject);

    procedure FormActivate(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);

       procedure  wmz_pas(ltem, nied, fat: double;no_till:boolean; var wmz: double);

    procedure ADOCAfterConnect(Sender: TObject);

    procedure Button7Click(Sender: TObject);

    procedure Button9Click(Sender: TObject);
    procedure ComboBox2CloseUp(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    procedure Button12Click(Sender: TObject);
    procedure ComboBox3CloseUp(Sender: TObject);
    procedure FormShow(Sender: TObject);

  private
    { Private-Deklarationen }


    a_FAT: double;
    a_exp: longint;
    pcnt_crop,pcnt_fom:integer;
    tmp,prec,bat,cdi: array [1..5] of double;
    crophdl,fomhdl: array[1..50] of string;
    crop: array[1..50,1..200] of string;
    fom : array[1..50,1..400] of string;
  public
    { Public-Deklarationen }
    crop_mode:boolean;
    ebod:widestring;
    dbfile,fom_item :string;
    wpath:widestring;
    Flags: OLEVariant;
 procedure save_climate(stat, temp, nied :string);
 procedure save_soil(soil, clay, silt, skel :string);

 procedure import_fom( item,crop,ix:string);
  end;
const
     cs1='Provider=Microsoft.Jet.OLEDB.4.0;User ID=Admin;Data Source=' ;
     cs3=';Mode=Share Deny None;Jet OLEDB:System database="";Jet OLEDB:Registry Path="";Jet OLEDB:Database Password="";Jet OLEDB:Engine Type=4;Jet OLEDB:Database Locking Mode=0;Jet OLEDB:Global Partial Bulk Ops=2;Jet OLEDB:Global Bulk Transactions=1;' ;
     cs4='Extended Properties="";' ;
     cs5='Jet OLEDB:New Database Password="";Jet OLEDB:Create System Database=False;Jet OLEDB:Encrypt Database=False;Jet OLEDB:Don''t Copy Locale on Compact=False;Jet OLEDB:Compact Without Replica Repair=False;Jet OLEDB:SFP=False';

var
  webdata: Twebdata;

implementation

{$R *.dfm}

uses FDC_modul;

procedure Twebdata.ADOCAfterConnect(Sender: TObject);
begin
button5.Click;


end;

procedure Twebdata.Button10Click(Sender: TObject);
var vs: string;
    i,j,k:integer;
    match:boolean;
    m:integer;
begin

m:=IDNO;
k:=combobox2.ItemIndex+1;   // selected item: har[1,k]
// strat nametest
repeat
fdc.hqry.SQL.Clear;
fdc.hqry.SQL.Add(' select * from cdypflan where name='+crop[2,k]);
fdc.hqry.Open;
fdc.hqry.First;
if fdc.hqry.RecordCount>0 then
 begin
  crop[2,k]:=leftstr(crop[2,k],length(crop[2,k])-1)+'*"';
  listbox1.ItemIndex:= listbox1.Items.Add('crop name is changed because it was already used ');
 end;
until fdc.hqry.RecordCount=0;
// end nametest



fdc.hqry.SQL.Clear;
fdc.hqry.SQL.Add(' select * from cdypflan where item_IX='+crop[1,k]);
fdc.hqry.Open;
fdc.hqry.First;
if fdc.hqry.RecordCount>0 then
 begin
  listbox1.ItemIndex:=  listbox1.Items.Add(' item is allready defined');




 // content check
 match:=true;
 for j := 1 to pcnt_crop do
 begin
  match:= match and( fdc.hqry.FieldByName(crophdl[j]).AsVariant=crop [j,k])   ;
  if not ( fdc.hqry.FieldByName(crophdl[j]).AsVariant=crop [j,k])  then listbox1.Items.Add('not matching parameter: '+crophdl[j]+'  websource=' +crop[j,k]+'   local='+fdc.hqry.FieldByName(crophdl[j]).asstring)

 end;
 if match  then    listbox1.ItemIndex:= listbox1.Items.Add(' item is allready existing with same content');

 m:=application.MessageBox('import parameter record anyway ?','existing item with deviating parameter values ',mb_yesno);

 if m=IDYES then
 begin
  // get a new item_ix
  fdc.aqry.Close;
  fdc.aqry.SQL.Clear;
  fdc.aqry.SQL.Add('select max(item_ix)+1 as new_item from cdypflan');
  fdc.aqry.open;
  fdc.aqry.First;
  crop[1,k]:=fdc.aqry.FieldByName('new_item').AsString;
 end;

end;   // recordcount>0


if (fdc.hqry.RecordCount=0) or (m=IDYES) then
begin
 listbox1.Items.Add(' try to import record');
 fdc.hqry.SQL.Clear;
 //fdc.hqry.SQL.Add(' insert into cdypflan (ITEM_IX,Oeko_Anbau,Oekoanbau,Name_de,Name_en,ewr_ix,grd_ix,kop_ix,CEWR,FEWR  ,N_GEHALT,TS_Bezug_Hp,HI  ,Source )' );
 fdc.hqry.SQL.Add(' insert into cdypflan (ITEM_IX, Name,art,modell,transk,algo,steil,vegdau,nbok,lnub,wtmax,wwg,dbhmax,bhmax,matanf,tempanf,bgmax,dbgmax, CEWR,FEWR,n_gehalt,czep,zetb  ,ewr_ix,grd_ix , sba_id,kop_ix,hi,dm_nat,source )' );
 vs:='';
 for i:=1 to pcnt_crop do
 begin
  if crop[i,k]='FALSCH' then crop[i,k]:='FALSE';
  if crop[i,k]='WAHR' then crop[i,k]:='TRUE';
//  if i in [2,4,30 ] then crop[i,k]:='"'+crop[i,k]+'"';
  vs:=vs+crop[i,k];
  if i<pcnt_crop then  vs:=  vs+', ';
 end;
 fdc.hqry.SQL.Add(' values  ( '+vs+')');
 fdc.hqry.sql.SaveToFile('appendcrop.sql');
 try fdc.hqry.ExecSQL;
 except
   listbox1.ItemIndex:=    listbox1.Items.Add('no success');
 end;
// listbox1.Items.Add(vs);
   listbox1.ItemIndex:= listbox1.Items.Add(' ...ready');
  // now the ops for crop item : crop[1,k]

  // chekup xxx_id : 6,7,8
listbox1.Items.Add('crop requires item_ix '+crop[24,k]+' in cdyopspa ')    ;
 import_fom(crop[24,k],crop[1,k],'ewr');
 if crop[25,k]<>'-99' then
 begin
 listbox1.Items.Add('crop requires item_ix '+crop[25,k]+' in cdyopspa ')    ;
 import_fom(crop[25,k],crop[1,k],'kop');
 end;
  if crop[27,k]<>'-99' then
 begin
 listbox1.Items.Add('crop requires item_ix '+crop[27,k]+' in cdyopspa ')    ;
 import_fom(crop[27,k],crop[1,k],'grd');
 end;

  listbox1.ItemIndex:= listbox1.Items.Add('********** crop import finished *********** ')    ;

end ;

end;

procedure Twebdata.import_fom( item,crop,ix:string);
var vs, ts,tstr,wstr: string;
     item_redef,match: boolean;
     i,j,k,m:integer ;
begin

  m:=IDNO;
  k:=0;
  // sear matching k
  repeat
     inc(k);
  until (fom[1,k]=item) ;


  // start nametest
repeat
fdc.hqry.SQL.Clear;
fdc.hqry.SQL.Add(' select * from cdyopspa where name='+fom[3,k]);
fdc.hqry.Open;
fdc.hqry.First;
if fdc.hqry.RecordCount>0 then
 begin
  fom[3,k]:=  leftstr(fom[3,k],length(fom[3,k])-1)+'*"';
  listbox1.ItemIndex:=listbox1.Items.Add('FOM name is changed because it was already used ');
 end;
until fdc.hqry.RecordCount=0;
// end nametest

  item_redef:=false;
  fdc.hqry.sql.clear;
  fdc.hqry.SQL.Add(' select * from cdyopspa where item_ix='+item);
  fdc.hqry.Open;
  fdc.hqry.First;
  if fdc.hqry.RecordCount>0 then
  begin
   item_redef:=true;
   listbox1.ItemIndex:=listbox1.Items.Add(' item is allready defined');
// content check
   match:=true;
   for j := 1 to pcnt_fom do
   begin
    tstr:=uppercase( fdc.hqry.FieldByName(fomhdl[j]).Asstring);
    wstr:=uppercase (fom[j,k]);
    begin
     match:= match and( tstr=wstr)   ;
     if not ( tstr=wstr)  then listbox1.ItemIndex:=listbox1.Items.Add('not matching parameter: '+fomhdl[j]+'  websource=' +fom[j,k]+'   local='+fdc.hqry.FieldByName(fomhdl[j]).asstring)
    end;
   end;
   if match
   then  listbox1.ItemIndex:=listbox1.Items.Add(' item is allready existing with same content')
   else m:=application.MessageBox('import parameter record anyway ?','existing item with deviating parameter values ',mb_yesno);

 if m=IDYES then
 begin
  // get a new item_ix
  fdc.aqry.Close;
  fdc.aqry.SQL.Clear;
  fdc.aqry.SQL.Add('select max(item_ix)+1 as new_item from cdyopspa');
  fdc.aqry.open;
  fdc.aqry.First;
  fom[1,k]:=fdc.aqry.FieldByName('new_item').AsString;
 end;

end;   // recordcount>0

 if (m=IDYES) or ( fdc.hqry.recordcount=0) then
 begin
   // FOM record importieren
   vs:='';
// k already defined   k:= 0; repeat inc(k) until fom[1,k]=item;
   for i:=1 to pcnt_fom do
   begin
    ts:= fom[i,k];
    if ts='' then ts:='-99';

//    if i in [3,12] then ts:= '"'+ts+'"';
    if uppercase(ts)='FALSCH' then ts:='FALSE';
    if uppercase(ts)='WAHR'   then ts:='TRUE';
    vs:=vs+ts;
    if i<pcnt_fom then vs:=vs+', ' ;
    end;
    fdc.hqry.SQL.Clear;
    fdc.hqry.SQL.Add( ' insert into cdyopspa ( item_ix,sba_id,NAME,od,K,ETA,CNR,CNR_ALT,TS_GEHALT,C_GEH_TS,MOR,source )' );
    fdc.hqry.SQL.Add( ' values ( ' + vs+ ')' );
    fdc.hqry.SQL.SaveToFile('opspappend.sql');
    fdc.hqry.ExecSQL;
    j:= fdc.hqry.RowsAffected;
    if j=1 then listbox1.ItemIndex:=listbox1.Items.Add('inserted item: '+fom[3,k]+' ix='+fom[1,k])   else listbox1.Items.Add(' error while inserting item '+fom[3,k]);
    listbox1.ItemIndex:=  listbox1.Items.Add('********** fom import finished *********** ')    ;
end;
 application.ProcessMessages;
 if item_redef then
 begin
    fdc.hqry.SQL.Clear;

   // check possible update of crop related FOM_ix (ewr_ix,kop_ix,grd_id )
   //if ix='ewr' then
     fdc.hqry.SQL.Add( ' update cdypflan set '+ix+'_ix='+fom[1,k]+' where item_ix='+crop );
   fdc.hqry.ExecSQL;
   i:= fdc.hqry.Rowsaffected;
   if i=1 then
   begin
     // success
   listbox1.ItemIndex:=   listbox1.Items.Add(' **** updated: crop_item '+crop+': '+ix+' to '+fom[1,k]);
   end
   else
   begin
    // fehler
    listbox1.ItemIndex:=   listbox1.Items.Add(' update of '+ix+' not successful');

   end;
 end;

end;


procedure Twebdata.Button11Click(Sender: TObject);
begin
//listbox1.Items.LoadFromStream();
end;

procedure Twebdata.Button12Click(Sender: TObject);
begin
//item_ix finden

 import_fom(fom_item,'!','');
end;

procedure Twebdata.Button1Click(Sender: TObject);
begin
  webdata.Close;
end;


procedure Twebdata.Button3Click(Sender: TObject);
var r_path,h_line,userprof :string;
begin

end;




 procedure Twebdata.wmz_pas(ltem, nied, fat: double;no_till:boolean; var wmz: double);
    { Berechnet mittleren Wert der wirksamen Mineralisierungszeit wmz
      für Standort mit Jahresmittel der Lufttemperatur ltem
                   mit Jahresniederschlagssumme nied
                  mit Feinanteilgehalt fat}
      {Regressionkoeffizienten des Modells
         WMZ = A*LTEM+B*NIED+C
       mit
         A,B,C: Funktionen von FAT.
       Funktionen sind für FAT-Werte aus Feld fattab vorgegeben;
       dazwischen wird linear interpoliert}
    const
     {Abstufungen FAT-Werte der CANDY-Simulationsläufe}
      fattab: feld1=(6.0, 8.0, 11.5, 15.0, 22.0, 32.0, 44.0);
       a: feld1=(3.3541,   3.1825,  3.0629,   2.1824,    2.1698,     2.0054, 1.8676);
       b: feld1=(0.015698, 0.01325, 0.003204, -0.009797, -0.02726, -0.03232, -0.03178);
       c: feld1=(9.0870,   10.2234, 14.5547,   23.0218, 23.6263,   22.9473,  22.9300);

    var
      i, i1: integer;
      p, h1, h2: real;
      yps,alpha:double;

    begin
      {lineare Interpolation des FAT-Wertes, p: Gewicht auf fat-Strahl}
      i:=0;
      repeat
        inc(i)
      until (fat <= fattab[i]) or (i=8);
      case i of
        {alle Werte als fat=6 angenommen}
        1:      wmz:=a[1]*ltem+b[1]*nied+c[1];
        {lineare Interpolation notwendig}
        2,3,4,5,6,7: begin
                  i1:=i-1;
                  h1:=a[i1]*ltem+b[i1]*nied+c[i1];
                  h2:=a[i]*ltem+b[i]*nied+c[i];
                  p:=(fat-fattab[i1])/(fattab[i]-fattab[i1]);
                  wmz:=(1-p)*h1+p*h2;
                end;
        {alle Werte als fat=44 angenommen}
        8:      wmz:=a[7]*ltem+b[7]*nied+c[7];
      end;
    end;{wmz_pas}

procedure Twebdata.save_soil(soil, clay, silt, skel :string);
var _ba:string;
begin
    _ba:=soil;
//# prepare soil record
   with  fdc.hqry do
   begin
     sql.Clear;
     sql.Add(' select * from soilproperties where profile="'+_ba+'"');
     open;
     first;
     if recordcount=0 then
     begin
     sql.Clear;
     sql.Add('   INSERT INTO soilproperties ( soil_ID,profile ) SELECT Max(soilproperties.soil_ID)+1 AS x, "new" FROM soilproperties');

     application.ProcessMessages;
     execsql;
     sql.Clear;
     sql.Add(' update soilproperties set profile="'+_ba+'", clay='+clay +', silt='+silt);
     sql.Add(', silt_org=TRUE, skelett='+skel);
     sql.add(' where profile="new"');
    // listbox1.Items.Add(sql.text);
     listbox1.Items.Add('Boden übernommen für '+_ba);
     application.ProcessMessages;
     execsql;
     end // if recordcount
     else      listbox1.Items.Add('Bodendaten vorhanden: '+_ba);
   end;
end;

procedure Twebdata.save_climate(stat, temp, nied :string);
var clid,gname:string;
begin
     gname:=stat;

       with  fdc.hqry do
   begin
     sql.Clear;
     sql.Add(' select * from climate_station where station="'+gname+'"');
     open;
     first;
     if recordcount=0 then
     begin
          sql.Clear;
     sql.Add('   INSERT INTO climate_station ( climate_ID,station ) SELECT Max(climate_ID)+1 AS x, "new" FROM climate_station');
//     listbox1.Items.Add(sql.text);
     application.ProcessMessages;
     execsql;
     sql.Clear;
     sql.Add(' update climate_station set station="'+gname+'", year0_nd=0, year1_nd=0, ndep_0=0, ndep_1=0 where station="new"');
//     listbox1.Items.Add(sql.text);
     application.ProcessMessages;
     execsql;
     sql.Clear;
     sql.Add( 'select climate_id from climate_station where station="'+gname+'"');
     open;        first;
     clid:= fieldbyname('climate_id').Asstring;
     sql.Clear;
     sql.Add(' insert into climate_data (climate_id, [day],[month], [year],temperature, precipitation) select '+clid+', 0, 0, 0,'+ temp+', '+nied);
  //             listbox1.Items.Add(sql.text);

        listbox1.Items.Add('Klima übernommen für '+Gname);
     application.ProcessMessages;
     execsql;
     end else     listbox1.Items.Add('Klimadaten vorhanden: '+Gname);
    end;
{
   with fdc.fdc.hqry do
   begin

     sql.Clear;
     sql.Add('   INSERT INTO climate_station ( climate_ID,station ) SELECT Max(climate_ID)+1 AS x, "new" FROM climate_station');
               listbox1.Items.Add(sql.text);
     application.ProcessMessages;
     execsql;
     sql.Clear;
     sql.Add(' update climate_station set station="'+stat+'", year0_nd=0, year1_nd=0, ndep_0=0, ndep_1=0 where station="new"');
               listbox1.Items.Add(sql.text);
     application.ProcessMessages;
     execsql;
     sql.Clear;
     sql.Add( 'select climate_id from climate_station where station="'+stat+'"');
     open;        first;
     clid:= fieldbyname('climate_id').Asstring;
     sql.Clear;
     sql.Add(' insert into climate_data (climate_id, [day],[month], [year],temperature, precipitation) select '+clid+', 0, 0, 0,'+ temp+', '+ nied);
               listbox1.Items.Add(sql.text);
     application.ProcessMessages;
     execsql;

  end;
  }
end;






procedure Twebdata.Button7Click(Sender: TObject);
var url_,aline,hline:string;
 PersistStream: IPersistStreamInit;
   Stream: IStream;
   FileStream: TFileStream;

begin
wb.navigate(edit5.text);
while wb.ReadyState < READYSTATE_INTERACTIVE do   Application.ProcessMessages;
if not Assigned(wb.Document) then
   begin
     ShowMessage('Document not loaded!') ;
     Exit;
   end;
  PersistStream := wb.Document as IPersistStreamInit;
   FileStream := TFileStream.Create(wpath+'\tmp_file3.html', fmCreate) ;
   try
     Stream := TStreamAdapter.Create(FileStream, soReference) as IStream;
     if Failed(PersistStream.Save(Stream, True)) then ShowMessage('SaveAs HTML fail!') ;
   finally
     FileStream.Free;
   end;
end;


procedure Twebdata.Button9Click(Sender: TObject);

var
PersistStream: IPersistStreamInit;
   Stream: IStream;
   FileStream: TFileStream;
   hfile: textfile;
   header,aline,hline :string;
   p0,p,l,i,j,k:integer;
   cnt:boolean;

 //  _umo='├Â Å

begin
  {
    cnt:=InternetCheckConnection(pwideChar('https://www.ufzoff.de/index.php?de=42459'),1,0);
   if not cnt then
   begin
     exit;
   end;
   }
   listbox1.Clear;
   Wb.Navigate(edit6.text) ;
   while Wb.ReadyState < READYSTATE_INTERACTIVE do   Application.ProcessMessages;

   if not Assigned(WB.Document) then
   begin
     ShowMessage('Document not loaded!') ;
     Exit;
   end;
   PersistStream := WB.Document as IPersistStreamInit;
   FileStream := TFileStream.Create(wpath+'\tmp_file.html', fmCreate) ;
   try
     Stream := TStreamAdapter.Create(FileStream, soReference) as IStream;
     if Failed(PersistStream.Save(Stream, True)) then ShowMessage('SaveAs HTML fail!') ;
   finally
     FileStream.Free;
   end;

   assignfile(hfile,wpath+'\tmp_file.html');
   reset(hfile);
    //  listbox1.Items.LoadFromFile(wpath+'\tmp_file.html');
    //  listbox1.Items.Encoding:='UTF8';
    //  application.ProcessMessages;
   repeat
     readln(hfile,aline);
     aline:=utf8tostring(aline);
   until eof(hfile) or ( pos('###cdypflan',aline)>0);

   // aline enthält den vollständigen parameter set
   // extract headline
   p0:=pos('item_ix',aline);

   if p0=0 then
   begin
   application.MessageBox('no successful connection to the datasource','action not possible',mb_ok) ;
     exit;
   end;
   p:=pos('<br/>',aline);
   header:=copy(aline,p0,p-p0);
   j:=1;

   crophdl[j]:='';
   for i:= 1 to length(header) do
   begin
    if header[i]=','  then  begin  inc(j);  crophdl[j]:='';  end
                      else      crophdl[j]:=crophdl[j]+header[i];
   end;
   pcnt_crop:=j;

   aline:=copy(aline,p+5,length(aline));

   k:=1;
   combobox2.Items.Clear;
repeat
   l:=pos('<br/>',aline);
   if l>0 then
   begin
   hline:=copy(aline,1,l-1);
   aline:=copy(aline,l+5,length(aline));

   j:=1;
   crop[j,k]:='';
   for i:= 1 to length(hline) do
     begin
       if hline[i]=','
       then
         begin
         // element finished
           if j in [2,4  ] then
           begin
            crop[j,k]:='"'+crop[j,k]+'"';
           end;
           inc(j);
           crop[j,k]:='';
         end
       else
        begin
          // continue current element
          crop[j,k]:=crop[j,k]+hline[i];
        end;
     end;
// record completed
       crop[30,k]:='"'+crop[j,k]+'"';
            if crop[1,k]<>'-99' then
            begin
             combobox2.Items.Add(crop[2,k]);
            end;

    inc(k);
   end;
  until  crop[1,k-1]='-99';   //copy(aline,1,4)='</p>';
  reset(hfile);
   repeat
     readln(hfile,aline);
     aline:=utf8tostring(aline);
   until eof(hfile) or ( pos('###cdyopspa',aline)>0);
   p0:=  pos('###cdyopspa',aline);
   aline:=copy(aline,p0+length('###cdyopspa<br/>'), length(aline));
      // extract headline
   p0:=pos('item_ix',aline);
   aline:=rightstr(aline,length(aline)-p0+1);
   p0:=1;
   p:=pos('<br/>',aline);
   header:=copy(aline,p0,p-p0);
   j:=1;
   fomhdl[j]:='';
   for i:= 1 to length(header) do
   begin
    if header[i]=','  then  begin
                             inc(j);
                             fomhdl[j]:='';
                            end
                      else      fomhdl[j]:=fomhdl[j]+header[i];
   end;
   pcnt_fom:=j;

   aline:=copy(aline,p+5,length(aline));

   k:=1;
   combobox3.Items.Clear;
repeat
   l:=pos('<br/>',aline);
   if l>0 then
   begin
   hline:=copy(aline,1,l-1);
   aline:=copy(aline,l+5,length(aline));

   j:=1;
   fom[j,k]:='';
   for i:= 1 to length(hline) do
     begin
       if hline[i]=','
       then
         begin
         // element finished
           if j in [3 ] then fom[j,k]:= '"'+fom[j,k]+'"';
           inc(j);
           fom[j,k]:='';
         end
       else
        begin
          // continue current element
          fom[j,k]:=fom[j,k]+hline[i];
        end;
     end;
// record completed
    fom[12,k]:= '"'+fom[j,k]+'"';
     if fom[4,k]='WAHR' then      combobox3.Items.Add(fom[3,k]);
    inc(k);
   end;
  until fom[1,k-1]='-99';// l=0;


   closefile(hfile);
 if crop_mode then
  begin
   combobox2.Visible:=true;
   button10.Visible:=true;
  end
  else
  begin
   combobox3.Visible:=true;
   button12.Visible:=true;
  end;
  combobox2.ItemIndex:=0;
  combobox3.ItemIndex:=0;
end;

procedure Twebdata.ComboBox2CloseUp(Sender: TObject);
var a_item: integer;
begin
  listbox1.Items.Clear;
  a_item:=combobox2.ItemIndex+1;
  listbox1.Items.Add(crop[2,a_item]);
  label1.Caption:=crop[30,a_item];
end;




procedure Twebdata.ComboBox3CloseUp(Sender: TObject);

var a_item:string;
   k: integer;
begin
  listbox1.Items.Clear;
  a_item:=combobox3.items[combobox3.ItemIndex];
  k:=0;
  repeat
    inc(k);
  until fom[3,k]=a_item ;
  listbox1.Items.Add(fom[3,k]);
  fom_item:=fom[1,k];
  label1.Caption:=fom[12,k];
end;


procedure Twebdata.FormActivate(Sender: TObject);
var ini:tinifile;
inist:widestring;

var  Flags: OLEVariant;
begin
wpath:= getcurrentdir;
wb.visible:=true;


 //   WebBrowser1.Navigate('http://www.umweltbundesamt.at/umweltsituation/landwirtschaft/acc/', Flags, Flags, Flags, Flags);
end;

procedure Twebdata.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var a_key:word;
begin
   a_key:=key;
   if a_key= 20 then
   begin
     application.MessageBox('hoi','wo',mb_ok);
   end;

end;

procedure Twebdata.FormKeyPress(Sender: TObject; var Key: Char);
var a_key:char;
begin
   a_key:=key;
   if a_key=char(20) then
   begin
     application.MessageBox('hoi','wo',mb_ok);
   end;

end;

procedure Twebdata.FormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
  var i,j:integer;
  begin
       i:=x;
       j:=x+2;
end;

procedure Twebdata.FormShow(Sender: TObject);
begin
   combobox2.Visible:=false;
   button10.Visible:=false;
   combobox3.Visible:=false;
   button12.Visible:=false;
   label1.Caption:='';
end;

end.
