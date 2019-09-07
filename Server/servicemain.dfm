object ModelService: TModelService
  OldCreateOrder = False
  OnCreate = ServiceCreate
  OnDestroy = ServiceDestroy
  DisplayName = 'RI Model Server'
  ErrorSeverity = esIgnore
  Height = 292
  Width = 311
end
