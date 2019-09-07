unit servicemain_tmp;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, SvcMgr, Dialogs, Variants,
  IniFiles, Registry, Sockets, WinSock, ShellApi,Tlhelp32, ExtCtrls, Menus, SyncObjs,
  IBServices, DM;

type
  TModelService = class(TService)
    Tr: TTrayIcon;
    ppm: TPopupMenu;
    close1: TMenuItem;
    CloseInConnection1: TMenuItem;
    IB_BKP: TIBBackupService;
    tmr_bakup: TTimer;
    procedure ServiceDestroy(Sender: TObject);
    procedure ServiceContinue(Sender: TService; var Continued: Boolean);
    procedure ServicePause(Sender: TService; var Paused: Boolean);
    procedure ServiceStop(Sender: TService; var Stopped: Boolean);
    procedure ServiceStart(Sender: TService; var Started: Boolean);
    procedure ServiceExecute(Sender: TService);
    procedure ServiceCreate(Sender: TObject);
  private
    function GetServicePath(Sender: TObject): string;   // остается здесь!
  public
    function GetServiceController: TServiceController; override;
  end;


var
  ModelService: TModelService;

implementation

{$R *.DFM}


function TModelService.GetServicePath(Sender: TObject): string;
var ServName: string;
    Reg: TRegistry;
begin   // оставляем
  ServName := TModelService(Sender).Name;
  Reg := TRegistry.Create;
  Reg.RootKey := HKEY_LOCAL_MACHINE;
  Result := '';
  with Reg do
    begin
      try
        OpenKey('System\CurrentControlSet\Services\'+ServName, False);
        Result := ReadString('ImagePath');
        CloseKey;
      except
        Result := '';
      end;
    end;
  Reg.Free;
end;

procedure ServiceController(CtrlCode: DWord); stdcall;
begin
  ModelService.Controller(CtrlCode);
  if CtrlCode = 1 then service_flag:=true;
  if CtrlCode = 2 then ModelService.DoPause;
  if CtrlCode = 3 then ModelService.DoContinue;
end;

function TModelService.GetServiceController: TServiceController;
begin
  Result := ServiceController;
end;

procedure TModelService.ServiceContinue(Sender: TService;
  var Continued: Boolean);
begin
  Continued:=true;
end;

procedure TModelService.ServiceCreate(Sender: TObject);
begin
  service_flag:=false;
  DecimalSeparator := '.';
  THOUSANDSEPARATOR := #0;
  DateSeparator := '.';
  StartDM(GetServicePath(Sender));
end;

procedure TModelService.ServiceDestroy(Sender: TObject);
begin
  CloiseDM;
end;

procedure TModelService.ServiceExecute(Sender: TService);
var
  ii : integer;
begin
   SDM.hard_close:=false;
   ii:=0;
   ModelService.WaitHint :=5000;
   while service_flag <> true do Begin
      sleep(100);
      Inc(ii);
      if ii>19 Then Begin
         ModelService.ReportStatus();
         ii:=0;
      end;
   end;
end;

procedure TModelService.ServicePause(Sender: TService; var Paused: Boolean);
begin
  Paused:=true;   //     проверено. мин нет! :)
  SDM.SaveLogFile(false);
  if service_flag then ModelService.Status:=csStopped;
  SDM.hard_close:=true;
end;

procedure TModelService.ServiceStart(Sender: TService; var Started: Boolean);
begin
  Started:=true;
   service_flag:=false;     // здесь закончил
   SDM.hard_close:=false;
   SDM.time_close:=0;
   SDM.CalcFlowCount:=0;
   SDM.monopol:=false;
   SDM.resetnom:=0;

   SDM.debugmore:=false;
   SDM.savecalcdirmode:=false;
   SDM.sqlspy:='';

   SDM.ReadConfig;
end;

procedure TModelService.ServiceStop(Sender: TService; var Stopped: Boolean);
begin
  Stopped:=true;
  SDM.hard_close:=true;
  SDM.SaveLogFile(false);
end;


end.
