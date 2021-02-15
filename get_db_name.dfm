object fget_db_name: Tfget_db_name
  Left = 423
  Top = 202
  Caption = 'Enter name of the new folder'
  ClientHeight = 86
  ClientWidth = 271
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object db_name: TEdit
    Left = 32
    Top = 32
    Width = 89
    Height = 21
    TabOrder = 0
    Text = 'xxxxx'
  end
  object Button1: TButton
    Left = 152
    Top = 32
    Width = 75
    Height = 25
    Caption = 'create'
    TabOrder = 1
    OnClick = Button1Click
  end
end
