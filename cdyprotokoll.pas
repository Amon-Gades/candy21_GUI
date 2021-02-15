unit cdyprotokoll;

interface
    function writeprotokoll( OutString: string ):boolean;


implementation
   uses   Windows, Messages, SysUtils, Classes, Graphics, Controls, Dialogs,
         StdCtrls, ComCtrls ;
 var
  FPROT:textfile;
  Dateiname : string;


//{$DEFINE CDY_PROT}
{$UNDEF CDY_PROT}

function writeprotokoll( OutString: string ):boolean;

begin
  {$IFDEF CDY_PROT}
   append(FPROT);
   Writeln(FPROT, outstring);
   closefile(fprot)   ;
  {$ENDIF}
  result := true    ;
end;

 begin
  {$IFDEF CDY_PROT}
  dateiname := 'cdy_prot.txt'   ;
  AssignFile(FPROT, Dateiname);
  rewrite (FPROT);
  {$ENDIF}

end.
 