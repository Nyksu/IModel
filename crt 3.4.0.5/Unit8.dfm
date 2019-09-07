object Opf: TOpf
  Left = 0
  Top = 0
  Caption = #1054#1087#1077#1088#1072#1094#1080#1080
  ClientHeight = 469
  ClientWidth = 799
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
  object Splitter1: TSplitter
    Left = 567
    Top = 0
    Height = 469
    Align = alRight
    ExplicitLeft = 560
    ExplicitTop = -8
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 567
    Height = 469
    Align = alClient
    BevelOuter = bvNone
    Caption = 'Panel1'
    TabOrder = 0
    ExplicitWidth = 465
    object GroupBox1: TGroupBox
      Left = 0
      Top = 0
      Width = 567
      Height = 218
      Align = alClient
      TabOrder = 0
      ExplicitWidth = 544
      object DBGrid1: TDBGrid
        Left = 2
        Top = 15
        Width = 563
        Height = 201
        Align = alClient
        DataSource = Form1.DSOperations
        Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        OnKeyUp = DBGrid1KeyUp
        OnMouseMove = DBGrid1MouseMove
        OnMouseUp = DBGrid1MouseUp
        Columns = <
          item
            Expanded = False
            FieldName = 'KN'
            Title.Caption = #1050#1086#1076
            Width = 60
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'NAME'
            Title.Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1086#1087#1077#1088#1072#1094#1080#1080
            Width = 444
            Visible = True
          end>
      end
    end
    object GroupBox2: TGroupBox
      Left = 0
      Top = 218
      Width = 567
      Height = 251
      Align = alBottom
      Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1099
      TabOrder = 1
      ExplicitWidth = 544
      DesignSize = (
        567
        251)
      object Label1: TLabel
        Left = 32
        Top = 64
        Width = 67
        Height = 13
        Caption = #1050#1086#1084#1084#1077#1085#1090#1072#1088#1080#1081
      end
      object Label2: TLabel
        Left = 384
        Top = 104
        Width = 36
        Height = 13
        Caption = #1057#1090#1072#1090#1091#1089
      end
      object Label3: TLabel
        Left = 32
        Top = 104
        Width = 24
        Height = 13
        Caption = #1056#1086#1083#1100
      end
      object Label4: TLabel
        Left = 32
        Top = 24
        Width = 73
        Height = 13
        Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
      end
      object Label5: TLabel
        Left = 32
        Top = 152
        Width = 39
        Height = 13
        Caption = '             '
      end
      object Label6: TLabel
        Left = 32
        Top = 144
        Width = 36
        Height = 13
        Caption = '            '
      end
      object SpeedButton5: TSpeedButton
        Left = 10
        Top = 38
        Width = 22
        Height = 21
        Caption = 'Clr'
        Flat = True
        OnClick = SpeedButton5Click
      end
      object DBLookupComboBox1: TDBLookupComboBox
        Left = 32
        Top = 118
        Width = 337
        Height = 21
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        KeyField = 'ID'
        ListField = 'NAME'
        ListSource = Form1.DSRoles
        ParentFont = False
        TabOrder = 0
      end
      object Panel2: TPanel
        Left = 96
        Top = 203
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
        object SpeedButton3: TSpeedButton
          Left = 91
          Top = 2
          Width = 87
          Height = 32
          Caption = #1048#1079#1084#1077#1085#1080#1090#1100
          Enabled = False
          Flat = True
          OnClick = SpeedButton3Click
        end
      end
      object Panel3: TPanel
        Left = 276
        Top = 203
        Width = 178
        Height = 36
        Anchors = [akLeft, akBottom]
        BevelInner = bvLowered
        BevelOuter = bvSpace
        TabOrder = 2
        object SpeedButton4: TSpeedButton
          Left = 89
          Top = 2
          Width = 87
          Height = 32
          Caption = #1047#1072#1082#1088#1099#1090#1100
          Flat = True
          OnClick = SpeedButton4Click
        end
        object SpeedButton2: TSpeedButton
          Left = 2
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
        Left = 32
        Top = 38
        Width = 473
        Height = 21
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 3
      end
      object Edit2: TEdit
        Left = 32
        Top = 78
        Width = 473
        Height = 21
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 4
      end
      object Edit3: TEdit
        Left = 384
        Top = 118
        Width = 121
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
      object CheckBox1: TCheckBox
        Left = 40
        Top = 208
        Width = 15
        Height = 17
        TabOrder = 6
        OnClick = CheckBox1Click
      end
    end
  end
  object RPanel: TPanel
    Left = 570
    Top = 0
    Width = 229
    Height = 469
    Align = alRight
    BevelOuter = bvNone
    TabOrder = 1
    ExplicitLeft = 528
    object GroupBox3: TGroupBox
      Left = 0
      Top = 0
      Width = 229
      Height = 469
      Align = alClient
      Caption = #1043#1088#1091#1087#1087#1072
      Ctl3D = True
      ParentCtl3D = False
      TabOrder = 0
      object CheckListBox1: TCheckListBox
        Left = 2
        Top = 15
        Width = 198
        Height = 452
        OnClickCheck = CheckListBox1ClickCheck
        Align = alClient
        BevelInner = bvSpace
        BevelOuter = bvNone
        BevelKind = bkFlat
        Columns = 1
        ItemHeight = 13
        TabOrder = 0
        OnEnter = CheckListBox1Enter
      end
      object Panel15: TPanel
        Left = 200
        Top = 15
        Width = 27
        Height = 452
        Align = alRight
        BevelInner = bvLowered
        BevelOuter = bvSpace
        TabOrder = 1
        ExplicitLeft = 191
        ExplicitTop = 23
        object SpeedButton6: TSpeedButton
          Left = 2
          Top = 2
          Width = 23
          Height = 22
          Caption = 'Ad'
          Flat = True
          OnClick = SpeedButton6Click
        end
        object SpeedButton7: TSpeedButton
          Left = 2
          Top = 24
          Width = 23
          Height = 22
          Caption = 'De'
          Flat = True
          OnClick = SpeedButton7Click
        end
        object SpeedButton8: TSpeedButton
          Left = 2
          Top = 46
          Width = 23
          Height = 22
          Caption = 'Gr'
          Enabled = False
          Flat = True
        end
        object SpeedButton9: TSpeedButton
          Left = 2
          Top = 68
          Width = 23
          Height = 22
          Caption = 'Us'
          Enabled = False
          Flat = True
        end
      end
    end
  end
end
