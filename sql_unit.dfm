object sql_form: Tsql_form
  Left = 569
  Top = 188
  Caption = 'SQL - module'
  ClientHeight = 624
  ClientWidth = 687
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label2: TLabel
    Left = 514
    Top = -1
    Width = 60
    Height = 13
    Caption = 'SQL script'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label1: TLabel
    Left = 632
    Top = 0
    Width = 6
    Height = 13
    Caption = '0'
  end
  object Label3: TLabel
    Left = 656
    Top = 0
    Width = 24
    Height = 13
    Caption = 'of 10'
  end
  object Button1: TButton
    Left = 505
    Top = 226
    Width = 145
    Height = 25
    Caption = 'execute'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Memo1: TMemo
    Left = 0
    Top = 16
    Width = 650
    Height = 193
    Lines.Strings = (
      ' ')
    TabOrder = 1
  end
  object CheckBox1: TCheckBox
    Left = 8
    Top = 232
    Width = 97
    Height = 17
    Caption = 'data change'
    TabOrder = 2
  end
  object Button3: TButton
    Left = 312
    Top = 226
    Width = 171
    Height = 25
    Caption = 'load from file'
    TabOrder = 3
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 137
    Top = 226
    Width = 152
    Height = 25
    Caption = 'save to file'
    TabOrder = 4
    OnClick = Button4Click
  end
  object UpDown1: TUpDown
    Left = 656
    Top = 16
    Width = 29
    Height = 57
    Min = -100
    TabOrder = 5
    OnClick = UpDown1Click
  end
  object PageControl1: TPageControl
    Left = 2
    Top = 257
    Width = 679
    Height = 361
    ActivePage = TabSheet1
    TabOrder = 6
    object TabSheet1: TTabSheet
      Caption = 'result data set'
      object DBGrid1: TDBGrid
        Left = 3
        Top = 3
        Width = 665
        Height = 296
        DataSource = DataSource1
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
      end
      object Button6: TButton
        Left = 199
        Top = 305
        Width = 262
        Height = 25
        Caption = 'export to XLS'
        TabOrder = 1
        OnClick = Button6Click
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'parameters'
      ImageIndex = 1
      object StringGrid1: TStringGrid
        Left = 144
        Top = 56
        Width = 249
        Height = 153
        ColCount = 2
        DefaultColWidth = 120
        RowCount = 6
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goEditing]
        TabOrder = 0
      end
      object Button2: TButton
        Left = 144
        Top = 224
        Width = 249
        Height = 25
        Caption = 'update sql code with parameter values'
        TabOrder = 1
        OnClick = Button2Click
      end
      object Button5: TButton
        Left = 144
        Top = 255
        Width = 249
        Height = 25
        Caption = 'clear grid'
        TabOrder = 2
        OnClick = Button5Click
      end
    end
  end
  object DataSource1: TDataSource
    DataSet = fdc.hqry
    Left = 56
    Top = 416
  end
  object SaveDialog1: TSaveDialog
    DefaultExt = 'sql'
    Left = 128
    Top = 24
  end
  object OpenDialog1: TOpenDialog
    DefaultExt = 'sql'
    Filter = 'sql - files (*.sql)|*.sql'
    Left = 184
    Top = 24
  end
  object xla: TExcelApplication
    AutoConnect = False
    ConnectKind = ckRunningOrNew
    AutoQuit = False
    Left = 264
    Top = 24
  end
end
