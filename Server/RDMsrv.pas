unit RDMsrv;

{$WARN SYMBOL_PLATFORM OFF}
                                              
interface

uses
  Windows, Messages, SysUtils, Classes, ComServ, ComObj, VCLCom, DataBkr,
  DBClient, modelserver_TLB, StdVcl, IBDatabase, DB, Variants, IBCustomDataSet,
  IBQuery, SLib, Provider, SvcMgr, IBScript, ShellAPI, ExtCtrls, IBExtract, Formula,
  IniStrings, DCPMain, DM;

const
  keylock = 'rjycnhernjh2008RI';
  sql_co_p1 = 'V97qT+cuBpDElNvIKHQ+W5+ilDThPi53wAgVFBeYv2YxOU8Nb9Qf9pasvoH2Wvl1Kw5ULWZWcuC/TLppBg4fyls4pZy8yLgNCiTC3qtSIQS8dNmD9CaU2vHw5n219Zg+ntQhdQs09MaTc';
  sql_co_p2 = 'j6doGB+X27JgvGNgdgFRnXh+TAmzNiHDBCX8xp+I2w94+j+Acz9cYxbmHuwV9lsAWRDzBMgeSWuDlz5RaiFOOGKHA3HqgAChlc31NjFA5QmLDtpVU4VO6/3JUt78/a622pjQP6pMxOhMWqBB0/oFK0DjI6WiF';
  sql_co_p3 = 'VgozBKGQyrDtgy6TBOPSlBQLUCAW6C3ldRFv3QBFAREUP+CkzmgDmV51NDkqLL77rAw1ERpLSTTSIH7jQ9nq0JqxGdfZwsFRdwDPHF4UDRpNqrm6K52maF/+TCkmL3Kf+fi6YxlXAsWgc=';

type

Fold = record
  Document:string;
  TempFolder : string;
  FileType : integer;
  CModulType : integer;
  Comment : string;
  size : integer;
  datemake : TDateTime;
end;

CalcSW = record
  filename : string;
  sensorvalue : string;
  sensorerror : string;
  progressable : integer;
  checkCount : integer;
  needStart : boolean;

  precalcname : string;  // наименование файла подстановки предрасчетов
  precalcfile : string;  // наименование файла хранимого предрасчета для схемы
  precalcvar : integer;  // процент изменения схемы допускаемый без переписи хранимого файла предрачетов
  changmapcount : real; // процент изменений схемы
  elsyst : integer;  //питание от системы или собственных генераторов (1 - от системы)

  kzunitkn : string;  // код узла КЗ
end;

CalcType = record
  id : integer;
  comment : string;
  maps : variant;
  periuds : variant;
  mainmaps : integer;
  planid : integer;
  modid : integer;   // номер расчетного модуля
end;

LimitsRec = record
  islimited : boolean;
  usercount : integer;
  powermax : integer;
  exelstringcount : integer;
  mapcount : integer;
  objectsmapcount : integer;
end;

TMetaData = (
  mdTableStrurure, mdDomain, mdTableData, mdTableIndex, mdTableForeign
);

TRI_Modelserver = class(TRemoteDataModule, IRI_Modelserver)
    IBDB: TIBDatabase;
    IBTrans: TIBTransaction;
    q_SQL: TIBQuery;
    q_usr_grp: TIBQuery;
    q_users: TIBQuery;
    q_work: TIBQuery;
    dsp_work: TDataSetProvider;
    cds_work: TClientDataSet;
    cds_teh: TClientDataSet;
    ib_script: TIBScript;
    q_oper_rite: TIBQuery;
    IBDbCalc: TIBDatabase;
    IBTransCalc: TIBTransaction;
    q_files: TIBQuery;
    timerCalc: TTimer;
    q_files_add: TIBQuery;
    q_work_c: TIBQuery;
    dsp_work_c: TDataSetProvider;
    cds_work_c: TClientDataSet;
    IBExtract: TIBExtract;
    q_mapid_c: TIBQuery;
    cds_work_with_me: TClientDataSet;
    q_execute: TIBQuery;
    q_calc_ins: TIBQuery;
    q_per_ins: TIBQuery;
    q_execute_c: TIBQuery;
    ib_script_c: TIBScript;
    q_oper_rt_g: TIBQuery;
    q_dualset_c: TIBQuery;
    timerDelFolder: TTimer;
    timerRetCalcstate: TTimer;
    q_sum_power: TIBQuery;
    procedure RemoteDataModuleCreate(Sender: TObject);
    procedure timerRetCalcstateTimer(Sender: TObject);
    procedure timerDelFolderTimer(Sender: TObject);
    procedure timerCalcTimer(Sender: TObject);
    procedure RemoteDataModuleDestroy(Sender: TObject);
  private
    sys_op : boolean;
    username : string;
    userid : integer;
    usernik : string;
    userrole : integer;
    useractive : integer;
    error_op : integer; {0 Ok, 1 нет прав, 2 нет СКЛ, 3 ошибка выполнения, -1 нет БД}
    SqlField : TNykSQLField;
    calcstate : integer;
    curCalc : CalcType;
    calcpath : string;
    lastid : integer;
    RFile : TFileStream;
    Paths : Fold;
    ExecutedModule : Fold;
    ModuleCalcSW : CalcSW;
    ProcentCalc : integer;
    MapLockID : int64;
    monopolise : boolean;
    NoLogErrorSQL : TStringList;
    notDeletedFolders : TStringList;
    lresetnom : integer;
    limitslist : LimitsRec;
    Procedure ReLoadSQL;
    Function LoadSQL(knn : string) : pointer;
    function TestRiteSQL(sqlkn : string; rol : integer) : boolean;
    Function DoSQL(asql : pointer; params, dbdirect : variant) : integer;
    function GetNextId(gennam : string) : integer;
    function GetNextId_c(gennam : string) : integer;
    procedure ClearUser;
    Procedure LogOut;
    Function RunIbScript(script : string) : boolean;
    Function CreateCalcDB : boolean;
    Function StrAnyChar(str : string;dir,ll,ee : integer) : string;
    Function MakeFormatStr(par,len,ext : variant;br : string) : string;
    Function ElementToCalc(ename,defn,kn : string; par : variant; periud : integer) : boolean;
    Function ElementCalcToDB(ename,defn,kn : string; tpc : integer) : boolean;
    Function MakeCalkFolder : string;
    Function PutCalcModul(foldername : string; c_type : integer) : boolean;
    Function DeleteFolder(foldername : string) : integer;
    procedure DelFolder(foldername : string);
    Function SendElementsToCalc(mapid,periud:integer) : boolean;
    function SaveFileToBD(Filename, Path, Comment:string; FileType, ModulType,Fsize:integer; Dmake:TDateTime) : boolean;
    function LoadCalcResult : boolean;
    function DumpDBstructure(tbName: string; meta : TMetaData):boolean;
    function DumpDBtoCalc(mapid : integer):boolean;
    function ExecCalcSQLTeh(sql:string):boolean;
    function GetUserData(uid : int64) : variant;
    function TestMapIdCalc(mapid : integer) : boolean;
    function CreateCalc : boolean;
    procedure ReSetINIConfig;
    procedure UpDateINIConfig(initxt : string);
    function GetVarValFromFormatStr(fstr : string; index : integer; br : char) : variant;
    procedure Initialise;
    function ReadLimitStation : boolean;
    function GetSumPowerMap(mid : integer) : real;
    { Private declarations }
  protected
    function GetLastError: OleVariant; safecall;
    function GetCalcState: OleVariant; safecall;
    function GetGostKey: OleVariant; safecall;
    procedure PutCalcSetMap(mapid, modul: Integer; res: OleVariant); safecall;
    function GetCalcSetMap(mapid, modul: Integer): OleVariant; safecall;
    function GetVersions: OleVariant; safecall;
    procedure ResetCalcSet(CUNIT: Smallint); safecall;
    function GetConfigINI: OleVariant; safecall;
    procedure SetConfigINI(INITEXT, LOGTYPE: OleVariant); safecall;
    procedure ErrSQLlogControl(kn, oper: OleVariant); safecall;
    function LockMapEditOp(mid, sts: OleVariant): OleVariant; safecall;
    function MapCalcCount(MAPID: Integer): OleVariant; safecall;
    function SetUpstruct: OleVariant; safecall;
    function LoadUpstuct(scrpt: OleVariant): OleVariant; safecall;
    function GetMonoState: OleVariant; safecall;
    function DoLockMapF(mid, sts: OleVariant): OleVariant; safecall;
    function GetUserStatus: OleVariant; safecall;
    procedure BackTransC; safecall;
    procedure CommTransC; safecall;
    procedure StartTransC; safecall;
    function CloseTransmit: OleVariant; safecall;
    function StartTransmit(FileName: OleVariant; FileType, ModulType: Integer): OleVariant; safecall;
    function WorkTransmit(Buffer: OleVariant): OleVariant; safecall;
    function DoCalculate(mapid: Integer; params: OleVariant): Integer; safecall;
    function RunScript(kn, script: OleVariant): OleVariant; safecall;
    function IsOperationRite(kn: OleVariant): OleVariant; safecall;
    function TestOperRites(kn: OleVariant): OleVariant; safecall;
    function GetLastId: OleVariant; safecall;
    function GetStatus(params: OleVariant): OleVariant; safecall;
    function GetTehDataN(ksql, params, nams, dbdirect: OleVariant): OleVariant; safecall;
    function GetTehData(ksql, params, dbdirect: OleVariant): OleVariant; safecall;
    function GetData(ksql, params, dbdirect: OleVariant): OleVariant; safecall;
    function RunSQL(ksql, params, dbdirect: OleVariant): OleVariant; safecall;
    procedure BackTrans; safecall;
    procedure CommTrans; safecall;
    procedure StartTrans; safecall;
    function LogDB(lg, ps: OleVariant): Integer; safecall;
    class procedure UpdateRegistry(Register: Boolean; const ClassID, ProgID: string); override;

  public
    { Public declarations }
  end;

implementation

{$R *.DFM}

Uses servicemain;

procedure TRI_Modelserver.Initialise;
var
  ss, sqltxt : string;
  inis : TMemIni;
  ls : TStringList;
begin
  LgList.Add('Создание RDM. Initialise: '+TimeToStr(now));
  SDM.WriteLogFile(2,'Создание RDM','Start.');
  DecimalSeparator := '.';
  THOUSANDSEPARATOR := #0;
  DateSeparator := '.';

  SqlField:=nil;
  sys_op:=false;
  username:='';
  userid:=0;
  usernik:='';
  userrole:=1000;
  useractive:=0;
  calcstate:=0;
  lastid:=-1;
  ProcentCalc:=0;
  MapLockID:=0;
  monopolise:=false;
  lresetnom:=SDM.resetnom;

  notDeletedFolders:=TStringList.Create;
  NoLogErrorSQL:=TStringList.Create;
  timerDelFolder.Enabled:=false;

  {if ModelService.Status<>csRunning Then Begin
     WriteLogFile(0,'Запуск сервиса','Сервис не запущен.');
     Exit;
  end; }

  if ModelService=nil then Exit;

  if SDM=nil then Exit;

  if SDM.monopol then Exit;

  if ModelService.Status<>csRunning then  Begin
     LgList.Add('Создание RDM. Initialise. Сервис не запущен. '+TimeToStr(now));
     //SDM.WriteLogFile(0,'Запуск сервиса','Сервис не запущен.');
     Exit;
  end;

  IBDB.DatabaseName:=SDM.dbservername+':'+SDM.dbname;
  SDM.WriteLogFile(1,'БД name',IBDB.DatabaseName);
  ss:='user_name='+SDM.dbusr;
  IBDB.Params.Add(ss);
  ss:='password='+SDM.dbpass;
  IBDB.Params.Add(ss);
  ss:='lc_ctype=WIN1251';
  IBDB.Params.Add(ss);

  try
    IBDB.Connected:=true;
    SDM.WriteLogFile(2,'Создание RDM','Создание завершено удачно.');
    if IBDB.Connected then Begin
       SDM.WriteLogFile(2,'Создание RDM','Коннект к БД модуля получен.');
    end
    Else Exit;
  except
    SDM.WriteLogFile(0,'Создание RDM','Ошибка соединения с БД.');
    Exit;
  end;
  // if ModelService.CalcOneBase and ModelService.CalcTestLoad then CreateCalcDB;
  if SDM.CalcOneBase then CreateCalcDB;

  sqltxt:=sql_co_p1+sql_co_p2+sql_co_p3;
  sqltxt:=DecryptString(sqltxt,keylock);
  q_sum_power.SQL.Text:=sqltxt;

  ls:=TStringList.Create;
  ls.LoadFromFile(SDM.serverpath+'modelserver.ini');
  inis:=TMemIni.Create(ls.Text);

  if inis.ReadString('DEBUG','more','0')='1' Then SDM.debugmore:=true Else SDM.debugmore:=false;
  if inis.ReadString('DEBUG','iansave','0')='1' Then SDM.savecalcdirmode:=true Else SDM.savecalcdirmode:=false;
  if inis.ReadString('DEBUG','sqlspy','0')='1' then SDM.sqlspy:=inis.ReadString('DEBUG','sql','') Else SDM.sqlspy:='';

  ls.Free;
  inis.Free;

end;

function TRI_Modelserver.DumpDBstructure(tbName: string; meta : TMetaData):boolean;
var
  ss, fchar : string;
  kvo, ii, CountFirstStringMustDelete : integer;
  allLines,res : boolean;
  sect : TExtractType;
  ob : TExtractObjectTypes;
  script : TStringList;
Begin
  Result:=false;
  if not IBDB.Connected then Exit;
  if not IBDBCalc.Connected then Exit;
  script:=TStringList.Create;
  case meta of
    mdTableStrurure  : Begin
                        fchar:='C';
                        CountFirstStringMustDelete:=2;
                        allLines:=true;
                        sect:=etTable;
                        ob:=eoTable;
                       end;
    mdDomain         : Begin
                        fchar:='C';
                        CountFirstStringMustDelete:=1;
                        allLines:=false;
                        sect:=etDomain;
                        ob:=eoDomain;
                       end;
    mdTableData      : Begin
                        fchar:='I';
                        CountFirstStringMustDelete:=0;
                        allLines:=false;
                        sect:=etTable;
                        ob:=eoData;
                       end;
    mdTableIndex     : Begin
                        fchar:='C';
                        CountFirstStringMustDelete:=2;
                        allLines:=false;
                        sect:=etTable;
                        ob:=eoIndexes;
                       end;
    mdTableForeign   : Begin
                        fchar:='A';
                        CountFirstStringMustDelete:=0;
                        allLines:=false;
                        sect:=etTable;
                        ob:=eoForeign;
                       end;
  end;
  IBExtract.ExtractObject(ob,tbName, [sect]);
  script.Text:=IBExtract.Items.Text;
  if CountFirstStringMustDelete>0 then
     for ii := 0 to CountFirstStringMustDelete - 1 do script.Delete(0);
  res:=true;
  if allLines then  res:=res and ExecCalcSQLTeh(script.Text)
  Else for ii := 0 to script.Count-1 do res:=res and ExecCalcSQLTeh(script.Strings[ii]);
  Result:=res;
  script.Free;
end;

function TRI_Modelserver.ExecCalcSQLTeh(sql:string):boolean;
Begin
  q_work_c.Active:=false;
  q_work_c.SQL.Text:=sql;
  q_work_c.Prepare;
  try
    q_work_c.ExecSQL;
    Result:=true;
  except
    Result:=false;
  end;
end;

function TRI_Modelserver.DumpDBtoCalc(mapid : integer):boolean;
var
  sst : TStrings;
  ii : integer;
  ss : string; 
  inis : TMemIni;
  ls : TStringList;
Begin
  Result:=false;
  if not((IBDbCalc.Connected)and(IBDB.Connected)) then Exit;
  StartTransC;
  // добавляем домены
  if not DumpDBstructure('',mdDomain) Then Begin
    SDM.WriteLogFile(0,'Операции с расчётной БД','(DumpDBtoCalc) Не удалось вставить домены в БД');
    BackTransC;
    Exit;
  end;
  // добавляем структуру таблиц
  sst:=TStrings.Create; 
  ls:=TStringList.Create;
  ls.LoadFromFile(SDM.serverpath+'modelserver.ini');
  inis:=TMemIni.Create(ls.Text);
  inis.ReadSection('DAMP TABLES',sst);
  // sst.Text:=ModelService.GetIniStruktureFromConfig('DAMP TABLES');
  if sst.Text='' then Begin
    sst.free;
    SDM.WriteLogFile(0,'Операции с расчётной БД','(DumpDBtoCalc) Нет в кофигурации списка таблиц, необходимых для расчётной БД');
    BackTransC; 
    ls.Free;
    inis.Free;
    Exit;
  end;
  for ii := 0 to sst.Count - 1 do
      if not DumpDBstructure(sst.Strings[ii],mdTableStrurure) Then Begin
         SDM.WriteLogFile(0,'Операции с расчётной БД','(DumpDBtoCalc) Не удалось вставить структуру таблицы в расчётную БД: '+sst.Strings[ii]);
         BackTransC;
         sst.Free; 
         ls.Free;
         inis.Free;
         Exit;
      end;
  // добавляем значения справочников
  for ii := 0 to sst.Count - 1 do Begin
      ss:=inis.ReadString('DAMP TABLES',sst.Strings[ii],'0');
      //ss:=ModelService.GetIniDataFromConfig('DAMP TABLES',sst.Strings[ii],'0');
      if ss='1' then
      if not DumpDBstructure(sst.Strings[ii],mdTableData) Then Begin
         SDM.WriteLogFile(0,'Операции с расчётной БД','(DumpDBtoCalc) Не удалось вставить значения справочников в расчётную БД: '+sst.Strings[ii]);
         BackTransC;
         sst.Free;
         ls.Free;
         inis.Free;
         Exit;
      end;
  end;
  ls.Free;
  inis.Free;
  // добавляем значения таблиц с привязкой к номеру схемы


  // добавляем индексы в таблицы
  for ii := 0 to sst.Count - 1 do
      if not DumpDBstructure(sst.Strings[ii],mdTableIndex) Then Begin
         SDM.WriteLogFile(0,'Операции с расчётной БД','(DumpDBtoCalc) Не удалось вставить индексы в расчётную БД: '+sst.Strings[ii]);
         BackTransC;
         sst.Free;
         Exit;
      end;


  sst.Free;
  CommTransC;
  Result:=true;
end;

procedure TRI_Modelserver.RemoteDataModuleCreate(Sender: TObject);
begin
  LgList.Add('RemoteDataModuleCreate'+TimeToStr(now));
  Initialise;
end;

