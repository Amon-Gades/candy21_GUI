{
 implements methods to calculate a nitrogen balance from management data
}
unit cdy_bil;
interface
uses cnd_vars;
type
Pcnd_bilanz=^Tcnd_bilanz;
Tcnd_bilanz = class(Tobject)
               n_saldo_harv,
               n_saldo,
               n_dng_min,
               n_dng_org,
               n_dng_sym : real;
               constructor create;
               procedure   update(s:sysstat);
               procedure   calc_n_saldo(n_off, n_ewr:real; var saldo:real);
               procedure   reset;
             end;
// var bilanz:Tcnd_bilanz;

implementation

constructor Tcnd_bilanz.create;
begin
   reset;
   n_saldo:=-999;
   n_saldo_harv:=-999;
end;

procedure Tcnd_bilanz.calc_n_saldo(n_off, n_ewr:real ; var saldo:real);
begin
 n_saldo:=n_dng_org+n_dng_min+n_dng_sym-n_off ;
 n_saldo_harv:=n_saldo-n_ewr;
 saldo:=n_saldo;
end;

procedure Tcnd_bilanz.reset;
begin
 n_dng_min:=0;
 n_dng_org:=0;
 n_dng_sym:=0;
end;

procedure Tcnd_bilanz.update(s:sysstat);
begin
 n_dng_min:=n_dng_min+s.mDng_n;
 n_dng_org:=n_dng_org+s.oDng_n;
 n_dng_sym:=n_dng_sym+s.symb_n;
end;



begin
end.