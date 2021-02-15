unit cdy_news;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  Tcdynews = class(TForm)
    newslist: TListBox;
    Button2: TButton;
    Button1: TButton;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
    mresult:integer;
  end;

var
  cdynews: Tcdynews;

implementation

{$R *.dfm}

procedure Tcdynews.Button1Click(Sender: TObject);
begin
MResult:=1;
cdynews.Close;
end;

procedure Tcdynews.Button2Click(Sender: TObject);
begin
MResult:=2;
cdynews.Close;
end;

end.