procedure TRI_Modelserver.RemoteDataModuleDestroy(Sender: TObject);
begin

  if calcstate=2 then Begin
     calcstate:=-1;
     timerCalc.Enabled:=false;
     SDM.EndingCalcFlow;
     SDM.kill_task(ExecutedModule.Document);
     DelFolder(ExecutedModule.TempFolder);
     SDM.WriteLogFile(0,'timerCalcTimer', 'Расчет не выполнен! Выход пользователя до окончания расчета.');
  end;
  SDM.BlockMap(0, userid, 3);
  SDM.BlockMapOper(userid, 3,null);
  if SDM.CalcOneBase then Begin
     IBDbCalc.Connected:=false;
  end
  Else if IBDbCalc.Connected then IBDbCalc.DropDatabase;
  notDeletedFolders.Free;
  NoLogErrorSQL.Free;
  LogOut;
end;

class procedure TRI_Modelserver.UpdateRegistry(Register: Boolean; const ClassID, ProgID: string);
begin
  if Register then
  begin
    inherited UpdateRegistry(Register, ClassID, ProgID);
    EnableSocketTransport(ClassID);
    EnableWebTransport(ClassID);
  end else
  begin
    DisableSocketTransport(ClassID);
    DisableWebTransport(ClassID);
    inherited UpdateRegistry(Register, ClassID, ProgID);
  end;
end;

function TRI_Modelserver.TestRiteSQL(sqlkn : string; rol : integer) : boolean;
var
  rr: boolean;
Begin
  // Проверка прав пользователя на СКЛ
  error_op:=0;
  if not IBDB.Connected then Begin
     error_op:=-1;
     Result:=false;
     Exit;
  end;
  rr:=false;
  try
    If useractive>0 Then Begin
       // Проверка ролей
       if userrole<=rol then rr:=true;
       SDM.WriteLogFile(1,'TestRiteSQL','Проверка прав на SQL: '+sqlkn+' userrole='+IntToStr(userrole)+' rol='+IntToStr(rol));
       // Проверка групп пользователей
       q_usr_grp.Active:=false;
       q_usr_grp.ParamByName('uid').AsInteger:=userid;
       q_usr_grp.ParamByName('kn').AsString:=sqlkn;
       q_usr_grp.Prepare;
       q_usr_grp.Active:=true;
       If q_usr_grp.RecordCount>0 Then
         case q_usr_grp.FieldByName('res').AsInteger of
              1 : rr:=true;
             -1 : rr:=false;
         end;
       q_usr_grp.Active:=false;
    end;

  finally
    Result:=rr;
    if not rr then error_op:=1;
    If rr Then SDM.WriteLogFile(1,'TestRiteSQL','Проверка прав на SQL: '+sqlkn+' дала результат: Есть права!')
    Else SDM.WriteLogFile(1,'TestRiteSQL','Проверка прав на SQL: '+sqlkn+' дала результат: No rites!');
  end;
end;

procedure TRI_Modelserver.DelFolder(foldername : string);
var
  iii : integer;
Begin
   If DeleteFolder(foldername)<1 Then Begin
         If not notDeletedFolders.Find(foldername,iii) Then Begin
           notDeletedFolders.Add(foldername);
           timerDelFolder.Enabled:=true;
         end;
     end;
end;

procedure TRI_Modelserver.timerCalcTimer(Sender: TObject);
var
  fullFileName : string;
  ms : TMemoryStream;
  ff: TFileStream;
  ls : TStringList;
  ss : string;
  rres : boolean;
  ii,iii : integer;
begin
  SDM.WriteLogFile(4,'timerCalcTimer', 'Enter count='+IntToStr(ModuleCalcSW.checkCount));
  if calcstate<>2 then Begin
     SDM.WriteLogFile(4,'timerCalcTimer', 'May be exit... stateCalc='+IntToStr(calcstate)+' На выходе. cur: '+IntToStr(SDM.CalcFlowCount));
     timerCalc.Enabled:=false;
     if SDM.CalcFlowCount = SDM.MaxCalcFlow then Begin
       SDM.WriteLogFile(4,'timerCalcTimer', 'Mistique... stateCalc='+IntToStr(calcstate)+' На выходе. cur: '+IntToStr(SDM.CalcFlowCount));
       SDM.EndingCalcFlow;
     end;
     ExecutedModule.Document:='';
     Exit;
  end;
  if ExecutedModule.Document='' then Begin
     SDM.EndingCalcFlow;
     timerCalc.Enabled:=false;
     DelFolder(calcpath);
     calcstate:=0;
     Exit;
  end;
  SDM.WriteLogFile(4,'timerCalcTimer', 'Continue stateCalc='+IntToStr(calcstate));
  Dec(ModuleCalcSW.checkCount);
  rres:=false;

  if (ModuleCalcSW.checkCount+1<0)and(calcstate=2) then Begin
     // Убиваем процесс, останавливаем расчёт.
     calcstate:=-1;
     timerCalc.Enabled:=false;
     SDM.EndingCalcFlow;
     SDM.kill_task(ExecutedModule.Document);
     DelFolder(ExecutedModule.TempFolder);
     SDM.WriteLogFile(0,'timerCalcTimer', 'Расчет не выполнен! Расчетный модуль не отвечает.');
     ExecutedModule.Document:='';
     Exit;
  end;

  // Проверяем наличие файла результатов расчёта
  fullFileName:=calcpath+ModuleCalcSW.filename;
  if FileExists(fullFileName) Then Begin
     SDM.WriteLogFile(4,'timerCalcTimer', 'File find: '+fullFileName);
     ls:=TStringList.Create;
     ff:=TFileStream.Create(fullFileName, fmOpenRead, fmShareDenyNone);
     ff.Position:=0;
     ms := TMemoryStream.Create;
     ms.Position := 0;
     ms.CopyFrom(ff, ff.Size);
     SDM.WriteLogFile(4,'timerCalcTimer', 'Size= '+IntToStr(ff.Size)+' ms.size= '+IntToStr(ms.Size));
     ms.Position := 0;
     ls.loadfromstream(ms);
     SDM.WriteLogFile(4,'timerCalcTimer', 'IAN = '+ls.Text);
     //ms.SaveToFile(calcpath+'ms.txt');
     ms.Free;
     ff.Free;
     if ls.Text<>'' then Begin
        ls.Strings[0]:=CorrectFormatStr(ls.Strings[0],'!');
        SDM.WriteLogFile(4,'timerCalcTimer', 'KeyVal = '+ls.Strings[0]+' & Key = '+ModuleCalcSW.sensorvalue);
        if ls.Strings[0]=ModuleCalcSW.sensorvalue then Begin
           calcstate:=3;
           timerCalc.Enabled:=false;
           SDM.EndingCalcFlow;
           ProcentCalc:=100;
           ExecutedModule.Document:='';
           // запуск загрузки
           SDM.WriteLogFile(4,'timerCalcTimer', 'запуск загрузки');
           if not LoadCalcResult then Begin
             DelFolder(calcpath);
             calcstate:=0;
             ls.Free;
             Exit;
          end;
        end
        Else Begin
          if ls.Count>1 then Begin
             if ModuleCalcSW.progressable=1 then ProcentCalc:=StrToInt(ls.Strings[1]);
             SDM.WriteLogFile(4,'timerCalcTimer', 'Процент расчета: '+ls.Strings[1]);
          end;
          if ls.Strings[0]=ModuleCalcSW.sensorerror then Begin
             timerCalc.Enabled:=false;
             SDM.EndingCalcFlow;
             DelFolder(calcpath);
             calcstate:=-1; 
             ExecutedModule.Document:='';
             ls.Free;
             SDM.WriteLogFile(0,'timerCalcTimer', 'Расчет не выполнен! Ошибка сходимости модели.');
             Exit;
          end;

        end;
     end;
  end;
  {if (ModuleCalcSW.checkCount<0)and(calcstate=2) then Begin
     // Убиваем процесс, останавливаем расчёт.
     calcstate:=-1;
     timerCalc.Enabled:=false;
     SDM.EndingCalcFlow;
     SDM.kill_task(ExecutedModule.Document);
     DelFolder(ExecutedModule.TempFolder);
     SDM.WriteLogFile(0,'timerCalcTimer', 'Расчет не выполнен! Расчетный модуль не отвечает.');
     Exit;
  end;  }

end;

procedure TRI_Modelserver.timerDelFolderTimer(Sender: TObject);
var
  ii,co : integer;
  vv : variant;
begin
  //if notDeletedFolders then
  co:=notDeletedFolders.Count;
  if co=0 Then Exit;
  timerDelFolder.Enabled:=false;
  vv:=VarArrayCreate([0, co-1], varInteger);
  for ii:=0 to co - 1 do
      vv[ii]:=DeleteFolder(notDeletedFolders.Strings[ii]);
  for ii := co-1 to 0 do
      if vv[ii]>0 then notDeletedFolders.Delete(ii);
  if notDeletedFolders.Count>0 then timerDelFolder.Enabled:=true;
end;

procedure TRI_Modelserver.timerRetCalcstateTimer(Sender: TObject);
begin
  calcstate:=0;
  ExecutedModule.Document:='';
  timerRetCalcstate.Enabled:=false;
end;

Function TRI_Modelserver.LoadSQL(knn : string) : pointer;
var
  sm : TNykSQL;
  ii : integer;
Begin
   //q_SQL
  Result:=nil;
  error_op:=0;
  if not IBDB.Connected then Begin
     error_op:=-1;
     Exit;
  end;
  if SqlField=nil then SqlField:=TNykSQLField.Create Else
  If SqlField.TestSQLPresent(knn,ii) Then Begin
     Result:=SqlField.SQLByIndex(ii);
     Exit;
  end;
  SDM.WriteLogFile(1,'Загрузка SQL','Загружаем SQL: '+knn);
  q_SQL.Active:=false;
  q_SQL.ParamByName('kn').AsString:=knn;
  q_SQL.prepare;
  q_SQL.Active:=true;
  if q_SQL.RecordCount>0 then Begin
     sm:=SqlField.AddSQL(q_SQL.FieldByName('ID').AsInteger, q_SQL.FieldByName('ROLES_ID').AsInteger, q_SQL.FieldByName('KN').AsString, q_SQL.FieldByName('COMMENT').AsString);
     sm.AddSQLtxt(q_SQL.FieldByName('SQL').Value);
     sm.SetDoIt(TestRiteSQL(knn,sm.RulesId));
     Result:=sm;
  end
  Else SDM.WriteLogFile(0,'Операции с БД','(LoadSQL) Нет храмимого кода SQL: '+knn);
  q_SQL.Active:=false;
end;

Function TRI_Modelserver.DoSQL(asql : pointer; params, dbdirect : variant) : integer;
var
  sm : TNykSQL;
  i,ii,iid,stt : integer;
  ss : string;
  isCalcSQL : boolean;
  pp : pointer;
Begin
  Result:=-3;
  ss:='';
  isCalcSQL:=false;
  if asql=nil then Exit;
  sm:=asql;
  sm.ReActivate;
  stt:=1;
  if SDM.debugmore Then if sm.kn=SDM.sqlspy then stt:=4;
  SDM.WriteLogFile(stt,'Запуск хранимого SQL','(DoSQL) Заполняем SQL: '+sm.kn);
  if (not sm.CanDoIt) and (not sys_op) then Begin
     SDM.WriteLogFile(4,'Запуск хранимого SQL','(DoSQL). ОШИБКА! Нет прав на исполнение запроса: '+sm.kn+' для '+username);
     Result:=-2;
     Exit;
  end;
  if not VarIsNull(dbdirect) then Begin
        If TestMapIdCalc(dbdirect) or sys_op Then Begin
           if not IBDbCalc.Connected then Begin
              Result:=-5; //Не создана расчётная база.
              SDM.WriteLogFile(0,'Запуск хранимого SQL','(DoSQL) Не удачное открытие запроса SQL (Не создана расчётная база.): '+sm.kn+': '+String(dbdirect)+': '+sm.SQL.text);
              Exit;
           end;
           isCalcSQL:=true;
        end
        Else Begin
             Result:=-4; //Либо не верно указана схема расчётная либо расчёт не был проведён
             SDM.WriteLogFile(0,'Запуск хранимого SQL','(DoSQL) Не удачное открытие запроса SQL (не верно указана схема расчётная либо расчёт не был проведён): '+sm.kn+': '+String(dbdirect)+': '+sm.SQL.text);
             Exit;
        end;
  end;
  if sm.IsNeedParam then Begin
     SDM.WriteLogFile(stt,'Запуск хранимого SQL','(DoSQL) Параметры нужны в DoSQL!!: '+IntToStr(VarArrayHighBound(params[0],1)+1));
     if VarIsNull(params) then Begin
        SDM.WriteLogFile(0,'Запуск хранимого SQL','(DoSQL) не переданы параметры SQL: '+sm.kn+': '+sm.SQL.text);
        Exit;
     end;
     for i := 0 to VarArrayHighBound(params[0],1) do
       sm.AddValue(params[0][i],params[1][i]);
     if VarArrayHighBound(params,1)>1 then
        If not VarIsNull(params[2]) Then
           for i := 0 to VarArrayHighBound(params[2],1) do sm.AddClrComent(params[2][i]);
     If not sm.TestParams Then Begin
        SDM.WriteLogFile(0,'Запуск хранимого SQL','(DoSQL) SQL не прошёл проверку после заполнения параметров: '+sm.kn+': '+sm.SQL.text);
        Exit;
     end;
  end;
  SDM.WriteLogFile(stt,'Запуск хранимого SQL','(DoSQL) Параметры в DoSQL Заполнены!!.');
  SDM.WriteLogFile(stt,'Запуск хранимого SQL','(DoSQL) System parameters:'+IntToStr(sm.SysVar.Count));
  if sm.SysVar.Count>0 then Begin
     sm.SetSysParVal('user',userid);
     sm.SetSysParVal('rol',userrole);
     if sm.Generator<>'' Then Begin
        if isCalcSQL then iid:=GetNextId_c(sm.Generator) Else iid:=GetNextId(sm.Generator);
        sm.SetSysParVal('id',iid);
     end;
  end;
  SDM.WriteLogFile(stt,'Запуск хранимого SQL','(DoSQL) Вызываем RunIBSQL_LEex');
  if isCalcSQL then Result:=SqlField.RunIBSQL_LEex(sm,q_work_c,ss)
  Else Result:=SqlField.RunIBSQL_LEex(sm,q_work,ss);
  SDM.WriteLogFile(stt,'Запуск хранимого SQL','(DoSQL) RunIBSQL_LE выполнен с результатом:'+IntToStr(Result));
  if result<>0 then
    if NoLogErrorSQL.IndexOf(sm.kn)<0 Then Begin
     SDM.WriteLogFile(0,'Запуск хранимого SQL','(DoSQL) Ошибка исполнения хранимого SQL: '+sm.kn+' --- '+ss);
     if result=1 then Begin
        if isCalcSQL then pp:=q_work_c Else pp:=q_work;
        SDM.WriteLogFile(0,'Запуск хранимого SQL','(DoSQL) Не удачное открытие запроса SQL: '+sm.kn+': '+TIBQuery(pp).SQL.Text);
        for ii := 0 to TIBQuery(pp).ParamCount - 1 Do Begin
            if VarIsNull(TIBQuery(pp).Params.Items[ii].Value) then ss:='NULL'
            Else ss:=String(TIBQuery(pp).Params.Items[ii].Value);
            SDM.WriteLogFile(0,'Запуск хранимого SQL','(DoSQL) Par SQL: '+sm.kn+': '+TIBQuery(pp).Params.Items[ii].Name+' = '+ss);
        end;
        for ii:=0 to sm.SysVar.Count-1 do Begin
            if VarIsNull(sm.SysVal[ii]) then ss:='NULL'
            Else ss:=String(sm.SysVal[ii]);
            SDM.WriteLogFile(0,'Запуск хранимого SQL','(DoSQL) Объект SQL (системные переменные): '+sm.SysVar.Strings[ii]+' = '+ss);
        end;
     end;
    end;
end;

Procedure TRI_Modelserver.ReLoadSQL;
Begin
  error_op:=0;
  if not IBDB.Connected then Begin
     error_op:=-1;
     Exit;
  end;
  if SqlField<>nil then Begin
     SqlField.free;
     SqlField:=nil;
  end;
  SqlField:=TNykSQLField.Create;
  SDM.WriteLogFile(1,'Операции с объектами','Сброс памяти объектов SQL.');
end;

function TRI_Modelserver.LogDB(lg, ps: OleVariant): Integer;
var
 rr : integer;
 rrr : variant;
 ss : string;
 ls : TStringList;
begin
  // Авторизация пользователя
  rr:=-1;
  SDM.WriteLogFile(3,'LogDB.','Получен запрос на авторизацию пользователя: '+lg);
  if not IBDB.Connected then  Initialise;

  If not IBDB.Connected Then Begin
     SDM.WriteLogFile(0,'LogDB','БД не доступна при авторизации пользователя: '+lg);
     result:=1;
     Exit;
  end;
  ClearUser;
  //WriteLogFile(1,'Секьюрити','Пароль пользователя: '+ps);
  try
    q_users.Active:=false;
    q_users.ParamByName('pw').AsString:=ps;
    q_users.ParamByName('nam').AsString:=lg;
    q_users.Prepare;
    q_users.Active:=true;
    if q_users.RecordCount>0 then Begin
       username:=q_users.FieldByName('name').AsString;
       userid:=q_users.FieldByName('id').AsInteger;
       usernik:=q_users.FieldByName('nikname').AsString;
       userrole:=q_users.FieldByName('roles_id').AsInteger;
       useractive:=q_users.FieldByName('state').AsInteger;
       if useractive<0 then useractive:=0;
       if useractive>0 then useractive:=1;
       if useractive=1 then Begin
          ReadLimitStation;
          rr:=0;
          if limitslist.usercount>0 then
            if limitslist.usercount<=SDM.GetUserCOuntConnect then Begin
             rr:=10;
             useractive:=0;
            end;
       end;
    end;
    q_users.Active:=false;
    if useractive=1 then
       if SDM.AddClientToList(username,usernik,userid,userrole,useractive)=1 Then
          SDM.WriteLogFile(3,'LogDB','Удачная авторизаци пользователя: '+lg)
       Else Begin
          rr:=2;
          SDM.WriteLogFile(3,'LogDB','Авторизаци пользователя: '+lg+' отклонена. Повторная регистрация.');
          ClearUser;
       end
    Else Begin
       SDM.WriteLogFile(3,'LogDB','Авторизаци пользователя: '+lg+' отклонена. Сеанс связи завершон.');
       ClearUser;
    end;
  finally
    result:=rr;
  end;
  rrr:='';
  if rr=0 then Begin
    rrr:=GetVersions;
  end;
  if String(rrr)<>'' then Begin
     ls:=TStringList.Create;
     ls.Text:=String(rrr);
     ss:=ls.Strings[1]+'('+ls.Strings[2]+'/'+ls.Strings[3]+')';
     SDM.WriteLogFile(2,'LogDB','Версия БД: '+ss);
     ls.Free;
  end;
end;

