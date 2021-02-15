unit cdysomdyn;

{< this unit implements the @link(Tsomdyn) class for the turnover of Carbon and Nitrogen}
{$INCLUDE cdy_definitions.pas}
interface

uses
{$IFDEF CDY_GUI}
cdy_glob,
{$ENDIF}
{$IFDEF CDY_SRV}
cdy_config,
{$ENDIF}

cnd_vars, cnd_util, ok_dlg1, soilprf3, math;


type

  Tsomdyn = class(Tobject)

    ops: array [1 .. maxfraz] of opst; // FOM array; FOM = OPS
    btief: integer; //< Soil depth in dm
    leach: real; //< Leached N [kg/ha/d]
    d_immi: real; //< Atmospheric N-Deposition [kg/ha/d]
    k_aos: real; //< Rate coefficient (km) for the C-mineralization from AOS (A-SOM) [1/d]
    k_stab: real; //< Rate coefficient (kS) for the C-flux from AOS (A-SOM) to the SOS (S-SOM) pool [1/d]
    k_akt: real; //< Rate coefficient (kA) for the C-flux from SOS (S-SOM) to the AOS (A-SOM) pool [1/d]
    k_deni: real; //< Constant denitrification factor (default for Halle = 3.066E-5)
    maxdeni: real; //< Maximum amount of denitrification [kg/ha/d]
    N_drain: real; //< Daily N loss with an artificial drain flow for an ameliorated soil
    corg: real; //< Concentration of soil organic carbon [%]
    hwmz: real; //< Estimated average BAT to initialize carbon in AOS (A-SOM) plus SOS (S-SOM)
    cnr_obs: real; //< C/N ratio of decomposable soil organic matter (Ger: Organische Bodensubstanz - OBS)
    ph: profil; //< pH value of the soil (default = 7) (not yet implemented)
    pv: profil; //< Soil pore volume [%]
    wk: profil; //< Field capacity [%] (Ger: Wasserkapazität)
    trd: profil; //< Soil bulk density [g/cm3] (Ger: Trockenrohdichte)
    brutto_min: profil; //< Total N-Mineralisation due to decomposition from all organic pools
    netto_min: profil; //< Actual change of Nmin stock due to turnover from all organic pools
    dispersion: profil; //< Parameter for N-leaching
    cmin_l: profil; //< C-mineralization per layer
    pvxwk: saeule; //< Supportive parameter as product from pore volume and field capacity
    dcrep: saeule; //< Crep flux per time step
    fdelta: saeule; //< Parameter to reduce BAT with soil depth
    n2oflux: double; //< N2O-N emission [kg/ha/d]
    nit1: double; //< Kinetic parameter for nitrification process (#todo: Datenbank erweitern und Manual)
    nit2: double; //< Kinetic parameter for nitrification process (#todo: Datenbank erweitern und Manual)

    constructor create(s: sysstat; immi: real; asprfl: T_soil_profile);          {< Creation of the object soil organic matter dynamics (Tsomdyn) as 'soil' variable
                                                                                 in the @link(cdyspsys) (unit to initialise soil conditions).
                                                                                 The initialisation reads required parameters and uses the system status (s)
                                                                                 to identify existing fresh organic matter pools,
                                                                                 N immission rates (immi) and the actual soil profile (asprfl) settings
                                                                                 (e.g. layers, physics, etc.).
                                                                                 @param(s: represents the record of state variables)
                                                                                 @param(immi: float number, annual atmospheric N-Immission)
                                                                                 @param(asprfl: points to the current soil profile variable)
                                                                                  }

    procedure timetrans(var s: sysstat; var w_mi, w_me, w_ma: profil);           {< Calculation of turnover conditions for aerobic turnover (make_WMZ: BAT)
                                                                                  and anaerobic N-Turnover (make_DNZ).
                                                                                 @param(s: represents the record of state variables)
                                                                                 @param(w_xx: can currently be ignored)
                                                                                 (w_mi, w_me, w_ma CIPS only, currently not activated)
                                                                                 }
    procedure cums_init(nied, ltem, crep: real; prfl: T_soil_profile;
      var s: sysstat);                                                           {< Calculation of initial pool sizes: cums = AOS (A-SOM) plus SOS (S-SOM)
                                                                                  based on the mean precipitation (nied), air temperature (ltem)
                                                                                  and an estimated C-rep (crep) as well as the fine soil parts (Ger: Feinanteil, FAT)
                                                                                  from the soil profile.
                                                                                 @param(nied: annual rainfall in mm (should be an long term average))
                                                                                 @param(ltem: annual average of air temperature in °C (should be an long term average))
                                                                                 @param(crep: average crep-flux from pre-management)
                                                                                 @param(prfl: points to the current soil profile variable to know top soil texture)
                                                                                 @param(s: represents the record of state variables)
                                                                                  }

    procedure daystep(var s: sysstat);                                           {< Executes one time step: updating FOM pools, processing timetrans, FOM turnover, SOM turnover,
                                                                                    updating TOC, nitrification, nitrogen leaching and denitrification.
                                                                                    @param(s: represents the record of state variables, some of them are changed) }

  end;

