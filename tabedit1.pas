unit tabedit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, fdc_modul,
  Dialogs, Grids, DBGrids, DB, ADODB, StdCtrls, ExtCtrls, DBCtrls;

type
  Tftabed = class(TForm)
   // ADO_Table1: TADOTable;
    DBGrid1: TDBGrid;
    Button1: TButton;
    DBNavigator1: TDBNavigator;
    procedure Button1Click(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
        waitmode:boolean;
  end;

var
  ftabed: Tftabed;

implementation


{$R *.dfm}

procedure Tftabed.Button1Click(Sender: TObject);
begin
    waitmode:=false;
    ftabed.close;

end;

end.