procedure TRI_Modelserver.ClearUser;
Begin
  sys_op:=false;
  username:='';
  userid:=0;
  usernik:='';
  userrole:=1000;
  useractive:=0;

  SqlField:=nil;

  calcstate:=0;
  lastid:=-1;
  ProcentCalc:=0;

end;

Procedure TRI_Modelserver.LogOut;
Begin
  if userid=0 then Exit;
  if monopolise then Begin
     SDM.hard_close:=false;
     monopolise:=false;
     SDM.monopol:=false;
     SDM.WriteLogFile(2,'System service','(GetStatus). User '+usernik+' return status MONOPOLISE');
  end;
  SDM.BlockMap(0, userid, 3);
  SDM.DeleteClientFromList(userid);
  ReLoadSQL;
  SDM.WriteLogFile(3,'LogOut','Завершение работы пользователя: '+usernik);
  ClearUser;
end;

procedure TRI_Modelserver.CommTrans;
begin
  If IBTrans.InTransaction Then Begin
     IBTrans.Commit;
     // добавить лог
  end;
end;

procedure TRI_Modelserver.StartTrans;
begin
  If not IBTrans.InTransaction Then Begin
     IBTrans.StartTransaction;
     // добавить лог
  end;
end;

procedure TRI_Modelserver.BackTrans;
begin
  // добавить лог
  If IBTrans.InTransaction Then IBTrans.Rollback;
end;


function TRI_Modelserver.RunSQL(ksql, params, dbdirect: OleVariant): OleVariant;
var
  sm : TNykSQL;
begin
   Result:=null;
   sm:=LoadSQL(ksql);
   if sm=nil then Exit;
   SDM.WriteLogFile(1,'RunSQL','Запускаем SQL: '+String(sm.kn));
   Result:=DoSQL(sm,params, dbdirect);
end;

function TRI_Modelserver.GetData(ksql, params, dbdirect: OleVariant): OleVariant;
var
  res : variant;
  ii : integer;
  pp, p2 : pointer;
begin
  Result:=null;
  SDM.WriteLogFile(1,'GetData','Запускаем SQL: '+String(ksql));
  cds_work.Active:=false;
  cds_work_c.Active:=false;
  res:=RunSQL(ksql, Params, dbdirect);
  SDM.WriteLogFile(1,'GetData','Выполнена SQL: '+String(ksql)+' с результатом: '+String(res));
  if not VarIsNull(res) then
     if res=0 then Begin
        pp:=cds_work;
        p2:=q_work;
        If not VarIsNull(dbdirect) Then
           if TestMapIdCalc(dbdirect) or sys_op then Begin
              pp:=cds_work_c;
              p2:=q_work_c;
           end
           Else Exit;

        try
          TClientDataSet(pp).Active:=true;
          Result:=TClientDataSet(pp).Data;
          TClientDataSet(pp).Active:=false;
          SDM.WriteLogFile(1,'GetData','Выполнена SQL: '+String(ksql)+' All rite!!');
        except
          on E: Exception do Begin
            SDM.WriteLogFile(0,'Операции с БД','(GetData) Не удачное открытие запроса SQL: '+ksql+' --- '+E.Message);
            SDM.WriteLogFile(0,'Операции с БД','(GetData) Не удачное открытие запроса SQL: '+TIBQuery(p2).SQL.Text);
            for ii := 0 to TIBQuery(p2).ParamCount - 1 Do
                SDM.WriteLogFile(0,'Операции с БД','(GetData) Par SQL: '+TIBQuery(p2).Params.Items[ii].Name+' = '+String(TIBQuery(p2).Params.Items[ii].Value));
          end;
        end;
     end
     Else error_op:=res;
end;

function TRI_Modelserver.GetNextId(gennam : string) : integer;
var
  params, res : variant;
Begin
  Result:=-1;
  params:=VarArrayCreate([0, 1], varVariant);
  params[0]:=VarArrayOf(['!GENOM']);
  params[1]:=VarArrayOf([gennam]);
  res:=GetTehData('Nyk140',params,null);
  if not VarIsNull(res) then Begin
     Result:=Integer(res);
     lastid:=Result;
  end
  Else lastid:=-1;
end;

function TRI_Modelserver.GetNextId_c(gennam : string) : integer;
var
  params, res : variant;
Begin 
  Result:=-1;
  params:=VarArrayCreate([0, 1], varVariant);
  params[0]:=VarArrayOf(['!GENOM']);
  params[1]:=VarArrayOf([gennam]);
  sys_op:=true;
  res:=GetTehData('Nyk140',params,0);
  sys_op:=false;
  if not VarIsNull(res) then Begin
     Result:=Integer(res);
     lastid:=Result;
  end
  Else lastid:=-1;
end;

function TRI_Modelserver.GetTehData(ksql, params, dbdirect: OleVariant): OleVariant;
var
  res,otv : variant;
  co,ii   : integer;
begin
  Result:=null;
  SDM.WriteLogFile(1,'Получение тех. параметров из SQL','(GetTehData) kn='+ksql);
  res:=GetData(ksql, Params, dbdirect);
  if VarIsNull(res) then Begin
     SDM.WriteLogFile(0,'Получение тех. параметров из SQL','(GetTehData) Результат - NULL. SQL='+ksql);
     Exit;
  end;
  cds_teh.Active:=false;
  cds_teh.Data:=res;
  if cds_teh.RecordCount=0 then Exit;
  co:=cds_teh.Fields.Count;
  If co>0 Then
   If co>1 Then Begin
     otv:=VarArrayCreate([0, co-1], varVariant);
     For ii:=0 to co-1 Do
        otv[ii]:=cds_teh.Fields.Fields[ii].Value;
     Result:=otv;
   end
   Else Result:=cds_teh.Fields.Fields[0].Value;
   cds_teh.Active:=false;
end;

function TRI_Modelserver.GetTehDataN(ksql, params, nams, dbdirect: OleVariant): OleVariant;
var
  res,otv : variant;
  co,ii   : integer;
begin
  Result:=null;
  res:=GetData(ksql, Params, dbdirect);
  if VarIsNull(res) then Exit;
  cds_teh.Active:=false;
  cds_teh.Data:=res;
  if cds_teh.RecordCount=0 then Exit;
  try
    co:=VarArrayHighBound(nams,1);
  except
    cds_teh.Active:=false;
    Exit;
  end;
  otv:=VarArrayCreate([0, co], varVariant);
  try
    For ii:=0 to co Do otv[ii]:=cds_teh.Fields.FieldByName(nams[ii]).Value;
    Result:=otv;
  except
    cds_teh.Active:=false;
    Result:=null;
    error_op:=10; // Нет параметра
    SDM.WriteLogFile(0,'Операции с БД','(GetTehDataN) Нет параметра для запроса SQL: '+ksql);
  end;
  cds_teh.Active:=false;
end;

function TRI_Modelserver.GetStatus(params: OleVariant): OleVariant;
var
  ppr, vr : variant;
  me  : TMes;
begin
  ppr:=VarArrayCreate([0, 9], varVariant);
  ppr[0]:=error_op; //  код последней ошибки
  If SDM.hard_close Then ppr[1]:=1 Else ppr[1]:=0; // общий запрет на работу с сервером 1, разрешение 0
  if monopolise then ppr[1]:=0;

  ppr[2]:=null; //  личный запрет на коннекцию к серверу 1, 0 - разрешение
  ppr[3]:=SDM.time_close; //  время запрета на коннекцию в милисекундах
  ppr[4]:=SDM.GetUserList; //  массив он-лайн пользователей в сети
  ppr[5]:=SDM.r_mes_sect(usernik); //  массив не прочитанных сообщений
  //WriteLogFile(1,'Статус','Сообщения: '+String(ppr[5]));
  ppr[6]:=calcstate; //  индикация расчётного режима. 1 - расчёт выполнен. 2 - идёт расчёт, 3 - загрузка результатов; -1 - расчет прерван по ошибке. 0 - нет расчета.
  if SDM.debugmore Then SDM.WriteLogFile(4,'---- Статус','состояние расчета: '+String(ppr[6]));
  if (calcstate<2)and(calcstate<>0) then timerRetCalcstate.Enabled:=true;
  
  //WriteLogFile(4,'GetStatus', '6');
  ppr[7]:=ProcentCalc; //  процент выполнения расчёта.
  //WriteLogFile(4,'GetStatus', '7');
  ppr[8]:=null;

  if SDM.resetnom<>lresetnom then Begin
     lresetnom:=SDM.resetnom;
     ReLoadSQL;
     ReSetINIConfig;
  end;

  if not VarIsNull(params) then Begin
     if params[0]=1 then Begin
        ReLoadSQL;
        ReSetINIConfig;
     end;
     if (params[1]=1) and (userrole<20) then Begin
        SDM.hard_close:=true;
        SDM.time_close:=params[2];
        SDM.WriteLogFile(2,'System service','(GetStatus)It send direction for users DESCONNECT');
     end;
     if not VarIsNull(params[3]) then Begin
        vr:=params[3]; // Передача текстового сообщения (почта)
        me.user:=vr[0];
        me.from:=usernik;
        me.date:=datetostr(now);
        me.time:=timetostr(now);
        me.msg:=vr[1];
        SDM.WriteLogFile(1,'Статус','Передача сообщения: '+me.msg);
        SDM.write_message(me);
     end;
     if (params[4]=1) and (userrole<20) and (not SDM.monopol) then Begin
        SDM.hard_close:=true;
        monopolise:=true;
        SDM.monopol:=true;
        SDM.time_close:=params[2];
        SDM.WriteLogFile(2,'System service','(GetStatus) It send direction for users DESCONNECT. User '+usernik+' get status MONOPOLISE');
     end;
     if (params[4]=0) and monopolise then Begin
        SDM.hard_close:=false;
        monopolise:=false;
        SDM.monopol:=false;
        SDM.WriteLogFile(2,'System service','(GetStatus). User '+usernik+' return status MONOPOLISE');
     end;
     if (params[5]=1)and(userrole<20) then Inc(SDM.resetnom);
     
  end;
  //WriteLogFile(4,'GetStatus', 'end');
  ppr[9]:=now; //  серверное время
  Result:=ppr;
end;

function TRI_Modelserver.GetLastId: OleVariant;
begin
  Result:=lastid;
end;

function TRI_Modelserver.TestOperRites(kn: OleVariant): OleVariant;
var
  params, res : variant;
Begin
  Result:=-1; // не работает
  params:=VarArrayCreate([0, 1], varVariant);
  params[0]:=VarArrayOf(['kn']);
  params[1]:=VarArrayOf([kn]);
  res:=GetTehData('Nyk235',params,null);
  if not VarIsNull(res) then Result:=Integer(res)
  Else Begin
     Result:=-1;
     SDM.WriteLogFile(0,'Проверка прав на операцию','(TestOperRites) kn='+kn+' для пользователя '+usernik+' результат отрицательный.');
  end;
end;

function TRI_Modelserver.IsOperationRite(kn: OleVariant): OleVariant;
begin
  Result:=0; // РАБОЧАЯ!!! процедура
  q_oper_rite.Active:=false;
  q_oper_rite.ParamByName('kn').AsString:=kn;
  q_oper_rite.ParamByName('rol').AsInteger:=userrole;
  q_oper_rite.Prepare;
  try
    q_oper_rite.Open;
    if q_oper_rite.Active then
       if q_oper_rite.RecordCount>0 then
          if q_oper_rite.FieldByName('kvo').AsInteger>0 then Result:=1;
    q_oper_rite.Active:=false;

    q_oper_rt_g.Active:=false;
    q_oper_rt_g.ParamByName('uid').AsInteger:=userid;
    q_oper_rt_g.ParamByName('kn').AsString:=kn;
    q_oper_rt_g.Prepare;
    q_oper_rt_g.Active:=true;
       If q_oper_rt_g.RecordCount>0 Then
         case q_oper_rt_g.FieldByName('res').AsInteger of
              1 : Result:=1;
             -1 : Result:=0;
         end;
    q_oper_rt_g.Active:=false;

  except
    Result:=-1;
    SDM.WriteLogFile(0,'Проверка прав на операцию','(IsOperationRite) kn='+kn+' для пользователя '+usernik+'. Ошибка операции!');
  end;
end;

Function TRI_Modelserver.RunIbScript(script : string) : boolean;
Begin
  If not IBDB.Connected Then Begin
     result:=false;
     Exit;
  end;
  ib_script.Script.Text:=script;
  StartTrans;
  try
    ib_script.ExecuteScript;
    Result:=true;
    CommTrans;
  except
    Result:=False;
    BackTrans;
  end;
end;

function TRI_Modelserver.RunScript(kn, script: OleVariant): OleVariant;
var
  res : variant;
begin
   If not IBDB.Connected Then Begin
     result:=-1;
     Exit;
   end;
   Result:=null;
   res:=IsOperationRite(kn);
   if not VarIsNull(res) then
      if Integer(res)>0 then Begin
         SDM.WriteLogFile(1,'Операции с БД','(RunScript) Права на запуск скрипта получены.');
         if RunIbScript(script) then Begin
            Result:=0;
            SDM.WriteLogFile(1,'Операции с БД','(RunScript) Скрипт выполнен удачно!');
         end
         Else Begin
           Result:=3;
           SDM.WriteLogFile(0,'Операции с БД','(RunScript) При выполнении скрипта возникла ошибка.');
           SDM.WriteLogFile(0,'Операции с БД','(RunScript) Скрипт:'+script);
         end;

      end
      Else Result:=1;
end;

Function TRI_Modelserver.StrAnyChar(str : string;dir,ll,ee : integer) : string;
var
  len,po : integer;
  ss,ext : string;
  ii : integer;
Begin
  len:=Length(str);
  ss:=str;
  ext:='';
  if ee>0 then Begin
     for ii := 0 to len - 1 do if ss[ii]=',' then ss[ii]:='.';
     po:=pos('.',ss);
     if po=0 then ss:=ss+'.';
     len:=Length(ss);
     while (len-pos('.',ss))<ee do Begin
       ss:=ss+'0';
       len:=Length(ss);
     end;
  end;

  While len<ll Do Begin
    Inc(len);
    CASE dir of
         0 : ss:=ss+' ';
         1 : ss:=' '+ss;
    end;
  end;
  Result:=ss;
end;

Function TRI_Modelserver.MakeFormatStr(par,len, ext : variant;br : string) : string;
var
  cc,ii,dd : integer;
  ss,st : string;
Begin
  Result:='';
  ss:='';
  cc:=VarArrayHighBound(par,1);
  If cc<>VarArrayHighBound(len,1) Then Exit;
  For ii:=0 To cc Do Begin
     Case VarType(par[ii]) of
      varNull      : st:=' ';
      varSmallint  : st:=IntToStr(par[ii]);
      varInteger   : st:=IntToStr(par[ii]);
      varSingle    : st:=FloatToStrF(par[ii],ffFixed,15,3);
      varDouble    : st:=FloatToStrF(par[ii],ffFixed,15,3);
      varDate      : st:=DateToStr(par[ii]);
      varBoolean   : If Boolean(par[ii]) Then st:='TRUE' Else st:='FALSE';
      varVariant   : st:=par[ii];
      varString    : st:=par[ii];
      varOleStr    : st:=par[ii];

      Else st:=String(par[ii]);
     end;
     
     if len[ii]>0 Then dd:=0 Else dd:=1;

     st:=StrAnyChar(st,dd,Trunc(ABS(len[ii])),Integer(ext[ii]));

     //if ii=2 then WriteLogFile(4,'MakeFormatStr','ii='+IntToStr(ii)+' res='+st+' ish'+String(par[ii]));

     If ii=0 Then ss:=st Else ss:=ss+br+st;
  end;
  Result:=ss;
end;

Function TRI_Modelserver.ElementCalcToDB(ename,defn,kn : string; tpc : integer) : boolean;
var
  file_ini_name, in_extention, in_params_filename, in_file_extation : string;
  ss,br,s2 : string;
  cc, ii, len, mn, jj, sst, vint, co, ij : integer;
  vreal : Extended;
  re,pr,pnam,ptype,pval,pround : variant;
  ttt : char;
  inis,inis2 : TMemIni;
  ls : TStringList;
