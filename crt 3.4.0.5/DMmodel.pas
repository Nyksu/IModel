unit DMmodel;

interface

uses
  SysUtils, Classes, DB, DBClient, MConnect, Forms, SConnect, Variants, IniFiles, ComCtrls, StdCtrls;

type
  TDM = class(TDataModule)
    SockTo: TSocketConnection;
    cds_work: TClientDataSet;
    cds_work2: TClientDataSet;
    cds_work3: TClientDataSet;
    CDSSubstation: TClientDataSet;
    CDSWelt: TClientDataSet;
    CDSPlatform: TClientDataSet;
    CDSSwitchover: TClientDataSet;
    CDSBusBarSection: TClientDataSet;
    CDSElectricStation: TClientDataSet;
    CDSPointLoad: TClientDataSet;
    CDSCondenser: TClientDataSet;
    CDSEnginePS: TClientDataSet;
    CDSEnginePA: TClientDataSet;
    CDSEngineKA: TClientDataSet;
    CDSBusBar: TClientDataSet;
    CDSGenerator: TClientDataSet;
    CDSTransformatorSD: TClientDataSet;
    CDSTransformatorST: TClientDataSet;
    CDSAirLine: TClientDataSet;
    CDSCableLine: TClientDataSet;
    CDSWireway: TClientDataSet;
    CDSSwitch: TClientDataSet;
    CDSConnection: TClientDataSet;
    cds_work4: TClientDataSet;
    CDSInstrument: TClientDataSet;
  private
    { Private declarations }
    
  public
    { Public declarations }
    outpars : variant; // параметры динамическим управлением сервера
    Function TestStatus: variant;
    function GetTehDataN(ksql, params, nams: Variant): Variant; overload;
    function GetTehDataN(ksql, params, nams: Variant; actuality : boolean): Variant; overload;
    function GetTehData(ksql, params: Variant): Variant; overload;
    function GetTehData(ksql, params: Variant; actuality : boolean): Variant; overload;
    function GetData(ksql, Params: Variant): Variant; overload;
    function GetData(ksql, Params: Variant; actuality : boolean): Variant; overload;
    function RunSQL(ksql, params: Variant): Variant;
    function RunSQLC(ksql, params: Variant;mapId : integer): Variant;
    function GetDataC(ksql, Params: Variant;mapId : integer): Variant;
    function GetTehDataC(ksql, params: Variant;mapId : integer): Variant;
    function GetTehDataNC(ksql, params, nams: Variant;mapId : integer): Variant;
    procedure BackTrans;
    procedure CommTrans;
    procedure StartTrans;
    procedure BackTransC;
    procedure CommTransC;
    procedure StartTransC;
    function GetNextId(gennam : string) : integer;
    function GetNextIdC(gennam : string;mapId : integer) : integer;
    function GetLastId : integer;
    procedure ReadINIConfig;
    function TestOperRites(kn : string) : boolean;
    function RunScript(kn,script : string) : integer;
    function GetUnicalString(Mno, Spread: Integer): string;

    {}
    function SendFile(par: variant; BufSize: Integer; pgb : TProgressBar; lb : TLabel): Integer;
    // имя файла
    // комментарий
    // тип файла ( 1 или 2 )
    // код расчетного модуля ( для электричества 1 )
    {}
    
    function StreamToVariant(FS: TMemoryStream): OleVariant;
  end;

var
  DM: TDM;
  vers : string;
  conn : boolean;
  exepath : string;

Function StartDM : boolean;

Procedure CloseDM;

implementation
  uses unit1;
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

procedure CloseDM;
begin
  DM.SockTo.Connected := False;
  DM.Free;
end;

function TDM.GetUnicalString(Mno, Spread: Integer): string;
const d = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ';
var i: Integer;
    A, B, C: Integer;
    Code: string;
    DeltaCif: string;
begin
 Code := '';
 DeltaCif := IntToStr(Spread);
 DeltaCif := Copy(DeltaCif, 1, 1);
 Randomize;
 for i := 1 to mno do
    begin
      A := Random(36);
      B := Random(36);
      C := Random(36);
      Code := Code + DeltaCif + Copy(d,A,1) + Copy(d,B,1) + Copy(d,C,1) + DeltaCif;
    end;
 Result := Code;
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
  Result:=SockTo.AppServer.GetTehDataN(ksql, Params, nams, null);
