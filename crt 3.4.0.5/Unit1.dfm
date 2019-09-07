object Form1: TForm1
  Left = 221
  Top = 186
  ClientHeight = 650
  ClientWidth = 792
  Color = clBtnFace
  Constraints.MinHeight = 600
  Constraints.MinWidth = 800
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 792
    Height = 631
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitHeight = 611
    object ToolBar1: TToolBar
      Left = 0
      Top = 0
      Width = 792
      Height = 25
      ButtonHeight = 21
      ButtonWidth = 79
      Caption = 'ToolBar1'
      Color = clBtnFace
      EdgeBorders = [ebTop, ebRight, ebBottom]
      ParentColor = False
      ShowCaptions = True
      TabOrder = 0
      DesignSize = (
        790
        21)
      object ToolButton1: TToolButton
        Left = 0
        Top = 0
        Caption = #1043#1088#1091#1087#1087#1099
        ImageIndex = 4
        OnClick = ToolButton1Click
      end
      object ToolButton4: TToolButton
        Left = 79
        Top = 0
        Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1080
        ImageIndex = 3
        ParentShowHint = False
        ShowHint = False
        OnClick = ToolButton4Click
      end
      object ToolButton6: TToolButton
        Left = 158
        Top = 0
        Caption = #1056#1086#1083#1080
        ImageIndex = 4
        OnClick = ToolButton6Click
      end
      object ToolButton8: TToolButton
        Left = 237
        Top = 0
        Caption = #1054#1087#1077#1088#1072#1094#1080#1080
        ImageIndex = 4
        OnClick = ToolButton8Click
      end
      object ToolButton2: TToolButton
        Left = 316
        Top = 0
        Caption = #1054#1075#1088#1072#1085#1080#1095#1077#1085#1080#1103
        ImageIndex = 5
        OnClick = ToolButton2Click
      end
      object Panel14: TPanel
        Left = 395
        Top = 0
        Width = 407
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        BevelOuter = bvNone
        TabOrder = 0
        Visible = False
        DesignSize = (
          407
          21)
        object Label8: TLabel
          Left = 193
          Top = 6
          Width = 75
          Height = 13
          Anchors = [akLeft, akTop, akRight]
          Caption = #1045#1084#1082#1086#1089#1090#1100' '#1055#1091#1083#1072':'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label9: TLabel
          Left = 275
          Top = 6
          Width = 3
          Height = 13
          Anchors = [akLeft, akTop, akRight]
        end
      end
    end
    object PageControl1: TPageControl
      Left = 0
      Top = 25
      Width = 792
      Height = 606
      ActivePage = TabSheet2
      Align = alClient
      TabOrder = 1
      ExplicitHeight = 586
      object TabSheet2: TTabSheet
        Caption = 'SQL '#1079#1072#1087#1088#1086#1089#1099
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ImageIndex = 1
        ParentFont = False
        ExplicitHeight = 558
        object Splitter1: TSplitter
          Left = 230
          Top = 0
          Width = 5
          Height = 578
          Beveled = True
          Color = clSkyBlue
          ParentColor = False
          ExplicitLeft = 249
          ExplicitHeight = 540
        end
        object Panel2: TPanel
          Left = 0
          Top = 0
          Width = 230
          Height = 578
          Align = alLeft
          BevelOuter = bvNone
          Caption = 'Panel1'
          Color = clCream
          TabOrder = 0
          ExplicitHeight = 558
          object TreeView1: TTreeView
            Left = 0
            Top = 113
            Width = 230
            Height = 465
            Align = alClient
            Ctl3D = False
            Images = ImList
            Indent = 19
            ParentCtl3D = False
            ParentShowHint = False
            PopupMenu = pop_tree
            ReadOnly = True
            RightClickSelect = True
            RowSelect = True
            ShowHint = False
            TabOrder = 0
            OnClick = TreeView1Click
            OnGetImageIndex = TreeView1GetImageIndex
            OnKeyUp = TreeView1KeyUp
            OnMouseMove = TreeView1MouseMove
            ExplicitHeight = 445
          end
          object Panel12: TPanel
            Left = 0
            Top = 72
            Width = 230
            Height = 41
            Align = alTop
            BevelInner = bvLowered
            BevelOuter = bvSpace
            TabOrder = 1
            Visible = False
            DesignSize = (
              230
              41)
            object SpeedButton19: TSpeedButton
              Left = 210
              Top = 4
              Width = 15
              Height = 15
              Anchors = [akTop, akRight]
              Caption = 'X'
              Flat = True
              OnClick = SpeedButton19Click
              ExplicitLeft = 229
            end
            object Panel13: TPanel
              Left = 6
              Top = 7
              Width = 154
              Height = 28
              BevelOuter = bvNone
              TabOrder = 0
              object SpeedButton18: TSpeedButton
                Left = 77
                Top = 2
                Width = 60
                Height = 22
                BiDiMode = bdRightToLeftReadingOnly
                Caption = #1055#1086#1083#1091#1095#1080#1090#1100
                ParentBiDiMode = False
                OnClick = SpeedButton18Click
              end
              object PoolMask: TMaskEdit
                Left = 2
                Top = 2
                Width = 72
                Height = 22
                Ctl3D = False
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -13
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                MaxLength = 15
                ParentCtl3D = False
                ParentFont = False
                TabOrder = 0
                Text = '1'
                OnKeyPress = user_nameKeyPress
              end
            end
          end
          object Panel4: TPanel
            Left = 0
            Top = 0
            Width = 230
            Height = 72
            Align = alTop
            BevelInner = bvLowered
            BevelOuter = bvSpace
            TabOrder = 2
            DesignSize = (
              230
              72)
            object SpeedButton1: TSpeedButton
              Left = 6
              Top = 12
              Width = 89
              Height = 37
              AllowAllUp = True
              Caption = #1057#1086#1077#1076#1080#1085#1080#1090#1100
              OnClick = SpeedButton1Click
            end
            object lab_flag: TLabel
              Left = 13
              Top = 53
              Width = 74
              Height = 13
              AutoSize = False
              Caption = '    '
              Color = clSilver
              ParentColor = False
            end
            object user_name: TMaskEdit
              Left = 101
              Top = 13
              Width = 118
              Height = 22
              Anchors = [akLeft, akTop, akRight]
              Ctl3D = False
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              MaxLength = 15
              ParentCtl3D = False
              ParentFont = False
              TabOrder = 0
              OnKeyPress = user_nameKeyPress
            end
            object user_pass: TMaskEdit
              Left = 101
              Top = 41
              Width = 118
              Height = 19
              Anchors = [akLeft, akTop, akRight]
              Ctl3D = False
              ParentCtl3D = False
              PasswordChar = '*'
              TabOrder = 1
              OnKeyPress = user_passKeyPress
            end
          end
        end
        object Panel3: TPanel
          Left = 235
          Top = 0
          Width = 549
          Height = 578
          Align = alClient
          Caption = 'Panel2'
          TabOrder = 1
          ExplicitHeight = 558
          object Panel5: TPanel
            Left = 1
            Top = 481
            Width = 547
            Height = 96
            Align = alBottom
            Anchors = [akLeft, akBottom]
            BevelInner = bvLowered
            BevelOuter = bvSpace
            Enabled = False
            TabOrder = 0
            ExplicitTop = 461
            DesignSize = (
              547
              96)
            object Label7: TLabel
              Left = 8
              Top = 24
              Width = 27
              Height = 13
              Caption = '         '
            end
            object CheckViewDel: TCheckBox
              Left = 8
              Top = 3
              Width = 145
              Height = 18
              Anchors = [akLeft]
              Caption = #1055#1086#1082#1072#1079#1099#1074#1072#1090#1100' '#1091#1076#1072#1083#1077#1085#1085#1099#1077
              TabOrder = 0
              OnClick = CheckViewDelClick
            end
          end
          object Panel6: TPanel
            Left = 1
            Top = 1
            Width = 331
            Height = 480
            Align = alClient
            Caption = 'Panel6'
            TabOrder = 1
            ExplicitHeight = 460
            object Splitter2: TSplitter
              Left = 1
              Top = 254
              Width = 329
              Height = 5
              Cursor = crVSplit
              Align = alBottom
              Beveled = True
              Color = clSkyBlue
              ParentColor = False
              ExplicitLeft = 13
              ExplicitTop = 208
              ExplicitWidth = 438
            end
            object Panel16: TPanel
              Left = 1
              Top = 1
              Width = 329
              Height = 253
              Align = alClient
              BevelOuter = bvNone
              Caption = 'Panel16'
              TabOrder = 0
              ExplicitHeight = 233
              object DBGrid1: TDBGrid
                Left = 0
                Top = 0
                Width = 329
                Height = 253
                Align = alClient
                BorderStyle = bsNone
                DataSource = DSSQLCode
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
                ParentFont = False
                ReadOnly = True
                TabOrder = 0
                TitleFont.Charset = DEFAULT_CHARSET
                TitleFont.Color = clWindowText
                TitleFont.Height = -11
                TitleFont.Name = 'MS Sans Serif'
                TitleFont.Style = []
                OnDrawColumnCell = DBGrid1DrawColumnCell
                OnKeyUp = DBGrid1KeyUp
                OnMouseMove = DBGrid1MouseMove
                OnMouseUp = DBGrid1MouseUp
                Columns = <
                  item
                    Expanded = False
                    FieldName = 'STATE'
                    Title.Alignment = taCenter
                    Title.Caption = #1057
                    Width = 15
                    Visible = True
                  end
                  item
                    Expanded = False
                    FieldName = 'KN'
                    Title.Alignment = taCenter
                    Title.Caption = #1050#1086#1076' SQL'
                    Visible = True
                  end
                  item
                    Expanded = False
                    FieldName = 'COMMENT'
                    Title.Alignment = taCenter
                    Title.Caption = #1050#1086#1084#1084#1077#1085#1090#1072#1088#1080#1081
                    Width = 300
                    Visible = True
                  end
                  item
                    Expanded = False
                    FieldName = 'CHANGE_DATE'
                    Title.Alignment = taCenter
                    Title.Caption = #1055#1086#1089#1083#1077#1076#1085#1103#1103' '#1088#1077#1076#1072#1082#1094#1080#1103
                    Width = 120
                    Visible = True
                  end
                  item
                    Expanded = False
                    FieldName = 'ID'
                    Visible = True
                  end>
              end
            end
            object Panel8: TPanel
              Left = 1
              Top = 259
              Width = 329
              Height = 220
              Align = alBottom
              Caption = 'Panel8'
              TabOrder = 1
              ExplicitTop = 239
              object Panel9: TPanel
                Left = 1
                Top = 1
                Width = 327
                Height = 33
                Align = alTop
                BevelInner = bvLowered
                BevelOuter = bvSpace
                TabOrder = 0
                DesignSize = (
                  327
                  33)
                object SpeedButton17: TSpeedButton
                  Left = 5
                  Top = 6
                  Width = 23
                  Height = 22
                  Caption = 'Clr'
                  Flat = True
                  OnClick = SpeedButton17Click
                end
                object Edit1: TEdit
                  Left = 30
                  Top = 6
                  Width = 292
                  Height = 21
                  Anchors = [akLeft, akTop, akRight]
                  BevelInner = bvNone
                  BevelOuter = bvNone
                  BorderStyle = bsNone
                  Ctl3D = False
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clNavy
                  Font.Height = -13
                  Font.Name = 'MS Sans Serif'
                  Font.Style = [fsBold]
                  ParentCtl3D = False
                  ParentFont = False
                  TabOrder = 0
                end
              end
              object Panel11: TPanel
                Left = 1
                Top = 34
                Width = 327
                Height = 91
                Align = alTop
                BevelOuter = bvNone
                TabOrder = 1
                DesignSize = (
                  327
                  91)
                object Label10: TLabel
                  Left = 15
                  Top = 60
                  Width = 65
                  Height = 13
                  Caption = #1055#1086#1080#1089#1082' '#1087#1086' KN'
                end
                object SpeedButton20: TSpeedButton
                  Left = 247
                  Top = 55
                  Width = 57
                  Height = 22
                  Anchors = [akTop, akRight]
                  Caption = #1053#1072#1081#1090#1080
                  Flat = True
                  OnClick = SpeedButton20Click
                end
                object Panel10: TPanel
                  Left = 5
                  Top = -5
                  Width = 321
                  Height = 49
                  Anchors = []
                  BevelOuter = bvNone
                  Caption = 'Panel10'
                  TabOrder = 0
                  DesignSize = (
                    321
                    49)
                  object Panel17: TPanel
                    Left = 37
                    Top = 7
                    Width = 269
                    Height = 36
                    Anchors = []
                    BevelInner = bvLowered
                    BevelOuter = bvSpace
                    TabOrder = 0
                    object SpeedButton14: TSpeedButton
                      Left = 2
                      Top = 2
                      Width = 89
                      Height = 32
                      Caption = #1044#1086#1073#1072#1074#1080#1090#1100
                      Enabled = False
                      Flat = True
                      OnClick = SpeedButton14Click
                      OnMouseMove = SpeedButton14MouseMove
                    end
                    object SpeedButton15: TSpeedButton
                      Left = 180
                      Top = 2
                      Width = 87
                      Height = 32
                      Caption = #1059#1076#1072#1083#1080#1090#1100
                      Enabled = False
                      Flat = True
                      OnClick = SpeedButton15Click
                      OnMouseMove = SpeedButton15MouseMove
                    end
                    object SpeedButton16: TSpeedButton
                      Left = 91
                      Top = 2
                      Width = 89
                      Height = 32
                      Caption = #1048#1079#1084#1077#1085#1080#1090#1100
                      Enabled = False
                      Flat = True
                      OnClick = SpeedButton16Click
                      OnMouseMove = SpeedButton16MouseMove
                    end
                  end
                  object CheckBox1: TCheckBox
                    Left = 10
                    Top = 16
                    Width = 15
                    Height = 17
                    Anchors = [akLeft]
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
                object FindEdit: TEdit
                  Left = 83
                  Top = 56
                  Width = 156
                  Height = 21
                  Anchors = [akLeft, akTop, akRight]
                  TabOrder = 1
                  OnKeyDown = FindEditKeyDown
                end
              end
              object Memo3: TMemo
                Left = 1
                Top = 125
                Width = 327
                Height = 94
                Align = alClient
                BevelInner = bvNone
                BevelOuter = bvNone
                BorderStyle = bsNone
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clNavy
                Font.Height = -13
                Font.Name = 'MS Sans Serif'
                Font.Style = [fsBold]
                ParentFont = False
                ScrollBars = ssVertical
                TabOrder = 2
              end
            end
          end
          object Panel7: TPanel
            Left = 332
            Top = 1
            Width = 216
            Height = 480
            Align = alRight
            TabOrder = 2
            ExplicitHeight = 460
            object GroupBox1: TGroupBox
              Left = 1
              Top = 1
              Width = 214
              Height = 109
              Align = alTop
              Caption = #1043#1088#1091#1087#1087#1072
              Ctl3D = True
              ParentCtl3D = False
              TabOrder = 0
              object CheckListBox1: TCheckListBox
                Left = 2
                Top = 15
                Width = 183
                Height = 92
                OnClickCheck = CheckListBox1ClickCheck
                Align = alLeft
                BevelInner = bvSpace
                BevelOuter = bvNone
                BevelKind = bkFlat
                Columns = 1
                ItemHeight = 13
                TabOrder = 0
                OnEnter = CheckListBox1Enter
              end
              object Panel15: TPanel
                Left = 185
                Top = 15
                Width = 27
                Height = 92
                Align = alLeft
                BevelInner = bvLowered
                BevelOuter = bvSpace
                TabOrder = 1
                object SpeedButton2: TSpeedButton
                  Left = 2
                  Top = 2
                  Width = 23
                  Height = 22
                  Caption = 'Ad'
                  Flat = True
                  OnClick = SpeedButton2Click
                end
                object SpeedButton3: TSpeedButton
                  Left = 2
                  Top = 24
                  Width = 23
                  Height = 22
                  Caption = 'De'
                  Flat = True
                  OnClick = SpeedButton3Click
                end
                object SpeedButton4: TSpeedButton
                  Left = 2
                  Top = 46
                  Width = 23
                  Height = 22
                  Caption = 'Gr'
                  Flat = True
                  OnClick = SpeedButton4Click
                end
                object SpeedButton5: TSpeedButton
                  Left = 2
                  Top = 68
                  Width = 23
                  Height = 22
                  Caption = 'Us'
                  Flat = True
                  OnClick = SpeedButton5Click
                end
              end
            end
            object GroupBox2: TGroupBox
              Left = 1
              Top = 110
              Width = 214
              Height = 369
              Align = alClient
              Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1099
              TabOrder = 1
              ExplicitHeight = 349
              DesignSize = (
                214
                369)
              object Label2: TLabel
                Left = 16
                Top = 55
                Width = 25
                Height = 13
                Caption = #1056#1086#1083#1100
              end
              object Label3: TLabel
                Left = 16
                Top = 95
                Width = 37
                Height = 13
                Caption = #1042#1077#1088#1089#1080#1103
              end
              object Label4: TLabel
                Left = 16
                Top = 135
                Width = 34
                Height = 13
                Caption = #1057#1090#1072#1090#1091#1089
              end
              object SpeedButton13: TSpeedButton
                Left = 17
                Top = 175
                Width = 168
                Height = 26
                Caption = #1055#1077#1088#1077#1085#1077#1089#1090#1080' '#1074' '#1058#1077#1089#1090' '#1079#1072#1087#1088#1086#1089#1072
                Flat = True
                OnClick = SpeedButton13Click
              end
              object Label5: TLabel
                Left = 16
                Top = 16
                Width = 115
                Height = 13
                Caption = #1055#1086#1089#1083#1077#1076#1085#1077#1077' '#1080#1079#1084#1077#1085#1077#1085#1080#1077
              end
              object DBLookupComboBox1: TDBLookupComboBox
                Left = 15
                Top = 69
                Width = 178
                Height = 21
                Anchors = [akLeft, akTop, akRight]
                BevelInner = bvSpace
                BiDiMode = bdLeftToRight
                Ctl3D = True
                DropDownRows = 10
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = [fsBold]
                KeyField = 'ID'
                ListField = 'NAME'
                ListSource = DSRoles
                ParentBiDiMode = False
                ParentCtl3D = False
                ParentFont = False
                TabOrder = 0
              end
              object Memo2: TMemo
                Left = 16
                Top = 208
                Width = 177
                Height = 156
                Anchors = [akLeft, akTop, akBottom]
                Color = clBtnFace
                Ctl3D = False
                Lines.Strings = (
                  ' '#1057#1090#1072#1090#1091#1089' SQL '#1079#1072#1087#1088#1086#1089#1072':'
                  ' -2 - Deleted'
                  ' -1 - Delete'
                  '  0 - Active = False'
                  '  1 - Active = True'
                  '  2 - Edit'
                  '  3 - Insert')
                ParentCtl3D = False
                ReadOnly = True
                TabOrder = 1
                ExplicitHeight = 136
              end
              object Edit2: TEdit
                Left = 16
                Top = 109
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
              object Edit3: TEdit
                Left = 16
                Top = 149
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
              object Edit4: TEdit
                Left = 16
                Top = 30
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
            end
          end
        end
      end
      object TabSheet1: TTabSheet
        Caption = #1058#1077#1089#1090' '#1079#1072#1087#1088#1086#1089#1072
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        ExplicitHeight = 558
        object panEx: TPanel
          Left = 0
          Top = 0
          Width = 568
          Height = 578
          Align = alClient
          BevelOuter = bvNone
          Caption = 'panEx'
          TabOrder = 0
          ExplicitHeight = 558
          object Splitter3: TSplitter
            Left = 0
            Top = 347
            Width = 568
            Height = 5
            Cursor = crVSplit
            Align = alBottom
            Color = clSkyBlue
            ParentColor = False
            ExplicitTop = 309
            ExplicitWidth = 677
          end
          object DBGrid2: TDBGrid
            Left = 0
            Top = 0
            Width = 568
            Height = 347
            Align = alClient
            BorderStyle = bsNone
            DataSource = DSExplorer
            Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
            TabOrder = 0
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'MS Sans Serif'
            TitleFont.Style = []
          end
          object ed_sql_txt: TMemo
            Left = 0
            Top = 352
            Width = 568
            Height = 111
            Align = alBottom
            BorderStyle = bsNone
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clNavy
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            HideSelection = False
            ParentFont = False
            ParentShowHint = False
            ScrollBars = ssVertical
            ShowHint = True
            TabOrder = 1
            OnChange = ed_sql_txtChange
            ExplicitTop = 332
          end
          object panBtEx: TPanel
            Left = 0
            Top = 463
            Width = 568
            Height = 115
            Align = alBottom
            BevelInner = bvLowered
            BevelOuter = bvSpace
            Caption = 'panBtEx'
            TabOrder = 2
            ExplicitTop = 443
            DesignSize = (
              568
              115)
            object SpeedButton12: TSpeedButton
              Left = 576
              Top = 16
              Width = 23
              Height = 22
              Visible = False
            end
            object Panel18: TPanel
              Left = 48
              Top = 13
              Width = 465
              Height = 91
              Anchors = []
              BevelOuter = bvNone
              Caption = 'Panel18'
              TabOrder = 0
              DesignSize = (
                465
                91)
              object GroupBox4: TGroupBox
                Left = 20
                Top = 8
                Width = 384
                Height = 73
                Anchors = []
                Caption = #1059#1087#1088#1072#1074#1083#1077#1085#1080#1077
                TabOrder = 0
                object SpeedButton8: TSpeedButton
                  Left = 82
                  Top = 14
                  Width = 40
                  Height = 25
                  Caption = 'Up'
                  Enabled = False
                  OnClick = SpeedButton8Click
                end
                object SpeedButton9: TSpeedButton
                  Left = 82
                  Top = 38
                  Width = 40
                  Height = 25
                  Caption = 'Down'
                  Enabled = False
                  OnClick = SpeedButton9Click
                end
                object SpeedButton10: TSpeedButton
                  Left = 121
                  Top = 14
                  Width = 60
                  Height = 49
                  Caption = 'Commit'
                  Enabled = False
                  OnClick = SpeedButton10Click
                end
                object SpeedButton11: TSpeedButton
                  Left = 180
                  Top = 14
                  Width = 60
                  Height = 49
                  Caption = 'Rollback'
                  Enabled = False
                  OnClick = SpeedButton11Click
                end
                object SpeedButton7: TSpeedButton
                  Left = 239
                  Top = 14
                  Width = 60
                  Height = 49
                  Caption = 'Execute'
                  OnClick = SpeedButton7Click
                end
              end
              object GroupBox3: TGroupBox
                Left = 349
                Top = 8
                Width = 92
                Height = 73
                Anchors = []
                Caption = #1052#1077#1090#1086#1076
                TabOrder = 1
                object rbSQL: TRadioButton
                  Left = 24
                  Top = 16
                  Width = 57
                  Height = 17
                  Caption = 'SQL'
                  Checked = True
                  TabOrder = 0
                  TabStop = True
                end
                object rbDML: TRadioButton
                  Left = 24
                  Top = 40
                  Width = 57
                  Height = 17
                  Caption = 'DML'
                  TabOrder = 1
                end
              end
            end
          end
          object Memo1: TMemo
            Left = 32
            Top = 120
            Width = 577
            Height = 89
            TabOrder = 3
            Visible = False
          end
        end
        object panEnv: TPanel
          Left = 568
          Top = 0
          Width = 216
          Height = 578
          Align = alRight
          BevelOuter = bvNone
          Caption = 'panEnv'
          TabOrder = 1
          ExplicitHeight = 558
        end
      end
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 631
    Width = 792
    Height = 19
    Panels = <
      item
        Width = 50
      end
      item
        Width = 50
      end
      item
        Text = #1043#1088#1091#1087#1087': '
        Width = 100
      end
      item
        Text = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1077#1081': '
        Width = 150
      end
      item
        Style = psOwnerDraw
        Text = #1048#1089#1090#1086#1095#1085#1080#1082' '#1055#1091#1083#1072': '
        Width = 50
      end>
    OnDrawPanel = StatusBar1DrawPanel
    ExplicitTop = 611
  end
  object MainMenu1: TMainMenu
    Left = 120
    Top = 200
    object Update1: TMenuItem
      Caption = #1054#1073#1085#1086#1074#1083#1077#1085#1080#1077
      object Send1: TMenuItem
        AutoHotkeys = maManual
        Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
        ShortCut = 116
        OnClick = Send1Click
      end
      object Receive1: TMenuItem
        AutoHotkeys = maManual
        Caption = #1054#1073#1085#1086#1074#1080#1090#1100
        ShortCut = 117
        OnClick = Receive1Click
      end
    end
    object Pool1: TMenuItem
      Caption = #1055#1091#1083' '#1082#1083#1102#1095#1077#1081
      Enabled = False
      object GetPool1: TMenuItem
        Caption = #1055#1086#1083#1091#1095#1080#1090#1100' '#1082#1083#1102#1095#1080'...'
        OnClick = GetPool1Click
      end
      object SetPool1: TMenuItem
        Caption = #1042#1077#1088#1085#1091#1090#1100' '#1082#1083#1102#1095#1080' '#1074' '#1073#1072#1079#1091
        OnClick = SetPool1Click
      end
    end
    object Exit1: TMenuItem
      Caption = #1042#1099#1093#1086#1076
      OnClick = Exit1Click
    end
  end
  object ImList: TImageList
    DrawingStyle = dsSelected
    Left = 16
    Top = 144
    Bitmap = {
      494C010102000400040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FAFAFAFFF4F4F4FFF4F4F4FFFAFAFAFF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000F3F3F3FFCFCFCFFFD6AF89FED8AC81FED2AC86FEB8B8B8FFD1D1D1FFF3F3
      F3FF0000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0080808000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000E7E7
      E7FFFFBD75FFCF400DFFD96539FFDF7D56FFE9A07BFFFCE3BDFFF7B46DFEB4B4
      B4FFE7E7E7FF00000000000000000000000000000000FFFFFF00EFF7EF009F87
      6F00BFAF8F00BFAF8F00BFAF8F00BFAF8F00BFAF8F00BFAF8F00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0080808000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000EDE8E3FFFCD1
      9EFFFFEDC8FFFFF5DCFFFFFAEEFFFFFCF4FFFFF7E5FFFFF2D2FFFDE2B9FFFAC6
      8FFFB6B0ABFFEDEDEDFF000000000000000000000000FFFFFF00EFF7EF009F87
      6F009F876F00BFAF8F00BFAF8F00BFAF8F00BFAF8F00BFAF8F00BFAF8F00BFAF
      8F00BFAF8F00FFFFFF0080808000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FCFCFCFFEF9E63FFF8CA
      A1FFFFECC7FFFFF5DCFFFFFAEDFFFFFCF3FFFFF7E4FFFFF2D2FFFDE1B9FFF9CC
      9CFFF9B26FFFC1C1C1FFFCFCFCFF0000000000000000FFFFFF00EFEFEF009F87
      6F009F876F00BFAF8F00BFAF8F00BFAF8F00BFAF8F00BFAF8F00BFAF8F00BFAF
      8F00BFAF8F00FFFFFF0080808000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000F4DAB8FECC3400FFFAD2
      A4FFFDE5BEFFFFF2D2FFFFF6DFFFFFF6E1FFF9DCBFFFFFEEC9FFFBD7ADFFF2B3
      81FFDB622DFFD4A87CFEEBEBEBFF0000000000000000FFFFFF00EFE7EF009F87
      6F009F876F00BFAF8F00BFAF8F00BFAF8F00BFAF8F00BFAF8F00BFAF8F00BFAF
      8F00BFAF8F00FFFFFF0080808000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000E99055FFD44A11FFE47A
      3FFFFBD6ABFFFEE7C0FFFFEFCCFFFFF0CEFFE16C2AFFD9571BFFF7C798FFF4B0
      7FFFCC3400FFF5994FFFD6D6D6FF0000000000000000FFFFFF00DFE7DF009F87
      6F009F876F00BFAF8F00BFAF8F00BFAF8F00BFAF8F00BFAF8F00BFAF8F00BFAF
      8F00BFAF8F00FFFFFF0080808000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000DE6326FFE3712EFFEB88
      3FFFF7BA7DFFFEECC7FFFFEEC9FFFFEEC9FFFFA851FFFDA54FFFE3702FFFF0A1
      6CFFEA894EFFEF8D49FFC9C9C9FF0000000000000000FFFFFF00DFDFDF009F87
      6F009F876F00CFAF8F00CFAF8F00CFAF8F00CFAF8F00CFAF8F00CFAF8F00CFAF
      8F00CFAF8F00FFFFFF0080808000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000E3712EFFED8E43FFFDBB
      54FFFFEBBFFFFFF1D1FFFFF2D3FFFFF2D3FFFFB362FFFFAA54FFFFA851FFF9A8
      63FFDB5920FFDC5B1DFFC9C9C9FF0000000000000000FFFFFF00DFD7DF00DFDF
      DF00DFDFDF009F876F00CFAF8F00CFAF8F00CFAF8F00CFAF8F00CFAF8F00CFAF
      8F00CFAF8F00FFFFFF0080808000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000EB8137FFF8B360FFFFEF
      CAFFFFF3D5FFFFF4DAFFFFD290FFFFCF8BFFFFC67EFFFFB96BFFFFAA55FFFFA8
      51FFD9591FFFD5470BFFD4D4D4FF0000000000000000FFFFFF00CFD7CF00DFE7
      DF00EFEFEF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0080808000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000F4B272FFFFDBA7FFFFF3
      D6FFFFF5DDFFFFF3D7FFFFE6AFFFFFE2A9FFFFD798FFFFC780FFFFB666FFFFA8
      51FFF59343FFED7C2EFFE9E9E9FF0000000000000000FFFFFF00AFAFAF00AFA7
      AF009F9F9F009F9F9F00FFFFFF00FFFFFF00FFFFFF00F9F9F900B7987900B798
      7900B7987900FFFFFF0080808000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FCFCECFEFFC074FFFFF4
      DBFFFFF7E3FFFFF9E9FFFFFAE9FFFFF5C7FFFFE7B4FFFFDBA5FFFFBE72FFFFAA
      55FFF49142FFE0B07FFEFBFBFBFF000000000000000000000000FFFFFF00EFEF
      EF00FFFFFF008F8F8F00EFF7EF00EFEFEF00EFEFEF00EFEFEF00A78B6F00A78B
      6F00A78B6F00EFEFEF0080808000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000F7B882FFFFD6
      97FFFFF1CEFFFFFAEFFFFFFCF6FFFFFED9FFFFECB8FFFFD798FFFFC279FFFFAD
      59FFEE7F31FFEBEBEBFF0000000000000000000000000000000000000000FFFF
      FF00EFEFEF009F9F9F00DFDFDF00DFE7DF00DFE7DF00E5E5E500977D6400977D
      6400977D6400DFE7DF0080808000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FDFDFAFFFCDA
      ACFFFFE9B3FFFFFCD0FFFFFFE4FFFFFDD1FFFFEAB5FFFFD696FFFFC177FFF8A6
      5EFFE4DFDAFF0000000000000000000000000000000000000000000000000000
      0000FFFFFF009F979F00CFD7CF00CFD7CF00CFD7CF00CFD7CF00CFD7CF00CFD7
      CF00CFD7CF00CFD7CF0080808000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFE
      FBFFFAD3A2FFDFD9CAFFFFE1ABFFFFF5E1FFFFE9C0FFFED6A1FFF59A4FFFF1EC
      E6FF000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF00EFF7EF00EFF7EF00EFEFEF00EFEFEF00DFE7DF00DFE7
      DF00DFDFDF00DFDFDF00DFDFDF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FDFAF3FFF9E6C4FEFAD9A8FEF6D8B2FEF7F0E6FFFEFEFEFF0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF00FC3FFFFF00000000F00F800100000000
      E007800100000000C00380010000000080018001000000008001800100000000
      8001800100000000800180010000000080018001000000008001800100000000
      80018001000000008001C00100000000C003E00100000000C007F00100000000
      E00FF80100000000F81FFFFF0000000000000000000000000000000000000000
      000000000000}
  end
  object ApplicationEvents: TApplicationEvents
    Left = 16
    Top = 184
  end
  object OpenDlg: TOpenDialog
    FileName = 'C:\back\backup_09022007_112329.cds'
    Filter = 'Import Base (*.cds)|*.cds'
    Options = [ofHideReadOnly, ofExtensionDifferent, ofEnableSizing]
    Left = 16
    Top = 264
  end
  object SaveDlg: TSaveDialog
    Filter = 'Export Base (*.cds)|*.cds'
    FilterIndex = 2
    Options = [ofHideReadOnly, ofExtensionDifferent, ofEnableSizing]
    Left = 16
    Top = 304
  end
  object Session1: TSession
    Active = True
    AutoSessionName = True
    Left = 40
    Top = 336
  end
  object qEx: TQuery
    DatabaseName = 'ExDataBase'
    SessionName = 'Session1_1'
    Left = 80
    Top = 368
  end
  object cds_txt: TClientDataSet
    Aggregates = <>
    Params = <
      item
        DataType = ftUnknown
        ParamType = ptUnknown
      end>
    Left = 80
    Top = 336
  end
  object dsEx: TDataSource
    DataSet = qEx
    Left = 120
    Top = 368
  end
  object pop_tree: TPopupMenu
    Left = 152
    Top = 200
    object N1: TMenuItem
      Caption = #1056#1077#1076#1072#1082#1090#1086#1088' '#1073#1083#1086#1082#1086#1074
      OnClick = N1Click
    end
    object N2: TMenuItem
      Caption = #1056#1072#1079#1074#1077#1088#1085#1091#1090#1100
      GroupIndex = 1
      OnClick = N2Click
    end
    object N3: TMenuItem
      Caption = #1057#1074#1077#1088#1085#1091#1090#1100
      GroupIndex = 1
      OnClick = N3Click
    end
  end
  object ClientDataSet5: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'DataSetProvider5'
    Left = 240
    Top = 208
  end
  object DataSetProvider5: TDataSetProvider
    DataSet = Query11
    Left = 280
    Top = 208
  end
  object Query10: TQuery
    DatabaseName = 'myTEXTSQL'
    SessionName = 'Session1_1'
    Left = 288
    Top = 152
  end
  object Query11: TQuery
    DatabaseName = 'myTEXTSQL'
    SessionName = 'Session1_1'
    SQL.Strings = (
      'select * from sql_bloks')
    Left = 320
    Top = 208
  end
  object Query6: TQuery
    SessionName = 'Session1_1'
    Left = 328
    Top = 152
  end
  object Query1: TQuery
    DatabaseName = 'myTEXTSQL'
    SessionName = 'Session1_1'
    SQL.Strings = (
      'select * from SQL_BLOKS where (STATE>0) order by hi_id')
    Left = 360
    Top = 152
  end
  object QSQL: TQuery
    DatabaseName = 'myTEXTSQL'
    SessionName = 'Session1_1'
    SQL.Strings = (
      'select * from SQL_CODES')
    Left = 416
    Top = 208
  end
  object DSSQL: TDataSource
    DataSet = QSQL
    Left = 464
    Top = 208
  end
  object Query8: TQuery
    DatabaseName = 'myTEXTSQL'
    SessionName = 'Session1_1'
    SQL.Strings = (
      'select * FROM user_groups where (state > 0) order by name')
    Left = 416
    Top = 88
  end
  object Query9: TQuery
    DatabaseName = 'myTEXTSQL'
    SessionName = 'Session1_1'
    SQL.Strings = (
      'select * from SQL_CODES')
    Left = 416
    Top = 48
  end
  object DataSource2: TDataSource
    DataSet = Query8
    Left = 464
    Top = 88
  end
  object DataSetProvider4: TDataSetProvider
    DataSet = Query9
    Left = 464
    Top = 48
  end
  object ClientDataSet3: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'DataSetProvider4'
    Left = 512
    Top = 48
  end
  object ClientDataSet4: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'DataSetProvider4'
    Left = 512
    Top = 16
  end
  object DataSource6: TDataSource
    DataSet = ClientDataSet3
    Left = 556
    Top = 48
  end
  object Query5: TQuery
    DatabaseName = 'myTEXTSQL'
    SessionName = 'Session1_1'
    SQL.Strings = (
      'select * from roles')
    Left = 128
    Top = 484
  end
  object DataSource4: TDataSource
    DataSet = Query5
    Left = 160
    Top = 484
  end
  object Query2: TQuery
    DatabaseName = 'myTEXTSQL'
    SessionName = 'Session1_1'
    Left = 192
    Top = 412
  end
  object DataSource1: TDataSource
    DataSet = Query2
    Left = 232
    Top = 420
  end
  object QFindKN: TQuery
    DatabaseName = 'myTEXTSQL'
    SessionName = 'Session1_1'
    SQL.Strings = (
      'select * from sql_codes where kn = :kn')
    Left = 335
    Top = 404
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'kn'
        ParamType = ptUnknown
      end>
  end
  object DSFindKN: TDataSource
    DataSet = QFindKN
    Left = 367
    Top = 404
  end
  object QPoolOperation: TQuery
    DatabaseName = 'myTEXTSQL'
    SessionName = 'Session1_1'
    Left = 206
    Top = 500
  end
  object QUpdate: TQuery
    DatabaseName = 'myTEXTSQL'
    SessionName = 'Session1_1'
    Left = 238
    Top = 500
  end
  object QValid: TQuery
    DatabaseName = 'myTEXTSQL'
    SessionName = 'Session1_1'
    Left = 238
    Top = 468
  end
  object QRoleGroup: TQuery
    DatabaseName = 'myTEXTSQL'
    SessionName = 'Session1_1'
    Left = 270
    Top = 468
  end
  object QWhatBase: TQuery
    DatabaseName = 'myTEXTSQL'
    SessionName = 'Session1_1'
    Left = 270
    Top = 500
  end
  object QCode: TQuery
    DatabaseName = 'myTEXTSQL'
    SessionName = 'Session1_1'
    Left = 302
    Top = 500
  end
  object QStack: TQuery
    DatabaseName = 'myTEXTSQL'
    SessionName = 'Session1_1'
    Left = 302
    Top = 468
  end
  object QOperation: TQuery
    DatabaseName = 'myTEXTSQL'
    SessionName = 'Session1_1'
    Left = 334
    Top = 468
  end
  object QUser: TQuery
    DatabaseName = 'myTEXTSQL'
    SessionName = 'Session1_1'
    Left = 334
    Top = 500
  end
  object QBlock: TQuery
    DatabaseName = 'myTEXTSQL'
    SessionName = 'Session1_1'
    Left = 366
    Top = 500
  end
  object QGetGroup: TQuery
    DatabaseName = 'myTEXTSQL'
    SessionName = 'Session1_1'
    Left = 366
    Top = 468
  end
  object QViewOperation: TQuery
    DatabaseName = 'myTEXTSQL'
    SessionName = 'Session1_1'
    SQL.Strings = (
      'select * from operations where (state >  0) order by name')
    Left = 414
    Top = 380
  end
  object QViewRole: TQuery
    DatabaseName = 'myTEXTSQL'
    SessionName = 'Session1_1'
    SQL.Strings = (
      'select * from ROLES order  by  ID')
    Left = 414
    Top = 420
  end
  object q_last: TQuery
    DatabaseName = 'myTEXTSQL'
    SessionName = 'Session1_1'
    SQL.Strings = (
      'select * from SQL_BLOKS where (STATE>0) order by hi_id'
      '')
    Left = 414
    Top = 460
  end
  object QViewUser: TQuery
    DatabaseName = 'myTEXTSQL'
    SessionName = 'Session1_1'
    SQL.Strings = (
      'select * from users where (state>0 ) order by name')
    Left = 414
    Top = 500
  end
  object DSViewOperation: TDataSource
    DataSet = QViewOperation
    Left = 446
    Top = 380
  end
  object DSViewRole: TDataSource
    DataSet = QViewRole
    Left = 446
    Top = 420
  end
  object ds_last: TDataSource
    DataSet = q_last
    Left = 446
    Top = 460
  end
  object DSViewUser: TDataSource
    DataSet = QViewUser
    Left = 446
    Top = 500
  end
  object CDSSQLCode: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 688
    Top = 8
  end
  object DSSQLCode: TDataSource
    DataSet = CDSSQLCode
    OnDataChange = DSSQLCodeDataChange
    Left = 720
    Top = 8
  end
  object CDSRules: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 688
    Top = 40
  end
  object CDSRoles: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 632
    Top = 224
  end
  object DSRoles: TDataSource
    DataSet = CDSRoles
    Left = 664
    Top = 224
  end
  object CDSGroups: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 632
    Top = 256
  end
  object DSGroups: TDataSource
    DataSet = CDSGroups
    Left = 664
    Top = 256
  end
  object CDSUsers: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 632
    Top = 288
  end
  object DSUsers: TDataSource
    DataSet = CDSUsers
    Left = 664
    Top = 288
  end
  object CDSOperations: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 632
    Top = 320
  end
  object DSOperations: TDataSource
    DataSet = CDSOperations
    Left = 664
    Top = 320
  end
  object CDSExplorer: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 632
    Top = 192
  end
  object DSExplorer: TDataSource
    DataSet = CDSExplorer
    Left = 664
    Top = 192
  end
  object CDSUpdate: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 640
    Top = 544
  end
  object CDSLoadUpdate: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 608
    Top = 544
  end
  object Timer2: TTimer
    Enabled = False
    Interval = 5000
    OnTimer = Timer2Timer
    Left = 520
    Top = 152
  end
  object CDSOpRules: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 464
    Top = 584
  end
end
