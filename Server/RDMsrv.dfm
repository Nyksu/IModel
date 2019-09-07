object RI_Modelserver: TRI_Modelserver
  OldCreateOrder = False
  OnCreate = RemoteDataModuleCreate
  OnDestroy = RemoteDataModuleDestroy
  Height = 512
  Width = 669
  object IBDB: TIBDatabase
    LoginPrompt = False
    DefaultTransaction = IBTrans
    Left = 26
    Top = 8
  end
  object IBTrans: TIBTransaction
    DefaultDatabase = IBDB
    DefaultAction = TARollback
    Left = 26
    Top = 64
  end
  object q_SQL: TIBQuery
    Database = IBDB
    Transaction = IBTrans
    SQL.Strings = (
      'Select * from SQL_CODES'
      'where'
      'KN=:kn'
      'and state>0')
    Left = 26
    Top = 124
    ParamData = <
      item
        DataType = ftString
        Name = 'kn'
        ParamType = ptInput
      end>
  end
  object q_usr_grp: TIBQuery
    Database = IBDB
    Transaction = IBTrans
    SQL.Strings = (
      'Select res from GET_RITE_SQL(:uid,:kn)')
    Left = 28
    Top = 182
    ParamData = <
      item
        DataType = ftInteger
        Name = 'uid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'kn'
        ParamType = ptInput
      end>
  end
  object q_users: TIBQuery
    Database = IBDB
    Transaction = IBTrans
    SQL.Strings = (
      'Select *'
      'from'
      'USERS'
      'where'
      'NIKNAME=:nam'
      'and PSW=:pw')
    Left = 28
    Top = 246
    ParamData = <
      item
        DataType = ftString
        Name = 'nam'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'pw'
        ParamType = ptInput
      end>
  end
  object q_work: TIBQuery
    Database = IBDB
    Transaction = IBTrans
    Left = 98
    Top = 10
  end
  object dsp_work: TDataSetProvider
    DataSet = q_work
    Left = 160
    Top = 14
  end
  object cds_work: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dsp_work'
    Left = 98
    Top = 80
  end
  object cds_teh: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 168
    Top = 78
  end
  object ib_script: TIBScript
    Database = IBDB
    Transaction = IBTrans
    Terminator = ';'
    Left = 120
    Top = 160
  end
  object q_oper_rite: TIBQuery
    Database = IBDB
    Transaction = IBTrans
    SQL.Strings = (
      'Select Count(id) as kvo'
      'from operations'
      'where'
      'kn=:kn'
      'and roles_id>=:rol')
    Left = 32
    Top = 312
    ParamData = <
      item
        DataType = ftString
        Name = 'kn'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'rol'
        ParamType = ptInput
      end>
  end
  object IBDbCalc: TIBDatabase
    LoginPrompt = False
    DefaultTransaction = IBTransCalc
    Left = 590
    Top = 18
  end
  object IBTransCalc: TIBTransaction
    DefaultDatabase = IBDbCalc
    DefaultAction = TARollback
    Left = 586
    Top = 84
  end
  object q_files: TIBQuery
    Database = IBDB
    Transaction = IBTrans
    SQL.Strings = (
      'Select Name, Fbody'
      'from files'
      'where'
      'state=1'
      'and ctype=:ctp')
    Left = 32
    Top = 382
    ParamData = <
      item
        DataType = ftInteger
        Name = 'ctp'
        ParamType = ptInput
      end>
  end
  object timerCalc: TTimer
    Enabled = False
    Interval = 5000
    OnTimer = timerCalcTimer
    Left = 474
    Top = 26
  end
  object q_files_add: TIBQuery
    Database = IBDB
    Transaction = IBTrans
    SQL.Strings = (
      
        'Insert into FILES(ID,NAME,STATE,FTYPE,CTYPE,FBODY,COMMENT,FILESI' +
        'ZE, DATEMAKE)'
      'values (:id, :name, :st, :ft, :ct, :body, :com, :fs, :dm)')
    Left = 96
    Top = 386
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'id'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'name'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'st'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'ft'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'ct'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'body'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'com'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'fs'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'dm'
        ParamType = ptUnknown
      end>
  end
  object q_work_c: TIBQuery
    Database = IBDbCalc
    Transaction = IBTransCalc
    Left = 588
    Top = 158
  end
  object dsp_work_c: TDataSetProvider
    DataSet = q_work_c
    Left = 584
    Top = 226
  end
  object cds_work_c: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dsp_work_c'
    Left = 584
    Top = 296
  end
  object IBExtract: TIBExtract
    Database = IBDB
    Transaction = IBTrans
    Left = 204
    Top = 162
  end
  object q_mapid_c: TIBQuery
    Database = IBDbCalc
    Transaction = IBTransCalc
    SQL.Strings = (
      'Select Count(id) as KVO'
      'from periuds'
      'where '
      'mapid=:map')
    Left = 584
    Top = 360
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'map'
        ParamType = ptUnknown
      end>
  end
  object cds_work_with_me: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 240
    Top = 280
  end
  object q_execute: TIBQuery
    Database = IBDB
    Transaction = IBTrans
    Left = 192
    Top = 400
  end
  object q_calc_ins: TIBQuery
    Database = IBDbCalc
    Transaction = IBTransCalc
    SQL.Strings = (
      'Insert into CALCS (id,moment,comment,mapid,planid,kzunit)'
      'values(:id,:mmt,:com,:map,:plan,:kzu)')
    Left = 496
    Top = 120
    ParamData = <
      item
        DataType = ftInteger
        Name = 'id'
        ParamType = ptInput
      end
      item
        DataType = ftDateTime
        Name = 'mmt'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'com'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'map'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'plan'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'kzu'
        ParamType = ptInput
      end>
  end
  object q_per_ins: TIBQuery
    Database = IBDbCalc
    Transaction = IBTransCalc
    SQL.Strings = (
      'Insert into PERIUDS(id,calcs_id,periud,mapid)'
      'values(:id,:clc,:per,:map)')
    Left = 496
    Top = 192
    ParamData = <
      item
        DataType = ftInteger
        Name = 'id'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'clc'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'per'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'map'
        ParamType = ptInput
      end>
  end
  object q_execute_c: TIBQuery
    Database = IBDbCalc
    Transaction = IBTransCalc
    Left = 496
    Top = 272
  end
  object ib_script_c: TIBScript
    Database = IBDbCalc
    Transaction = IBTransCalc
    Terminator = ';'
    Statistics = False
    Left = 488
    Top = 360
  end
  object q_oper_rt_g: TIBQuery
    Database = IBDB
    Transaction = IBTrans
    SQL.Strings = (
      'Select res from GET_RITE_OPER(:uid,:kn)')
    Left = 100
    Top = 310
    ParamData = <
      item
        DataType = ftInteger
        Name = 'uid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'kn'
        ParamType = ptInput
      end>
  end
  object q_dualset_c: TIBQuery
    Database = IBDbCalc
    Transaction = IBTransCalc
    SQL.Strings = (
      'INSERT INTO DUAL(FF) VALUES (1)')
    Left = 528
    Top = 424
  end
  object timerDelFolder: TTimer
    Enabled = False
    Interval = 25000
    OnTimer = timerDelFolderTimer
    Left = 392
    Top = 128
  end
  object timerRetCalcstate: TTimer
    Enabled = False
    Interval = 120000
    OnTimer = timerRetCalcstateTimer
    Left = 376
    Top = 32
  end
  object q_sum_power: TIBQuery
    Database = IBDB
    Transaction = IBTrans
    SQL.Strings = (
      '')
    Left = 56
    Top = 448
  end
end
