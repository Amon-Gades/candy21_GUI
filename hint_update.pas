unit hint_update;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, strutils,  registry,   ActiveX,  wininet, Vcl.Dialogs, Vcl.StdCtrls,
  Vcl.OleCtrls, SHDocVw, Data.DB, Data.Win.ADODB;

type
  Thint_update_fm = class(TForm)
    wb: TWebBrowser;
    Button1: TButton;
    ListBox1: TListBox;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private-Deklarationen }
    cdy_reg: tregistry;
  public
    { Public-Deklarationen }
    procedure get_new_version(var vid:string; var dataset: string);
    procedure update_internal_data(dataset:string);
    procedure process_dataset(data_set:string);
    function  is_a_new_version(vid,cur_vid:string):boolean;
  end;

var
  hint_update_fm: Thint_update_fm;

implementation

{$R *.dfm}

uses candy_uif, FDC_modul;

procedure Thint_update_fm.Button1Click(Sender: TObject);
var
PersistStream: IPersistStreamInit;
   Stream: IStream;
   FileStream: TFileStream;
   wpath,aline,newsline,version_id,current_version,dataset, vrsdata:string;
   hfile:textfile;
   p0,p1:integer;
      cnt,nextversion:boolean;
begin
 cnt:=InternetCheckConnection(pwideChar('https://www.ufz.de/index.php?de=42459'),1,0);
 if  cnt then
 begin
  cdy_reg:=Tregistry.Create;
   cdy_reg.RootKey := HKEY_CURRENT_USER;
   if cdy_reg.OpenKey('\Software\candy', False)
   then
   begin

     //versionsnummer lesen
     try current_version:= cdy_reg.Readstring('vsnr');  except ;     end;

    if current_version='' then   current_version:='0.0.0.0';


     try wpath:= cdy_reg.readstring('ppath'  ); except;  end;

   end;
   wb.Hide;
   wb.Navigate('https://www.ufz.de/index.php?de=43148');
   while Wb.ReadyState < READYSTATE_INTERACTIVE do   Application.ProcessMessages;
   if   Assigned(WB.Document) then
   begin
     PersistStream := WB.Document as IPersistStreamInit;
     FileStream := TFileStream.Create(wpath+'\tmp_hints.html', fmCreate) ;
     try
       Stream := TStreamAdapter.Create(FileStream, soReference) as IStream;
       if Failed(PersistStream.Save(Stream, True)) then ShowMessage('SaveAs HTML fail!') ;
     finally
       FileStream.Free;
     end;
     assignfile(hfile,wpath+'\tmp_hints.html');
     reset(hfile);
     repeat
       readln(hfile,aline);
       aline:=utf8tostring(aline);
     until eof(hfile) or ( pos('### internal_updates',aline)>0);

     p0:=pos('#version',aline);
     dataset:=aline;
     repeat
     p1:=pos('*end',dataset);
     vrsdata:=copy(dataset,p0,p1-p0-1);  // hier ist der komplette Text einer Version enthalten
     dataset:=copy(dataset,p1+4,length(dataset));
     nextversion:=true;
  //   repeat
       get_new_version( version_id, vrsdata);
       if is_a_new_version(version_id,current_version) then
       begin
         listbox1.Items.Add(' going for version '+version_id);
         update_internal_data(vrsdata);
         application.ProcessMessages;
         cdy_reg.writestring('vsnr',trim(version_id));
         current_version:=trim(version_id);
       end;

    // until version_id='';
     p0:=pos('#version',dataset);
     until p0=0;
     listbox1.Items.Add(' no further updates found - end of processing');
     closefile(hfile);
   end; // if document
 end; // if cnt
 button2.Show;
end;  //button

procedure Thint_update_fm.Button2Click(Sender: TObject);
begin
 close;
end;

procedure Thint_update_fm.FormActivate(Sender: TObject);
begin
button1.Click;
end;

procedure Thint_update_fm.get_new_version(var vid:string;var dataset: string);
var h:string;
  p0,p1:integer;
begin
  p0:=pos('#version:',dataset);
  p1:=pos('*data',dataset);
  h:= copy(dataset,p0,p1-p0);
  p0:=pos('[',h);
  p1:=pos(']',h);
  vid:=trim(copy(h,p0+1,p1-p0-1));
  p0:=pos('*data',dataset)+5;
  dataset:=copy(dataset,p0,length(dataset));
end;

procedure Thint_update_fm.update_internal_data(dataset:string);
var h:string;
    p0,p1:integer;
    another_record:boolean;
begin
   another_record:=true;
    p0:=pos('[',dataset);
    dataset:=copy(dataset,p0,length(dataset));
    p0:=1;
   repeat
     p1:=pos('</p',dataset);
     h:=copy(dataset,p0,p1-1);
     listbox1.Items.add(h);
     process_dataset(h);
     dataset:=copy(dataset,p1+3,length(dataset));
     p0:=pos('[',dataset);
     another_record:=(p0>0);
   until not another_record ;
   listbox1.Items.Add(' version update finished ');
end;

procedure  Thint_update_fm.process_dataset(data_set:string);
var h, tablename,condition,fieldname,fieldvalue:string;
    p0,p1,i:integer;
    itemlst:array[1..4] of string;
begin
 for i:=1 to 4 do
 begin
  p0:=pos('[',data_set);
  p1:=pos(']',data_set);
  itemlst[i]:=copy(data_set,p0+1,p1-p0-1);
  data_set:=copy(data_set,p1+1,length(data_set));
 end;
// intqry
 fdc.any_update.SQL.Clear;
 fdc.any_update.SQL.Add('update '+itemlst[1]+' set '+itemlst[3]+'='+itemlst[4]+' where '+itemlst[2]);
  try
   fdc.any_update.ExecSQL;
  except
   // if update fails
   listbox1.Items.Add('... not successful');
  end;
end;


function  Thint_update_fm.is_a_new_version(vid,cur_vid:string):boolean;
var  hc,hx:string  ;
     i:integer;
     newv:boolean;
begin
  newv:=false;
  if vid<>'' then
  begin
//  cur_vid:=cdy_uif.info1.GetThisExeVersion;
    for i:= 1 to 3 do
    begin
      hc:=leftstr(cur_vid,pos('.',cur_vid)-1);
      hx:=leftstr(    vid,pos('.',    vid)-1);
      cur_vid:=copy(cur_vid,pos('.',cur_vid)+1,25) ;
          vid:=copy(    vid,pos('.',    vid)+1,25) ;
      newv:=newv or  (strtoint(hx)>strtoint(hc) );
    end;
      newv:=newv or  (strtoint(vid)>strtoint(cur_vid) );
  end;
  is_a_new_version:=newv;
end;

end.
