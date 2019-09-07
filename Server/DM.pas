unit DM;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, SvcMgr, Dialogs, IniFiles, Registry,
  SyncObjs, ShellApi, ExtCtrls, Tlhelp32, IBServices, Variants, BusyUnit ;

type TClientList = record
          UserId: Integer;
          UserNick: string;
          UserName: string;
          UserRole: Integer;
          UserActive: Integer;
end;

type  TMes = record         // конструкция для сообщений
         user:string;
         from:string;
         date:string;
         time:string;
          msg:string;
      end;

type
  TSDM = class(TDataModule)
    IB_BKP: TIBBackupService;
    tmr_bakup: TTimer;
    procedure DataModuleCreate(Sender: TObject);
    procedure tmr_bakupTimer(Sender: TObject);
  private
    { Private declarations }
    LogList: TStringList;                             // переменная лог файла
    CanContinueCalc : TCriticalSection;               //
    CanChangeBlockMapList : TCriticalSection;         //
    CanPostOperation : TCriticalSection;              // возможность оперировать с почтой
    dmClientList: TStringList;                        // переменная списка клиентов RDM
    BlockedLayerList : TStringList;                   //  Список заблокироавнных слоёв
    BlockedLayerListOp : TStringList;                 //  Список заблокироавнных слоёв
    mProcList : TStringList;                          // переменная таблицы процессов
    mCliLimit : char;                                 //
    systempath : string;                              // путь до системы
    procedure all_create;                             // Начальная инициализация переменных
    function LoadLogFile: Integer;                    // читает лог-файл
    function GetExeVersion(exename:string) : string;  // узнает версию файла
    //function GetServicePath(Sender: TObject): string; // возвращает путь до сервиса
    Function DeleteDir(foldername : string) : integer; // удаляет директорию
    function only_one(m:string) : boolean;             // запущен ли уже процесс
    function get_fname(m:string):string;               // выдает имя файла без точек и "\"  в пути
    function task_list : boolean;                      // таблица процессов
  public
    { Public declarations }

    ini : TInifile;                                   //
    rini : TRegistry;                                 //
    serverpath : string;                              // путь до сервиса
    dbname : string;                                  //
    dbCalcName : string;                              //
    dbusr : string;                                   //
    dbpass : string;                                  //
    dbservername : string;                            //
    ipnohost : string;                                // IP не существующий в сети
    savecalcdirmode : boolean;                        // отменяет удаление временной директории расчетов.
    resetnom : integer;                               // номер действующего ресета.
    bkp_path : string;                                // путь до backup
    MaxCalcFlow : integer;                            // максимальное число одновременных потоков вычислений
    CalcFlowCount : integer;                          // текущее число одновременных потоков вычислений
    CalcOneBase : boolean;                            // флаг сохранять расчеты в единую БД
    CalcTestLoad : boolean;                           // Флаг тестовой базы
    ServerVers : string;                              // Версия сервиса
    DBvers : string;                                  // Версия БД
    GostKeyDrow : integer;                            // Способо отображения выключателй ГОСТ или обратный
    time_close : integer;                             // Время дисконнекта в миллисекундах
    monopol : boolean;                                // Флаг монопольного режима
    debugmore : boolean;                              // Флаг расширенного логгирования
    sqlspy : string;                                  // если не пусто, код SQL за которым выставлено наблюдение
    hard_close : boolean;                             // жесткий дисконнект;
    LogType : integer;                                // тип логов (0 - NO, 1 - Error, 2 All, 3- DEBUG)

    bkp_max_nom : integer;                            // Количество бэкапов
    bkp_last_nom : integer;                           // Последний номер бэкапа  
    function SaveLogFile(isold : boolean): Integer;   // сохраняет лог-файл
    function GetUnicalString(Mno, Spread: Integer): string;
    function WriteLogFile(TypeLogMessage: Byte; LogEvent, LogMessage: string): Integer; // добавляет строку в лог
    Procedure ReadRegistryConfig;                     // читает конфигурацию из регистри
    Procedure ReadINIConfig;                          // читает конфигурацию из INI
    function GetCalcFlowAble(nknam : string) : boolean;  // Запрашивать эту функцию для получения разрешения на запуск расчёта
    procedure EndingCalcFlow;                         // Выполнить эту процедуру после завершения расчёта с любым итогом
    procedure DelTempDirs;
    function exec(d:string):boolean;                   // запуск файла
    function kill_task(ExeFileName: string): boolean;  // завершение всех ! одноименных процессов
    function GetClient(one:string): TClientList;       // единичная посылка в TClientList формате, на входе строка из списка клиентов
    function AddClientToList(UserName,  UserNick: string; UserId, UserRole, UserActive: Integer): Integer;   // добавить клиента в список клиентов
    function DeleteClientFromList(UserId: Integer): Integer;  // удаляет клиента из списка клиентов
    function BakupWorkBase(idx : integer) : boolean;
    function GetClientFromList(UserId: Int64): TClientList;  // возвращает реквизиты активного пользователя системы по его ID
    function BlockMap(idmap, usrid: Int64; sets : Shortint) : int64;  // блокирует, разблокирует и сообщает о состоянии блакировки слоя.
                                                              //sets: 0 - кто блокирует?; 1 - блокировка;
                                                              //2 - разблокировка; 3 - разблокировка всех локов пользователя;
                                                              //4 - очистка списка блокировки.
    function BlockMapOper(usrid: Int64; sets : Shortint; layers : variant) : variant;  // блокирует, разблокирует и сообщает о состоянии блакировки группы слоёв.
                                                              //sets: 0 - кто блокирует?; 1 - блокировка;
                                                              //2, 3 - разблокировка всех локов пользователя;
                                                              //4 - очистка списка блокировки.
    function IsLayerBloked(idl : integer) : boolean;
    function r_mes_sect(sect:string):string;              // читаем массив не прочитанных сообщений для пользователя.
    procedure write_message(me:TMes);                     // записываем сообщение в пул
    procedure ReadConfig;                                 // запускает процедуры чтения конфиг файлов
    procedure FreeStates;                                 // Очищает списки при остановках сервиса
    function GetUserCOuntConnect : integer;                // Возвращает число подключенных пользователей
    function GetUserList : string;                        // массив он-лайн пользователей в сети
    procedure WriteStringToConfigINI(sectt,ident,st : string);  // Запись значения в кофигурационный файл
  end;

