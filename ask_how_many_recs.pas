unit ask_how_many_recs;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls;

type
  Trec_app_quest = class(TForm)
    Label1: TLabel;
    Edit1: TEdit;
    UpDown1: TUpDown;
    Button1: TButton;
    Button2: TButton;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  rec_app_quest: Trec_app_quest;

implementation

uses range_sel_U;

{$R *.dfm}

procedure Trec_app_quest.Button2Click(Sender: TObject);

var i,j,k,l:integer;
     ndat,
     vdat:array of string;
begin

k:=strtoint(edit1.text);
i:=range_select.dbgrid3.DataSource.DataSet.fields.Count;
setlength(ndat,i);
setlength(vdat,i);
for j:=0 to i-1 do
begin
 ndat[j]:= range_select.dbgrid3.DataSource.DataSet.fields.Fields[j].FieldName;
 vdat[j]:= range_select.dbgrid3.DataSource.DataSet.fields.Fields[j].AsString;
end;
for l:=1 to k do
begin
 range_select.dbgrid3.DataSource.DataSet.Append;
 for j:=0 to i-1 do
 begin
  range_select.dbgrid3.DataSource.DataSet.fields.FieldByName(ndat[j]).AsString:=vdat[j];
 end;
  range_select.dbgrid3.DataSource.DataSet.post;
end;


 rec_app_quest.close;
end;

procedure Trec_app_quest.Button1Click(Sender: TObject);
begin
 rec_app_quest.close;
end;

end.