const
  c2co2 = 44 / 12; //< factor to transform C mass into CO2 mass

var
  d_immi_rechen: real; //<  Hilfsgroesse fuer N-Immissions-Aufteilung
  d_immi_rechen2: real; //< Hilfsgroessen fuer N-Immissions-Aufteilung
  d_immi_tot: real; //< Summe N-Immission pro Jahr

implementation

uses cdyspsys;       //< this is the overarching unit where somdyn is implemented in candy

constructor Tsomdyn.create(s: sysstat; immi: real; asprfl: T_soil_profile);

var
  ok: boolean;
  i, j: byte;
  
  wp: profil;
  XFA,  xdp: real;


begin

  for i := 1 to 20 do

  begin
    ph[i] := 7;                                                                   //< pH defined but not yet used
    cmin_l[i] := 0;                                                               //< initial value
  end;

  { FOM parameters }

  for i := 1 to s.opsfra do

  begin
    opsparm.select(s.ks.ops[i].nr, ops[i].name, ok);                             {< locates at parameter record for an existing
                                                                                   FOM fraction, only relevant when a initial state
                                                                                    is defined in a stc file;
                                                                                    at default candy will start without any FOM
                                                                                  }
    if not ok then                                                                // ok is true if parameter record was found
    begin
      _halt(6);                                                                  //_halt stops simulation and shows an error message
    end;

    ops[i].k := opsparm.parm('K');
    ops[i].eta := opsparm.parm('ETA');
    ops[i].cnr := opsparm.parm('CNR');

  end;

  { SOM parameters }

  k_aos := cdyaparm.parm('K_AOS');
  k_akt := cdyaparm.parm('K_AKT');
  k_stab := cdyaparm.parm('K_STAB');
  cnr_obs := cdyaparm.parm('CNR_OBS');

  { Denitrification parameters }

  k_deni := cdyaparm.parm('K_DENI');
  maxdeni := cdyaparm.parm('MAXDENI');

  { N-immission }

  d_immi_rechen := immi / 365.25;
  d_immi := d_immi_rechen;

  { Nitrification parameters }

  cdyaparm.is_Field('NIT1', ok);
  if ok then
    nit1 := cdyaparm.parm('NIT1')
  else
    nit1 := 40;

  cdyaparm.is_Field('NIT2', ok);
  if ok then
    nit2 := cdyaparm.parm('NIT2')
  else
    nit2 := 90;

  { Soil physical properties from soil profile object asprfl }

  xdp := cdyaparm.parm('DISP_KF'); // controles dispersion of N-leaching
  btief := asprfl.btief;           // soil profile depth (dm)
  asprfl.put_trd(20, trd);         // bulk density
  asprfl.put_fkap(20, wk);         // field capacity
  asprfl.put_pvol(20, pv);         // pore volume
  asprfl.put_pwp(20, wp);          // permanent wilting point

  { Supportive parameters }

  for j := 1 to 20 do

  begin

    // for upper 60 cm
    if j < 7 then

    begin
      pvxwk[j] := pv[j] * wk[j];   // numeric helper used in denitrification
      asprfl.put_fat(j, XFA);      // get FAT as XFA
      fdelta[j] := -min(-6, -XFA) * 0.2844 - 1.4586; // numeric helper used during BAT calculation to get the BAT reduction depending on depth
    end;

    // for the whole profile
    if j < asprfl.btief then
      dispersion[j] := (1 - xdp * wp[j] / wk[j])       //numeric helper used to claculate N-leaching
    else
      dispersion[j] := 0.1;

    if dispersion[j] < 0.1 then
      dispersion[j] := 0.1;

  end;