Begin
  if kn='Nyk___' then Begin
     // пропускаем не настроенные элементы
     Result:=true;
     Exit;
  end;
  if SDM.debugmore Then sst:=4 Else sst:=1;
  // if kn='Nyk999' Then sst:=4;
  SDM.WriteLogFile(4,'ElementCalcToDB','Закачка  ='+ename);

  Result:=false;

  ls:=TStringList.Create;
  ls.LoadFromFile(SDM.serverpath+'modelserver.ini');
  inis:=TMemIni.Create(ls.Text);

  //  ModuleCalcSW.filename:=inis.ReadString('MODUL'+IntToStr(curCalc.modid),'switch','ian');


  file_ini_name:=inis.ReadString('Files',ename,defn);
  case tpc of
       0 : Begin // расчетные данные модуля 1 без обратного действия
           in_extention:=inis.ReadString('MODUL'+IntToStr(curCalc.modid),'in_param_extation','.ipf');
           in_file_extation:=inis.ReadString('MODUL'+IntToStr(curCalc.modid),'in_file_extation','.4cc');
       end;
       1 : Begin // расчетные данные модуля 1 с обратным действием
           in_extention:=inis.ReadString('MODUL'+IntToStr(curCalc.modid),'imod_param_extation','.imf');
           in_file_extation:=inis.ReadString('MODUL'+IntToStr(curCalc.modid),'imod_file_extation','.3cc');
       end;
       2 : Begin // дополнительный расчетный модуль
           in_extention:=inis.ReadString('CALC','in_param_extation','.ipf');
           in_file_extation:=inis.ReadString('CALC','in_file_extation','.5cc');
       end;
  end;

  SDM.WriteLogFile(sst,'ElementCalcToDB','Закачка  = 1');

  in_params_filename:=calcpath+file_ini_name+in_file_extation; // результаты расчета
  file_ini_name:=SDM.serverpath+file_ini_name+in_extention;  // формат результатов расчета

  if not FileExists(in_params_filename) then Begin
      // пропускаем отсутствующие элементы
      SDM.WriteLogFile(sst,'ElementCalcToDB','пропускаем отсутствующие элементы');
     Result:=true;
     ls.Free;
     inis.free;
     Exit;
  end;

  SDM.WriteLogFile(sst,'ElementCalcToDB','Закачка  = 2... '+file_ini_name);

  ls.Clear;
  ls.LoadFromFile(file_ini_name);
  inis2:=TMemIni.Create(ls.Text);

  ss:=inis2.ReadString('Fields','count','0');
  if ss='0' then Begin
    SDM.WriteLogFile(0,'ElementCalcToDB',' ss=0');
    ls.Free;
    inis.free;
    inis2.free;
    Exit;
  end;

  SDM.WriteLogFile(sst,'ElementCalcToDB','закачка  = 3... ss='+ss);

  try
    len:=StrToInt(ss);
  except
    SDM.WriteLogFile(0,'ElementCalcToDB',' ss не число');
    ls.Free;
    inis.free;
    inis2.free;
    Exit;
  end;
  br:=inis2.ReadString('Design','break','!');

  SDM.WriteLogFile(sst,'ElementCalcToDB','закачка  = 4... Len='+IntToStr(len));


  pnam:=VarArrayCreate([0, len-1], varVariant);  // имена полей
  ptype:=VarArrayCreate([0, len-1], varVariant); // типы данных
  pval:=VarArrayCreate([0, len-1], varVariant); // одна запись данных
  pround:=VarArrayCreate([0, len-1], varVariant); // признак округления данных (0-нет округления, >0 число разрядов после запятой)

  SDM.WriteLogFile(sst,'ElementCalcToDB','Закачка  = 5');

  for ii := 0 to len - 1 do Begin
     pnam[ii]:=inis2.ReadString('Fields',IntToStr(ii+1),'');
     ptype[ii]:=inis2.ReadString('Types',IntToStr(ii+1),'I');
     pround[ii]:=inis2.ReadString('Round',IntToStr(ii+1),'0');
  end;

  SDM.WriteLogFile(sst,'ElementCalcToDB','Закачка  = 6');

  pr:=VarArrayCreate([0, 1], varVariant);
  pr[0]:=pnam;
  //pr[1]:=VarArrayOf([params[0]]);

  ls.Clear;
  ls.LoadFromFile(in_params_filename);
  co:=ls.Count;

  For ij:=0 to co-1 do Begin
    ss:=ls.Strings[ij];
    ttt:=br[1];
   // WriteLogFile(4,'ElementCalcToDB','ReadLn='+ss);
    ss:=CorrectFormatStr(ss,ttt);
   // WriteLogFile(4,'ElementCalcToDB','после чистки ReadLn=/'+ss+'/ ttt='+ttt);
    if ss<>'' then Begin
       re:=AnalizeStr(ss,ttt,true);
       if not VarIsNull(re) then Begin
          cc:=VarArrayHighBound(re,1);
          if cc<>(len-2) then Begin
             SDM.WriteLogFile(0,'ElementCalcToDB',' описание не совпадает с числом параметров результата расчетов:'+IntToStr(cc+1)+' - '+in_params_filename);
             ls.Free;
             inis.free;
             inis2.free;
             Exit;
          end;
          for ii := 0 to cc do Begin
              ttt:=String(ptype[ii])[1];
              SDM.WriteLogFile(sst,'ElementCalcToDB','сопоставляем элемент закачки  ==== '+IntToStr(ii));
              s2:=TestCharModulationString(String(re[ii]));
              if (s2='*')or(String(re[ii])='NaN') then SDM.WriteLogFile(0,'ElementCalcToDB','Неверный формат! Элемент: '+ename+' размер ячейки '+IntToStr(ii)+' переполнен значением '+String(re[ii]));
              case ttt of
                 'I' : Begin
                        vint:=0;
                        if (s2='*')or(String(re[ii])='NaN') then pval[ii]:=0
                        Else
                        If not TryStrToInt(String(re[ii]),vint) Then Begin
                          pval[ii]:=0;
                          SDM.WriteLogFile(0,'ElementCalcToDB','Неверный формат! Элемент: '+ename+' Значение ячейки '+IntToStr(ii)+' не INTEGER! = '+String(re[ii]));
                        end
                        Else pval[ii]:=vint;
                       end;
                 'R' : Begin
                        vreal:=0;
                        if (s2='*')or(String(re[ii])='NaN') then pval[ii]:=0
                        Else
                         Begin
                         vint:=-1;
                         Val(String(re[ii]),vreal,vint);
                         if (not TryStrToFloat(String(re[ii]),vreal))and(vint<>0) Then Begin
                          pval[ii]:=0;
                          SDM.WriteLogFile(0,'ElementCalcToDB','Неверный формат! Элемент: '+ename+' Значение ячейки '+IntToStr(ii)+' не REAL! = '+String(re[ii])+' DS='+String(DecimalSeparator));
                         end
                         Else
                         if pround[ii]='0' then pval[ii]:=Real(re[ii])
                           Else Begin
                             mn:=1;
                             for jj:=1 to Integer(pround[ii]) do mn:=mn*10;
                             pval[ii]:=Round(Real(re[ii])*mn)/mn;
                           end;
                         end;
                       end;
                 'S' : pval[ii]:=String(re[ii]);
              end;
          end;
          pval[len-1]:=curCalc.id;
          pr[1]:=pval;
          SDM.WriteLogFile(sst,'ElementCalcToDB','RunSQL  ==== Start '+kn);
          re:=RunSQL(kn, pr, curCalc.mainmaps);
          SDM.WriteLogFile(sst,'ElementCalcToDB','RunSQL  ==== '+String(re));
          if re<>0 then Begin
             SDM.WriteLogFile(sst,'ElementCalcToDB',' Ошибка вставки SQL='+kn+' --- '+String(re));
             ls.Free;
             inis.free;
             inis2.free;
             Exit;
          end;
       end;
    end;
  end;
  SDM.WriteLogFile(4,'ElementCalcToDB','Залито Ок!');
  //dbdirect=calcmapid
  Result:=true; 
  ls.Free;
  inis.free;
  inis2.free;
end;

Function TRI_Modelserver.ElementToCalc(ename,defn,kn : string; par : variant; periud : integer) : boolean;
var
  file_ini_name, out_extention, out_params_filename, out_file_extation : string;
  ss, s2,br, brp, coment_prn : string;
  cc, c2, startp, ii, korrect : integer;
  re,pp,ll,ee : variant;
  inis,inis2 : TMemIni;
  ls : TStringList;
Begin
  coment_prn:='';
  if kn='Nyk___' then Begin
    Result:=true;
    SDM.WriteLogFile(4,'ElementToCalc','Element: '+defn+' Пропущен.');
    Exit;
  end;
  ls:=TStringList.Create;
  ls.LoadFromFile(SDM.serverpath+'modelserver.ini');
  inis:=TMemIni.Create(ls.Text);

  Result:=false;
  out_extention:=inis.ReadString('MODUL'+IntToStr(curCalc.modid),'out_params_extation','.par');
  //WriteLogFile(4,'ElementToCalc','1 '+out_extention);

  out_file_extation:=inis.ReadString('MODUL'+IntToStr(curCalc.modid),'out_file_extation','.2cc');
  //WriteLogFile(4,'ElementToCalc','2 '+out_file_extation);

  file_ini_name:=inis.ReadString('Files',ename,defn);
  //WriteLogFile(4,'ElementToCalc','3 '+file_ini_name);

  out_params_filename:=calcpath+file_ini_name+out_file_extation;
  //WriteLogFile(4,'ElementToCalc','4 '+out_params_filename);

  file_ini_name:=SDM.serverpath+file_ini_name+out_extention;
  //WriteLogFile(4,'ElementToCalc','5 '+file_ini_name);

  ls.Clear;
  ls.LoadFromFile(file_ini_name);
  inis2:=TMemIni.Create(ls.Text);

  ss:=inis2.ReadString('Fields','count','0');
  s2:=inis2.ReadString('PARAM','count','0');
  //WriteLogFile(4,'ElementToCalc','6 '+ss);

  if periud<0 then korrect:=-1 Else korrect:=0;


  if ss='0' then Begin
    SDM.WriteLogFile(0,'ElementToCalc',' ss=0');
    ls.Free;
    inis.free;
    inis2.Free;
    Exit;
  end;
  try
    cc:=StrToInt(ss);
  except
    SDM.WriteLogFile(0,'ElementToCalc',' ss не число');
    ls.Free;
    inis.free;
    inis2.Free;
    Exit;
  end;
  c2:=0;
  startp:=0;  //стартовая позиция дополнительных параметров
  if s2<>'0' then Begin
    try
      c2:=StrToInt(s2);  // количество дополнительных параметров
      s2:= inis2.ReadString('PARAM','start','');
      startp:=StrToInt(s2);
    except
      c2:=0;
    end;
  end;

  br:=inis2.ReadString('Design','break','!');
  brp:=inis2.ReadString('Design','breakp',' ');
  coment_prn:=inis2.ReadString('Coments','show','0');

  //WriteLogFile(4,'ElementToCalc','7 '+br+'  '+coment_prn);

  pp:=VarArrayCreate([0, cc+korrect+c2], varVariant);
  ll:=VarArrayCreate([0, cc+korrect+c2], varVariant);
  ee:=VarArrayCreate([0, cc+korrect+c2], varVariant);

  try
    try
      //WriteLogFile(4,'ElementToCalc','7a '+kn);
      re:=GetData(kn,par,null);
      //WriteLogFile(4,'ElementToCalc','8 '+kn);

      If VarIsNull(re) Then Begin
         SDM.WriteLogFile(0,'ElementToCalc','Bad SQL '+kn);
         Raise EMathError.Create('');
      end;
      cds_work_with_me.active:=false;
      cds_work_with_me.Data:=re;
      SDM.WriteLogFile(4,'ElementToCalc','Element: '+defn+' Count rows: '+IntToStr(cds_work_with_me.RecordCount));

      ls.Clear;
      if periud>0 then ls.LoadFromFile(out_params_filename); 

      //WriteLogFile(4,'ElementToCalc','10 Открыли файл для записи');
      if korrect>=0 then Begin
         ll[0]:=-3;
         ee[0]:=0;
         If coment_prn='1' Then ls.add('0. Номер периуда');
         pp[0]:=IntToStr(periud);
      end;
      For ii:=1 to cc+c2 Do Begin  //Подпись шапки таблицы вывода расчётных данных в файл
         ll[ii+korrect]:=StrToInt(inis2.ReadString('Len',IntToStr(ii),'1'));
         If coment_prn='1' Then Begin
           ss:=inis2.ReadString('Coments',IntToStr(ii),'');
           If ss<>'' Then ls.add(IntToStr(ii)+'. '+ss);
         end;
         ee[ii+korrect]:=StrToInt(inis2.ReadString('Ext',IntToStr(ii),'0'));
      end;
      ls.add('');

      While not cds_work_with_me.EOF Do Begin
        For ii:=1 To cc+NumAnalize(c2) Do Begin
           //WriteLogFile(1,'ElementToCalc','ii='+IntToStr(ii));
           ss:=inis2.ReadString('Fields',IntToStr(ii),'');
           if ss<>'' Then pp[ii+korrect]:=cds_work_with_me.FieldByName(ss).Value;
           //if ss='ENG_LOADING' then WriteLogFile(4,'ElementToCalc','file='+out_params_filename+'  NAME='+ss+' res='+String(pp[ii-1]));
        end;
        if c2>0 then Begin
           //WriteLogFile(1,'ElementToCalc','+++ str='+String(pp[startp]));
           re:=AnalizeStr(String(pp[startp+korrect]),brp[1],false);
           if VarIsNull(re) then SDM.WriteLogFile(0,'ElementToCalc','Пустая строка вместо доп параметров!');
           for ii := startp to cc+c2 do Begin
             //WriteLogFile(1,'ElementToCalc','+++ ii='+IntToStr(ii)+' kor='+IntToStr(korrect)+' start='+IntToStr(startp)+' pp[ii+korrect]:=re[ii-startp]');
             //WriteLogFile(1,'ElementToCalc','+++ re='+re[ii-startp]);
             pp[ii+korrect]:=re[ii-startp];
           end;
        end;
        ss:=MakeFormatStr(pp,ll,ee,br);
        //WriteLogFile(1,'ElementToCalc !!!!',ss);
        ls.add(ss);
        cds_work_with_me.Next;
      end;
      ls.SaveToFile(out_params_filename);
      Result:=true;
      //WriteLn(ff,str);
    finally
      cds_work_with_me.active:=false;
      ls.Free;
      inis.free;
      inis2.Free;
    end;
  except
     SDM.WriteLogFile(0,'ElementToCalc','OUT блин!');
  end;
end;

Function TRI_Modelserver.CreateCalcDB : boolean;
var
  ss,dbn, er : string;
  id : integer;
  sm : TNykSQL;
