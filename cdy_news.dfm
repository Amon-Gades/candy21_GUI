object cdynews: Tcdynews
  Left = 0
  Top = 0
  Caption = 'online news'
  ClientHeight = 168
  ClientWidth = 394
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 12
  object newslist: TListBox
    Left = 6
    Top = 6
    Width = 382
    Height = 109
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    ItemHeight = 12
    TabOrder = 0
  end
  object Button2: TButton
    Left = 198
    Top = 134
    Width = 189
    Height = 23
    Caption = '&OK - delete this message'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    OnClick = Button2Click
  end
  object Button1: TButton
    Left = 6
    Top = 134
    Width = 186
    Height = 23
    Caption = '&OK - show message again'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    OnClick = Button1Click
  end
end
