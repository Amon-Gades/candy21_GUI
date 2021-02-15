object ST_View: TST_View
  Left = 171
  Top = 41
  Caption = 'Stat_View'
  ClientHeight = 558
  ClientWidth = 611
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 24
    Top = 0
    Width = 32
    Height = 13
    Caption = 'Label1'
  end
  object Label2: TLabel
    Left = 24
    Top = 16
    Width = 32
    Height = 13
    Caption = 'Label2'
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 32
    Width = 585
    Height = 481
    Caption = 'Stat-Record'
    TabOrder = 0
    object StringGrid1: TStringGrid
      Left = 14
      Top = 15
      Width = 201
      Height = 322
      DefaultColWidth = 38
      DefaultRowHeight = 14
      FixedCols = 0
      RowCount = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -8
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ScrollBars = ssNone
      TabOrder = 0
    end
    object StringGrid2: TStringGrid
      Left = 14
      Top = 343
      Width = 379
      Height = 122
      ColCount = 9
      DefaultColWidth = 38
      DefaultRowHeight = 14
      FixedCols = 0
      RowCount = 8
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -8
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ScrollBars = ssNone
      TabOrder = 1
    end
    object StringGrid3: TStringGrid
      Left = 222
      Top = 16
      Width = 167
      Height = 321
      ColCount = 2
      DefaultColWidth = 80
      DefaultRowHeight = 14
      FixedCols = 0
      RowCount = 19
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -8
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ScrollBars = ssNone
      TabOrder = 2
    end
    object StringGrid4: TStringGrid
      Left = 398
      Top = 16
      Width = 167
      Height = 153
      ColCount = 2
      DefaultColWidth = 80
      DefaultRowHeight = 14
      FixedCols = 0
      RowCount = 10
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -8
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ScrollBars = ssNone
      TabOrder = 3
    end
    object Button2: TButton
      Left = 486
      Top = 360
      Width = 75
      Height = 25
      Caption = '>>>>>'
      Enabled = False
      TabOrder = 4
      OnClick = Button2Click
    end
    object Button1: TButton
      Left = 406
      Top = 360
      Width = 75
      Height = 25
      Caption = '<<<<<'
      Enabled = False
      TabOrder = 5
      OnClick = Button1Click
    end
    object ListBox1: TListBox
      Left = 400
      Top = 176
      Width = 161
      Height = 161
      ItemHeight = 13
      TabOrder = 6
      OnDblClick = ListBox1DblClick
    end
    object Button4: TButton
      Left = 408
      Top = 408
      Width = 153
      Height = 25
      Caption = 'compress file'
      TabOrder = 7
      OnClick = Button4Click
    end
  end
  object Button3: TButton
    Left = 416
    Top = 520
    Width = 153
    Height = 25
    Caption = 'OK'
    TabOrder = 1
    OnClick = Button3Click
  end
end
