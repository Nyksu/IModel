program modelserver;

{%TogetherDiagram 'ModelSupport_modelserver\default.txaPackage'}

uses
  SvcMgr {: CoClass},
  servicemain in 'servicemain.pas' {ModelService: TService},
  modelserver_TLB in 'modelserver_TLB.pas',
  RDMsrv in 'RDMsrv.pas' {RI_Modelserver: TRemoteDataModule} {RI_Modelserver: CoClass},
  SLib in 'SLib.pas',
  StrUtils1 in 'StrUtils1.pas',
  Formula in 'Formula.pas',
  IniStrings in 'IniStrings.pas',
  BusyUnit in 'BusyUnit.pas',
  DCPrijndael in '..\Lib\DCPrijndael.pas',
  DCPbase64 in '..\Lib\DCPbase64.pas',
  DCPblockciphers in '..\Lib\DCPblockciphers.pas',
  DCPconst in '..\Lib\DCPconst.pas',
  DCPcrypt2 in '..\Lib\DCPcrypt2.pas',
  DCPhaval in '..\Lib\DCPhaval.pas',
  DCPMain in '..\Lib\DCPMain.pas',
  DM in 'DM.pas' {SDM: TDataModule};

{$R *.TLB}

{$R *.RES}

begin
  // Windows 2003 Server requires StartServiceCtrlDispatcher to be
  // called before CoRegisterClassObject, which can be called indirectly
  // by Application.Initialize. TServiceApplication.DelayInitialize allows
  // Application.Initialize to be called from TService.Main (after
  // StartServiceCtrlDispatcher has been called).
  //
  // Delayed initialization of the Application object may affect
  // events which then occur prior to initialization, such as
  // TService.OnCreate. It is only recommended if the ServiceApplication
  // registers a class object with OLE and is intended for use with
  // Windows 2003 Server.
  //
   Application.DelayInitialize := True;
  //
  if not Application.DelayInitialize or Application.Installing then
    Application.Initialize;
  Application.CreateForm(TModelService, ModelService);
  //Application.CreateForm(TSDM, SDM);
  Application.Run;
end.
