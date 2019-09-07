unit servicemain;

interface

uses
  Windows, Messages, SysUtils, Classes, Registry, SvcMgr, DM;

type
  TModelService = class(TService)
    procedure ServiceDestroy(Sender: TObject);
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
  LgList.Add('GetServicePath. SrvName: '+ServName);
  Reg := TRegistry.Create;
  Reg.RootKey := HKEY_LOCAL_MACHINE;
  Result := '';
  with Reg do
    begin
      try
        OpenKey('System\CurrentControlSet\Services\'+ServName, False);
        Result := ReadString('ImagePath');
        LgList.Add('GetServicePath. Result: '+Result);
        CloseKey;
      except
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

procedure TModelService.ServiceCreate(Sender: TObject);
var
  ss : string;
begin
//     проверено. мин нет! :)
  service_flag:=false;
  LgList:=TStringList.Create;
  DecimalSeparator := '.';
  THOUSANDSEPARATOR := #0;
  DateSeparator := '.';
  ss:=GetServicePath(Sender);
  LgList.Add('ServiceCreate. Service Name: '+ss);
  StartDM(ss);
end;

procedure TModelService.ServiceDestroy(Sender: TObject);
begin
  LgList.SaveToFile('syslogmodel.txt');
  LgList.Free;
  CloiseDM;
end;

end.
