unit GrassParameters;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls,  Data.DB, Data.Win.ADODB,    candy_uif,
  Vcl.DBCtrls;

type
  TForm_2 = class(TForm)
    Panel2: TPanel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label43: TLabel;
    Label49: TLabel;
    Label56: TLabel;
    Label57: TLabel;
    Label58: TLabel;
    Edit6: TEdit;
    Edit7: TEdit;
    Edit31: TEdit;
    Edit38: TEdit;
    CheckBox12: TCheckBox;
    CheckBox16: TCheckBox;
    CheckBox18: TCheckBox;
    Panel3: TPanel;
    Label25: TLabel;
    Label34: TLabel;
    Label37: TLabel;
    Label38: TLabel;
    Label18: TLabel;
    Edit24: TEdit;
    Edit26: TEdit;
    Edit27: TEdit;
    Edit9: TEdit;
    Panel4: TPanel;
    Label27: TLabel;
    Label41: TLabel;
    Label42: TLabel;
    Label44: TLabel;
    Edit29: TEdit;
    Edit30: TEdit;
    Edit34: TEdit;
    Panel5: TPanel;
    Label26: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label36: TLabel;
    Label39: TLabel;
    Label48: TLabel;
    Label50: TLabel;
    Label51: TLabel;
    Edit10: TEdit;
    Edit11: TEdit;
    Edit13: TEdit;
    Edit14: TEdit;
    Edit25: TEdit;
    Edit28: TEdit;
    Edit37: TEdit;
    Edit41: TEdit;
    Edit42: TEdit;
    Edit43: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Edit2: TEdit;
    Label4: TLabel;
    Panel1: TPanel;
    Label55: TLabel;
    CheckBox9: TCheckBox;
    Label5: TLabel;
    Label33: TLabel;
    Edit20: TEdit;
    Label52: TLabel;
    Edit44: TEdit;
    Label46: TLabel;
    Label7: TLabel;
    Label6: TLabel;
    Label47: TLabel;
    Edit8: TEdit;
    Edit35: TEdit;
    Edit36: TEdit;
    Label3: TLabel;
    Edit1: TEdit;
    Edit3: TEdit;
    gmnm_src: TDataSource;
    DBLookupComboBox1: TDBLookupComboBox;
    Label8: TLabel;
    Edit4: TEdit;
    Button3: TButton;
    geom_save: TButton;
    compet_save: TButton;
    estab_save: TButton;
    mort_save: TButton;
    growth_save: TButton;
    Button1: TButton;
    cb_edit: TCheckBox;
    procedure Button1Click(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure DBLookupComboBox1CloseUp(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Edit4Change(Sender: TObject);
    procedure estab_saveClick(Sender: TObject);
    procedure compet_saveClick(Sender: TObject);
    procedure mort_saveClick(Sender: TObject);
    procedure growth_saveClick(Sender: TObject);
    procedure geom_saveClick(Sender: TObject);
    procedure cb_editClick(Sender: TObject);

  private
    { Private-Deklarationen }
    editmode:boolean;
    procedure set_edit(on:boolean);
  public
    { Public-Deklarationen }
    selname:string;
    procedure getSpeciesPar(grp: integer);
  end;

var
  Form_2: TForm_2;

implementation



{$R *.dfm}

uses FDC_modul;

    procedure TForm_2.cb_editClick(Sender: TObject);
    begin
       set_edit(cb_edit.Checked);
    end;


procedure TForm_2.Button1Click(Sender: TObject);   //set parameter
begin
 // setSpeciesPar(strtoint(Form_2.Edit2.Text));
  Form_2.close;
end;
procedure TForm_2.Button2Click(Sender: TObject);  // reset parameter
begin
 // grassmind_getSpeciesPar(strtoint(Form_2.Edit2.Text));
end;

procedure Tform_2.set_edit(on:boolean);
begin
if on then
 begin
 fdc.gmp.Open;
 if fdc.gmp.Locate('art_id',edit2.Text,[]) then
 begin
 with estab_save do
 begin
  Visible:=true;
  Enabled:=true;
  Caption:='save to item '+edit2.Text;
 end;
 with geom_save do
 begin
  Visible:=true;
  Enabled:=true;
  Caption:='save to item '+edit2.Text;
 end;

 with growth_save do
 begin
  Visible:=true;
  Enabled:=true;
  Caption:='save to item '+edit2.Text;
 end;

 with compet_save do
 begin
  Visible:=true;
  Enabled:=true;
  Caption:='save to item '+edit2.Text;
 end;

 with mort_save do
 begin
  Visible:=true;
  Enabled:=true;
  Caption:='save to item '+edit2.Text;
 end;
 end;
 end else
 begin
  mort_save.Enabled:=false;
  mort_save.Visible:=false;
  compet_save.Enabled:=false;
  compet_save.Visible:=false;
  growth_save.Enabled:=false;
  growth_save.Visible:=false;
  estab_save.Enabled:=false;
  estab_save.Visible:=false;
  geom_save.Enabled:=false;
  geom_save.Visible:=false;
 end;


end;




procedure TForm_2.Button3Click(Sender: TObject);
begin
 Form_2.Caption:='species parametrisation: edit mode '    ;
 editmode:=true;
 label4.Hide;
 edit2.Hide;
 fdc.gm_id.Open;
 fdc.gm_id.first;
 edit2.Text:=fdc.gm_id.fieldbyname('new_id').asstring;
 with estab_save do
 begin
  Visible:=true;
  Enabled:=true;
  Caption:='save to new item '+edit2.Text;
 end;
 with geom_save do
 begin
  Visible:=true;
  Enabled:=true;
  Caption:='save to new item '+edit2.Text;
 end;

 with growth_save do
 begin
  Visible:=true;
  Enabled:=true;
  Caption:='save to new item '+edit2.Text;
 end;

 with compet_save do
 begin
  Visible:=true;
  Enabled:=true;
  Caption:='save to new item '+edit2.Text;
 end;

 with mort_save do
 begin
  Visible:=true;
  Enabled:=true;
  Caption:='save to new item '+edit2.Text;
 end;

 application.ProcessMessages;

fdc.gmp.Open;
fdc.gmp.Append;
fdc.gmp.FieldByName('art_id').AsString:=edit2.Text;
fdc.gmp.FieldByName('name').AsString:=edit4.Text;
fdc.gmp.FieldByName('com').AsString:='';
fdc.gmp.FieldByName('lightextk').AsString:='';
fdc.gmp.FieldByName('seedmass').AsString:='';
fdc.gmp.FieldByName('mortsapling').AsString:='';
fdc.gmp.FieldByName('mindage repro').AsString:='';
fdc.gmp.FieldByName('minh').AsString:='';
fdc.gmp.FieldByName('emergence').AsString:='';
fdc.gmp.FieldByName('germrate').AsString:='';
fdc.gmp.FieldByName('mortbasic').AsString:='';
fdc.gmp.FieldByName('pmax').AsString:='';
fdc.gmp.FieldByName('alpha').AsString:='';
fdc.gmp.FieldByName('gresp').AsString:='';
fdc.gmp.FieldByName('mresp').AsString:='';
fdc.gmp.FieldByName('hmax').AsString:='';
fdc.gmp.FieldByName('hwratio').AsString:='';
fdc.gmp.FieldByName('sla').AsString:='';
fdc.gmp.FieldByName('fs').AsString:='';
fdc.gmp.FieldByName('srl').AsString:='';
fdc.gmp.FieldByName('rls').AsString:='';
fdc.gmp.FieldByName('allocsh').AsString:='';
fdc.gmp.FieldByName('allocro').AsString:='';
fdc.gmp.FieldByName('allocre').AsString:='';
fdc.gmp.FieldByName('allocst').AsString:='';
fdc.gmp.FieldByName('of').AsString:='';
fdc.gmp.FieldByName('shootroot1').AsString:='';
fdc.gmp.FieldByName('shootroot2').AsString:='';
fdc.gmp.FieldByName('rootda').AsString:='';
fdc.gmp.FieldByName('rootdb').AsString:='';
fdc.gmp.FieldByName('lifespan').AsString:='';
fdc.gmp.FieldByName('nfix').AsString:='';
fdc.gmp.FieldByName('wue').AsString:='';
fdc.gmp.FieldByName('nue').AsString:='';
fdc.gmp.FieldByName('q10basis').AsString:='';
fdc.gmp.FieldByName('q10ref').AsString:='';
fdc.gmp.FieldByName('m').AsString:='';
fdc.gmp.FieldByName('sow').AsString:='';
fdc.gmp.FieldByName('CN').AsString:='';
fdc.gmp.FieldByName('plotsize').AsString:='';
fdc.gmp.FieldByName('plotnumber').AsString:='';
fdc.gmp.Post;
//fdc.gmp.Close;
end;



procedure TForm_2.compet_saveClick(Sender: TObject);
begin
// implement data staorage
 if fdc.gmp.FieldByName('art_id').AsString=edit2.text then
 begin
 fdc.gmp.Edit;
 fdc.gmp.FieldByName('cn').AsString  := Form_2.Edit1.Text ;
 fdc.gmp.FieldByName('wue').AsString := Form_2.Edit20.Text  ;
 fdc.gmp.FieldByName('nue').AsString:=  Form_2.Edit44.Text ;
 if checkbox9.checked  then  fdc.gmp.FieldByName('nfix').Asinteger:=  1
                       else  fdc.gmp.FieldByName('nfix').Asinteger:=  0;
 fdc.gmp.Post;
 compet_save.Caption:='* saved to item '+ edit2.Text;
 end;
end;

procedure TForm_2.DBLookupComboBox1CloseUp(Sender: TObject);

begin
 edit2.Text:= fdc.grm_names.FieldByName('art_id').AsString;
getSpeciesPar(strtoint(Form_2.Edit2.Text));
end;

procedure TForm_2.Edit4Change(Sender: TObject);
begin
if length(trim(edit4.text))>1 then
begin
 button3.Enabled:=true;

end;
end;

procedure TForm_2.estab_saveClick(Sender: TObject);
begin
// implement data staorage
 if fdc.gmp.FieldByName('art_id').AsString=edit2.text then
 begin
 fdc.gmp.Edit;
 fdc.gmp.FieldByName('minh').AsString  := Form_2.Edit8.Text ;
 fdc.gmp.FieldByName('mindage repro').AsString := Form_2.Edit9.Text  ;
 fdc.gmp.FieldByName('emergence').AsString:=  Form_2.Edit27.Text ;
 fdc.gmp.FieldByName('germrate').AsString := Form_2.Edit26.Text ;
 fdc.gmp.FieldByName('seedmass').AsString := Form_2.Edit24.Text ;
 fdc.gmp.Post;
 estab_save.Caption:='* saved to item '+ edit2.Text;
 end;
end;

procedure TForm_2.FormActivate(Sender: TObject);
begin
with fdc.grm_names do
begin
 Open;
 first;
end;
edit4.Text:='?';
 button3.Enabled:=false;
editmode:=false;
Form_2.Caption:='species parametrisation: check mode '    ;

  if selname<>'*' then
  begin
   if  fdc.grm_names.Locate('art_id',strtoint(selname),[]) then
   begin
      Form_2.Edit2.Text:=selname;
      dblookupcombobox1.KeyValue:=strtoint(selname);
      getSpeciesPar(strtoint(Form_2.Edit2.Text));
   end;
   end else
   begin
    fdc.grm_names.first;
    selname:=fdc.grm_names.FieldByName('art_id').Asstring;
    Form_2.Edit2.Text:=selname;
    dblookupcombobox1.KeyValue:=strtoint(selname);
    getSpeciesPar(strtoint(Form_2.Edit2.Text));
   end;
   application.ProcessMessages;



end;

procedure TForm_2.FormHide(Sender: TObject);
begin
  Form_2.Visible := false;
end;

procedure TForm_2.FormShow(Sender: TObject);
begin
  Form_2.Visible := true;

end;

procedure TForm_2.geom_saveClick(Sender: TObject);
begin
 // implement data staorage
 if fdc.gmp.FieldByName('art_id').AsString=edit2.text then
 begin
 fdc.gmp.Edit;

 fdc.gmp.FieldByName('of').AsString  := Form_2.Edit10.Text;
 fdc.gmp.FieldByName('allocsh').AsString:= Form_2.Edit11.Text;
 fdc.gmp.FieldByName('hwratio').AsString:= Form_2.Edit13.Text;
 fdc.gmp.FieldByName('fs').AsString     := Form_2.edit14.Text;
 fdc.gmp.FieldByName('hmax').AsString   := Form_2.Edit25.Text;
 fdc.gmp.FieldByName('sla').AsString    := Form_2.Edit28.Text;
 fdc.gmp.FieldByName('shootroot1').AsString:= Form_2.Edit37.Text;
 fdc.gmp.FieldByName('srl').AsString    := Form_2.Edit41.Text;
 fdc.gmp.FieldByName('rootda').AsString := Form_2.Edit42.Text;
 fdc.gmp.FieldByName('rootdb').AsString := Form_2.Edit43.Text;


 fdc.gmp.Post;
 geom_save.Caption:='* saved to item '+ edit2.Text;
 end;
end;

procedure tForm_2.getSpeciesPar(grp: integer);
var
  lifespan: integer;
begin
  fdc.aqry.SQL.Clear;
  fdc.aqry.SQL.Add('select * from grassmind_par where art_id=' + inttostr(grp));
  fdc.aqry.open;


  //geometry

 if geom_save.caption[1]<>'*' then
 begin
  Form_2.Edit10.Text := fdc.aqry.FieldByName('of').AsString;
  Form_2.Edit11.Text := fdc.aqry.FieldByName('allocsh').AsString;
  Form_2.Edit13.Text := fdc.aqry.FieldByName('hwratio').AsString;
  Form_2.edit14.Text := fdc.aqry.FieldByName('fs').AsString;
  Form_2.Edit25.Text := fdc.aqry.FieldByName('hmax').AsString;
  Form_2.Edit28.Text := fdc.aqry.FieldByName('sla').AsString;
  Form_2.Edit37.Text := fdc.aqry.FieldByName('shootroot1').AsString;
  Form_2.Edit41.Text := fdc.aqry.FieldByName('srl').AsString;
  Form_2.Edit42.Text := fdc.aqry.FieldByName('rootda').AsString;
  Form_2.Edit43.Text := fdc.aqry.FieldByName('rootdb').AsString;
 end;

  //growthparms
 if growth_save.caption[1]<>'*' then
 begin
  Form_2.edit3.Text  := fdc.aqry.FieldByName('M').AsString;
  Form_2.Edit36.Text := fdc.aqry.FieldByName('gresp').AsString;
  Form_2.Edit35.Text := fdc.aqry.FieldByName('mresp').AsString;
  Form_2.Edit29.Text := fdc.aqry.FieldByName('pmax').AsString;
  Form_2.Edit30.Text := fdc.aqry.FieldByName('alpha').AsString;
  Form_2.Edit34.Text := fdc.aqry.FieldByName('Lightextk').AsString;
 end;

 //competition
 if compet_save.caption[1]<>'*' then
 begin
  Form_2.Edit1.Text  := fdc.aqry.FieldByName('cn').AsString;
  Form_2.Edit20.Text := fdc.aqry.FieldByName('wue').AsString;
  Form_2.Edit44.Text := fdc.aqry.FieldByName('nue').AsString;
  Form_2.checkbox9.Checked := (fdc.aqry.FieldByName('nfix').AsInteger = 1)  ;
 end;

//mortality
  if mort_save.caption[1]<>'*' then
 begin
  Form_2.Edit6.Text := fdc.aqry.FieldByName('mortsapling').AsString;
  Form_2.edit7.Text := fdc.aqry.FieldByName('mortbasic').AsString;
  Form_2.Edit31.Text := fdc.aqry.FieldByName('lls').AsString;
  Form_2.Edit38.Text := fdc.aqry.FieldByName('rls').AsString;
  lifespan:= fdc.aqry.FieldByName('lifespan').Asinteger;
  case lifespan of
   1: begin
      Form_2.checkbox12.Checked := true;
      Form_2.checkbox16.Checked := false;
      Form_2.checkbox18.Checked := false;
      end;
   2: begin
      Form_2.checkbox12.Checked := false;
      Form_2.checkbox16.Checked := true;
      Form_2.checkbox18.Checked := false;
      end;
else  begin
      Form_2.checkbox12.Checked := false;
      Form_2.checkbox16.Checked := false;
      Form_2.checkbox18.Checked := true;
      end;//else
  end; //case
 end;// if


 //establishment
 if estab_save.caption[1]<>'*' then
 begin
  Form_2.Edit8.Text  := fdc.aqry.FieldByName('minh').AsString;
  Form_2.Edit9.Text  := fdc.aqry.FieldByName('mindage repro').AsString;
  Form_2.Edit27.Text := fdc.aqry.FieldByName('emergence').AsString;
  Form_2.Edit26.Text := fdc.aqry.FieldByName('germrate').AsString;
  Form_2.Edit24.Text := fdc.aqry.FieldByName('seedmass').AsString;
 end;



 end;



procedure TForm_2.growth_saveClick(Sender: TObject);
begin
 // implement data staorage
 if fdc.gmp.FieldByName('art_id').AsString=edit2.text then
 begin
 fdc.gmp.Edit;
 fdc.gmp.FieldByName('M').AsString     := Form_2.edit3.Text;
 fdc.gmp.FieldByName('gresp').AsString := Form_2.Edit36.Text;
 fdc.gmp.FieldByName('mresp').AsString := Form_2.Edit35.Text;
 fdc.gmp.FieldByName('pmax').AsString  := Form_2.Edit29.Text;
 fdc.gmp.FieldByName('alpha').AsString := Form_2.Edit30.Text;
 fdc.gmp.Post;
 growth_save.Caption:='* saved to item '+ edit2.Text;
 end;
end;

procedure TForm_2.mort_saveClick(Sender: TObject);
begin
// implement data staorage
 if fdc.gmp.FieldByName('art_id').AsString=edit2.text then
 begin
 fdc.gmp.Edit;
 fdc.gmp.FieldByName('mortsapling').AsString  := Form_2.Edit6.Text ;
 fdc.gmp.FieldByName('mortbasic').AsString := Form_2.Edit7.Text  ;
 fdc.gmp.FieldByName('lls').AsString:=  Form_2.Edit31.Text ;
 fdc.gmp.FieldByName('rls').AsString:=  Form_2.Edit38.Text ;

 if checkbox12.checked  then  fdc.gmp.FieldByName('lifespan').Asinteger:=  1  ;
 if checkbox16.checked  then  fdc.gmp.FieldByName('lifespan').Asinteger:=  2  ;
 if checkbox18.checked  then  fdc.gmp.FieldByName('lifespan').Asinteger:=  20  ;

 fdc.gmp.Post;
 mort_save.Caption:='* saved to item '+ edit2.Text;
 end;
end;

end.
