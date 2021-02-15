unit Unit8;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.OleCtrls, SHDocVw;

type
  Tccb_info = class(TForm)
    wb1: TWebBrowser;
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  ccb_info: Tccb_info;

implementation

{$R *.dfm}

end.
