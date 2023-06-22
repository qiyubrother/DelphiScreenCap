object Form1: TForm1
  Left = 0
  Top = 0
  Caption = #23450#26102#25130#23631
  ClientHeight = 52
  ClientWidth = 433
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsStayOnTop
  Position = poDesktopCenter
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 120
    Height = 18
    Caption = #26102#38388#38388#38548#65288#27627#31186#65289
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 18
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object dtInterval: TEdit
    Left = 126
    Top = 8
    Width = 59
    Height = 24
    TabOrder = 0
    Text = '1000'
  end
  object btnStart: TButton
    Left = 191
    Top = 8
    Width = 114
    Height = 25
    Caption = #21551#21160#23450#26102#25130#23631
    TabOrder = 1
    OnClick = btnStartClick
  end
  object btnStop: TButton
    Left = 311
    Top = 8
    Width = 114
    Height = 25
    Caption = #20572#27490#23450#26102#25130#23631
    Enabled = False
    TabOrder = 2
    OnClick = btnStopClick
  end
  object tmr: TTimer
    Enabled = False
    OnTimer = tmrTimer
    Left = 272
    Top = 40
  end
end