Function StartDM(s_name : string) : boolean;

Procedure CloiseDM;

var
  SDM: TSDM;
  service_flag : boolean;  // Переменная определяет останавливать сервис или нет
  LgList: TStringList;
  srvname    : string;                              // полное имя сервера с путем

implementation

{$R *.dfm}

Procedure CloiseDM;
Begin
   if SDM <> nil then Begin
      if SDM.mProcList <> nil then Begin
         SDM.mProcList.free;
         SDM.mProcList:=nil;
      end;
      if SDM.dmClientList <> nil then Begin
         SDM.dmClientList.free;
         SDM.dmClientList:=nil;
      end;
      if SDM.LogList <> nil then Begin
         SDM.LogList.free;
         SDM.LogList:=nil;
      end;
      try
        SDM.FreeStates;
      except
      end;
      SDM.Free;
      SDM:=nil;
   end;
end;

Function StartDM(s_name : string) : boolean;
Begin
  if SDM <> nil then CloiseDM;
  Result:=true;
  try
     srvname:=s_name;
     LgList.Add('StartDM. Service Name: '+s_name);
     SDM:=TSDM.Create(Application);
  except
     Result:=false;
     LgList.Add('StartDM. Ошибка. ДМ не создан: '+s_name);
  end;
end;

function TSDM.GetUserList : string;
Begin
  Result:=dmClientList.Text;
end;

function TSDM.GetUserCOuntConnect : integer;
Begin
  Result:=dmClientList.Count;
end;

procedure TSDM.ReadConfig;
Begin
   ReadRegistryConfig;
   ReadINIConfig;
end;

procedure TSDM.FreeStates;
Begin
  BlockedLayerList.Free;
  BlockedLayerListOp.free;
  CanContinueCalc.Free;
  CanChangeBlockMapList.Free;
end;

