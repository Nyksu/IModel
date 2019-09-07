object Datef: TDatef
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'Datef'
  ClientHeight = 184
  ClientWidth = 162
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object Calendar: TMonthCalendar
    Left = 0
    Top = 0
    Width = 162
    Height = 153
    Align = alTop
    Date = 39108.552928680560000000
    TabOrder = 0
  end
  object TimeP: TDateTimePicker
    Left = 0
    Top = 160
    Width = 161
    Height = 21
    BevelInner = bvLowered
    Date = 39108.000000000000000000
    Time = 39108.000000000000000000
    Kind = dtkTime
    TabOrder = 1
  end
end
