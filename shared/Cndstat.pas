{ management routines for the *.stc files (may be no more relevant in future as computation speed is increasing
but can be useful to initialise the model with most flexibility
}
unit cndstat;

{ Die Unit CNDSTAT liefert im wesentlichen Prozeduren, um die Status-Kataloge
  mit den einzelnen Status-Datens‰tzen zu verwalten. Die Katalogdateien sind vom
  Typ _STATUS. Die Katalog-Datens‰tze enthalten neben dem eigentlichen Status-
  Satz die Variablen VOR und NEXT, die auf den vorangegangen bzw. nachfolgenden
  Eintrag ( Satznummer ) in der Katalogdatei zeigen.
  Diese Zeigergrˆﬂen werden beim Lesen eines Status in den Globalvariablen
  satz_vor bzw. satz_next gespeichert und sind auch auﬂerhalb der UNIT verfÅgbar.
  Der letzte Eintrag fÅr einen Schlag ist durch <next>=-1, der erste durch
  <vor>=-1 gekennzeichnet;

  Algorithmen :

  procedure stc_create(name:string);
          - Legt eine Katalogdatei mit dem Namen <name> an.
            Namenskonventionen bestehen nicht.
  procedure s_open(var f: s_file;name:string);
          - ˆffnet den mit <name> bezeichneten Katalog
            f ist die Dateivariable. Wahrscheinlich wird
            diese Routine nur innerhalb der UNIT benˆtigt.
  procedure status_lesen(name:string;nr:integer;Var stat:statrec);
          - liest den mit <nr> bezeichneten Satz aus der mit <name>
            bezeichneten Katalogdatei und ¸bergibt den Status in der
            Variablen <stat>. Die G¸ltigkeit des Status wird nicht gepr¸ft !
  procedure status_schreiben(name:string;s:statrec;var n:integer);
          - h‰ngt den in <s> ¸bergebenen Status an die mit <name>
            bezeichnete Katalogdatei an. <n> liefert die Satznummer.
  procedure make_catalog(name:string;var cat:siptr);
          - Liest den Inhalt der mit <name> bezeichneten Katalogdatei auf den
            Heap. <cat> zeigt auf den Listenanfang. Ung¸ltige S‰tze werden
            nicht ber¸cksichtigt.
  procedure write_catalog(name:string; cat:siptr);
          - schreibt die auf dem Heap liegende Status-Liste, auf deren Anfang
            <cat> zeigt in die mit <name> bezeichnete Katalogdatei. Die neue
            Verzeichnis des jeweils ersten u. letzten Status fÅr einen
            speziellen Schlag werden mit der Schlagbezeichnug in der Textdatei
            CATALOG.$$$ gespeichert. Format: <schlag>:6,<1.Nr.>:4,<l.Nr.>:4$0D$0A
  procedure cutstat(name:string);
          - Bearbeitet wird die Katalogdatei <name>. In der Textdatei
            CUTLIST.$$$ wird die Bezeichnung der SchlÑge Åbergeben, fÅr die
            nur noch der letzte aufgefundene Status behalten wird. Eine
            Sicherheitskopie wird nicht erstellt.
  procedure find_vor_status(datei:string; schlag:string; jahr,tag:integer; var s:statrec; ok:boolean);
          - ¸bergibt in der Variablen <s> den Status des Schlages <schlag> aus der
            Katalogdatei <datei>, der unmittelbar vor dem mit <tag> und <jahr>
            bezeichnetem Termin liegt.
            das Ergebnis ist nur bei OK=true g¸ltig
  procedure get_cat_dir(datei:string;VAR cdir:dirptr);
          - schreibt das Inhaltsverzeichnis der Katalogdatei <datei> auf den
            Heap. Die Liste enth‰lt neben der Schlagbezeichnung die Anzahl der
            g¸ltigen Eintr‰ge. Die ebenfalls enthaltene Hilfvariable <nextrec>
            dient nur zum Aufbau der Datenstruktur.


}


interface

uses cnd_vars,ok_dlg1,sysutils;

type


 _status = record
              vor :integer;
              next:integer;
              info:statrec;
            end;

 s_file = file of _status;

 srecptr = ^srec;
   srec  = record
             status : statrec;
             next   : srecptr;
           end;

 siptr = ^si;
 si    = record
          schlag : string[8];
          nextrec: integer;
          p_srec : srecptr;
          next   : siptr;
        end;

 dirptr= ^dirrec;
 dirrec= record
          schlag : string[8];
          records,
          arec,
          nextrec: integer;
          next   : dirptr;
         end;




var
  satz_vor,satz_next : integer;


procedure stc_create(name:string);
procedure s_open(var f: s_file;name:string);
procedure status_lesen(name:string;nr:integer;Var stat:statrec);
procedure status_schreiben(name:string;s:statrec;var n:integer);
procedure make_catalog(name:string;var cat:siptr);
procedure write_catalog(name:string; cat:siptr);
procedure cutstat(name:string);
procedure find_vor_status(datei:string; schlag:string; jahr,tag:integer; var oldst:statrec; var nr:integer; var ok:boolean);
procedure get_cat_dir(datei:string;VAR cdir:dirptr);
procedure statinit(var s:statrec);
procedure stc_length(name:string; var l:integer);
procedure get_anfang(name,schlag:string; var anr:integer);

implementation

procedure stc_create(name:string);
var f: s_file;
    s: _status;
begin
 assign(f,name);
 rewrite(f);
 write(f,s);
 close(f);
end;

procedure s_open(var f: s_file;name:string);
begin
if pos('.',name)=0 then name:=name+'.stc';
if fileexists(name) then
begin
 assignfile(f,name);
 //{$I-}
 reset(f);
 //{$I+}
 {
 if ioresult <> 0 then
       begin
        //writeln('Statusdatei ',name,' nicht gefunden ');
        //writeln(' ! Abbruch unvermeidbar !');
        _halt(1);
       end;
        }
 end else _halt(1);

end;
procedure stc_length(name:string; var l:integer);

var f:s_file;
begin
  s_open(f,name);
  l:=filesize(f);
  close(f);
end;
procedure status_lesen(name:string;nr:integer;Var stat:statrec);

var f:s_file;
    l:integer;
    s:_status;
begin
s_open(f,name);
l:=filesize(f);
if nr>(l-1) then
             begin
             {
              writeln('Statusdatei ',name,' enth‰lt nur ',(l-1):4,' S‰tze !');
              writeln(' Zugriff auf Satz ',nr:4,' nicht mˆglich');
              writeln(' ! Abbruch unvermeidbar !');
              }
              _halt(15);
             end;
seek(f,nr);
read(f,s);
close(f);
stat:=s.info;
satz_vor:=s.vor;
satz_next:=s.next;

end;

procedure status_schreiben(name:string;s:statrec;var n:integer);


{ Eingang: n ist bisher letzte Satznummer }
{ Ausgang: n ist jetzt  letzte Satznummer }
{ ein neuer Status liegt vor, wenn n=-1   }

var f: s_file;
    stat:_status;
    l:integer;
begin
stat.info:=s;
s_open(f,name);
l:=filesize(f);
if l=0 then
begin
  //leere statusdatei
  //write blind record
  stat.vor :=-1;
  stat.next:=-1;
  write(f,stat);
  l:=filesize(f);
end;
seek(f,l);
if n > 0 then
begin                        { Folgestatus mit Vorg‰nger verketten }
 stat.vor :=n;
 stat.next:=-1;
 write(f,stat);
 seek(f,n);
 read(f,stat);
 stat.next:=l;
 seek(f,n);
 write(f,stat);
end
else
 begin                       { erstes Auftreten in der Statusliste }
  stat.vor :=-1;
  stat.next:=-1;
  write(f,stat)
 end;

close(f);
n:=l;
end;

procedure make_catalog(name:string;var cat:siptr);
var f:s_file;
    s    : _status;
    hcat,                { Hilfszeiger im Catalog }
    ecat : siptr;        { Ende des Catalogs      }
    hrec : srecptr;
    l,i  : integer;
begin
s_open(f,name);
l:=filesize(f);
new(cat);
hcat:=cat;
ecat:=cat;
if l=1 then            { leere Statusdatei }
       begin
       cat:=NIL;
       exit;
       end;
for i:=1 to l-1 do
begin
seek(f,i);
read(f,s);
if s.vor=-1
  then    { neuer Ast erforderlich }
    begin
    new(ecat^.next);
    ecat:=ecat^.next;
    ecat^.next:=NIL;
    new(hrec);             { Platz f¸r Statuseintrag    }
    hrec^.status:=s.info;
    hrec^.next:=NIL;
    ecat^.schlag := s.info.schlag;
    ecat^.nextrec:= s.next;
    ecat^.p_srec:=hrec;
    end
  else   { Ankn¸pfen an vorhandenen Ast }
   begin
    hcat:=cat;                         { Hilfszeiger auf Anfang }
    repeat hcat:=hcat^.next;   { passenden Ast suchen   }
    until (hcat=NIL) or ((hcat^.nextrec=i) and (hcat^.schlag=s.info.schlag));
    if hcat<> NIL  then                      { Ast gefunden           }
       begin
        hrec:=hcat^.p_srec;                  { Hilfszeiger auf Listenanfang }
        while hrec^.next<>NIL do
         hrec:=hrec^.next;                   { Listenende suchen          }
        new(hrec^.next);                     { Platz f¸r Statuseintrag    }
        hrec:=hrec^.next;                    { Zeiger auf freien Platz    }
        hrec^.next:=NIL;                     { Klappe zu                  }
        hrec^.status:=s.info;                { Status eintragen           }
        hcat^.nextrec:=s.next;               { Folgenummer merken         }
       end;
   end;
end;
close(f);
cat:=cat^.next;
end;

function satz_eindeutig(r:siptr):boolean;
var n:string;
    d:boolean;
begin
 n:=r^.schlag;
 d:=false;
 while (r^.next<>NIL) and not d do
   begin
    r:= r^.next;
    d:= (r^.schlag=n);
   end;
 satz_eindeutig:= not d;
end;

procedure write_catalog(name:string; cat:siptr);
var f:s_file;
    t:text;
    snr,utlg,
    fda_s0,fda_s1,
    n,l:integer;
    snr_,utlg_ :string ;
    s:_status;

function make_snr(sbez:string):integer;
var i,h:integer;
begin
 while sbez[1]='_' do sbez:=copy(sbez,2,length(sbez)-1);

 if pos('-',sbez)>0 then sbez:=copy(sbez,1,length(sbez)-2)   {___1-0}
                    else sbez:=copy(sbez,1,length(sbez)-1);  {___10}
 val(sbez,i,h);
 make_snr:=i;
end;

function make_pnr(sbez:string):integer;
var i,h:integer;
begin
 val(sbez[length(sbez)],i,h);
 make_pnr:=i;
end;


begin
 stc_create(name);
 s_open(f,name);
 assign(t,'CATALOG.$$$');
 rewrite(t);
 l:=0;
 while cat<>NIL do
  begin
   if satz_eindeutig(cat) then
   begin
   n:=-1;

   fda_s0:=l+1;
   snr:=make_snr(cat.schlag);
   snr_:=inttostr(snr);
   utlg:=make_pnr(cat.schlag);
   utlg_:=inttostr(utlg);
   write(t,cat^.schlag:6,snr_:6,utlg_:6,fda_s0:6);
   while cat^.p_srec<>NIL do
      begin
        inc(l);
        s.vor :=n;
        s.info:= cat^.p_srec^.status;
        if cat^.p_srec^.next=NIL then s.next:=-1 else s.next:=l+1;
        seek(f,l);
        write(f,s);
        n:=l;
        cat^.p_srec:=cat^.p_srec^.next;
      end;

   fda_s1:=n;
   writeln(t,fda_s1:6);



   end;
   cat:=cat^.next;
  end;
  close(t);
  close(f);
 end;

procedure cutstat(name:string);
var cat,h:siptr;
    schlag:string;
    t:text;
begin
make_catalog(name,cat);
assign(t,'CUTLIST.$$$');
reset(t);
while not eof(t) do
begin
 readln(t,schlag);
 h:=cat;
 while (h<>NIL) and (h^.schlag<>schlag) do h:=h^.next;      { Schlag suchen }
 while h^.p_srec^.next<>NIL do             { der letzte soll der erste sein }
             h^.p_srec:=h^.p_srec^.next;
end;
write_catalog(name,cat);
end;

procedure find_vor_status(datei:string; schlag:string; jahr,tag:integer; var oldst:statrec; var nr:integer; var ok:boolean);

begin
if jahr<100 then jahr:=jahr+1900;

{den letzten g¸ltigen Status lesen}
status_lesen(datei,nr,oldst);

if satz_next=-1 then
begin                                       { der Status war der letzte in der Kette -‰ltere S‰tze lesen }
 while (oldst.jahr<>jahr) and (satz_vor>0) do         {vorgehen bis zum gesuchten Jahr}
 begin
   nr:=satz_vor;
   status_lesen(datei,nr,oldst);
 end;
 if (oldst.jahr<>jahr) then
    begin
     ok:=false;
     exit;                          {das gesuchte Jahr ist nicht enthalten}
    end;
 while (oldst.tag>tag) and (oldst.jahr=jahr) and (satz_vor>0) do
 begin
   nr:=satz_vor;
   status_lesen(datei,nr,oldst);
 end;                               {Suche beendet}

 if (oldst.jahr=jahr) and (oldst.tag<=tag) then
    begin                           {Suche war erfolgreich}
     ok:=true;
    end
 else
    begin                           {Suche war erfolglos}
     ok:=false;
    end;
 end
 else
 begin                              { der Status war inmitten der Kette - j¸ngere SÑtze lesen }

 while (oldst.jahr<jahr)
        and (satz_next>0) do        {Jahr suchen}
 begin
  nr:=satz_next;
  status_lesen(datei,nr,oldst);
 end;

 if (oldst.jahr<>jahr) then
    begin
     ok:=false;
     exit;                          {das gesuchte Jahr ist nicht enthalten}
    end;

 while (oldst.tag<tag)
  and (oldst.jahr=jahr)
  and (satz_next>0) do              {Tag suchen}
 begin
  nr:=satz_next;
  status_lesen(datei,nr,oldst);
 end;
 if (satz_next<0) then              {das war der letzte Status in der Kette}
  begin
  if (oldst.tag<=tag)
   and (oldst.jahr=jahr)
   then ok:=true                    {der letzte Status kann benutzt werden}
   else ok:=false;                  {es ist kein zutreffender Status zu finden}
  exit;
  end;

 {zuletzt gelesener Statustag  >  Zieltag oder Jahr Åberschritten}
 if oldst.tag>tag then
  begin                             {vorhergehenden Status benutzen}
   nr:=satz_vor;
   if nr>0 then status_LESEN(datei,nr,oldst);
  end;
 ok:= (oldst.tag<=tag) and (oldst.jahr=jahr);
end;

end;

procedure get_anfang(name,schlag:string; var anr:integer);
var catdir,hdir:dirptr;
begin
 get_cat_dir(name,catdir);
 hdir:=catdir;
 while (hdir.schlag<>schlag) do
 begin
  if (hdir.next<>nil) then  hdir:=hdir.next;
 end;
 if hdir.schlag=schlag then  anr:=hdir.arec
                        else _halt(15);
end;

procedure get_cat_dir(datei:string;VAR cdir:dirptr);

var f:s_file;
    s    : _status;
    hdir : dirptr;       { Hilfszeiger im Verzeichnis }
    l,i  : integer;
begin
s_open(f,datei);
l:=filesize(f);
new(cdir);
hdir:=cdir;
if l=1 then            { leerer Statuscatalog }
       begin
       cdir:=NIL;
       exit;
       end;
for i:=1 to l-1 do
begin
seek(f,i);
read(f,s);
if s.vor=-1
  then    { neuen Schlag entdeckt }
    begin
    new(hdir^.next);
    hdir:=hdir^.next;
    hdir^.next:=NIL;
    hdir^.schlag := s.info.schlag;
    hdir^.nextrec:= s.next;
    hdir^.records:=1;
    hdir^.arec:=i;
    end
  else   { Ankn¸pfen an vorhandenen Ast }
   begin
    hdir:=cdir^.next;                        { Hilfszeiger auf Anfang }
    while (hdir^.schlag<>s.info.schlag)
      and (hdir<>NIL) do hdir:=hdir^.next;   { passenden Ast suchen   }
    if hdir<> NIL  then                      { Ast gefunden           }
       if hdir^.nextrec=i then               { g¸ltige Satznummer     }
       begin
        inc(hdir^.records);                  { Z‰hler erhˆhen         }
        hdir^.nextrec:=s.next;               { Folgenummer merken     }
        hdir.arec:=i;
       end;
   end;
end;
close(f);
cdir:=cdir^.next;                            { Zeiger auf Anfang      }
end;

procedure statinit(var s:statrec);
var i,j:byte;
begin
s.snow   :=0;
s.speisch:=0;
s.szep   :=0;
s.nobfl  :=0;
s.pnr    :=0;
s.veganf :=0;
s.vegend :=0;
s.apool  :=0;
s.nvirt  :=0;
s.maxpflent:=0;
s.kumpflent:=0;
s.legans   :=false;
s.mtna     :=0;
s.wutief   :=0;
s.bedgrd   :=0;
s.bestho   :=0;
s.besruh   :=false;
s.forts    :=0;
for i:=1 to 20 do
 begin
  s.botem[i]  := 10;
  s.bofeu[i]  := 10;
  s.nin[i]    := 1;
  s.amn[i]    := 1;
 end;
for i:=1 to 3 do
 begin
  s.aos[i]:=1000;
  s.sos[i]:=3000;
  for j:=1 to maxfraz do begin
                          s.ops[j].c[i]:=0;
                          s.ops[j].nr:=0;
                         end;
 end;
end;

begin
end.