unit DMmodel;

interface

uses
  SysUtils, Classes, DB, DBClient, MConnect, Forms, SConnect, Variants, IniFiles;

type
  TDM = class(TDataModule)
    SockTo: TSocketConnection;
    cds_work: TClientDataSet;
    cds_work2: TClientDataSet;
    cds_work3: TClientDataSet;
  private
    { Private declarations }
    
  public
    { Public declarations }
    outpars : variant; // параметры динамическим управлением сервера
    Function TestStatus: variant;
    function GetTehDataN(ksql, params, nams: Variant): Variant;
    function GetTehData(ksql, params: Variant): Variant;
    function GetData(ksql, Params: Variant): Variant;
    function RunSQL(ksql, params: Variant): Variant;
    procedure BackTrans;
    procedure CommTrans;
    procedure StartTrans;
    function GetNextId(gennam : string) : integer;
    function GetLastId : integer;
    procedure ReadINIConfig;
    function TestOperRites(kn : string) : boolean;
  end;

var
  DM: TDM;
  vers : string;
  conn : boolean;
  exepath : string;

Function StartDM : boolean;

Procedure CloseDM;

implementation

{$R *.dfm}

Function StartDM : boolean;
Begin
  Result:=false;
  exepath:=ExtractFilePath(Application.ExeName);
  try
    try
      DM:=TDM.Create(Application);
      DM.outpars:=null;
      DM.ReadINIConfig;
      DM.SockTo.Connected:=true;
      Result:=true;
    finally
    end;
  except
  end;
end;

Procedure CloseDM;
Begin
  DM.SockTo.Connected:=false;
  DM.Free;
end;

procedure TDM.ReadINIConfig;
var
  ss : string;
  ii : integer;
  ini : TIniFile;
Begin
  ini:=TIniFile.Create(exepath+'\model.ini');
  SockTo.Host:=ini.ReadString('SERVER','server','localhost');

  ini.Free;
end;

function TDM.GetTehDataN(ksql, params, nams: Variant): Variant;
Begin  
  Result:=null;
  if not conn then Exit;
  Result:=SockTo.AppServer.GetTehDataN(ksql, Params, nams);
end;

function TDM.GetTehData(ksql, params: Variant): Variant;
Begin  
  Result:=null;
  if not conn then Exit;
  Result:=SockTo.AppServer.GetTehData(ksql, Params);
end;

function TDM.GetData(ksql, Params: Variant): Variant;
Begin
  Result:=null;
  if not conn then Exit;
  Result:=SockTo.AppServer.GetData(ksql, Params);
end;

function TDM.RunSQL(ksql, params: Variant): Variant; 
Begin 
  Result:=null;
  if not conn then Exit;
  Result:=SockTo.AppServer.RunSQL(ksql, Params);
end;

procedure TDM.BackTrans;
Begin  
  if not conn then Exit;
  SockTo.AppServer.BackTrans;
end;

procedure TDM.CommTrans;
Begin 
  if not conn then Exit;
  SockTo.AppServer.CommTrans;
end;

procedure TDM.StartTrans;
Begin
  if not conn then Exit;
  SockTo.AppServer.StartTrans;
end;

function TDM.GetNextId(gennam : string) : integer;
var
  params, res : variant;
Begin
  params:=VarArrayCreate([0, 1], varVariant);
  params[0]:=VarArrayOf(['!GENOM']);
  params[1]:=VarArrayOf([gennam]);
  res:=GetTehData('Nyk140',params);
  if not VarIsNull(res) then Result:=Integer(res);
end;

function TDM.GetLastId : integer;
Begin
  Result:=-1;
  if not conn then Exit;
  Result:=SockTo.AppServer.GetLastId;
end;

function TDM.TestOperRites(kn : string) : boolean;
var
  ii : integer;
  res, params : variant;
Begin
  Result:=false;
  if not conn then Exit;
  //res:=SockTo.AppServer.TestOperRites(kn);
  //res:=SockTo.AppServer.IsOperationRite(kn);

  params:=VarArrayCreate([0, 1], varVariant);
  params[0]:=VarArrayOf(['kn']);
  params[1]:=VarArrayOf(['Nyk234']);
  res:=DM.GetTehData('Nyk235',params); 

  if VarIsNull(res) then ii:=-2 Else ii:=res;
  If ii>0 Then Result:=true;
end;

Function  TDM.TestStatus : variant;
var
  res : Variant;
Begin
  Result:=null;
  if not conn then Exit;
  Result:=SockTo.AppServer.GetStatus(outpars);
  outpars:=null;
end;

end.
