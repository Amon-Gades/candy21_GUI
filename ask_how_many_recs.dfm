object rec_app_quest: Trec_app_quest
  Left = 536
  Top = 179
  Width = 323
  Height = 135
  Caption = 'Question'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 40
    Top = 16
    Width = 185
    Height = 13
    Caption = 'How many records should be created ?'
  end
  object Edit1: TEdit
    Left = 240
    Top = 16
    Width = 33
    Height = 21
    TabOrder = 0
    Text = '5'
  end
  object UpDown1: TUpDown
    Left = 273
    Top = 16
    Width = 12
    Height = 21
    Associate = Edit1
    Position = 5
    TabOrder = 1
  end
  object Button1: TButton
    Left = 216
    Top = 56
    Width = 75
    Height = 25
    Caption = 'cancel'
    TabOrder = 2
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 40
    Top = 56
    Width = 75
    Height = 25
    Caption = 'OK'
    TabOrder = 3
    OnClick = Button2Click
  end
end
