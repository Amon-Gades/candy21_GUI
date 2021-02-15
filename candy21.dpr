program candy21;

uses
  Vcl.Forms,
  ask_how_many_recs in 'ask_how_many_recs.pas' {rec_app_quest},
  candy_uif in 'candy_uif.pas' {cdy_UIF},
  cdy_news in 'cdy_news.pas' {cdynews},
  cdy_st_view in 'cdy_st_view.pas' {ST_View},
  cdyprmedit in 'cdyprmedit.pas' {cdy_parms},
  data_interface in 'data_interface.pas' {webdata},
  GrassParameters in 'GrassParameters.pas' {Form_2},
  hint_update in 'hint_update.pas' {hint_update_fm},
  MapWinGIS_TLB in 'MapWinGIS_TLB.pas',
  mw_modul_U in 'mw_modul_U.pas' {mw_modul},
  mwshow in 'mwshow.pas' {mw_show},
  path_sel_u in 'path_sel_u.pas' {path_sel},
  prmdlg2 in 'prmdlg2.pas' {prmdlgf},
  selres in 'selres.pas' {sel_res_frm},
  sql_unit in 'sql_unit.pas' {sql_form},
  tabedit1 in 'tabedit1.pas' {ftabed},
  Types97 in 'Types97.pas',
  Unit8 in 'Unit8.pas' {ccb_info},
  Vcl.Themes,
  Vcl.Styles,
  cdy_r_vw in 'cdy_r_vw.pas' {cdy_res_view},
  Cdy_glob in 'Cdy_glob.pas',
  wetgen1 in 'wetgen1.pas' {cli_tool},
  wg_proc in 'wg_proc.pas',
  FDC_modul in 'FDC_modul.pas' {fdc: TDataModule},
  range_sel_U in 'range_sel_U.pas' {range_select},
  get_a_name in 'get_a_name.pas' {frm_get_a_name},
  get_db_name in 'get_db_name.pas' {fget_db_name},
  dllcandy in 'dllcandy.pas',
  Bestand in 'shared\Bestand.pas',
  cdy_bil in 'shared\cdy_bil.pas',
  cdyparm in 'shared\cdyparm.pas',
  cdyptf in 'shared\cdyptf.pas',
  cdysomdyn in 'shared\cdysomdyn.pas',
  cdyspsys in 'shared\cdyspsys.pas',
  cdystemp in 'shared\cdystemp.pas',
  cdyswat in 'shared\cdyswat.pas',
  cdywett in 'shared\cdywett.pas',
  cnd_rs_2 in 'shared\cnd_rs_2.pas',
  cnd_util in 'shared\cnd_util.pas',
  cnd_vars in 'shared\cnd_vars.pas',
  Cndmulch in 'shared\Cndmulch.pas',
  cndplant in 'shared\cndplant.pas',
  Cndstat in 'shared\Cndstat.pas',
  gis_rslt in 'shared\gis_rslt.pas',
  grasslnd in 'shared\grasslnd.pas',
  observations in 'shared\observations.pas',
  ok_dlg1 in 'shared\ok_dlg1.pas',
  Scenario in 'shared\Scenario.pas',
  Slurry in 'shared\Slurry.pas',
  Soilprf3 in 'shared\Soilprf3.pas',
  stdplant in 'shared\stdplant.pas',
  TRKPLANT in 'shared\TRKPLANT.PAS';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'CANDY';
  TStyleManager.TrySetStyle('Iceberg Classico');
  Application.CreateForm(Tcdy_UIF, cdy_UIF);
  Application.CreateForm(Tpath_sel, path_sel);
  Application.CreateForm(Trec_app_quest, rec_app_quest);
  Application.CreateForm(Tcdynews, cdynews);
  Application.CreateForm(TST_View, ST_View);
  Application.CreateForm(Tcdy_parms, cdy_parms);
  Application.CreateForm(Twebdata, webdata);
  Application.CreateForm(Tfrm_get_a_name, frm_get_a_name);
  Application.CreateForm(Tfget_db_name, fget_db_name);
  Application.CreateForm(TForm_2, Form_2);
  Application.CreateForm(Thint_update_fm, hint_update_fm);
  Application.CreateForm(Tmw_modul, mw_modul);
  Application.CreateForm(Tmw_show, mw_show);
  Application.CreateForm(Tpath_sel, path_sel);
  Application.CreateForm(Tprmdlgf, prmdlgf);
  Application.CreateForm(Trange_select, range_select);
  Application.CreateForm(Tsel_res_frm, sel_res_frm);
  Application.CreateForm(Tsql_form, sql_form);
  Application.CreateForm(Tftabed, ftabed);
  Application.CreateForm(Tccb_info, ccb_info);
  Application.CreateForm(Tcdy_res_view, cdy_res_view);
  Application.CreateForm(Tcli_tool, cli_tool);
  Application.CreateForm(Tfdc, fdc);
  Application.CreateForm(Trange_select, range_select);
  Application.CreateForm(Tfrm_get_a_name, frm_get_a_name);
  Application.CreateForm(Tfget_db_name, fget_db_name);
  //  Application.CreateForm(Tfrm_sze_stat, frm_sze_stat);
  cdy_uif.form_init;
  Application.Run;
end.
