object Form6: TForm6
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'Form6'
  ClientHeight = 469
  ClientWidth = 589
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 378
    Top = 0
    Width = 211
    Height = 469
    Align = alRight
    Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1099
    TabOrder = 0
    DesignSize = (
      211
      469)
    object Panel4: TPanel
      Left = 8
      Top = 23
      Width = 193
      Height = 313
      Anchors = [akTop]
      TabOrder = 0
      DesignSize = (
        193
        313)
      object Label2: TLabel
        Left = 8
        Top = 50
        Width = 36
        Height = 13
        Caption = #1057#1090#1072#1090#1091#1089
      end
      object Label3: TLabel
        Left = 8
        Top = 90
        Width = 20
        Height = 13
        Caption = #1050#1086#1076
      end
      object Label4: TLabel
        Left = 8
        Top = 131
        Width = 109
        Height = 13
        Caption = #1050#1086#1076' '#1074#1077#1088#1093#1085#1077#1075#1086' '#1091#1088#1086#1074#1085#1103
      end
      object Label1: TLabel
        Left = 8
        Top = 9
        Width = 52
        Height = 13
        Caption = #1048#1084#1103' '#1073#1083#1086#1082#1072
      end
      object Label5: TLabel
        Left = 8
        Top = 176
        Width = 3
        Height = 13
      end
      object Label6: TLabel
        Left = 8
        Top = 176
        Width = 3
        Height = 13
      end
      object Panel3: TPanel
        Left = 7
        Top = 268
        Width = 180
        Height = 36
        Anchors = [akLeft, akBottom]
        BevelInner = bvLowered
        BevelOuter = bvSpace
        TabOrder = 0
        object SpeedButton3: TSpeedButton
          Left = 2
          Top = 2
          Width = 89
          Height = 32
          Caption = #1048#1079#1084#1077#1085#1080#1090#1100
          Enabled = False
          Flat = True
          OnClick = SpeedButton3Click
        end
        object SpeedButton4: TSpeedButton
          Left = 91
          Top = 2
          Width = 87
          Height = 32
          Caption = #1047#1072#1082#1088#1099#1090#1100
          Flat = True
          OnClick = SpeedButton4Click
        end
      end
      object Panel2: TPanel
        Left = 7
        Top = 232
        Width = 180
        Height = 36
        Anchors = [akLeft, akBottom]
        BevelInner = bvLowered
        BevelOuter = bvSpace
        TabOrder = 1
        object SpeedButton1: TSpeedButton
          Left = 2
          Top = 2
          Width = 89
          Height = 32
          Caption = #1044#1086#1073#1072#1074#1080#1090#1100
          Enabled = False
          Flat = True
          OnClick = SpeedButton1Click
        end
        object SpeedButton2: TSpeedButton
          Left = 91
          Top = 2
          Width = 87
          Height = 32
          Caption = #1059#1076#1072#1083#1080#1090#1100
          Enabled = False
          Flat = True
          OnClick = SpeedButton2Click
        end
      end
      object Edit1: TEdit
        Left = 8
        Top = 24
        Width = 177
        Height = 21
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 2
      end
      object Edit2: TEdit
        Left = 8
        Top = 64
        Width = 177
        Height = 21
        Color = clBtnFace
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        ReadOnly = True
        TabOrder = 3
      end
      object Edit3: TEdit
        Left = 8
        Top = 104
        Width = 177
        Height = 21
        Color = clBtnFace
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        ReadOnly = True
        TabOrder = 4
      end
      object Edit4: TEdit
        Left = 8
        Top = 145
        Width = 177
        Height = 21
        Color = clBtnFace
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        ReadOnly = True
        TabOrder = 5
      end
    end
    object CheckBox1: TCheckBox
      Left = 16
      Top = 341
      Width = 15
      Height = 17
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = CheckBox1Click
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 378
    Height = 469
    Align = alClient
    BevelOuter = bvNone
    Caption = 'Panel1'
    TabOrder = 1
    object TreeView1: TTreeView
      Left = 0
      Top = 0
      Width = 378
      Height = 469
      Align = alClient
      BorderStyle = bsNone
      Images = Form1.ImList
      Indent = 19
      ReadOnly = True
      TabOrder = 0
      OnClick = TreeView1Click
      OnGetImageIndex = TreeView1GetImageIndex
      OnKeyUp = TreeView1KeyUp
      OnMouseMove = TreeView1MouseMove
    end
  end
end
