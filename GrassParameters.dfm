object Form_2: TForm_2
  Left = 0
  Top = 0
  Caption = 'species prametrisation: check mode'
  ClientHeight = 574
  ClientWidth = 948
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  OnHide = FormHide
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label4: TLabel
    Left = 93
    Top = 52
    Width = 31
    Height = 19
    Caption = 'item'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label8: TLabel
    Left = 188
    Top = 8
    Width = 39
    Height = 19
    Caption = 'name'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Panel2: TPanel
    Left = 596
    Top = 299
    Width = 346
    Height = 227
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object Label14: TLabel
      Left = 8
      Top = 10
      Width = 74
      Height = 19
      Caption = 'Mortality'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label15: TLabel
      Left = 46
      Top = 45
      Width = 106
      Height = 13
      Caption = 'Seedling mortality [/y]'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label16: TLabel
      Left = 61
      Top = 71
      Width = 90
      Height = 13
      Caption = 'Basic mortality [/y]'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label43: TLabel
      Left = 70
      Top = 98
      Width = 81
      Height = 13
      Caption = 'Leaf life span [d]'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label49: TLabel
      Left = 68
      Top = 125
      Width = 83
      Height = 13
      Caption = 'Root life span [d]'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label56: TLabel
      Left = 256
      Top = 45
      Width = 33
      Height = 13
      Caption = 'Annual'
    end
    object Label57: TLabel
      Left = 256
      Top = 68
      Width = 45
      Height = 13
      Caption = 'Bi-Annual'
    end
    object Label58: TLabel
      Left = 256
      Top = 91
      Width = 44
      Height = 13
      Caption = 'Perennial'
    end
    object Edit6: TEdit
      Left = 157
      Top = 42
      Width = 58
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      Text = 'Edit6'
    end
    object Edit7: TEdit
      Left = 157
      Top = 69
      Width = 58
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      Text = 'Edit7'
    end
    object Edit31: TEdit
      Left = 157
      Top = 98
      Width = 58
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      Text = 'Edit31'
    end
    object Edit38: TEdit
      Left = 157
      Top = 123
      Width = 58
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      Text = 'Edit38'
    end
    object CheckBox12: TCheckBox
      Left = 317
      Top = 45
      Width = 25
      Height = 17
      TabOrder = 4
    end
    object CheckBox16: TCheckBox
      Left = 317
      Top = 68
      Width = 25
      Height = 17
      TabOrder = 5
    end
    object CheckBox18: TCheckBox
      Left = 317
      Top = 91
      Width = 25
      Height = 17
      TabOrder = 6
    end
    object mort_save: TButton
      Left = 84
      Top = 188
      Width = 202
      Height = 25
      Caption = 'Button4'
      TabOrder = 7
      Visible = False
      OnClick = mort_saveClick
    end
  end
  object Panel3: TPanel
    Left = 244
    Top = 79
    Width = 346
    Height = 214
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    object Label25: TLabel
      Left = 7
      Top = 10
      Width = 256
      Height = 19
      Caption = 'Recruitment and Establishment'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label34: TLabel
      Left = 139
      Top = 45
      Width = 105
      Height = 13
      Caption = 'Seed Biomass [g odm]'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label37: TLabel
      Left = 162
      Top = 72
      Width = 80
      Height = 13
      Caption = 'Germination rate'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label38: TLabel
      Left = 132
      Top = 97
      Width = 110
      Height = 13
      Caption = 'Days to Emergence [d]'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label18: TLabel
      Left = 65
      Top = 124
      Width = 177
      Height = 13
      Caption = 'min. Age for Start of Recruitment [y]'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label6: TLabel
      Left = 103
      Top = 151
      Width = 137
      Height = 13
      Caption = 'min. height of seedlings [cm]'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Edit24: TEdit
      Left = 248
      Top = 43
      Width = 73
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      Text = 'Edit24'
    end
    object Edit26: TEdit
      Left = 248
      Top = 70
      Width = 73
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      Text = 'Edit26'
    end
    object Edit27: TEdit
      Left = 248
      Top = 95
      Width = 73
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      Text = 'Edit27'
    end
    object Edit9: TEdit
      Left = 248
      Top = 122
      Width = 73
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      Text = 'Edit9'
    end
    object Edit8: TEdit
      Left = 248
      Top = 149
      Width = 73
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      Text = 'Edit8'
    end
    object estab_save: TButton
      Left = 65
      Top = 176
      Width = 202
      Height = 25
      Caption = 'Button4'
      TabOrder = 5
      Visible = False
      OnClick = estab_saveClick
    end
  end
  object Panel4: TPanel
    Left = 596
    Top = 73
    Width = 346
    Height = 220
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    object Label27: TLabel
      Left = 14
      Top = 12
      Width = 60
      Height = 19
      Caption = 'Growth'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label41: TLabel
      Left = 73
      Top = 30
      Width = 185
      Height = 13
      Caption = 'Max. Grossphotosynthese ['#181'mol/m'#178'/s]'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label42: TLabel
      Left = 63
      Top = 59
      Width = 195
      Height = 13
      Caption = 'Slope Light-Response-Curve ['#181'mol/'#181'mol]'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label44: TLabel
      Left = 128
      Top = 86
      Width = 130
      Height = 13
      Caption = 'Light-Extinction-Coefficient'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label46: TLabel
      Left = 96
      Top = 140
      Width = 159
      Height = 13
      Caption = 'maintenance respiration rate [/d]'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label7: TLabel
      Left = 118
      Top = 113
      Width = 135
      Height = 13
      Caption = 'light transmission coefficient'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label47: TLabel
      Left = 136
      Top = 167
      Width = 120
      Height = 13
      Caption = 'growth respiration factor'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Edit29: TEdit
      Left = 264
      Top = 28
      Width = 73
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      Text = 'Edit29'
    end
    object Edit30: TEdit
      Left = 264
      Top = 57
      Width = 73
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      Text = 'Edit30'
    end
    object Edit34: TEdit
      Left = 264
      Top = 84
      Width = 73
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      Text = 'Edit34'
    end
    object Edit35: TEdit
      Left = 264
      Top = 138
      Width = 73
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      Text = 'Edit35'
    end
    object Edit36: TEdit
      Left = 264
      Top = 165
      Width = 73
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      Text = 'Edit36'
    end
    object Edit3: TEdit
      Left = 264
      Top = 111
      Width = 73
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
      Text = 'Edit3'
    end
    object growth_save: TButton
      Left = 29
      Top = 186
      Width = 202
      Height = 25
      Caption = 'Button4'
      TabOrder = 6
      Visible = False
      OnClick = growth_saveClick
    end
  end
  object Panel5: TPanel
    Left = 5
    Top = 79
    Width = 233
    Height = 447
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    object Label26: TLabel
      Left = 12
      Top = 9
      Width = 80
      Height = 19
      Caption = 'Geometry'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label19: TLabel
      Left = 75
      Top = 53
      Width = 70
      Height = 13
      Caption = 'Overlap factor'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label20: TLabel
      Left = 33
      Top = 80
      Width = 112
      Height = 13
      Caption = 'Allocation rate to shoot'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label23: TLabel
      Left = 50
      Top = 107
      Width = 95
      Height = 13
      Caption = 'Height-Width-Ratio '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label24: TLabel
      Left = 35
      Top = 134
      Width = 110
      Height = 13
      Caption = 'correction factor shoot'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label36: TLabel
      Left = 64
      Top = 163
      Width = 81
      Height = 13
      Caption = 'Max. height [cm]'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label39: TLabel
      Left = 88
      Top = 189
      Width = 57
      Height = 13
      Caption = 'SLA [cm'#178'/g]'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label48: TLabel
      Left = 61
      Top = 217
      Width = 84
      Height = 13
      Caption = 'Shoot-Root-Ratio'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label50: TLabel
      Left = 13
      Top = 244
      Width = 132
      Height = 13
      Caption = 'Specific Root Length [cm/g]'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label51: TLabel
      Left = 13
      Top = 283
      Width = 209
      Height = 13
      Caption = 'Rooting Depth ~ Shoot Biomass: Power-law'
    end
    object Label1: TLabel
      Left = 99
      Top = 304
      Width = 45
      Height = 13
      Caption = 'Intercept'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 98
      Top = 331
      Width = 46
      Height = 13
      Caption = 'Exponent'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Edit10: TEdit
      Left = 157
      Top = 51
      Width = 58
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      Text = 'Edit10'
    end
    object Edit11: TEdit
      Left = 157
      Top = 78
      Width = 58
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      Text = 'Edit11'
    end
    object Edit13: TEdit
      Left = 157
      Top = 105
      Width = 58
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      Text = 'Edit13'
    end
    object Edit14: TEdit
      Left = 157
      Top = 132
      Width = 58
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      Text = 'Edit14'
    end
    object Edit25: TEdit
      Left = 157
      Top = 161
      Width = 58
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      Text = 'Edit25'
    end
    object Edit28: TEdit
      Left = 157
      Top = 187
      Width = 58
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
      Text = 'Edit28'
    end
    object Edit37: TEdit
      Left = 157
      Top = 215
      Width = 58
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 6
      Text = 'Edit37'
    end
    object Edit41: TEdit
      Left = 157
      Top = 242
      Width = 58
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 7
      Text = 'Edit41'
    end
    object Edit42: TEdit
      Left = 157
      Top = 302
      Width = 58
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 8
      Text = 'Edit42'
    end
    object Edit43: TEdit
      Left = 157
      Top = 329
      Width = 58
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 9
      Text = 'Edit43'
    end
    object geom_save: TButton
      Left = 13
      Top = 408
      Width = 202
      Height = 25
      Caption = 'geom_save'
      TabOrder = 10
      Visible = False
      OnClick = geom_saveClick
    end
  end
  object Edit2: TEdit
    Left = 152
    Top = 52
    Width = 86
    Height = 21
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    Text = ' '
  end
  object Panel1: TPanel
    Left = 244
    Top = 299
    Width = 346
    Height = 227
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
    object Label55: TLabel
      Left = 15
      Top = 135
      Width = 182
      Height = 13
      Caption = 'symbiotische Stickstofffixierung'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label5: TLabel
      Left = 15
      Top = 16
      Width = 100
      Height = 19
      Caption = 'Competition'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label33: TLabel
      Left = 54
      Top = 52
      Width = 182
      Height = 13
      Caption = 'Water-Use-Efficiency [g ODM/kg H20]'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label52: TLabel
      Left = 55
      Top = 79
      Width = 181
      Height = 13
      Caption = 'Nitrogen-Use-Efficiency [g ODM/kg N]'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 148
      Top = 106
      Width = 86
      Height = 13
      Caption = 'C:N ratio of shoot'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object CheckBox9: TCheckBox
      Left = 246
      Top = 138
      Width = 30
      Height = 17
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object Edit20: TEdit
      Left = 248
      Top = 50
      Width = 73
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      Text = 'Edit20'
    end
    object Edit44: TEdit
      Left = 248
      Top = 77
      Width = 73
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      Text = 'Edit44'
    end
    object Edit1: TEdit
      Left = 248
      Top = 104
      Width = 73
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      Text = 'Edit1'
    end
    object compet_save: TButton
      Left = 54
      Top = 186
      Width = 202
      Height = 25
      Caption = 'Button4'
      TabOrder = 4
      Visible = False
      OnClick = compet_saveClick
    end
  end
  object DBLookupComboBox1: TDBLookupComboBox
    Left = 8
    Top = 25
    Width = 230
    Height = 21
    KeyField = 'art_id'
    ListField = 'name'
    ListSource = gmnm_src
    TabOrder = 6
    OnCloseUp = DBLookupComboBox1CloseUp
  end
  object Edit4: TEdit
    Left = 244
    Top = 25
    Width = 256
    Height = 21
    TabOrder = 7
    Text = '?'
    OnChange = Edit4Change
  end
  object Button3: TButton
    Left = 506
    Top = 23
    Width = 84
    Height = 25
    Caption = 'create new'
    Enabled = False
    TabOrder = 8
    OnClick = Button3Click
  end
  object Button1: TButton
    Left = 680
    Top = 532
    Width = 202
    Height = 29
    Caption = 'close'
    TabOrder = 9
    OnClick = Button1Click
  end
  object cb_edit: TCheckBox
    Left = 8
    Top = 52
    Width = 65
    Height = 17
    Caption = 'edit data '
    TabOrder = 10
    OnClick = cb_editClick
  end
  object gmnm_src: TDataSource
    DataSet = fdc.grm_names
    Left = 500
    Top = 53
  end
end
