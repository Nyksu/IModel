object LimitForm: TLimitForm
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1054#1075#1088#1072#1085#1080#1095#1077#1085#1080#1103
  ClientHeight = 326
  ClientWidth = 298
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
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object BasePanel: TPanel
    Left = 0
    Top = 0
    Width = 298
    Height = 326
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object OriginLabel: TLabel
      Left = 16
      Top = 11
      Width = 92
      Height = 13
      Caption = #1055#1088#1072#1074#1086#1086#1073#1083#1072#1076#1072#1090#1077#1083#1100
    end
    object OriginalEdit: TEdit
      Left = 16
      Top = 30
      Width = 265
      Height = 19
      Ctl3D = False
      ParentCtl3D = False
      TabOrder = 0
    end
    object LimitCheckBox: TCheckBox
      Left = 189
      Top = 55
      Width = 92
      Height = 17
      Caption = #1054#1075#1088#1072#1085#1080#1095#1077#1085#1080#1103
      Ctl3D = True
      ParentCtl3D = False
      TabOrder = 1
      OnClick = LimitCheckBoxClick
    end
    object Panel1: TPanel
      Left = 16
      Top = 78
      Width = 265
      Height = 211
      BevelOuter = bvLowered
      Enabled = False
      TabOrder = 2
      object Label1: TLabel
        Left = 32
        Top = 13
        Width = 140
        Height = 13
        Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1077#1081
      end
      object Label2: TLabel
        Left = 13
        Top = 38
        Width = 159
        Height = 13
        Caption = #1057#1091#1084#1084#1072#1088#1085#1072#1103' '#1072#1082#1090#1080#1074#1085#1072#1103' '#1084#1086#1097#1085#1086#1089#1090#1100
      end
      object Label3: TLabel
        Left = 43
        Top = 63
        Width = 129
        Height = 13
        Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1089#1090#1088#1086#1082' '#1074' Excel'
      end
      object Label4: TLabel
        Left = 86
        Top = 88
        Width = 86
        Height = 13
        Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1089#1093#1077#1084
      end
      object Label5: TLabel
        Left = 18
        Top = 113
        Width = 154
        Height = 13
        Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1096#1072#1073#1083#1086#1085#1086#1074' '#1074' '#1089#1093#1077#1084#1077
      end
      object Label6: TLabel
        Left = 19
        Top = 138
        Width = 77
        Height = 13
        Caption = #1042#1080#1076#1099' '#1088#1072#1089#1095#1077#1090#1086#1074
      end
      object Edit1: TEdit
        Left = 178
        Top = 11
        Width = 49
        Height = 19
        Ctl3D = False
        ParentCtl3D = False
        TabOrder = 0
        Text = '0'
      end
      object Edit2: TEdit
        Left = 178
        Top = 36
        Width = 49
        Height = 19
        Ctl3D = False
        ParentCtl3D = False
        TabOrder = 1
        Text = '0'
      end
      object Edit3: TEdit
        Left = 178
        Top = 61
        Width = 49
        Height = 19
        Ctl3D = False
        ParentCtl3D = False
        TabOrder = 2
        Text = '0'
      end
      object Edit4: TEdit
        Left = 178
        Top = 86
        Width = 49
        Height = 19
        Ctl3D = False
        ParentCtl3D = False
        TabOrder = 3
        Text = '0'
      end
      object Edit5: TEdit
        Left = 178
        Top = 111
        Width = 49
        Height = 19
        Ctl3D = False
        ParentCtl3D = False
        TabOrder = 4
        Text = '0'
      end
      object UpDown1: TUpDown
        Left = 227
        Top = 11
        Width = 16
        Height = 19
        Associate = Edit1
        Max = 1000
        TabOrder = 5
      end
      object UpDown2: TUpDown
        Left = 227
        Top = 36
        Width = 16
        Height = 19
        Associate = Edit2
        TabOrder = 6
      end
      object UpDown3: TUpDown
        Left = 227
        Top = 61
        Width = 16
        Height = 19
        Associate = Edit3
        Max = 1000
        TabOrder = 7
      end
      object UpDown4: TUpDown
        Left = 227
        Top = 86
        Width = 16
        Height = 19
        Associate = Edit4
        Max = 1000
        TabOrder = 8
      end
      object UpDown5: TUpDown
        Left = 227
        Top = 111
        Width = 17
        Height = 19
        Associate = Edit5
        Max = 1000
        TabOrder = 9
      end
      object CheckList: TCheckListBox
        Left = 19
        Top = 157
        Width = 225
        Height = 44
        Ctl3D = False
        ItemHeight = 13
        Items.Strings = (
          #1059#1089#1090#1072#1085#1086#1074#1080#1074#1096#1080#1081#1089#1103' '#1088#1077#1078#1080#1084
          #1050#1086#1088#1086#1090#1082#1086#1077' '#1079#1072#1084#1099#1082#1072#1085#1080#1077)
        ParentCtl3D = False
        TabOrder = 10
      end
    end
    object SaveBt: TButton
      Left = 206
      Top = 295
      Width = 75
      Height = 25
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
      TabOrder = 3
      OnClick = SaveBtClick
    end
  end
end
