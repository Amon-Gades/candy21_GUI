unit selres;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db,  StdCtrls, CheckLst,cdy_glob, ADODB, Vcl.Grids, Vcl.DBGrids;
// möglichst OHNE gis_rslt bauen
type
  Tsel_res_frm = class(TForm)
    Button1: TButton;
    CheckListBox1: TCheckListBox;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;

    Label1: TLabel;
    Label2: TLabel;
    Edit1: TEdit;
    ComboBox1: TComboBox;
    procedure Button1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure CheckListBox1ClickCheck(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);

    procedure CheckListBox1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure ComboBox1CloseUp(Sender: TObject);
  private
    { Private-Deklarationen }
        const
    got_hints: boolean = False ;
    var
    hints: array of string;
    procedure res_tab_aktualisieren;

  public
    { Public-Deklarationen }
    gis_mode:boolean;
  end;

var
  sel_res_frm: Tsel_res_frm;

implementation
 uses gis_rslt, prmdlg2,strutils, candy_uif, FDC_modul;
//uses prmdlg;

{$R *.DFM}

procedure Tsel_res_frm.Button1Click(Sender: TObject);
var i,j:integer; list_id:string;
begin
  if Trim(edit1.Text)<>'?' then
  begin
  // auswahl speichern
  // Liste ergänzen (Autowert+name)
  fdc.hqry.Close;
  fdc.hqry.SQL.Clear;
  fdc.hqry.SQL.Add('INSERT INTO cdyrslt_lists ( listname ) SELECT '''+trim(edit1.text)+''' AS Ausdr1');
  fdc.hqry.Execsql;

  fdc.hqry.Close;
  fdc.hqry.SQL.Clear;
  fdc.hqry.SQL.Add('select max(item_ix) as id from cdyrslt_lists where  listname ='''+trim(edit1.text)+'''' );
  fdc.hqry.open;
  list_id:=fdc.hqry.FieldByName('ID').asstring  ;
  // auswahl speichern
  fdc.hqry.Close;
  fdc.hqry.SQL.Clear;
  fdc.hqry.SQL.Add('INSERT INTO cdyrslt_selection (list_ix, RESULTNR ) SELECT '+list_id+' as item_ix, CDY_RSLT.RESULTNR FROM CDY_RSLT WHERE (((CDY_RSLT.AUSWAHL) Like ''*''))');
  fdc.hqry.Execsql;
  end;

// cdy_rslt updaten

// alle löschen

fdc.any_update.sql.clear;
fdc.any_update.sql.add('update CDY_RSLT set AUSWAHL='' '' ');
fdc.any_update.execsql;

fdc.any_update.SQL.Clear;
fdc.any_update.SQL.Add('update  CDY_RSLT  set AUSWAHL=:ausw where RESULTAT=:rslt');



// auswahl setzen
for i:=0 to checklistbox1.Items.Count-1 do
begin
 if    checklistbox1.checked[i] then
 begin

  fdc.any_update.parambyname('rslt').value:=checklistbox1.items[i];
  fdc.any_update.parambyname('ausw').value:='*';
  fdc.any_update.execsql;
 end;
end;


// im GIS-Mode nur die neuen Einträge erhalten
if gis_mode then
begin
 for i:= 0 to checklistbox1.Items.count-1 do
 begin
  if  not checklistbox1.itemenabled[i] then
  begin
    fdc.any_update.parambyname('rslt').value:=checklistbox1.items[i];
    fdc.any_update.parambyname('ausw').value:=' ';
    fdc.any_update.execsql;
  end;
 end; //for
end;//if
sel_res_frm.close;
end;

procedure Tsel_res_frm.FormActivate(Sender: TObject);
 {vari,k,d,t:integer;
    res_item:string;
    }
begin
   if not got_hints then  cdy_uif.get_hints('sel_res_frm',sel_res_frm);
   got_hints:=true;


 {
 fdc.hqry.Close;
 fdc.hqry.SQL.Clear;
 fdc.hqry.SQL.Add('select RESULTAT, AUSWAHL, resultnr, remark from CDY_RSLT where resultnr>0 order by resultat ' );
 fdc.hqry.open;
 fdc.hqry.first;
 setlength(hints, fdc.hqry.RecordCount+1);
 checklistbox1.items.clear;
 i:=0;
 repeat
   res_item:= fdc.hqry.FieldByName('REMARK').AsString;
   k:=  pos('CIPS',res_item);
   d:=  pos('SSD',res_item);
   t:=  pos('TGM',res_item);
   if ( (( k=0) and (d=0)  and (t=0))
   or ( ( d>0) and prmdlgf.chk_ssd.checked  )
   or ( ( t>0) and prmdlgf.gd_edt.Enabled )
   or ( ( k>0) and prmdlgf.chk_cips.checked  ) )
   then
   begin

   checklistbox1.items.add(fdc.hqry.fieldbyname('RESULTAT').asstring);
   hints[i]:= trim(res_item);

   if fdc.hqry.fieldbyname('AUSWAHL').asstring='*' then
   begin
    checklistbox1.checked[i]:=true;
    if gis_mode then begin checklistbox1.State[i]:=cbgrayed;
                       checklistbox1.itemenabled[i]:=false;
                      end;
   end;
   inc(i);
   end ;
   fdc.hqry.next;
 until fdc.hqry.Eof;
 }
end;

procedure Tsel_res_frm.CheckListBox1ClickCheck(Sender: TObject);
var I:integer;
begin



i:= checklistbox1.ItemIndex;

fdc.any_update.SQL.Clear;
fdc.any_update.SQL.Add('update CDY_RSLT  set AUSWAHL=:ausw where RESULTAT=:rslt');

fdc.any_update.parambyname('rslt').value:=checklistbox1.items[i];
if  (checklistbox1.State[i]<>cbgrayed)
then
 begin
  if checklistbox1.checked[i]
  then fdc.any_update.parambyname('ausw').value:='*'
  else  fdc.any_update.parambyname('ausw').value:=' ';
 end;
fdc.any_update.execsql;

fdc.hqry.SQL.Clear;
fdc.hqry.SQL.Add('select RESULTAT, AUSWAHL, resultnr, remark from CDY_RSLT where resultnr>0 order by resultat');
fdc.hqry.close;
fdc.hqry.open;

end;



procedure Tsel_res_frm.CheckListBox1MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var
  idx: integer;
  olh: string;
begin
try
  with checklistbox1 do
    begin
      olh := hint;
      idx := itematpos(point(x, y), false);
      if (idx <= items.count - 1) then hint :=hints[idx] //items.strings[idx]
      else hint := '';
      if hint <> olh then application.cancelhint
    end;
except

end;
end;

procedure Tsel_res_frm.ComboBox1CloseUp(Sender: TObject);
var list_id:string; j:integer;
begin

// selection updaten
list_id:=combobox1.Items[combobox1.ItemIndex];
j:= pos(':',list_id) ;
if j>0 then
 begin
   // alles auf null
  button3.Click;
  list_id:=leftstr(list_id,j-1 );
  fdc.any_update.Close;
  fdc.any_update.SQL.Clear;
  if fdc.any_update.Connection.Params.DriverID='PG'
  then
  begin
   fdc.any_update.SQL.Add(' UPDATE cdy_rslt as r  SET AUSWAHL = ''*''  from cdyrslt_selection as s ');
   fdc.any_update.SQL.Add('   where s.resultnr = r.resultnr and s.list_ix=' +list_id );
  end
  else
  begin
   fdc.any_update.SQL.Add(' UPDATE CDYRSLT_SELECTION INNER JOIN CDY_RSLT ON CDYRSLT_SELECTION.resultnr = CDY_RSLT.RESULTNR SET CDY_RSLT.AUSWAHL = ''*''  ');
   fdc.any_update.SQL.Add(' WHERE CDYRSLT_SELECTION.list_ix='+list_id );
  end;
  fdc.any_update.SQL.SaveToFile('check0.sql');
  fdc.any_update.ExecSQL;
  res_tab_aktualisieren  ;
 end;
end;

procedure Tsel_res_frm.FormShow(Sender: TObject);
var i:integer;
begin

   button3.Enabled:=(not gis_mode);
   button4.Enabled:=(not gis_mode);
edit1.Text:='?';
combobox1.ItemIndex:=0;//last selection
fdc.hqry.Close;
 fdc.hqry.SQL.Clear;
 if fdc.hqry.Connection.Params.DriverID='PG'
 then  fdc.hqry.SQL.Add('select item_ix || '':'' || listname as liste from CDYRSLT_lists order by item_ix ' )
 else  fdc.hqry.SQL.Add('select item_ix&":"&listname as liste from CDYRSLT_lists order by item_ix ' );
 fdc.hqry.open;
 combobox1.Items.Clear;
 combobox1.Items.Add('current selection');
 fdc.hqry.First;
 repeat
  combobox1.Items.Add(fdc.hqry.FieldByName('liste').asstring);
  fdc.hqry.Next;
 until fdc.hqry.eof ;
 combobox1.ItemIndex:=0;
 res_tab_aktualisieren  ;
end;

procedure Tsel_res_frm.Button2Click(Sender: TObject);
var i:integer;
begin
 for i:=0 to checklistbox1.Items.Count-1 do
 begin
    checklistbox1.checked[i]:=true;
 end;
// Standard liste wählen

 fdc.hqry.sql.clear;
 fdc.hqry.sql.add('update CDY_RSLT set AUSWAHL=''*'' ');
 if fdc.hqry.Connection.Params.DriverID='PG'
then  fdc.hqry.sql.add(' WHERE  not ( (StrPos(remark,''SSD'')>0) )  ')
else fdc.hqry.sql.add(' WHERE  not ( (InStr([remark],''SSD'')>0) )  ');

 // fdc.hqry.sql.add(' WHERE  not (   (InStr([remark],''CIPS'')>0)  or  (InStr([remark],''TGM'')>0)  or  (InStr([remark],''SSD'')>0) )  ');
 fdc.hqry.execsql;

 if prmdlgf.chk_ssd.checked   then
 begin
  fdc.hqry.SQL.Clear;
  fdc.hqry.sql.add('update CDY_RSLT set AUSWAHL=''*'' ');

   if fdc.hqry.Connection.Params.DriverID='PG'
then  fdc.hqry.sql.add(' WHERE    ( (StrPos(remark,''SSD'')>0) )  ')
else fdc.hqry.sql.add(' WHERE    ( (InStr([remark],''SSD'')>0) )  ');

 // fdc.hqry.sql.add(' WHERE   (  (InStr([remark],''SSD'')>0) )  ');
  fdc.hqry.execsql;
 end;
 { tracegas module eliminiert
if  prmdlgf.gd_edt.Enabled    then
begin
fdc.hqry.SQL.Clear;
fdc.hqry.sql.add('update CDY_RSLT set AUSWAHL=''*'' ');
fdc.hqry.sql.add(' WHERE   (  (InStr([remark],"TGM")>0) )  ');
fdc.hqry.execsql;
end;
  }
//   or ( ( k>0) and prmdlgf.chk_cips.checked  ) )
{ no cips
if prmdlgf.chk_cips.checked   then
begin
fdc.hqry.SQL.Clear;
fdc.hqry.sql.add('update CDY_RSLT set AUSWAHL=''*'' ');
fdc.hqry.sql.add(' WHERE   (  (InStr([remark],"CIPS")>0) )  ');
fdc.hqry.execsql;
end;
         }
end;

procedure Tsel_res_frm.Button3Click(Sender: TObject);
var i:integer;
begin
for i:=0 to checklistbox1.Items.Count-1 do
begin
    checklistbox1.checked[i]:=false;
end;
fdc.hqry.sql.clear;
fdc.hqry.sql.add('update CDY_RSLT set AUSWAHL='' '' ');
fdc.hqry.execsql;
end;

procedure Tsel_res_frm.Button4Click(Sender: TObject);
var i:integer;
begin
for i:=0 to checklistbox1.Items.Count-1 do
begin
    checklistbox1.checked[i]:=not  checklistbox1.checked[i];
end;
fdc.hqry.sql.clear;
fdc.hqry.sql.add('update CDY_RSLT set AUSWAHL=''#'' where AUSWAHL=''*'' ');
fdc.hqry.execsql;
fdc.hqry.sql.clear;
fdc.hqry.sql.add('update CDY_RSLT set AUSWAHL=''*'' where AUSWAHL='' '' ');
 if fdc.hqry.Connection.Params.DriverID='PG'
then  fdc.hqry.sql.add(' WHERE  not ( (StrPos(remark,''SSD'')>0) )  ')
else fdc.hqry.sql.add(' WHERE  not ( (InStr([remark],''SSD'')>0) )  ');
//fdc.hqry.sql.add('and  not (   (InStr([remark],''CIPS'')>0)  or  (InStr([remark],''TGM'')>0)  or  (InStr([remark],''SSD'')>0) )  ');
fdc.hqry.execsql;

 if prmdlgf.chk_ssd.checked   then
 begin
fdc.hqry.sql.clear;
fdc.hqry.sql.add('update CDY_RSLT set AUSWAHL=''*'' where AUSWAHL='' '' ');
 if fdc.hqry.Connection.Params.DriverID='PG'
then  fdc.hqry.sql.add(' and   ( (StrPos(remark,''SSD'')>0) )  ')
else fdc.hqry.sql.add(' and ( (InStr([remark],''SSD'')>0) )  ');
//fdc.hqry.sql.add('and  InStr([remark],''SSD'')>0   ');
fdc.hqry.execsql;
 end;

 { no trace gas module  and cips also
 if prmdlgf.gd_edt.enabled   then
 begin
fdc.hqry.sql.clear;
fdc.hqry.sql.add('update CDY_RSLT set AUSWAHL=''*'' where AUSWAHL='' '' ');
fdc.hqry.sql.add('and  InStr([remark],"TGM")>0   ');
fdc.hqry.execsql;
 end;


  if prmdlgf.chk_cips.checked   then
 begin
fdc.hqry.sql.clear;
fdc.hqry.sql.add('update CDY_RSLT set AUSWAHL=''*'' where AUSWAHL='' '' ');
fdc.hqry.sql.add('and  InStr([remark],"CIPS")>0   ');
fdc.hqry.execsql;
 end;
                      }


fdc.hqry.sql.clear;
fdc.hqry.sql.add('update CDY_RSLT set AUSWAHL='' '' where AUSWAHL=''#'' ');
fdc.hqry.execsql;
end;


procedure Tsel_res_frm.res_tab_aktualisieren;
var
    i,t,d,k:integer;
    res_item:string;
begin

 fdc.hqry.Close;
 fdc.hqry.SQL.Clear;
 fdc.hqry.SQL.Add('select RESULTAT, AUSWAHL, resultnr, remark from CDY_RSLT where resultnr>0 order by resultat ' );
 fdc.hqry.open;
 fdc.hqry.first;
 fdc.hqry.FetchAll;    // otherwise we dont know the exact record count
 setlength(hints, fdc.hqry.RecordCount+1);
 checklistbox1.items.clear;
 i:=0;

 repeat
 // application.MessageBox(pwidechar(fdc.hqry.FieldByName('resultat').AsString),'checkup',mb_ok);
   res_item:= fdc.hqry.FieldByName('REMARK').AsString;
   k:=  pos('CIPS',res_item);
   d:=  pos('SSD',res_item);
   t:=  pos('TGM',res_item);
   if ( (( k=0) and (d=0)  and (t=0))
   or ( ( d>0) and prmdlgf.chk_ssd.checked  ))
  // or ( ( t>0) and prmdlgf.gd_edt.Enabled )
  // or ( ( k>0) and prmdlgf.chk_cips.checked  ) )
   then
   begin

   checklistbox1.items.add(fdc.hqry.fieldbyname('RESULTAT').asstring);
   hints[i]:= trim(res_item);

   if fdc.hqry.fieldbyname('AUSWAHL').asstring='*' then
   begin
    checklistbox1.checked[i]:=true;
    if gis_mode then begin checklistbox1.State[i]:=cbgrayed;
                       checklistbox1.itemenabled[i]:=false;
                      end;
   end;
   inc(i);
   end ;
   fdc.hqry.next;
 until fdc.hqry.Eof;

end;

end.
