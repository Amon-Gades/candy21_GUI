unit get_db_name;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  Tfget_db_name = class(TForm)
    db_name: TEdit;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  fget_db_name: Tfget_db_name;

implementation

{$R *.DFM}

procedure Tfget_db_name.Button1Click(Sender: TObject);
begin
 close;
end;

end.