end;

procedure Tsomdyn.cums_init(nied, ltem, crep: real; prfl: T_soil_profile; var s: sysstat);

var
  cums: real; // cums = AOS (A-SOM) plus SOS (S-SOM)
  i: integer;
  faktor, fat: real;

begin

  hwmz := w_m_z(fat, nied, ltem); // w_m_z = BAT

  { cums-Startwert wird aus mittlerem ops-Anfall und wmz analog zur Humusbilanz berechnet }

  cums := crep * 683 / hwmz * 100; { Cums in kg/ha }

  { faktor for splitting into AOS (A-SOM) and SOS (S-SOM) }

  faktor := cdyaparm.parm('K_STAB') / cdyaparm.parm('K_AKT');

  { Cums distributed to the upper three soil layers
  and splitted into AOS (A-SOM) and SOS (S-SOM)
  and calculation of the inert carbon pool }

  cums := cums / 3;

  for i := 1 to 3 do

  begin
     // assuming aos and sos are in steady state
    s.ks.aos[i] := cums / (1 + faktor);
    s.ks.sos[i] := cums - s.ks.aos[i];

    // only used for the 'pore size' model to calculate inert SOM pool size
    // pof4ci: ratio of C-inert/SOC as calculated by the pore size approach
    if ((prfl.cim = 'PS') and (prfl.pof4ci[i] > 0)) then
     // calculated inert carbon pool expressed as M% assuming a 30 cm top soil layer
      prfl.c_inert := prfl.c_inert + (cums * prfl.pof4ci[i] / (1 - prfl.pof4ci[i])) / (30000 * prfl.trd_0[i]);
     // basics: soc*cif=ci ; soc=cums+ci ;cums*cif+ci*cif=ci ; cums*cif=ci*(1-cif)
     // where cif : prfl.pof4ci and ci : prfl.c_inert
  end;

end;