procedure TSDM.all_create;
begin
   service_flag:=false;
   hard_close:=false;

   dbname:='';
   dbusr:='';
   dbpass:='';

   DecimalSeparator:='.';
   THOUSANDSEPARATOR:=' ';
   DateSeparator:='.';

   time_close:=0;
   CalcFlowCount:=0;
   monopol:=false;
   resetnom:=0;

   debugmore:=false;
   savecalcdirmode:=false;
   sqlspy:='';

   CanContinueCalc:=TCriticalSection.Create;
   CanChangeBlockMapList:=TCriticalSection.Create;
   BlockedLayerList:=TStringList.Create;
   BlockedLayerListOp:=TStringList.Create;

   mProcList:=TStringList.Create;
   dmClientList := TStringList.Create;
   LogList := TStringList.Create;

   try
     LoadLogFile;
   except
   end;

   ReadConfig;

   if not DirectoryExists(serverpath+'precalc\') then ForceDirectories(serverpath+'precalc\');

   mCliLimit:='|';  
end;

procedure TSDM.write_message(me:TMes);
var
  mes : TIniFile;
  sl  : TStringList;
begin
   sl:=TStringList.Create;
 try
  try
   CanPostOperation.Enter;
   mes:=TIniFile.Create(serverpath+'\message.ini');
   mes.ReadSection(me.user,sl);
   mes.WriteString(me.user,inttostr(sl.Count+1),'|'+ me.user+'|'+ me.from+ '|'+ me.date +'|'+ me.time +'|'+ me.msg +'|');
   mes.Free;
  finally
   CanPostOperation.Leave;
  end;
 except

 end;
   sl.Free;
end;

function TSDM.r_mes_sect(sect:string):string;
var
   mes: TIniFile;
   res_str: TStringList;
begin
 res_str:=TStringList.Create;
 try
  try
   CanPostOperation.Enter;
   mes:=TIniFile.Create(serverpath+'\message.ini');
   mes.ReadSectionValues(sect,res_str);
   mes.EraseSection(sect);
   mes.Free;
  finally
   CanPostOperation.Leave;
   Result:=res_str.text;
  end;
 except

 end;
   res_str.Free;
end;

function TSDM.SaveLogFile(isold : boolean): Integer;
var
  ss : string;
begin
  Result := 1;
  try
    if isold then ss:='\ServiceLog.old' Else ss:='\ServiceLog.txt';    
    LogList.SaveToFile(serverpath + ss);
  except
    Result := -1;
  end;
end;

function TSDM.LoadLogFile: Integer;
begin
  Result := 1;
  try
    LogList.Clear;
    if FileExists(serverpath + '\ServiceLog.txt') then LogList.LoadFromFile(serverpath + '\ServiceLog.txt');
    If LogList.Count>10000 Then Begin
       SaveLogFile(true);
       LogList.Clear;
       SaveLogFile(false);
    end;
  except
    Result := -1;
  end;
end;

function TSDM.GetUnicalString(Mno, Spread: Integer): string;
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
      Code := Code + DeltaCif + Copy(d,A,1) +
      Copy(d,B,1) + Copy(d,C,1) + DeltaCif;
    end;
 Result := Code;
end;

Procedure TSDM.ReadRegistryConfig;
var
  str, ss : string;
Begin
  str:='';
  // read registry variables
  rini:=TRegistry.Create();
  rini.RootKey:= HKEY_LOCAL_MACHINE;
  rini.OpenKey('SOFTWARE\RUSINTEL\RI IModel',true);
  systempath:=GetEnvironmentVariable('SystemRoot');
  LogType:=1;
  WriteLogFile(2,'Загрузка сервиса','Запись до чтения регистри... (0)');
  try
    try
      serverpath:=rini.ReadString('Server ini path');
      str:=rini.ReadString('Loging');
    finally
      WriteLogFile(2,'REGISTRY прочитано. Путь до сервиса',serverpath);
    end;
  except
     WriteLogFile(0,'Загрузка сервиса','Fly out path: '+serverpath);
  end;
  WriteLogFile(2,'Строка логов: ', str);
  if (str<>'ALL')and(str<>'NO')and(str<>'DEBUG') then Begin
       str:='ERROR';
       rini.WriteString('Loging',str);
  end;
  WriteLogFile(2,'Тип логов: ', str);
  if str='ALL' then LogType:=2;
  if str='NO' then LogType:=0;
  if str='DEBUG' then LogType:=3;

  if LogType=3 then Begin
     SaveLogFile(true);
     LogList.Clear;
     SaveLogFile(false);
     WriteLogFile(2,'Тип логов: ', str);
     WriteLogFile(2,'REGISTRY. Путь до сервиса',serverpath);
  end;
  ServerVers:=GetExeVersion(srvname);
  WriteLogFile(2,'Версия сервера', ServerVers);
  WriteLogFile(2,'REGISTRY INI path',serverpath);
  if serverpath='' then Begin
     serverpath:=ExtractFilePath(srvname);
     rini.WriteString('Model Server ini path',serverpath);
     WriteLogFile(0,'REGISTRY НЕ прочитано. Путь до сервиса',serverpath);
  end;   
end;

Procedure TSDM.ReadINIConfig;
var
  ss : string;
Begin
  ini:=TIniFile.Create(serverpath+'modelserver.ini');
  // read DB params
  dbname:=ini.ReadString('DB','path','');
  dbusr:=ini.ReadString('DB','user','');
  dbpass:=ini.ReadString('DB','psw','');
  dbCalcName:=ini.ReadString('DB','calc_path','');
  MaxCalcFlow:=StrToInt(ini.ReadString('CALC','max_flows','1'));
  if MaxCalcFlow=1 then ini.WriteString('CALC','max_flows','1');
  CalcOneBase:=false;
  ss:=ini.ReadString('CALC','one_base','0');
  if ss='1' then CalcOneBase:=true
  Else ini.WriteString('CALC','one_base','0');
  CalcTestLoad:=false;
  ss:=ini.ReadString('CALC','testload','0');
  if ss='1' then CalcTestLoad:=true
  Else ini.WriteString('CALC','testload','0');

  dbservername:=ini.ReadString('DB','server','127.0.0.1');

  ipnohost:=ini.ReadString('DB','nohost','192.168.1.222');

  bkp_path:=ini.ReadString('DB','bk_path','c:\');
  bkp_max_nom:=StrToInt(ini.ReadString('DB','bk_count','5'));
  bkp_last_nom:=StrToInt(ini.ReadString('DB','bk_lastnom','0'));

  GostKeyDrow:=StrToInt(ini.ReadString('SETS','GOSTKEY','0'));

  WriteLogFile(2,'INI прочитано.  Рабочая база данных: ',dbservername+':'+dbname);
  ini.Free;

end;

function TSDM.GetExeVersion(exename:string) : string;
var
  loc_InfoBufSize : integer;
  loc_InfoBuf     : PChar;
  loc_VerBufSize  : integer;
  loc_VerBuf      : PChar;
  FLangID         :string;
Begin
  Result:='';
  FLangID:='041904E3';
  loc_InfoBufSize := GetFileVersionInfoSize(PChar(ExeName),DWORD(loc_InfoBufSize));
  if loc_InfoBufSize > 0 then  begin
    loc_InfoBuf := AllocMem(loc_InfoBufSize);
    GetFileVersionInfo(PChar(ExeName),0,loc_InfoBufSize,loc_InfoBuf);
    VerQueryValue(loc_InfoBuf,PChar('StringFileInfo\'+FLangId+'\FileVersion'),Pointer(loc_VerBuf),DWORD(loc_VerBufSize));
    Result := String(loc_VerBuf);
    WriteLogFile(2,'GetExeVersion: ',Result);
    FreeMem(loc_InfoBuf, loc_InfoBufSize);
  end;
end;

function TSDM.WriteLogFile(TypeLogMessage: Byte; LogEvent, LogMessage: string): Integer;
var
  needsave : boolean;
begin
  Result := -1;
  if LogType=0 Then Exit;
  needsave:=false;
  try

    case TypeLogMessage of
        0 : Begin
              LogList.Add(DateToStr(Now) + ' ' + TimeToStr(Now) + ' [Error] ' + LogEvent + ' = ' + LogMessage);
              needsave:=true;
            end;
        1 : Begin
              if LogType=2 Then Begin
                 LogList.Add(DateToStr(Now) + ' ' + TimeToStr(Now) + ' [Info] ' + LogEvent + ' = ' + LogMessage);
                 needsave:=true;
              end;
            end;
        2 : Begin
              LogList.Add(DateToStr(Now) + ' ' + TimeToStr(Now) + ' [SYSTEM] ' + LogEvent + ' = ' + LogMessage);
              needsave:=true;
            end;
        3 : Begin
              LogList.Add(DateToStr(Now) + ' ' + TimeToStr(Now) + ' [Security] ' + LogEvent + ' = ' + LogMessage);
              needsave:=true;
            end;
        4 : Begin
              if (LogType=3) or (LogType=2) Then  Begin
                LogList.Add(DateToStr(Now) + ' ' + TimeToStr(Now) + ' [Debag] ' + LogEvent + ' = ' + LogMessage);
                needsave:=true;
              end;
            end;
    end;
    if needsave then
       if SaveLogFile(false) = 1 then Result := 1;
  except
    Result := -1;
  end;

end;

function TSDM.GetCalcFlowAble(nknam : string) : boolean;
// Запрашивать эту функцию для получения разрешения на запуск расчёта
Begin
  Result:=false;
  WriteLogFile(4,'GetCalcFlowAble',nknam+' Зашел. Max: '+IntToStr(MaxCalcFlow)+'  cur: '+IntToStr(CalcFlowCount));
  try
    CanContinueCalc.Enter;
    if (MaxCalcFlow>CalcFlowCount) then Begin
       Inc(CalcFlowCount);
       Result:=true;
    end;
  finally
    CanContinueCalc.Leave;
  end;
  WriteLogFile(4,'GetCalcFlowAble',nknam+' Вышел. cur: '+IntToStr(CalcFlowCount));
end;

procedure TSDM.EndingCalcFlow;
// Выполнить эту процедуру после завершения расчёта с любым итогом
Begin
  WriteLogFile(4,'EndingCalcFlow','На входе. cur: '+IntToStr(CalcFlowCount));
  try
    CanContinueCalc.Enter;
    if (CalcFlowCount>0) then Dec(CalcFlowCount);
  finally
    CanContinueCalc.Leave;
  end;
  WriteLogFile(4,'EndingCalcFlow','На выходе. cur: '+IntToStr(CalcFlowCount));
end;

Function TSDM.DeleteDir(foldername : string) : integer;
var
sh : SHFILEOPSTRUCT;
ss : string;
ii : integer;
Begin
  Result:=0;
  if foldername[length(foldername)]='\' then ss:=copy(foldername,1,length(foldername)-1)
  Else ss:=foldername;
  WriteLogFile(4,'DeleteDir', 'Enter: '+ss);
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
           WriteLogFile(1,'DeleteDir', 'Delete: '+IntToStr(ii));
           Result:=1;
        end
        Else WriteLogFile(0,'DeleteDir', 'Error Folder Delete: '+IntToStr(ii)+' folder name: '+ss);
      except
        WriteLogFile(0,'DeleteDir', 'Delete failed '+ss);
        Result:=-1;
      end;
    end;
end;

procedure TSDM.DelTempDirs;
var
  ss : string;
  FF: TSearchRec;
  rr : integer;
Begin
  // удаление временной папки
  ss:=serverpath+'*-TEMPDIR-*';
  rr:=FindFirst(ss,faDirectory,FF);
  while rr=0 do Begin
     if DeleteDir(serverpath+FF.Name)<>1 then WriteLogFile(0,'DelTempDirs','Не возможно удалить директорию: '+serverpath+FF.Name);
     rr:=FindNext(FF);
  end;
  FindClose(FF);
end;

function TSDM.exec(d:string):boolean; // sheller
 var kk,f:PChar;
     i,l2,h,inst:integer;
     zFileName, zParams, zDir: array[0..79] of Char;    // переменные для запуска файлов
begin
 if not only_one(d) then
 try
   h:=0;
   l2:=length(d);
   for i:=l2 downto 1 do
   begin
     f:=PChar(copy(d,i,1));
     if f='\' then begin h:=i; break; end;
   end;
   f:=PChar(Copy(d,1,h-1));
   kk:=PChar(copy(d,h+1,l2-h));
   inst:=shellexecute(0,'open', StrPCopy(zFileName, kk),StrPCopy(zParams, ''),StrPCopy(zDir,f), 1);
   if (inst<>0) and (inst<>ERROR_BAD_FORMAT)
                and (inst<>ERROR_FILE_NOT_FOUND)
                and (inst<>ERROR_PATH_NOT_FOUND)
   then Result:=true
   else Result:=false;
 except
   Result:=false;
 end
 else Result:=false;
end;

function TSDM.get_fname(m:string):string;
var i:integer;
begin
  i:=pos('.',m);
  if i<>0 then
      begin
        m:=copy(m,1, pos('.',m)-1);
        i:=pos('\',m);
        while i<>0 do
          begin
           m:=copy(m,pos('\',m)+1,length(m));
           i:=pos('\',m);
          end;
      end
      else
      begin
        m:=copy(m,pos('\',m)+1,length(m));
        i:=pos('\',m);
        while i<>0 do
          begin
           m:=copy(m,pos('\',m)+1,length(m));
           i:=pos('\',m);
          end;
      end;
  Result:=m;
end;

function TSDM.task_list:boolean;
var
    ContinueLoop: BOOL;
    FSnapshotHandle: THandle;
    FProcessEntry32: TProcessEntry32;
begin
  try
    mProcList.Clear;
    FSnapshotHandle := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
    FProcessEntry32.dwSize := Sizeof(FProcessEntry32);
    ContinueLoop := Process32First(FSnapshotHandle,FProcessEntry32);
    while integer(ContinueLoop) <> 0 do
    begin
      mProcList.Add( ExtractFileName(FProcessEntry32.szExeFile) );
      ContinueLoop := Process32Next(FSnapshotHandle, FProcessEntry32);
    end;
    mProcList.Sort;
    CloseHandle(FSnapshotHandle);
    Result:=true;
  except
    Result:=false;
  end;
end;


procedure TSDM.WriteStringToConfigINI(sectt,ident,st : string);
Begin
  ini:=TIniFile.Create(serverpath+'modelserver.ini');
  ini.WriteString(sectt,ident,st);
  ini.Free;
end;

procedure TSDM.tmr_bakupTimer(Sender: TObject);
var
 Hour, Min, Sec, MSec: Word;
 Year, Month, Day: Word;
 idx : integer;
begin
  tmr_bakup.Enabled:=false;
  hard_close:=false;
  DecodeTime(time,Hour,Min,Sec,MSec);
  DecodeDate(date, Year, Month, Day);
  if (Hour<21)and(Hour>6) then Begin
    tmr_bakup.Interval:=3600000;
    tmr_bakup.Enabled:=true;
    Exit;
  end;

  if bkp_max_nom<=bkp_last_nom then idx:=1 Else idx:=bkp_last_nom+1;

  if not BakupWorkBase(idx) then Begin
    WriteLogFile(0,'tmr_bakupTimer', 'Ошибка очередного резервного копирования рабочей базы #'+IntToStr(idx));
    tmr_bakup.Interval:=1200000;
    tmr_bakup.Enabled:=true;
    Exit;
  end
  Else Begin
    WriteStringToConfigINI('DB','bk_lastnom',IntToStr(idx));
  end;
  DelTempDirs;
end;

function TSDM.only_one(m:string):boolean;
var i:integer;
    pm1,pm2:string;
begin
 Result:=false;
 try
    pm1:=get_fname(m);
    task_list;
    for i:=0 to mProcList.Count-1 do
       begin
          pm2:=mProcList.Strings[i];
          pm2:=copy(pm2,1,pos('.',pm2)-1);
          if pm2=pm1 then Result:=true;
       end;
 except
    Result:=true;
 end;
end;

function TSDM.kill_task(ExeFileName: string): boolean;
const
  PROCESS_TERMINATE=$0001;
var
  ContinueLoop: BOOL;
  FSnapshotHandle: THandle;
  FProcessEntry32: TProcessEntry32;
begin
  result := false;
 try
  FSnapshotHandle := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  FProcessEntry32.dwSize := Sizeof(FProcessEntry32);
  ContinueLoop := Process32First(FSnapshotHandle,FProcessEntry32);
  while integer(ContinueLoop) <> 0 do
    begin
      if ((UpperCase(ExtractFileName(FProcessEntry32.szExeFile)) = UpperCase(ExeFileName))
      or (UpperCase(FProcessEntry32.szExeFile) = UpperCase(ExeFileName))) then
         Result := TerminateProcess(OpenProcess(PROCESS_TERMINATE, BOOL(0),FProcessEntry32.th32ProcessID), 0) ;
      ContinueLoop := Process32Next(FSnapshotHandle,FProcessEntry32);
    end;
  CloseHandle(FSnapshotHandle);
 except
   //
 end;
end;

function TSDM.AddClientToList(UserName,  UserNick: string; UserId, UserRole, UserActive: Integer): Integer;
var I: Integer;
begin
  Result := 1;
  try
    for I := 0 to dmClientList.Count - 1 do
      begin
        if GetClient(dmClientList.Strings[I]).UserId = UserId then Begin
           Result:=0;
           Exit;
        end;
      end;
    dmClientList.Add('|'+ IntToStr(UserId) +'|'+ UserNick+ '|'+ UserName +'|'+ IntToStr(UserRole) +'|'+ IntToStr(UserActive) +'|');
    tmr_bakup.Enabled:=false;
  except
    Result := -1;
  end;
end;

procedure TSDM.DataModuleCreate(Sender: TObject);
begin
  LgList.Add('DataModuleCreate. Enter');
  all_create;
end;

function TSDM.DeleteClientFromList(UserId: Integer): Integer;
var I: Integer;
begin
  Result := 1;
  try
    for I := 0 to dmClientList.Count - 1 do
      begin
        if GetClient(dmClientList.Strings[I]).UserId = UserId then dmClientList.Delete(I);
      end;
      if dmClientList.Count=0 then Begin
         tmr_bakup.Interval:=10800000;
         tmr_bakup.Enabled:=true;
         if CalcFlowCount<>0 then Begin
            WriteLogFile(0,'DeleteClientFromList', 'Осталась не завершенной сессия расчетов: '+IntToStr(CalcFlowCount));
            CalcFlowCount:=0;
         end;
         monopol:=false;
         if hard_close then Begin
            WriteLogFile(2,'Остановка сервиса','Поступила команда остановить сервис. Начало остановки сервиса.');
            service_flag:=true;
         end;
      end;
  except
    Result := -1;
  end;
end;

function TSDM.BakupWorkBase(idx:integer) : boolean;
var
  er : string;
  ss : string;
Begin
  Result:=false;
  if hard_close then Begin
     WriteLogFile(0,'BakupWorkBase','Сервис подготовлен к остановке. Бэкап не возможен.');
     Exit;
  end;
  IB_BKP.ServerName:=dbservername;

  ss:='user_name='+dbusr;
  IB_BKP.Params.Add(ss);
  ss:='password='+dbpass;
  IB_BKP.Params.Add(ss);

  IB_BKP.BackupFile.Clear;
  IB_BKP.BackupFile.Add(bkp_path+IntToStr(idx)+'iModel.bkp');
  IB_BKP.DatabaseName:=dbname;
  try
    try
      monopol:=true;
      IB_BKP.Active:=true;
      IB_BKP.ServiceStart;
      while not IB_BKP.IsServiceRunning do DoBusy(ipnohost);
      WriteLogFile(4,'BakupWorkBase', 'Очередное резервное копирование рабочей базы #'+IntToStr(idx));
      Result:=true;
    finally
      monopol:=false;
    end;
  except
    on E: Exception do Begin
       er:=E.Message;
       WriteLogFile(0,'BakupWorkBase','Ошибка исполнения: '+er);
    end;
  end;
end;

function TSDM.GetClient(one:string): TClientList;
var k,g,st:integer;
    po:integer;
    s,s2:string;
    relt:TClientList;
begin
 s:='';
 po:=pos('=', one);
 g:=length(one);
 one:=copy(one,po+1,g);
 g:=length(one);
 st:=0;
 for k:=1 to g do
 begin
   s2:=copy(one,k,1);
   if s2='|' then
   begin
     inc(st);
     case st of
         2 : relt.UserId := StrToInt(s);
         3 : relt.UserNick:=s;
         4 : relt.UserName:=s;
         5 : relt.UserRole := StrToInt(s);
         6 : relt.UserActive := StrToInt(s);
     end;
     s:='';
    end
    else s:=s+copy(one,k,1);
  end;
  Result:=relt;
end;

function TSDM.GetClientFromList(UserId: Int64): TClientList;
var
 I: Integer;
 tkl : TClientList;
begin
  Result.UserId:=0;
  try
    for I := 0 to dmClientList.Count - 1 do
      begin
        tkl:=GetClient(dmClientList.Strings[I]);
        if tkl.UserId = UserId then Begin
           Result:=tkl;
           Break;
        end;
      end;
  except

  end;
end;

function TSDM.BlockMap(idmap, usrid: Int64; sets : Shortint) : int64; // CanChangeBlockMapList   BlockedLayerList
var
ii, i : integer;
s1,s2 : string;
rr : int64;
Begin
  Result:=-1;
  case sets of
    0 : Begin  //  test
          ii:=BlockedLayerList.IndexOfName(IntToStr(idmap));
          if ii>-1 then Result:=StrToInt(BlockedLayerList.ValueFromIndex[ii])
          Else Begin
            ii:=BlockedLayerListOp.IndexOfName(IntToStr(idmap));
            if ii>-1 then Result:=StrToInt(BlockedLayerListOp.ValueFromIndex[ii]);
          end;
        end;
    1 : Begin  //  lock
          CanChangeBlockMapList.Enter;
          ii:=BlockMap(idmap, usrid,0);
          If ii>0 then
            if ii<>usrid Then Begin
               Result:=ii;
               CanChangeBlockMapList.Leave;
               Exit;
             end
             Else Begin
               Result:=0;
               CanChangeBlockMapList.Leave;
               Exit;
             end;
          BlockedLayerList.Add(IntToStr(idmap)+'='+IntToStr(usrid));
          CanChangeBlockMapList.Leave;
          Result:=0;
        end;
    2 : Begin  //  unlock
          ii:=BlockMap(idmap, usrid,0);
          if ii=usrid then Begin
             CanChangeBlockMapList.Enter;
             ii:=BlockedLayerList.IndexOfName(IntToStr(idmap));
             BlockedLayerList.Delete(ii);
             CanChangeBlockMapList.Leave;
             Result:=0;
          end;
         end;
     3 : Begin  //  clear usr
          for i := 0 to BlockedLayerList.Count - 1 do Begin
              WriteLogFile(4,'BlockMap', 'co='+IntToStr(BlockedLayerList.Count));
              s1:=BlockedLayerList.ValueFromIndex[i];
              s2:=IntToStr(usrid);
              WriteLogFile(4,'BlockMap', 'i='+IntToStr(i)+' user='+s2+' Значение строки списка='+s1);
              if s1=s2 Then Begin
                 WriteLogFile(4,'BlockMap', 'Unlock all locks user map='+BlockedLayerList.Names[i]+' user='+IntToStr(usrid));
                 rr:=BlockMap(StrToInt(BlockedLayerList.Names[i]), usrid,2);
                 if rr=0 then BlockMap(idmap, usrid,3);
                 Exit;
              end;
           end;
           Result:=0;
          end;
     4 : Begin  //  clear all
           CanChangeBlockMapList.Enter;
           BlockedLayerList.Clear;
           Result:=0;
           CanChangeBlockMapList.Leave;
         end;
  end;
end;

function TSDM.IsLayerBloked(idl : integer) : boolean;
var
  idx : integer;
Begin
  result:=false;
  idx:=BlockedLayerList.IndexOfName(IntToStr(idl));
  if idx>-1 then Result:=true;
  idx:=BlockedLayerListOp.IndexOfName(IntToStr(idl));
  if idx>-1 then Result:=true;
end;

function TSDM.BlockMapOper(usrid: Int64; sets : Shortint; layers : variant) : variant;
var
  co,idx,ii,nom : integer;
  Lbloklist : TStringList;
  vvl : variant;
  ss : string;
Begin
  Result:=Null;
  WriteLogFile(4,'BlockMapOper','Вошли! S='+IntToStr(sets));
  co:=0;
  if not VarIsNull(layers) then
     try
       co:=VarArrayHighBound(layers,1);
     except
       co:=-1;
       Result:=-1;
       WriteLogFile(0,'BlockMapOper','layers не является массивом');
       Exit;
     end;
  Lbloklist:=TStringList.Create;
 // WriteLogFile(4,'BlockMapOper','----- 1 userID='+IntToStr(usrid));
  case sets of
     0 : Begin
           for ii:=0 to co do Begin
               idx:=BlockedLayerList.IndexOfName(String(layers[ii]));
               if (idx>-1)and (StrToInt(BlockedLayerList.ValueFromIndex[idx])<>usrid) then
                  Lbloklist.Add(BlockedLayerList.Strings[idx])
               Else Begin
                  idx:=BlockedLayerListOp.IndexOfName(String(layers[ii]));
                  if (idx>-1)and(StrToInt(BlockedLayerListOp.ValueFromIndex[idx])<>usrid) then
                      Lbloklist.Add(BlockedLayerListOp.Strings[idx]);
               end;
           end;
           if Lbloklist.Count>0 then Begin
             Result:=VarArrayCreate([0, Lbloklist.Count-1], varVariant);
             for ii:=0 to Lbloklist.Count - 1 do
                 Result[ii]:=VarArrayOf([StrToInt(Lbloklist.Names[ii]),StrToInt(Lbloklist.ValueFromIndex[ii])]);
           end;
  //         WriteLogFile(4,'BlockMapOper','----- S-0--');
         end;
     1 : Begin
           CanChangeBlockMapList.Enter;
           try
           vvl:=BlockMapOper(usrid,0,layers);
           if VarIsNull(vvl) then Begin
              for ii:=0 to co do Begin
                  if not IsLayerBloked(Integer(layers[ii])) then
                     BlockedLayerListOp.Add(IntToStr(layers[ii])+'='+IntToStr(usrid));
              end;
           end
           Else Result:=vvl;
           finally
             CanChangeBlockMapList.Leave;
           end;
 //          WriteLogFile(4,'BlockMapOper','----- S-1--');
         end;
     2 : Begin
           CanChangeBlockMapList.Enter;
           try
           for ii:=0 to co do Begin
               ss:=BlockedLayerListOp.Values[String(layers[ii])];
               if ss='' then Begin
                 WriteLogFile(0,'BlockMapOper','Потеряный слой в блокировке без пользователя: '+String(layers[ii]));
                 nom:=BlockedLayerListOp.IndexOfName(String(layers[ii]));
                 if nom>=0 then BlockedLayerListOp.Delete(nom);
               end
               Else Begin
                 idx:=StrToInt(ss);
                 if idx=usrid then Begin
                    nom:=BlockedLayerListOp.IndexOfName(String(layers[ii]));
                    BlockedLayerListOp.Delete(nom);
                 end;
               end;
           end;
           finally
            CanChangeBlockMapList.Leave;
           end;
 //          WriteLogFile(4,'BlockMapOper','----- S-2--');
         end;
     3 : Begin
           CanChangeBlockMapList.Enter;
           try
             for ii:=0 to BlockedLayerListOp.Count - 1 do
                 if BlockedLayerListOp.ValueFromIndex[ii]=IntToStr(usrid) then
                    Lbloklist.Add(BlockedLayerListOp.Names[ii]);
             for ii := 0 to Lbloklist.Count - 1 do
                 BlockedLayerListOp.Delete(BlockedLayerListOp.IndexOfName(Lbloklist.Strings[ii]));
           finally
             CanChangeBlockMapList.Leave;
           end;
  //         WriteLogFile(4,'BlockMapOper','----- S-3--');
         end;
     4 : Begin
           CanChangeBlockMapList.Enter;
           try
             BlockedLayerListOp.Clear;
           finally
             CanChangeBlockMapList.Leave;
           end;
  //         WriteLogFile(4,'BlockMapOper','----- S-4--');
         end;
  end;
  Lbloklist.Free;
//  WriteLogFile(4,'BlockMapOper','----- end--');
end;

end.
