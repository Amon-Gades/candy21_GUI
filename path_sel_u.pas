unit path_sel_u;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, FileCtrl;

type
  Tpath_sel = class(TForm)
    DirectoryListBox1: TDirectoryListBox;
    DriveComboBox1: TDriveComboBox;
    Label1: TLabel;
    Button1: TButton;
    Button2: TButton;
    procedure Button2Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    sel_path,
    org_path : string;
  end;

var
  path_sel: Tpath_sel;

implementation

{$R *.DFM}

procedure Tpath_sel.Button2Click(Sender: TObject);
begin
 sel_path:=org_path;
 path_sel.close;
end;

procedure Tpath_sel.FormActivate(Sender: TObject);
begin
 directoryListBox1.directory:=org_path;
end;

procedure Tpath_sel.Button1Click(Sender: TObject);
begin
 sel_path:=directorylistbox1.directory;
 path_sel.close;
end;

end.