{ calculation of turnover conditions for aerobic turnover (make_WMZ: BAT) and anaerobic N-Turnover (make_DNZ) }
procedure Tsomdyn.timetrans(var s: sysstat; var w_mi, w_me, w_ma: profil);

  function temfu(t: real): real;               // temperature effect on BAT
  const
    q10 = 2.1;
  begin
    if t < -20 then
      temfu := 0
    else
      if t < 35 then
      temfu := exp(ln(q10) * (0.1 * t - 3.5))
    else
      temfu := 1;
  end;

  procedure make_wmz; //< timetrans for aerobic carbon turnover (BAT)
  const
    las = 20; // 3;
    pocket = 14; { pocket-Volumenanteil in % }
    schicht = 10; { Schichtdicke=10cm }
    maxd = 100;

  var
    i, a_las: integer; { Laufvariable }
    scmp: { saeule } profil; { C-Mineralisierungspotential }
    delta: { saeule } profil; { Daempfungskoeffizient }
    elv: real; { Luftvolumenanteil in % }
    c0: real; { obere Randbedingung }
    tf, { Temperatur-  und }
    wf: real; { Wasserfaktor }
    xx: double;

    function efu(x: real): real;     // robust exponential function used within BAT calculation
    const
      maxpos = 37;
      maxneg = -37;
    begin

      if x > maxpos then
        efu := exp(maxpos)
      else if x < maxneg then
        efu := 0
      else
        efu := exp(x);
    end;

    function feufu(f, v: real): real;     // soil moisture effect on BAT
    var
      p: real;
    begin
       p := f / v;
       if p < 0.5 then
        feufu := 4 * p * (1 - p)
      else
        feufu := 1;
     end;

  begin                       // start BAT calculation
    { bofeu: soil moisture in VOL% = mmm for 1dm layer
      botem: soil temperature
      pv   : pore volume }

    a_las := min(btief, las);
    for i := 1 to a_las do // all active layers
    begin
      tf := temfu(s.ks.botem[i]); // impact of soil temperature
      wf := feufu(s.ks.bofeu[i], pv[i]); // impact of soil moisture
      elv := pv[i] - s.ks.bofeu[i]; // air volume
      //nur für CIPS
      w_ma[i] := 1;
      w_me[i] := 0;
      w_mi[i] := 0; // default: all activity in macro PV
      if s.ks.bofeu[i] < pv[i] then
      begin
        if s.ks.bofeu[i] < candy.sprfl.wc_ma_me[i] then
          // check: activity in meso ?
          if s.ks.bofeu[i] < candy.sprfl.wc_me_mi[i] then
          // check: activity in micro ?
           begin
            w_ma[i] := 0; // case 1: acivity in meso/micro environment
            w_me[i] := (s.ks.bofeu[i]) / (candy.sprfl.wc_me_mi[i]);
            w_mi[i] := 1 - w_me[i];
           end
          else
           begin
            // case 2: acivity in macro/meso environment
            w_ma[i] := (s.ks.bofeu[i] - candy.sprfl.wc_me_mi[i]) /
              (candy.sprfl.wc_ma_me[i] - candy.sprfl.wc_me_mi[i]);
            w_me[i] := 1 - w_ma[i];
           end;
      end;

      if i = 1 then         // first soil layer
       begin
        if elv > pocket then
          delta[1] := sqrt(fdelta[1] * tf * wf / (schicht * elv * (elv - pocket)))
        else
          delta[1] := maxd;
        c0 := 1;
        s.wmz[i] := tf * wf * efu(-delta[i] * schicht * 0.5);  // total wmz of soil layer
       end
      else
       begin           // all othe soil layers below the first one
        if delta[i - 1] < maxd then
          c0 := c0 * efu(-delta[i - 1] * schicht)
        else
          c0 := 0;
        { c0 verkoerpert die Wirkung des reduzierten Sauerstoff-Partialdruckes
        an der Schichtobergrenze}
        if (elv > pocket) and (c0 > 0)
         then  delta[i] := sqrt(fdelta[i]*tf*wf/(schicht*elv*c0*(elv - pocket)))
        else   delta[i] := maxd;
        delta[i] := delta[i - 1] + delta[i];
        { Relation zur Bodenoberflaeche herstellen }
        s.wmz[i] := tf * wf * efu(-delta[i] * schicht);
      end;

    end; { for }

    for i := a_las + 1 to 20 do   s.wmz[i] := 0;

  end;

  procedure make_dnz; //< timetrans for denitrification (anaerobic)
  var
    i: byte;
    deni: real;
  begin
    for i := 1 to 3 do
    begin
      if s.ks.bofeu[i] > 0.0267 * pvxwk[i] - 0.627 * wk[i] then
      begin
        deni := (s.ks.bofeu[i] + 0.627 * wk[i] - 0.0267 * pvxwk[i]) /
          (1.627 * wk[i] - 0.0267 * pvxwk[i]);

        if deni <= 0 then s.dnz[i] := 0
        else
        begin
          deni := sqr(deni);
          deni := min(deni, 1);
          s.dnz[i] := deni * temfu(s.ks.botem[i]);
        end;
      end

      else
        s.dnz[i] := 0;
    end;
  end;

begin
  make_wmz;
  make_dnz; // Anaerobe BAT
end;

