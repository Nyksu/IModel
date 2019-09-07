object SDM: TSDM
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 300
  Width = 297
  object IB_BKP: TIBBackupService
    Protocol = TCP
    LoginPrompt = False
    TraceFlags = []
    BlockingFactor = 0
    Options = []
    Left = 128
    Top = 16
  end
  object tmr_bakup: TTimer
    Enabled = False
    Interval = 10800000
    OnTimer = tmr_bakupTimer
    Left = 208
    Top = 16
  end
end