end;

function TDM.GetTehData(ksql, params: Variant): Variant;
Begin
  Result:=null;
  if not conn then Exit;
  Result:=SockTo.AppServer.GetTehData(ksql, Params, null);
end;

function TDM.GetData(ksql, Params: Variant): Variant;
Begin
  Result:=null;
  if not conn then Exit;
  Result:=SockTo.AppServer.GetData(ksql, Params, null);
end;

function TDM.GetTehDataNC(ksql, params, nams: Variant;mapId : integer): Variant;
Begin
  Result:=null;
  if not conn then Exit;
  Result:=SockTo.AppServer.GetTehDataN(ksql, Params, nams, mapId);
end;

function TDM.GetTehDataC(ksql, params: Variant;mapId : integer): Variant;
Begin
  Result:=null;
  if not conn then Exit;
  Result:=SockTo.AppServer.GetTehData(ksql, Params, mapId);
end;

function TDM.GetDataC(ksql, Params: Variant;mapId : integer): Variant;
Begin
  Result:=null;
  if not conn then Exit;
  Result:=SockTo.AppServer.GetData(ksql, Params, mapId);
end;

function TDM.RunSQLC(ksql, params: Variant;mapId : integer): Variant;
Begin 
  Result:=null;
  if not conn then Exit;
  Result:=SockTo.AppServer.RunSQL(ksql, Params, mapId);
end;

function TDM.GetTehData(ksql, params: Variant; actuality : boolean): Variant;
Begin
  Result:=null;
  if not conn then Exit;
  if actuality then Begin
     CommTrans;
     StartTrans;
     Result:=SockTo.AppServer.GetTehData(ksql, Params, null);
     CommTrans;
  end
  Else Result:=SockTo.AppServer.GetTehData(ksql, Params, null);
end;

function TDM.GetData(ksql, Params: Variant; actuality : boolean): Variant;
Begin
  Result:=null;
  if not conn then Exit;
  if actuality then Begin
     CommTrans;
     StartTrans;
     Result:=SockTo.AppServer.GetData(ksql, Params, null);
     CommTrans;
  end
  Else Result:=SockTo.AppServer.GetData(ksql, Params, null);
end;

function TDM.GetTehDataN(ksql, params, nams: Variant; actuality : boolean): Variant;
Begin
  Result:=null;
  if not conn then Exit;
  if actuality then Begin
     CommTrans;
     StartTrans;
     Result:=SockTo.AppServer.GetTehDataN(ksql, Params, nams, null);
     CommTrans;
  end
  Else Result:=SockTo.AppServer.GetTehDataN(ksql, Params, nams, null);
end;

function TDM.RunSQL(ksql, params: Variant): Variant; 
Begin 
  Result:=null;
  if not conn then Exit;
  Result:=SockTo.AppServer.RunSQL(ksql, Params, null);
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

procedure TDM.BackTransC;
Begin
  if not conn then Exit;
  SockTo.AppServer.BackTransC;
end;

procedure TDM.CommTransC;
Begin
  if not conn then Exit;
  SockTo.AppServer.CommTransC;
end;

procedure TDM.StartTransC;
Begin
  if not conn then Exit;
  SockTo.AppServer.StartTransC;
end;

function TDM.GetNextId(gennam : string) : integer;
var
  params, res : variant;
Begin
  Result := 0;
  params:=VarArrayCreate([0, 1], varVariant);
  params[0]:=VarArrayOf(['!GENOM']);
  params[1]:=VarArrayOf([gennam]);
  res:=GetTehData('Nyk140',params);
  if not VarIsNull(res) then Result := Integer(res);
end;

function TDM.GetNextIdC(gennam : string;mapId : integer) : integer;
var
  params, res : variant;
Begin
  Result := 0;
  params:=VarArrayCreate([0, 1], varVariant);
  params[0]:=VarArrayOf(['!GENOM']);
  params[1]:=VarArrayOf([gennam]);
  res:=GetTehDataC('Nyk140',params, mapId);
  if not VarIsNull(res) then Result := Integer(res);
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

  res:=SockTo.AppServer.IsOperationRite(kn);

  {params:=VarArrayCreate([0, 1], varVariant);
  params[0]:=VarArrayOf(['kn']);
  params[1]:=VarArrayOf([kn]);
  res:=DM.GetTehData('Nyk235',params); }

  if VarIsNull(res) then ii:=-2 Else ii:=res;
  If ii>0 Then Result:=true;
