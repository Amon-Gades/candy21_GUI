unit get_a_name;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  Tfrm_get_a_name = class(TForm)
    Edit1: TEdit;
    Label1: TLabel;
    Button1: TButton;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    last_button:integer;
  end;

var
  frm_get_a_name: Tfrm_get_a_name;

implementation

{$R *.dfm}

procedure Tfrm_get_a_name.Button1Click(Sender: TObject);
begin
 last_button:=1;
 close;
end;

procedure Tfrm_get_a_name.Button2Click(Sender: TObject);
begin
 last_button:=2;
 close;
end;

end.
