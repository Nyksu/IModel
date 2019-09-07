object Usf: TUsf
  Left = 0
  Top = 0
  Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1080
  ClientHeight = 477
  ClientWidth = 531
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 531
    Height = 477
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object DBGrid1: TDBGrid
      Left = 0
      Top = 0
      Width = 319
      Height = 477
      Align = alClient
      BorderStyle = bsNone
      DataSource = Form1.DSUsers
      Options = [dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      OnCellClick = DBGrid1CellClick
      OnKeyUp = DBGrid1KeyUp
      OnMouseUp = DBGrid1MouseUp
      Columns = <
        item
          Expanded = False
          FieldName = 'NAME'
          Title.Alignment = taCenter
          Title.Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100
          Width = 241
          Visible = True
        end>
    end
    object GroupBox1: TGroupBox
      Left = 319
      Top = 0
      Width = 212
      Height = 477
      Align = alRight
      Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1099
      TabOrder = 1
      DesignSize = (
        212
        477)
      object SpeedButton5: TSpeedButton
        Left = 48
        Top = 131
        Width = 121
        Height = 22
        Caption = #1054#1095#1080#1089#1090#1080#1090#1100' '#1087#1086#1083#1103
        Flat = True
        OnClick = SpeedButton5Click
      end
      object Panel2: TPanel
        Left = 9
        Top = 153
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
          Width = 30
          Height = 13
          Caption = #1051#1086#1075#1080#1085
        end
        object Label3: TLabel
          Left = 8
          Top = 90
          Width = 37
          Height = 13
          Caption = #1055#1072#1088#1086#1083#1100
        end
        object Label4: TLabel
          Left = 8
          Top = 131
          Width = 67
          Height = 13
          Caption = #1050#1086#1084#1084#1077#1085#1090#1072#1088#1080#1081
        end
        object Label1: TLabel
          Left = 8
          Top = 9
          Width = 93
          Height = 13
          Caption = #1048#1084#1103' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103
        end
        object Label5: TLabel
          Left = 8
          Top = 170
          Width = 24
          Height = 13
          Caption = #1056#1086#1083#1100
        end
        object SpeedButton10: TSpeedButton
          Left = 152
          Top = 103
          Width = 33
          Height = 22
          Caption = 'New'
          Flat = True
          OnClick = SpeedButton10Click
        end
        object Panel4: TPanel
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
        object Panel3: TPanel
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
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 3
        end
        object Edit3: TEdit
          Left = 8
          Top = 105
          Width = 141
          Height = 21
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 4
          OnClick = Edit3Click
        end
        object Edit4: TEdit
          Left = 8
          Top = 145
          Width = 177
          Height = 21
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 5
        end
        object DBLookupComboBox1: TDBLookupComboBox
          Left = 8
          Top = 184
          Width = 177
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
          TabOrder = 6
        end
        object CheckBox1: TCheckBox
          Left = 8
          Top = 209
          Width = 16
          Height = 17
          TabOrder = 7
          OnClick = CheckBox1Click
        end
      end
      object GroupBox2: TGroupBox
        Left = 2
        Top = 15
        Width = 208
        Height = 109
        Align = alTop
        Caption = #1043#1088#1091#1087#1087#1072
        Ctl3D = True
        ParentCtl3D = False
        TabOrder = 1
        object CheckListBox1: TCheckListBox
          Left = 2
          Top = 15
          Width = 176
          Height = 92
          OnClickCheck = CheckListBox1ClickCheck
          Align = alLeft
          BevelInner = bvSpace
          BevelOuter = bvNone
          BevelKind = bkFlat
          Columns = 1
          ItemHeight = 13
          TabOrder = 0
        end
        object Panel5: TPanel
          Left = 178
          Top = 15
          Width = 27
          Height = 92
          Align = alLeft
          BevelInner = bvLowered
          BevelOuter = bvSpace
          TabOrder = 1
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
end