end;

Function  TDM.TestStatus : variant;
var
  res : Variant;
Begin
  Result:=null;
  if not conn then Exit;
  try
    Result:=SockTo.AppServer.GetStatus(outpars);
  except
    Result := Null;
  end;
  outpars:=null;
end;

function TDM.RunScript(kn,script : string) : integer;
var
  res : variant;
Begin
  Result:=-2;
  if not conn then Exit;
  res:=SockTo.AppServer.RunScript(kn,script);
  if not VarIsNull(res) then Result:=Integer(res);
end;

function TDM.StreamToVariant(FS: TMemoryStream): OleVariant;
var
//  FS: TFileStream;
  P,P1: pointer;
//  buff: OleVariant;
begin
//  FS := TFileStream.Create(stFileName ,fmOpenRead);
  try
    FS.Position := 0;
    GetMem(P, FS.size);
    FS.ReadBuffer(P^,FS.size); // ?eoaai ec iioiea a P^
    Result :=VarArrayCreate([0,FS.size-1],varByte);
    P1 :=VarArrayLock(Result);
     move(P^,P1^,FS.size);  // ia?aiauaai ec P^ a iannea buff
    VarArrayUnLock(Result);
    FreeMem(P,FS.size);
  finally
//    FS.Free;
  end;
end;

function TDM.SendFile(par: variant; BufSize: Integer; pgb : TProgressBar; lb : TLabel): Integer;
var FileStream: TFileStream;
    Stream: TMemoryStream;
    Parts, i : Integer;
    Param: Variant;
    Percent: Real;
    dt : TDateTime;
begin
  Result := -1;
  try
    i:=FileAge(par[0]);
    if i<0 then Exit;
    dt:=FileDateToDateTime(i);
    FileStream := TFileStream.Create(par[0], fmOpenRead);
    Stream := TMemoryStream.Create;
    Parts := FileStream.Size div BufSize;

    {}
     pgb.Max := FileStream.Size;
     pgb.Position := 0;
     lb.Caption := '0%';

        Param := VarArrayCreate([0, 3], varVariant);
        Param[0] := ExtractFileName(par[0]);
        Param[1] := par[1];
        Param[2] := FileStream.Size;
        Param[3] := dt;
    {}

    DM.SockTo.AppServer.StartTransmit(Param, par[2],par[3]);
    if Parts <> 0 then
      begin
        for i := 0 to Parts - 1 do
          begin
            FileStream.Position := BufSize * i;
            Stream.CopyFrom(FileStream, BufSize);
            DM.SockTo.AppServer.WorkTransmit(StreamToVariant(Stream));

            {}

            pgb.Position := pgb.Position + Stream.Size;
            Percent := (pgb.Position*100)/pgb.Max;
            lb.Caption := FloatToStr(Round(Percent)) + '%';
            Application.ProcessMessages;
            //Sleep(500);
            {}

            Stream.Clear;
          end;
        if (Parts*BufSize) < FileStream.Size then
          begin
            FileStream.Position := BufSize * (Parts);
            Stream.CopyFrom(FileStream, FileStream.Size - Parts * BufSize);
            DM.SockTo.AppServer.WorkTransmit(StreamToVariant(Stream));

            {}

            pgb.Position := pgb.Position + Stream.Size;
            Percent := (pgb.Position*100)/pgb.Max;
            lb.Caption := FloatToStr(Round(Percent)) + '%';
            Application.ProcessMessages;
            //Sleep(500);
            {}
            Stream.Clear;
          end;
      end
      else
      begin
        FileStream.Position := 0;
        Stream.CopyFrom(FileStream, FileStream.Size);
        DM.SockTo.AppServer.WorkTransmit(StreamToVariant(Stream));

        {}

        pgb.Position := pgb.Position + Stream.Size;
        Percent := (pgb.Position*100)/pgb.Max;
        lb.Caption := FloatToStr(Round(Percent)) + '%';
        Application.ProcessMessages;
        {}
        
        Stream.Clear;
      end;
    DM.SockTo.AppServer.CloseTransmit;
    pgb.Position := 0;
    //fr_modelmain.Label1.Caption := '0%';
    FileStream.Free;
    Stream.Free;
    Result := 1;
  except
    Result := -1;
  end;
end;

end.
