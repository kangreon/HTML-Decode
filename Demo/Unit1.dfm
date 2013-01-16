object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'HTML Entities'
  ClientHeight = 328
  ClientWidth = 383
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 30
    Height = 13
    Caption = 'HTML:'
  end
  object Label2: TLabel
    Left = 8
    Top = 136
    Width = 57
    Height = 13
    Caption = #1056#1077#1079#1091#1083#1100#1090#1072#1090':'
  end
  object Memo1: TMemo
    Left = 8
    Top = 24
    Width = 369
    Height = 105
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'DejaVu Sans'
    Font.Style = []
    ParentFont = False
    ScrollBars = ssBoth
    TabOrder = 0
  end
  object Memo2: TMemo
    Left = 8
    Top = 152
    Width = 369
    Height = 106
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'DejaVu Sans'
    Font.Style = []
    ParentFont = False
    ScrollBars = ssBoth
    TabOrder = 1
  end
  object Button2: TButton
    Left = 8
    Top = 264
    Width = 129
    Height = 55
    Caption = #1050#1086#1085#1074#1077#1088#1090#1080#1088#1086#1074#1072#1090#1100
    TabOrder = 2
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 232
    Top = 264
    Width = 145
    Height = 55
    Caption = #1050#1086#1085#1074#1077#1088#1090#1080#1088#1086#1074#1072#1090#1100' '#1080' '#1089#1086#1093#1088#1072#1085#1080#1090#1100' '#1074' '#1092#1072#1081#1083' (UTF8)'
    TabOrder = 3
    WordWrap = True
    OnClick = Button3Click
  end
  object SaveDialog1: TSaveDialog
    DefaultExt = 'txt'
    Filter = 'TXT '#1060#1072#1081#1083#1099'|*.txt'
    Left = 176
    Top = 56
  end
end
