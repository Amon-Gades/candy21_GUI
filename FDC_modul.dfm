object fdc: Tfdc
  OldCreateOrder = False
  Height = 635
  Width = 839
  object hqry: TFDQuery
    Connection = cdy_UIF.dbc
    SQL.Strings = (
      '')
    Left = 136
    Top = 24
  end
  object cdyctrl: TFDQuery
    Connection = cdy_UIF.dbc
    Left = 136
    Top = 72
  end
  object FDA_update: TFDQuery
    Connection = cdy_UIF.dbc
    Left = 136
    Top = 128
  end
  object htab: TFDTable
    BeforeOpen = htabBeforeOpen
    Connection = cdy_UIF.dbc
    Left = 56
    Top = 8
  end
  object hsrc: TDataSource
    DataSet = htab
    Left = 16
    Top = 8
  end
  object masqry: TFDQuery
    OnCalcFields = masqryCalcFields
    Connection = cdy_UIF.dbc
    SQL.Strings = (
      'select * from cdy_madat')
    Left = 280
    Top = 16
    object masqrykey: TFDAutoIncField
      FieldName = 'key'
      Origin = '[key]'
      ReadOnly = True
    end
    object masqrySNR: TSmallintField
      FieldName = 'SNR'
      Origin = 'SNR'
    end
    object masqryUTLG: TSmallintField
      FieldName = 'UTLG'
      Origin = 'UTLG'
    end
    object masqryDATUM: TSQLTimeStampField
      FieldName = 'DATUM'
      Origin = 'DATUM'
    end
    object masqryMACODE: TSmallintField
      FieldName = 'MACODE'
      Origin = 'MACODE'
    end
    object masqryWERT1: TSmallintField
      FieldName = 'WERT1'
      Origin = 'WERT1'
    end
    object masqryWERT2: TFloatField
      FieldName = 'WERT2'
      Origin = 'WERT2'
    end
    object masqryORIGWERT: TFloatField
      FieldName = 'ORIGWERT'
      Origin = 'ORIGWERT'
    end
    object masqryREIN: TWideStringField
      FieldName = 'REIN'
      Origin = 'REIN'
      Size = 1
    end
    object masqryUNIT: TStringField
      FieldKind = fkCalculated
      FieldName = 'UNIT'
      Calculated = True
    end
    object masqryAKTION: TStringField
      FieldKind = fkCalculated
      FieldName = 'AKTION'
      Calculated = True
    end
    object masqrySUBJEKT: TStringField
      FieldKind = fkCalculated
      FieldName = 'SUBJEKT'
      Calculated = True
    end
  end
  object massrc: TDataSource
    DataSet = masqry
    OnDataChange = massrcDataChange
    Left = 232
    Top = 16
  end
  object mweqry: TFDQuery
    Connection = cdy_UIF.dbc
    SQL.Strings = (
      'select * from cdy_mvdat')
    Left = 280
    Top = 72
    object mweqrySNR: TSmallintField
      FieldName = 'SNR'
      Origin = 'SNR'
    end
    object mweqryUTLG: TSmallintField
      FieldName = 'UTLG'
      Origin = 'UTLG'
    end
    object mweqryDATUM: TSQLTimeStampField
      FieldName = 'DATUM'
      Origin = 'DATUM'
    end
    object mweqryM_IX: TSmallintField
      FieldName = 'M_IX'
      Origin = 'M_IX'
    end
    object mweqryS0: TSmallintField
      FieldName = 'S0'
      Origin = 'S0'
    end
    object mweqryS1: TSmallintField
      FieldName = 'S1'
      Origin = 'S1'
    end
    object mweqryM_WERT: TFloatField
      FieldName = 'M_WERT'
      Origin = 'M_WERT'
    end
    object mweqryVARIATION: TFloatField
      FieldName = 'VARIATION'
      Origin = 'VARIATION'
    end
    object mweqryANZAHL: TSmallintField
      FieldName = 'ANZAHL'
      Origin = 'ANZAHL'
    end
    object mweqryS_WERT: TFloatField
      FieldName = 'S_WERT'
      Origin = 'S_WERT'
    end
    object mweqryKORREKTUR: TWideStringField
      FieldName = 'KORREKTUR'
      Origin = 'KORREKTUR'
      Size = 1
    end
    object mweqryproperty: TStringField
      FieldKind = fkLookup
      FieldName = 'property'
      LookupDataSet = mklqry
      LookupKeyFields = 'item_ix'
      LookupResultField = 'Bezeichnung'
      KeyFields = 'M_IX'
      Lookup = True
    end
    object mweqryunit: TStringField
      FieldKind = fkLookup
      FieldName = 'unit'
      LookupDataSet = mklqry
      LookupKeyFields = 'item_ix'
      LookupResultField = 'propunit'
      KeyFields = 'M_IX'
      Lookup = True
    end
    object mweqryklasse: TStringField
      FieldKind = fkLookup
      FieldName = 'klasse'
      LookupDataSet = mklqry
      LookupKeyFields = 'item_ix'
      LookupResultField = 'KLASSE'
      KeyFields = 'M_IX'
      Lookup = True
    end
    object mweqryprop: TStringField
      FieldKind = fkLookup
      FieldName = 'prop'
      LookupDataSet = mklqry
      LookupKeyFields = 'item_ix'
      LookupResultField = 'Merkmal'
      KeyFields = 'M_IX'
      Lookup = True
    end
  end
  object mklqry: TFDQuery
    Connection = cdy_UIF.dbc
    SQL.Strings = (
      
        'select item_ix  ,propname as Merkmal, shrtname as Bezeichnung, a' +
        'dptbl, propunit , 0 as KLASSE from cdyprop order by propname'
      ''
      '')
    Left = 280
    Top = 128
  end
  object mklsrc: TDataSource
    DataSet = mklqry
    OnDataChange = mklsrcDataChange
    Left = 232
    Top = 128
  end
  object mwesrc: TDataSource
    DataSet = mweqry
    OnDataChange = mwesrcDataChange
    Left = 232
    Top = 72
  end
  object fdaqry: TFDQuery
    Connection = cdy_UIF.dbc
    Left = 280
    Top = 192
  end
  object fdasrc: TDataSource
    DataSet = fdaqry
    OnDataChange = fdasrcDataChange
    Left = 232
    Top = 192
  end
  object actqry: TFDQuery
    Connection = cdy_UIF.dbc
    SQL.Strings = (
      'select * from cdyaktion')
    Left = 280
    Top = 248
  end
  object actsrc: TDataSource
    DataSet = actqry
    Left = 232
    Top = 248
  end
  object items: TFDQuery
    Connection = cdy_UIF.dbc
    SQL.Strings = (
      
        'select trim(left(name,25)) as item, item_ix, 1 as objekt from cd' +
        'ypflan '
      'where modell<>'#39'FOREST'#39
      'union'
      
        'select trim(left(name,25))as item, item_ix, 3 as objekt from cdy' +
        'opspa where od'
      'union'
      
        'select trim(left(name,25)) as item, item_ix, 4 as objekt from cd' +
        'ymindg'
      'union'
      
        'select trim(left(name,25)) as item, item_ix, 8 as objekt from cd' +
        'yagchm'
      'union'
      
        'select trim(left(name,25)) as item, item_ix, 5 as objekt from cd' +
        'ytilldev'
      'union'
      'select '#39'-'#39' as item, item_ix, 6 as objekt from cdypflan'
      'union'
      
        'select trim(left(name,25)) as item, 1 as item_ix,7 as objekt fro' +
        'm cdyirrgdev'
      'union'
      
        'select trim(left(name,25)) as item, item_ix, 10 as objekt from c' +
        'dylives'
      'union'
      
        'select trim(left(name,25)) as item, item_ix, 11 as objekt from c' +
        'dylives'
      'union'
      
        'select trim(left(name,25)) as item, item_ix, 21 as objekt from c' +
        'dylwprm'
      'union'
      
        'select trim(left(name,25)) as item, item_ix, 22 as objekt from c' +
        'dykfprm'
      'union'
      
        'select trim(left(name,25)) as item, item_ix, 23 as objekt from c' +
        'dyforst'
      'order by objekt, item_ix')
    Left = 272
    Top = 424
  end
  object any_update: TFDQuery
    Connection = cdy_UIF.dbc
    Left = 136
    Top = 184
  end
  object profiles: TFDQuery
    Connection = cdy_UIF.dbc
    SQL.Strings = (
      'select distinct PROFIL as NAME  from profile')
    Left = 272
    Top = 312
  end
  object prfsrc: TDataSource
    DataSet = profiles
    Left = 232
    Top = 312
  end
  object classqry: TFDQuery
    Connection = cdy_UIF.dbc
    SQL.Strings = (
      'select * from cdyprclass')
    Left = 280
    Top = 368
  end
  object clasrc: TDataSource
    DataSet = classqry
    Left = 232
    Top = 368
  end
  object profile_prm: TFDQuery
    Connection = cdy_UIF.dbc
    SQL.Strings = (
      'SELECT distinct  PROFILE.PROFIL '
      'FROM PROFILE')
    Left = 232
    Top = 488
  end
  object explanations: TFDTable
    BeforeOpen = htabBeforeOpen
    Connection = cdy_UIF.dbc
    UpdateOptions.UpdateTableName = 'cdy_explain'
    TableName = 'cdy_explain'
    Left = 56
    Top = 64
  end
  object hrz_prm: TFDTable
    IndexFieldNames = 'NAME'
    MasterSource = cdy_parms.ds_prof_data
    MasterFields = 'horiz_name'
    Connection = cdy_UIF.dbc
    UpdateOptions.UpdateTableName = 'cndhrzn'
    TableName = 'cndhrzn'
    Left = 32
    Top = 208
  end
  object prof_data: TFDTable
    Connection = cdy_UIF.dbc
    UpdateOptions.UpdateTableName = 'profile'
    TableName = 'profile'
    Left = 640
    Top = 360
  end
  object access_table: TFDTable
    Connection = cdy_UIF.dbc
    Left = 32
    Top = 256
  end
  object littergreen: TFDQuery
    Connection = cdy_UIF.dbc
    SQL.Strings = (
      'select * from cdyopspa where not od')
    Left = 440
    Top = 16
  end
  object litterstraw: TFDQuery
    Connection = cdy_UIF.dbc
    SQL.Strings = (
      'select * from cdyopspa where not od')
    Left = 440
    Top = 72
  end
  object litterroot: TFDQuery
    Connection = cdy_UIF.dbc
    SQL.Strings = (
      'select * from cdyopspa where not od')
    Left = 432
    Top = 120
  end
  object aktion: TFDTable
    Connection = cdy_UIF.dbc
    UpdateOptions.UpdateTableName = 'cdyaktion'
    TableName = 'cdyaktion'
    Left = 16
    Top = 304
  end
  object hrz_liste: TFDQuery
    Connection = cdy_UIF.dbc
    SQL.Strings = (
      'select distinct NAME from CNDHRZN')
    Left = 40
    Top = 160
  end
  object fert: TFDTable
    Connection = cdy_UIF.dbc
    UpdateOptions.UpdateTableName = 'cdymindg'
    TableName = 'cdymindg'
    Left = 16
    Top = 408
  end
  object cndmwml: TFDTable
    Connection = cdy_UIF.dbc
    UpdateOptions.UpdateTableName = 'cdyprop'
    TableName = 'cdyprop'
    Left = 16
    Top = 360
  end
  object propqry: TFDQuery
    Connection = cdy_UIF.dbc
    SQL.Strings = (
      'select * from cdyprop')
    Left = 280
    Top = 488
  end
  object opspa: TFDTable
    Connection = cdy_UIF.dbc
    UpdateOptions.UpdateTableName = 'cdyopspa'
    TableName = 'cdyopspa'
    Left = 16
    Top = 464
  end
  object sbacrop: TFDTable
    Connection = cdy_UIF.dbc
    UpdateOptions.UpdateTableName = 'sbacrop'
    TableName = 'sbacrop'
    Left = 80
    Top = 312
  end
  object sbamanure: TFDTable
    Connection = cdy_UIF.dbc
    UpdateOptions.UpdateTableName = 'sbamanure'
    TableName = 'sbamanure'
    Left = 80
    Top = 360
  end
  object sbasoil: TFDTable
    Connection = cdy_UIF.dbc
    UpdateOptions.UpdateTableName = 'sbasoil'
    TableName = 'sbasoil'
    Left = 80
    Top = 408
  end
  object sbaomdef: TFDTable
    Connection = cdy_UIF.dbc
    UpdateOptions.UpdateTableName = 'sbaomdef'
    TableName = 'sbaomdef'
    Left = 80
    Top = 464
  end
  object crops: TFDTable
    Connection = cdy_UIF.dbc
    UpdateOptions.UpdateTableName = 'cdypflan'
    TableName = 'cdypflan'
    Left = 632
    Top = 24
  end
  object cdy_aprm: TFDTable
    Connection = cdy_UIF.dbc
    UpdateOptions.UpdateTableName = 'cdyaparm'
    TableName = 'cdyaparm'
    Left = 632
    Top = 72
  end
  object grassl: TFDTable
    Connection = cdy_UIF.dbc
    UpdateOptions.UpdateTableName = 'cdygras'
    TableName = 'cdygras'
    Left = 632
    Top = 120
  end
  object btprm: TFDTable
    Connection = cdy_UIF.dbc
    UpdateOptions.UpdateTableName = 'cdybtprm'
    TableName = 'cdybtprm'
    Left = 632
    Top = 168
  end
  object lives: TFDTable
    Connection = cdy_UIF.dbc
    UpdateOptions.UpdateTableName = 'cdylives'
    TableName = 'cdylives'
    Left = 640
    Top = 216
  end
  object resobj: TFDTable
    Connection = cdy_UIF.dbc
    UpdateOptions.UpdateTableName = 'cdy_rslt'
    TableName = 'cdy_rslt'
    Left = 640
    Top = 264
  end
  object tgparms: TFDTable
    Connection = cdy_UIF.dbc
    UpdateOptions.UpdateTableName = 'cdytgprm'
    TableName = 'cdytgprm'
    Left = 640
    Top = 312
  end
  object add_prfl: TFDQuery
    Connection = cdy_UIF.dbc
    SQL.Strings = (
      'insert into profile (PROFIL) values(:name)')
    Left = 432
    Top = 224
    ParamData = <
      item
        Name = 'NAME'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end>
  end
  object grm_names: TFDQuery
    SQL.Strings = (
      'select name, art_id from grassmind_par order by name'
      ' ')
    Left = 72
    Top = 560
  end
  object grm_population: TFDQuery
    Connection = cdy_UIF.dbc
    SQL.Strings = (
      'select * from grassmind_poplist')
    Left = 416
    Top = 352
  end
  object grm_crop: TFDQuery
    Connection = cdy_UIF.dbc
    SQL.Strings = (
      'select * from grassmind_poplist')
    Left = 416
    Top = 408
  end
  object siwaprm: TFDQuery
    Connection = cdy_UIF.dbc
    SQL.Strings = (
      'select s.*, c.* from cdysiwap s, cdypflan c'
      'where s.item_ix=c.item_ix')
    Left = 416
    Top = 464
  end
  object c2p_qry: TFDQuery
    Connection = cdy_UIF.dbc
    SQL.Strings = (
      'select * from cdycl2pr')
    Left = 416
    Top = 520
  end
  object clas_qry: TFDQuery
    Connection = cdy_UIF.dbc
    SQL.Strings = (
      'select * from cdyprclass')
    Left = 416
    Top = 568
  end
  object itemsrc: TDataSource
    DataSet = items
    Left = 232
    Top = 424
  end
  object wcnt: TFDQuery
    Connection = cdy_UIF.dbc
    SQL.Strings = (
      'SELECT wstat '
      'FROM cdy_cldat'
      'GROUP by wstat')
    Left = 536
    Top = 568
  end
  object wyr: TFDQuery
    Connection = cdy_UIF.dbc
    SQL.Strings = (
      'SELECT cdy_cldat.wstat+'#39'_'#39'+ trim(str(  Year([DATUM]))) AS widx'
      'FROM cdy_cldat'
      'where wstat=:wstat'
      'GROUP BY Year([DATUM]), cdy_cldat.wstat;')
    Left = 536
    Top = 512
    ParamData = <
      item
        Name = 'WSTAT'
        ParamType = ptInput
      end>
  end
  object wdqry: TFDQuery
    Connection = cdy_UIF.dbc
    SQL.Strings = (
      'select datum, ltem as x from cdy_cldat')
    Left = 536
    Top = 464
  end
  object aqry: TFDQuery
    Connection = cdy_UIF.dbc
    SQL.Strings = (
      '')
    Left = 136
    Top = 240
  end
  object oqry: TFDQuery
    Connection = cdy_UIF.dbc
    SQL.Strings = (
      '')
    Left = 136
    Top = 288
  end
  object mvdat: TFDTable
    BeforeOpen = htabBeforeOpen
    Connection = cdy_UIF.dbc
    UpdateOptions.UpdateTableName = 'cdy_mvdat'
    TableName = 'cdy_mvdat'
    Left = 744
    Top = 24
  end
  object get_obslst: TFDQuery
    Connection = cdy_UIF.dbc
    SQL.Strings = (
      ''
      'select * from cdy_obslt where sch_ix=2')
    Left = 536
    Top = 24
  end
  object dview: TFDQuery
    OnCalcFields = dviewCalcFields
    Connection = cdy_UIF.dbc
    SQL.Strings = (
      ''
      'select * from cdy_mvdat')
    Left = 536
    Top = 72
    object dviewSNR: TSmallintField
      FieldName = 'SNR'
      Origin = 'SNR'
    end
    object dviewUTLG: TSmallintField
      FieldName = 'UTLG'
      Origin = 'UTLG'
    end
    object dviewDATUM: TSQLTimeStampField
      FieldName = 'DATUM'
      Origin = 'DATUM'
    end
    object dviewM_IX: TSmallintField
      FieldName = 'M_IX'
      Origin = 'M_IX'
    end
    object dviewS0: TSmallintField
      FieldName = 'S0'
      Origin = 'S0'
    end
    object dviewS1: TSmallintField
      FieldName = 'S1'
      Origin = 'S1'
    end
    object dviewKORREKTUR: TWideStringField
      FieldName = 'KORREKTUR'
      Origin = 'KORREKTUR'
      Size = 1
    end
    object dviewmerkmal: TStringField
      FieldKind = fkCalculated
      FieldName = 'merkmal'
      Calculated = True
    end
  end
  object mwml: TFDQuery
    Connection = cdy_UIF.dbc
    SQL.Strings = (
      ''
      ''
      
        'select item_ix  ,propname as Merkmal, shrtname as Bezeichnung, a' +
        'dptbl, propunit , 0 as KLASSE,format,typ from cdyprop order by p' +
        'ropname')
    Left = 536
    Top = 128
  end
  object schemes: TFDQuery
    Connection = cdy_UIF.dbc
    SQL.Strings = (
      ''
      'select * from cdy_obsch')
    Left = 536
    Top = 184
  end
  object gmp: TFDTable
    BeforeOpen = htabBeforeOpen
    Connection = cdy_UIF.dbc
    UpdateOptions.UpdateTableName = 'grassmind_par'
    TableName = 'grassmind_par'
    Left = 744
    Top = 104
  end
  object gm_id: TFDQuery
    SQL.Strings = (
      ''
      'select max(art_id)+1 as new_id from grassmind_par')
    Left = 136
    Top = 560
  end
  object frxDB_mas: TfrxDBDataset
    UserName = 'frx_mas'
    CloseDataSource = False
    DataSet = masqry
    BCDToCurrency = False
    Left = 720
    Top = 448
  end
  object frxDB_fda: TfrxDBDataset
    UserName = 'frx_fda'
    CloseDataSource = False
    DataSet = fdaqry
    BCDToCurrency = False
    Left = 728
    Top = 504
  end
  object frxmarep: TfrxReport
    Version = '6.7'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 42085.758164178240000000
    ReportOptions.LastChange = 42085.810053692130000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 776
    Top = 448
    Datasets = <
      item
        DataSet = frxDB_fda
        DataSetName = 'frx_fda'
      end
      item
        DataSet = frxDB_mas
        DataSetName = 'frx_mas'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      Frame.Typ = []
      MirrorMode = []
      object ReportTitle1: TfrxReportTitle
        FillType = ftBrush
        Frame.Typ = []
        Height = 105.826840000000000000
        Top = 16.000000000000000000
        Width = 718.110700000000000000
        object Memo1: TfrxMemoView
          AllowVectorExport = True
          Left = 7.559060000000000000
          Width = 139.842610000000000000
          Height = 26.456710000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clTeal
          Font.Height = -19
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'Management')
          ParentFont = False
        end
        object Time: TfrxMemoView
          AllowVectorExport = True
          Left = 650.079160000000000000
          Width = 60.472480000000000000
          Height = 18.897650000000000000
          Frame.Typ = []
          Memo.UTF8W = (
            '[Time]')
        end
        object Date: TfrxMemoView
          AllowVectorExport = True
          Left = 563.149970000000000000
          Width = 79.370130000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
          ParentFont = False
        end
        object frx_fdaSBEZ: TfrxMemoView
          AllowVectorExport = True
          Left = 272.126160000000000000
          Width = 238.110390000000000000
          Height = 18.897650000000000000
          DataField = 'SBEZ'
          DataSet = frxDB_fda
          DataSetName = 'frx_fda'
          Frame.Typ = []
          Memo.UTF8W = (
            '[frx_fda."SBEZ"]')
        end
        object Line1: TfrxLineView
          AllowVectorExport = True
          Left = 3.779530000000000000
          Top = 34.015770000000000000
          Width = 706.772110000000000000
          Color = clBlack
          Frame.Color = clTeal
          Frame.Typ = [ftTop]
          Frame.Width = 2.000000000000000000
        end
        object frx_fdaSNR: TfrxMemoView
          AllowVectorExport = True
          Left = 143.622140000000000000
          Top = 56.692950000000000000
          Width = 79.370130000000000000
          Height = 18.897650000000000000
          DataField = 'SNR'
          DataSet = frxDB_fda
          DataSetName = 'frx_fda'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frx_fda."SNR"]')
          ParentFont = False
        end
        object frx_fdaUTLG: TfrxMemoView
          AllowVectorExport = True
          Left = 245.669450000000000000
          Top = 56.692950000000000000
          Width = 49.133890000000000000
          Height = 18.897650000000000000
          DataField = 'UTLG'
          DataSet = frxDB_fda
          DataSetName = 'frx_fda'
          Frame.Typ = []
          Memo.UTF8W = (
            '[frx_fda."UTLG"]')
        end
        object frx_fdaFNAME: TfrxMemoView
          AllowVectorExport = True
          Left = 7.559060000000000000
          Top = 56.692950000000000000
          Width = 113.385900000000000000
          Height = 18.897650000000000000
          DataField = 'FNAME'
          DataSet = frxDB_fda
          DataSetName = 'frx_fda'
          Frame.Typ = []
          Memo.UTF8W = (
            '[frx_fda."FNAME"]')
        end
      end
      object Header1: TfrxHeader
        FillType = ftBrush
        Frame.Typ = []
        Height = 49.133890000000000000
        Top = 140.000000000000000000
        Width = 718.110700000000000000
        ReprintOnNewPage = True
        object Memo2: TfrxMemoView
          AllowVectorExport = True
          Left = 7.559060000000000000
          Width = 68.031540000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'date')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          AllowVectorExport = True
          Left = 98.267780000000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'action')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          AllowVectorExport = True
          Left = 264.567100000000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'object')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          AllowVectorExport = True
          Left = 570.709030000000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'origin')
          ParentFont = False
        end
        object Line2: TfrxLineView
          AllowVectorExport = True
          Top = 34.015770000000000000
          Width = 714.331170000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
          Frame.Width = 1.500000000000000000
        end
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Frame.Typ = []
        Height = 22.677180000000000000
        Top = 208.000000000000000000
        Width = 718.110700000000000000
        DataSet = frxDB_mas
        DataSetName = 'frx_mas'
        RowCount = 0
        object frx_masDATUM: TfrxMemoView
          AllowVectorExport = True
          Left = 7.559060000000000000
          Width = 79.370130000000000000
          Height = 18.897650000000000000
          DataField = 'DATUM'
          DataSet = frxDB_mas
          DataSetName = 'frx_mas'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[frx_mas."DATUM"]')
          ParentFont = False
        end
        object frx_masAKTION: TfrxMemoView
          AllowVectorExport = True
          Left = 98.267780000000000000
          Width = 154.960730000000000000
          Height = 18.897650000000000000
          DataField = 'AKTION'
          DataSet = frxDB_mas
          DataSetName = 'frx_mas'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[frx_mas."AKTION"]')
          ParentFont = False
        end
        object frx_masSUBJEKT: TfrxMemoView
          AllowVectorExport = True
          Left = 264.567100000000000000
          Width = 143.622140000000000000
          Height = 18.897650000000000000
          DataField = 'SUBJEKT'
          DataSet = frxDB_mas
          DataSetName = 'frx_mas'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[frx_mas."SUBJEKT"]')
          ParentFont = False
        end
        object frx_masWERT2: TfrxMemoView
          AllowVectorExport = True
          Left = 423.307360000000000000
          Width = 60.472480000000000000
          Height = 18.897650000000000000
          DataField = 'WERT2'
          DataSet = frxDB_mas
          DataSetName = 'frx_mas'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[frx_mas."WERT2"]')
          ParentFont = False
        end
        object frx_masUNIT: TfrxMemoView
          AllowVectorExport = True
          Left = 495.118430000000000000
          Width = 49.133890000000000000
          Height = 18.897650000000000000
          DataField = 'UNIT'
          DataSet = frxDB_mas
          DataSetName = 'frx_mas'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[frx_mas."UNIT"]')
          ParentFont = False
        end
        object frx_masORIGWERT: TfrxMemoView
          AllowVectorExport = True
          Left = 566.929500000000000000
          Top = 3.779530000000000000
          Width = 79.370130000000000000
          Height = 18.897650000000000000
          DataField = 'ORIGWERT'
          DataSet = frxDB_mas
          DataSetName = 'frx_mas'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[frx_mas."ORIGWERT"]')
          ParentFont = False
        end
        object frx_masREIN: TfrxMemoView
          AllowVectorExport = True
          Left = 665.197280000000000000
          Width = 45.354360000000000000
          Height = 18.897650000000000000
          DataField = 'REIN'
          DataSet = frxDB_mas
          DataSetName = 'frx_mas'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[frx_mas."REIN"]')
          ParentFont = False
        end
      end
    end
  end
  object frxDB_obs: TfrxDBDataset
    UserName = 'frx_obs'
    CloseDataSource = False
    DataSet = mweqry
    BCDToCurrency = False
    Left = 728
    Top = 560
  end
  object frxobsrep: TfrxReport
    Version = '6.7'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 42085.812901296300000000
    ReportOptions.LastChange = 42085.823875300930000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 792
    Top = 560
    Datasets = <
      item
        DataSet = frxDB_fda
        DataSetName = 'frx_fda'
      end
      item
        DataSet = frxDB_obs
        DataSetName = 'frx_obs'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      Frame.Typ = []
      MirrorMode = []
      object ReportTitle1: TfrxReportTitle
        FillType = ftBrush
        Frame.Typ = []
        Height = 102.047310000000000000
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        object Memo1: TfrxMemoView
          AllowVectorExport = True
          Left = 3.779530000000000000
          Width = 139.842610000000000000
          Height = 26.456710000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clTeal
          Font.Height = -19
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'Observation')
          ParentFont = False
        end
        object Time: TfrxMemoView
          AllowVectorExport = True
          Left = 646.299630000000000000
          Width = 60.472480000000000000
          Height = 18.897650000000000000
          Frame.Typ = []
          Memo.UTF8W = (
            '[Time]')
        end
        object Date: TfrxMemoView
          AllowVectorExport = True
          Left = 559.370440000000000000
          Width = 79.370130000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
          ParentFont = False
        end
        object frx_fdaSBEZ: TfrxMemoView
          AllowVectorExport = True
          Left = 268.346630000000000000
          Width = 238.110390000000000000
          Height = 18.897650000000000000
          DataField = 'SBEZ'
          DataSet = frxDB_fda
          DataSetName = 'frx_fda'
          Frame.Typ = []
          Memo.UTF8W = (
            '[frx_fda."SBEZ"]')
        end
        object Line1: TfrxLineView
          AllowVectorExport = True
          Top = 34.015770000000000000
          Width = 706.772110000000000000
          Color = clBlack
          Frame.Color = clTeal
          Frame.Typ = [ftTop]
          Frame.Width = 2.000000000000000000
        end
        object frx_fdaSNR: TfrxMemoView
          AllowVectorExport = True
          Left = 139.842610000000000000
          Top = 56.692950000000000000
          Width = 79.370130000000000000
          Height = 18.897650000000000000
          DataField = 'SNR'
          DataSet = frxDB_fda
          DataSetName = 'frx_fda'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frx_fda."SNR"]')
          ParentFont = False
        end
        object frx_fdaUTLG: TfrxMemoView
          AllowVectorExport = True
          Left = 241.889920000000000000
          Top = 56.692950000000000000
          Width = 49.133890000000000000
          Height = 18.897650000000000000
          DataField = 'UTLG'
          DataSet = frxDB_fda
          DataSetName = 'frx_fda'
          Frame.Typ = []
          Memo.UTF8W = (
            '[frx_fda."UTLG"]')
        end
        object frx_fdaFNAME: TfrxMemoView
          AllowVectorExport = True
          Left = 3.779530000000000000
          Top = 56.692950000000000000
          Width = 113.385900000000000000
          Height = 18.897650000000000000
          DataField = 'FNAME'
          DataSet = frxDB_fda
          DataSetName = 'frx_fda'
          Frame.Typ = []
          Memo.UTF8W = (
            '[frx_fda."FNAME"]')
        end
      end
      object Header1: TfrxHeader
        FillType = ftBrush
        Frame.Typ = []
        Height = 52.913420000000000000
        Top = 181.417440000000000000
        Width = 718.110700000000000000
        ReprintOnNewPage = True
        object Memo2: TfrxMemoView
          AllowVectorExport = True
          Left = 11.338590000000000000
          Top = 3.779530000000000000
          Width = 68.031540000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'date')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          AllowVectorExport = True
          Left = 102.047310000000000000
          Top = 3.779530000000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'property')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          AllowVectorExport = True
          Left = 279.685220000000000000
          Top = 3.779530000000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            'layer')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          AllowVectorExport = True
          Left = 415.748300000000000000
          Top = 3.779530000000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'value')
          ParentFont = False
        end
        object Line2: TfrxLineView
          AllowVectorExport = True
          Left = 3.779530000000000000
          Top = 37.795300000000000000
          Width = 714.331170000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
          Frame.Width = 1.500000000000000000
        end
        object Memo7: TfrxMemoView
          AllowVectorExport = True
          Left = 589.606680000000000000
          Top = 3.779530000000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'adapt')
          ParentFont = False
        end
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Frame.Typ = []
        Height = 22.677180000000000000
        Top = 257.008040000000000000
        Width = 718.110700000000000000
        DataSet = frxDB_obs
        DataSetName = 'frx_obs'
        RowCount = 0
        object frx_obsDATUM: TfrxMemoView
          AllowVectorExport = True
          Left = 11.338590000000000000
          Width = 75.590600000000000000
          Height = 18.897650000000000000
          DataField = 'DATUM'
          DataSet = frxDB_obs
          DataSetName = 'frx_obs'
          Frame.Typ = []
          Memo.UTF8W = (
            '[frx_obs."DATUM"]')
        end
        object frx_obsm_WERT: TfrxMemoView
          AllowVectorExport = True
          Left = 415.748300000000000000
          Width = 79.370130000000000000
          Height = 18.897650000000000000
          DataField = 'm_WERT'
          DataSet = frxDB_obs
          DataSetName = 'frx_obs'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[frx_obs."m_WERT"]')
          ParentFont = False
        end
        object frx_obsS0: TfrxMemoView
          AllowVectorExport = True
          Left = 275.905690000000000000
          Width = 45.354360000000000000
          Height = 18.897650000000000000
          DataField = 'S0'
          DataSet = frxDB_obs
          DataSetName = 'frx_obs'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frx_obs."S0"]')
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          AllowVectorExport = True
          Left = 328.819110000000000000
          Width = 11.338590000000000000
          Height = 18.897650000000000000
          Frame.Typ = []
          Memo.UTF8W = (
            '-')
        end
        object frx_obsS1: TfrxMemoView
          AllowVectorExport = True
          Left = 343.937230000000000000
          Width = 45.354360000000000000
          Height = 18.897650000000000000
          DataField = 'S1'
          DataSet = frxDB_obs
          DataSetName = 'frx_obs'
          Frame.Typ = []
          Memo.UTF8W = (
            '[frx_obs."S1"]')
        end
        object frx_obsprop: TfrxMemoView
          AllowVectorExport = True
          Left = 98.267780000000000000
          Width = 162.519790000000000000
          Height = 18.897650000000000000
          DataField = 'prop'
          DataSet = frxDB_obs
          DataSetName = 'frx_obs'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[frx_obs."prop"]')
          ParentFont = False
        end
        object frx_obsunit: TfrxMemoView
          AllowVectorExport = True
          Left = 514.016080000000000000
          Width = 49.133890000000000000
          Height = 18.897650000000000000
          DataField = 'unit'
          DataSet = frxDB_obs
          DataSetName = 'frx_obs'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[frx_obs."unit"]')
          ParentFont = False
        end
        object frx_obsKORREKTUR: TfrxMemoView
          AllowVectorExport = True
          Left = 589.606680000000000000
          Width = 18.897650000000000000
          Height = 18.897650000000000000
          DataField = 'KORREKTUR'
          DataSet = frxDB_obs
          DataSetName = 'frx_obs'
          Frame.Typ = []
          Memo.UTF8W = (
            '[frx_obs."KORREKTUR"]')
        end
      end
    end
  end
end