{ wrapping of OPS_UMSATZ - OBS_UMSATZ - NITRIFICATION - DENITRIFICATION - VERLAGERUNG }
procedure Tsomdyn.daystep(var s:sysstat);
var
  c_rep: real;
  c_min: real;
  n_min: real;
  deni: real;
  ok: boolean;
  i, ii: integer;
  f_mi: profil;
  f_me: profil;
  f_ma: profil;
  //n1: double;

  {ops_beg}          // FOM Turover
  procedure ops_umsatz(dt:profil);
  var
    j, schicht: byte;
    r_faktor: real;
    n_res: real;
    s_c_min: real;
    s_cv: real;
    s_n_min: real;
    s_c_rep: real;
  begin
    for schicht := 1 to 3 do // 3 layers in topsoil (Krume)
    begin
       dcrep[schicht] := 0;
    (* erfolgt in daystep: brutto_min[schicht]:=0; netto_min[schicht]:=0; co2_pr[schicht]:=0; *)
       for J := 1 to s.opsfra do
       begin
        // C-Abbau (Veratmung) der OPS (FOM)
        s_cv := s.ks.ops[j].C[schicht] * (1 - exp(-ops[j].k * dt[schicht]));
        // Teil der als CO2 abgeht
        s_c_min := (1 - ops[j].eta) * s_cv;
        // Umsatz von C aus FOM ins SOM
        s_c_rep := ops[j].eta * s_cv;
        // N-mineralisation of one layer
        brutto_min[schicht] := brutto_min[schicht] + s_cv / ops[j].cnr;
        // Stickstofffreisetzung - Netto N-mobiliserung oder N-immobilisierung
        s_n_min := s_cv / ops[j].cnr - s_c_rep / cnr_obs;
        // mineralised N is ammonium N
        if s_n_min > + 1.0E-11 then
          s.ks.amn[schicht] := s.ks.amn[schicht] + s_n_min;

        // Wenn N immobilisiert wird, also der N Pool leer ist, könnte der C Umsatz behindert werden
        if s_n_min < -1.0E-11 then
        begin
          n_res := 0.99 * (-s.ks.amn[schicht] - s.ks.nin[schicht]);
          {hier ist n_res <= 0} // Was bedeutet das?
          if s_n_min < n_res then
          begin
            r_faktor := n_res / s_n_min; { damit bleibt r_faktor >= 0 }
            s_cv := r_faktor * s_cv;
            s_c_min := r_faktor * s_c_min;
            s_c_rep := r_faktor * s_c_rep;
            s_n_min := r_faktor * s_n_min;
          end;

          s.ks.amn[schicht] := s.ks.amn[schicht] + s_n_min;

          if s.ks.amn[schicht] < 0 then
          begin
            s.ks.nin[schicht] := s.ks.nin[schicht] + s.ks.amn[schicht];
            s.ks.amn[schicht] := 0;
          end;

        end;

        dcrep[schicht] := dcrep[schicht] + s_c_rep;         // Crep of one layer
        cmin_l[schicht] := cmin_l[schicht] + s_c_min;
        // co2_pr[schicht]:= co2_pr[schicht]+c2co2*s_c_min/(1.98*864*0.1);       // 0.1 m schichth�he
        s.ks.ops[j].C[schicht] := s.ks.ops[j].C[schicht] - s_cv; // Abnahme FOM
        s.ks.aos[schicht] := s.ks.aos[schicht] + s_c_rep;
        // Wachstum mikrobielle Biomasse AOS Pool
        netto_min[schicht] := s_n_min;
        n_min := n_min + s_n_min; // update n-mineralisatiobn
        c_min := c_min + s_c_min; // update co2 Freisetzung
        c_rep := c_rep + s_c_rep;
      end;

  end;

  s.c_rep := c_rep;

  end;
  {ops_end}

  {obs_beg}
  procedure obs_umsatz(dt:profil);
  var
    schicht: byte;
    s_c_min: real;
    s_n_min: real;
    c_stab: real;
    c_akt: real;

  begin

    for schicht := 1 to 3 do
    begin
      s_c_min := s.ks.aos[schicht] * (1 - exp(-k_aos * dt[schicht])); // Abbau AOS Pool
      s_n_min := s_c_min / cnr_obs; //
      s.ks.aos[schicht] := s.ks.aos[schicht] - s_c_min;
      s.ks.amn[schicht] := s.ks.amn[schicht] + s_n_min;
      c_stab := s.ks.aos[schicht] * (1 - exp(-k_stab * dt[schicht]));  // Fluss AOS in stabilie OS (SOS)
      c_akt := s.ks.sos[schicht] * (1 - exp(-k_akt * dt[schicht]));    // Fluss

      // Bilanzänderungen der einzelnen Poole
      s.ks.aos[schicht] := s.ks.aos[schicht] - c_stab + c_akt;
      s.ks.sos[schicht] := s.ks.sos[schicht] + c_stab - c_akt;

      c_min := c_min + s_c_min; // hier steht schon die OPS-C-Mineralisierung !

      // C-Mineralisation on one layer from SOM and FOM
      cmin_l[schicht] := cmin_l[schicht] + s_c_min;
      // co2_pr[schicht]:=co2_pr[schicht]+c2co2*s_c_min/(1.98*864*0.1); // 0.1 m schichth�he  ; 1.98 g/m� ; 1d= 24*60*60= 86400 sec
      // ^ produzierte CO2-Menge in liter/sec f�r ein Bodenvolumen von  1 m�
      netto_min[schicht] := netto_min[schicht] + s_n_min;
      brutto_min[schicht] := brutto_min[schicht] + s_n_min;
      n_min := n_min + s_n_min;
    end;
    s.c_min := c_min;
    s.n_min := n_min;
  end;
  {obs_end}

  {nit_beg}
  procedure nitrifikation(dt:profil);   // NH4-N is transformed to NO3-N
  var
    schicht: byte;
    nira: real;
    hnit: real;
  begin
    for schicht := 1 to 3 do
    begin
      nira := hnit * nit1 * trd[schicht] * s.ks.amn[schicht] * dt[schicht] / (s.ks.amn[schicht] + trd[schicht] * nit2);
      nira := min(nira, s.ks.amn[schicht]);
      s.ks.amn[schicht] := s.ks.amn[schicht] - nira;
      s.ks.nin[schicht] := s.ks.nin[schicht] + nira;
    end;
  end;
  {nit_end}

  {deni_beg}
  {Gasfoermnige N-Verluste incl. NGAS-Modell zur Berechnung des N2O Flux nach dem Paper:
  GLOBAL BIOGEOCHEMIC CYCLES, VOL. 10, NO. 3, PAGES 401-412, SEPTEMBER 1996
  Generalized model for Nz and NzO production from nitrification and denitrification
  W.J. Parton , A.R. Mosier, D.S. Ojima, D.W. Valentine ,D.S. Schimel ,K. Weiern, and A. E. Kulmala}
  procedure denitrifikation(dt:saeule);
  var
    schicht: byte;
    s_deni: real;
    no3_conc: extended;
    co2_prod: extended;
    wfps: extended;
    f_wfps: extended;
    f_no3: extended;
    f_co2: extended;
    R_n2_n2o: extended;

  begin
    deni := 0;
    n2oflux := 0;
    for schicht := 1 to 3 do
    begin
      s_deni := min(dt[schicht] * k_deni * s.ks.nin[schicht] * s.ks.aos[schicht], maxdeni);
      s_deni := max(s_deni, 0);
      deni := deni + s_deni;
      s.ks.nin[schicht] := s.ks.nin[schicht] - s_deni;
      wfps := min(1, (s.ks.bofeu[schicht] / pv[schicht]));
      no3_conc := s.ks.nin[schicht] / trd[schicht];
      co2_prod := cmin_l[schicht];
      f_wfps := 1.4 / power(13, (17 / power(13, (2.2 * wfps))));
      f_co2 := 13 + (30.78 * ARCTAN(PI * 0.07 * (co2_prod - 13))) / PI;
      f_no3 := (1 - (0.5 + (1 * ARCTAN(PI * 0.01 * (no3_conc - 190))) / PI)) * 25;
      R_n2_n2o := sqrt(f_no3 * f_co2) * f_wfps;
      n2oflux := n2oflux + s_deni / (1 + R_n2_n2o);
    end;
    s.ngfv := deni;
  end;
  {deni_end}

  {verl_beg}
  procedure verlagerung;
  const
    loesl = 5.0;
  var
    i: byte;
    transport: real;
    ok, ok1: boolean;
    n_im_som: real; { N-Immissionsanteil im Sommer }
    n_im_bew: real; { Aufschlag/Abschlag N-Immission bei/ohne Bewuchs }
  begin
    {N-Immission}
    cdyaparm.is_Field('N_IM_SOM', ok);
    cdyaparm.is_Field('N_IM_BEW', ok1);
    if (ok and ok1) then
    begin { Anfang Aufteilung N-Immission, Puhlmann 5.6.01, }
      n_im_som := cdyaparm.parm('N_IM_SOM');
      if n_im_som > 0 then
      begin
        n_im_bew := cdyaparm.parm('N_IM_BEW');
        if (s.ks.tag = 1) then
          add_message('seasonal partition of N-immissions activ');

        if s.ks.pnr = 0 then { ohne Bewuchs }
        begin
          d_immi_rechen2 := d_immi_rechen * (1 - n_im_bew);
          if (s.ks.tag > 120) and (s.ks.tag < 304) then
            d_immi := d_immi_rechen2 * n_im_som * 2 { Sommer }
          else
            d_immi := d_immi_rechen2 * (1 - n_im_som) * 2; { Winter }
        end;

        if s.ks.pnr > 0 then { mit Bewuchs }
        begin
          d_immi_rechen2 := d_immi_rechen * (1 + n_im_bew);
          if (s.ks.tag > 120) and (s.ks.tag < 304)
           then  d_immi := d_immi_rechen2 * n_im_som * 2 { Sommer }
           else  d_immi := d_immi_rechen2 * (1 - n_im_som) * 2; { Winter }
        end;

        d_immi_tot := d_immi_tot + d_immi;
        If s.ks.tag = 365 then
        begin
          add_message(real2string(s.ks.jahr, 4, 0) + ': total N-Immission =' +
            real2string(d_immi_tot, 5, 1) + ' kg/ha');

          d_immi_tot := 0;
        end;
      end;

    end; {Ende Aufteilung N-Immission, Puhlmann}

    s.ks.nobfl := s.ks.nobfl + d_immi;
    s.mdng_n := s.mdng_n + d_immi;

    {Einwaschen und Verlagern}
    transport := min(s.ks.nobfl, loesl * s.wett.niedk);
    s.ks.nobfl := s.ks.nobfl - transport;
    N_drain := 0; // tages initialisierung

    for i := 1 to 20 do
    begin
      {Test ob Bodenschicht vorhanden ist}
      if i <= btief then
      begin
        {Falls ja:}
        s.ks.nin[i] := s.ks.nin[i] + transport;
        if (i = candy.sprfl.dr_depth) and (s.drain_flow > 0) then
        begin
          transport := s.ks.nin[i] * dispersion[i] * s.perko[i] / (s.ks.bofeu[i] + (s.drain_flow + s.perko[i]));    {Drainabfluss}
          N_drain := s.ks.nin[i]; // alter wert
          s.ks.nin[i] := s.ks.nin[i] * (1 - dispersion[i] * s.drain_flow / (s.ks.bofeu[i] + (s.drain_flow + s.perko[i])));
          N_drain := N_drain - s.ks.nin[i]; // differenz alt-neu ist abfluss
        end
        else { keine Drainageschicht }
          if s.perko[i] > 0
          then transport := s.ks.nin[i] * dispersion[i] * s.perko[i] / (s.ks.bofeu[i] + s.perko[i])
          else transport := 0;
        s.ks.nin[i] := s.ks.nin[i] - transport;
        s.nllay[i] := transport;
        { ende ja}
      end
      else s.nllay[i] := 0;
    end;

    leach := transport;
    s.ninauswasch := leach;
    s.N_drain := N_drain;

  end;
  {verl_end}

  {cnds_beg}
