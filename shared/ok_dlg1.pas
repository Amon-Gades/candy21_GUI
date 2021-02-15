{$INCLUDE cdy_definitions.pas}
unit ok_dlg1;

interface
 uses
 {$IFDEF CDY_SRV}
  FMX.Forms,
  cdy_config;
 {$ENDIF}

 {$IFDEF CDY_GUI}
 Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls;

type
  TOK_Dlg = class(TForm)
    OKBtn: TButton;
    Label1: TLabel;
    procedure OKBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
//    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    subtext:string;
    abbruch:boolean;
  end;
{$ENDIF}

 procedure _halt(c:byte);
 var
 anything: integer;
 {$IFDEF CDY_GUI}
  OK_Dlg: TOK_Dlg;
{$ENDIF}
implementation

{$IFDEF CDY_GUI}
{$R *.DFM}
{$ENDIF}

procedure _halt(c:byte);
var zeile:string;
begin
case c of
1 : zeile:=' CEC  1:  error opening file / file not found ';
2 : zeile:=' CEC  2';
3 : zeile:=' CEC  3:  no valid latitude ';
4 : zeile:=' CEC  4:  error reading management data  ';
5 : zeile:=' CEC  5:  error reading crop parameters  ';
6 : zeile:=' CEC  6:  fos parameters not found  ';
7 : zeile:=' CEC  7:  to many fos pools in system ';
8 : zeile:=' CEC  8:  error reading climate data ';
9 : zeile:=' CEC  9  ';
10 : zeile:=' CEC 10:  profile not found  ';
11 : zeile:=' CEC 11 ';
12 : zeile:=' CEC 12:  error reading climate data  ';
13 : zeile:=' CEC 13:  wrong structure of climate file(to many records)  ';
14 : zeile:=' CEC 14:  unexpected end of climate data  ';
15 : zeile:=' CEC 15:  error reading stc file  ';
16 : zeile:=' CEC 16:  CANDY-error  ';
17 : zeile:=' CEC 17:  Nmin<0  ';
18 : zeile:=' CEC 18:  read- or conversion error  ';
19 : zeile:=' CEC 19:  unknown parameter  ';
20 : zeile:=' CEC 20:  error during SOM intialisation';
22 : zeile:=' CEC 22:  error in job control ';
23 : zeile:=' CEC 23:  no state for initialisation ';
24 : zeile:=' CEC 24:  Data not longer consistent';
50 : zeile:=' CEC 50:  error in water module';
51 : zeile:=' CEC 51:  error in N-cycle';
55 : zeile:=' CEC 55:  Item in CDYDEVPA not found ';
56 : zeile:=' CEC 56:  Grasland parameters not in database';
60 : zeile:=' CEC 60:  incomplete definition of MW class ';
100: zeile:=' CEC 100: error reading FDA file ';
101: zeile:=' CEC 101: no data for cdyaparm ';
121: zeile:=' CEC 121: no crop for autofert-module ';
200: zeile:=' CEC 200: soil data dot found';
201: zeile:=' CEC 201: could not initialize a requested agrochemical';
end;

 {$IFDEF CDY_GUI}
ok_dlg.caption:='error message';
ok_dlg.label1.caption:=zeile + ok_dlg.subtext;
ok_dlg.ShowModal;

 {$ENDIF}

 {$IFDEF CDY_SRV}
 append (poutfile);
 writeln(poutfile,zeile);
 close  (poutfile);
 {$ENDIF}

 application.Terminate;
halt;

end;

 {$IFDEF CDY_GUI}
procedure TOK_Dlg.FormCreate(Sender: TObject);
begin
{erst mal ausblenden   }
 abbruch:=false;
 subtext:='';

end;

procedure TOK_Dlg.OKBtnClick(Sender: TObject);
begin
    abbruch:=true;
    OK_dlg.close;
end;




begin
  {$ENDIF}
end.
