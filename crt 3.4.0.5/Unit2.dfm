object Grf: TGrf
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsDialog
  Caption = #1043#1088#1091#1087#1087#1099
  ClientHeight = 298
  ClientWidth = 597
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
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 597
    Height = 298
    Align = alClient
    BevelOuter = bvNone
    Caption = 'Panel1'
    TabOrder = 0
    ExplicitWidth = 293
    DesignSize = (
      597
      298)
    object SpeedButton4: TSpeedButton
      Left = 528
      Top = 185
      Width = 49
      Height = 21
      Caption = 'Edit'
      Flat = True
      OnClick = SpeedButton4Click
    end
    object DBGrid1: TDBGrid
      Left = 0
      Top = 0
      Width = 597
      Height = 179
      Align = alTop
      Anchors = [akLeft, akTop, akRight, akBottom]
      BorderStyle = bsNone
      DataSource = Form1.DSGroups
      Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      OnKeyUp = DBGrid1KeyUp
      OnMouseUp = DBGrid1MouseUp
      Columns = <
        item
          Expanded = False
          FieldName = 'NAME'
          Title.Alignment = taCenter
          Title.Caption = #1043#1088#1091#1087#1087#1072
          Width = 550
          Visible = True
        end>
    end
    object Edit1: TEdit
      Left = 15
      Top = 212
      Width = 507
      Height = 21
      Anchors = [akLeft, akBottom]
      BevelInner = bvLowered
      BevelKind = bkFlat
      BorderStyle = bsNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
    end
    object Panel2: TPanel
      Left = 159
      Top = 253
      Width = 180
      Height = 36
      Anchors = [akLeft, akBottom]
      BevelInner = bvLowered
      BevelOuter = bvSpace
      TabOrder = 2
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
    object Panel3: TPanel
      Left = 339
      Top = 253
      Width = 90
      Height = 36
      Anchors = [akLeft, akBottom]
      BevelInner = bvLowered
      BevelOuter = bvSpace
      TabOrder = 3
      object SpeedButton3: TSpeedButton
        Left = 2
        Top = 2
        Width = 86
        Height = 32
        Caption = #1047#1072#1082#1088#1099#1090#1100
        Flat = True
        OnClick = SpeedButton3Click
      end
    end
    object Edit2: TEdit
      Left = 15
      Top = 185
      Width = 507
      Height = 21
      BevelInner = bvLowered
      BevelKind = bkFlat
      BorderStyle = bsNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 4
      OnChange = Edit2Change
    end
    object CheckBox1: TCheckBox
      Left = 15
      Top = 234
      Width = 15
      Height = 17
      TabOrder = 5
      OnClick = CheckBox1Click
    end
  end
end