//------------------ SOMDYN DAYSTEP --------------------------------------------
  begin  // Daystep
    c_min := 0;
    c_rep := 0;
    n_min := 0;
    for i := 1 to 20 do
    begin
      // co2_pr[i]:=0;
      netto_min[i] := 0;
      brutto_min[i] := 0;
    end;
    // ---- check for new FOM
    if s.new_ops then                      // true: FOM was added
    begin
      for i := 1 to s.opsfra do
      begin
        if s.ks.ops[i].nr = -1 then
        begin
          ops[i].name := 'BBM';             // mikrobial biomass can be generated internally
          ops[i].k := 0.5;
          ops[i].eta := 0.5;
          ops[i].cnr := 8.5;
        end
        else
        begin
          opsparm.select(s.ks.ops[i].nr, ops[i].name, ok);
          ops[i].k := opsparm.parm('K');
          ops[i].eta := opsparm.parm('ETA');
          ops[i].cnr := opsparm.parm('CNR');
        end;
      end; // for
      s.new_ops := false;
    end; // new_ops

    //---- BAT calculation
    timetrans(s, f_mi, f_me, f_ma);

    //---- FOM turnover (FOM decay and Crep generation)

    if s.opsfra > 0 then  ops_umsatz(s.wmz);

    //--- SOM turnover (uses Crep from FOM turnover)
    obs_umsatz(s.wmz);

    // mineralisiertes C : s.C_MIN in kg / ha /d
    // aktuellen Corg-gehalt updaten
    corg := 0;
    for ii := 1 to 3 do
    corg := corg + candy.sprfl.c_inert + (s.ks.aos[ii] + s.ks.sos[ii]) / (10000 * candy.sprfl.trd[ii]);

    corg := corg / 3;

   //--- Nitrogen turnover
    nitrifikation(s.wmz);   // NH$-N ==> NO3-N
    verlagerung;            // transport NO3-N qith water flux downwards
    denitrifikation(s.dnz); // N-Flux from denitrification to atmosphere
    //n1 := 0;
    //for i := 1 to btief do  n1 := n1 + s.ks.amn[i] + s.ks.nin[i];
  end;
{cnds_end}

  begin

  end.
