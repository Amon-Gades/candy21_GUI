object sel_res_frm: Tsel_res_frm
  Left = 473
  Top = 114
  Caption = 'Select Results'
  ClientHeight = 434
  ClientWidth = 323
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  OnShow = FormShow
  PixelsPerInch = 120
  TextHeight = 16
  object Label1: TLabel
    Left = 39
    Top = 335
    Width = 63
    Height = 16
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = 'save to list'
  end
  object Label2: TLabel
    Left = 30
    Top = 364
    Width = 75
    Height = 16
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = 'load from list'
  end
  object Button1: TButton
    Left = 204
    Top = 394
    Width = 83
    Height = 31
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = 'OK'
    TabOrder = 0
    OnClick = Button1Click
  end
  object CheckListBox1: TCheckListBox
    Left = 108
    Top = 40
    Width = 179
    Height = 287
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    OnClickCheck = CheckListBox1ClickCheck
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    OnMouseMove = CheckListBox1MouseMove
  end
  object Button2: TButton
    Left = 30
    Top = 59
    Width = 60
    Height = 41
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = 'all'
    TabOrder = 2
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 30
    Top = 148
    Width = 60
    Height = 40
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = 'none'
    TabOrder = 3
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 30
    Top = 226
    Width = 60
    Height = 41
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = 'invert'
    TabOrder = 4
    OnClick = Button4Click
  end
  object Edit1: TEdit
    Left = 108
    Top = 331
    Width = 179
    Height = 24
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    TabOrder = 5
    Text = '?'
  end
  object ComboBox1: TComboBox
    Left = 108
    Top = 361
    Width = 179
    Height = 24
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    TabOrder = 6
    Text = 'ComboBox1'
    OnCloseUp = ComboBox1CloseUp
  end
end
