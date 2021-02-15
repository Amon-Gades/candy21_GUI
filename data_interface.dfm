object webdata: Twebdata
  Left = 0
  Top = 0
  Caption = 'web based parameter interface'
  ClientHeight = 543
  ClientWidth = 753
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  OnMouseDown = FormMouseDown
  OnShow = FormShow
  PixelsPerInch = 120
  TextHeight = 17
  object Label6: TLabel
    Left = 10
    Top = 10
    Width = 215
    Height = 27
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = 'parameter web site'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -22
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    Font.Quality = fqClearType
    ParentFont = False
    Visible = False
  end
  object Label1: TLabel
    Left = 35
    Top = 158
    Width = 4
    Height = 17
    Caption = '.'
  end
  object wb: TWebBrowser
    Left = 52
    Top = 205
    Width = 294
    Height = 183
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    TabOrder = 0
    ControlData = {
      4C000000631E0000EA1200000000000000000000000000000000000000000000
      000000004C000000000000000000000001000000E0D057007335CF11AE690800
      2B2E126208000000000000004C0000000114020000000000C000000000000046
      8000000000000000000000000000000000000000000000000000000000000000
      00000000000000000100000000000000000000000000000000000000}
  end
  object Button4: TButton
    Left = 290
    Top = 441
    Width = 109
    Height = 32
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = 'Button4'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    Visible = False
  end
  object Button5: TButton
    Left = 282
    Top = 400
    Width = 109
    Height = 33
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = 'Button5'
    TabOrder = 2
    Visible = False
  end
  object ListBox1: TListBox
    Left = 35
    Top = 189
    Width = 686
    Height = 284
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    ItemHeight = 17
    TabOrder = 3
  end
  object Button1: TButton
    Left = 437
    Top = 501
    Width = 284
    Height = 33
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = 'Ende'
    TabOrder = 4
    OnClick = Button1Click
  end
  object Edit5: TEdit
    Left = 285
    Top = 282
    Width = 114
    Height = 26
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
    Text = 'www.ufz.de'
    Visible = False
  end
  object Button7: TButton
    Left = 290
    Top = 319
    Width = 98
    Height = 33
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = 'any website'
    TabOrder = 6
    Visible = False
    OnClick = Button7Click
  end
  object Button8: TButton
    Left = 282
    Top = 360
    Width = 117
    Height = 32
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = 'find location'
    TabOrder = 7
    Visible = False
  end
  object Button9: TButton
    Left = 31
    Top = 31
    Width = 690
    Height = 50
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = 'check web parms'
    TabOrder = 8
    OnClick = Button9Click
  end
  object Edit6: TEdit
    Left = 228
    Top = 13
    Width = 307
    Height = 25
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    TabOrder = 9
    Text = 'https://www.ufz.de/index.php?de=42459'
    Visible = False
  end
  object ComboBox2: TComboBox
    Left = 31
    Top = 105
    Width = 368
    Height = 25
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    TabOrder = 10
    Text = 'ComboBox2'
    Visible = False
    OnCloseUp = ComboBox2CloseUp
    Items.Strings = (
      'a'
      'b')
  end
  object Button10: TButton
    Left = 458
    Top = 107
    Width = 263
    Height = 33
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = 'import crop record'
    TabOrder = 11
    Visible = False
    OnClick = Button10Click
  end
  object ComboBox3: TComboBox
    Left = 31
    Top = 122
    Width = 368
    Height = 25
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    TabOrder = 12
    Text = 'ComboBox3'
    Visible = False
    OnCloseUp = ComboBox3CloseUp
  end
  object Button12: TButton
    Left = 458
    Top = 119
    Width = 263
    Height = 32
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = 'import FOM record'
    TabOrder = 13
    Visible = False
    OnClick = Button12Click
  end
end