Begin
  Result:=IBDbCalc.Connected;
  if Result then Begin
    Exit;
  end;

  SDM.WriteLogFile(4,'CreateCalcDB','Enter');

  if SDM.CalcOneBase then Begin
     IBDbCalc.DatabaseName:=SDM.dbservername+':'+SDM.dbCalcName+'MODEL_CALC.GDB';
     SDM.WriteLogFile(1,'БД name',IBDbCalc.DatabaseName);
     ss:='user_name='+SDM.dbusr;
     IBDbCalc.Params.Add(ss);
     ss:='password='+SDM.dbpass;
     IBDbCalc.Params.Add(ss);
     ss:='lc_ctype=WIN1251';
     IBDbCalc.Params.Add(ss);
     IBDbCalc.Connected:=true;
     SDM.WriteLogFile(4,'CreateCalcDB','коннект ДБ!');
     if IBDbCalc.Connected then Result:=true;
     Exit;
  end;


  id:=GetNextId('GENERAL');
  dbn:=SDM.dbservername+':'+SDM.dbCalcName+IntToStr(id)+'.tmp';
  IBDbCalc.DatabaseName:=dbn;
  SDM.WriteLogFile(4,'БД calc name',dbn);
  ss:='user '''+SDM.dbusr+''' password '''+SDM.dbpass+'''';
  IBDbCalc.Params.Add(ss);
  ss:='page_size 4096';
  IBDbCalc.Params.Add(ss);
  ss:='default character set win1251';
  IBDbCalc.Params.Add(ss);
  //WriteLogFile(4,'БД name',IBDbCalc.Params.Text);

  try
    IBDbCalc.CreateDatabase;
  except
    on E: Exception do Begin
       er:=E.Message;
       SDM.WriteLogFile(0,'Временная БД','Не удалось создать временную БД: '+dbn);
       SDM.WriteLogFile(0,'Временная БД','Причина ошибки: '+er);
       Exit;
    end;
  end;
  IBDbCalc.Connected:=false;
  IBDbCalc.Params.Clear;
  SDM.WriteLogFile(1,'БД name',IBDbCalc.DatabaseName);
  ss:='user_name='+SDM.dbusr;
  IBDbCalc.Params.Add(ss);
  ss:='password='+SDM.dbpass;
  IBDbCalc.Params.Add(ss);
  ss:='lc_ctype=WIN1251';
  IBDbCalc.Params.Add(ss);
  IBDbCalc.Connected:=true;

  // создать структуру ДБ

  // ib_script_c

  //sm:=GetSQL('Nyk619');
  sm:=LoadSQL('Nyk619');

  if sm=nil then Begin
    SDM.WriteLogFile(0,'Временная БД','Не удалось найти скрипт создания БД: Nyk619');
    Exit;
  end;
  sm.ReActivate;
  if (not sm.CanDoIt) and (not sys_op) then Begin
    SDM.WriteLogFile(0,'Временная БД','Не хватает прав пользователя для создания временной БД: Nyk619');
    Exit;
  end;
  ib_script_c.Script.Text:=sm.SQL.Text;
  try
    StartTransC;
    ib_script_c.ExecuteScript;
  except
    SDM.WriteLogFile(0,'Временная БД','Ошибка выполнения скрипта создания временной БД');
    IBDbCalc.DropDatabase;
    Exit;
  end;
  CommTransC;
  StartTransC;
  try
    q_dualset_c.ExecSQL;
  except
    //IBDbCalc.DropDatabase;
    BackTransC;
    SDM.WriteLogFile(0,'Временная БД','Ошибка инициирования таблици DUAL');
    Exit;
  end;
  CommTransC;

  SDM.WriteLogFile(4,'Временная БД','Временная БД создана удачно! '+dbn);

  Result:=true;
end;

Function TRI_Modelserver.MakeCalkFolder : string;
var
  ss : string;
Begin
  ss:=SDM.GetUnicalString(1,userid);
  ss:=SDM.serverpath+usernik+'-TEMPDIR-'+ss+'\';
  try
    mkdir(ss);
    Result:=ss;
  except
    Result:='';
  end;
end;

Function TRI_Modelserver.PutCalcModul(foldername : string; c_type : integer) : boolean;
var
 filname,ss : string;
Begin
  // Размещение расчётного модуля из БД в расчётную временную директорию
  Result:=false;
  q_files.Active:=false;
  q_files.ParamByName('ctp').AsInteger:=c_type;
  q_files.Prepare;
  try
    q_files.Open;
  except
    Exit;
  end;
  if q_files.RecordCount=0 then Begin
     q_files.Active:=false;
     Exit;
  end;
  q_files.first;
  ss:=foldername;
  if foldername[length(foldername)]<>'\' then ss:=ss+'\';
  While not q_files.EOF Do Begin
    filname:=q_files.FieldByName('NAME').AsString;
    SDM.WriteLogFile(4,'PutCalcModul','Сохраняемый файл расчётного модуля: '+ss+filname);
    TBlobField(q_files.FieldByName('Fbody')).SaveToFile(ss+filname);
    q_files.Next;
  end;
  Result:=true;
  SDM.WriteLogFile(1,'PutCalcModul','Сохраняемые файлы видимо сохранены! ');
  q_files.Active:=false;
end;

Function TRI_Modelserver.DeleteFolder(foldername : string) : integer;
var
sh:SHFILEOPSTRUCT;
ss:string;
//sr:tsearchrec;
//pst:pchar;
ii : integer;
Begin
  // удаление временной папки
  Result:=0;
  if SDM.debugmore or SDM.savecalcdirmode Then begin
     SDM.WriteLogFile(4,'DeleteFolder', 'No deleted: '+ss);
     Result:=2;
     Exit;
  end;
  if foldername[length(foldername)]='\' then ss:=copy(foldername,1,length(foldername)-1)
  Else ss:=foldername;
  SDM.WriteLogFile(4,'DeleteFolder', 'Enter: '+ss);
  if DirectoryExists(ss) then
    begin
      sh.Wnd:= 0;
      sh.wFunc:= FO_DELETE;
      sh.pFrom := PChar(ss);
      sh.pTo := Nil;
      sh.fFlags := FOF_NOCONFIRMATION or FOF_SILENT;
      try
        ii:=SHFileOperation(sh);
        if ii=0 then Begin
           SDM.WriteLogFile(1,'DeleteFolder', 'Delete: '+IntToStr(ii));
           Result:=1;
        end
        Else SDM.WriteLogFile(0,'DeleteFolder', 'Error Folder Delete: '+IntToStr(ii)+' folder name: '+ss);
      except
        SDM.WriteLogFile(0,'DeleteFolder', 'Delete failed '+ss);
        Result:=-1;
      end;
    end;
end;

function TRI_Modelserver.SendElementsToCalc(mapid,periud:integer) : boolean;
var
  par : variant;
Begin
  Result:=false;
  SDM.WriteLogFile(4,'Выгрузка расчётных данных','Выгружаем данные по схеме №: '+IntToStr(mapid));

if periud=0 then Begin
  //++++++++++++ТИПЫ синхронных двигателей и генераторов+++++++++++
  par:=null;
  if not ElementToCalc('SENTYPE','syn_type','Nyk460',par,-1) then Begin
    SDM.WriteLogFile(0,'Выгрузка расчётных данных','Не удалось выгрузить Типы синхронных двигателей и генераторов!');
    Exit
  end
  Else SDM.WriteLogFile(1,'Выгрузка расчётных данных','Типы синхронных двигателей и генераторов выгружены!');

  //++++++++++++ТИПЫ асинхронных двигателей+++++++++++
  par:=null;
  if not ElementToCalc('AENTYPE','asyn_type','Nyk613',par,-1) then Begin
    SDM.WriteLogFile(0,'Выгрузка расчётных данных','Не удалось выгрузить Типы асинхронных двигателей!');
    Exit
  end
  Else SDM.WriteLogFile(1,'Выгрузка расчётных данных','Типы асинхронных двигателей выгружены!');

  //++++++++++++ТИПЫ реакторов+++++++++++
  par:=null;
  if not ElementToCalc('RECTYPE','rec_type','Nyk674',par,-1) then Begin
    SDM.WriteLogFile(0,'Выгрузка расчётных данных','Не удалось выгрузить Типы реакторов!');
    Exit
  end
  Else SDM.WriteLogFile(1,'Выгрузка расчётных данных','Типы реакторов выгружены!');

  //++++++++++++ТИПЫ реакторов СТК+++++++++++
  par:=null;
  if not ElementToCalc('STKTYPE','stk_type','Nyk675',par,-1) then Begin
    SDM.WriteLogFile(0,'Выгрузка расчётных данных','Не удалось выгрузить Типы реакторов СТК!');
    Exit
  end
  Else SDM.WriteLogFile(1,'Выгрузка расчётных данных','Типы реакторов СТК выгружены!');

  //++++++++++++Справочник законов регулирования возбуждением+++++
  if not ElementToCalc('LAWEX','loaw_excitation','Nyk461',par,-1) then Begin
    SDM.WriteLogFile(0,'Выгрузка расчётных данных','Не удалось выгрузить Законы регулирования возбуждения!');
    Exit
  end
  Else SDM.WriteLogFile(1,'Выгрузка расчётных данных','Законы регулирования возбуждения выгружены!');

  par:=VarArrayCreate([0, 1], varVariant);
  par[0]:=VarArrayOf(['W']);
  par[1]:=VarArrayOf([1]);

  //++++++++++++Справочник автотрансформаторов+++++
  if not ElementToCalc('TTRANSA','trans_type_a','Nyk472',par,-1) then Begin
    SDM.WriteLogFile(0,'Выгрузка расчётных данных','Не удалось выгрузить Типы автотрансформаторов!');
    Exit
  end
  Else SDM.WriteLogFile(1,'Выгрузка расчётных данных','Таблица Типов автотрансформаторов выгружена!');

  //++++++++++++Справочник типов ПАРН+++++
  if not ElementToCalc('TPARN','parn_type','Nyk610',par,-1) then Begin
    SDM.WriteLogFile(0,'Выгрузка расчётных данных','Не удалось выгрузить Типы ПАРН!');
    Exit
  end
  Else SDM.WriteLogFile(1,'Выгрузка расчётных данных','Таблица Типов ПАРН выгружена!');

  par[0]:=VarArrayOf(['W']);
  par[1]:=VarArrayOf([2]);

  //++++++++++++Справочник трансформаторов 2+++++
  if not ElementToCalc('TTRANS2','trans_type_2','Nyk472',par,-1) then Begin
    SDM.WriteLogFile(0,'Выгрузка расчётных данных','Не удалось выгрузить Типы трансформаторов 2обм.!');
    Exit
  end
  Else SDM.WriteLogFile(1,'Выгрузка расчётных данных','Таблица Типов трансформаторов 2обм. выгружена!');

   par[0]:=VarArrayOf(['W']);
  par[1]:=VarArrayOf([-3]);

  //++++++++++++Справочник трансформаторов с расщепленной обмоткой+++++
  if not ElementToCalc('TTRANS2R','trans_type_2r','Nyk472',par,-1) then Begin
    SDM.WriteLogFile(0,'Выгрузка расчётных данных','Не удалось выгрузить Типы трансформаторов расщепленной обм.!');
    Exit
  end
  Else SDM.WriteLogFile(1,'Выгрузка расчётных данных','Таблица Типов трансформаторов расщепленной обм. выгружена!');

  par[0]:=VarArrayOf(['W']);
  par[1]:=VarArrayOf([3]);

  //++++++++++++Справочник трансформаторов 3+++++
  if not ElementToCalc('TTRANS3','trans_type_3','Nyk472',par,-1) then Begin
    SDM.WriteLogFile(0,'Выгрузка расчётных данных','Не удалось выгрузить Типы трансформаторов 3 обм.!');
    Exit
  end
  Else SDM.WriteLogFile(1,'Выгрузка расчётных данных','Таблица Типов трансформаторов 3обм. выгружена!');

end;

  par:=VarArrayCreate([0, 1], varVariant);
  par[0]:=VarArrayOf(['map']);
  par[1]:=VarArrayOf([mapid]);

  //++++++++++++Таблица СД+++++
  if not ElementToCalc('SD','sd','Nyk462',par,periud) then Begin
    SDM.WriteLogFile(0,'Выгрузка расчётных данных','Не удалось выгрузить СД!');
    Exit
  end
  Else SDM.WriteLogFile(1,'Выгрузка расчётных данных','Таблица СД выгружена!');

  //++++++++++++Таблица АД+++++
  if not ElementToCalc('AD','ad','Nyk463',par,periud) then Begin
    SDM.WriteLogFile(0,'Выгрузка расчётных данных','Не удалось выгрузить АД!');
    Exit
  end
  Else SDM.WriteLogFile(1,'Выгрузка расчётных данных','Таблица АД выгружена!');

  //++++++++++++Таблица Выключателей+++++
  if not ElementToCalc('KEY','key','Nyk464',par,periud) then Begin
    SDM.WriteLogFile(0,'Выгрузка расчётных данных','Не удалось выгрузить Выключатели!');
    Exit
  end
  Else SDM.WriteLogFile(1,'Выгрузка расчётных данных','Таблица Выключателей выгружена!');

  //++++++++++++Шина бесконечной мощьности+++++
  if not ElementToCalc('POWER','power','Nyk466',par,periud) then Begin
    SDM.WriteLogFile(0,'Выгрузка расчётных данных','Не удалось выгрузить Шины бесконечной мощности!');
    Exit
  end
  Else SDM.WriteLogFile(1,'Выгрузка расчётных данных','Таблица Шин бесконечной мощности выгружена!');

  //++++++++++++Синхронный генератор+++++
  if not ElementToCalc('GENER','generator','Nyk467',par,periud) then Begin
    SDM.WriteLogFile(0,'Выгрузка расчётных данных','Не удалось выгрузить Синхронные генераторы!');
    Exit
  end
  Else SDM.WriteLogFile(1,'Выгрузка расчётных данных','Таблица Синхронных генераторов выгружена!');

  //++++++++++++Концентрированая нагрузка+++++
  if not ElementToCalc('NAGR','nagruzka','Nyk468',par,periud) then Begin
    SDM.WriteLogFile(0,'Выгрузка расчётных данных','Не удалось выгрузить Нагрузку!');
    Exit
  end
  Else SDM.WriteLogFile(1,'Выгрузка расчётных данных','Таблица Нагрузки выгружена!');

  //++++++++++++Конденцаторыные батареи+++++
  if not ElementToCalc('BSK','bsk','Nyk672',par,periud) then Begin
    SDM.WriteLogFile(0,'Выгрузка расчётных данных','Не удалось выгрузить БСК!');
    Exit
  end
  Else SDM.WriteLogFile(1,'Выгрузка расчётных данных','Таблица БСК выгружена!');

  //++++++++++++ПС, кусты, площадки+++++
  if not ElementToCalc('SS','obj','Nyk823',par,periud) then Begin
    SDM.WriteLogFile(0,'Выгрузка расчётных данных','Не удалось выгрузить Подстанции!');
    Exit
  end
  Else SDM.WriteLogFile(1,'Выгрузка расчётных данных','Таблица Подстанций выгружена!');

  //++++++++++++Воздушные линии+++++
  if not ElementToCalc('VL','vl','Nyk469',par,periud) then Begin
    SDM.WriteLogFile(0,'Выгрузка расчётных данных','Не удалось выгрузить ВЛ!');
    Exit
  end
  Else SDM.WriteLogFile(1,'Выгрузка расчётных данных','Таблица ВЛ выгружена!');

  //++++++++++++Кабельные линии и токопроводы+++++
  if not ElementToCalc('CL','cl','Nyk470',par,periud) then Begin
    SDM.WriteLogFile(0,'Выгрузка расчётных данных','Не удалось выгрузить КЛ!');
    Exit
  end
  Else SDM.WriteLogFile(1,'Выгрузка расчётных данных','Таблица КЛ и токопроводов выгружена!');

  //++++++++++++Связи+++++
  if not ElementToCalc('CONNECTS','connects','Nyk471',par,periud) then Begin
    SDM.WriteLogFile(0,'Выгрузка расчётных данных','Не удалось выгрузить Связи!');
    Exit
  end
  Else SDM.WriteLogFile(1,'Выгрузка расчётных данных','Таблица Связей выгружена!');

  //++++++++++++Трансформаторы 3-х обмоточные+++++
  if not ElementToCalc('T3','trans3','Nyk473',par,periud) then Begin
    SDM.WriteLogFile(0,'Выгрузка расчётных данных','Не удалось выгрузить 3-х трансвоматоры!');
    Exit
  end
  Else SDM.WriteLogFile(1,'Выгрузка расчётных данных','Таблица 3-х обмоточных трансформаторов выгружена!');

  //++++++++++++Трансформаторы 2-х обмоточные+++++
  if not ElementToCalc('T2','trans2','Nyk474',par,periud) then Begin
    SDM.WriteLogFile(0,'Выгрузка расчётных данных','Не удалось выгрузить 2-х трансвоматоры!');
    Exit
  end
  Else SDM.WriteLogFile(1,'Выгрузка расчётных данных','Таблица 2-х обмоточных трансформаторов выгружена!');

  //++++++++++++Трансформаторы с расщепленной обмоткой+++++
  if not ElementToCalc('T2R','trans2r','Nyk683',par,periud) then Begin
    SDM.WriteLogFile(0,'Выгрузка расчётных данных','Не удалось выгрузить трансвоматоры с расщепленной обмоткой!');
    Exit
  end
  Else SDM.WriteLogFile(1,'Выгрузка расчётных данных','Таблица 2-х обмоточных трансформаторов выгружена!');

  //++++++++++++ АвтоТрансформаторы +++++
  if not ElementToCalc('AT','a-trans','Nyk562',par,periud) then Begin
    SDM.WriteLogFile(0,'Выгрузка расчётных данных','Не удалось выгрузить Автотрансвоматоры!');
    Exit
  end
  Else SDM.WriteLogFile(1,'Выгрузка расчётных данных','Таблица Автотрансформаторов выгружена!');

  //++++++++++++ Реакторы +++++
  if not ElementToCalc('REK','reaktor','Nyk612',par,periud) then Begin
    SDM.WriteLogFile(0,'Выгрузка расчётных данных','Не удалось выгрузить Реакторы!');
    Exit
  end
  Else SDM.WriteLogFile(1,'Выгрузка расчётных данных','Таблица Реакторов выгружена!');

  //++++++++++++ Реакторы СТК+++++
  if not ElementToCalc('STK','stk','Nyk673',par,periud) then Begin
    SDM.WriteLogFile(0,'Выгрузка расчётных данных','Не удалось выгрузить Реакторы СТК!');
    Exit
  end
  Else SDM.WriteLogFile(1,'Выгрузка расчётных данных','Таблица Реакторов СТК выгружена!');

  //++++++++++++ ПАРНы +++++
  if not ElementToCalc('PARN','parn','Nyk611',par,periud) then Begin
    SDM.WriteLogFile(0,'Выгрузка расчётных данных','Не удалось выгрузить ПАРНы!');
    Exit
  end
  Else SDM.WriteLogFile(1,'Выгрузка расчётных данных','Таблица ПАРНов выгружена!');

  Result:=true;
end;

function TRI_Modelserver.GetVarValFromFormatStr(fstr : string; index : integer; br : char) : variant;
var
  vrmas : variant;
  co : integer;
Begin
  Result:=null;
  vrmas:=AnalizeStr(fstr,br,true);
  if not VarIsNull(vrmas) then Begin
     try
       co:=VarArrayHighBound(vrmas,1);
       if co>=index then Result:=vrmas[index];
     except
       SDM.WriteLogFile(0,'GetVarValFromFormatStr','!!!!!!!!!!!!!!');
     end;
  end;
end;

function TRI_Modelserver.DoCalculate(mapid: Integer; params: OleVariant): Integer;
var
  par, nam, res : variant;
  exefilename,ss,s1 : string;
  periud,co,i1,i2,iii : integer;
  rr : boolean;
  cds_temp : TClientDataSet;
  pStr, pStr1: PAnsiChar;
  inis,inis2 : TMemIni;
  ls : TStringList;
label noPlanFind, ErrorCalc, EndCalc;
begin
  SDM.WriteLogFile(4,'DoCalculate','вошли! '+usernik);

  if calcstate<>0 then Begin
    Result:=-10; //Расчёт не завершён
    Exit;
  end;
  // params[0] - код расчётного модуля


  ProcentCalc:=0;
  calcstate:=0;
  curCalc.mainmaps:=0;
  ExecutedModule.Document:='';
  curCalc.id:=0;
  curCalc.comment:='';
  curCalc.maps:=null;
  curCalc.planid:=0;
  curCalc.periuds:=null;
  curCalc.modid:=0;
  ModuleCalcSW.kzunitkn:='';


  Result:=-1; // Очереди расчётов заняты
  if not SDM.GetCalcFlowAble(usernik) then Exit;      //  ModelService.EndingCalcFlow;


  calcpath:='';
  calcpath:=MakeCalkFolder;
  Result:=-2; //Ошибка создания директории расчётов
  if calcpath='' then Begin
    SDM.EndingCalcFlow;
    Exit;
  end;

  //Проверим ограничения мощности.
  if limitslist.powermax>0 Then
     if Round(GetSumPowerMap(mapid))>=limitslist.powermax then  Begin
        SDM.WriteLogFile(0,'Выгрузка расчётных данных','Ошибка -7 Pmax! п=0 MAPSUM_P='+FloatToStr(GetSumPowerMap(mapid))+' > '+IntToStr(limitslist.powermax));
        Result:=-7; //Превышены ограничения по мощности
        GoTO ErrorCalc;
     end
     Else SDM.WriteLogFile(1,'Выгрузка расчётных данных','Pmax в допустимых пределах! п=0');


  If not PutCalcModul(calcpath,params[0]) Then Begin
    Result:=-3; //Ошибка размещения расчётного модуля
    SDM.WriteLogFile(0,'DoCalculate','Ошибка сохранения расчётного модуля! '+usernik);
    calcpath:='';
    GoTO ErrorCalc;
  end;

  ls:=TStringList.Create;
  ls.LoadFromFile(SDM.serverpath+'modelserver.ini');
  inis:=TMemIni.Create(ls.Text);

   // Записываем предрасчеты для расчетного модуля
  ss:=inis.ReadString('MODUL'+String(params[0]),'pcalc_nam','regim.r');
  ModuleCalcSW.precalcname:=calcpath+ss;
  ModuleCalcSW.precalcfile:=SDM.serverpath+'precalc\'+ss+IntToStr(mapid);
  ModuleCalcSW.precalcvar:=StrToInt(inis.ReadString('MODUL'+String(params[0]),'pcalc_var','10'));
  par:=VarArrayCreate([0, 1], varVariant);
  par[0]:=VarArrayOf(['MID']);
  par[1]:=VarArrayOf([mapid]);
  res:=GetTehData('Nyk681',par,null);
  if VarIsNull(res) then ModuleCalcSW.changmapcount:=0
  Else ModuleCalcSW.changmapcount:=Real(res);
  pStr:=PAnsiChar(ModuleCalcSW.precalcfile);
  pStr1:=PAnsiChar(ModuleCalcSW.precalcname);
  if FileExists(ModuleCalcSW.precalcfile) then Begin
     CopyFile(pStr,pStr1,false);
  end
  Else ModuleCalcSW.precalcvar:=0;

  // Записываем настройки расчета схемы для расчетного модуля
  ss:=inis.ReadString('MODUL'+String(params[0]),'set_nam','upra.r');
  //pStr:=PAnsiChar(serverpath+'precalc\'+ss+IntToStr(mapid));
  //pStr1:=PAnsiChar(calcpath+ss); \ls.Clear;
  ls.Clear;
  ls.LoadFromFile(SDM.serverpath+'upra.par');
  inis2:=TMemIni.Create(ls.Text);
  ls.Clear;
  s1:=inis2.ReadString('Design','break','*');
  if not FileExists(SDM.serverpath+'precalc\'+ss+IntToStr(mapid)) then Begin
    co:=inis2.ReadInteger('Fields','count',0);
    for i1:=1 to co do Begin
        if i1=1 Then iii:=1 Else iii:=0;
        ls.add(MakeFormatStr(VarArrayOf([iii,0,inis2.ReadString('Fields',IntToStr(i1),'')]),
        VarArrayOf([inis2.ReadInteger('Len','STATE',1),inis2.ReadInteger('Len','VALUE',-6),inis2.ReadInteger('Len','NAME',20)]),
        VarArrayOf([0,0,0]),s1));
    end;
    ls.SaveToFile(SDM.serverpath+'precalc\'+ss+IntToStr(mapid));
  end;
  inis2.Free;
  ls.Clear;
  ls.LoadFromFile(SDM.serverpath+'precalc\'+ss+IntToStr(mapid));
  ModuleCalcSW.elsyst:=1;
  par:=GetVarValFromFormatStr(ls.Strings[0],0,s1[1]);
  s1:='';
  if not VarIsNull(par) then Begin
     s1:=String(par);
     ModuleCalcSW.elsyst:=StrToInt(s1);
  end;
  if VarArrayHighBound(params,1)>2 then Begin
     par:=params[3];  // ограничение потоков мощности
     if not VarIsNull(par) then Begin
        co:=0;
        try
          co:=VarArrayHighBound(par,1);
        except
          co:=0;
          SDM.WriteLogFile(0,'DoCalculate','Ошибка параметров расчета! Некорректные данные ограничения потока мощности.');
        end;
        if co>1 then Begin
           ls.Add('POWERFLOW');
           ls.Add(String(par[0]));
           ls.Add(String(par[1]));
           for iii:=2 to co do ls.Add(String(par[iii]));
        end;
     end;
  end;
  ls.Add('');
  ls.SaveToFile(calcpath+ss);
  ls.Clear;
  //CopyFile(pStr,pStr1,false);

  periud:=0;
  curCalc.modid:=Integer(params[0]);

  // процедуру выгрузки расчётных данных в расчётную временную папку
  if not SendElementsToCalc(mapid,periud) then Begin
    Result:=-5; //не выгружены расчётные данные элементов
    GoTO ErrorCalc;
  end;

  if Integer(params[0])=2 then Begin // Расчет КЗ
     //Выгрузка точки КЗ
     par:=params[4];
     if not VarIsNull(par) then Begin
        co:=0;
        try
          co:=VarArrayHighBound(par,1);
        except
          co:=0;
        end;
        if co=1 then Begin
           ss:=MakeFormatStr(VarArrayOf([par[0],par[1]]),VarArrayOf([-10,-5]),VarArrayOf([0,1]),'!');
           ls.Add(ss);
           ss:=inis.ReadString('CALC','out_file_extation','.2cc');
           ss:=inis.ReadString('MODUL2','KZfileOut','kz')+ss;
           ls.SaveToFile(calcpath+ss);
           ModuleCalcSW.kzunitkn:=String(par[0]);
           ls.Clear;
        end
        Else Begin
          SDM.WriteLogFile(0,'DoCalculate','Ошибка параметров расчета! Некорректные данные точки КЗ.');
          Result:=-8;  // отсутствуют или не верные данные точки КЗ
          GoTO ErrorCalc;
        end;
     end
     Else Begin
       SDM.WriteLogFile(0,'DoCalculate','Ошибка параметров расчета! Отсутствует точка КЗ.');
       Result:=-8;  // отсутствуют или не верные данные точки КЗ
       GoTO ErrorCalc;
     end;
     curCalc.comment:='-КЗ- '+String(params[2]);
     ModuleCalcSW.precalcvar:=9000000;
     GoTo noPlanFind;
  end
  Else curCalc.comment:=String(params[2]);


  //выгрузка плана событий.
  if not VarIsNull(params[1]) then Begin
    cds_temp:=TClientDataSet.Create(nil);
    // цикл по плану событий с разбиением расчетов на периуды.
    par:=VarArrayCreate([0, 1], varVariant);
    par[0]:=VarArrayOf(['PLAN']);
    par[1]:=VarArrayOf([params[1]]);
    res:=GetData('Nyk606',par,null);
    if VarIsNull(res) Then Begin
       SDM.WriteLogFile(0,'Выгрузка расчётных данных','Запрос 606 пустой!');
       GoTo noPlanFind;
    end;
    curCalc.planid:=Integer(params[1]);
    cds_temp.Data:=res;
    rr:=true;
    if cds_temp.Active then Begin
      co:=cds_temp.RecordCount;
      if co>0 then Begin
       while not cds_temp.Eof do Begin
          //WriteLogFile(1,'Выгрузка расчётных данных',cds_temp.FieldByName('NOMER').AsString);
          i1:=cds_temp.FieldByName('MAP_ID').AsInteger;
          i2:=cds_temp.FieldByName('NOMER').AsInteger;

          if limitslist.powermax>0 Then
             if Round(GetSumPowerMap(i1))>=limitslist.powermax then  Begin
                SDM.WriteLogFile(0,'Выгрузка расчётных данных','Ошибка -7 Pmax! п='+IntToStr(i2));
                Result:=-7; //Превышены ограничения по мощности
                GoTO ErrorCalc;
             end
             Else SDM.WriteLogFile(1,'Выгрузка расчётных данных','Pmax в допустимых пределах! п='+IntToStr(i2));

          rr:=rr and SendElementsToCalc(i1,i2);
          cds_temp.Next;
       end;
      end;
    end;
    cds_temp.active:=false;
    cds_temp.Free;

    // Выгружаем план событий
    if not ElementToCalc('PLAN','actplan','Nyk608',par,-1) then Begin
       SDM.WriteLogFile(0,'Выгрузка расчётных данных','Не удалось выгрузить План событий!');
       rr:=false;
    end
    Else SDM.WriteLogFile(1,'Выгрузка расчётных данных','Таблица Плана событий выгружена!');

    // Выгружаем локальные события:
    if not ElementToCalc('KEYACT','akey','Nyk607',par,-1) then Begin
       SDM.WriteLogFile(0,'Выгрузка расчётных данных','Не удалось выгрузить События коммутирующей аппаратуры!');
       rr:=false;
    end
    Else SDM.WriteLogFile(1,'Выгрузка расчётных данных','Таблица Событий коммутирующей аппаратуры выгружена!');

    if not ElementToCalc('NAGRACT','anagr','Nyk609',par,-1) then Begin
       SDM.WriteLogFile(0,'Выгрузка расчётных данных','Не удалось выгрузить События сосредоточенной нагрузки!');
       rr:=false;
    end
    Else SDM.WriteLogFile(1,'Выгрузка расчётных данных','Таблица Событий коммутирующей сосредоточенной нагрузки!');

    if not rr then  Begin
       Result:=-5; //не выгружены расчётные данные элементов
       GoTO ErrorCalc;
    end;

  end;

  noPlanFind:

  curCalc.mainmaps:=mapid;
  SDM.WriteLogFile(4,'Расчет.','Код схемы:'+IntToStr(curCalc.mainmaps));

  // Получаем путь и имя файла запуска расчётного модуля
  par:=VarArrayCreate([0, 1], varVariant);
  par[0]:=VarArrayOf(['CTYPE']);
  par[1]:=VarArrayOf([params[0]]);
  nam:=VarArrayOf(['NAME']);
  res:=GetTehDataN('Nyk453',par,nam,null);
  if VarIsNull(res) then Begin
    Result:=-4; //нет в базе имени ехе файла
    GoTO ErrorCalc;
  end;
  if StrToInt(inis.ReadString('MODUL'+String(params[0]),'start','0'))=1 Then ModuleCalcSW.needStart:=true
  Else ModuleCalcSW.needStart:=false;
  exefilename:=calcpath+String(res[0]);// 1
  if ModuleCalcSW.needStart then
   if SDM.exec(exefilename) then Begin
     calcstate:=2; // начало расчёта
     ExecutedModule.Document:=String(res[0]); //1
     ExecutedModule.TempFolder:=calcpath;
     Result:=1;
     curCalc.mainmaps:=mapid;

     ModuleCalcSW.filename:=inis.ReadString('MODUL'+String(params[0]),'switch','ian');
     ModuleCalcSW.sensorvalue:=inis.ReadString('MODUL'+String(params[0]),'end_key','100');
     ModuleCalcSW.sensorerror:=inis.ReadString('MODUL'+String(params[0]),'err_key','X');
     ModuleCalcSW.progressable:=StrToInt(inis.ReadString('MODUL'+String(params[0]),'progress','0'));
     ModuleCalcSW.checkCount:=StrToInt(inis.ReadString('MODUL'+String(params[0]),'check_count','10'));

     timerCalc.Enabled:=true;
   end
   Else Begin
     Result:=-6;
     SDM.EndingCalcFlow;
   end
  Else Begin
     // возможно тестовая закачка?
     SDM.WriteLogFile(4,'тестовая закачка','Начало!');
     if SDM.CalcTestLoad then Begin
        SDM.WriteLogFile(4,'тестовая закачка','Первый шаг!');
        calcstate:=3;
        timerCalc.Enabled:=false;
        SDM.EndingCalcFlow;
        ProcentCalc:=100;
           // запуск загрузки
        if not LoadCalcResult then Begin
           SDM.WriteLogFile(0,'тестовая закачка','ничО не вышло!');
           Result:=2;
           GoTO ErrorCalc;
        end;
        Result:=1;
        ls.Free;
        inis.Free;
        Exit;
     end;


     SDM.EndingCalcFlow;
     Result:=2;
  end;

  //Result:=1;
  //calcstate:=1;  Расчёт выполнен/
  // тестовое создание временной БД
  // CreateCalcDB; // убрать после тестов!

  GoTo EndCalc;

  ErrorCalc:
  SDM.EndingCalcFlow;
  DelFolder(calcpath);
  calcpath:='';

  EndCalc:
  try
    ls.Free;
  except
  end;
  try
    inis.Free;
  except
  end;
end;

function TRI_Modelserver.LoadCalcResult : boolean;
var 
  pStr, pStr1: PAnsiChar;
  par, res : variant;
Begin
  Result:=false;
  if calcstate<>3 then Exit;
  if not CreateCalcDB then Exit;
  SDM.WriteLogFile(4,'LoadCalcResult', 'БД создана');
  if not CreateCalc then Exit;

  SDM.WriteLogFile(4,'LoadCalcResult','дошли до заливки!');

  if (ModuleCalcSW.precalcvar=0)or(ModuleCalcSW.precalcvar<=Round(ModuleCalcSW.changmapcount)) then Begin
      pStr:=PAnsiChar(ModuleCalcSW.precalcfile);
      pStr1:=PAnsiChar(ModuleCalcSW.precalcname);
      CopyFile(pStr1,pStr,false);
      par:=VarArrayCreate([0, 1], varVariant);
      par[0]:=VarArrayOf(['MAP']);
      par[1]:=VarArrayOf([curCalc.mainmaps]);
      StartTrans;
      res:=RunSQL('Nyk682',par,null);
      if res=0 then CommTrans
      Else BackTrans;
  end;

  StartTransC;

  //++++++++++++Таблица СД+++++
  if not ElementCalcToDB('SD','sd','Nyk671',0) then Begin
    SDM.WriteLogFile(0,'Загрузка расчётных данных','Не удалось загрузить СД!');
    BackTransC;
    Exit
  end
  Else SDM.WriteLogFile(1,'Загрузка расчётных данных','Таблица СД загружена!');


  //++++++++++++Таблица АД+++++
  if not ElementCalcToDB('AD','ad','Nyk624',0) then Begin
    SDM.WriteLogFile(0,'Загрузка расчётных данных','Не удалось загрузить АД!');
    BackTransC;
    Exit
  end
  Else SDM.WriteLogFile(1,'Загрузка расчётных данных','Таблица АД загружена!');

  //++++++++++++Таблица Выключателей+++++
  if not ElementCalcToDB('KEY','key','Nyk___',0) then Begin
    SDM.WriteLogFile(0,'Загрузка расчётных данных','Не удалось загрузить Выключатели!');
    BackTransC;
    Exit
  end
  Else SDM.WriteLogFile(1,'Загрузка расчётных данных','Таблица Выключателей загружена!');

  //++++++++++++Шина бесконечной мощьности+++++
  if not ElementCalcToDB('POWER','power','Nyk621',0) then Begin
    SDM.WriteLogFile(0,'Загрузка расчётных данных','Не удалось загрузить Шины бесконечной мощности!');
    BackTransC;
    Exit
  end
  Else SDM.WriteLogFile(1,'Загрузка расчётных данных','Таблица Шин бесконечной мощности загружена!');

  //++++++++++++Синхронные генератор+++++
  if not ElementCalcToDB('GENER','generator','Nyk678',0) then Begin
    SDM.WriteLogFile(0,'Загрузка расчётных данных','Не удалось загрузить Синхронные генераторы!');
    BackTransC;
    Exit
  end
  Else SDM.WriteLogFile(1,'Загрузка расчётных данных','Таблица Синхронных генераторов загружена!');

  //++++++++++++Концентрированая нагрузка+++++
  if not ElementCalcToDB('NAGR','nagruzka','Nyk670',0) then Begin
    SDM.WriteLogFile(0,'Загрузка расчётных данных','Не удалось загрузить Нагрузку!');
    BackTransC;
    Exit
  end
  Else SDM.WriteLogFile(1,'Загрузка расчётных данных','Таблица Нагрузки загружена!');

  //++++++++++++БСК+++++
  if not ElementCalcToDB('BSK','bsk','Nyk677',0) then Begin
    SDM.WriteLogFile(0,'Загрузка расчётных данных','Не удалось загрузить БСК!');
    BackTransC;
    Exit
  end
  Else SDM.WriteLogFile(1,'Загрузка расчётных данных','Таблица БСК загружена!');

  //++++++++++++БСК+++++
  if not ElementCalcToDB('SS','obj','Nyk822',0) then Begin
    SDM.WriteLogFile(0,'Загрузка расчётных данных','Не удалось загрузить Подстанции!');
    BackTransC;
    Exit
  end
  Else SDM.WriteLogFile(1,'Загрузка расчётных данных','Таблица Подстанций загружена!');

  //++++++++++++Воздушные линии+++++
  if not ElementCalcToDB('VL','vl','Nyk622',0) then Begin
    SDM.WriteLogFile(0,'Загрузка расчётных данных','Не удалось загрузить ВЛ!');
    BackTransC;
    Exit
  end
  Else SDM.WriteLogFile(1,'Загрузка расчётных данных','Таблица ВЛ загружена!');

  //++++++++++++Кабельные линии и токопроводы+++++
  if not ElementCalcToDB('CL','cl','Nyk623',0) then Begin
    SDM.WriteLogFile(0,'Загрузка расчётных данных','Не удалось загрузить КЛ!');
    BackTransC;
    Exit
  end
  Else SDM.WriteLogFile(1,'Загрузка расчётных данных','Таблица КЛ и токопроводов загружена!');

  //++++++++++++Трансформаторы 3-х обмоточные+++++
  if not ElementCalcToDB('T3','trans3','Nyk669',0) then Begin
    SDM.WriteLogFile(0,'Загрузка расчётных данных','Не удалось загрузить 3-х трансвоматоры!');
    BackTransC;
    Exit
  end
  Else SDM.WriteLogFile(1,'Загрузка расчётных данных','Таблица 3-х обмоточных трансформаторов загружена!');

  //++++++++++++Трансформаторы с расщепленной обмоткой+++++
  if not ElementCalcToDB('T2R','trans2r','Nyk684',0) then Begin
    SDM.WriteLogFile(0,'Загрузка расчётных данных','Не удалось загрузить трансвоматоры с расщепленной обмоткой!');
    BackTransC;
    Exit
  end
  Else SDM.WriteLogFile(1,'Загрузка расчётных данных','Таблица трансформаторов с ращепленной обмоткой загружена!');

  //++++++++++++Трансформаторы 2-х обмоточные+++++
  if not ElementCalcToDB('T2','trans2','Nyk676',0) then Begin
    SDM.WriteLogFile(0,'Загрузка расчётных данных','Не удалось загрузить 2-х трансвоматоры!');
    BackTransC;
    Exit
  end
  Else SDM.WriteLogFile(1,'Загрузка расчётных данных','Таблица 2-х обмоточных трансформаторов загружена!');

  //++++++++++++ АвтоТрансформаторы +++++
  if not ElementCalcToDB('AT','a-trans','Nyk___',0) then Begin
    SDM.WriteLogFile(0,'Загрузка расчётных данных','Не удалось загрузить Автотрансвоматоры!');
    BackTransC;
    Exit
  end
  Else SDM.WriteLogFile(1,'Загрузка расчётных данных','Таблица Автотрансформаторов загружена!');

  //++++++++++++ ПАРНы +++++
  if not ElementCalcToDB('PARN','parn','Nyk___',0) then Begin
    SDM.WriteLogFile(0,'Загрузка расчётных данных','Не удалось загрузить ПАРНы!');
    BackTransC;
    Exit
  end
  Else SDM.WriteLogFile(1,'Загрузка расчётных данных','Таблица ПАРН загружена!');

  //++++++++++++ Реакторы +++++
  if not ElementCalcToDB('REK','reaktor','Nyk679',0) then Begin
    SDM.WriteLogFile(0,'Загрузка расчётных данных','Не удалось загрузить Реакторы!');
    BackTransC;
    Exit
  end
  Else SDM.WriteLogFile(1,'Загрузка расчётных данных','Таблица Реакторов загружена!');

  //++++++++++++ Реакторы СТК+++++
  if not ElementCalcToDB('STK','stk','Nyk693',0) then Begin
    SDM.WriteLogFile(0,'Загрузка расчётных данных','Не удалось загрузить Реакторы СТК!');
    BackTransC;
    Exit
  end
  Else SDM.WriteLogFile(1,'Загрузка расчётных данных','Таблица Реакторов загружена!');

  //заполняем таблицы с обратной связью

  // таблица РПН
  if not ElementCalcToDB('RPN','rpn','Nyk691',1) then Begin
    SDM.WriteLogFile(0,'Загрузка расчётных данных','Не удалось загрузить РПН!');
    BackTransC;
    Exit
  end
  Else SDM.WriteLogFile(1,'Загрузка расчётных данных','Таблица РПН загружена!');

  // таблица уставок генераторов
  if not ElementCalcToDB('GENER','generator','Nyk692',1) then Begin
    SDM.WriteLogFile(0,'Загрузка расчётных данных','Не удалось загрузить уставки генератора!');
    BackTransC;
    Exit
  end
  Else SDM.WriteLogFile(1,'Загрузка расчётных данных','Таблица уставок генератора загружена!');


  CommTransC;
  SDM.WriteLogFile(4,'Загрузка расчётных данных','Все данные залиты удачно!!');
  Result:=true;
  DelFolder(calcpath);
  calcstate:=1;
end;

function TRI_Modelserver.CloseTransmit: OleVariant;
begin
  Result := -1;
  try
    SDM.WriteLogFile(1,'CloseTransmit', 'Enter '+usernik);
    RFile.Free;
    If SaveFileToBD(Paths.Document,Paths.TempFolder,Paths.Comment,Paths.FileType,Paths.CModulType,Paths.size,Paths.datemake) Then Begin
       Result := 1;
       SDM.WriteLogFile(1,'CloseTransmit', ' OK '+usernik);
    end
    Else SDM.WriteLogFile(0,'CloseTransmit', ' Ошибка сохранения файла в БД');
  except
    Result := -1;
    SDM.WriteLogFile(0,'CloseTransmit', ' Ошибка '+usernik);
  end;
end;

function TRI_Modelserver.StartTransmit(FileName: OleVariant; FileType, ModulType: Integer): OleVariant;
begin
  Result := '';
  try
    Paths.Document:=FileName[0];
    Paths.size:=FileName[2];
    Paths.datemake:=FileName[3];
    Paths.FileType:=FileType;
    Paths.CModulType:=ModulType;
    Paths.Comment:=FileName[1];
    Paths.TempFolder := MakeCalkFolder;
    SDM.WriteLogFile(4,'StartTransmit', 'Enter '+Paths.TempFolder+Paths.Document);
    RFile := TFileStream.Create(Paths.TempFolder + Paths.Document, fmCreate);
    RFile.Position := 0;
    Result := RFile.FileName;
    SDM.WriteLogFile(1,'StartTransmit', ' OK '+Paths.Document);
  except
    Result := '';
    SDM.WriteLogFile(0,'StartTransmit', ' Ошибка '+Paths.Document);
  end;

end;

function TRI_Modelserver.SaveFileToBD(Filename, Path, Comment:string; FileType, ModulType,Fsize:integer; Dmake:TDateTime) : boolean;
var
  ii : integer;
Begin
  Result:=false;
  try
   try
   ii:=GetNextId('GENERAL');
   if ii<0 then Exit;
   q_files_add.ParamByName('id').AsInteger:=ii;
   q_files_add.ParamByName('body').LoadFromFile(Path+Filename,ftBlob);
   q_files_add.ParamByName('ft').AsInteger:=FileType;
   q_files_add.ParamByName('ct').AsInteger:=ModulType;
   q_files_add.ParamByName('st').AsInteger:=1;
   q_files_add.ParamByName('com').AsString:=Comment;
   q_files_add.ParamByName('name').AsString:=Filename;
   q_files_add.ParamByName('fs').AsInteger:=Fsize;
   q_files_add.ParamByName('dm').Value:=Dmake;
   q_files_add.Prepare;
   StartTrans;
   q_files_add.ExecSQL;
   CommTrans;
   Result:=true;
   finally
     DelFolder(Path);
   end;
  except
    BackTrans;
    SDM.WriteLogFile(0,'SaveFileToBD', ' Ошибка '+Filename);
  end;
end;

function TRI_Modelserver.WorkTransmit(Buffer: OleVariant): OleVariant;
var BufSize: Integer;
begin
  Result := -1;
  try
    SDM.WriteLogFile(1,'WorkTransmit', 'Enter '+usernik);
    BufSize := VarArrayHighBound (Buffer, 1) - VarArrayLowBound (Buffer, 1) + 1;
    RFile.Write(VarArrayLock(Buffer)^, BufSize);
    RFile.Position := RFile.Position;
    VarArrayUnlock(Buffer);
    Result := 1;
    SDM.WriteLogFile(1,'WorkTransmit', ' OK '+usernik);
  except
    Result := -1;
    SDM.WriteLogFile(0,'WorkTransmit', ' Ошибка '+usernik);
    RFile.Free;
  end;

end;


procedure TRI_Modelserver.BackTransC;
begin
  if not IBDbCalc.Connected then Exit;

  If IBTransCalc.InTransaction Then Begin
     IBTransCalc.Rollback;
     // добавить лог
  end
end;

procedure TRI_Modelserver.CommTransC;
begin
  if not IBDbCalc.Connected then Exit;

  If IBTransCalc.InTransaction Then Begin
     IBTransCalc.Commit;
     // добавить лог
  end
end;

procedure TRI_Modelserver.StartTransC;
begin
  if not IBDbCalc.Connected then Exit;

  If not IBTransCalc.InTransaction Then Begin
     IBTransCalc.StartTransaction;
     // добавить лог
  end
end;

function TRI_Modelserver.GetUserStatus: OleVariant;
begin
  Result:=null;
  If not IBDB.Connected Then Exit;
  if useractive=1 then Begin
     Result:=VarArrayOf([username, usernik, userrole]);
  end;
end;

function TRI_Modelserver.TestMapIdCalc(mapid : integer) : boolean;
var
  par, res, nam : variant;
Begin
  Result:=false;
  if not IBDbCalc.Connected then Begin
    SDM.WriteLogFile(0,'TestMapIdCalc','Нет коннекта к временной БД ');
    Exit;
  end;
  if (mapid=0) and SDM.CalcTestLoad then Begin
    Result:=true;
    Exit;
  end;
  q_mapid_c.Active:=false;
  q_mapid_c.ParamByName('map').AsInteger:=mapid;
  q_mapid_c.Prepare;
  try
    q_mapid_c.Open;
  Except
    q_mapid_c.Active:=false;
    SDM.WriteLogFile(0,'TestMapIdCalc','Ошибка выполнения запроса проверки схемы.');
    Exit;
  end;
  if q_mapid_c.FieldByName('KVO').AsInteger>0 then Result:=true;
  q_mapid_c.Active:=false;
end;

function TRI_Modelserver.GetUserData(uid : int64) : variant;
var
  par, res, nam : variant;
Begin
  Result:=null;
  Exit; // Временно ф-ция не доделана
  par:=VarArrayCreate([0, 1], varVariant);
  par[0]:=VarArrayOf(['CTYPE']);
  par[1]:=VarArrayOf([0]);
  nam:=VarArrayOf(['NAME']);
  res:=GetTehDataN('Nyk453',par,nam,null);
end;

function TRI_Modelserver.DoLockMapF(mid, sts: OleVariant): OleVariant;
var
  idres,mapid : int64;
  res : variant;
  tkl : TClientList;
  sets: Shortint;
begin
   Result:=null;
   mapid:=mid;
   sets:=sts;

   If not IBDB.Connected Then Exit;
   if useractive=1 then Begin
      case sets of
          0 : Begin  // узнает состояние блокировки слоя
              idres:=SDM.BlockMap(mapid, userid, 0);
              if idres>0 then Begin
                 tkl:=SDM.GetClientFromList(idres);
                 Result:=VarArrayOf([tkl.UserId,tkl.UserNick,tkl.UserName]);
              end;
          end;
          1 : Begin  // устанавливает блокироку объекта
              res:=IsOperationRite('Nyk567');
              if not VarIsNull(res) then
                 if Integer(res)>0 then Begin
                    idres:=0;
                    If MapLockID>0 Then Begin
                       idres:=SDM.BlockMap(MapLockID, userid, 2);
                    end;
                    if idres=0 then Begin
                       idres:=SDM.BlockMap(mapid, userid, 1);
                       SDM.WriteLogFile(4,'DoLockMap', 'Block map='+IntToStr(mapid)+' sets=1 res='+IntToStr(idres));
                       if idres=0 then Begin
                          Result:=0;
                          MapLockID:=mapid;
                       end;
                    end;
                 end;
          end;
          2 : Begin  // освобождает блокироку указанного объекта пользователя
              idres:=SDM.BlockMap(mapid, userid, 2);
              SDM.WriteLogFile(4,'DoLockMap', 'Unlock map='+IntToStr(mapid)+' sets=1 res='+IntToStr(idres));
              if idres=0 then Begin
                  if MapLockID=mapid then MapLockID:=0;
                  Result:=0;
              end;
          end;
          3 : Begin  // освобождает все блокировки пользователя
              idres:=SDM.BlockMap(mapid, userid, 3);
              Result:=0;
              MapLockID:=0;
          end;
          4 : Begin  // освобождает весь список блокировок
              res:=IsOperationRite('Nyk568');
              if not VarIsNull(res) then
                 if Integer(res)>0 then Begin
                     SDM.BlockMap(mapid, userid, 4);
                     MapLockID:=0;
                     Result:=0;
                 end;
          end; 
          5 : Begin  // возвращает код залоченного объекта
              If MapLockID>0 Then Result:=MapLockID;
          end;

      end;
   end;
end;

function TRI_Modelserver.GetMonoState: OleVariant;
begin
  If SDM.monopol Then Result:=1 Else If SDM.hard_close Then Result:=-1 Else Result:=0;
end;

function TRI_Modelserver.LoadUpstuct(scrpt: OleVariant): OleVariant;
// Возвращает:  NULL если аргумент NULL, 0 если аргумент "", -1 и -2 Если не верный формат, -3 если нет SQL, -4 если ошибка SQLж
// 1 - Если удачно сохранено; -5 - если нет шапки в файле; -6 испорчен СКЛ 616; -7 такие обновления уже установлены.
var
  pp,res,params : variant;
  co,ii,nomvers,lastver : integer;
  ParList : TStringList;
  strvers : string;
  datcr : TDateTime;
begin  // Загрузка обновлений в базу обновления структуры БД
  Result:=null;
  if VarIsNull(scrpt) then Exit;
  Result:=0;
  if scrpt='' then Exit;
  Result:=-1;
  pp:=AnalizeStr(scrpt,'!',false);
  if VarIsNull(pp) then Exit;
  Result:=-2;
  try
    co:=VarArrayHighBound(pp,1);
  except
    SDM.WriteLogFile(0,'LoadUpstuct', 'scrpt= '+String(scrpt));
    SDM.WriteLogFile(0,'LoadUpstuct', '++++++++++++++++++++++++++++++++++++++++++++++++++++++');
    try
    SDM.WriteLogFile(0,'LoadUpstuct', 'pp[0]= '+String(pp[0]));
    SDM.WriteLogFile(0,'LoadUpstuct', '++++++++++++++++++++++++++++++++++++++++++++++++++++++');
    SDM.WriteLogFile(0,'LoadUpstuct', 'pp[1]= '+String(pp[1]));
    except
    end;
    Exit;
  end;
  Result:=-3;
  if co<1 then Exit;
  Result:=-5;
  if VarIsNull(pp[0]) then Exit;

  SDM.WriteLogFile(2,'LoadUpstuct', 'Прошли все проверки!');

  params:=VarArrayCreate([0, 1], varVariant);

  ParList:=TStringList.Create;
  ParList.Text:=pp[0];
  strvers:=ParList.Values['STRVERS'];
  nomvers:=StrTOInt(ParList.Values['INTVERS']);
  datcr:=StrToDateTime(ParList.Values['DATE']);
  lastver:=StrTOInt(ParList.Values['LASTVERS']);
  ParList.Free;

  params[0]:=VarArrayOf(['VERS']);
  params[1]:=VarArrayOf([nomvers]);

  res:=GetTehData('Nyk616',params,null);
  if VarIsNull(res) then Begin
    SDM.WriteLogFile(0,'LoadUpstuct', 'Нарушение целостности SQL Nyk616.');
    Result:=-6;
    Exit;
  end;
  if Integer(res)>0 then Begin
    SDM.WriteLogFile(0,'LoadUpstuct', 'Попытка повторной установки обновления.');
    Result:=-7;
    Exit;
  end;

  Result:=-4;
  StartTrans;
  SDM.WriteLogFile(2,'LoadUpstuct', 'Стартуем транзакцию...');
  For ii:=1 To co Do Begin
   //params[0]:=VarArrayOf(['SVER','IVERS','LVER','DAT','SQL']);
   //params[1]:=VarArrayOf([strvers,nomvers,lastver,datcr,pp[ii]]);
   params[0]:=VarArrayOf(['IVERS','LVER','DAT','SQL','SVERS']);
   params[1]:=VarArrayOf([nomvers,lastver,datcr,pp[ii],strvers]);
   res:=RunSQL('Nyk614',params,null);
   SDM.WriteLogFile(2,'LoadUpstuct', 'Запустили СКЛ на всавку...'+IntToStr(ii));
   if res<>0 then Begin
      BackTrans;
      SDM.WriteLogFile(0,'LoadUpstuct', 'Ошибка вставки скрипта обновления в таблицу.');
      Exit;
   end;
  end;
  CommTrans;
  Result:=1;
  SDM.WriteLogFile(2,'LoadUpstuct', 'Скрипты сохранены! Результат: '+IntToStr(Integer(Result)));
end;

procedure TRI_Modelserver.UpDateINIConfig(initxt : string);
var
  inis : TMemIni;
  co, ii : integer;
  res : variant;
Begin
  inis:=TMemIni.Create(initxt);
  res:=inis.GetFullArrayValues;
  inis.Free;
  if VarIsNull(res) then Exit;
  try
   co:=VarArrayHighBound(res,1);
  except
    Exit;
  end;
  for ii := 0 to co do
     SDM.WriteStringToConfigINI(String(res[ii][0]),String(res[ii][1]),String(res[ii][2]));
    
end;

function TRI_Modelserver.SetUpstruct: OleVariant;
// Возвращает NULL если не монопольный режим, -1 если еще не наступил монопольный (есть еще включенные клиенты)
// -2 если нет не установленых апдейтов, если число >0 то это номер отсутствующего обязательного оновления, установка которого нужна для установки текущего апдейта
// если 0 то обновление установлено полностью, -3 если запрос поиска предыдущей версии не выполнился, -4 если  апдейт не выполнился
var
 res,par : variant;
 ss : string;
 ls,ls2 : TStringList;
 idx,ii,co : integer;
begin
  Result:=null;
  if not monopolise then Exit;
  Result:=-1;
  if SDM.GetUserCOuntConnect>1 then Exit;
  Result:=-2;
  par:=VarArrayCreate([0, 1], varVariant);
  res:=GetData('Nyk615',null,null);
  if VarIsNull(res) then Exit;
  cds_work_with_me.Active:=false;
  cds_work_with_me.Data:=res;
  if cds_work_with_me.RecordCount=0 then Exit;
  while not cds_work_with_me.Eof do Begin
    par[0]:=VarArrayOf(['NEWID','VERS']);
    par[1]:=VarArrayOf([cds_work_with_me.FieldByName('id').AsInteger,cds_work_with_me.FieldByName('oldversneed').AsInteger]);
    StartTrans;
    res:=GetTehData('Nyk617',par,null);
    if VarIsNull(res) then Begin
       Result:=-3;
       BackTrans;
       Exit;
    end;
    if Integer(res)=0 then Begin
      BackTrans;
      Result:=cds_work_with_me.FieldByName('oldversneed').AsInteger;
      Exit;
    end;
    ss:=cds_work_with_me.FieldByName('sql').AsString;
    if Pos('-',ss)=1 then Begin
       ls2:=TStringList.Create;
       ls2.Text:=ss;
       ls2.Delete(0);
       UpDateINIConfig(ls2.Text);
       ls:=TStringList.Create;
       ls.text:=String(GetConfigINI);
       co:=ls2.Count;
       for ii := 0 to co-1 do Begin
         ls.CaseSensitive:=false;
         if (Pos('[',ls2.Strings[ii])<>1)and(ls2.Strings[ii]<>'') then Begin
           idx:=ls.IndexOf(ls2.Strings[ii]);
           if idx>=0 then ls.Delete(idx)
           Else SDM.WriteLogFile(0,'SetUpstruct','Не в INI найдена строка '+ls2.Strings[ii]);
         end;
       end;
       SetConfigINI(ls.Text,'');
       ls.Free;
       ls2.Free;
    end
    Else
    if Pos('[',ss)=1 then Begin
       // Кусок обновления ИНИ-файла
       UpDateINIConfig(ss);
    end
    Else
    if Pos(';',ss)>0 then Begin
       ib_script.Script.Text:=ss;
       try
        ib_script.ExecuteScript;
       except
        BackTrans;
        SDM.WriteLogFile(0,'SetUpstruct','Ошибка выполнения скрипта обновления структуры БД:'+ss);
        Result:=-4;
        //Raise;
        Exit;
       end;
    end
    Else Begin
     q_execute.Active:=false;
     q_execute.SQL.Text:=ss;
     q_execute.Prepare;
     try
      q_execute.ExecSQL;
     except
      BackTrans;
      SDM.WriteLogFile(0,'SetUpstruct','Ошибка выполнения SQL обновления структуры БД:'+ss);
      Result:=-4;
      Exit;
     end;
    end;
    CommTrans;
    cds_work_with_me.Next;
  end;
  Result:=0;
end;

function TRI_Modelserver.CreateCalc : boolean;
var
  idd, co, ii, iidd : integer;
  par,res : variant;
  er : string;
Begin
  // (mapid,planid : integer)
  Result:=false;
  if not IBDbCalc.Connected then Exit;
  SDM.WriteLogFile(4,'закачка','CreateCalc вошли. '+curCalc.comment);
  idd:=GetNextId_c('GENERAL');
  SDM.WriteLogFile(4,'CreateCalc', 'idd='+IntToStr(idd));
  if idd<1 then Exit;
  curCalc.id:=0;
  q_calc_ins.ParamByName('id').AsInteger:=idd;
  q_calc_ins.ParamByName('mmt').AsDateTime:=now;
  q_calc_ins.ParamByName('com').AsString:=curCalc.comment;
  q_calc_ins.ParamByName('map').AsInteger:=curCalc.mainmaps;
  q_calc_ins.ParamByName('kzu').AsString:=ModuleCalcSW.kzunitkn;
  if curCalc.planid=0 then q_calc_ins.ParamByName('plan').Value:=null
  Else q_calc_ins.ParamByName('plan').AsInteger:=curCalc.planid;
  SDM.WriteLogFile(4,'CreateCalc', 'Добавляем расчет');
  try
    q_calc_ins.Prepare;
    StartTransC;
    q_calc_ins.ExecSQL;
  except
    on E: Exception do Begin
       calcstate:=-1;
       er:=E.Message;
       SDM.WriteLogFile(0,'CreateCalc','Ошибка исполнения: '+er);
       BackTransC;
       SDM.WriteLogFile(0,'Выгрузка расчётных данных','Ошибка вставки нового расчета во временную базу!');
       Exit;
    end;
  end;
  curCalc.id:=idd;
  SDM.WriteLogFile(4,'CreateCalc','создали. ИД='+IntToStr(idd));
  iidd:=GetNextId_c('GENERAL');
  q_per_ins.ParamByName('id').AsInteger:=iidd;
  q_per_ins.ParamByName('clc').AsInteger:=idd;
  q_per_ins.ParamByName('per').AsInteger:=0;
  q_per_ins.ParamByName('map').AsInteger:=curCalc.mainmaps;
  q_per_ins.Prepare;
  try
    q_per_ins.ExecSQL;
  except
    BackTransC;
    SDM.WriteLogFile(0,'Выгрузка расчётных данных','Ошибка вставки начального периода во временную базу!');
    Exit;
  end;
  CommTransC;
  SDM.WriteLogFile(4,'CreateCalc','создали нулевой период. ИД='+IntToStr(iidd));
  par:=VarArrayCreate([0, 1], varVariant);
  par[0]:=VarArrayOf(['PLAN']);
  par[1]:=VarArrayOf([curCalc.planid]);
  res:=GetData('Nyk618',par,null);
  if VarIsNull(res) Then SDM.WriteLogFile(0,'Выгрузка расчётных данных','Запрос 618 испорчен!')
  Else Begin

     cds_work_with_me.Active:=false;
     cds_work_with_me.Data:=res;
     co:=cds_work_with_me.RecordCount;
     if co>0 then Begin
        curCalc.maps:=VarArrayCreate([0,co-1],varVariant);
        curCalc.periuds:=VarArrayCreate([0,co-1],varVariant);
        ii:=0;
        StartTransC;
        while not cds_work_with_me.EOF do Begin
           iidd:=GetNextId_c('GENERAL');
           curCalc.maps[ii]:=cds_work_with_me.FieldByName('MAP_ID').AsInteger;
           curCalc.periuds[ii]:=cds_work_with_me.FieldByName('NOMER').AsInteger;
           q_per_ins.ParamByName('id').AsInteger:=iidd;
           q_per_ins.ParamByName('clc').AsInteger:=idd;
           q_per_ins.ParamByName('per').AsInteger:=curCalc.periuds[ii];
           q_per_ins.ParamByName('map').AsInteger:=curCalc.maps[ii];
           q_per_ins.Prepare;
           try
             q_per_ins.ExecSQL;
           except
             BackTransC;
             curCalc.maps:=null;
             curCalc.periuds:=null;
             SDM.WriteLogFile(0,'Выгрузка расчётных данных','Ошибка вставки периода во временную базу!');
             Break;
           end;
           inc(ii);
           cds_work_with_me.Next;
        end;
        CommTransC;
     end;
     cds_work_with_me.Active:=false;
  end;
  Result:=true;
end;

function TRI_Modelserver.MapCalcCount(MAPID: Integer): OleVariant;
var
  par, res, nam : variant;
Begin
  Result:=0;
  if not IBDbCalc.Connected then Begin
    SDM.WriteLogFile(4,'MapCalcCount Error','Нет коннекта к временной БД ');
    Exit;
  end;
  if (mapid=0) then Exit;
  q_mapid_c.Active:=false;
  q_mapid_c.ParamByName('map').AsInteger:=mapid;
  q_mapid_c.Prepare;
  try
    q_mapid_c.Open;
  Except
    q_mapid_c.Active:=false;
    SDM.WriteLogFile(0,'TMapCalcCount','Ошибка выполнения запроса проверки схемы.');
    Exit;
  end;
  Result:=q_mapid_c.FieldByName('KVO').AsInteger;
  q_mapid_c.Active:=false;
end;

function TRI_Modelserver.LockMapEditOp(mid, sts: OleVariant): OleVariant;
var
  l_var,par,res,rres : variant;
  co,ii, st : integer;
  cds_ttest: TClientDataSet;
begin
  Result:=-1;
  res:=-2;
  SDM.WriteLogFile(4,'LockMapEditOp','Зашли. Mid: '+String(mid)+'  S: '+String(sts));
  par:=VarArrayCreate([0, 1], varVariant);
  par[0]:=VarArrayOf(['MID']);
  par[1]:=VarArrayOf([mid]);
  rres:=GetData('Nyk680',par,null);
//  WriteLogFile(4,'LockMapEditOp','Выполнили запрос : Nyk680');
  if VarIsNull(rres) Then SDM.WriteLogFile(0,'LockMapEditOp','Запрос 680 не выполнен! MID='+IntToStr(mid))
  Else Begin
    res:=-3;
//    WriteLogFile(4,'LockMapEditOp','Запрос : Nyk680 удачно выполнен!!');
    cds_ttest:=TClientDataSet.Create(nil);
    cds_ttest.Active:=false;
    try
    cds_ttest.Data:=rres;
    except
      SDM.WriteLogFile(0,'LockMapEditOp','Не корректные данные датасета');
      cds_ttest.Free;
      exit;
    end;
//    WriteLogFile(4,'LockMapEditOp','Датасет заполнен данными');
    res:=-4;
    co:=cds_ttest.RecordCount;
    if co>0 then Begin
//      WriteLogFile(4,'LockMapEditOp','В запросе Nyk680 записей: '+IntToStr(co));
      cds_ttest.First;
      l_var:=VarArrayCreate([0, co-1], varVariant);
      for ii := 0 to co - 1 do Begin
          l_var[ii]:=cds_ttest.FieldByName('ID').AsInteger;
 //         WriteLogFile(4,'LockMapEditOp','В запись: '+IntToStr(ii)+' занчение: '+cds_ttest.FieldByName('ID').AsString);
          cds_ttest.Next;
      end;
      cds_ttest.Active:=false;
      cds_ttest.Free;
 //     WriteLogFile(4,'LockMapEditOp','---1  S='+String(sts));
      st:=Integer(sts);
      if st>2 then st:=2;
      if st<0 then st:=0;
  //    WriteLogFile(4,'LockMapEditOp','---2  S='+IntToStr(st));
      res:=SDM.BlockMapOper(userid, st, l_var);
    end;
  end;
  Result:=res;
end;

procedure TRI_Modelserver.ErrSQLlogControl(kn, oper: OleVariant);
var
  idx : integer;
begin
  case Integer(oper) of
       0 : Begin // Set
             if NoLogErrorSQL.IndexOf(String(kn))<0 Then NoLogErrorSQL.Add(String(kn));
           end;
       1 : Begin // Remove
             idx:=NoLogErrorSQL.IndexOf(String(kn));
             if idx>-1 then NoLogErrorSQL.Delete(idx);
           end;
       2 : Begin // Clear
             NoLogErrorSQL.Clear;
           end;
  end;
end;

function TRI_Modelserver.GetConfigINI: OleVariant;
var
  ls : TStringList;
begin
  Result:='';
  if IsOperationRite('Nyk688')<>1 Then Exit;
  ls:=TStringList.Create;
  ls.LoadFromFile(SDM.serverpath+'modelserver.ini');
  Result:=ls.Text;
  ls.Free;
end;

procedure TRI_Modelserver.ReSetINIConfig;
var
  str : string;
  inis : TMemIni;
  ls : TStringList;
Begin
  ls:=TStringList.Create;
  ls.LoadFromFile(SDM.serverpath+'modelserver.ini');
  inis:=TMemIni.Create(ls.Text);
  SDM.dbCalcName:=inis.ReadString('DB','calc_path','');
  SDM.MaxCalcFlow:=inis.ReadInteger('CALC','max_flows',1);
  if inis.ReadInteger('CALC','one_base',0)=0 then SDM.CalcOneBase:=false
  Else SDM.CalcOneBase:=true;
  if inis.ReadInteger('CALC','testload',0)=0 then SDM.CalcTestLoad:=false
  Else SDM.CalcTestLoad:=true;

  if inis.ReadInteger('DEBUG','more',0)=1 then SDM.debugmore:=true Else SDM.debugmore:=false;
  if inis.ReadInteger('DEBUG','iansave',0)=1 then SDM.savecalcdirmode:=true Else SDM.savecalcdirmode:=false;
  if inis.ReadInteger('DEBUG','sqlspy',0)=1 then
        SDM.sqlspy:=inis.ReadString('DEBUG','sql','')
  Else  SDM.sqlspy:='';

  SDM.dbservername:=inis.ReadString('DB','sever','127.0.0.1');
  SDM.bkp_path:=inis.ReadString('DB','bk_path','c:\');
  SDM.bkp_max_nom:=inis.ReadInteger('DB','bk_count',5);
  SDM.bkp_last_nom:=inis.ReadInteger('DB','bk_lastnom',0);

  SDM.ipnohost:=inis.ReadString('DB','nohost','192.168.1.222');
  SDM.GostKeyDrow:=inis.ReadInteger('SETS','GOSTKEY',0);

  inis.Free;
  ls.Free;
end;

procedure TRI_Modelserver.SetConfigINI(INITEXT, LOGTYPE: OleVariant);
var
  str : string;
  ls : TStringList;
begin
  if IsOperationRite('Nyk688')<>1 Then Exit;
  if String(INITEXT)<>'' then Begin
     ls:=TStringList.Create;
     ls.Text:=String(INITEXT);
     ls.SaveToFile(SDM.serverpath+'modelserver.ini');
     ls.Free;
  end;
  if String(LOGTYPE)<>'' then Begin
     str:=String(LOGTYPE);
     if str='ALL' then LogType:=2;
     if str='NO' then LogType:=0;
     if str='DEBUG' then LogType:=3;
     if str='ERROR' then LogType:=1;
     SDM.rini.WriteString('Loging',str);
     SDM.WriteLogFile(2,'Тип логов изменен на: ', str);
  end;
  Inc(SDM.resetnom);
end;

procedure TRI_Modelserver.ResetCalcSet(CUNIT: Smallint);
var
  ss : string;
  ls : TStringList;
  inis : TMemIni;
  FF: TSearchRec;
  rr : integer;
begin
  if IsOperationRite('Nyk687')<>1 Then Exit;
  if CUNIT<0 then Begin
     SDM.CalcFlowCount:=0;
     SDM.WriteLogFile(2,'ResetCalcSet','Принудительный сброс ветвей расчетов.');
     Exit;
  end;
  if CUNIT=0 then Exit;

  ls:=TStringList.Create;
  ls.LoadFromFile(SDM.serverpath+'modelserver.ini');
  inis:=TMemIni.Create(ls.Text);
  ss:=inis.ReadString('MODUL'+IntToStr(CUNIT),'set_nam','upra.r');
  ss:=SDM.serverpath+'precalc\'+ss+'*';
  rr:=FindFirst(ss,faAnyFile,FF);
  while rr=0 do Begin
     try
     if not DeleteFile(SDM.serverpath+'precalc\'+FF.Name) then SDM.WriteLogFile(0,'ResetCalcSet','Не возможно удалить файл: '+SDM.serverpath+'precalc\'+FF.Name);
     except
       SDM.WriteLogFile(0,'ResetCalcSet','exception. Не возможно удалить файл: '+SDM.serverpath+'precalc\'+FF.Name);
     end;
     rr:=FindNext(FF);
  end;
  FindClose(FF);
  inis.Free;
  ls.Free;
end;

function TRI_Modelserver.GetVersions: OleVariant;
var
  rres : variant;
  ls : TStringList;
begin
  REsult:='';
  if useractive=0 then Exit;
  ls:=TStringList.Create;
  ls.Add(SDM.ServerVers);
  rres:=GetTehData('Nyk685',null,null);
  if VarIsNull(rres) then Begin
     SDM.WriteLogFile(0,'GetVersions','Ошибка выполнения селекта Nyk685');
     ls.Free;
     Exit;
  end;
  ls.Add(String(rres[1]));
  ls.Add(String(rres[0]));
  rres:=GetTehData('Nyk686',null,null);
  if VarIsNull(rres) then Begin
     SDM.WriteLogFile(0,'GetVersions','Ошибка выполнения селекта Nyk686');
     ls.Free;
     Exit;
  end;
  ls.Add(String(rres));
  Result:=ls.Text;
  ls.Free;
end;

function TRI_Modelserver.GetCalcSetMap(mapid, modul: Integer): OleVariant;
var
  ss,s2 : string;
  ls : TStringList;
  inis : TMemIni;
  datamass,rr : variant;
  ii,co,cc,c2 : integer;
  ttt : char;
  realvar : real;
begin
  Result:=null;
  if useractive=0 then Exit;
  if IsOperationRite('Nyk689')<>1 Then Exit;
  ls:=TStringList.Create;
  ss:='upra.par';
  if modul>1 then ss:=IntToStr(modul)+ss;
  ls.LoadFromFile(SDM.serverpath+ss);
  inis:=TMemIni.Create(ls.Text);
  co:=inis.ReadInteger('Fields','Count',1);
  datamass:=VarArrayCreate([0,3,0,co-1],varVariant);
  realvar:=0;
  for ii:=0 to co-1 do Begin
      datamass[0,ii]:=inis.ReadString('Coments',IntToStr(ii+1),'Наименование параметра');
      datamass[1,ii]:=0;
      datamass[2,ii]:=realvar;
      datamass[3,ii]:=inis.ReadString('Fields',IntToStr(ii+1),'NAME');
  end;
  if modul>1 then ss:=inis.ReadString('MODUL'+IntToStr(modul),'set_nam',IntToStr(modul)+'upra.r')
  else ss:=inis.ReadString('MODUL'+IntToStr(modul),'set_nam','upra.r');
  if FileExists(SDM.serverpath+'precalc\'+ss+IntToStr(mapid)) then Begin
     ls.LoadFromFile(SDM.serverpath+'precalc\'+ss+IntToStr(mapid));
     cc:=ls.Count;
     if cc>co then cc:=co;
     s2:=inis.ReadString('Design','break','!');
     ttt:=s2[1];
     for ii:=0 to cc-1 do Begin
         s2:=ls.Strings[ii];
         s2:=CorrectFormatStr(s2,ttt);
         rr:=AnalizeStr(s2,ttt,true);
         if not VarIsNull(rr) then Begin
           try
           c2:=VarArrayHighBound(rr,1);
           except
             c2:=-1;
           end;
           if c2>=0 then Begin
              datamass[1,ii]:=Integer(rr[0]);
              if c2>0 then Begin
               try
                 realvar:=Real(rr[1]);
                 datamass[2,ii]:=realvar;
               except
                 SDM.WriteLogFile(0,'GetCalcSetMap','Ошибка формата значения параметра '+String(datamass[4,ii])+': '+String(rr[2]));
               end;
              end;
           end;
         end;
     end;
  end;
  Result:=datamass;
  ls.Free;
  inis.Free;
end;

procedure TRI_Modelserver.PutCalcSetMap(mapid, modul: Integer; res: OleVariant);
var
  ss,s2 : string;
  ls : TStringList;
  inis : TMemIni;
  datamass,len,ext : variant;
  ii,jj,co,cc : integer;
  ttt : char;
begin
  //Function MakeFormatStr(par,len,ext : variant;br : string) : string;
  if useractive=0 then Exit;
  if IsOperationRite('Nyk690')<>1 Then Exit;
  if VarIsNull(res) then Exit;
  //datamass:=GetCalcSetMap(mapid, modul);
  cc:=VarArrayHighBound(res,2);
  ss:='upra.par';
  if modul>1 then ss:=IntToStr(modul)+ss;
  ls:=TStringList.Create;
  ls.LoadFromFile(SDM.serverpath+ss);
  SDM.WriteLogFile(4,'PutCalcSetMap','load '+SDM.serverpath+ss);
  inis:=TMemIni.Create(ls.Text);
  co:=inis.ReadInteger('Fields','Count',1);
  s2:=inis.ReadString('Design','break','!');
  ttt:=s2[1];
  if co<>cc+1 then Begin
     SDM.WriteLogFile(0,'PutCalcSetMap','Не совпала размерность массивов!');
     datamass:=GetCalcSetMap(mapid, modul);
     for ii:=0 to co-1 do
         for jj:=0 to cc do
             if res[3,jj]=datamass[3,ii] then Begin
                datamass[1,ii]:=res[1,jj];
                datamass[2,ii]:=res[2,jj];
             end;
     res:=datamass;
  end;
  len:=VarArrayCreate([0,2],VarInteger);
  ext:=VarArrayCreate([0,2],VarInteger);
  len[0]:=inis.ReadInteger('Len','STATE',3);
  len[1]:=inis.ReadInteger('Len','VALUE',12);
  len[2]:=inis.ReadInteger('Len','NAME',30);
  datamass:=VarArrayCreate([0,2],VarVariant);
  ext[0]:=0;
  ext[2]:=0;
  Ls.Clear;
  for ii:=0 to co-1 do Begin
     ext[1]:=inis.ReadInteger('Ext',IntToStr(ii),0);
     for jj:=0 to 2 do Begin
       datamass[jj]:=res[jj+1,ii];
     end;
     s2:=MakeFormatStr(datamass,len,ext,ttt);
     ls.Add(s2);
  end;
  if modul>1 then ss:=inis.ReadString('MODUL'+IntToStr(modul),'set_nam',IntToStr(modul)+'upra.r')
  else ss:=inis.ReadString('MODUL'+IntToStr(modul),'set_nam','upra.r');
  ls.SaveToFile(SDM.serverpath+'precalc\'+ss+IntToStr(mapid));
  inis.Free;
  ls.Free;
end;

function TRI_Modelserver.GetGostKey: OleVariant;
begin
  Result:=SDM.GostKeyDrow;
end;

function TRI_Modelserver.GetCalcState: OleVariant;
begin
  Result:=VarArrayOf([calcstate,ProcentCalc]);
  if SDM.debugmore Then SDM.WriteLogFile(4,'---- Статус','состояние расчета: '+IntToStr(calcstate));
  if (calcstate<2)and(calcstate<>0) then timerRetCalcstate.Enabled:=true;
end;

function TRI_Modelserver.GetLastError: OleVariant;
begin
  Result:=error_op;
end;

function TRI_Modelserver.GetSumPowerMap(mid : integer) : real;
var
  rr : real;
Begin
  rr:=1000000;
  Result:=rr;
  if useractive=0 then Exit;
  if not IBDB.Connected then Exit;
  q_sum_power.Active:=false;
  try 
  q_sum_power.ParamByName('map1').AsInteger:=mid;
  q_sum_power.ParamByName('map2').AsInteger:=mid;
  q_sum_power.Prepare;
  q_sum_power.Active:=true;
  if q_sum_power.Active then Begin
     rr:=q_sum_power.FieldByName('PSUM').AsFloat;
     q_sum_power.Next;
     rr:=rr+q_sum_power.FieldByName('PSUM').AsFloat;
     Result:=rr;
  end;
  finally
    q_sum_power.Active:=false;
  end;
end;

function TRI_Modelserver.ReadLimitStation : boolean;
var
  c_str, c_key, c_s_res  : string;
  rres,vres : variant;
  co,ii : integer;
Begin
  Result:=false;
  limitslist.islimited:=true;
  limitslist.usercount:=1;
  limitslist.powermax:=1;
  limitslist.exelstringcount:=1;
  limitslist.mapcount:=1;
  limitslist.objectsmapcount:=1;
  rres:=GetTehData('Pavel1700',null,null);
  if VarIsNull(rres) then Begin
     SDM.WriteLogFile(0,'ReadLimitStation','Ошибка выполнения селекта Pavel1700');
     Exit;
  end;
  if VarIsNull(rres[1]) then Begin
     SDM.WriteLogFile(0,'ReadLimitStation','Не заполнено поле лимитов');
     Exit;
  end;
  if VarIsNull(rres[0]) then Begin
     SDM.WriteLogFile(0,'ReadLimitStation','Не заполнено поле лицензианта');
     Exit;
  end;
  c_str:=String(rres[1]);
  c_key:=String(rres[0]);
  if c_str='' then Begin
     SDM.WriteLogFile(0,'ReadLimitStation','Пустое поле лимитов');
     Exit;
  end;
  if c_key='' then Begin
     SDM.WriteLogFile(0,'ReadLimitStation','Пустое поле лицензианта');
     Exit;
  end;
  c_s_res:=DecryptString(c_str,c_key);
  vres:=AnalizeStrClosed(c_s_res,'|',false);
  if VarIsNull(vres) then  Begin
     SDM.WriteLogFile(0,'ReadLimitStation','Кодировка отсутствует');
     Exit;
  end;
  try
    co:=VarArrayHighBound(vres,1);
  except
    SDM.WriteLogFile(0,'ReadLimitStation','Кодировка со сбоем');
    Exit;
  end;
  if co>=0 then limitslist.usercount:=Integer(vres[0]);
  if co>0 then limitslist.powermax:=Integer(vres[1]);
  if co>1 then limitslist.exelstringcount:=Integer(vres[2]);
  if co>2 then limitslist.mapcount:=Integer(vres[3]);
  if co>3 then limitslist.objectsmapcount:=Integer(vres[4]);

  if co<4 then SDM.WriteLogFile(0,'ReadLimitStation','Не все ограничения указаны. Количество='+IntToStr(co+1));

  if (limitslist.usercount=0)
     and(limitslist.powermax=0)
     and(limitslist.exelstringcount=0)
     and(limitslist.mapcount=0)
     and(limitslist.objectsmapcount=0) then limitslist.islimited:=false;

  Result:=true;
end;

initialization
  TComponentFactory.Create(ComServer, TRI_Modelserver,
    Class_RI_Modelserver, ciMultiInstance, tmApartment);
end.
